//-----------------------------------------------------------------------------
// system.v
//-----------------------------------------------------------------------------

module gordon_ftl_verilog
  (
    fpga_0_Ethernet_MAC_slew1_pin,
    fpga_0_Ethernet_MAC_slew2_pin,
    fpga_0_Ethernet_MAC_PHY_rst_n_pin,
    fpga_0_Ethernet_MAC_PHY_crs_pin,
    fpga_0_Ethernet_MAC_PHY_col_pin,
    fpga_0_Ethernet_MAC_PHY_tx_data_pin,
    fpga_0_Ethernet_MAC_PHY_tx_en_pin,
    fpga_0_Ethernet_MAC_PHY_tx_clk_pin,
    fpga_0_Ethernet_MAC_PHY_tx_er_pin,
    fpga_0_Ethernet_MAC_PHY_rx_er_pin,
    fpga_0_Ethernet_MAC_PHY_rx_clk_pin,
    fpga_0_Ethernet_MAC_PHY_dv_pin,
    fpga_0_Ethernet_MAC_PHY_rx_data_pin,
    fpga_0_Ethernet_MAC_PHY_Mii_clk_pin,
    fpga_0_Ethernet_MAC_PHY_Mii_data_pin,
    fpga_0_SysACE_CompactFlash_SysACE_CLK_pin,
    fpga_0_SysACE_CompactFlash_SysACE_MPA_pin,
    fpga_0_SysACE_CompactFlash_SysACE_MPD_pin,
    fpga_0_SysACE_CompactFlash_SysACE_CEN_pin,
    fpga_0_SysACE_CompactFlash_SysACE_OEN_pin,
    fpga_0_SysACE_CompactFlash_SysACE_WEN_pin,
    fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clk_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clkn_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Addr_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_BankAddr_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CASn_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_RASn_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_WEn_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DM_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CKE_pin,
    fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CSn_pin,
    fpga_0_net_gnd_pin,
    fpga_0_net_gnd_1_pin,
    fpga_0_net_gnd_2_pin,
    fpga_0_net_gnd_3_pin,
    fpga_0_net_gnd_4_pin,
    fpga_0_net_gnd_5_pin,
    fpga_0_net_gnd_6_pin,
    fpga_0_DDR_CLK_FB,
    fpga_0_DDR_CLK_FB_OUT,
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
    ftl_0_PLB_MAddrAckOut_pin
  );
  output fpga_0_Ethernet_MAC_slew1_pin;
  output fpga_0_Ethernet_MAC_slew2_pin;
  output fpga_0_Ethernet_MAC_PHY_rst_n_pin;
  input fpga_0_Ethernet_MAC_PHY_crs_pin;
  input fpga_0_Ethernet_MAC_PHY_col_pin;
  output [3:0] fpga_0_Ethernet_MAC_PHY_tx_data_pin;
  output fpga_0_Ethernet_MAC_PHY_tx_en_pin;
  input fpga_0_Ethernet_MAC_PHY_tx_clk_pin;
  output fpga_0_Ethernet_MAC_PHY_tx_er_pin;
  input fpga_0_Ethernet_MAC_PHY_rx_er_pin;
  input fpga_0_Ethernet_MAC_PHY_rx_clk_pin;
  input fpga_0_Ethernet_MAC_PHY_dv_pin;
  input [3:0] fpga_0_Ethernet_MAC_PHY_rx_data_pin;
  inout fpga_0_Ethernet_MAC_PHY_Mii_clk_pin;
  inout fpga_0_Ethernet_MAC_PHY_Mii_data_pin;
  input fpga_0_SysACE_CompactFlash_SysACE_CLK_pin;
  output [6:0] fpga_0_SysACE_CompactFlash_SysACE_MPA_pin;
  inout [15:0] fpga_0_SysACE_CompactFlash_SysACE_MPD_pin;
  output fpga_0_SysACE_CompactFlash_SysACE_CEN_pin;
  output fpga_0_SysACE_CompactFlash_SysACE_OEN_pin;
  output fpga_0_SysACE_CompactFlash_SysACE_WEN_pin;
  input fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin;
  output [0:2] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clk_pin;
  output [0:2] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clkn_pin;
  output [0:12] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Addr_pin;
  output [0:1] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_BankAddr_pin;
  output fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CASn_pin;
  output fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_RASn_pin;
  output fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_WEn_pin;
  output [0:7] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DM_pin;
  inout [0:7] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin;
  inout [0:63] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin;
  output [0:1] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CKE_pin;
  output [0:1] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CSn_pin;
  output fpga_0_net_gnd_pin;
  output fpga_0_net_gnd_1_pin;
  output fpga_0_net_gnd_2_pin;
  output fpga_0_net_gnd_3_pin;
  output fpga_0_net_gnd_4_pin;
  output fpga_0_net_gnd_5_pin;
  output fpga_0_net_gnd_6_pin;
  input fpga_0_DDR_CLK_FB;
  output fpga_0_DDR_CLK_FB_OUT;
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
  input [0:0] ftl_0_IP2Bus_IntrEventOut_pin;
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

  // Internal signals

  wire C405RSTCHIPRESETREQ;
  wire C405RSTCORERESETREQ;
  wire C405RSTSYSRESETREQ;
  wire EICC405EXTINPUTIRQ;
  wire Ethernet_MAC_IP2INTC_Irpt;
  wire RSTC405RESETCHIP;
  wire RSTC405RESETCORE;
  wire RSTC405RESETSYS;
  wire SysACE_CompactFlash_SysACE_IRQ;
  wire [0:0] clk_90_n_s;
  wire [0:0] clk_90_s;
  wire dcm_0_lock;
  wire dcm_1_FB;
  wire dcm_1_lock;
  wire dcm_clk_s;
  wire [0:0] ddr_clk_90_n_s;
  wire [0:0] ddr_clk_90_s;
  wire ddr_clk_feedback_out_s;
  wire ddr_feedback_s;
  wire [0:12] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Addr;
  wire [0:1] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_BankAddr;
  wire fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CASn;
  wire [0:1] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CKE;
  wire [0:1] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CSn;
  wire [0:2] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clk;
  wire [0:2] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clkn;
  wire [0:7] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DM;
  wire [0:7] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I;
  wire [0:7] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O;
  wire [0:7] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T;
  wire [0:63] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I;
  wire [0:63] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O;
  wire [0:63] fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T;
  wire fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_RASn;
  wire fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_WEn;
  wire fpga_0_Ethernet_MAC_PHY_Mii_clk_I;
  wire fpga_0_Ethernet_MAC_PHY_Mii_clk_O;
  wire fpga_0_Ethernet_MAC_PHY_Mii_clk_T;
  wire fpga_0_Ethernet_MAC_PHY_Mii_data_I;
  wire fpga_0_Ethernet_MAC_PHY_Mii_data_O;
  wire fpga_0_Ethernet_MAC_PHY_Mii_data_T;
  wire fpga_0_Ethernet_MAC_PHY_col;
  wire fpga_0_Ethernet_MAC_PHY_crs;
  wire fpga_0_Ethernet_MAC_PHY_dv;
  wire fpga_0_Ethernet_MAC_PHY_rst_n;
  wire fpga_0_Ethernet_MAC_PHY_rx_clk;
  wire [3:0] fpga_0_Ethernet_MAC_PHY_rx_data;
  wire fpga_0_Ethernet_MAC_PHY_rx_er;
  wire fpga_0_Ethernet_MAC_PHY_tx_clk;
  wire [3:0] fpga_0_Ethernet_MAC_PHY_tx_data;
  wire fpga_0_Ethernet_MAC_PHY_tx_en;
  wire fpga_0_Ethernet_MAC_PHY_tx_er;
  wire fpga_0_SysACE_CompactFlash_SysACE_CEN;
  wire fpga_0_SysACE_CompactFlash_SysACE_CLK;
  wire [6:0] fpga_0_SysACE_CompactFlash_SysACE_MPA;
  wire [15:0] fpga_0_SysACE_CompactFlash_SysACE_MPD_I;
  wire [15:0] fpga_0_SysACE_CompactFlash_SysACE_MPD_O;
  wire [15:0] fpga_0_SysACE_CompactFlash_SysACE_MPD_T;
  wire fpga_0_SysACE_CompactFlash_SysACE_MPIRQ;
  wire fpga_0_SysACE_CompactFlash_SysACE_OEN;
  wire fpga_0_SysACE_CompactFlash_SysACE_WEN;
  wire [0:31] ftl_0_Bus2IP_AddrOut;
  wire [0:7] ftl_0_Bus2IP_BEOut;
  wire ftl_0_Bus2IP_CSOut;
  wire ftl_0_Bus2IP_ClkOut;
  wire [0:63] ftl_0_Bus2IP_DataOut;
  wire [0:1] ftl_0_Bus2IP_RdCEOut;
  wire ftl_0_Bus2IP_RdReqOut;
  wire ftl_0_Bus2IP_ResetOut;
  wire [0:1] ftl_0_Bus2IP_WrCEOut;
  wire ftl_0_Bus2IP_WrReqOut;
  wire [0:63] ftl_0_IP2Bus_DataOut;
  wire ftl_0_IP2Bus_ErrorOut;
  wire [0:0] ftl_0_IP2Bus_IntrEventOut;
  wire ftl_0_IP2Bus_RdAckOut;
  wire ftl_0_IP2Bus_RetryOut;
  wire ftl_0_IP2Bus_ToutSupOut;
  wire ftl_0_IP2Bus_WrAckOut;
  wire ftl_0_IP2INTC_Irpt;
  wire [0:31] ftl_0_M_ABusOut;
  wire [0:7] ftl_0_M_BEOut;
  wire [0:1] ftl_0_M_MSizeOut;
  wire ftl_0_M_RNWOut;
  wire ftl_0_M_abortOut;
  wire ftl_0_M_busLockOut;
  wire ftl_0_M_compressOut;
  wire ftl_0_M_guardedOut;
  wire ftl_0_M_lockErrOut;
  wire ftl_0_M_orderedOut;
  wire [0:1] ftl_0_M_priorityOut;
  wire ftl_0_M_rdBurstOut;
  wire ftl_0_M_requestOut;
  wire [0:3] ftl_0_M_sizeOut;
  wire [0:2] ftl_0_M_typeOut;
  wire ftl_0_M_wrBurstOut;
  wire [0:63] ftl_0_M_wrDBusOut;
  wire ftl_0_PLB_MAddrAckOut;
  wire ftl_0_PLB_MBusyOut;
  wire ftl_0_PLB_MErrOut;
  wire ftl_0_PLB_MRdBTermOut;
  wire ftl_0_PLB_MRdDAckOut;
  wire [0:63] ftl_0_PLB_MRdDBusOut;
  wire [0:3] ftl_0_PLB_MRdWdAddrOut;
  wire ftl_0_PLB_MRearbitrateOut;
  wire [0:1] ftl_0_PLB_MSSizeOut;
  wire ftl_0_PLB_MWrBTermOut;
  wire ftl_0_PLB_MWrDAckOut;
  wire jtagppc_0_0_C405JTGTDO;
  wire jtagppc_0_0_C405JTGTDOEN;
  wire jtagppc_0_0_JTGC405TCK;
  wire jtagppc_0_0_JTGC405TDI;
  wire jtagppc_0_0_JTGC405TMS;
  wire jtagppc_0_0_JTGC405TRSTNEG;
  wire jtagppc_0_1_C405JTGTDO;
  wire jtagppc_0_1_C405JTGTDOEN;
  wire jtagppc_0_1_JTGC405TCK;
  wire jtagppc_0_1_JTGC405TDI;
  wire jtagppc_0_1_JTGC405TMS;
  wire jtagppc_0_1_JTGC405TRSTNEG;
  wire net_gnd0;
  wire [0:0] net_gnd1;
  wire [0:1] net_gnd2;
  wire [0:3] net_gnd4;
  wire [0:6] net_gnd7;
  wire [0:7] net_gnd8;
  wire [0:9] net_gnd10;
  wire [0:31] net_gnd32;
  wire [0:63] net_gnd64;
  wire net_vcc0;
  wire [0:0] net_vcc1;
  wire [0:1] net_vcc2;
  wire [0:31] opb_M_ABus;
  wire [0:3] opb_M_BE;
  wire [0:31] opb_M_DBus;
  wire [0:0] opb_M_RNW;
  wire [0:0] opb_M_busLock;
  wire [0:0] opb_M_request;
  wire [0:0] opb_M_select;
  wire [0:0] opb_M_seqAddr;
  wire [0:31] opb_OPB_ABus;
  wire [0:3] opb_OPB_BE;
  wire [0:31] opb_OPB_DBus;
  wire [0:0] opb_OPB_MGrant;
  wire opb_OPB_RNW;
  wire opb_OPB_Rst;
  wire opb_OPB_errAck;
  wire opb_OPB_retry;
  wire opb_OPB_select;
  wire opb_OPB_seqAddr;
  wire opb_OPB_timeout;
  wire opb_OPB_xferAck;
  wire [0:63] opb_Sl_DBus;
  wire [0:1] opb_Sl_errAck;
  wire [0:1] opb_Sl_retry;
  wire [0:1] opb_Sl_toutSup;
  wire [0:1] opb_Sl_xferAck;
  wire [0:0] pgassign1;
  wire [2:0] pgassign2;
  wire [0:3] pgassign3;
  wire [0:3] pgassign4;
  wire [0:95] plb_M_ABus;
  wire [0:23] plb_M_BE;
  wire [0:5] plb_M_MSize;
  wire [0:2] plb_M_RNW;
  wire [0:2] plb_M_abort;
  wire [0:2] plb_M_busLock;
  wire [0:2] plb_M_compress;
  wire [0:2] plb_M_guarded;
  wire [0:2] plb_M_lockErr;
  wire [0:2] plb_M_ordered;
  wire [0:5] plb_M_priority;
  wire [0:2] plb_M_rdBurst;
  wire [0:2] plb_M_request;
  wire [0:11] plb_M_size;
  wire [0:8] plb_M_type;
  wire [0:2] plb_M_wrBurst;
  wire [0:191] plb_M_wrDBus;
  wire [0:4] plb_PLB2OPB_rearb;
  wire [0:31] plb_PLB_ABus;
  wire [0:7] plb_PLB_BE;
  wire [0:2] plb_PLB_MAddrAck;
  wire [0:2] plb_PLB_MBusy;
  wire [0:2] plb_PLB_MErr;
  wire [0:2] plb_PLB_MRdBTerm;
  wire [0:2] plb_PLB_MRdDAck;
  wire [0:191] plb_PLB_MRdDBus;
  wire [0:11] plb_PLB_MRdWdAddr;
  wire [0:2] plb_PLB_MRearbitrate;
  wire [0:5] plb_PLB_MSSize;
  wire [0:1] plb_PLB_MSize;
  wire [0:2] plb_PLB_MWrBTerm;
  wire [0:2] plb_PLB_MWrDAck;
  wire plb_PLB_PAValid;
  wire plb_PLB_RNW;
  wire plb_PLB_Rst;
  wire plb_PLB_SAValid;
  wire [0:2] plb_PLB_SMBusy;
  wire [0:2] plb_PLB_SMErr;
  wire plb_PLB_abort;
  wire plb_PLB_busLock;
  wire plb_PLB_compress;
  wire plb_PLB_guarded;
  wire plb_PLB_lockErr;
  wire [0:1] plb_PLB_masterID;
  wire plb_PLB_ordered;
  wire [0:1] plb_PLB_pendPri;
  wire plb_PLB_pendReq;
  wire plb_PLB_rdBurst;
  wire plb_PLB_rdPrim;
  wire [0:1] plb_PLB_reqPri;
  wire [0:3] plb_PLB_size;
  wire [0:2] plb_PLB_type;
  wire plb_PLB_wrBurst;
  wire [0:63] plb_PLB_wrDBus;
  wire plb_PLB_wrPrim;
  wire [0:14] plb_Sl_MBusy;
  wire [0:14] plb_Sl_MErr;
  wire [0:9] plb_Sl_SSize;
  wire [0:4] plb_Sl_addrAck;
  wire [0:4] plb_Sl_rdBTerm;
  wire [0:4] plb_Sl_rdComp;
  wire [0:4] plb_Sl_rdDAck;
  wire [0:319] plb_Sl_rdDBus;
  wire [0:19] plb_Sl_rdWdAddr;
  wire [0:4] plb_Sl_rearbitrate;
  wire [0:4] plb_Sl_wait;
  wire [0:4] plb_Sl_wrBTerm;
  wire [0:4] plb_Sl_wrComp;
  wire [0:4] plb_Sl_wrDAck;
  wire [0:31] plb_bram_if_cntlr_1_port_BRAM_Addr;
  wire plb_bram_if_cntlr_1_port_BRAM_Clk;
  wire [0:63] plb_bram_if_cntlr_1_port_BRAM_Din;
  wire [0:63] plb_bram_if_cntlr_1_port_BRAM_Dout;
  wire plb_bram_if_cntlr_1_port_BRAM_EN;
  wire plb_bram_if_cntlr_1_port_BRAM_Rst;
  wire [0:7] plb_bram_if_cntlr_1_port_BRAM_WEN;
  wire proc_clk_s;
  wire [0:0] sys_bus_reset;
  wire [0:0] sys_clk_n_s;
  wire [0:0] sys_clk_s;
  wire sys_rst_s;

  // Internal assignments

  assign fpga_0_Ethernet_MAC_PHY_rst_n_pin = fpga_0_Ethernet_MAC_PHY_rst_n;
  assign fpga_0_Ethernet_MAC_PHY_crs = fpga_0_Ethernet_MAC_PHY_crs_pin;
  assign fpga_0_Ethernet_MAC_PHY_col = fpga_0_Ethernet_MAC_PHY_col_pin;
  assign fpga_0_Ethernet_MAC_PHY_tx_data_pin = fpga_0_Ethernet_MAC_PHY_tx_data;
  assign fpga_0_Ethernet_MAC_PHY_tx_en_pin = fpga_0_Ethernet_MAC_PHY_tx_en;
  assign fpga_0_Ethernet_MAC_PHY_tx_clk = fpga_0_Ethernet_MAC_PHY_tx_clk_pin;
  assign fpga_0_Ethernet_MAC_PHY_tx_er_pin = fpga_0_Ethernet_MAC_PHY_tx_er;
  assign fpga_0_Ethernet_MAC_PHY_rx_er = fpga_0_Ethernet_MAC_PHY_rx_er_pin;
  assign fpga_0_Ethernet_MAC_PHY_rx_clk = fpga_0_Ethernet_MAC_PHY_rx_clk_pin;
  assign fpga_0_Ethernet_MAC_PHY_dv = fpga_0_Ethernet_MAC_PHY_dv_pin;
  assign fpga_0_Ethernet_MAC_PHY_rx_data = fpga_0_Ethernet_MAC_PHY_rx_data_pin;
  assign fpga_0_SysACE_CompactFlash_SysACE_CLK = fpga_0_SysACE_CompactFlash_SysACE_CLK_pin;
  assign fpga_0_SysACE_CompactFlash_SysACE_MPA_pin = fpga_0_SysACE_CompactFlash_SysACE_MPA;
  assign fpga_0_SysACE_CompactFlash_SysACE_CEN_pin = fpga_0_SysACE_CompactFlash_SysACE_CEN;
  assign fpga_0_SysACE_CompactFlash_SysACE_OEN_pin = fpga_0_SysACE_CompactFlash_SysACE_OEN;
  assign fpga_0_SysACE_CompactFlash_SysACE_WEN_pin = fpga_0_SysACE_CompactFlash_SysACE_WEN;
  assign fpga_0_SysACE_CompactFlash_SysACE_MPIRQ = fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clk_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clk;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clkn_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clkn;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Addr_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Addr;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_BankAddr_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_BankAddr;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CASn_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CASn;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_RASn_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_RASn;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_WEn_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_WEn;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DM_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DM;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CKE_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CKE;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CSn_pin = fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CSn;
  assign ddr_feedback_s = fpga_0_DDR_CLK_FB;
  assign fpga_0_DDR_CLK_FB_OUT = ddr_clk_feedback_out_s;
  assign dcm_clk_s = sys_clk_pin;
  assign sys_rst_s = sys_rst_pin;
  assign ftl_0_IP2Bus_WrAckOut = ftl_0_IP2Bus_WrAckOut_pin;
  assign ftl_0_IP2Bus_RdAckOut = ftl_0_IP2Bus_RdAckOut_pin;
  assign ftl_0_IP2Bus_ToutSupOut = ftl_0_IP2Bus_ToutSupOut_pin;
  assign ftl_0_IP2Bus_ErrorOut = ftl_0_IP2Bus_ErrorOut_pin;
  assign ftl_0_IP2Bus_RetryOut = ftl_0_IP2Bus_RetryOut_pin;
  assign ftl_0_IP2Bus_DataOut = ftl_0_IP2Bus_DataOut_pin;
  assign ftl_0_Bus2IP_WrReqOut_pin = ftl_0_Bus2IP_WrReqOut;
  assign ftl_0_Bus2IP_RdReqOut_pin = ftl_0_Bus2IP_RdReqOut;
  assign ftl_0_Bus2IP_WrCEOut_pin = ftl_0_Bus2IP_WrCEOut;
  assign ftl_0_Bus2IP_RdCEOut_pin = ftl_0_Bus2IP_RdCEOut;
  assign ftl_0_Bus2IP_CSOut_pin = ftl_0_Bus2IP_CSOut;
  assign ftl_0_Bus2IP_BEOut_pin = ftl_0_Bus2IP_BEOut;
  assign ftl_0_Bus2IP_DataOut_pin = ftl_0_Bus2IP_DataOut;
  assign ftl_0_Bus2IP_AddrOut_pin = ftl_0_Bus2IP_AddrOut;
  assign ftl_0_IP2Bus_IntrEventOut[0:0] = ftl_0_IP2Bus_IntrEventOut_pin[0:0];
  assign ftl_0_Bus2IP_ResetOut_pin = ftl_0_Bus2IP_ResetOut;
  assign ftl_0_Bus2IP_ClkOut_pin = ftl_0_Bus2IP_ClkOut;
  assign ftl_0_M_rdBurstOut = ftl_0_M_rdBurstOut_pin;
  assign ftl_0_M_wrBurstOut = ftl_0_M_wrBurstOut_pin;
  assign ftl_0_M_wrDBusOut = ftl_0_M_wrDBusOut_pin;
  assign ftl_0_M_ABusOut = ftl_0_M_ABusOut_pin;
  assign ftl_0_M_abortOut = ftl_0_M_abortOut_pin;
  assign ftl_0_M_lockErrOut = ftl_0_M_lockErrOut_pin;
  assign ftl_0_M_orderedOut = ftl_0_M_orderedOut_pin;
  assign ftl_0_M_guardedOut = ftl_0_M_guardedOut_pin;
  assign ftl_0_M_compressOut = ftl_0_M_compressOut_pin;
  assign ftl_0_M_typeOut = ftl_0_M_typeOut_pin;
  assign ftl_0_M_sizeOut = ftl_0_M_sizeOut_pin;
  assign ftl_0_M_MSizeOut = ftl_0_M_MSizeOut_pin;
  assign ftl_0_M_BEOut = ftl_0_M_BEOut_pin;
  assign ftl_0_M_RNWOut = ftl_0_M_RNWOut_pin;
  assign ftl_0_M_busLockOut = ftl_0_M_busLockOut_pin;
  assign ftl_0_M_priorityOut = ftl_0_M_priorityOut_pin;
  assign ftl_0_M_requestOut = ftl_0_M_requestOut_pin;
  assign ftl_0_PLB_MWrBTermOut_pin = ftl_0_PLB_MWrBTermOut;
  assign ftl_0_PLB_MRdBTermOut_pin = ftl_0_PLB_MRdBTermOut;
  assign ftl_0_PLB_MRdDAckOut_pin = ftl_0_PLB_MRdDAckOut;
  assign ftl_0_PLB_MRdWdAddrOut_pin = ftl_0_PLB_MRdWdAddrOut;
  assign ftl_0_PLB_MRdDBusOut_pin = ftl_0_PLB_MRdDBusOut;
  assign ftl_0_PLB_MWrDAckOut_pin = ftl_0_PLB_MWrDAckOut;
  assign ftl_0_PLB_MErrOut_pin = ftl_0_PLB_MErrOut;
  assign ftl_0_PLB_MBusyOut_pin = ftl_0_PLB_MBusyOut;
  assign ftl_0_PLB_MRearbitrateOut_pin = ftl_0_PLB_MRearbitrateOut;
  assign ftl_0_PLB_MSSizeOut_pin = ftl_0_PLB_MSSizeOut;
  assign ftl_0_PLB_MAddrAckOut_pin = ftl_0_PLB_MAddrAckOut;
  assign plb_PLB2OPB_rearb[0:0] = 1'b0;
  assign plb_PLB2OPB_rearb[2:2] = 1'b0;
  assign plb_PLB2OPB_rearb[3:3] = 1'b0;
  assign plb_PLB2OPB_rearb[4:4] = 1'b0;
  assign pgassign1[0:0] = 1'b0;
  assign pgassign2[2] = Ethernet_MAC_IP2INTC_Irpt;
  assign pgassign2[1] = SysACE_CompactFlash_SysACE_IRQ;
  assign pgassign2[0] = ftl_0_IP2INTC_Irpt;
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clk[0:2] = pgassign3[0:2];
  assign ddr_clk_feedback_out_s = pgassign3[3];
  assign fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Clkn[0:2] = pgassign4[0:2];
  assign net_gnd0 = 1'b0;
  assign fpga_0_net_gnd_pin = net_gnd0;
  assign fpga_0_net_gnd_1_pin = net_gnd0;
  assign fpga_0_net_gnd_2_pin = net_gnd0;
  assign fpga_0_net_gnd_3_pin = net_gnd0;
  assign fpga_0_net_gnd_4_pin = net_gnd0;
  assign fpga_0_net_gnd_5_pin = net_gnd0;
  assign fpga_0_net_gnd_6_pin = net_gnd0;
  assign net_gnd1[0:0] = 1'b0;
  assign net_gnd10[0:9] = 10'b0000000000;
  assign net_gnd2[0:1] = 2'b00;
  assign net_gnd32[0:31] = 32'b00000000000000000000000000000000;
  assign net_gnd4[0:3] = 4'b0000;
  assign net_gnd64[0:63] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  assign net_gnd7[0:6] = 7'b0000000;
  assign net_gnd8[0:7] = 8'b00000000;
  assign net_vcc0 = 1'b1;
  assign fpga_0_Ethernet_MAC_slew1_pin = net_vcc0;
  assign fpga_0_Ethernet_MAC_slew2_pin = net_vcc0;
  assign net_vcc1[0:0] = 1'b1;
  assign net_vcc2[0:1] = 2'b11;

  sysclk_inv_wrapper
    sysclk_inv (
      .Op1 ( sys_clk_s[0:0] ),
      .Op2 ( net_gnd1[0:0] ),
      .Res ( sys_clk_n_s[0:0] )
    );

  reset_block_wrapper
    reset_block (
      .Slowest_sync_clk ( sys_clk_s[0] ),
      .Ext_Reset_In ( sys_rst_s ),
      .Aux_Reset_In ( net_gnd0 ),
      .Core_Reset_Req ( C405RSTCORERESETREQ ),
      .Chip_Reset_Req ( C405RSTCHIPRESETREQ ),
      .System_Reset_Req ( C405RSTSYSRESETREQ ),
      .Dcm_locked ( dcm_1_lock ),
      .Rstc405resetcore ( RSTC405RESETCORE ),
      .Rstc405resetchip ( RSTC405RESETCHIP ),
      .Rstc405resetsys ( RSTC405RESETSYS ),
      .Bus_Struct_Reset ( sys_bus_reset[0:0] ),
      .Peripheral_Reset (  )
    );

  ppc405_1_wrapper
    ppc405_1 (
      .C405CPMCORESLEEPREQ (  ),
      .C405CPMMSRCE (  ),
      .C405CPMMSREE (  ),
      .C405CPMTIMERIRQ (  ),
      .C405CPMTIMERRESETREQ (  ),
      .C405XXXMACHINECHECK (  ),
      .CPMC405CLOCK ( net_gnd0 ),
      .CPMC405CORECLKINACTIVE ( net_gnd0 ),
      .CPMC405CPUCLKEN ( net_vcc0 ),
      .CPMC405JTAGCLKEN ( net_vcc0 ),
      .CPMC405TIMERCLKEN ( net_vcc0 ),
      .CPMC405TIMERTICK ( net_vcc0 ),
      .MCBCPUCLKEN ( net_vcc0 ),
      .MCBTIMEREN ( net_vcc0 ),
      .MCPPCRST ( net_vcc0 ),
      .PLBCLK ( net_gnd0 ),
      .DCRCLK ( net_gnd0 ),
      .C405RSTCHIPRESETREQ (  ),
      .C405RSTCORERESETREQ (  ),
      .C405RSTSYSRESETREQ (  ),
      .RSTC405RESETCHIP ( net_gnd0 ),
      .RSTC405RESETCORE ( net_gnd0 ),
      .RSTC405RESETSYS ( net_gnd0 ),
      .C405PLBICUABUS (  ),
      .C405PLBICUBE (  ),
      .C405PLBICURNW (  ),
      .C405PLBICUABORT (  ),
      .C405PLBICUBUSLOCK (  ),
      .C405PLBICUU0ATTR (  ),
      .C405PLBICUGUARDED (  ),
      .C405PLBICULOCKERR (  ),
      .C405PLBICUMSIZE (  ),
      .C405PLBICUORDERED (  ),
      .C405PLBICUPRIORITY (  ),
      .C405PLBICURDBURST (  ),
      .C405PLBICUREQUEST (  ),
      .C405PLBICUSIZE (  ),
      .C405PLBICUTYPE (  ),
      .C405PLBICUWRBURST (  ),
      .C405PLBICUWRDBUS (  ),
      .C405PLBICUCACHEABLE (  ),
      .PLBC405ICUADDRACK ( net_gnd0 ),
      .PLBC405ICUBUSY ( net_gnd0 ),
      .PLBC405ICUERR ( net_gnd0 ),
      .PLBC405ICURDBTERM ( net_gnd0 ),
      .PLBC405ICURDDACK ( net_gnd0 ),
      .PLBC405ICURDDBUS ( net_gnd64 ),
      .PLBC405ICURDWDADDR ( net_gnd4 ),
      .PLBC405ICUREARBITRATE ( net_gnd0 ),
      .PLBC405ICUWRBTERM ( net_gnd0 ),
      .PLBC405ICUWRDACK ( net_gnd0 ),
      .PLBC405ICUSSIZE ( net_gnd2 ),
      .PLBC405ICUSERR ( net_gnd0 ),
      .PLBC405ICUSBUSYS ( net_gnd0 ),
      .C405PLBDCUABUS (  ),
      .C405PLBDCUBE (  ),
      .C405PLBDCURNW (  ),
      .C405PLBDCUABORT (  ),
      .C405PLBDCUBUSLOCK (  ),
      .C405PLBDCUU0ATTR (  ),
      .C405PLBDCUGUARDED (  ),
      .C405PLBDCULOCKERR (  ),
      .C405PLBDCUMSIZE (  ),
      .C405PLBDCUORDERED (  ),
      .C405PLBDCUPRIORITY (  ),
      .C405PLBDCURDBURST (  ),
      .C405PLBDCUREQUEST (  ),
      .C405PLBDCUSIZE (  ),
      .C405PLBDCUTYPE (  ),
      .C405PLBDCUWRBURST (  ),
      .C405PLBDCUWRDBUS (  ),
      .C405PLBDCUCACHEABLE (  ),
      .C405PLBDCUWRITETHRU (  ),
      .PLBC405DCUADDRACK ( net_gnd0 ),
      .PLBC405DCUBUSY ( net_gnd0 ),
      .PLBC405DCUERR ( net_gnd0 ),
      .PLBC405DCURDBTERM ( net_gnd0 ),
      .PLBC405DCURDDACK ( net_gnd0 ),
      .PLBC405DCURDDBUS ( net_gnd64 ),
      .PLBC405DCURDWDADDR ( net_gnd4 ),
      .PLBC405DCUREARBITRATE ( net_gnd0 ),
      .PLBC405DCUWRBTERM ( net_gnd0 ),
      .PLBC405DCUWRDACK ( net_gnd0 ),
      .PLBC405DCUSSIZE ( net_gnd2 ),
      .PLBC405DCUSERR ( net_gnd0 ),
      .PLBC405DCUSBUSYS ( net_gnd0 ),
      .BRAMDSOCMCLK ( net_gnd0 ),
      .BRAMDSOCMRDDBUS ( net_gnd32 ),
      .DSARCVALUE ( net_gnd8 ),
      .DSCNTLVALUE ( net_gnd8 ),
      .DSOCMBRAMABUS (  ),
      .DSOCMBRAMBYTEWRITE (  ),
      .DSOCMBRAMEN (  ),
      .DSOCMBRAMWRDBUS (  ),
      .DSOCMBUSY (  ),
      .BRAMISOCMCLK ( net_gnd0 ),
      .BRAMISOCMRDDBUS ( net_gnd64 ),
      .ISARCVALUE ( net_gnd8 ),
      .ISCNTLVALUE ( net_gnd8 ),
      .ISOCMBRAMEN (  ),
      .ISOCMBRAMEVENWRITEEN (  ),
      .ISOCMBRAMODDWRITEEN (  ),
      .ISOCMBRAMRDABUS (  ),
      .ISOCMBRAMWRABUS (  ),
      .ISOCMBRAMWRDBUS (  ),
      .C405DCRABUS (  ),
      .C405DCRDBUSOUT (  ),
      .C405DCRREAD (  ),
      .C405DCRWRITE (  ),
      .DCRC405ACK ( net_gnd0 ),
      .DCRC405DBUSIN ( net_gnd32 ),
      .EICC405CRITINPUTIRQ ( net_gnd0 ),
      .EICC405EXTINPUTIRQ ( net_gnd0 ),
      .C405JTGCAPTUREDR (  ),
      .C405JTGEXTEST (  ),
      .C405JTGPGMOUT (  ),
      .C405JTGSHIFTDR (  ),
      .C405JTGTDO ( jtagppc_0_1_C405JTGTDO ),
      .C405JTGTDOEN ( jtagppc_0_1_C405JTGTDOEN ),
      .C405JTGUPDATEDR (  ),
      .MCBJTAGEN ( net_vcc0 ),
      .JTGC405BNDSCANTDO ( net_gnd0 ),
      .JTGC405TCK ( jtagppc_0_1_JTGC405TCK ),
      .JTGC405TDI ( jtagppc_0_1_JTGC405TDI ),
      .JTGC405TMS ( jtagppc_0_1_JTGC405TMS ),
      .JTGC405TRSTNEG ( jtagppc_0_1_JTGC405TRSTNEG ),
      .C405DBGMSRWE (  ),
      .C405DBGSTOPACK (  ),
      .C405DBGWBCOMPLETE (  ),
      .C405DBGWBFULL (  ),
      .C405DBGWBIAR (  ),
      .DBGC405DEBUGHALT ( net_gnd0 ),
      .DBGC405EXTBUSHOLDACK ( net_gnd0 ),
      .DBGC405UNCONDDEBUGEVENT ( net_gnd0 ),
      .C405TRCCYCLE (  ),
      .C405TRCEVENEXECUTIONSTATUS (  ),
      .C405TRCODDEXECUTIONSTATUS (  ),
      .C405TRCTRACESTATUS (  ),
      .C405TRCTRIGGEREVENTOUT (  ),
      .C405TRCTRIGGEREVENTTYPE (  ),
      .TRCC405TRACEDISABLE ( net_gnd0 ),
      .TRCC405TRIGGEREVENTIN ( net_gnd0 )
    );

  ppc405_0_wrapper
    ppc405_0 (
      .C405CPMCORESLEEPREQ (  ),
      .C405CPMMSRCE (  ),
      .C405CPMMSREE (  ),
      .C405CPMTIMERIRQ (  ),
      .C405CPMTIMERRESETREQ (  ),
      .C405XXXMACHINECHECK (  ),
      .CPMC405CLOCK ( proc_clk_s ),
      .CPMC405CORECLKINACTIVE ( net_gnd0 ),
      .CPMC405CPUCLKEN ( net_vcc0 ),
      .CPMC405JTAGCLKEN ( net_vcc0 ),
      .CPMC405TIMERCLKEN ( net_vcc0 ),
      .CPMC405TIMERTICK ( net_vcc0 ),
      .MCBCPUCLKEN ( net_vcc0 ),
      .MCBTIMEREN ( net_vcc0 ),
      .MCPPCRST ( net_vcc0 ),
      .PLBCLK ( sys_clk_s[0] ),
      .DCRCLK ( net_gnd0 ),
      .C405RSTCHIPRESETREQ ( C405RSTCHIPRESETREQ ),
      .C405RSTCORERESETREQ ( C405RSTCORERESETREQ ),
      .C405RSTSYSRESETREQ ( C405RSTSYSRESETREQ ),
      .RSTC405RESETCHIP ( RSTC405RESETCHIP ),
      .RSTC405RESETCORE ( RSTC405RESETCORE ),
      .RSTC405RESETSYS ( RSTC405RESETSYS ),
      .C405PLBICUABUS ( plb_M_ABus[32:63] ),
      .C405PLBICUBE ( plb_M_BE[8:15] ),
      .C405PLBICURNW ( plb_M_RNW[1] ),
      .C405PLBICUABORT ( plb_M_abort[1] ),
      .C405PLBICUBUSLOCK ( plb_M_busLock[1] ),
      .C405PLBICUU0ATTR ( plb_M_compress[1] ),
      .C405PLBICUGUARDED ( plb_M_guarded[1] ),
      .C405PLBICULOCKERR ( plb_M_lockErr[1] ),
      .C405PLBICUMSIZE ( plb_M_MSize[2:3] ),
      .C405PLBICUORDERED ( plb_M_ordered[1] ),
      .C405PLBICUPRIORITY ( plb_M_priority[2:3] ),
      .C405PLBICURDBURST ( plb_M_rdBurst[1] ),
      .C405PLBICUREQUEST ( plb_M_request[1] ),
      .C405PLBICUSIZE ( plb_M_size[4:7] ),
      .C405PLBICUTYPE ( plb_M_type[3:5] ),
      .C405PLBICUWRBURST ( plb_M_wrBurst[1] ),
      .C405PLBICUWRDBUS ( plb_M_wrDBus[64:127] ),
      .C405PLBICUCACHEABLE (  ),
      .PLBC405ICUADDRACK ( plb_PLB_MAddrAck[1] ),
      .PLBC405ICUBUSY ( plb_PLB_MBusy[1] ),
      .PLBC405ICUERR ( plb_PLB_MErr[1] ),
      .PLBC405ICURDBTERM ( plb_PLB_MRdBTerm[1] ),
      .PLBC405ICURDDACK ( plb_PLB_MRdDAck[1] ),
      .PLBC405ICURDDBUS ( plb_PLB_MRdDBus[64:127] ),
      .PLBC405ICURDWDADDR ( plb_PLB_MRdWdAddr[4:7] ),
      .PLBC405ICUREARBITRATE ( plb_PLB_MRearbitrate[1] ),
      .PLBC405ICUWRBTERM ( plb_PLB_MWrBTerm[1] ),
      .PLBC405ICUWRDACK ( plb_PLB_MWrDAck[1] ),
      .PLBC405ICUSSIZE ( plb_PLB_MSSize[2:3] ),
      .PLBC405ICUSERR ( plb_PLB_SMErr[1] ),
      .PLBC405ICUSBUSYS ( plb_PLB_SMBusy[1] ),
      .C405PLBDCUABUS ( plb_M_ABus[0:31] ),
      .C405PLBDCUBE ( plb_M_BE[0:7] ),
      .C405PLBDCURNW ( plb_M_RNW[0] ),
      .C405PLBDCUABORT ( plb_M_abort[0] ),
      .C405PLBDCUBUSLOCK ( plb_M_busLock[0] ),
      .C405PLBDCUU0ATTR ( plb_M_compress[0] ),
      .C405PLBDCUGUARDED ( plb_M_guarded[0] ),
      .C405PLBDCULOCKERR ( plb_M_lockErr[0] ),
      .C405PLBDCUMSIZE ( plb_M_MSize[0:1] ),
      .C405PLBDCUORDERED ( plb_M_ordered[0] ),
      .C405PLBDCUPRIORITY ( plb_M_priority[0:1] ),
      .C405PLBDCURDBURST ( plb_M_rdBurst[0] ),
      .C405PLBDCUREQUEST ( plb_M_request[0] ),
      .C405PLBDCUSIZE ( plb_M_size[0:3] ),
      .C405PLBDCUTYPE ( plb_M_type[0:2] ),
      .C405PLBDCUWRBURST ( plb_M_wrBurst[0] ),
      .C405PLBDCUWRDBUS ( plb_M_wrDBus[0:63] ),
      .C405PLBDCUCACHEABLE (  ),
      .C405PLBDCUWRITETHRU (  ),
      .PLBC405DCUADDRACK ( plb_PLB_MAddrAck[0] ),
      .PLBC405DCUBUSY ( plb_PLB_MBusy[0] ),
      .PLBC405DCUERR ( plb_PLB_MErr[0] ),
      .PLBC405DCURDBTERM ( plb_PLB_MRdBTerm[0] ),
      .PLBC405DCURDDACK ( plb_PLB_MRdDAck[0] ),
      .PLBC405DCURDDBUS ( plb_PLB_MRdDBus[0:63] ),
      .PLBC405DCURDWDADDR ( plb_PLB_MRdWdAddr[0:3] ),
      .PLBC405DCUREARBITRATE ( plb_PLB_MRearbitrate[0] ),
      .PLBC405DCUWRBTERM ( plb_PLB_MWrBTerm[0] ),
      .PLBC405DCUWRDACK ( plb_PLB_MWrDAck[0] ),
      .PLBC405DCUSSIZE ( plb_PLB_MSSize[0:1] ),
      .PLBC405DCUSERR ( plb_PLB_SMErr[0] ),
      .PLBC405DCUSBUSYS ( plb_PLB_SMBusy[0] ),
      .BRAMDSOCMCLK ( net_gnd0 ),
      .BRAMDSOCMRDDBUS ( net_gnd32 ),
      .DSARCVALUE ( net_gnd8 ),
      .DSCNTLVALUE ( net_gnd8 ),
      .DSOCMBRAMABUS (  ),
      .DSOCMBRAMBYTEWRITE (  ),
      .DSOCMBRAMEN (  ),
      .DSOCMBRAMWRDBUS (  ),
      .DSOCMBUSY (  ),
      .BRAMISOCMCLK ( net_gnd0 ),
      .BRAMISOCMRDDBUS ( net_gnd64 ),
      .ISARCVALUE ( net_gnd8 ),
      .ISCNTLVALUE ( net_gnd8 ),
      .ISOCMBRAMEN (  ),
      .ISOCMBRAMEVENWRITEEN (  ),
      .ISOCMBRAMODDWRITEEN (  ),
      .ISOCMBRAMRDABUS (  ),
      .ISOCMBRAMWRABUS (  ),
      .ISOCMBRAMWRDBUS (  ),
      .C405DCRABUS (  ),
      .C405DCRDBUSOUT (  ),
      .C405DCRREAD (  ),
      .C405DCRWRITE (  ),
      .DCRC405ACK ( net_gnd0 ),
      .DCRC405DBUSIN ( net_gnd32 ),
      .EICC405CRITINPUTIRQ ( net_gnd0 ),
      .EICC405EXTINPUTIRQ ( EICC405EXTINPUTIRQ ),
      .C405JTGCAPTUREDR (  ),
      .C405JTGEXTEST (  ),
      .C405JTGPGMOUT (  ),
      .C405JTGSHIFTDR (  ),
      .C405JTGTDO ( jtagppc_0_0_C405JTGTDO ),
      .C405JTGTDOEN ( jtagppc_0_0_C405JTGTDOEN ),
      .C405JTGUPDATEDR (  ),
      .MCBJTAGEN ( net_vcc0 ),
      .JTGC405BNDSCANTDO ( net_gnd0 ),
      .JTGC405TCK ( jtagppc_0_0_JTGC405TCK ),
      .JTGC405TDI ( jtagppc_0_0_JTGC405TDI ),
      .JTGC405TMS ( jtagppc_0_0_JTGC405TMS ),
      .JTGC405TRSTNEG ( jtagppc_0_0_JTGC405TRSTNEG ),
      .C405DBGMSRWE (  ),
      .C405DBGSTOPACK (  ),
      .C405DBGWBCOMPLETE (  ),
      .C405DBGWBFULL (  ),
      .C405DBGWBIAR (  ),
      .DBGC405DEBUGHALT ( net_gnd0 ),
      .DBGC405EXTBUSHOLDACK ( net_gnd0 ),
      .DBGC405UNCONDDEBUGEVENT ( net_gnd0 ),
      .C405TRCCYCLE (  ),
      .C405TRCEVENEXECUTIONSTATUS (  ),
      .C405TRCODDEXECUTIONSTATUS (  ),
      .C405TRCTRACESTATUS (  ),
      .C405TRCTRIGGEREVENTOUT (  ),
      .C405TRCTRIGGEREVENTTYPE (  ),
      .TRCC405TRACEDISABLE ( net_gnd0 ),
      .TRCC405TRIGGEREVENTIN ( net_gnd0 )
    );

  plb_bram_if_cntlr_1_bram_wrapper
    plb_bram_if_cntlr_1_bram (
      .BRAM_Rst_A ( plb_bram_if_cntlr_1_port_BRAM_Rst ),
      .BRAM_Clk_A ( plb_bram_if_cntlr_1_port_BRAM_Clk ),
      .BRAM_EN_A ( plb_bram_if_cntlr_1_port_BRAM_EN ),
      .BRAM_WEN_A ( plb_bram_if_cntlr_1_port_BRAM_WEN ),
      .BRAM_Addr_A ( plb_bram_if_cntlr_1_port_BRAM_Addr ),
      .BRAM_Din_A ( plb_bram_if_cntlr_1_port_BRAM_Din ),
      .BRAM_Dout_A ( plb_bram_if_cntlr_1_port_BRAM_Dout ),
      .BRAM_Rst_B ( net_gnd0 ),
      .BRAM_Clk_B ( net_gnd0 ),
      .BRAM_EN_B ( net_gnd0 ),
      .BRAM_WEN_B ( net_gnd8 ),
      .BRAM_Addr_B ( net_gnd32 ),
      .BRAM_Din_B (  ),
      .BRAM_Dout_B ( net_gnd64 )
    );

  plb_bram_if_cntlr_1_wrapper
    plb_bram_if_cntlr_1 (
      .plb_clk ( sys_clk_s[0] ),
      .plb_rst ( plb_PLB_Rst ),
      .plb_abort ( plb_PLB_abort ),
      .plb_abus ( plb_PLB_ABus ),
      .plb_be ( plb_PLB_BE ),
      .plb_buslock ( plb_PLB_busLock ),
      .plb_compress ( plb_PLB_compress ),
      .plb_guarded ( plb_PLB_guarded ),
      .plb_lockerr ( plb_PLB_lockErr ),
      .plb_masterid ( plb_PLB_masterID ),
      .plb_msize ( plb_PLB_MSize ),
      .plb_ordered ( plb_PLB_ordered ),
      .plb_pavalid ( plb_PLB_PAValid ),
      .plb_rnw ( plb_PLB_RNW ),
      .plb_size ( plb_PLB_size ),
      .plb_type ( plb_PLB_type ),
      .sl_addrack ( plb_Sl_addrAck[0] ),
      .sl_mbusy ( plb_Sl_MBusy[0:2] ),
      .sl_merr ( plb_Sl_MErr[0:2] ),
      .sl_rearbitrate ( plb_Sl_rearbitrate[0] ),
      .sl_ssize ( plb_Sl_SSize[0:1] ),
      .sl_wait ( plb_Sl_wait[0] ),
      .plb_rdprim ( plb_PLB_rdPrim ),
      .plb_savalid ( plb_PLB_SAValid ),
      .plb_wrprim ( plb_PLB_wrPrim ),
      .plb_wrburst ( plb_PLB_wrBurst ),
      .plb_wrdbus ( plb_PLB_wrDBus ),
      .sl_wrbterm ( plb_Sl_wrBTerm[0] ),
      .sl_wrcomp ( plb_Sl_wrComp[0] ),
      .sl_wrdack ( plb_Sl_wrDAck[0] ),
      .plb_rdburst ( plb_PLB_rdBurst ),
      .sl_rdbterm ( plb_Sl_rdBTerm[0] ),
      .sl_rdcomp ( plb_Sl_rdComp[0] ),
      .sl_rddack ( plb_Sl_rdDAck[0] ),
      .sl_rddbus ( plb_Sl_rdDBus[0:63] ),
      .sl_rdwdaddr ( plb_Sl_rdWdAddr[0:3] ),
      .plb_pendreq ( plb_PLB_pendReq ),
      .plb_pendpri ( plb_PLB_pendPri ),
      .plb_reqpri ( plb_PLB_reqPri ),
      .bram_rst ( plb_bram_if_cntlr_1_port_BRAM_Rst ),
      .bram_clk ( plb_bram_if_cntlr_1_port_BRAM_Clk ),
      .bram_en ( plb_bram_if_cntlr_1_port_BRAM_EN ),
      .bram_wen ( plb_bram_if_cntlr_1_port_BRAM_WEN ),
      .bram_addr ( plb_bram_if_cntlr_1_port_BRAM_Addr ),
      .bram_din ( plb_bram_if_cntlr_1_port_BRAM_Din ),
      .bram_dout ( plb_bram_if_cntlr_1_port_BRAM_Dout )
    );

  ftl_0_wrapper
    ftl_0 (
      .PLB_Clk ( sys_clk_s[0] ),
      .PLB_Rst ( plb_PLB_Rst ),
      .Sl_addrAck ( plb_Sl_addrAck[2] ),
      .Sl_MBusy ( plb_Sl_MBusy[6:8] ),
      .Sl_MErr ( plb_Sl_MErr[6:8] ),
      .Sl_rdBTerm ( plb_Sl_rdBTerm[2] ),
      .Sl_rdComp ( plb_Sl_rdComp[2] ),
      .Sl_rdDAck ( plb_Sl_rdDAck[2] ),
      .Sl_rdDBus ( plb_Sl_rdDBus[128:191] ),
      .Sl_rdWdAddr ( plb_Sl_rdWdAddr[8:11] ),
      .Sl_rearbitrate ( plb_Sl_rearbitrate[2] ),
      .Sl_SSize ( plb_Sl_SSize[4:5] ),
      .Sl_wait ( plb_Sl_wait[2] ),
      .Sl_wrBTerm ( plb_Sl_wrBTerm[2] ),
      .Sl_wrComp ( plb_Sl_wrComp[2] ),
      .Sl_wrDAck ( plb_Sl_wrDAck[2] ),
      .PLB_abort ( plb_PLB_abort ),
      .PLB_ABus ( plb_PLB_ABus ),
      .PLB_BE ( plb_PLB_BE ),
      .PLB_busLock ( plb_PLB_busLock ),
      .PLB_compress ( plb_PLB_compress ),
      .PLB_guarded ( plb_PLB_guarded ),
      .PLB_lockErr ( plb_PLB_lockErr ),
      .PLB_masterID ( plb_PLB_masterID ),
      .PLB_MSize ( plb_PLB_MSize ),
      .PLB_ordered ( plb_PLB_ordered ),
      .PLB_PAValid ( plb_PLB_PAValid ),
      .PLB_pendPri ( plb_PLB_pendPri ),
      .PLB_pendReq ( plb_PLB_pendReq ),
      .PLB_rdBurst ( plb_PLB_rdBurst ),
      .PLB_rdPrim ( plb_PLB_rdPrim ),
      .PLB_reqPri ( plb_PLB_reqPri ),
      .PLB_RNW ( plb_PLB_RNW ),
      .PLB_SAValid ( plb_PLB_SAValid ),
      .PLB_size ( plb_PLB_size ),
      .PLB_type ( plb_PLB_type ),
      .PLB_wrBurst ( plb_PLB_wrBurst ),
      .PLB_wrDBus ( plb_PLB_wrDBus ),
      .PLB_wrPrim ( plb_PLB_wrPrim ),
      .M_abort ( plb_M_abort[2] ),
      .M_ABus ( plb_M_ABus[64:95] ),
      .M_BE ( plb_M_BE[16:23] ),
      .M_busLock ( plb_M_busLock[2] ),
      .M_compress ( plb_M_compress[2] ),
      .M_guarded ( plb_M_guarded[2] ),
      .M_lockErr ( plb_M_lockErr[2] ),
      .M_MSize ( plb_M_MSize[4:5] ),
      .M_ordered ( plb_M_ordered[2] ),
      .M_priority ( plb_M_priority[4:5] ),
      .M_rdBurst ( plb_M_rdBurst[2] ),
      .M_request ( plb_M_request[2] ),
      .M_RNW ( plb_M_RNW[2] ),
      .M_size ( plb_M_size[8:11] ),
      .M_type ( plb_M_type[6:8] ),
      .M_wrBurst ( plb_M_wrBurst[2] ),
      .M_wrDBus ( plb_M_wrDBus[128:191] ),
      .PLB_MBusy ( plb_PLB_MBusy[2] ),
      .PLB_MErr ( plb_PLB_MErr[2] ),
      .PLB_MWrBTerm ( plb_PLB_MWrBTerm[2] ),
      .PLB_MWrDAck ( plb_PLB_MWrDAck[2] ),
      .PLB_MAddrAck ( plb_PLB_MAddrAck[2] ),
      .PLB_MRdBTerm ( plb_PLB_MRdBTerm[2] ),
      .PLB_MRdDAck ( plb_PLB_MRdDAck[2] ),
      .PLB_MRdDBus ( plb_PLB_MRdDBus[128:191] ),
      .PLB_MRdWdAddr ( plb_PLB_MRdWdAddr[8:11] ),
      .PLB_MRearbitrate ( plb_PLB_MRearbitrate[2] ),
      .PLB_MSSize ( plb_PLB_MSSize[4:5] ),
      .IP2INTC_Irpt ( ftl_0_IP2INTC_Irpt ),
      .PLB_MAddrAckOut ( ftl_0_PLB_MAddrAckOut ),
      .PLB_MSSizeOut ( ftl_0_PLB_MSSizeOut ),
      .PLB_MRearbitrateOut ( ftl_0_PLB_MRearbitrateOut ),
      .PLB_MBusyOut ( ftl_0_PLB_MBusyOut ),
      .PLB_MErrOut ( ftl_0_PLB_MErrOut ),
      .PLB_MWrDAckOut ( ftl_0_PLB_MWrDAckOut ),
      .PLB_MRdDBusOut ( ftl_0_PLB_MRdDBusOut ),
      .PLB_MRdWdAddrOut ( ftl_0_PLB_MRdWdAddrOut ),
      .PLB_MRdDAckOut ( ftl_0_PLB_MRdDAckOut ),
      .PLB_MRdBTermOut ( ftl_0_PLB_MRdBTermOut ),
      .PLB_MWrBTermOut ( ftl_0_PLB_MWrBTermOut ),
      .M_requestOut ( ftl_0_M_requestOut ),
      .M_priorityOut ( ftl_0_M_priorityOut ),
      .M_busLockOut ( ftl_0_M_busLockOut ),
      .M_RNWOut ( ftl_0_M_RNWOut ),
      .M_BEOut ( ftl_0_M_BEOut ),
      .M_MSizeOut ( ftl_0_M_MSizeOut ),
      .M_sizeOut ( ftl_0_M_sizeOut ),
      .M_typeOut ( ftl_0_M_typeOut ),
      .M_compressOut ( ftl_0_M_compressOut ),
      .M_guardedOut ( ftl_0_M_guardedOut ),
      .M_orderedOut ( ftl_0_M_orderedOut ),
      .M_lockErrOut ( ftl_0_M_lockErrOut ),
      .M_abortOut ( ftl_0_M_abortOut ),
      .M_ABusOut ( ftl_0_M_ABusOut ),
      .M_wrDBusOut ( ftl_0_M_wrDBusOut ),
      .M_wrBurstOut ( ftl_0_M_wrBurstOut ),
      .M_rdBurstOut ( ftl_0_M_rdBurstOut ),
      .Bus2IP_ClkOut ( ftl_0_Bus2IP_ClkOut ),
      .Bus2IP_ResetOut ( ftl_0_Bus2IP_ResetOut ),
      .IP2Bus_IntrEventOut ( ftl_0_IP2Bus_IntrEventOut[0] ),
      .Bus2IP_AddrOut ( ftl_0_Bus2IP_AddrOut ),
      .Bus2IP_DataOut ( ftl_0_Bus2IP_DataOut ),
      .Bus2IP_BEOut ( ftl_0_Bus2IP_BEOut ),
      .Bus2IP_CSOut ( ftl_0_Bus2IP_CSOut ),
      .Bus2IP_RdCEOut ( ftl_0_Bus2IP_RdCEOut ),
      .Bus2IP_WrCEOut ( ftl_0_Bus2IP_WrCEOut ),
      .Bus2IP_RdReqOut ( ftl_0_Bus2IP_RdReqOut ),
      .Bus2IP_WrReqOut ( ftl_0_Bus2IP_WrReqOut ),
      .IP2Bus_DataOut ( ftl_0_IP2Bus_DataOut ),
      .IP2Bus_RetryOut ( ftl_0_IP2Bus_RetryOut ),
      .IP2Bus_ErrorOut ( ftl_0_IP2Bus_ErrorOut ),
      .IP2Bus_ToutSupOut ( ftl_0_IP2Bus_ToutSupOut ),
      .IP2Bus_RdAckOut ( ftl_0_IP2Bus_RdAckOut ),
      .IP2Bus_WrAckOut ( ftl_0_IP2Bus_WrAckOut )
    );

  plb2opb_wrapper
    plb2opb (
      .PLB_Clk ( sys_clk_s[0] ),
      .OPB_Clk ( sys_clk_s[0] ),
      .PLB_Rst ( plb_PLB_Rst ),
      .OPB_Rst ( opb_OPB_Rst ),
      .Bus_Error_Det (  ),
      .BGI_Trans_Abort (  ),
      .BGO_dcrAck (  ),
      .BGO_dcrDBus (  ),
      .DCR_ABus ( net_gnd10 ),
      .DCR_DBus ( net_gnd32 ),
      .DCR_Read ( net_gnd0 ),
      .DCR_Write ( net_gnd0 ),
      .BGO_addrAck ( plb_Sl_addrAck[1] ),
      .BGO_MErr ( plb_Sl_MErr[3:5] ),
      .BGO_MBusy ( plb_Sl_MBusy[3:5] ),
      .BGO_rdBTerm ( plb_Sl_rdBTerm[1] ),
      .BGO_rdComp ( plb_Sl_rdComp[1] ),
      .BGO_rdDAck ( plb_Sl_rdDAck[1] ),
      .BGO_rdDBus ( plb_Sl_rdDBus[64:127] ),
      .BGO_rdWdAddr ( plb_Sl_rdWdAddr[4:7] ),
      .BGO_rearbitrate ( plb_Sl_rearbitrate[1] ),
      .BGO_SSize ( plb_Sl_SSize[2:3] ),
      .BGO_wait ( plb_Sl_wait[1] ),
      .BGO_wrBTerm ( plb_Sl_wrBTerm[1] ),
      .BGO_wrComp ( plb_Sl_wrComp[1] ),
      .BGO_wrDAck ( plb_Sl_wrDAck[1] ),
      .PLB_abort ( plb_PLB_abort ),
      .PLB_ABus ( plb_PLB_ABus ),
      .PLB_BE ( plb_PLB_BE ),
      .PLB_busLock ( plb_PLB_busLock ),
      .PLB_compress ( plb_PLB_compress ),
      .PLB_guarded ( plb_PLB_guarded ),
      .PLB_lockErr ( plb_PLB_lockErr ),
      .PLB_masterID ( plb_PLB_masterID ),
      .PLB_MSize ( plb_PLB_MSize ),
      .PLB_ordered ( plb_PLB_ordered ),
      .PLB_PAValid ( plb_PLB_PAValid ),
      .PLB_rdBurst ( plb_PLB_rdBurst ),
      .PLB_rdPrim ( plb_PLB_rdPrim ),
      .PLB_RNW ( plb_PLB_RNW ),
      .PLB_SAValid ( plb_PLB_SAValid ),
      .PLB_size ( plb_PLB_size ),
      .PLB_type ( plb_PLB_type ),
      .PLB_wrBurst ( plb_PLB_wrBurst ),
      .PLB_wrDBus ( plb_PLB_wrDBus ),
      .PLB_wrPrim ( plb_PLB_wrPrim ),
      .PLB2OPB_rearb ( plb_PLB2OPB_rearb[1] ),
      .BGO_ABus ( opb_M_ABus ),
      .BGO_BE ( opb_M_BE ),
      .BGO_busLock ( opb_M_busLock[0] ),
      .BGO_DBus ( opb_M_DBus ),
      .BGO_request ( opb_M_request[0] ),
      .BGO_RNW ( opb_M_RNW[0] ),
      .BGO_select ( opb_M_select[0] ),
      .BGO_seqAddr ( opb_M_seqAddr[0] ),
      .OPB_DBus ( opb_OPB_DBus ),
      .OPB_errAck ( opb_OPB_errAck ),
      .OPB_MnGrant ( opb_OPB_MGrant[0] ),
      .OPB_retry ( opb_OPB_retry ),
      .OPB_timeout ( opb_OPB_timeout ),
      .OPB_xferAck ( opb_OPB_xferAck )
    );

  plb_wrapper
    plb (
      .PLB_Clk ( sys_clk_s[0] ),
      .SYS_Rst ( sys_bus_reset[0] ),
      .PLB_Rst ( plb_PLB_Rst ),
      .PLB_dcrAck (  ),
      .PLB_dcrDBus (  ),
      .DCR_ABus ( net_gnd10 ),
      .DCR_DBus ( net_gnd32 ),
      .DCR_Read ( net_gnd0 ),
      .DCR_Write ( net_gnd0 ),
      .M_ABus ( plb_M_ABus ),
      .M_BE ( plb_M_BE ),
      .M_RNW ( plb_M_RNW ),
      .M_abort ( plb_M_abort ),
      .M_busLock ( plb_M_busLock ),
      .M_compress ( plb_M_compress ),
      .M_guarded ( plb_M_guarded ),
      .M_lockErr ( plb_M_lockErr ),
      .M_MSize ( plb_M_MSize ),
      .M_ordered ( plb_M_ordered ),
      .M_priority ( plb_M_priority ),
      .M_rdBurst ( plb_M_rdBurst ),
      .M_request ( plb_M_request ),
      .M_size ( plb_M_size ),
      .M_type ( plb_M_type ),
      .M_wrBurst ( plb_M_wrBurst ),
      .M_wrDBus ( plb_M_wrDBus ),
      .Sl_addrAck ( plb_Sl_addrAck ),
      .Sl_MErr ( plb_Sl_MErr ),
      .Sl_MBusy ( plb_Sl_MBusy ),
      .Sl_rdBTerm ( plb_Sl_rdBTerm ),
      .Sl_rdComp ( plb_Sl_rdComp ),
      .Sl_rdDAck ( plb_Sl_rdDAck ),
      .Sl_rdDBus ( plb_Sl_rdDBus ),
      .Sl_rdWdAddr ( plb_Sl_rdWdAddr ),
      .Sl_rearbitrate ( plb_Sl_rearbitrate ),
      .Sl_SSize ( plb_Sl_SSize ),
      .Sl_wait ( plb_Sl_wait ),
      .Sl_wrBTerm ( plb_Sl_wrBTerm ),
      .Sl_wrComp ( plb_Sl_wrComp ),
      .Sl_wrDAck ( plb_Sl_wrDAck ),
      .PLB_ABus ( plb_PLB_ABus ),
      .PLB_BE ( plb_PLB_BE ),
      .PLB_MAddrAck ( plb_PLB_MAddrAck ),
      .PLB_MBusy ( plb_PLB_MBusy ),
      .PLB_MErr ( plb_PLB_MErr ),
      .PLB_MRdBTerm ( plb_PLB_MRdBTerm ),
      .PLB_MRdDAck ( plb_PLB_MRdDAck ),
      .PLB_MRdDBus ( plb_PLB_MRdDBus ),
      .PLB_MRdWdAddr ( plb_PLB_MRdWdAddr ),
      .PLB_MRearbitrate ( plb_PLB_MRearbitrate ),
      .PLB_MWrBTerm ( plb_PLB_MWrBTerm ),
      .PLB_MWrDAck ( plb_PLB_MWrDAck ),
      .PLB_MSSize ( plb_PLB_MSSize ),
      .PLB_PAValid ( plb_PLB_PAValid ),
      .PLB_RNW ( plb_PLB_RNW ),
      .PLB_SAValid ( plb_PLB_SAValid ),
      .PLB_abort ( plb_PLB_abort ),
      .PLB_busLock ( plb_PLB_busLock ),
      .PLB_compress ( plb_PLB_compress ),
      .PLB_guarded ( plb_PLB_guarded ),
      .PLB_lockErr ( plb_PLB_lockErr ),
      .PLB_masterID ( plb_PLB_masterID ),
      .PLB_MSize ( plb_PLB_MSize ),
      .PLB_ordered ( plb_PLB_ordered ),
      .PLB_pendPri ( plb_PLB_pendPri ),
      .PLB_pendReq ( plb_PLB_pendReq ),
      .PLB_rdBurst ( plb_PLB_rdBurst ),
      .PLB_rdPrim ( plb_PLB_rdPrim ),
      .PLB_reqPri ( plb_PLB_reqPri ),
      .PLB_size ( plb_PLB_size ),
      .PLB_type ( plb_PLB_type ),
      .PLB_wrBurst ( plb_PLB_wrBurst ),
      .PLB_wrDBus ( plb_PLB_wrDBus ),
      .PLB_wrPrim ( plb_PLB_wrPrim ),
      .PLB_SaddrAck (  ),
      .PLB_SMErr ( plb_PLB_SMErr ),
      .PLB_SMBusy ( plb_PLB_SMBusy ),
      .PLB_SrdBTerm (  ),
      .PLB_SrdComp (  ),
      .PLB_SrdDAck (  ),
      .PLB_SrdDBus (  ),
      .PLB_SrdWdAddr (  ),
      .PLB_Srearbitrate (  ),
      .PLB_Sssize (  ),
      .PLB_Swait (  ),
      .PLB_SwrBTerm (  ),
      .PLB_SwrComp (  ),
      .PLB_SwrDAck (  ),
      .PLB2OPB_rearb ( plb_PLB2OPB_rearb ),
      .ArbAddrVldReg (  ),
      .Bus_Error_Det (  )
    );

  opb_intc_0_wrapper
    opb_intc_0 (
      .OPB_Clk ( sys_clk_s[0] ),
      .Intr ( pgassign2 ),
      .OPB_Rst ( opb_OPB_Rst ),
      .OPB_ABus ( opb_OPB_ABus ),
      .OPB_BE ( opb_OPB_BE ),
      .OPB_RNW ( opb_OPB_RNW ),
      .OPB_select ( opb_OPB_select ),
      .OPB_seqAddr ( opb_OPB_seqAddr ),
      .OPB_DBus ( opb_OPB_DBus ),
      .IntC_DBus ( opb_Sl_DBus[0:31] ),
      .IntC_errAck ( opb_Sl_errAck[0] ),
      .IntC_retry ( opb_Sl_retry[0] ),
      .IntC_toutSup ( opb_Sl_toutSup[0] ),
      .IntC_xferAck ( opb_Sl_xferAck[0] ),
      .Irq ( EICC405EXTINPUTIRQ )
    );

  opb_wrapper
    opb (
      .OPB_Clk ( sys_clk_s[0] ),
      .OPB_Rst ( opb_OPB_Rst ),
      .SYS_Rst ( sys_bus_reset[0] ),
      .Debug_SYS_Rst ( net_gnd0 ),
      .WDT_Rst ( net_gnd0 ),
      .M_ABus ( opb_M_ABus ),
      .M_BE ( opb_M_BE ),
      .M_beXfer ( net_gnd1[0:0] ),
      .M_busLock ( opb_M_busLock[0:0] ),
      .M_DBus ( opb_M_DBus ),
      .M_DBusEn ( net_gnd1[0:0] ),
      .M_DBusEn32_63 ( net_vcc1[0:0] ),
      .M_dwXfer ( net_gnd1[0:0] ),
      .M_fwXfer ( net_gnd1[0:0] ),
      .M_hwXfer ( net_gnd1[0:0] ),
      .M_request ( opb_M_request[0:0] ),
      .M_RNW ( opb_M_RNW[0:0] ),
      .M_select ( opb_M_select[0:0] ),
      .M_seqAddr ( opb_M_seqAddr[0:0] ),
      .Sl_beAck ( net_gnd2 ),
      .Sl_DBus ( opb_Sl_DBus ),
      .Sl_DBusEn ( net_vcc2 ),
      .Sl_DBusEn32_63 ( net_vcc2 ),
      .Sl_errAck ( opb_Sl_errAck ),
      .Sl_dwAck ( net_gnd2 ),
      .Sl_fwAck ( net_gnd2 ),
      .Sl_hwAck ( net_gnd2 ),
      .Sl_retry ( opb_Sl_retry ),
      .Sl_toutSup ( opb_Sl_toutSup ),
      .Sl_xferAck ( opb_Sl_xferAck ),
      .OPB_MRequest (  ),
      .OPB_ABus ( opb_OPB_ABus ),
      .OPB_BE ( opb_OPB_BE ),
      .OPB_beXfer (  ),
      .OPB_beAck (  ),
      .OPB_busLock (  ),
      .OPB_rdDBus (  ),
      .OPB_wrDBus (  ),
      .OPB_DBus ( opb_OPB_DBus ),
      .OPB_errAck ( opb_OPB_errAck ),
      .OPB_dwAck (  ),
      .OPB_dwXfer (  ),
      .OPB_fwAck (  ),
      .OPB_fwXfer (  ),
      .OPB_hwAck (  ),
      .OPB_hwXfer (  ),
      .OPB_MGrant ( opb_OPB_MGrant[0:0] ),
      .OPB_pendReq (  ),
      .OPB_retry ( opb_OPB_retry ),
      .OPB_RNW ( opb_OPB_RNW ),
      .OPB_select ( opb_OPB_select ),
      .OPB_seqAddr ( opb_OPB_seqAddr ),
      .OPB_timeout ( opb_OPB_timeout ),
      .OPB_toutSup (  ),
      .OPB_xferAck ( opb_OPB_xferAck )
    );

  jtagppc_0_wrapper
    jtagppc_0 (
      .TRSTNEG ( net_vcc0 ),
      .HALTNEG0 ( net_vcc0 ),
      .DBGC405DEBUGHALT0 (  ),
      .HALTNEG1 ( net_vcc0 ),
      .DBGC405DEBUGHALT1 (  ),
      .C405JTGTDO0 ( jtagppc_0_0_C405JTGTDO ),
      .C405JTGTDOEN0 ( jtagppc_0_0_C405JTGTDOEN ),
      .JTGC405TCK0 ( jtagppc_0_0_JTGC405TCK ),
      .JTGC405TDI0 ( jtagppc_0_0_JTGC405TDI ),
      .JTGC405TMS0 ( jtagppc_0_0_JTGC405TMS ),
      .JTGC405TRSTNEG0 ( jtagppc_0_0_JTGC405TRSTNEG ),
      .C405JTGTDO1 ( jtagppc_0_1_C405JTGTDO ),
      .C405JTGTDOEN1 ( jtagppc_0_1_C405JTGTDOEN ),
      .JTGC405TCK1 ( jtagppc_0_1_JTGC405TCK ),
      .JTGC405TDI1 ( jtagppc_0_1_JTGC405TDI ),
      .JTGC405TMS1 ( jtagppc_0_1_JTGC405TMS ),
      .JTGC405TRSTNEG1 ( jtagppc_0_1_JTGC405TRSTNEG )
    );

  ddr_clk90_inv_wrapper
    ddr_clk90_inv (
      .Op1 ( ddr_clk_90_s[0:0] ),
      .Op2 ( net_gnd1[0:0] ),
      .Res ( ddr_clk_90_n_s[0:0] )
    );

  dcm_1_wrapper
    dcm_1 (
      .RST ( dcm_0_lock ),
      .CLKIN ( ddr_feedback_s ),
      .CLKFB ( dcm_1_FB ),
      .PSEN ( net_gnd0 ),
      .PSINCDEC ( net_gnd0 ),
      .PSCLK ( net_gnd0 ),
      .DSSEN ( net_gnd0 ),
      .CLK0 ( dcm_1_FB ),
      .CLK90 ( ddr_clk_90_s[0] ),
      .CLK180 (  ),
      .CLK270 (  ),
      .CLKDV (  ),
      .CLK2X (  ),
      .CLK2X180 (  ),
      .CLKFX (  ),
      .CLKFX180 (  ),
      .STATUS (  ),
      .LOCKED ( dcm_1_lock ),
      .PSDONE (  )
    );

  dcm_0_wrapper
    dcm_0 (
      .RST ( net_gnd0 ),
      .CLKIN ( dcm_clk_s ),
      .CLKFB ( sys_clk_s[0] ),
      .PSEN ( net_gnd0 ),
      .PSINCDEC ( net_gnd0 ),
      .PSCLK ( net_gnd0 ),
      .DSSEN ( net_gnd0 ),
      .CLK0 ( sys_clk_s[0] ),
      .CLK90 ( clk_90_s[0] ),
      .CLK180 (  ),
      .CLK270 (  ),
      .CLKDV (  ),
      .CLK2X (  ),
      .CLK2X180 (  ),
      .CLKFX ( proc_clk_s ),
      .CLKFX180 (  ),
      .STATUS (  ),
      .LOCKED ( dcm_0_lock ),
      .PSDONE (  )
    );

  clk90_inv_wrapper
    clk90_inv (
      .Op1 ( clk_90_s[0:0] ),
      .Op2 ( net_gnd1[0:0] ),
      .Res ( clk_90_n_s[0:0] )
    );

  sysace_compactflash_wrapper
    SysACE_CompactFlash (
      .OPB_Clk ( sys_clk_s[0] ),
      .OPB_Rst ( opb_OPB_Rst ),
      .OPB_ABus ( opb_OPB_ABus ),
      .OPB_DBus ( opb_OPB_DBus ),
      .Sln_DBus ( opb_Sl_DBus[32:63] ),
      .OPB_select ( opb_OPB_select ),
      .OPB_RNW ( opb_OPB_RNW ),
      .OPB_seqAddr ( opb_OPB_seqAddr ),
      .OPB_BE ( opb_OPB_BE ),
      .Sln_xferAck ( opb_Sl_xferAck[1] ),
      .Sln_errAck ( opb_Sl_errAck[1] ),
      .Sln_toutSup ( opb_Sl_toutSup[1] ),
      .Sln_retry ( opb_Sl_retry[1] ),
      .SysACE_MPA ( fpga_0_SysACE_CompactFlash_SysACE_MPA ),
      .SysACE_CLK ( fpga_0_SysACE_CompactFlash_SysACE_CLK ),
      .SysACE_MPIRQ ( fpga_0_SysACE_CompactFlash_SysACE_MPIRQ ),
      .SysACE_MPD_I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I ),
      .SysACE_MPD_O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O ),
      .SysACE_MPD_T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T ),
      .SysACE_CEN ( fpga_0_SysACE_CompactFlash_SysACE_CEN ),
      .SysACE_OEN ( fpga_0_SysACE_CompactFlash_SysACE_OEN ),
      .SysACE_WEN ( fpga_0_SysACE_CompactFlash_SysACE_WEN ),
      .SysACE_IRQ ( SysACE_CompactFlash_SysACE_IRQ )
    );

  ethernet_mac_wrapper
    Ethernet_MAC (
      .PHY_tx_clk ( fpga_0_Ethernet_MAC_PHY_tx_clk ),
      .PHY_rx_clk ( fpga_0_Ethernet_MAC_PHY_rx_clk ),
      .PHY_crs ( fpga_0_Ethernet_MAC_PHY_crs ),
      .PHY_dv ( fpga_0_Ethernet_MAC_PHY_dv ),
      .PHY_rx_data ( fpga_0_Ethernet_MAC_PHY_rx_data ),
      .PHY_col ( fpga_0_Ethernet_MAC_PHY_col ),
      .PHY_rx_er ( fpga_0_Ethernet_MAC_PHY_rx_er ),
      .PHY_tx_en ( fpga_0_Ethernet_MAC_PHY_tx_en ),
      .PHY_rx_en (  ),
      .PHY_tx_er ( fpga_0_Ethernet_MAC_PHY_tx_er ),
      .PHY_tx_data ( fpga_0_Ethernet_MAC_PHY_tx_data ),
      .PHY_rst_n ( fpga_0_Ethernet_MAC_PHY_rst_n ),
      .PLB_Clk ( sys_clk_s[0] ),
      .PLB_Rst ( plb_PLB_Rst ),
      .Freeze ( net_gnd0 ),
      .IP2INTC_Irpt ( Ethernet_MAC_IP2INTC_Irpt ),
      .PLB_ABus ( plb_PLB_ABus ),
      .PLB_PAValid ( plb_PLB_PAValid ),
      .PLB_SAValid ( plb_PLB_SAValid ),
      .PLB_rdPrim ( plb_PLB_rdPrim ),
      .PLB_wrPrim ( plb_PLB_wrPrim ),
      .PLB_masterID ( plb_PLB_masterID ),
      .PLB_abort ( plb_PLB_abort ),
      .PLB_busLock ( plb_PLB_busLock ),
      .PLB_RNW ( plb_PLB_RNW ),
      .PLB_BE ( plb_PLB_BE ),
      .PLB_MSize ( plb_PLB_MSize ),
      .PLB_size ( plb_PLB_size ),
      .PLB_type ( plb_PLB_type ),
      .PLB_compress ( plb_PLB_compress ),
      .PLB_guarded ( plb_PLB_guarded ),
      .PLB_ordered ( plb_PLB_ordered ),
      .PLB_lockErr ( plb_PLB_lockErr ),
      .PLB_wrDBus ( plb_PLB_wrDBus ),
      .PLB_wrBurst ( plb_PLB_wrBurst ),
      .PLB_rdBurst ( plb_PLB_rdBurst ),
      .PLB_pendReq ( plb_PLB_pendReq ),
      .PLB_pendPri ( plb_PLB_pendPri ),
      .PLB_reqPri ( plb_PLB_reqPri ),
      .Sl_addrAck ( plb_Sl_addrAck[3] ),
      .Sl_SSize ( plb_Sl_SSize[6:7] ),
      .Sl_wait ( plb_Sl_wait[3] ),
      .Sl_rearbitrate ( plb_Sl_rearbitrate[3] ),
      .Sl_wrDAck ( plb_Sl_wrDAck[3] ),
      .Sl_wrComp ( plb_Sl_wrComp[3] ),
      .Sl_wrBTerm ( plb_Sl_wrBTerm[3] ),
      .Sl_rdDBus ( plb_Sl_rdDBus[192:255] ),
      .Sl_rdWdAddr ( plb_Sl_rdWdAddr[12:15] ),
      .Sl_rdDAck ( plb_Sl_rdDAck[3] ),
      .Sl_rdComp ( plb_Sl_rdComp[3] ),
      .Sl_rdBTerm ( plb_Sl_rdBTerm[3] ),
      .Sl_MBusy ( plb_Sl_MBusy[9:11] ),
      .Sl_MErr ( plb_Sl_MErr[9:11] ),
      .PLB_MAddrAck ( net_gnd0 ),
      .PLB_MSSize ( net_gnd2 ),
      .PLB_MRearbitrate ( net_gnd0 ),
      .PLB_MBusy ( net_gnd0 ),
      .PLB_MErr ( net_gnd0 ),
      .PLB_MWrDAck ( net_gnd0 ),
      .PLB_MRdDBus ( net_gnd64 ),
      .PLB_MRdWdAddr ( net_gnd4 ),
      .PLB_MRdDAck ( net_gnd0 ),
      .PLB_MRdBTerm ( net_gnd0 ),
      .PLB_MWrBTerm ( net_gnd0 ),
      .M_request (  ),
      .M_priority (  ),
      .M_buslock (  ),
      .M_RNW (  ),
      .M_BE (  ),
      .M_MSize (  ),
      .M_size (  ),
      .M_type (  ),
      .M_compress (  ),
      .M_guarded (  ),
      .M_ordered (  ),
      .M_lockErr (  ),
      .M_abort (  ),
      .M_ABus (  ),
      .M_wrDBus (  ),
      .M_wrBurst (  ),
      .M_rdBurst (  ),
      .PHY_Mii_clk_I ( fpga_0_Ethernet_MAC_PHY_Mii_clk_I ),
      .PHY_Mii_clk_O ( fpga_0_Ethernet_MAC_PHY_Mii_clk_O ),
      .PHY_Mii_clk_T ( fpga_0_Ethernet_MAC_PHY_Mii_clk_T ),
      .PHY_Mii_data_I ( fpga_0_Ethernet_MAC_PHY_Mii_data_I ),
      .PHY_Mii_data_O ( fpga_0_Ethernet_MAC_PHY_Mii_data_O ),
      .PHY_Mii_data_T ( fpga_0_Ethernet_MAC_PHY_Mii_data_T )
    );

  ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper
    DDR_512MB_64Mx64_rank2_row13_col10_cl2_5 (
      .PLB_Clk ( sys_clk_s[0] ),
      .PLB_Clk_n ( sys_clk_n_s[0] ),
      .Clk90_in ( clk_90_s[0] ),
      .Clk90_in_n ( clk_90_n_s[0] ),
      .DDR_Clk90_in ( ddr_clk_90_s[0] ),
      .DDR_Clk90_in_n ( ddr_clk_90_n_s[0] ),
      .PLB_Rst ( plb_PLB_Rst ),
      .PLB_ABus ( plb_PLB_ABus ),
      .PLB_PAValid ( plb_PLB_PAValid ),
      .PLB_SAValid ( plb_PLB_SAValid ),
      .PLB_rdPrim ( plb_PLB_rdPrim ),
      .PLB_wrPrim ( plb_PLB_wrPrim ),
      .PLB_masterID ( plb_PLB_masterID ),
      .PLB_abort ( plb_PLB_abort ),
      .PLB_busLock ( plb_PLB_busLock ),
      .PLB_RNW ( plb_PLB_RNW ),
      .PLB_BE ( plb_PLB_BE ),
      .PLB_MSize ( plb_PLB_MSize ),
      .PLB_size ( plb_PLB_size ),
      .PLB_type ( plb_PLB_type ),
      .PLB_compress ( plb_PLB_compress ),
      .PLB_guarded ( plb_PLB_guarded ),
      .PLB_ordered ( plb_PLB_ordered ),
      .PLB_lockErr ( plb_PLB_lockErr ),
      .PLB_wrDBus ( plb_PLB_wrDBus ),
      .PLB_wrBurst ( plb_PLB_wrBurst ),
      .PLB_rdBurst ( plb_PLB_rdBurst ),
      .PLB_pendReq ( plb_PLB_pendReq ),
      .PLB_pendPri ( plb_PLB_pendPri ),
      .PLB_reqPri ( plb_PLB_reqPri ),
      .Sl_addrAck ( plb_Sl_addrAck[4] ),
      .Sl_SSize ( plb_Sl_SSize[8:9] ),
      .Sl_wait ( plb_Sl_wait[4] ),
      .Sl_rearbitrate ( plb_Sl_rearbitrate[4] ),
      .Sl_wrDAck ( plb_Sl_wrDAck[4] ),
      .Sl_wrComp ( plb_Sl_wrComp[4] ),
      .Sl_wrBTerm ( plb_Sl_wrBTerm[4] ),
      .Sl_rdDBus ( plb_Sl_rdDBus[256:319] ),
      .Sl_rdWdAddr ( plb_Sl_rdWdAddr[16:19] ),
      .Sl_rdDAck ( plb_Sl_rdDAck[4] ),
      .Sl_rdComp ( plb_Sl_rdComp[4] ),
      .Sl_rdBTerm ( plb_Sl_rdBTerm[4] ),
      .Sl_MBusy ( plb_Sl_MBusy[12:14] ),
      .Sl_MErr ( plb_Sl_MErr[12:14] ),
      .IP2INTC_Irpt (  ),
      .DDR_Clk ( pgassign3 ),
      .DDR_Clkn ( pgassign4 ),
      .DDR_CKE ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CKE ),
      .DDR_CSn ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CSn ),
      .DDR_RASn ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_RASn ),
      .DDR_CASn ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_CASn ),
      .DDR_WEn ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_WEn ),
      .DDR_DM ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DM ),
      .DDR_BankAddr ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_BankAddr ),
      .DDR_Addr ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_Addr ),
      .DDR_DQ_o ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O ),
      .DDR_DQ_i ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I ),
      .DDR_DQ_t ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T ),
      .DDR_DQS_i ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I ),
      .DDR_DQS_o ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O ),
      .DDR_DQS_t ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T ),
      .DDR_DM_ECC (  ),
      .DDR_DQ_ECC_o (  ),
      .DDR_DQ_ECC_i ( net_gnd7 ),
      .DDR_DQ_ECC_t (  ),
      .DDR_DQS_ECC_i ( net_gnd0 ),
      .DDR_DQS_ECC_o (  ),
      .DDR_DQS_ECC_t (  ),
      .DDR_Init_done (  )
    );

  IOBUF
    iobuf_0 (
      .I ( fpga_0_Ethernet_MAC_PHY_Mii_clk_O ),
      .IO ( fpga_0_Ethernet_MAC_PHY_Mii_clk_pin ),
      .O ( fpga_0_Ethernet_MAC_PHY_Mii_clk_I ),
      .T ( fpga_0_Ethernet_MAC_PHY_Mii_clk_T )
    );

  IOBUF
    iobuf_1 (
      .I ( fpga_0_Ethernet_MAC_PHY_Mii_data_O ),
      .IO ( fpga_0_Ethernet_MAC_PHY_Mii_data_pin ),
      .O ( fpga_0_Ethernet_MAC_PHY_Mii_data_I ),
      .T ( fpga_0_Ethernet_MAC_PHY_Mii_data_T )
    );

  IOBUF
    iobuf_2 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[15] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[15] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[15] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[15] )
    );

  IOBUF
    iobuf_3 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[14] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[14] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[14] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[14] )
    );

  IOBUF
    iobuf_4 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[13] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[13] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[13] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[13] )
    );

  IOBUF
    iobuf_5 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[12] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[12] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[12] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[12] )
    );

  IOBUF
    iobuf_6 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[11] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[11] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[11] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[11] )
    );

  IOBUF
    iobuf_7 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[10] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[10] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[10] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[10] )
    );

  IOBUF
    iobuf_8 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[9] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[9] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[9] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[9] )
    );

  IOBUF
    iobuf_9 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[8] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[8] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[8] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[8] )
    );

  IOBUF
    iobuf_10 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[7] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[7] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[7] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[7] )
    );

  IOBUF
    iobuf_11 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[6] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[6] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[6] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[6] )
    );

  IOBUF
    iobuf_12 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[5] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[5] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[5] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[5] )
    );

  IOBUF
    iobuf_13 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[4] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[4] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[4] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[4] )
    );

  IOBUF
    iobuf_14 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[3] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[3] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[3] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[3] )
    );

  IOBUF
    iobuf_15 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[2] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[2] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[2] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[2] )
    );

  IOBUF
    iobuf_16 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[1] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[1] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[1] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[1] )
    );

  IOBUF
    iobuf_17 (
      .I ( fpga_0_SysACE_CompactFlash_SysACE_MPD_O[0] ),
      .IO ( fpga_0_SysACE_CompactFlash_SysACE_MPD_pin[0] ),
      .O ( fpga_0_SysACE_CompactFlash_SysACE_MPD_I[0] ),
      .T ( fpga_0_SysACE_CompactFlash_SysACE_MPD_T[0] )
    );

  IOBUF
    iobuf_18 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[0] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[0] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[0] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[0] )
    );

  IOBUF
    iobuf_19 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[1] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[1] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[1] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[1] )
    );

  IOBUF
    iobuf_20 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[2] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[2] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[2] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[2] )
    );

  IOBUF
    iobuf_21 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[3] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[3] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[3] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[3] )
    );

  IOBUF
    iobuf_22 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[4] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[4] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[4] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[4] )
    );

  IOBUF
    iobuf_23 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[5] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[5] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[5] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[5] )
    );

  IOBUF
    iobuf_24 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[6] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[6] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[6] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[6] )
    );

  IOBUF
    iobuf_25 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_O[7] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_pin[7] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_I[7] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQS_T[7] )
    );

  IOBUF
    iobuf_26 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[0] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[0] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[0] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[0] )
    );

  IOBUF
    iobuf_27 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[1] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[1] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[1] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[1] )
    );

  IOBUF
    iobuf_28 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[2] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[2] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[2] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[2] )
    );

  IOBUF
    iobuf_29 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[3] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[3] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[3] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[3] )
    );

  IOBUF
    iobuf_30 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[4] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[4] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[4] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[4] )
    );

  IOBUF
    iobuf_31 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[5] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[5] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[5] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[5] )
    );

  IOBUF
    iobuf_32 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[6] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[6] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[6] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[6] )
    );

  IOBUF
    iobuf_33 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[7] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[7] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[7] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[7] )
    );

  IOBUF
    iobuf_34 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[8] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[8] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[8] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[8] )
    );

  IOBUF
    iobuf_35 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[9] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[9] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[9] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[9] )
    );

  IOBUF
    iobuf_36 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[10] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[10] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[10] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[10] )
    );

  IOBUF
    iobuf_37 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[11] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[11] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[11] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[11] )
    );

  IOBUF
    iobuf_38 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[12] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[12] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[12] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[12] )
    );

  IOBUF
    iobuf_39 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[13] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[13] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[13] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[13] )
    );

  IOBUF
    iobuf_40 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[14] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[14] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[14] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[14] )
    );

  IOBUF
    iobuf_41 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[15] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[15] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[15] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[15] )
    );

  IOBUF
    iobuf_42 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[16] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[16] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[16] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[16] )
    );

  IOBUF
    iobuf_43 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[17] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[17] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[17] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[17] )
    );

  IOBUF
    iobuf_44 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[18] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[18] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[18] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[18] )
    );

  IOBUF
    iobuf_45 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[19] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[19] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[19] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[19] )
    );

  IOBUF
    iobuf_46 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[20] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[20] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[20] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[20] )
    );

  IOBUF
    iobuf_47 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[21] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[21] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[21] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[21] )
    );

  IOBUF
    iobuf_48 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[22] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[22] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[22] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[22] )
    );

  IOBUF
    iobuf_49 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[23] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[23] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[23] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[23] )
    );

  IOBUF
    iobuf_50 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[24] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[24] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[24] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[24] )
    );

  IOBUF
    iobuf_51 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[25] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[25] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[25] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[25] )
    );

  IOBUF
    iobuf_52 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[26] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[26] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[26] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[26] )
    );

  IOBUF
    iobuf_53 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[27] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[27] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[27] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[27] )
    );

  IOBUF
    iobuf_54 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[28] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[28] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[28] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[28] )
    );

  IOBUF
    iobuf_55 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[29] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[29] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[29] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[29] )
    );

  IOBUF
    iobuf_56 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[30] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[30] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[30] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[30] )
    );

  IOBUF
    iobuf_57 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[31] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[31] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[31] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[31] )
    );

  IOBUF
    iobuf_58 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[32] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[32] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[32] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[32] )
    );

  IOBUF
    iobuf_59 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[33] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[33] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[33] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[33] )
    );

  IOBUF
    iobuf_60 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[34] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[34] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[34] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[34] )
    );

  IOBUF
    iobuf_61 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[35] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[35] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[35] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[35] )
    );

  IOBUF
    iobuf_62 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[36] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[36] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[36] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[36] )
    );

  IOBUF
    iobuf_63 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[37] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[37] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[37] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[37] )
    );

  IOBUF
    iobuf_64 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[38] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[38] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[38] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[38] )
    );

  IOBUF
    iobuf_65 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[39] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[39] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[39] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[39] )
    );

  IOBUF
    iobuf_66 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[40] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[40] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[40] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[40] )
    );

  IOBUF
    iobuf_67 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[41] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[41] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[41] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[41] )
    );

  IOBUF
    iobuf_68 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[42] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[42] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[42] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[42] )
    );

  IOBUF
    iobuf_69 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[43] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[43] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[43] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[43] )
    );

  IOBUF
    iobuf_70 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[44] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[44] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[44] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[44] )
    );

  IOBUF
    iobuf_71 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[45] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[45] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[45] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[45] )
    );

  IOBUF
    iobuf_72 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[46] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[46] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[46] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[46] )
    );

  IOBUF
    iobuf_73 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[47] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[47] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[47] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[47] )
    );

  IOBUF
    iobuf_74 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[48] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[48] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[48] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[48] )
    );

  IOBUF
    iobuf_75 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[49] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[49] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[49] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[49] )
    );

  IOBUF
    iobuf_76 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[50] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[50] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[50] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[50] )
    );

  IOBUF
    iobuf_77 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[51] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[51] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[51] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[51] )
    );

  IOBUF
    iobuf_78 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[52] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[52] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[52] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[52] )
    );

  IOBUF
    iobuf_79 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[53] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[53] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[53] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[53] )
    );

  IOBUF
    iobuf_80 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[54] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[54] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[54] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[54] )
    );

  IOBUF
    iobuf_81 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[55] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[55] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[55] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[55] )
    );

  IOBUF
    iobuf_82 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[56] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[56] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[56] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[56] )
    );

  IOBUF
    iobuf_83 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[57] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[57] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[57] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[57] )
    );

  IOBUF
    iobuf_84 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[58] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[58] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[58] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[58] )
    );

  IOBUF
    iobuf_85 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[59] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[59] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[59] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[59] )
    );

  IOBUF
    iobuf_86 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[60] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[60] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[60] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[60] )
    );

  IOBUF
    iobuf_87 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[61] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[61] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[61] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[61] )
    );

  IOBUF
    iobuf_88 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[62] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[62] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[62] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[62] )
    );

  IOBUF
    iobuf_89 (
      .I ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_O[63] ),
      .IO ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_pin[63] ),
      .O ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_I[63] ),
      .T ( fpga_0_DDR_512MB_64Mx64_rank2_row13_col10_cl2_5_DDR_DQ_T[63] )
    );

