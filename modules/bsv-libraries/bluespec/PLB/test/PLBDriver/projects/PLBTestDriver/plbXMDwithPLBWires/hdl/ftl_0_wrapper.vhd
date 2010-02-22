-------------------------------------------------------------------------------
-- ftl_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library ftl_v1_00_a;
use ftl_v1_00_a.all;

entity ftl_0_wrapper is
  port (
    PLB_Clk : in std_logic;
    PLB_Rst : in std_logic;
    Sl_addrAck : out std_logic;
    Sl_MBusy : out std_logic_vector(0 to 2);
    Sl_MErr : out std_logic_vector(0 to 2);
    Sl_rdBTerm : out std_logic;
    Sl_rdComp : out std_logic;
    Sl_rdDAck : out std_logic;
    Sl_rdDBus : out std_logic_vector(0 to 63);
    Sl_rdWdAddr : out std_logic_vector(0 to 3);
    Sl_rearbitrate : out std_logic;
    Sl_SSize : out std_logic_vector(0 to 1);
    Sl_wait : out std_logic;
    Sl_wrBTerm : out std_logic;
    Sl_wrComp : out std_logic;
    Sl_wrDAck : out std_logic;
    PLB_abort : in std_logic;
    PLB_ABus : in std_logic_vector(0 to 31);
    PLB_BE : in std_logic_vector(0 to 7);
    PLB_busLock : in std_logic;
    PLB_compress : in std_logic;
    PLB_guarded : in std_logic;
    PLB_lockErr : in std_logic;
    PLB_masterID : in std_logic_vector(0 to 1);
    PLB_MSize : in std_logic_vector(0 to 1);
    PLB_ordered : in std_logic;
    PLB_PAValid : in std_logic;
    PLB_pendPri : in std_logic_vector(0 to 1);
    PLB_pendReq : in std_logic;
    PLB_rdBurst : in std_logic;
    PLB_rdPrim : in std_logic;
    PLB_reqPri : in std_logic_vector(0 to 1);
    PLB_RNW : in std_logic;
    PLB_SAValid : in std_logic;
    PLB_size : in std_logic_vector(0 to 3);
    PLB_type : in std_logic_vector(0 to 2);
    PLB_wrBurst : in std_logic;
    PLB_wrDBus : in std_logic_vector(0 to 63);
    PLB_wrPrim : in std_logic;
    M_abort : out std_logic;
    M_ABus : out std_logic_vector(0 to 31);
    M_BE : out std_logic_vector(0 to 7);
    M_busLock : out std_logic;
    M_compress : out std_logic;
    M_guarded : out std_logic;
    M_lockErr : out std_logic;
    M_MSize : out std_logic_vector(0 to 1);
    M_ordered : out std_logic;
    M_priority : out std_logic_vector(0 to 1);
    M_rdBurst : out std_logic;
    M_request : out std_logic;
    M_RNW : out std_logic;
    M_size : out std_logic_vector(0 to 3);
    M_type : out std_logic_vector(0 to 2);
    M_wrBurst : out std_logic;
    M_wrDBus : out std_logic_vector(0 to 63);
    PLB_MBusy : in std_logic;
    PLB_MErr : in std_logic;
    PLB_MWrBTerm : in std_logic;
    PLB_MWrDAck : in std_logic;
    PLB_MAddrAck : in std_logic;
    PLB_MRdBTerm : in std_logic;
    PLB_MRdDAck : in std_logic;
    PLB_MRdDBus : in std_logic_vector(0 to 63);
    PLB_MRdWdAddr : in std_logic_vector(0 to 3);
    PLB_MRearbitrate : in std_logic;
    PLB_MSSize : in std_logic_vector(0 to 1);
    IP2INTC_Irpt : out std_logic;
    PLB_MAddrAckOut : out std_logic;
    PLB_MSSizeOut : out std_logic_vector(0 to 1);
    PLB_MRearbitrateOut : out std_logic;
    PLB_MBusyOut : out std_logic;
    PLB_MErrOut : out std_logic;
    PLB_MWrDAckOut : out std_logic;
    PLB_MRdDBusOut : out std_logic_vector(0 to 63);
    PLB_MRdWdAddrOut : out std_logic_vector(0 to 3);
    PLB_MRdDAckOut : out std_logic;
    PLB_MRdBTermOut : out std_logic;
    PLB_MWrBTermOut : out std_logic;
    M_requestOut : in std_logic;
    M_priorityOut : in std_logic_vector(0 to 1);
    M_busLockOut : in std_logic;
    M_RNWOut : in std_logic;
    M_BEOut : in std_logic_vector(0 to 7);
    M_MSizeOut : in std_logic_vector(0 to 1);
    M_sizeOut : in std_logic_vector(0 to 3);
    M_typeOut : in std_logic_vector(0 to 2);
    M_compressOut : in std_logic;
    M_guardedOut : in std_logic;
    M_orderedOut : in std_logic;
    M_lockErrOut : in std_logic;
    M_abortOut : in std_logic;
    M_ABusOut : in std_logic_vector(0 to 31);
    M_wrDBusOut : in std_logic_vector(0 to 63);
    M_wrBurstOut : in std_logic;
    M_rdBurstOut : in std_logic;
    Bus2IP_ClkOut : out std_logic;
    Bus2IP_ResetOut : out std_logic;
    IP2Bus_IntrEventOut : in std_logic;
    Bus2IP_AddrOut : out std_logic_vector(0 to 31);
    Bus2IP_DataOut : out std_logic_vector(0 to 63);
    Bus2IP_BEOut : out std_logic_vector(0 to 7);
    Bus2IP_CSOut : out std_logic;
    Bus2IP_RdCEOut : out std_logic_vector(0 to 1);
    Bus2IP_WrCEOut : out std_logic_vector(0 to 1);
    Bus2IP_RdReqOut : out std_logic;
    Bus2IP_WrReqOut : out std_logic;
    IP2Bus_DataOut : in std_logic_vector(0 to 63);
    IP2Bus_RetryOut : in std_logic;
    IP2Bus_ErrorOut : in std_logic;
    IP2Bus_ToutSupOut : in std_logic;
    IP2Bus_RdAckOut : in std_logic;
    IP2Bus_WrAckOut : in std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of ftl_0_wrapper : entity is "ftl_v1_00_a";

end ftl_0_wrapper;

architecture STRUCTURE of ftl_0_wrapper is

  component ftl is
    generic (
      C_BASEADDR : std_logic_vector;
      C_HIGHADDR : std_logic_vector;
      C_PLB_AWIDTH : INTEGER;
      C_PLB_DWIDTH : INTEGER;
      C_PLB_NUM_MASTERS : INTEGER;
      C_PLB_MID_WIDTH : INTEGER;
      C_USER_ID_CODE : INTEGER;
      C_FAMILY : STRING
    );
    port (
      PLB_Clk : in std_logic;
      PLB_Rst : in std_logic;
      Sl_addrAck : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_MErr : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_rdBTerm : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdDAck : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_PLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rearbitrate : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrDAck : out std_logic;
      PLB_abort : in std_logic;
      PLB_ABus : in std_logic_vector(0 to (C_PLB_AWIDTH-1));
      PLB_BE : in std_logic_vector(0 to ((C_PLB_DWIDTH/8)-1));
      PLB_busLock : in std_logic;
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_PLB_MID_WIDTH-1));
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_ordered : in std_logic;
      PLB_PAValid : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to 1);
      PLB_pendReq : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_RNW : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrBurst : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_wrPrim : in std_logic;
      M_abort : out std_logic;
      M_ABus : out std_logic_vector(0 to (C_PLB_AWIDTH-1));
      M_BE : out std_logic_vector(0 to ((C_PLB_DWIDTH/8)-1));
      M_busLock : out std_logic;
      M_compress : out std_logic;
      M_guarded : out std_logic;
      M_lockErr : out std_logic;
      M_MSize : out std_logic_vector(0 to 1);
      M_ordered : out std_logic;
      M_priority : out std_logic_vector(0 to 1);
      M_rdBurst : out std_logic;
      M_request : out std_logic;
      M_RNW : out std_logic;
      M_size : out std_logic_vector(0 to 3);
      M_type : out std_logic_vector(0 to 2);
      M_wrBurst : out std_logic;
      M_wrDBus : out std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_MBusy : in std_logic;
      PLB_MErr : in std_logic;
      PLB_MWrBTerm : in std_logic;
      PLB_MWrDAck : in std_logic;
      PLB_MAddrAck : in std_logic;
      PLB_MRdBTerm : in std_logic;
      PLB_MRdDAck : in std_logic;
      PLB_MRdDBus : in std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      PLB_MRearbitrate : in std_logic;
      PLB_MSSize : in std_logic_vector(0 to 1);
      IP2INTC_Irpt : out std_logic;
      PLB_MAddrAckOut : out std_logic;
      PLB_MSSizeOut : out std_logic_vector(0 to 1);
      PLB_MRearbitrateOut : out std_logic;
      PLB_MBusyOut : out std_logic;
      PLB_MErrOut : out std_logic;
      PLB_MWrDAckOut : out std_logic;
      PLB_MRdDBusOut : out std_logic_vector(0 to 63);
      PLB_MRdWdAddrOut : out std_logic_vector(0 to 3);
      PLB_MRdDAckOut : out std_logic;
      PLB_MRdBTermOut : out std_logic;
      PLB_MWrBTermOut : out std_logic;
      M_requestOut : in std_logic;
      M_priorityOut : in std_logic_vector(0 to 1);
      M_busLockOut : in std_logic;
      M_RNWOut : in std_logic;
      M_BEOut : in std_logic_vector(0 to 7);
      M_MSizeOut : in std_logic_vector(0 to 1);
      M_sizeOut : in std_logic_vector(0 to 3);
      M_typeOut : in std_logic_vector(0 to 2);
      M_compressOut : in std_logic;
      M_guardedOut : in std_logic;
      M_orderedOut : in std_logic;
      M_lockErrOut : in std_logic;
      M_abortOut : in std_logic;
      M_ABusOut : in std_logic_vector(0 to 31);
      M_wrDBusOut : in std_logic_vector(0 to 63);
      M_wrBurstOut : in std_logic;
      M_rdBurstOut : in std_logic;
      Bus2IP_ClkOut : out std_logic;
      Bus2IP_ResetOut : out std_logic;
      IP2Bus_IntrEventOut : in std_logic;
      Bus2IP_AddrOut : out std_logic_vector(0  to  (C_PLB_AWIDTH-1));
      Bus2IP_DataOut : out std_logic_vector(0  to  (C_PLB_DWIDTH-1));
      Bus2IP_BEOut : out std_logic_vector(0  to  ((C_PLB_DWIDTH/8)-1));
      Bus2IP_CSOut : out std_logic;
      Bus2IP_RdCEOut : out std_logic_vector(0  to  1);
      Bus2IP_WrCEOut : out std_logic_vector(0  to  1);
      Bus2IP_RdReqOut : out std_logic;
      Bus2IP_WrReqOut : out std_logic;
      IP2Bus_DataOut : in std_logic_vector(0  to  (C_PLB_DWIDTH-1));
      IP2Bus_RetryOut : in std_logic;
      IP2Bus_ErrorOut : in std_logic;
      IP2Bus_ToutSupOut : in std_logic;
      IP2Bus_RdAckOut : in std_logic;
      IP2Bus_WrAckOut : in std_logic
    );
  end component;

