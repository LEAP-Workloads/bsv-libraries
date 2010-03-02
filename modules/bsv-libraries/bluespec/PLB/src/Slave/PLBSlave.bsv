`include "asim/provides/plb_common.bsh"
`include "asim/provides/register_library.bsh"


import FIFOF::*;
import ClientServer::*;
import GetPut::*;
import Clocks::*;

// Should probably take the avalon abstraction thingy

module mkPLBSlave#(Clock externalClock, Reset externalReset) (PLBSlave#(address_width, data_width));
 
  Wire#(Bit#(1)) rdReqInValue <- mkBypassWire;
  Wire#(Bit#(1)) wrReqInValue <- mkBypassWire;
  Wire#(Bit#(1)) rdAckOutValue <- mkDWire(0);
  Wire#(Bit#(1)) wrAckOutValue <- mkDWire(0);
  Wire#(Bit#(1)) csInValue <- mkBypassWire;
  Wire#(Bit#(address_width)) addressInValue <- mkBypassWire;
  Wire#(Bit#(TDiv#(data_width,8))) beInValue <- mkBypassWire;
  Wire#(Bit#(data_width)) dataOutValue <- mkBypassWire;
  Wire#(Bit#(data_width)) dataInValue <- mkBypassWire;

  Reg#(Bit#(32)) loadCommandCountReg <- mkReg(0);
  Reg#(Bit#(32)) storeCommandCountReg <- mkReg(0);
  Reg#(Bit#(32)) totalCommandCountReg <- mkReg(0);
  Reg#(Bit#(32)) loadDataCountReg <- mkReg(0);
  Reg#(Bit#(32)) storeDataCountReg <- mkReg(0);

 ReadOnly#(Bit#(32)) loadCommandCountWire <- mkNullCrossingWire(externalClock,loadCommandCountReg._read);
  ReadOnly#(Bit#(32)) storeCommandCountWire <- mkNullCrossingWire(externalClock,storeCommandCountReg._read);
  ReadOnly#(Bit#(32)) totalCommandCountWire <- mkNullCrossingWire(externalClock,totalCommandCountReg._read);
  ReadOnly#(Bit#(32)) loadDataCountWire <- mkNullCrossingWire(externalClock,loadDataCountReg._read);
  ReadOnly#(Bit#(32)) storeDataCountWire <- mkNullCrossingWire(externalClock,storeDataCountReg._read);


  SyncFIFOIfc#(PLBRequest#(address_width,data_width)) reqFIFO <- mkSyncFIFOFromCC(2,externalClock);
  SyncFIFOIfc#(Bit#(data_width)) respFIFO <- mkSyncFIFOToCC(2,externalClock,externalReset);

  //FIFOF#(PLBRequest#(address_width,data_width)) reqFIFO <- mkFIFOF;
  //FIFOF#(Bit#(data_width)) respFIFO <- mkFIFOF;
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
       loadCommandCountReg <= loadCommandCountReg + 1;
      end
    else if(wrReqInValue == 1)
      begin
        //debug(avalonDebug,$display("DualAvalonSlave Side Write Req"));
  
        reqFIFO.enq(PLBRequest{addr: addressInValue,
                               data: dataInValue,
                               be: beInValue,
                               command: PLBWrite});   
        storeDataCountReg <= storeDataCountReg + 1;
        storeCommandCountReg <= storeCommandCountReg + 1;
        wrAckOutValue <= 1;
      end
    totalCommandCountReg <= totalCommandCountReg + 1;
  endrule

  rule produceResponse;
//    debug(avalonDebug,$display("Avalon Slave Resp"));
    respFIFO.deq;
    tokenFIFO.deq;
    dataOutValue <= respFIFO.first; // could register these.
    rdAckOutValue <= 1;
    loadDataCountReg <= loadDataCountReg + 1;
  endrule

 
  interface PLBSlaveWires plbSlaveWires;
    method Action sABus(Bit#(address_width) addr); // Address Bus
      addressInValue <= addr; 
    endmethod

    method Action sBE(Bit#(TDiv#(data_width,8)) be);       // Byte Enable
      beInValue <= be;
    endmethod

    method Action sCS(Bit#(1) cs);  
      csInValue <= cs;
    endmethod

    method Action sRdCE(Bit#(2) rdCE); 
      noAction; //Not needed?
    endmethod

    method Action sWrCE(Bit#(2) wrCE); 
      noAction; //Not needed
    endmethod

    method Action sRdReq(Bit#(1) rdReq);
      rdReqInValue <= rdReq;
    endmethod

    method Action sWrReq(Bit#(1) wrReq);
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

 interface loadCommandCount = loadCommandCountWire;
 interface storeCommandCount = storeCommandCountWire;
 interface totalCommandCount = totalCommandCountWire;
 interface loadDataCount = loadDataCountWire;
 interface storeDataCount = storeDataCountWire;

endmodule