endmodule

// synthesis attribute BOX_TYPE of sysclk_inv_wrapper is black_box;
// synthesis attribute BOX_TYPE of reset_block_wrapper is black_box;
// synthesis attribute BOX_TYPE of ppc405_1_wrapper is black_box;
// synthesis attribute BOX_TYPE of ppc405_0_wrapper is black_box;
// synthesis attribute BOX_TYPE of plb_bram_if_cntlr_1_bram_wrapper is black_box;
// synthesis attribute BOX_TYPE of plb_bram_if_cntlr_1_wrapper is black_box;
// synthesis attribute BOX_TYPE of ftl_0_wrapper is black_box;
// synthesis attribute BOX_TYPE of plb2opb_wrapper is black_box;
// synthesis attribute BOX_TYPE of plb_wrapper is black_box;
// synthesis attribute BOX_TYPE of opb_intc_0_wrapper is black_box;
// synthesis attribute BOX_TYPE of opb_wrapper is black_box;
// synthesis attribute BOX_TYPE of jtagppc_0_wrapper is black_box;
// synthesis attribute BOX_TYPE of ddr_clk90_inv_wrapper is black_box;
// synthesis attribute BOX_TYPE of dcm_1_wrapper is black_box;
// synthesis attribute BOX_TYPE of dcm_0_wrapper is black_box;
// synthesis attribute BOX_TYPE of clk90_inv_wrapper is black_box;
// synthesis attribute BOX_TYPE of sysace_compactflash_wrapper is black_box;
// synthesis attribute BOX_TYPE of ethernet_mac_wrapper is black_box;
// synthesis attribute BOX_TYPE of ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper is black_box;

