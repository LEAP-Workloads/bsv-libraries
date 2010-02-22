//-----------------------------------------------------------------------------
// system_stub.v
//-----------------------------------------------------------------------------

module system_stub
  (
    fpga_0_net_gnd_pin,
    fpga_0_net_gnd_1_pin,
    fpga_0_net_gnd_2_pin,
    fpga_0_net_gnd_3_pin,
    fpga_0_net_gnd_4_pin,
    fpga_0_net_gnd_5_pin,
    fpga_0_net_gnd_6_pin,
    sys_clk_pin,
    sys_rst_pin,
    ftl_0_IP2Bus_WrAckOut_pin,
    ftl_0_IP2Bus_RdAckOut_pin,
    ftl_0_IP2Bus_ToutSupOut_pin,
    ftl_0_IP2Bus_ErrorOut_pin,
    ftl_0_IP2Bus_RetryOut_pin,
    ftl_0_IP2Bus_DataOut_pin,
    ftl_0_Bus2IP_WrReqOut_pin,
    ftl_0_Bus2IP_RdReqOut_pin,
    ftl_0_Bus2IP_WrCEOut_pin,
    ftl_0_Bus2IP_RdCEOut_pin,
    ftl_0_Bus2IP_CSOut_pin,
    ftl_0_Bus2IP_BEOut_pin,
    ftl_0_Bus2IP_DataOut_pin,
    ftl_0_Bus2IP_AddrOut_pin,
    ftl_0_IP2Bus_IntrEventOut_pin,
    ftl_0_Bus2IP_ResetOut_pin,
    ftl_0_Bus2IP_ClkOut_pin,
    ftl_0_M_rdBurstOut_pin,
    ftl_0_M_wrBurstOut_pin,
    ftl_0_M_wrDBusOut_pin,
    ftl_0_M_ABusOut_pin,
    ftl_0_M_abortOut_pin,
    ftl_0_M_lockErrOut_pin,
    ftl_0_M_orderedOut_pin,
    ftl_0_M_guardedOut_pin,
    ftl_0_M_compressOut_pin,
    ftl_0_M_typeOut_pin,
    ftl_0_M_sizeOut_pin,
    ftl_0_M_MSizeOut_pin,
    ftl_0_M_BEOut_pin,
    ftl_0_M_RNWOut_pin,
    ftl_0_M_busLockOut_pin,
    ftl_0_M_priorityOut_pin,
    ftl_0_M_requestOut_pin,
    ftl_0_PLB_MWrBTermOut_pin,
    ftl_0_PLB_MRdBTermOut_pin,
    ftl_0_PLB_MRdDAckOut_pin,
    ftl_0_PLB_MRdWdAddrOut_pin,
    ftl_0_PLB_MRdDBusOut_pin,
    ftl_0_PLB_MWrDAckOut_pin,
    ftl_0_PLB_MErrOut_pin,
    ftl_0_PLB_MBusyOut_pin,
    ftl_0_PLB_MRearbitrateOut_pin,
    ftl_0_PLB_MSSizeOut_pin,
    ftl_0_PLB_MAddrAckOut_pin,
    ftl_0_IP2INTC_Irpt_pin
  );
  output fpga_0_net_gnd_pin;
  output fpga_0_net_gnd_1_pin;
  output fpga_0_net_gnd_2_pin;
  output fpga_0_net_gnd_3_pin;
  output fpga_0_net_gnd_4_pin;
  output fpga_0_net_gnd_5_pin;
  output fpga_0_net_gnd_6_pin;
  input sys_clk_pin;
  input sys_rst_pin;
  input ftl_0_IP2Bus_WrAckOut_pin;
  input ftl_0_IP2Bus_RdAckOut_pin;
  input ftl_0_IP2Bus_ToutSupOut_pin;
  input ftl_0_IP2Bus_ErrorOut_pin;
  input ftl_0_IP2Bus_RetryOut_pin;
  input [0:63] ftl_0_IP2Bus_DataOut_pin;
  output ftl_0_Bus2IP_WrReqOut_pin;
  output ftl_0_Bus2IP_RdReqOut_pin;
  output [0:1] ftl_0_Bus2IP_WrCEOut_pin;
  output [0:1] ftl_0_Bus2IP_RdCEOut_pin;
  output ftl_0_Bus2IP_CSOut_pin;
  output [0:7] ftl_0_Bus2IP_BEOut_pin;
  output [0:63] ftl_0_Bus2IP_DataOut_pin;
  output [0:31] ftl_0_Bus2IP_AddrOut_pin;
  input ftl_0_IP2Bus_IntrEventOut_pin;
  output ftl_0_Bus2IP_ResetOut_pin;
  output ftl_0_Bus2IP_ClkOut_pin;
  input ftl_0_M_rdBurstOut_pin;
  input ftl_0_M_wrBurstOut_pin;
  input [0:63] ftl_0_M_wrDBusOut_pin;
  input [0:31] ftl_0_M_ABusOut_pin;
  input ftl_0_M_abortOut_pin;
  input ftl_0_M_lockErrOut_pin;
  input ftl_0_M_orderedOut_pin;
  input ftl_0_M_guardedOut_pin;
  input ftl_0_M_compressOut_pin;
  input [0:2] ftl_0_M_typeOut_pin;
  input [0:3] ftl_0_M_sizeOut_pin;
  input [0:1] ftl_0_M_MSizeOut_pin;
  input [0:7] ftl_0_M_BEOut_pin;
  input ftl_0_M_RNWOut_pin;
  input ftl_0_M_busLockOut_pin;
  input [0:1] ftl_0_M_priorityOut_pin;
  input ftl_0_M_requestOut_pin;
  output ftl_0_PLB_MWrBTermOut_pin;
  output ftl_0_PLB_MRdBTermOut_pin;
  output ftl_0_PLB_MRdDAckOut_pin;
  output [0:3] ftl_0_PLB_MRdWdAddrOut_pin;
  output [0:63] ftl_0_PLB_MRdDBusOut_pin;
  output ftl_0_PLB_MWrDAckOut_pin;
  output ftl_0_PLB_MErrOut_pin;
  output ftl_0_PLB_MBusyOut_pin;
  output ftl_0_PLB_MRearbitrateOut_pin;
  output [0:1] ftl_0_PLB_MSSizeOut_pin;
  output ftl_0_PLB_MAddrAckOut_pin;
  output ftl_0_IP2INTC_Irpt_pin;

  system
    system_i (
      .fpga_0_net_gnd_pin ( fpga_0_net_gnd_pin ),
      .fpga_0_net_gnd_1_pin ( fpga_0_net_gnd_1_pin ),
      .fpga_0_net_gnd_2_pin ( fpga_0_net_gnd_2_pin ),
      .fpga_0_net_gnd_3_pin ( fpga_0_net_gnd_3_pin ),
      .fpga_0_net_gnd_4_pin ( fpga_0_net_gnd_4_pin ),
      .fpga_0_net_gnd_5_pin ( fpga_0_net_gnd_5_pin ),
      .fpga_0_net_gnd_6_pin ( fpga_0_net_gnd_6_pin ),
      .sys_clk_pin ( sys_clk_pin ),
      .sys_rst_pin ( sys_rst_pin ),
      .ftl_0_IP2Bus_WrAckOut_pin ( ftl_0_IP2Bus_WrAckOut_pin ),
      .ftl_0_IP2Bus_RdAckOut_pin ( ftl_0_IP2Bus_RdAckOut_pin ),
      .ftl_0_IP2Bus_ToutSupOut_pin ( ftl_0_IP2Bus_ToutSupOut_pin ),
      .ftl_0_IP2Bus_ErrorOut_pin ( ftl_0_IP2Bus_ErrorOut_pin ),
      .ftl_0_IP2Bus_RetryOut_pin ( ftl_0_IP2Bus_RetryOut_pin ),
      .ftl_0_IP2Bus_DataOut_pin ( ftl_0_IP2Bus_DataOut_pin ),
      .ftl_0_Bus2IP_WrReqOut_pin ( ftl_0_Bus2IP_WrReqOut_pin ),
      .ftl_0_Bus2IP_RdReqOut_pin ( ftl_0_Bus2IP_RdReqOut_pin ),
      .ftl_0_Bus2IP_WrCEOut_pin ( ftl_0_Bus2IP_WrCEOut_pin ),
      .ftl_0_Bus2IP_RdCEOut_pin ( ftl_0_Bus2IP_RdCEOut_pin ),
      .ftl_0_Bus2IP_CSOut_pin ( ftl_0_Bus2IP_CSOut_pin ),
      .ftl_0_Bus2IP_BEOut_pin ( ftl_0_Bus2IP_BEOut_pin ),
      .ftl_0_Bus2IP_DataOut_pin ( ftl_0_Bus2IP_DataOut_pin ),
      .ftl_0_Bus2IP_AddrOut_pin ( ftl_0_Bus2IP_AddrOut_pin ),
      .ftl_0_IP2Bus_IntrEventOut_pin ( ftl_0_IP2Bus_IntrEventOut_pin ),
      .ftl_0_Bus2IP_ResetOut_pin ( ftl_0_Bus2IP_ResetOut_pin ),
      .ftl_0_Bus2IP_ClkOut_pin ( ftl_0_Bus2IP_ClkOut_pin ),
      .ftl_0_M_rdBurstOut_pin ( ftl_0_M_rdBurstOut_pin ),
      .ftl_0_M_wrBurstOut_pin ( ftl_0_M_wrBurstOut_pin ),
      .ftl_0_M_wrDBusOut_pin ( ftl_0_M_wrDBusOut_pin ),
      .ftl_0_M_ABusOut_pin ( ftl_0_M_ABusOut_pin ),
      .ftl_0_M_abortOut_pin ( ftl_0_M_abortOut_pin ),
      .ftl_0_M_lockErrOut_pin ( ftl_0_M_lockErrOut_pin ),
      .ftl_0_M_orderedOut_pin ( ftl_0_M_orderedOut_pin ),
      .ftl_0_M_guardedOut_pin ( ftl_0_M_guardedOut_pin ),
      .ftl_0_M_compressOut_pin ( ftl_0_M_compressOut_pin ),
      .ftl_0_M_typeOut_pin ( ftl_0_M_typeOut_pin ),
      .ftl_0_M_sizeOut_pin ( ftl_0_M_sizeOut_pin ),
      .ftl_0_M_MSizeOut_pin ( ftl_0_M_MSizeOut_pin ),
      .ftl_0_M_BEOut_pin ( ftl_0_M_BEOut_pin ),
      .ftl_0_M_RNWOut_pin ( ftl_0_M_RNWOut_pin ),
      .ftl_0_M_busLockOut_pin ( ftl_0_M_busLockOut_pin ),
      .ftl_0_M_priorityOut_pin ( ftl_0_M_priorityOut_pin ),
      .ftl_0_M_requestOut_pin ( ftl_0_M_requestOut_pin ),
      .ftl_0_PLB_MWrBTermOut_pin ( ftl_0_PLB_MWrBTermOut_pin ),
      .ftl_0_PLB_MRdBTermOut_pin ( ftl_0_PLB_MRdBTermOut_pin ),
      .ftl_0_PLB_MRdDAckOut_pin ( ftl_0_PLB_MRdDAckOut_pin ),
      .ftl_0_PLB_MRdWdAddrOut_pin ( ftl_0_PLB_MRdWdAddrOut_pin ),
      .ftl_0_PLB_MRdDBusOut_pin ( ftl_0_PLB_MRdDBusOut_pin ),
      .ftl_0_PLB_MWrDAckOut_pin ( ftl_0_PLB_MWrDAckOut_pin ),
      .ftl_0_PLB_MErrOut_pin ( ftl_0_PLB_MErrOut_pin ),
      .ftl_0_PLB_MBusyOut_pin ( ftl_0_PLB_MBusyOut_pin ),
      .ftl_0_PLB_MRearbitrateOut_pin ( ftl_0_PLB_MRearbitrateOut_pin ),
      .ftl_0_PLB_MSSizeOut_pin ( ftl_0_PLB_MSSizeOut_pin ),
      .ftl_0_PLB_MAddrAckOut_pin ( ftl_0_PLB_MAddrAckOut_pin ),
      .ftl_0_IP2INTC_Irpt_pin ( ftl_0_IP2INTC_Irpt_pin )
    );

endmodule

