`include "asim/provides/plb_master.bsh"
`include "asim/provides/plb_slave.bsh"
`include "asim/provides/plb_common.bsh"
`include "asim/provides/plb_device_debug.bsh"
`include "asim/provides/register_library.bsh"
`include "asim/provides/librl_bsv_base.bsh"
`include "asim/provides/soft_connections.bsh"

`include "asim/rrr/server_stub_PLBTESTRRR.bsh"

import Vector::*;
import Connectable::*;
import ClientServer::*;
import GetPut::*;
import FIFO::*;
import FIFOF::*;

typedef enum{
  Idle,
  Running, 
  Inputing,
  Outputing
} TesterState deriving (Bits,Eq);

module [CONNECTED_MODULE]  mkPLBDevice#(Clock plbClock, Reset plbReset) (PLB_DEVICE);
  
  Clock clock <- exposeCurrentClock;
  Reset reset <- exposeCurrentReset;

  PLBMaster plbMaster <- mkPLBMaster(clock, reset, clocked_by plbClock, reset_by plbReset);
  PLBSlave#(32,64) plbSlave <- mkPLBSlave(clock, reset, clocked_by plbClock, reset_by plbReset);

  // Setup Debug RRR

  ServerStub_PLBTESTRRR server_stub <- mkServerStub_PLBTESTRRR();  

  mkConnectPLBDebugger(plbMaster.plbMasterDebug, plbSlave.plbSlaveDebug); 

  // Wire up PLB Slave
  // There are other solutions, but it seems simplest to emulate the byte 
  // enable code here, even though the CBusBE stuff exists  
  
  RegBE#(BusWord,8) hostCommand1 <- mkRegBE(0);
  RegBE#(BusWord,8) hostCommand2 <- mkRegBE(1);
  RegBE#(BusWord,8) hostCommand3 <- mkRegBE(0);


  rule handleDataCheck;
    let nullResp <- server_stub.acceptRequest_getTestStatus();
    server_stub.sendResponse_getTestStatus(truncate(hostCommand3.read));
  endrule

  rule handleSlave;
    let req <- plbSlave.busClient.request.get();
    PLBBusWordAddress wordAddr = truncateLSB(req.addr);
 
     // We care only about the bottom 4 bits of words
    Bit#(4) regAddr = truncate(wordAddr); 
   
    if(req.command == PLBWrite) 
      begin
        case (regAddr)
          0: begin
               hostCommand1.write(req.data,req.be);
             end
          1: begin
               hostCommand2.write(req.data,req.be);
             end
          2: begin
               hostCommand3.write(req.data,req.be);
             end

        endcase
      end
    else
      begin
        case (regAddr)
          0: begin
               plbSlave.busClient.response.put(hostCommand1.read());
             end
          1: begin
               plbSlave.busClient.response.put(hostCommand2.read());
             end
           default: begin
               //Default to prevent deadlocks   
               plbSlave.busClient.response.put(zeroExtend({wordAddr,3'b000}));     
             end
        endcase
      end
  endrule


  
  // Old master tester code...
  Reg#(TesterState) state <- mkReg(Idle);
  Reg#(Bit#(32)) baseRegLoad <- mkReg(0);
  Reg#(Bit#(32)) baseRegStore <- mkReg(0);
  Reg#(Bit#(16)) commandCount <- mkReg(0);
  Reg#(Bit#(32)) commandsComplete <- mkReg(1);
  Reg#(Bit#(16)) rxCount <- mkReg(0);
  Reg#(Bit#(16)) txCount <- mkReg(0);

  Bit#(5) size = truncate(hostCommand2.read);

  FIFO#(BusWord) dataFIFO <- mkSizedFIFO(32);
  Reg#(Bool) evenZero <- mkReg(True);

  rule handleEndCheck;
    let nullResp <- server_stub.acceptRequest_getTestReceived();
    server_stub.sendResponse_getTestReceived({txCount,rxCount});
  endrule
 
  rule grabInstruction(state == Idle && hostCommand1.read != 0);
    // Throw an RRR in here at some point....
    baseRegLoad <= 0; // BRAM is at 0
    baseRegStore <= 0;
    state <= Running;
  endrule  
  
  rule issueCommand(state == Running);
    if(commandCount + 1 == truncate(hostCommand2.read[63:32]))
      begin
        commandCount <= 0;
        hostCommand1.write(0,~0); 
        state <= Idle;
        commandsComplete <= commandsComplete + 1;
      end
    else
      begin
        commandCount <= commandCount + 1;
      end
    
    if(commandCount[0] == 0)
      begin
        baseRegLoad <= baseRegLoad + zeroExtend(size) * 8; 
        plbMaster.burstIfc.burstReq(tagged ReadReq BURST_COMMAND{size:size,addr:zeroExtend(baseRegLoad)});         
      end
    else
      begin
        baseRegStore <= baseRegStore + zeroExtend(size) * 8; 
        plbMaster.burstIfc.burstReq(tagged WriteReq BURST_COMMAND{size:size,addr:zeroExtend(baseRegStore)});         
      end
  endrule
  
  rule inputing;
     BusWord data <- plbMaster.burstIfc.readRsp();
     rxCount <= rxCount + 1;
     dataFIFO.enq(data);
  endrule 

  rule outputing;
    plbMaster.burstIfc.writeData(unpack((~(pack(dataFIFO.first))) & (~1)));
     txCount <= txCount + 1;
    dataFIFO.deq;
  endrule

  method Bit#(1) outIP2Bus_IntrEvent();
    return 0;
  endmethod

  interface plbMasterWires = plbMaster.plbMasterWires;
  interface plbSlaveWires = plbSlave.plbSlaveWires;

endmodule