module sysclk_inv_wrapper
  (
    Op1,
    Op2,
    Res
  );
  input [0:0] Op1;
  input [0:0] Op2;
  output [0:0] Res;
endmodule

module reset_block_wrapper
  (
    Slowest_sync_clk,
    Ext_Reset_In,
    Aux_Reset_In,
    Core_Reset_Req,
    Chip_Reset_Req,
    System_Reset_Req,
    Dcm_locked,
    Rstc405resetcore,
    Rstc405resetchip,
    Rstc405resetsys,
    Bus_Struct_Reset,
    Peripheral_Reset
  );
  input Slowest_sync_clk;
  input Ext_Reset_In;
  input Aux_Reset_In;
  input Core_Reset_Req;
  input Chip_Reset_Req;
  input System_Reset_Req;
  input Dcm_locked;
  output Rstc405resetcore;
  output Rstc405resetchip;
  output Rstc405resetsys;
  output [0:0] Bus_Struct_Reset;
  output [0:0] Peripheral_Reset;
endmodule

module ppc405_1_wrapper
  (
    C405CPMCORESLEEPREQ,
    C405CPMMSRCE,
    C405CPMMSREE,
    C405CPMTIMERIRQ,
    C405CPMTIMERRESETREQ,
    C405XXXMACHINECHECK,
    CPMC405CLOCK,
    CPMC405CORECLKINACTIVE,
    CPMC405CPUCLKEN,
    CPMC405JTAGCLKEN,
    CPMC405TIMERCLKEN,
    CPMC405TIMERTICK,
    MCBCPUCLKEN,
    MCBTIMEREN,
    MCPPCRST,
    PLBCLK,
    DCRCLK,
    C405RSTCHIPRESETREQ,
    C405RSTCORERESETREQ,
    C405RSTSYSRESETREQ,
    RSTC405RESETCHIP,
    RSTC405RESETCORE,
    RSTC405RESETSYS,
    C405PLBICUABUS,
    C405PLBICUBE,
    C405PLBICURNW,
    C405PLBICUABORT,
    C405PLBICUBUSLOCK,
    C405PLBICUU0ATTR,
    C405PLBICUGUARDED,
    C405PLBICULOCKERR,
    C405PLBICUMSIZE,
    C405PLBICUORDERED,
    C405PLBICUPRIORITY,
    C405PLBICURDBURST,
    C405PLBICUREQUEST,
    C405PLBICUSIZE,
    C405PLBICUTYPE,
    C405PLBICUWRBURST,
    C405PLBICUWRDBUS,
    C405PLBICUCACHEABLE,
    PLBC405ICUADDRACK,
    PLBC405ICUBUSY,
    PLBC405ICUERR,
    PLBC405ICURDBTERM,
    PLBC405ICURDDACK,
    PLBC405ICURDDBUS,
    PLBC405ICURDWDADDR,
    PLBC405ICUREARBITRATE,
    PLBC405ICUWRBTERM,
    PLBC405ICUWRDACK,
    PLBC405ICUSSIZE,
    PLBC405ICUSERR,
    PLBC405ICUSBUSYS,
    C405PLBDCUABUS,
    C405PLBDCUBE,
    C405PLBDCURNW,
    C405PLBDCUABORT,
    C405PLBDCUBUSLOCK,
    C405PLBDCUU0ATTR,
    C405PLBDCUGUARDED,
    C405PLBDCULOCKERR,
    C405PLBDCUMSIZE,
    C405PLBDCUORDERED,
    C405PLBDCUPRIORITY,
    C405PLBDCURDBURST,
    C405PLBDCUREQUEST,
    C405PLBDCUSIZE,
    C405PLBDCUTYPE,
    C405PLBDCUWRBURST,
    C405PLBDCUWRDBUS,
    C405PLBDCUCACHEABLE,
    C405PLBDCUWRITETHRU,
    PLBC405DCUADDRACK,
    PLBC405DCUBUSY,
    PLBC405DCUERR,
    PLBC405DCURDBTERM,
    PLBC405DCURDDACK,
    PLBC405DCURDDBUS,
    PLBC405DCURDWDADDR,
    PLBC405DCUREARBITRATE,
    PLBC405DCUWRBTERM,
    PLBC405DCUWRDACK,
    PLBC405DCUSSIZE,
    PLBC405DCUSERR,
    PLBC405DCUSBUSYS,
    BRAMDSOCMCLK,
    BRAMDSOCMRDDBUS,
    DSARCVALUE,
    DSCNTLVALUE,
    DSOCMBRAMABUS,
    DSOCMBRAMBYTEWRITE,
    DSOCMBRAMEN,
    DSOCMBRAMWRDBUS,
    DSOCMBUSY,
    BRAMISOCMCLK,
    BRAMISOCMRDDBUS,
    ISARCVALUE,
    ISCNTLVALUE,
    ISOCMBRAMEN,
    ISOCMBRAMEVENWRITEEN,
    ISOCMBRAMODDWRITEEN,
    ISOCMBRAMRDABUS,
    ISOCMBRAMWRABUS,
    ISOCMBRAMWRDBUS,
    C405DCRABUS,
    C405DCRDBUSOUT,
    C405DCRREAD,
    C405DCRWRITE,
    DCRC405ACK,
    DCRC405DBUSIN,
    EICC405CRITINPUTIRQ,
    EICC405EXTINPUTIRQ,
    C405JTGCAPTUREDR,
    C405JTGEXTEST,
    C405JTGPGMOUT,
    C405JTGSHIFTDR,
    C405JTGTDO,
    C405JTGTDOEN,
    C405JTGUPDATEDR,
    MCBJTAGEN,
    JTGC405BNDSCANTDO,
    JTGC405TCK,
    JTGC405TDI,
    JTGC405TMS,
    JTGC405TRSTNEG,
    C405DBGMSRWE,
    C405DBGSTOPACK,
    C405DBGWBCOMPLETE,
    C405DBGWBFULL,
    C405DBGWBIAR,
    DBGC405DEBUGHALT,
    DBGC405EXTBUSHOLDACK,
    DBGC405UNCONDDEBUGEVENT,
    C405TRCCYCLE,
    C405TRCEVENEXECUTIONSTATUS,
    C405TRCODDEXECUTIONSTATUS,
    C405TRCTRACESTATUS,
    C405TRCTRIGGEREVENTOUT,
    C405TRCTRIGGEREVENTTYPE,
    TRCC405TRACEDISABLE,
    TRCC405TRIGGEREVENTIN
  );
  output C405CPMCORESLEEPREQ;
  output C405CPMMSRCE;
  output C405CPMMSREE;
  output C405CPMTIMERIRQ;
  output C405CPMTIMERRESETREQ;
  output C405XXXMACHINECHECK;
  input CPMC405CLOCK;
  input CPMC405CORECLKINACTIVE;
  input CPMC405CPUCLKEN;
  input CPMC405JTAGCLKEN;
  input CPMC405TIMERCLKEN;
  input CPMC405TIMERTICK;
  input MCBCPUCLKEN;
  input MCBTIMEREN;
  input MCPPCRST;
  input PLBCLK;
  input DCRCLK;
  output C405RSTCHIPRESETREQ;
  output C405RSTCORERESETREQ;
  output C405RSTSYSRESETREQ;
  input RSTC405RESETCHIP;
  input RSTC405RESETCORE;
  input RSTC405RESETSYS;
  output [0:31] C405PLBICUABUS;
  output [0:7] C405PLBICUBE;
  output C405PLBICURNW;
  output C405PLBICUABORT;
  output C405PLBICUBUSLOCK;
  output C405PLBICUU0ATTR;
  output C405PLBICUGUARDED;
  output C405PLBICULOCKERR;
  output [0:1] C405PLBICUMSIZE;
  output C405PLBICUORDERED;
  output [0:1] C405PLBICUPRIORITY;
  output C405PLBICURDBURST;
  output C405PLBICUREQUEST;
  output [0:3] C405PLBICUSIZE;
  output [0:2] C405PLBICUTYPE;
  output C405PLBICUWRBURST;
  output [0:63] C405PLBICUWRDBUS;
  output C405PLBICUCACHEABLE;
  input PLBC405ICUADDRACK;
  input PLBC405ICUBUSY;
  input PLBC405ICUERR;
  input PLBC405ICURDBTERM;
  input PLBC405ICURDDACK;
  input [0:63] PLBC405ICURDDBUS;
  input [0:3] PLBC405ICURDWDADDR;
  input PLBC405ICUREARBITRATE;
  input PLBC405ICUWRBTERM;
  input PLBC405ICUWRDACK;
  input [0:1] PLBC405ICUSSIZE;
  input PLBC405ICUSERR;
  input PLBC405ICUSBUSYS;
  output [0:31] C405PLBDCUABUS;
  output [0:7] C405PLBDCUBE;
  output C405PLBDCURNW;
  output C405PLBDCUABORT;
  output C405PLBDCUBUSLOCK;
  output C405PLBDCUU0ATTR;
  output C405PLBDCUGUARDED;
  output C405PLBDCULOCKERR;
  output [0:1] C405PLBDCUMSIZE;
  output C405PLBDCUORDERED;
  output [0:1] C405PLBDCUPRIORITY;
  output C405PLBDCURDBURST;
  output C405PLBDCUREQUEST;
  output [0:3] C405PLBDCUSIZE;
  output [0:2] C405PLBDCUTYPE;
  output C405PLBDCUWRBURST;
  output [0:63] C405PLBDCUWRDBUS;
  output C405PLBDCUCACHEABLE;
  output C405PLBDCUWRITETHRU;
  input PLBC405DCUADDRACK;
  input PLBC405DCUBUSY;
  input PLBC405DCUERR;
  input PLBC405DCURDBTERM;
  input PLBC405DCURDDACK;
  input [0:63] PLBC405DCURDDBUS;
  input [0:3] PLBC405DCURDWDADDR;
  input PLBC405DCUREARBITRATE;
  input PLBC405DCUWRBTERM;
  input PLBC405DCUWRDACK;
  input [0:1] PLBC405DCUSSIZE;
  input PLBC405DCUSERR;
  input PLBC405DCUSBUSYS;
  input BRAMDSOCMCLK;
  input [0:31] BRAMDSOCMRDDBUS;
  input [0:7] DSARCVALUE;
  input [0:7] DSCNTLVALUE;
  output [8:29] DSOCMBRAMABUS;
  output [0:3] DSOCMBRAMBYTEWRITE;
  output DSOCMBRAMEN;
  output [0:31] DSOCMBRAMWRDBUS;
  output DSOCMBUSY;
  input BRAMISOCMCLK;
  input [0:63] BRAMISOCMRDDBUS;
  input [0:7] ISARCVALUE;
  input [0:7] ISCNTLVALUE;
  output ISOCMBRAMEN;
  output ISOCMBRAMEVENWRITEEN;
  output ISOCMBRAMODDWRITEEN;
  output [8:28] ISOCMBRAMRDABUS;
  output [8:28] ISOCMBRAMWRABUS;
  output [0:31] ISOCMBRAMWRDBUS;
  output [0:9] C405DCRABUS;
  output [0:31] C405DCRDBUSOUT;
  output C405DCRREAD;
  output C405DCRWRITE;
  input DCRC405ACK;
  input [0:31] DCRC405DBUSIN;
  input EICC405CRITINPUTIRQ;
  input EICC405EXTINPUTIRQ;
  output C405JTGCAPTUREDR;
  output C405JTGEXTEST;
  output C405JTGPGMOUT;
  output C405JTGSHIFTDR;
  output C405JTGTDO;
  output C405JTGTDOEN;
  output C405JTGUPDATEDR;
  input MCBJTAGEN;
  input JTGC405BNDSCANTDO;
  input JTGC405TCK;
  input JTGC405TDI;
  input JTGC405TMS;
  input JTGC405TRSTNEG;
  output C405DBGMSRWE;
  output C405DBGSTOPACK;
  output C405DBGWBCOMPLETE;
  output C405DBGWBFULL;
  output [0:29] C405DBGWBIAR;
  input DBGC405DEBUGHALT;
  input DBGC405EXTBUSHOLDACK;
  input DBGC405UNCONDDEBUGEVENT;
  output C405TRCCYCLE;
  output [0:1] C405TRCEVENEXECUTIONSTATUS;
  output [0:1] C405TRCODDEXECUTIONSTATUS;
  output [0:3] C405TRCTRACESTATUS;
  output C405TRCTRIGGEREVENTOUT;
  output [0:10] C405TRCTRIGGEREVENTTYPE;
  input TRCC405TRACEDISABLE;
  input TRCC405TRIGGEREVENTIN;
