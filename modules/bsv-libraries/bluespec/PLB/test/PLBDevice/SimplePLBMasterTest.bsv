`include "asim/provides/plb_master.bsh"
`include "asim/provides/plb_slave.bsh"
`include "asim/provides/plb_common.bsh"
`include "asim/provides/register_library.bsh"
`include "asim/provides/librl_bsv_base.bsh"
`include "asim/provides/soft_connections.bsh"

`include "asim/rrr/remote_server_stub_PLBDEBUGRRR.bsh"

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

  ServerStub_PLBDEBUGRRR server_stub <- mkServerStub_PLBDEBUGRRR();  

  mkConnectPLBDebugger(server_stub, plbMaster, plbSlave); 

  RegBE#(BusWord,8) hostCommand1 <- mkRegBE(0);
  RegBE#(BusWord,8) hostCommand2 <- mkRegBE(0);

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
               plbSlave.busClient.response.put(zeroExtend(req.addr));     
             end
        endcase
      end
  endrule


  
  // Old master tester code...
  Reg#(TesterState) state <- mkReg(Idle);
  Reg#(Bit#(32)) baseRegLoad <- mkReg(0);
  Reg#(Bit#(32)) baseRegStore <- mkReg(0);
  Reg#(Bit#(2)) commandCount <- mkReg(0);
  Reg#(Bit#(32)) commandsComplete <- mkReg(1);
  FIFO#(BusWord) dataFIFO <- mkSizedFIFO(32);
  Reg#(Bool) evenZero <- mkReg(True);
 
  rule grabInstruction(state == Idle && hostCommand1.read != 0);
    // Throw an RRR in here at some point....
    hostCommand1.write(0,~0); 
    baseRegLoad <= truncate(0); // BRAM is at 0
    baseRegStore <= truncate(0);
    state <= Running;
  endrule  
  
  rule issueCommand(state == Running);
    commandCount <= commandCount + 1;
    if(commandCount + 1 == 0)
      begin
        state <= Idle;
        commandsComplete <= commandsComplete + 1;
      end
    
    if(commandCount[0] == 0)
      begin
        baseRegLoad <= baseRegLoad + 8; 
        plbMaster.burstIfc.burstReq(tagged ReadReq BURST_COMMAND{size:1,addr:zeroExtend(baseRegLoad)});         
      end
    else
      begin
        baseRegStore <= baseRegStore + 8; 
        plbMaster.burstIfc.burstReq(tagged WriteReq BURST_COMMAND{size:1,addr:zeroExtend(baseRegStore)});         
      end
  endrule
  
  rule inputing;
     BusWord data <- plbMaster.burstIfc.readRsp();
     dataFIFO.enq(data);
  endrule 

  rule outputing;
    plbMaster.burstIfc.writeData(unpack((~(pack(dataFIFO.first))) & (~1)));
    dataFIFO.deq;
  endrule


  interface plbMasterWires = plbMaster.plbMasterWires;
  interface plbSlaveWires = plbSlave.plbSlaveWires;

endmodule
