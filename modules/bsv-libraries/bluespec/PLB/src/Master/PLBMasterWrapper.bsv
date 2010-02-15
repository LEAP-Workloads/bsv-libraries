`include "asim/provides/plb_master.bsh"
`include "asim/provides/plb_slave.bsh"
`include "asim/provides/plb_common.bsh"
`include "asim/provides/librl_bsv_base.bsh"



// This module generalizes the PLB Master to handle arbitrary burst length.
// It also converts from word address to bus address.  This is probably too 
// much work for this module, but I'm feeling lazy.  I'll probably fix it 
// at some point.

module  mkPLBMasterWrapper#(PLBMaster plbMaster) (BURST_MEMORY_IFC#(PLBBusWordAddress,BusWord,max_burst_size))
  provisos(
             Add#(extraLengthBits, TAdd#(1,TLog#(PLBMaxBurst)), TAdd#(1, TLog#(max_burst_size))),
             Add#(extraAddrBits, TAdd#(1, TLog#(max_burst_size)), SizeOf#(PLBBusWordAddress))
          );
    Reg#(Bool) handlingRead <- mkReg(True);
    Reg#(Bit#(TAdd#(1,TLog#(max_burst_size)))) wordsRemaining <- mkReg(0);
    Reg#(Bit#(TAdd#(1,TLog#(max_burst_size)))) outstandingReqs <- mkReg(0);
    Reg#(PLBBusWordAddress) address <- mkReg(0);

    Reg#(Bit#(32)) readsReturnedCount <- mkReg(0);
    Reg#(Bit#(32)) writesReturnedCount <- mkReg(0);
    Reg#(Bit#(32)) writeCommandsReceivedCount <- mkReg(0);
    Reg#(Bit#(32)) readCommandsReceivedCount <- mkReg(0);


    let plbMaxBurst = fromInteger(valueof(PLBMaxBurst));

    // We have to check for aligned accesses here...

    rule handleRead(handlingRead && wordsRemaining > 0 && outstandingReqs == 0);
      if(wordsRemaining >= plbMaxBurst) 
        begin
          plbMaster.burstIfc.burstReq(tagged ReadReq BURST_COMMAND{addr: {address,0}, size: plbMaxBurst});
          address <= address + plbMaxBurst;
          wordsRemaining <= wordsRemaining - plbMaxBurst;
          outstandingReqs <= plbMaxBurst; 
        end    
      else 
        begin
          plbMaster.burstIfc.burstReq(tagged ReadReq BURST_COMMAND{addr: {address,0}, size: truncate(wordsRemaining)});
          address <= address + zeroExtend(wordsRemaining);
          wordsRemaining <= 0;
          outstandingReqs <= wordsRemaining; 
        end    
    endrule

    rule handleWrite(!handlingRead && wordsRemaining > 0);
      if(wordsRemaining >= plbMaxBurst)
        begin
          plbMaster.burstIfc.burstReq(tagged WriteReq BURST_COMMAND{addr: {address,0}, size: plbMaxBurst});
          address <= address + plbMaxBurst;
          wordsRemaining <= wordsRemaining - plbMaxBurst;
        end
      else 
        begin
          plbMaster.burstIfc.burstReq(tagged WriteReq BURST_COMMAND{addr: {address,0}, size: truncate(wordsRemaining)});
          address <= address + zeroExtend(wordsRemaining);
          wordsRemaining <= 0;
        end    
    endrule


    method Action burstReq(BURST_REQUEST#(PLBBusWordAddress,max_burst_size) req) if(wordsRemaining == 0); 
      case (req) matches 
        tagged ReadReq .command: begin       
          wordsRemaining <= command.size;
          address <= command.addr;
          handlingRead <= True;
          readCommandsReceivedCount <= readCommandsReceivedCount + 1;
        end
        tagged WriteReq .command: begin       
          wordsRemaining <= command.size;
          address <= command.addr;
          handlingRead <= False;
          writeCommandsReceivedCount <= writeCommandsReceivedCount + 1;
        end
      endcase
    endmethod

    method ActionValue#(BusWord) readRsp();
      let data <- plbMaster.burstIfc.readRsp();
      outstandingReqs <= outstandingReqs - 1;
      readsReturnedCount <= readsReturnedCount + 1;
      return data;
    endmethod

    // Look at the read response value without popping it
    method peek = plbMaster.burstIfc.peek;
 
    // Read response ready
    method notEmpty = plbMaster.burstIfc.notEmpty;

    // Read request possible?
    method notFull = plbMaster.burstIfc.notFull;

    // We must split the write request and response...
    method Action writeData(BusWord data);
      plbMaster.burstIfc.writeData(data); 
      writesReturnedCount <= writesReturnedCount + 1;
    endmethod

    // Write request possible?
    method writeNotFull = plbMaster.burstIfc.writeNotFull;


  //method readsReturned = readsReturnedCount._read;
  //method writesReceived = writesReturnedCount._read;
  //method writeCommandsReceived = writeCommandsReceivedCount._read;
  //method readCommandsReceived = readCommandsReceivedCount._read;

endmodule