endmodule

module ppc405_0_wrapper
  (
    C405CPMCORESLEEPREQ,
    C405CPMMSRCE,
    C405CPMMSREE,
    C405CPMTIMERIRQ,
    C405CPMTIMERRESETREQ,
    C405XXXMACHINECHECK,
    CPMC405CLOCK,
    CPMC405CORECLKINACTIVE,
    CPMC405CPUCLKEN,
    CPMC405JTAGCLKEN,
    CPMC405TIMERCLKEN,
    CPMC405TIMERTICK,
    MCBCPUCLKEN,
    MCBTIMEREN,
    MCPPCRST,
    PLBCLK,
    DCRCLK,
    C405RSTCHIPRESETREQ,
    C405RSTCORERESETREQ,
    C405RSTSYSRESETREQ,
    RSTC405RESETCHIP,
    RSTC405RESETCORE,
    RSTC405RESETSYS,
    C405PLBICUABUS,
    C405PLBICUBE,
    C405PLBICURNW,
    C405PLBICUABORT,
    C405PLBICUBUSLOCK,
    C405PLBICUU0ATTR,
    C405PLBICUGUARDED,
    C405PLBICULOCKERR,
    C405PLBICUMSIZE,
    C405PLBICUORDERED,
    C405PLBICUPRIORITY,
    C405PLBICURDBURST,
    C405PLBICUREQUEST,
    C405PLBICUSIZE,
    C405PLBICUTYPE,
    C405PLBICUWRBURST,
    C405PLBICUWRDBUS,
    C405PLBICUCACHEABLE,
    PLBC405ICUADDRACK,
    PLBC405ICUBUSY,
    PLBC405ICUERR,
    PLBC405ICURDBTERM,
    PLBC405ICURDDACK,
    PLBC405ICURDDBUS,
    PLBC405ICURDWDADDR,
    PLBC405ICUREARBITRATE,
    PLBC405ICUWRBTERM,
    PLBC405ICUWRDACK,
    PLBC405ICUSSIZE,
    PLBC405ICUSERR,
    PLBC405ICUSBUSYS,
    C405PLBDCUABUS,
    C405PLBDCUBE,
    C405PLBDCURNW,
    C405PLBDCUABORT,
    C405PLBDCUBUSLOCK,
    C405PLBDCUU0ATTR,
    C405PLBDCUGUARDED,
    C405PLBDCULOCKERR,
    C405PLBDCUMSIZE,
    C405PLBDCUORDERED,
    C405PLBDCUPRIORITY,
    C405PLBDCURDBURST,
    C405PLBDCUREQUEST,
    C405PLBDCUSIZE,
    C405PLBDCUTYPE,
    C405PLBDCUWRBURST,
    C405PLBDCUWRDBUS,
    C405PLBDCUCACHEABLE,
    C405PLBDCUWRITETHRU,
    PLBC405DCUADDRACK,
    PLBC405DCUBUSY,
    PLBC405DCUERR,
    PLBC405DCURDBTERM,
    PLBC405DCURDDACK,
    PLBC405DCURDDBUS,
    PLBC405DCURDWDADDR,
    PLBC405DCUREARBITRATE,
    PLBC405DCUWRBTERM,
    PLBC405DCUWRDACK,
    PLBC405DCUSSIZE,
    PLBC405DCUSERR,
    PLBC405DCUSBUSYS,
    BRAMDSOCMCLK,
    BRAMDSOCMRDDBUS,
    DSARCVALUE,
    DSCNTLVALUE,
    DSOCMBRAMABUS,
    DSOCMBRAMBYTEWRITE,
    DSOCMBRAMEN,
    DSOCMBRAMWRDBUS,
    DSOCMBUSY,
    BRAMISOCMCLK,
    BRAMISOCMRDDBUS,
    ISARCVALUE,
    ISCNTLVALUE,
    ISOCMBRAMEN,
    ISOCMBRAMEVENWRITEEN,
    ISOCMBRAMODDWRITEEN,
    ISOCMBRAMRDABUS,
    ISOCMBRAMWRABUS,
    ISOCMBRAMWRDBUS,
    C405DCRABUS,
    C405DCRDBUSOUT,
    C405DCRREAD,
    C405DCRWRITE,
    DCRC405ACK,
    DCRC405DBUSIN,
    EICC405CRITINPUTIRQ,
    EICC405EXTINPUTIRQ,
    C405JTGCAPTUREDR,
    C405JTGEXTEST,
    C405JTGPGMOUT,
    C405JTGSHIFTDR,
    C405JTGTDO,
    C405JTGTDOEN,
    C405JTGUPDATEDR,
    MCBJTAGEN,
    JTGC405BNDSCANTDO,
    JTGC405TCK,
    JTGC405TDI,
    JTGC405TMS,
    JTGC405TRSTNEG,
    C405DBGMSRWE,
    C405DBGSTOPACK,
    C405DBGWBCOMPLETE,
    C405DBGWBFULL,
    C405DBGWBIAR,
    DBGC405DEBUGHALT,
    DBGC405EXTBUSHOLDACK,
    DBGC405UNCONDDEBUGEVENT,
    C405TRCCYCLE,
    C405TRCEVENEXECUTIONSTATUS,
    C405TRCODDEXECUTIONSTATUS,
    C405TRCTRACESTATUS,
    C405TRCTRIGGEREVENTOUT,
    C405TRCTRIGGEREVENTTYPE,
    TRCC405TRACEDISABLE,
    TRCC405TRIGGEREVENTIN
  );
  output C405CPMCORESLEEPREQ;
  output C405CPMMSRCE;
  output C405CPMMSREE;
  output C405CPMTIMERIRQ;
  output C405CPMTIMERRESETREQ;
  output C405XXXMACHINECHECK;
  input CPMC405CLOCK;
  input CPMC405CORECLKINACTIVE;
  input CPMC405CPUCLKEN;
  input CPMC405JTAGCLKEN;
  input CPMC405TIMERCLKEN;
  input CPMC405TIMERTICK;
  input MCBCPUCLKEN;
  input MCBTIMEREN;
  input MCPPCRST;
  input PLBCLK;
  input DCRCLK;
  output C405RSTCHIPRESETREQ;
  output C405RSTCORERESETREQ;
  output C405RSTSYSRESETREQ;
  input RSTC405RESETCHIP;
  input RSTC405RESETCORE;
  input RSTC405RESETSYS;
  output [0:31] C405PLBICUABUS;
  output [0:7] C405PLBICUBE;
  output C405PLBICURNW;
  output C405PLBICUABORT;
  output C405PLBICUBUSLOCK;
  output C405PLBICUU0ATTR;
  output C405PLBICUGUARDED;
  output C405PLBICULOCKERR;
  output [0:1] C405PLBICUMSIZE;
  output C405PLBICUORDERED;
  output [0:1] C405PLBICUPRIORITY;
  output C405PLBICURDBURST;
  output C405PLBICUREQUEST;
  output [0:3] C405PLBICUSIZE;
  output [0:2] C405PLBICUTYPE;
  output C405PLBICUWRBURST;
  output [0:63] C405PLBICUWRDBUS;
  output C405PLBICUCACHEABLE;
  input PLBC405ICUADDRACK;
  input PLBC405ICUBUSY;
  input PLBC405ICUERR;
  input PLBC405ICURDBTERM;
  input PLBC405ICURDDACK;
  input [0:63] PLBC405ICURDDBUS;
  input [0:3] PLBC405ICURDWDADDR;
  input PLBC405ICUREARBITRATE;
  input PLBC405ICUWRBTERM;
  input PLBC405ICUWRDACK;
  input [0:1] PLBC405ICUSSIZE;
  input PLBC405ICUSERR;
  input PLBC405ICUSBUSYS;
  output [0:31] C405PLBDCUABUS;
  output [0:7] C405PLBDCUBE;
  output C405PLBDCURNW;
  output C405PLBDCUABORT;
  output C405PLBDCUBUSLOCK;
  output C405PLBDCUU0ATTR;
  output C405PLBDCUGUARDED;
  output C405PLBDCULOCKERR;
  output [0:1] C405PLBDCUMSIZE;
  output C405PLBDCUORDERED;
  output [0:1] C405PLBDCUPRIORITY;
  output C405PLBDCURDBURST;
  output C405PLBDCUREQUEST;
  output [0:3] C405PLBDCUSIZE;
  output [0:2] C405PLBDCUTYPE;
  output C405PLBDCUWRBURST;
  output [0:63] C405PLBDCUWRDBUS;
  output C405PLBDCUCACHEABLE;
  output C405PLBDCUWRITETHRU;
  input PLBC405DCUADDRACK;
  input PLBC405DCUBUSY;
  input PLBC405DCUERR;
  input PLBC405DCURDBTERM;
  input PLBC405DCURDDACK;
  input [0:63] PLBC405DCURDDBUS;
  input [0:3] PLBC405DCURDWDADDR;
  input PLBC405DCUREARBITRATE;
  input PLBC405DCUWRBTERM;
  input PLBC405DCUWRDACK;
  input [0:1] PLBC405DCUSSIZE;
  input PLBC405DCUSERR;
  input PLBC405DCUSBUSYS;
  input BRAMDSOCMCLK;
  input [0:31] BRAMDSOCMRDDBUS;
  input [0:7] DSARCVALUE;
  input [0:7] DSCNTLVALUE;
  output [8:29] DSOCMBRAMABUS;
  output [0:3] DSOCMBRAMBYTEWRITE;
  output DSOCMBRAMEN;
  output [0:31] DSOCMBRAMWRDBUS;
  output DSOCMBUSY;
  input BRAMISOCMCLK;
  input [0:63] BRAMISOCMRDDBUS;
  input [0:7] ISARCVALUE;
  input [0:7] ISCNTLVALUE;
  output ISOCMBRAMEN;
  output ISOCMBRAMEVENWRITEEN;
  output ISOCMBRAMODDWRITEEN;
  output [8:28] ISOCMBRAMRDABUS;
  output [8:28] ISOCMBRAMWRABUS;
  output [0:31] ISOCMBRAMWRDBUS;
  output [0:9] C405DCRABUS;
  output [0:31] C405DCRDBUSOUT;
  output C405DCRREAD;
  output C405DCRWRITE;
  input DCRC405ACK;
  input [0:31] DCRC405DBUSIN;
  input EICC405CRITINPUTIRQ;
  input EICC405EXTINPUTIRQ;
  output C405JTGCAPTUREDR;
  output C405JTGEXTEST;
  output C405JTGPGMOUT;
  output C405JTGSHIFTDR;
  output C405JTGTDO;
  output C405JTGTDOEN;
  output C405JTGUPDATEDR;
  input MCBJTAGEN;
  input JTGC405BNDSCANTDO;
  input JTGC405TCK;
  input JTGC405TDI;
  input JTGC405TMS;
  input JTGC405TRSTNEG;
  output C405DBGMSRWE;
  output C405DBGSTOPACK;
  output C405DBGWBCOMPLETE;
  output C405DBGWBFULL;
  output [0:29] C405DBGWBIAR;
  input DBGC405DEBUGHALT;
  input DBGC405EXTBUSHOLDACK;
  input DBGC405UNCONDDEBUGEVENT;
  output C405TRCCYCLE;
  output [0:1] C405TRCEVENEXECUTIONSTATUS;
  output [0:1] C405TRCODDEXECUTIONSTATUS;
  output [0:3] C405TRCTRACESTATUS;
  output C405TRCTRIGGEREVENTOUT;
  output [0:10] C405TRCTRIGGEREVENTTYPE;
  input TRCC405TRACEDISABLE;
  input TRCC405TRIGGEREVENTIN;
