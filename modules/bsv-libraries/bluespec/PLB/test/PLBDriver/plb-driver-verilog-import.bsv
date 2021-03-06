`include "asim/provides/plb_common.bsh"

// I need to thoutk abin the reset signal
import "BVI" plb_driver_verilog_wrapper = 
module mkPLBDriver

    // interface:
        (PLB_DRIVER);
            
     default_clock clk(sys_clk_pin, (*unused*)  sys_clk_gate_dummy);  
     default_reset rst(sys_rst_pin) clocked_by(clk); 

     output_clock ip_clk(ftl_0_Bus2IP_ClkOut_pin);
     output_reset ip_rst(ftl_0_Bus2IP_ResetOut_pin) clocked_by (ip_clk);

     method ftl_0_Bus2IP_AddrOut_pin outBus2IP_Addr() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_DataOut_pin outBus2IP_Data() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_BEOut_pin outBus2IP_BE() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_CSOut_pin outBus2IP_CS() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_RdCEOut_pin outBus2IP_RdCE() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_WrCEOut_pin outBus2IP_WrCE() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_RdReqOut_pin outBus2IP_RdReq() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_Bus2IP_WrReqOut_pin outBus2IP_WrReq() clocked_by(ip_clk) reset_by(ip_rst);

     method inIP2Bus_IntrEvent(ftl_0_IP2Bus_IntrEventOut_pin) enable(ftl_0_IP2Bus_IntrEventOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inIP2Bus_Data(ftl_0_IP2Bus_DataOut_pin) enable(ftl_0_IP2Bus_DataOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inIP2Bus_Retry(ftl_0_IP2Bus_RetryOut_pin) enable(ftl_0_IP2Bus_RetryOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inIP2Bus_Error(ftl_0_IP2Bus_ErrorOut_pin) enable(ftl_0_IP2Bus_ErrorOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inIP2Bus_TinSup(ftl_0_IP2Bus_ToutSupOut_pin) enable(ftl_0_IP2Bus_ToutSupOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);// This merits some examination since the names don't match
     method inIP2Bus_RdAck(ftl_0_IP2Bus_RdAckOut_pin) enable(ftl_0_IP2Bus_RdAckOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inIP2Bus_WrAck(ftl_0_IP2Bus_WrAckOut_pin) enable(ftl_0_IP2Bus_WrAckOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);

     method ftl_0_PLB_MAddrAckOut_pin outPLB_MAddrAck clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MSSizeOut_pin outPLB_MSSize clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MRearbitrateOut_pin outPLB_MRearbitrate() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MBusyOut_pin outPLB_MBusy() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MErrOut_pin outPLB_MErr() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MWrDAckOut_pin outPLB_MWrDAck() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MRdDBusOut_pin outPLB_MRdDBus() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MRdWdAddrOut_pin outPLB_MRdWdAddr() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MRdDAckOut_pin outPLB_MRdDAck() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MRdBTermOut_pin outPLB_MRdBTerm() clocked_by(ip_clk) reset_by(ip_rst);
     method ftl_0_PLB_MWrBTermOut_pin outPLB_MWrBTerm() clocked_by(ip_clk) reset_by(ip_rst);

     method inM_request(ftl_0_M_requestOut_pin) enable(ftl_0_M_requestOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_priority(ftl_0_M_priorityOut_pin) enable(ftl_0_M_priorityOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_busLock(ftl_0_M_busLockOut_pin) enable(ftl_0_M_busLockOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_RNW(ftl_0_M_RNWOut_pin) enable(ftl_0_M_RNWOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_BE(ftl_0_M_BEOut_pin) enable(ftl_0_M_BEOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_MSize(ftl_0_M_MSizeOut_pin) enable(ftl_0_M_MSizeOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_size(ftl_0_M_sizeOut_pin) enable(ftl_0_M_sizeOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_type(ftl_0_M_typeOut_pin) enable(ftl_0_M_typeOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_compress(ftl_0_M_compressOut_pin) enable(ftl_0_M_compressOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_guarded(ftl_0_M_guardedOut_pin) enable(ftl_0_M_guardedOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_ordered(ftl_0_M_orderedOut_pin) enable(ftl_0_M_orderedOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_lockErr(ftl_0_M_lockErrOut_pin) enable(ftl_0_M_lockErrOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_abort(ftl_0_M_abortOut_pin) enable(ftl_0_M_abortOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_ABus(ftl_0_M_ABusOut_pin) enable(ftl_0_M_ABusOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_wrDBus(ftl_0_M_wrDBusOut_pin) enable(ftl_0_M_wrDBusOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_wrBurst(ftl_0_M_wrBurstOut_pin) enable(ftl_0_M_wrBurstOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);
     method inM_rdBurst(ftl_0_M_rdBurstOut_pin) enable(ftl_0_M_rdBurstOut_pin_dummy_en) clocked_by(ip_clk) reset_by(ip_rst);


schedule    (
      inIP2Bus_IntrEvent,

      outBus2IP_Addr,
      outBus2IP_Data,
      outBus2IP_BE,
      outBus2IP_CS,
      outBus2IP_RdCE,
      outBus2IP_WrCE,
      outBus2IP_RdReq,
      outBus2IP_WrReq,
      inIP2Bus_Data, 
      inIP2Bus_Retry,
      inIP2Bus_Error,
      inIP2Bus_TinSup,
      inIP2Bus_RdAck,
      inIP2Bus_WrAck,
      outPLB_MAddrAck,
      outPLB_MSSize,
      outPLB_MRearbitrate,
      outPLB_MBusy,
      outPLB_MErr,
      outPLB_MWrDAck,
      outPLB_MRdDBus,
      outPLB_MRdWdAddr,
      outPLB_MRdDAck,
      outPLB_MRdBTerm,
      outPLB_MWrBTerm,
      inM_request,
      inM_priority,
      inM_busLock,
      inM_RNW,
      inM_BE,
      inM_MSize,
      inM_size,
      inM_type,
      inM_compress,
      inM_guarded,
      inM_ordered,
      inM_lockErr,
      inM_abort,
      inM_ABus,
      inM_wrDBus,
      inM_wrBurst,
      inM_rdBurst


     ) CF (
      inIP2Bus_IntrEvent,
      outBus2IP_Addr,
      outBus2IP_Data,
      outBus2IP_BE,
      outBus2IP_CS,
      outBus2IP_RdCE,
      outBus2IP_WrCE,
      outBus2IP_RdReq,
      outBus2IP_WrReq,
      inIP2Bus_Data,
      inIP2Bus_Retry,
      inIP2Bus_Error,
      inIP2Bus_TinSup,
      inIP2Bus_RdAck,
      inIP2Bus_WrAck,
      outPLB_MAddrAck,
      outPLB_MSSize,
      outPLB_MRearbitrate,
      outPLB_MBusy,
      outPLB_MErr,
      outPLB_MWrDAck,
      outPLB_MRdDBus,
      outPLB_MRdWdAddr,
      outPLB_MRdDAck,
      outPLB_MRdBTerm,
      outPLB_MWrBTerm,
      inM_request,
      inM_priority,
      inM_busLock,
      inM_RNW,
      inM_BE,
      inM_MSize,
      inM_size,
      inM_type,
      inM_compress,
      inM_guarded,
      inM_ordered,
      inM_lockErr,
      inM_abort,
      inM_ABus,
      inM_wrDBus,
      inM_wrBurst,
      inM_rdBurst

     );

endmodule
  