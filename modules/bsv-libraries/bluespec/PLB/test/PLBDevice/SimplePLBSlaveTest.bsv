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


module [CONNECTED_MODULE]  mkPLBDevice#(Clock plbClock, Reset plbReset) (PLB_DEVICE);
  
  Clock clock <- exposeCurrentClock;
  Reset reset <- exposeCurrentReset;

  PLBMaster plbMaster <- mkPLBMaster(clock, reset, clocked_by plbClock, reset_by plbReset);
  PLBSlave#(32,64) plbSlave <- mkPLBSlave(clock, reset, clocked_by plbClock, reset_by plbReset);

  // Setup Debug RRR

  ServerStub_PLBDEBUGRRR server_stub <- mkServerStub_PLBDEBUGRRR();  

  mkConnectPLBDebugger(server_stub, plbMaster, plbSlave); 
  
  // Wire up PLB Master
  // Do nothing with the master here
    
  // Wire up PLB Slave
  // There are other solutions, but it seems simplest to emulate the byte 
  // enable code here, even though the CBusBE stuff exists  
  
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
          'h0: begin
               hostCommand1.write(req.data,req.be);
             end
          'h1: begin
               hostCommand2.write(req.data,req.be);
             end
        endcase
      end
    else
      begin
        case (regAddr)
          'h0: begin
               plbSlave.busClient.response.put(hostCommand1.read());
             end
          'h1: begin
               plbSlave.busClient.response.put(hostCommand2.read());
             end
           default: begin
               //Default to prevent deadlocks   
               plbSlave.busClient.response.put(zeroExtend(req.addr));     
             end
        endcase
      end
  endrule

 interface plbMasterWires = plbMaster.plbMasterWires;
 interface plbSlaveWires = plbSlave.plbSlaveWires;

endmodule