endmodule

module plb_bram_if_cntlr_1_bram_wrapper
  (
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    BRAM_Rst_B,
    BRAM_Clk_B,
    BRAM_EN_B,
    BRAM_WEN_B,
    BRAM_Addr_B,
    BRAM_Din_B,
    BRAM_Dout_B
  );
  input BRAM_Rst_A;
  input BRAM_Clk_A;
  input BRAM_EN_A;
  input [0:7] BRAM_WEN_A;
  input [0:31] BRAM_Addr_A;
  output [0:63] BRAM_Din_A;
  input [0:63] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:7] BRAM_WEN_B;
  input [0:31] BRAM_Addr_B;
  output [0:63] BRAM_Din_B;
  input [0:63] BRAM_Dout_B;
endmodule

module plb_bram_if_cntlr_1_wrapper
  (
    plb_clk,
    plb_rst,
    plb_abort,
    plb_abus,
    plb_be,
    plb_buslock,
    plb_compress,
    plb_guarded,
    plb_lockerr,
    plb_masterid,
    plb_msize,
    plb_ordered,
    plb_pavalid,
    plb_rnw,
    plb_size,
    plb_type,
    sl_addrack,
    sl_mbusy,
    sl_merr,
    sl_rearbitrate,
    sl_ssize,
    sl_wait,
    plb_rdprim,
    plb_savalid,
    plb_wrprim,
    plb_wrburst,
    plb_wrdbus,
    sl_wrbterm,
    sl_wrcomp,
    sl_wrdack,
    plb_rdburst,
    sl_rdbterm,
    sl_rdcomp,
    sl_rddack,
    sl_rddbus,
    sl_rdwdaddr,
    plb_pendreq,
    plb_pendpri,
    plb_reqpri,
    bram_rst,
    bram_clk,
    bram_en,
    bram_wen,
    bram_addr,
    bram_din,
    bram_dout
  );
  input plb_clk;
  input plb_rst;
  input plb_abort;
  input [0:31] plb_abus;
  input [0:7] plb_be;
  input plb_buslock;
  input plb_compress;
  input plb_guarded;
  input plb_lockerr;
  input [0:1] plb_masterid;
  input [0:1] plb_msize;
  input plb_ordered;
  input plb_pavalid;
  input plb_rnw;
  input [0:3] plb_size;
  input [0:2] plb_type;
  output sl_addrack;
  output [0:2] sl_mbusy;
  output [0:2] sl_merr;
  output sl_rearbitrate;
  output [0:1] sl_ssize;
  output sl_wait;
  input plb_rdprim;
  input plb_savalid;
  input plb_wrprim;
  input plb_wrburst;
  input [0:63] plb_wrdbus;
  output sl_wrbterm;
  output sl_wrcomp;
  output sl_wrdack;
  input plb_rdburst;
  output sl_rdbterm;
  output sl_rdcomp;
  output sl_rddack;
  output [0:63] sl_rddbus;
  output [0:3] sl_rdwdaddr;
  input plb_pendreq;
  input [0:1] plb_pendpri;
  input [0:1] plb_reqpri;
  output bram_rst;
  output bram_clk;
  output bram_en;
  output [0:7] bram_wen;
  output [0:31] bram_addr;
  input [0:63] bram_din;
  output [0:63] bram_dout;