begin

  ftl_0 : ftl
    generic map (
      C_BASEADDR => X"ffffffff",
      C_HIGHADDR => X"00000000",
      C_PLB_AWIDTH => 32,
      C_PLB_DWIDTH => 64,
      C_PLB_NUM_MASTERS => 3,
      C_PLB_MID_WIDTH => 2,
      C_USER_ID_CODE => 3,
      C_FAMILY => "virtex2p"
    )
    port map (
      PLB_Clk => PLB_Clk,
      PLB_Rst => PLB_Rst,
      Sl_addrAck => Sl_addrAck,
      Sl_MBusy => Sl_MBusy,
      Sl_MErr => Sl_MErr,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_rdComp => Sl_rdComp,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_wrComp => Sl_wrComp,
      Sl_wrDAck => Sl_wrDAck,
      PLB_abort => PLB_abort,
      PLB_ABus => PLB_ABus,
      PLB_BE => PLB_BE,
      PLB_busLock => PLB_busLock,
      PLB_compress => PLB_compress,
      PLB_guarded => PLB_guarded,
      PLB_lockErr => PLB_lockErr,
      PLB_masterID => PLB_masterID,
      PLB_MSize => PLB_MSize,
      PLB_ordered => PLB_ordered,
      PLB_PAValid => PLB_PAValid,
      PLB_pendPri => PLB_pendPri,
      PLB_pendReq => PLB_pendReq,
      PLB_rdBurst => PLB_rdBurst,
      PLB_rdPrim => PLB_rdPrim,
      PLB_reqPri => PLB_reqPri,
      PLB_RNW => PLB_RNW,
      PLB_SAValid => PLB_SAValid,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_wrBurst => PLB_wrBurst,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrPrim => PLB_wrPrim,
      M_abort => M_abort,
      M_ABus => M_ABus,
      M_BE => M_BE,
      M_busLock => M_busLock,
      M_compress => M_compress,
      M_guarded => M_guarded,
      M_lockErr => M_lockErr,
      M_MSize => M_MSize,
      M_ordered => M_ordered,
      M_priority => M_priority,
      M_rdBurst => M_rdBurst,
      M_request => M_request,
      M_RNW => M_RNW,
      M_size => M_size,
      M_type => M_type,
      M_wrBurst => M_wrBurst,
      M_wrDBus => M_wrDBus,
      PLB_MBusy => PLB_MBusy,
      PLB_MErr => PLB_MErr,
      PLB_MWrBTerm => PLB_MWrBTerm,
      PLB_MWrDAck => PLB_MWrDAck,
      PLB_MAddrAck => PLB_MAddrAck,
      PLB_MRdBTerm => PLB_MRdBTerm,
      PLB_MRdDAck => PLB_MRdDAck,
      PLB_MRdDBus => PLB_MRdDBus,
      PLB_MRdWdAddr => PLB_MRdWdAddr,
      PLB_MRearbitrate => PLB_MRearbitrate,
      PLB_MSSize => PLB_MSSize,
      IP2INTC_Irpt => IP2INTC_Irpt,
      PLB_MAddrAckOut => PLB_MAddrAckOut,
      PLB_MSSizeOut => PLB_MSSizeOut,
      PLB_MRearbitrateOut => PLB_MRearbitrateOut,
      PLB_MBusyOut => PLB_MBusyOut,
      PLB_MErrOut => PLB_MErrOut,
      PLB_MWrDAckOut => PLB_MWrDAckOut,
      PLB_MRdDBusOut => PLB_MRdDBusOut,
      PLB_MRdWdAddrOut => PLB_MRdWdAddrOut,
      PLB_MRdDAckOut => PLB_MRdDAckOut,
      PLB_MRdBTermOut => PLB_MRdBTermOut,
      PLB_MWrBTermOut => PLB_MWrBTermOut,
      M_requestOut => M_requestOut,
      M_priorityOut => M_priorityOut,
      M_busLockOut => M_busLockOut,
      M_RNWOut => M_RNWOut,
      M_BEOut => M_BEOut,
      M_MSizeOut => M_MSizeOut,
      M_sizeOut => M_sizeOut,
      M_typeOut => M_typeOut,
      M_compressOut => M_compressOut,
      M_guardedOut => M_guardedOut,
      M_orderedOut => M_orderedOut,
      M_lockErrOut => M_lockErrOut,
      M_abortOut => M_abortOut,
      M_ABusOut => M_ABusOut,
      M_wrDBusOut => M_wrDBusOut,
      M_wrBurstOut => M_wrBurstOut,
      M_rdBurstOut => M_rdBurstOut,
      Bus2IP_ClkOut => Bus2IP_ClkOut,
      Bus2IP_ResetOut => Bus2IP_ResetOut,
      IP2Bus_IntrEventOut => IP2Bus_IntrEventOut,
      Bus2IP_AddrOut => Bus2IP_AddrOut,
      Bus2IP_DataOut => Bus2IP_DataOut,
      Bus2IP_BEOut => Bus2IP_BEOut,
      Bus2IP_CSOut => Bus2IP_CSOut,
      Bus2IP_RdCEOut => Bus2IP_RdCEOut,
      Bus2IP_WrCEOut => Bus2IP_WrCEOut,
      Bus2IP_RdReqOut => Bus2IP_RdReqOut,
      Bus2IP_WrReqOut => Bus2IP_WrReqOut,
      IP2Bus_DataOut => IP2Bus_DataOut,
      IP2Bus_RetryOut => IP2Bus_RetryOut,
      IP2Bus_ErrorOut => IP2Bus_ErrorOut,
      IP2Bus_ToutSupOut => IP2Bus_ToutSupOut,
      IP2Bus_RdAckOut => IP2Bus_RdAckOut,
      IP2Bus_WrAckOut => IP2Bus_WrAckOut
    );

end architecture STRUCTURE;

