`include "asim/provides/plb_master.bsh"
`include "asim/provides/plb_slave.bsh"
`include "asim/provides/plb_common.bsh"
`include "asim/provides/plb_device_debug.bsh"
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

  plb_device_debug::ServerStub_PLBDEBUGRRR server_stub <- plb_device_debug::mkServerStub_PLBDEBUGRRR();  

  mkConnectPLBDebugger(server_stub, plbMaster, plbSlave); 
  
  // Wire up PLB Master
  // Do nothing with the master here
    
  // Wire up PLB Slave
  // There are other solutions, but it seems simplest to emulate the byte 
  // enable code here, even though the CBusBE stuff exists  
  
  RegBE#(BusWord,8) hostCommand1 <- mkRegBE(0);
  RegBE#(BusWord,8) hostCommand2 <- mkRegBE(0);
  RegBE#(BusWord,8) hostCommand3 <- mkRegBE(0);


  rule handleEndCheck;
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

 method Bit#(1) outIP2Bus_IntrEvent();
   return 0;
 endmethod

 interface plbMasterWires = plbMaster.plbMasterWires;
 interface plbSlaveWires = plbSlave.plbSlaveWires;

endmodule