endmodule

module ftl_0_wrapper
  (
    PLB_Clk,
    PLB_Rst,
    Sl_addrAck,
    Sl_MBusy,
    Sl_MErr,
    Sl_rdBTerm,
    Sl_rdComp,
    Sl_rdDAck,
    Sl_rdDBus,
    Sl_rdWdAddr,
    Sl_rearbitrate,
    Sl_SSize,
    Sl_wait,
    Sl_wrBTerm,
    Sl_wrComp,
    Sl_wrDAck,
    PLB_abort,
    PLB_ABus,
    PLB_BE,
    PLB_busLock,
    PLB_compress,
    PLB_guarded,
    PLB_lockErr,
    PLB_masterID,
    PLB_MSize,
    PLB_ordered,
    PLB_PAValid,
    PLB_pendPri,
    PLB_pendReq,
    PLB_rdBurst,
    PLB_rdPrim,
    PLB_reqPri,
    PLB_RNW,
    PLB_SAValid,
    PLB_size,
    PLB_type,
    PLB_wrBurst,
    PLB_wrDBus,
    PLB_wrPrim,
    M_abort,
    M_ABus,
    M_BE,
    M_busLock,
    M_compress,
    M_guarded,
    M_lockErr,
    M_MSize,
    M_ordered,
    M_priority,
    M_rdBurst,
    M_request,
    M_RNW,
    M_size,
    M_type,
    M_wrBurst,
    M_wrDBus,
    PLB_MBusy,
    PLB_MErr,
    PLB_MWrBTerm,
    PLB_MWrDAck,
    PLB_MAddrAck,
    PLB_MRdBTerm,
    PLB_MRdDAck,
    PLB_MRdDBus,
    PLB_MRdWdAddr,
    PLB_MRearbitrate,
    PLB_MSSize,
    IP2INTC_Irpt,
    PLB_MAddrAckOut,
    PLB_MSSizeOut,
    PLB_MRearbitrateOut,
    PLB_MBusyOut,
    PLB_MErrOut,
    PLB_MWrDAckOut,
    PLB_MRdDBusOut,
    PLB_MRdWdAddrOut,
    PLB_MRdDAckOut,
    PLB_MRdBTermOut,
    PLB_MWrBTermOut,
    M_requestOut,
    M_priorityOut,
    M_busLockOut,
    M_RNWOut,
    M_BEOut,
    M_MSizeOut,
    M_sizeOut,
    M_typeOut,
    M_compressOut,
    M_guardedOut,
    M_orderedOut,
    M_lockErrOut,
    M_abortOut,
    M_ABusOut,
    M_wrDBusOut,
    M_wrBurstOut,
    M_rdBurstOut,
    Bus2IP_ClkOut,
    Bus2IP_ResetOut,
    IP2Bus_IntrEventOut,
    Bus2IP_AddrOut,
    Bus2IP_DataOut,
    Bus2IP_BEOut,
    Bus2IP_CSOut,
    Bus2IP_RdCEOut,
    Bus2IP_WrCEOut,
    Bus2IP_RdReqOut,
    Bus2IP_WrReqOut,
    IP2Bus_DataOut,
    IP2Bus_RetryOut,
    IP2Bus_ErrorOut,
    IP2Bus_ToutSupOut,
    IP2Bus_RdAckOut,
    IP2Bus_WrAckOut
  );
  input PLB_Clk;
  input PLB_Rst;
  output Sl_addrAck;
  output [0:2] Sl_MBusy;
  output [0:2] Sl_MErr;
  output Sl_rdBTerm;
  output Sl_rdComp;
  output Sl_rdDAck;
  output [0:63] Sl_rdDBus;
  output [0:3] Sl_rdWdAddr;
  output Sl_rearbitrate;
  output [0:1] Sl_SSize;
  output Sl_wait;
  output Sl_wrBTerm;
  output Sl_wrComp;
  output Sl_wrDAck;
  input PLB_abort;
  input [0:31] PLB_ABus;
  input [0:7] PLB_BE;
  input PLB_busLock;
  input PLB_compress;
  input PLB_guarded;
  input PLB_lockErr;
  input [0:1] PLB_masterID;
  input [0:1] PLB_MSize;
  input PLB_ordered;
  input PLB_PAValid;
  input [0:1] PLB_pendPri;
  input PLB_pendReq;
  input PLB_rdBurst;
  input PLB_rdPrim;
  input [0:1] PLB_reqPri;
  input PLB_RNW;
  input PLB_SAValid;
  input [0:3] PLB_size;
  input [0:2] PLB_type;
  input PLB_wrBurst;
  input [0:63] PLB_wrDBus;
  input PLB_wrPrim;
  output M_abort;
  output [0:31] M_ABus;
  output [0:7] M_BE;
  output M_busLock;
  output M_compress;
  output M_guarded;
  output M_lockErr;
  output [0:1] M_MSize;
  output M_ordered;
  output [0:1] M_priority;
  output M_rdBurst;
  output M_request;
  output M_RNW;
  output [0:3] M_size;
  output [0:2] M_type;
  output M_wrBurst;
  output [0:63] M_wrDBus;
  input PLB_MBusy;
  input PLB_MErr;
  input PLB_MWrBTerm;
  input PLB_MWrDAck;
  input PLB_MAddrAck;
  input PLB_MRdBTerm;
  input PLB_MRdDAck;
  input [0:63] PLB_MRdDBus;
  input [0:3] PLB_MRdWdAddr;
  input PLB_MRearbitrate;
  input [0:1] PLB_MSSize;
  output IP2INTC_Irpt;
  output PLB_MAddrAckOut;
  output [0:1] PLB_MSSizeOut;
  output PLB_MRearbitrateOut;
  output PLB_MBusyOut;
  output PLB_MErrOut;
  output PLB_MWrDAckOut;
  output [0:63] PLB_MRdDBusOut;
  output [0:3] PLB_MRdWdAddrOut;
  output PLB_MRdDAckOut;
  output PLB_MRdBTermOut;
  output PLB_MWrBTermOut;
  input M_requestOut;
  input [0:1] M_priorityOut;
  input M_busLockOut;
  input M_RNWOut;
  input [0:7] M_BEOut;
  input [0:1] M_MSizeOut;
  input [0:3] M_sizeOut;
  input [0:2] M_typeOut;
  input M_compressOut;
  input M_guardedOut;
  input M_orderedOut;
  input M_lockErrOut;
  input M_abortOut;
  input [0:31] M_ABusOut;
  input [0:63] M_wrDBusOut;
  input M_wrBurstOut;
  input M_rdBurstOut;
  output Bus2IP_ClkOut;
  output Bus2IP_ResetOut;
  input IP2Bus_IntrEventOut;
  output [0:31] Bus2IP_AddrOut;
  output [0:63] Bus2IP_DataOut;
  output [0:7] Bus2IP_BEOut;
  output Bus2IP_CSOut;
  output [0:1] Bus2IP_RdCEOut;
  output [0:1] Bus2IP_WrCEOut;
  output Bus2IP_RdReqOut;
  output Bus2IP_WrReqOut;
  input [0:63] IP2Bus_DataOut;
  input IP2Bus_RetryOut;
  input IP2Bus_ErrorOut;
  input IP2Bus_ToutSupOut;
  input IP2Bus_RdAckOut;
  input IP2Bus_WrAckOut;
