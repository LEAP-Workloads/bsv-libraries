interface PLB_DRIVER;

     // Wires for hookout up the bus-based controller
     // hook the wires in reverse, as the names have already changed
     method Bit#(`C_AWIDTH) outBus2IP_Addr();
     method Bit#(`C_DWIDTH) outBus2IP_Data();
     method Bit#(TDiv#(`C_DWIDTH,8)) outBus2IP_BE();
     method Bit#(`C_NUM_CS) outBus2IP_CS();
     method Bit#(`C_NUM_CE) outBus2IP_RdCE();
     method Bit#(`C_NUM_CE) outBus2IP_WrCE();
     method Bit#(1) outBus2IP_RdReq();
     method Bit#(1) outBus2IP_WrReq();
     method Action inIP2Bus_IntrEvent(Bit#(`C_IP_INTR_NUM) value);
     method Action inIP2Bus_Data(Bit#(`C_DWIDTH) data);
     method Action inIP2Bus_Retry(Bit#(1) data);
     method Action inIP2Bus_Error(Bit#(1) data);
     method Action inIP2Bus_TinSup(Bit#(1) data);
     method Action inIP2Bus_RdAck(Bit#(1) data);
     method Action inIP2Bus_WrAck(Bit#(1) data);

     method Bit#(1) outPLB_MAddrAck();
     method Bit#(2) outPLB_MSSize();
     method Bit#(1) outPLB_MRearbitrate();
     (* always_ready *)
     method Bit#(1) outPLB_MBusy();
     (* always_ready *)
     method Bit#(1) outPLB_MErr();
     method Bit#(1) outPLB_MWrDAck();
     method Bit#(64) outPLB_MRdDBus();
     method Bit#(4) outPLB_MRdWdAddr();
     method Bit#(1) outPLB_MRdDAck();
     method Bit#(1) outPLB_MRdBTerm();
     method Bit#(1) outPLB_MWrBTerm();

     method Action inM_request(Bit#(1) data);
     method Action inM_priority(Bit#(2) data);
     method Action inM_busLock(Bit#(1) data);
     method Action inM_RNW(Bit#(1) data);
     method Action inM_BE(Bit#(8) data);
     method Action inM_MSize(Bit#(2) data);
     method Action inM_size(Bit#(4) data);
     method Action inM_type(Bit#(3) data);
     method Action inM_compress(Bit#(1) data);
     method Action inM_guarded(Bit#(1) data);
     method Action inM_ordered(Bit#(1) data);
     method Action inM_lockErr(Bit#(1) data);
     method Action inM_abort(Bit#(1) data);
     method Action inM_ABus(Bit#(32) data);
     method Action inM_wrDBus(Bit#(64) data);
     method Action inM_wrBurst(Bit#(1) data);
     method Action inM_rdBurst(Bit#(1) data);

     // Output Clock
    interface Clock ip_clk;
    interface Reset ip_rst;

endinterface
