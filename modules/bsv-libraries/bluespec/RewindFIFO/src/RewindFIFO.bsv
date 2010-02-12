import RegFile::*;
import GetPut::*;

function Get#(fifo_type) rewindFifoToGet( RewindFIFO#(fifo_type,size) fifo);
  Get#(fifo_type) f = interface Get#(fifo_type);
                        method ActionValue#(fifo_type) get();
                          fifo.deq;
                          return fifo.first;
                        endmethod
                      endinterface;
  return f; 
endfunction

function Put#(fifo_type) rewindFifoToPut( RewindFIFO#(fifo_type,size) fifo);
  Put#(fifo_type) f = interface Put#(fifo_type);
                        method Action put(fifo_type data);
                          fifo.enq(data);
                        endmethod
                      endinterface; 
  return f;
endfunction


// This fifo allows the partial commit of values.  Values are not seen at the output until commit is called.
// Yet another variant on the ever popular ring buffer.

interface RewindFIFO#(type data, numeric type size);
  method data first();
  method Action commit();  
  method Action rewind();  
  method Action deq();
  method Action enq(data inData);
  method Bool notFull;
  method Bool notEmpty;
endinterface

interface RewindFIFOLevel#(type data, numeric type size);
  method data first();
  method Action commit();  
  method Action rewind();  
  method Action deq();
  method Action enq(data inData);
  method Bool notFull;
  method Bool notEmpty;
  method Bool isLessThan   ( Bit#(TAdd#(1,TLog#(size))) c1 ) ;
  method Bool isGreaterThan( Bit#(TAdd#(1,TLog#(size))) c1 ) ;
endinterface

module mkRewindFIFOLevel (RewindFIFOLevel#(data,size))
   provisos(
     Bits#(data, dataSz)
   );


  RegFile#(Bit#(TAdd#(1,TLog#(size))),data) memory <- mkRegFile(0,fromInteger(valueof(size))); 

  Reg#(Bit#(TAdd#(1,TLog#(size)))) firstPtr      <- mkReg(0);
  Reg#(Bit#(TAdd#(1,TLog#(size)))) rewindPtr     <- mkReg(0);
  Reg#(Bit#(TAdd#(1,TLog#(size)))) enqPtr        <- mkReg(0);
  Reg#(Bit#(TAdd#(1,TLog#(size)))) dataCounter   <- mkReg(0);
  Reg#(Bit#(TAdd#(1,TLog#(size)))) rewindCounter <- mkReg(0);
  PulseWire           countUp       <- mkPulseWire;
  PulseWire           countDown     <- mkPulseWire;
  PulseWire           commitPulse   <- mkPulseWire;
  PulseWire           rewindPulse    <- mkPulseWire;

  rule toggle;
    // probably has to change completely
    if(countUp && !commitPulse) // don't care about count up, unless we also commit.
      begin
        dataCounter <= dataCounter + 1;
      end  
    else if(!countDown && commitPulse && !countUp)
      begin
        dataCounter <= dataCounter - rewindCounter;
      end 
    else if(!countDown && commitPulse && countUp)
      begin
        dataCounter <= dataCounter - rewindCounter + 1;
      end 
    else if(countDown && commitPulse && !countUp)
      begin
        dataCounter <= dataCounter - rewindCounter - 1;
      end 
    else if(countDown && commitPulse && countUp)
      begin
        dataCounter <= dataCounter - rewindCounter;
      end 

    if(commitPulse)
      begin
        rewindCounter <= 0;
      end
    else if(rewindPulse)
      begin
        rewindCounter <= 0;
      end
    else if(countDown)
      begin
        rewindCounter <= rewindCounter + 1;
      end

    // Enq Ptr just counts up
    if(countUp)
      begin
        enqPtr <= (enqPtr + 1 == fromInteger(valueof(size)))?0:enqPtr+1;  
      end


    // Rewind Pointer    
    if(commitPulse && countDown)
      begin
        rewindPtr <= (firstPtr + 1 == fromInteger(valueof(size)))?0:firstPtr+1; 
      end
    else if(commitPulse && !countDown)
      begin
        rewindPtr <= firstPtr;
      end
    

    // Handle first pointer, which may be rewound 
    if(commitPulse)
      begin
        if(countDown)
          begin
            firstPtr <= (firstPtr + 1 == fromInteger(valueof(size)))?0:firstPtr+1;
          end
      end
    else if(rewindPulse)
      begin
        firstPtr <= rewindPtr;
      end
    else if(countDown)
      begin
        firstPtr <= (firstPtr + 1 == fromInteger(valueof(size)))?0:firstPtr+1;
      end

    $display("RwFIFO: firstPtr: %h, rwPtr: %h, enqPtr: %h, rwCnt: %h, dataCnt: %h", firstPtr, rewindPtr, enqPtr, rewindCounter, dataCounter);

    // some simple checks
   if((enqPtr > rewindPtr) && (enqPtr - rewindPtr != dataCounter))
      begin
        $display("Data being dropped >, enqPtr - rewindPtr != dataCounter");
        $finish;
      end 

   if(enqPtr == rewindPtr && !(dataCounter == 0 || dataCounter == fromInteger(valueof(size))))
     begin
        $display("Data being dropped=, enqPtr - rewindPtr != dataCounter");
        $finish;
     end

   if(enqPtr < rewindPtr && !(dataCounter == enqPtr + fromInteger(valueof(size)) - rewindPtr))
     begin
        $display("Data being dropped<, enqPtr - rewindPtr != dataCounter");
        $finish;
     end

   // Same assertions about rw and first

   if((firstPtr > rewindPtr) && (firstPtr - rewindPtr != rewindCounter))
      begin
        $display("Data being dropped >, firstPtr - rewindPtr != rewindCounter");
        $finish;
      end 

   if(firstPtr == rewindPtr && !(rewindCounter == 0 || rewindCounter == fromInteger(valueof(size))))
     begin
        $display("Data being dropped=, firstPtr - rewindPtr != rewindCounter");
        $finish;
     end

   if(firstPtr < rewindPtr && !(rewindCounter == firstPtr + fromInteger(valueof(size)) - rewindPtr))
     begin
        $display("Data being dropped<, firstPtr - rewindPtr != rewindCounter");
        $finish;
     end

  endrule

  method data first() if(dataCounter > rewindCounter);
    return memory.sub(firstPtr);
  endmethod

  method Action commit();  
    commitPulse.send;
  endmethod

  method Action rewind();  
    rewindPulse.send;
  endmethod

  method Action deq() if(dataCounter > rewindCounter);
    countDown.send;
  endmethod

  // issue here is what happens when we also commit... 
  // commit should probably happen last.  if only we could specifiy...
  method Action enq(data inData) if(dataCounter < fromInteger(valueof(size)));
    if(enqPtr == rewindPtr && dataCounter != 0)
      begin
        $display("Overwriting data");
        $finish;
      end
    countUp.send;
    memory.upd(enqPtr,inData);  
  endmethod


  method Bool notFull;
   return dataCounter < fromInteger(valueof(size));
  endmethod

  method Bool notEmpty;
    return dataCounter > rewindCounter;
  endmethod

  method Bool isLessThan   ( Bit#(TAdd#(1,TLog#(size))) c1 );
    return ( dataCounter - rewindCounter  < c1 );
  endmethod

  method Bool isGreaterThan( Bit#(TAdd#(1,TLog#(size))) c1 );
   return ( dataCounter - rewindCounter  > c1 );   
  endmethod
endmodule