endmodule

module plb2opb_wrapper
  (
    PLB_Clk,
    OPB_Clk,
    PLB_Rst,
    OPB_Rst,
    Bus_Error_Det,
    BGI_Trans_Abort,
    BGO_dcrAck,
    BGO_dcrDBus,
    DCR_ABus,
    DCR_DBus,
    DCR_Read,
    DCR_Write,
    BGO_addrAck,
    BGO_MErr,
    BGO_MBusy,
    BGO_rdBTerm,
    BGO_rdComp,
    BGO_rdDAck,
    BGO_rdDBus,
    BGO_rdWdAddr,
    BGO_rearbitrate,
    BGO_SSize,
    BGO_wait,
    BGO_wrBTerm,
    BGO_wrComp,
    BGO_wrDAck,
    PLB_abort,
    PLB_ABus,
    PLB_BE,
    PLB_busLock,
    PLB_compress,
    PLB_guarded,
    PLB_lockErr,
    PLB_masterID,
    PLB_MSize,
    PLB_ordered,
    PLB_PAValid,
    PLB_rdBurst,
    PLB_rdPrim,
    PLB_RNW,
    PLB_SAValid,
    PLB_size,
    PLB_type,
    PLB_wrBurst,
    PLB_wrDBus,
    PLB_wrPrim,
    PLB2OPB_rearb,
    BGO_ABus,
    BGO_BE,
    BGO_busLock,
    BGO_DBus,
    BGO_request,
    BGO_RNW,
    BGO_select,
    BGO_seqAddr,
    OPB_DBus,
    OPB_errAck,
    OPB_MnGrant,
    OPB_retry,
    OPB_timeout,
    OPB_xferAck
  );
  input PLB_Clk;
  input OPB_Clk;
  input PLB_Rst;
  input OPB_Rst;
  output Bus_Error_Det;
  output BGI_Trans_Abort;
  output BGO_dcrAck;
  output [0:31] BGO_dcrDBus;
  input [0:9] DCR_ABus;
  input [0:31] DCR_DBus;
  input DCR_Read;
  input DCR_Write;
  output BGO_addrAck;
  output [0:2] BGO_MErr;
  output [0:2] BGO_MBusy;
  output BGO_rdBTerm;
  output BGO_rdComp;
  output BGO_rdDAck;
  output [0:63] BGO_rdDBus;
  output [0:3] BGO_rdWdAddr;
  output BGO_rearbitrate;
  output [0:1] BGO_SSize;
  output BGO_wait;
  output BGO_wrBTerm;
  output BGO_wrComp;
  output BGO_wrDAck;
  input PLB_abort;
  input [0:31] PLB_ABus;
  input [0:7] PLB_BE;
  input PLB_busLock;
  input PLB_compress;
  input PLB_guarded;
  input PLB_lockErr;
  input [0:1] PLB_masterID;
  input [0:1] PLB_MSize;
  input PLB_ordered;
  input PLB_PAValid;
  input PLB_rdBurst;
  input PLB_rdPrim;
  input PLB_RNW;
  input PLB_SAValid;
  input [0:3] PLB_size;
  input [0:2] PLB_type;
  input PLB_wrBurst;
  input [0:63] PLB_wrDBus;
  input PLB_wrPrim;
  output PLB2OPB_rearb;
  output [0:31] BGO_ABus;
  output [0:3] BGO_BE;
  output BGO_busLock;
  output [0:31] BGO_DBus;
  output BGO_request;
  output BGO_RNW;
  output BGO_select;
  output BGO_seqAddr;
  input [0:31] OPB_DBus;
  input OPB_errAck;
  input OPB_MnGrant;
  input OPB_retry;
  input OPB_timeout;
  input OPB_xferAck;
endmodule

module plb_wrapper
  (
    PLB_Clk,
    SYS_Rst,
    PLB_Rst,
    PLB_dcrAck,
    PLB_dcrDBus,
    DCR_ABus,
    DCR_DBus,
    DCR_Read,
    DCR_Write,
    M_ABus,
    M_BE,
    M_RNW,
    M_abort,
    M_busLock,
    M_compress,
    M_guarded,
    M_lockErr,
    M_MSize,
    M_ordered,
    M_priority,
    M_rdBurst,
    M_request,
    M_size,
    M_type,
    M_wrBurst,
    M_wrDBus,
    Sl_addrAck,
    Sl_MErr,
    Sl_MBusy,
    Sl_rdBTerm,
    Sl_rdComp,
    Sl_rdDAck,
    Sl_rdDBus,
    Sl_rdWdAddr,
    Sl_rearbitrate,
    Sl_SSize,
    Sl_wait,
    Sl_wrBTerm,
    Sl_wrComp,
    Sl_wrDAck,
    PLB_ABus,
    PLB_BE,
    PLB_MAddrAck,
    PLB_MBusy,
    PLB_MErr,
    PLB_MRdBTerm,
    PLB_MRdDAck,
    PLB_MRdDBus,
    PLB_MRdWdAddr,
    PLB_MRearbitrate,
    PLB_MWrBTerm,
    PLB_MWrDAck,
    PLB_MSSize,
    PLB_PAValid,
    PLB_RNW,
    PLB_SAValid,
    PLB_abort,
    PLB_busLock,
    PLB_compress,
    PLB_guarded,
    PLB_lockErr,
    PLB_masterID,
    PLB_MSize,
    PLB_ordered,
    PLB_pendPri,
    PLB_pendReq,
    PLB_rdBurst,
    PLB_rdPrim,
    PLB_reqPri,
    PLB_size,
    PLB_type,
    PLB_wrBurst,
    PLB_wrDBus,
    PLB_wrPrim,
    PLB_SaddrAck,
    PLB_SMErr,
    PLB_SMBusy,
    PLB_SrdBTerm,
    PLB_SrdComp,
    PLB_SrdDAck,
    PLB_SrdDBus,
    PLB_SrdWdAddr,
    PLB_Srearbitrate,
    PLB_Sssize,
    PLB_Swait,
    PLB_SwrBTerm,
    PLB_SwrComp,
    PLB_SwrDAck,
    PLB2OPB_rearb,
    ArbAddrVldReg,
    Bus_Error_Det
  );
  input PLB_Clk;
  input SYS_Rst;
  output PLB_Rst;
  output PLB_dcrAck;
  output [0:31] PLB_dcrDBus;
  input [0:9] DCR_ABus;
  input [0:31] DCR_DBus;
  input DCR_Read;
  input DCR_Write;
  input [0:95] M_ABus;
  input [0:23] M_BE;
  input [0:2] M_RNW;
  input [0:2] M_abort;
  input [0:2] M_busLock;
  input [0:2] M_compress;
  input [0:2] M_guarded;
  input [0:2] M_lockErr;
  input [0:5] M_MSize;
  input [0:2] M_ordered;
  input [0:5] M_priority;
  input [0:2] M_rdBurst;
  input [0:2] M_request;
  input [0:11] M_size;
  input [0:8] M_type;
  input [0:2] M_wrBurst;
  input [0:191] M_wrDBus;
  input [0:4] Sl_addrAck;
  input [0:14] Sl_MErr;
  input [0:14] Sl_MBusy;
  input [0:4] Sl_rdBTerm;
  input [0:4] Sl_rdComp;
  input [0:4] Sl_rdDAck;
  input [0:319] Sl_rdDBus;
  input [0:19] Sl_rdWdAddr;
  input [0:4] Sl_rearbitrate;
  input [0:9] Sl_SSize;
  input [0:4] Sl_wait;
  input [0:4] Sl_wrBTerm;
  input [0:4] Sl_wrComp;
  input [0:4] Sl_wrDAck;
  output [0:31] PLB_ABus;
  output [0:7] PLB_BE;
  output [0:2] PLB_MAddrAck;
  output [0:2] PLB_MBusy;
  output [0:2] PLB_MErr;
  output [0:2] PLB_MRdBTerm;
  output [0:2] PLB_MRdDAck;
  output [0:191] PLB_MRdDBus;
  output [0:11] PLB_MRdWdAddr;
  output [0:2] PLB_MRearbitrate;
  output [0:2] PLB_MWrBTerm;
  output [0:2] PLB_MWrDAck;
  output [0:5] PLB_MSSize;
  output PLB_PAValid;
  output PLB_RNW;
  output PLB_SAValid;
  output PLB_abort;
  output PLB_busLock;
  output PLB_compress;
  output PLB_guarded;
  output PLB_lockErr;
  output [0:1] PLB_masterID;
  output [0:1] PLB_MSize;
  output PLB_ordered;
  output [0:1] PLB_pendPri;
  output PLB_pendReq;
  output PLB_rdBurst;
  output PLB_rdPrim;
  output [0:1] PLB_reqPri;
  output [0:3] PLB_size;
  output [0:2] PLB_type;
  output PLB_wrBurst;
  output [0:63] PLB_wrDBus;
  output PLB_wrPrim;
  output PLB_SaddrAck;
  output [0:2] PLB_SMErr;
  output [0:2] PLB_SMBusy;
  output PLB_SrdBTerm;
  output PLB_SrdComp;
  output PLB_SrdDAck;
  output [0:63] PLB_SrdDBus;
  output [0:3] PLB_SrdWdAddr;
  output PLB_Srearbitrate;
  output [0:1] PLB_Sssize;
  output PLB_Swait;
  output PLB_SwrBTerm;
  output PLB_SwrComp;
  output PLB_SwrDAck;
  input [0:4] PLB2OPB_rearb;
  output ArbAddrVldReg;
  output Bus_Error_Det;
