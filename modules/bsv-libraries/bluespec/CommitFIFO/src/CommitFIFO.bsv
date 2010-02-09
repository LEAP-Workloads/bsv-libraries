import RegFile::*;
import GetPut::*;

function Get#(fifo_type) commitFifoToGet( CommitFIFO#(fifo_type,size) fifo);
  Get#(fifo_type) f = interface Get#(fifo_type);
                        method ActionValue#(fifo_type) get();
                          fifo.deq;
                          return fifo.first;
                        endmethod
                      endinterface;
  return f; 
endfunction

function Put#(fifo_type) commitFifoToPut( CommitFIFO#(fifo_type,size) fifo);
  Put#(fifo_type) f = interface Put#(fifo_type);
                        method Action put(fifo_type data);
                          fifo.enq(data);
                        endmethod
                      endinterface; 
  return f;
endfunction


// This fifo allows the partial commit of values.  Values are not seen at the output until commit is called.
// Yet another variant on the ever popular ring buffer.


interface CommitFIFO#(type data, numeric type size);
  method data first();
  method Action commit();  
  method Action abort();  
  method Action deq();
  method Action enq(data inData);
  method Bool notFull;
  method Bool notEmpty;
endinterface


module mkCommitFIFO (CommitFIFO#(data,size))
   provisos(
     Add#(1,TLog#(size), indexSz),
     Bits#(data, dataSz)
   );

  RegFile#(Bit#(indexSz),data) memory <- mkRegFile(0,fromInteger(valueof(size))); 

  Reg#(Bit#(indexSz)) firstPtr      <- mkReg(0);
  Reg#(Bit#(indexSz)) commitPtr     <- mkReg(0);
  Reg#(Bit#(indexSz)) enqPtr        <- mkReg(0);
  Reg#(Bit#(indexSz)) dataCounter   <- mkReg(0);
  Reg#(Bit#(indexSz)) commitCounter <- mkReg(0);
  PulseWire           countUp       <- mkPulseWire;
  PulseWire           countDown     <- mkPulseWire;
  PulseWire           commitPulse   <- mkPulseWire;
  PulseWire           abortPulse    <- mkPulseWire;

  rule toggle;
    // adjust data counter
    if(countDown && !commitPulse) // don't care about count up, unless we also commit.
      begin
        dataCounter <= dataCounter - 1;
      end  
    else if(!countDown && commitPulse && !countUp)
      begin
        dataCounter <= dataCounter + commitCounter;
      end 
    else if(!countDown && commitPulse && countUp)
      begin
        dataCounter <= dataCounter + commitCounter + 1;
      end 
    else if(countDown && commitPulse && !countUp)
      begin
        dataCounter <= dataCounter + commitCounter - 1;
      end 
    else if(countDown && commitPulse && countUp)
      begin
        dataCounter <= dataCounter + commitCounter;
      end 

    if(commitPulse)
      begin
        commitCounter <= 0;
      end
    else if(abortPulse)
      begin
        commitCounter <= 0;
      end
    else if(!commitPulse && countUp)
      begin
        commitCounter <= commitCounter + 1;
      end

    if(commitPulse && countUp)
      begin
        enqPtr <= (enqPtr + 1 == fromInteger(valueof(size)))?0:enqPtr+1;  
      end
    else if(abortPulse)
      begin
        enqPtr <= commitPtr;
      end
    else if(countUp)
      begin
        enqPtr <= (enqPtr + 1 == fromInteger(valueof(size)))?0:enqPtr+1;  
      end
   
    if(commitPulse && countUp)
      begin
        commitPtr <= (enqPtr + 1 == fromInteger(valueof(size)))?0:enqPtr+1; 
      end
    else if(commitPulse && !countUp)
      begin
        commitPtr <= enqPtr;
      end

  endrule

  method data first() if(dataCounter > 0);
    return memory.sub(firstPtr);
  endmethod

  method Action commit();  
    commitPulse.send;
  endmethod

  method Action abort();  
    abortPulse.send;
  endmethod

  method Action deq() if(dataCounter > 0);
    firstPtr <= (firstPtr + 1 == fromInteger(valueof(size)))?0:firstPtr+1;
    countDown.send;
  endmethod

  // issue here is what happens when we also commit... 
  // commit should probably happen last.  if only we could specifiy...
  method Action enq(data inData) if(dataCounter + commitCounter < fromInteger(valueof(size)));
    countUp.send;
    memory.upd(enqPtr,inData);  
  endmethod


  method Bool notFull;
   return dataCounter + commitCounter < fromInteger(valueof(size));
  endmethod

  method Bool notEmpty;
    return dataCounter > 0;
  endmethod
endmodule