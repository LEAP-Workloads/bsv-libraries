`include "asim/provides/plb_common.bsh"

import FIFOF::*;
import ClientServer::*;
import GetPut::*;

// Should probably take the avalon abstraction thingy



module mkPLBSlave (PLBSlave#(address_width, data_width));
 
  Wire#(Bit#(1)) rdReqInValue <- mkBypassWire;
  Wire#(Bit#(1)) wrReqInValue <- mkBypassWire;
  Wire#(Bit#(1)) rdAckOutValue <- mkDWire(0);
  Wire#(Bit#(1)) wrAckOutValue <- mkDWire(0);
  Wire#(Bit#(1)) csInValue <- mkBypassWire;
  Wire#(Bit#(address_width)) addressInValue <- mkBypassWire;
  Wire#(Bit#(TDiv#(data_width,8))) beInValue <- mkBypassWire;
  Wire#(Bit#(data_width)) dataOutValue <- mkBypassWire;
  Wire#(Bit#(data_width)) dataInValue <- mkBypassWire;


//  SyncFIFOIfc#(PLBRequest#(address_width,data_width)) reqFIFO <- mkSyncFIFOFromCC(2,asicClock);
 // SyncFIFOIfc#(Bit#(data_width)) respFIFO <- mkSyncFIFOToCC(2,asicClock,asicReset);

  FIFOF#(PLBRequest#(address_width,data_width)) reqFIFO <- mkFIFOF;
  FIFOF#(Bit#(data_width)) respFIFO <- mkFIFOF;
  FIFOF#(Bit#(0)) tokenFIFO <- mkSizedFIFOF(2);


  rule produceRequests(csInValue == 1);
    if(rdReqInValue == 1) 
      begin
       // debug(avalonDebug,$display("PLB Slave Side Read Req: addr: %h", addressInValue));
       tokenFIFO.enq(?);
       reqFIFO.enq(PLBRequest{addr: addressInValue,
                              data: ?,
                              be: ?, 
                              command: PLBRead});
      end
    else if(wrReqInValue == 1)
      begin
        //debug(avalonDebug,$display("DualAvalonSlave Side Write Req"));
  
        reqFIFO.enq(PLBRequest{addr: addressInValue,
                               data: dataInValue,
                               be: beInValue,
                               command: PLBWrite});   
        wrAckOutValue <= 1;
      end
  endrule

  rule produceResponse;
//    debug(avalonDebug,$display("Avalon Slave Resp"));
    respFIFO.deq;
    tokenFIFO.deq;
    dataOutValue <= respFIFO.first; // could register these.
    rdAckOutValue <= 1;
  endrule

  interface PLBSlaveWires plbSlaveWires;
    method Action sABus(Bit#(address_width) addr); // Address Bus
      addressInValue <= addr; 
    endmethod

    method Action sBE(Bit#(TDiv#(data_width,8)) be);       // Byte Enable
      beInValue <= be;
    endmethod

    method Action sCS(Bit#(1) cs);  // Bus lock
      csInValue <= cs;
    endmethod

    method Action sRdCE(Bit#(2) rdCE);  // Bus lock
      noAction; //Not needed?
    endmethod

    method Action sWrCE(Bit#(2) wrCE);  // Bus lock
      noAction; //Not needed
    endmethod

    method Action sRdReq(Bit#(1) rdReq);  // Bus lock
      rdReqInValue <= rdReq;
    endmethod

    method Action sWrReq(Bit#(1) wrReq);  // Bus lock
      wrReqInValue <= wrReq;
    endmethod

    method Action sDataIn(Bit#(data_width) data);
      dataInValue <= data;
    endmethod

    method Bit#(data_width) sDataOut();
      return dataOutValue;
    endmethod 

    method Bit#(1) sBusy();
      return (tokenFIFO.notFull && reqFIFO.notFull)?0:1; 
    endmethod 

    method Bit#(1) sRetry();
      return  0;
    endmethod  

    method Bit#(1) sError();
      return 0;
    endmethod  

    method Bit#(1) sToutSup();
      return 0;
    endmethod

    method Bit#(1) sRdAck();
      return rdAckOutValue;
    endmethod  

    method Bit#(1) sWrAck();
      return wrAckOutValue;
    endmethod
 
  endinterface

 interface Client busClient;
   interface Get request;
     method ActionValue#(PLBRequest#(address_width,data_width)) get();
       reqFIFO.deq;
       return reqFIFO.first;
     endmethod
   endinterface 

   interface Put response;
     method Action put(Bit#(data_width) data);
       // debug(avalonDebug,$display("PLB Slave Resp"));
       respFIFO.enq(data);
     endmethod
   endinterface
 endinterface

endmodule