endmodule

module opb_intc_0_wrapper
  (
    OPB_Clk,
    Intr,
    OPB_Rst,
    OPB_ABus,
    OPB_BE,
    OPB_RNW,
    OPB_select,
    OPB_seqAddr,
    OPB_DBus,
    IntC_DBus,
    IntC_errAck,
    IntC_retry,
    IntC_toutSup,
    IntC_xferAck,
    Irq
  );
  input OPB_Clk;
  input [2:0] Intr;
  input OPB_Rst;
  input [0:31] OPB_ABus;
  input [0:3] OPB_BE;
  input OPB_RNW;
  input OPB_select;
  input OPB_seqAddr;
  input [0:31] OPB_DBus;
  output [0:31] IntC_DBus;
  output IntC_errAck;
  output IntC_retry;
  output IntC_toutSup;
  output IntC_xferAck;
  output Irq;
endmodule

module opb_wrapper
  (
    OPB_Clk,
    OPB_Rst,
    SYS_Rst,
    Debug_SYS_Rst,
    WDT_Rst,
    M_ABus,
    M_BE,
    M_beXfer,
    M_busLock,
    M_DBus,
    M_DBusEn,
    M_DBusEn32_63,
    M_dwXfer,
    M_fwXfer,
    M_hwXfer,
    M_request,
    M_RNW,
    M_select,
    M_seqAddr,
    Sl_beAck,
    Sl_DBus,
    Sl_DBusEn,
    Sl_DBusEn32_63,
    Sl_errAck,
    Sl_dwAck,
    Sl_fwAck,
    Sl_hwAck,
    Sl_retry,
    Sl_toutSup,
    Sl_xferAck,
    OPB_MRequest,
    OPB_ABus,
    OPB_BE,
    OPB_beXfer,
    OPB_beAck,
    OPB_busLock,
    OPB_rdDBus,
    OPB_wrDBus,
    OPB_DBus,
    OPB_errAck,
    OPB_dwAck,
    OPB_dwXfer,
    OPB_fwAck,
    OPB_fwXfer,
    OPB_hwAck,
    OPB_hwXfer,
    OPB_MGrant,
    OPB_pendReq,
    OPB_retry,
    OPB_RNW,
    OPB_select,
    OPB_seqAddr,
    OPB_timeout,
    OPB_toutSup,
    OPB_xferAck
  );
  input OPB_Clk;
  output OPB_Rst;
  input SYS_Rst;
  input Debug_SYS_Rst;
  input WDT_Rst;
  input [0:31] M_ABus;
  input [0:3] M_BE;
  input [0:0] M_beXfer;
  input [0:0] M_busLock;
  input [0:31] M_DBus;
  input [0:0] M_DBusEn;
  input [0:0] M_DBusEn32_63;
  input [0:0] M_dwXfer;
  input [0:0] M_fwXfer;
  input [0:0] M_hwXfer;
  input [0:0] M_request;
  input [0:0] M_RNW;
  input [0:0] M_select;
  input [0:0] M_seqAddr;
  input [0:1] Sl_beAck;
  input [0:63] Sl_DBus;
  input [0:1] Sl_DBusEn;
  input [0:1] Sl_DBusEn32_63;
  input [0:1] Sl_errAck;
  input [0:1] Sl_dwAck;
  input [0:1] Sl_fwAck;
  input [0:1] Sl_hwAck;
  input [0:1] Sl_retry;
  input [0:1] Sl_toutSup;
  input [0:1] Sl_xferAck;
  output [0:0] OPB_MRequest;
  output [0:31] OPB_ABus;
  output [0:3] OPB_BE;
  output OPB_beXfer;
  output OPB_beAck;
  output OPB_busLock;
  output [0:31] OPB_rdDBus;
  output [0:31] OPB_wrDBus;
  output [0:31] OPB_DBus;
  output OPB_errAck;
  output OPB_dwAck;
  output OPB_dwXfer;
  output OPB_fwAck;
  output OPB_fwXfer;
  output OPB_hwAck;
  output OPB_hwXfer;
  output [0:0] OPB_MGrant;
  output [0:0] OPB_pendReq;
  output OPB_retry;
  output OPB_RNW;
  output OPB_select;
  output OPB_seqAddr;
  output OPB_timeout;
  output OPB_toutSup;
  output OPB_xferAck;
endmodule

module jtagppc_0_wrapper
  (
    TRSTNEG,
    HALTNEG0,
    DBGC405DEBUGHALT0,
    HALTNEG1,
    DBGC405DEBUGHALT1,
    C405JTGTDO0,
    C405JTGTDOEN0,
    JTGC405TCK0,
    JTGC405TDI0,
    JTGC405TMS0,
    JTGC405TRSTNEG0,
    C405JTGTDO1,
    C405JTGTDOEN1,
    JTGC405TCK1,
    JTGC405TDI1,
    JTGC405TMS1,
    JTGC405TRSTNEG1
  );
  input TRSTNEG;
  input HALTNEG0;
  output DBGC405DEBUGHALT0;
  input HALTNEG1;
  output DBGC405DEBUGHALT1;
  input C405JTGTDO0;
  input C405JTGTDOEN0;
  output JTGC405TCK0;
  output JTGC405TDI0;
  output JTGC405TMS0;
  output JTGC405TRSTNEG0;
  input C405JTGTDO1;
  input C405JTGTDOEN1;
  output JTGC405TCK1;
  output JTGC405TDI1;
  output JTGC405TMS1;
  output JTGC405TRSTNEG1;
endmodule

module ddr_clk90_inv_wrapper
  (
    Op1,
    Op2,
    Res
  );
  input [0:0] Op1;
  input [0:0] Op2;
  output [0:0] Res;
endmodule

module dcm_1_wrapper
  (
    RST,
    CLKIN,
    CLKFB,
    PSEN,
    PSINCDEC,
    PSCLK,
    DSSEN,
    CLK0,
    CLK90,
    CLK180,
    CLK270,
    CLKDV,
    CLK2X,
    CLK2X180,
    CLKFX,
    CLKFX180,
    STATUS,
    LOCKED,
    PSDONE
  );
  input RST;
  input CLKIN;
  input CLKFB;
  input PSEN;
  input PSINCDEC;
  input PSCLK;
  input DSSEN;
  output CLK0;
  output CLK90;
  output CLK180;
  output CLK270;
  output CLKDV;
  output CLK2X;
  output CLK2X180;
  output CLKFX;
  output CLKFX180;
  output [7:0] STATUS;
  output LOCKED;
  output PSDONE;
endmodule

module dcm_0_wrapper
  (
    RST,
    CLKIN,
    CLKFB,
    PSEN,
    PSINCDEC,
    PSCLK,
    DSSEN,
    CLK0,
    CLK90,
    CLK180,
    CLK270,
    CLKDV,
    CLK2X,
    CLK2X180,
    CLKFX,
    CLKFX180,
    STATUS,
    LOCKED,
    PSDONE
  );
  input RST;
  input CLKIN;
  input CLKFB;
  input PSEN;
  input PSINCDEC;
  input PSCLK;
  input DSSEN;
  output CLK0;
  output CLK90;
  output CLK180;
  output CLK270;
  output CLKDV;
  output CLK2X;
  output CLK2X180;
  output CLKFX;
  output CLKFX180;
  output [7:0] STATUS;
  output LOCKED;
  output PSDONE;
endmodule

module clk90_inv_wrapper
  (
    Op1,
    Op2,
    Res
  );
  input [0:0] Op1;
  input [0:0] Op2;
  output [0:0] Res;
endmodule

module sysace_compactflash_wrapper
  (
    OPB_Clk,
    OPB_Rst,
    OPB_ABus,
    OPB_DBus,
    Sln_DBus,
    OPB_select,
    OPB_RNW,
    OPB_seqAddr,
    OPB_BE,
    Sln_xferAck,
    Sln_errAck,
    Sln_toutSup,
    Sln_retry,
    SysACE_MPA,
    SysACE_CLK,
    SysACE_MPIRQ,
    SysACE_MPD_I,
    SysACE_MPD_O,
    SysACE_MPD_T,
    SysACE_CEN,
    SysACE_OEN,
    SysACE_WEN,
    SysACE_IRQ
  );
  input OPB_Clk;
  input OPB_Rst;
  input [0:31] OPB_ABus;
  input [0:31] OPB_DBus;
  output [0:31] Sln_DBus;
  input OPB_select;
  input OPB_RNW;
  input OPB_seqAddr;
  input [0:3] OPB_BE;
  output Sln_xferAck;
  output Sln_errAck;
  output Sln_toutSup;
  output Sln_retry;
  output [6:0] SysACE_MPA;
  input SysACE_CLK;
  input SysACE_MPIRQ;
  input [15:0] SysACE_MPD_I;
  output [15:0] SysACE_MPD_O;
  output [15:0] SysACE_MPD_T;
  output SysACE_CEN;
  output SysACE_OEN;
  output SysACE_WEN;
  output SysACE_IRQ;
endmodule

module ethernet_mac_wrapper
  (
    PHY_tx_clk,
    PHY_rx_clk,
    PHY_crs,
    PHY_dv,
    PHY_rx_data,
    PHY_col,
    PHY_rx_er,
    PHY_tx_en,
    PHY_rx_en,
    PHY_tx_er,
    PHY_tx_data,
    PHY_rst_n,
    PLB_Clk,
    PLB_Rst,
    Freeze,
    IP2INTC_Irpt,
    PLB_ABus,
    PLB_PAValid,
    PLB_SAValid,
    PLB_rdPrim,
    PLB_wrPrim,
    PLB_masterID,
    PLB_abort,
    PLB_busLock,
    PLB_RNW,
    PLB_BE,
    PLB_MSize,
    PLB_size,
    PLB_type,
    PLB_compress,
    PLB_guarded,
    PLB_ordered,
    PLB_lockErr,
    PLB_wrDBus,
    PLB_wrBurst,
    PLB_rdBurst,
    PLB_pendReq,
    PLB_pendPri,
    PLB_reqPri,
    Sl_addrAck,
    Sl_SSize,
    Sl_wait,
    Sl_rearbitrate,
    Sl_wrDAck,
    Sl_wrComp,
    Sl_wrBTerm,
    Sl_rdDBus,
    Sl_rdWdAddr,
    Sl_rdDAck,
    Sl_rdComp,
    Sl_rdBTerm,
    Sl_MBusy,
    Sl_MErr,
    PLB_MAddrAck,
    PLB_MSSize,
    PLB_MRearbitrate,
    PLB_MBusy,
    PLB_MErr,
    PLB_MWrDAck,
    PLB_MRdDBus,
    PLB_MRdWdAddr,
    PLB_MRdDAck,
    PLB_MRdBTerm,
    PLB_MWrBTerm,
    M_request,
    M_priority,
    M_buslock,
    M_RNW,
    M_BE,
    M_MSize,
    M_size,
    M_type,
    M_compress,
    M_guarded,
    M_ordered,
    M_lockErr,
    M_abort,
    M_ABus,
    M_wrDBus,
    M_wrBurst,
    M_rdBurst,
    PHY_Mii_clk_I,
    PHY_Mii_clk_O,
    PHY_Mii_clk_T,
    PHY_Mii_data_I,
    PHY_Mii_data_O,
    PHY_Mii_data_T
  );
  input PHY_tx_clk;
  input PHY_rx_clk;
  input PHY_crs;
  input PHY_dv;
  input [3:0] PHY_rx_data;
  input PHY_col;
  input PHY_rx_er;
  output PHY_tx_en;
  output PHY_rx_en;
  output PHY_tx_er;
  output [3:0] PHY_tx_data;
  output PHY_rst_n;
  input PLB_Clk;
  input PLB_Rst;
  input Freeze;
  output IP2INTC_Irpt;
  input [0:31] PLB_ABus;
  input PLB_PAValid;
  input PLB_SAValid;
  input PLB_rdPrim;
  input PLB_wrPrim;
  input [0:1] PLB_masterID;
  input PLB_abort;
  input PLB_busLock;
  input PLB_RNW;
  input [0:7] PLB_BE;
  input [0:1] PLB_MSize;
  input [0:3] PLB_size;
  input [0:2] PLB_type;
  input PLB_compress;
  input PLB_guarded;
  input PLB_ordered;
  input PLB_lockErr;
  input [0:63] PLB_wrDBus;
  input PLB_wrBurst;
  input PLB_rdBurst;
  input PLB_pendReq;
  input [0:1] PLB_pendPri;
  input [0:1] PLB_reqPri;
  output Sl_addrAck;
  output [0:1] Sl_SSize;
  output Sl_wait;
  output Sl_rearbitrate;
  output Sl_wrDAck;
  output Sl_wrComp;
  output Sl_wrBTerm;
  output [0:63] Sl_rdDBus;
  output [0:3] Sl_rdWdAddr;
  output Sl_rdDAck;
  output Sl_rdComp;
  output Sl_rdBTerm;
  output [0:2] Sl_MBusy;
  output [0:2] Sl_MErr;
  input PLB_MAddrAck;
  input [0:1] PLB_MSSize;
  input PLB_MRearbitrate;
  input PLB_MBusy;
  input PLB_MErr;
  input PLB_MWrDAck;
  input [0:63] PLB_MRdDBus;
  input [0:3] PLB_MRdWdAddr;
  input PLB_MRdDAck;
  input PLB_MRdBTerm;
  input PLB_MWrBTerm;
  output M_request;
  output [0:1] M_priority;
  output M_buslock;
  output M_RNW;
  output [0:7] M_BE;
  output [0:1] M_MSize;
  output [0:3] M_size;
  output [0:2] M_type;
  output M_compress;
  output M_guarded;
  output M_ordered;
  output M_lockErr;
  output M_abort;
  output [0:31] M_ABus;
  output [0:63] M_wrDBus;
  output M_wrBurst;
  output M_rdBurst;
  input PHY_Mii_clk_I;
  output PHY_Mii_clk_O;
  output PHY_Mii_clk_T;
  input PHY_Mii_data_I;
  output PHY_Mii_data_O;
  output PHY_Mii_data_T;
endmodule

module ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper
  (
    PLB_Clk,
    PLB_Clk_n,
    Clk90_in,
    Clk90_in_n,
    DDR_Clk90_in,
    DDR_Clk90_in_n,
    PLB_Rst,
    PLB_ABus,
    PLB_PAValid,
    PLB_SAValid,
    PLB_rdPrim,
    PLB_wrPrim,
    PLB_masterID,
    PLB_abort,
    PLB_busLock,
    PLB_RNW,
    PLB_BE,
    PLB_MSize,
    PLB_size,
    PLB_type,
    PLB_compress,
    PLB_guarded,
    PLB_ordered,
    PLB_lockErr,
    PLB_wrDBus,
    PLB_wrBurst,
    PLB_rdBurst,
    PLB_pendReq,
    PLB_pendPri,
    PLB_reqPri,
    Sl_addrAck,
    Sl_SSize,
    Sl_wait,
    Sl_rearbitrate,
    Sl_wrDAck,
    Sl_wrComp,
    Sl_wrBTerm,
    Sl_rdDBus,
    Sl_rdWdAddr,
    Sl_rdDAck,
    Sl_rdComp,
    Sl_rdBTerm,
    Sl_MBusy,
    Sl_MErr,
    IP2INTC_Irpt,
    DDR_Clk,
    DDR_Clkn,
    DDR_CKE,
    DDR_CSn,
    DDR_RASn,
    DDR_CASn,
    DDR_WEn,
    DDR_DM,
    DDR_BankAddr,
    DDR_Addr,
    DDR_DQ_o,
    DDR_DQ_i,
    DDR_DQ_t,
    DDR_DQS_i,
    DDR_DQS_o,
    DDR_DQS_t,
    DDR_DM_ECC,
    DDR_DQ_ECC_o,
    DDR_DQ_ECC_i,
    DDR_DQ_ECC_t,
    DDR_DQS_ECC_i,
    DDR_DQS_ECC_o,
    DDR_DQS_ECC_t,
    DDR_Init_done
  );
  input PLB_Clk;
  input PLB_Clk_n;
  input Clk90_in;
  input Clk90_in_n;
  input DDR_Clk90_in;
  input DDR_Clk90_in_n;
  input PLB_Rst;
  input [0:31] PLB_ABus;
  input PLB_PAValid;
  input PLB_SAValid;
  input PLB_rdPrim;
  input PLB_wrPrim;
  input [0:1] PLB_masterID;
  input PLB_abort;
  input PLB_busLock;
  input PLB_RNW;
  input [0:7] PLB_BE;
  input [0:1] PLB_MSize;
  input [0:3] PLB_size;
  input [0:2] PLB_type;
  input PLB_compress;
  input PLB_guarded;
  input PLB_ordered;
  input PLB_lockErr;
  input [0:63] PLB_wrDBus;
  input PLB_wrBurst;
  input PLB_rdBurst;
  input PLB_pendReq;
  input [0:1] PLB_pendPri;
  input [0:1] PLB_reqPri;
  output Sl_addrAck;
  output [0:1] Sl_SSize;
  output Sl_wait;
  output Sl_rearbitrate;
  output Sl_wrDAck;
  output Sl_wrComp;
  output Sl_wrBTerm;
  output [0:63] Sl_rdDBus;
  output [0:3] Sl_rdWdAddr;
  output Sl_rdDAck;
  output Sl_rdComp;
  output Sl_rdBTerm;
  output [0:2] Sl_MBusy;
  output [0:2] Sl_MErr;
  output IP2INTC_Irpt;
  output [0:3] DDR_Clk;
  output [0:3] DDR_Clkn;
  output [0:1] DDR_CKE;
  output [0:1] DDR_CSn;
  output DDR_RASn;
  output DDR_CASn;
  output DDR_WEn;
  output [0:7] DDR_DM;
  output [0:1] DDR_BankAddr;
  output [0:12] DDR_Addr;
  output [0:63] DDR_DQ_o;
  input [0:63] DDR_DQ_i;
  output [0:63] DDR_DQ_t;
  input [0:7] DDR_DQS_i;
  output [0:7] DDR_DQS_o;
  output [0:7] DDR_DQS_t;
  output DDR_DM_ECC;
  output [0:6] DDR_DQ_ECC_o;
  input [0:6] DDR_DQ_ECC_i;
  output [0:6] DDR_DQ_ECC_t;
  input DDR_DQS_ECC_i;
  output DDR_DQS_ECC_o;
  output DDR_DQS_ECC_t;
  output DDR_Init_done;
endmodule

