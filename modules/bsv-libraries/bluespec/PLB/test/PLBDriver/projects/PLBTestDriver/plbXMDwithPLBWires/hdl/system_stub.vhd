-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    fpga_0_net_gnd_pin : out std_logic;
    fpga_0_net_gnd_1_pin : out std_logic;
    fpga_0_net_gnd_2_pin : out std_logic;
    fpga_0_net_gnd_3_pin : out std_logic;
    fpga_0_net_gnd_4_pin : out std_logic;
    fpga_0_net_gnd_5_pin : out std_logic;
    fpga_0_net_gnd_6_pin : out std_logic;
    sys_clk_pin : in std_logic;
    sys_rst_pin : in std_logic;
    ftl_0_IP2Bus_WrAckOut_pin : in std_logic;
    ftl_0_IP2Bus_RdAckOut_pin : in std_logic;
    ftl_0_IP2Bus_ToutSupOut_pin : in std_logic;
    ftl_0_IP2Bus_ErrorOut_pin : in std_logic;
    ftl_0_IP2Bus_RetryOut_pin : in std_logic;
    ftl_0_IP2Bus_DataOut_pin : in std_logic_vector(0 to 63);
    ftl_0_Bus2IP_WrReqOut_pin : out std_logic;
    ftl_0_Bus2IP_RdReqOut_pin : out std_logic;
    ftl_0_Bus2IP_WrCEOut_pin : out std_logic_vector(0 to 1);
    ftl_0_Bus2IP_RdCEOut_pin : out std_logic_vector(0 to 1);
    ftl_0_Bus2IP_CSOut_pin : out std_logic;
    ftl_0_Bus2IP_BEOut_pin : out std_logic_vector(0 to 7);
    ftl_0_Bus2IP_DataOut_pin : out std_logic_vector(0 to 63);
    ftl_0_Bus2IP_AddrOut_pin : out std_logic_vector(0 to 31);
    ftl_0_IP2Bus_IntrEventOut_pin : in std_logic;
    ftl_0_Bus2IP_ResetOut_pin : out std_logic;
    ftl_0_Bus2IP_ClkOut_pin : out std_logic;
    ftl_0_M_rdBurstOut_pin : in std_logic;
    ftl_0_M_wrBurstOut_pin : in std_logic;
    ftl_0_M_wrDBusOut_pin : in std_logic_vector(0 to 63);
    ftl_0_M_ABusOut_pin : in std_logic_vector(0 to 31);
    ftl_0_M_abortOut_pin : in std_logic;
    ftl_0_M_lockErrOut_pin : in std_logic;
    ftl_0_M_orderedOut_pin : in std_logic;
    ftl_0_M_guardedOut_pin : in std_logic;
    ftl_0_M_compressOut_pin : in std_logic;
    ftl_0_M_typeOut_pin : in std_logic_vector(0 to 2);
    ftl_0_M_sizeOut_pin : in std_logic_vector(0 to 3);
    ftl_0_M_MSizeOut_pin : in std_logic_vector(0 to 1);
    ftl_0_M_BEOut_pin : in std_logic_vector(0 to 7);
    ftl_0_M_RNWOut_pin : in std_logic;
    ftl_0_M_busLockOut_pin : in std_logic;
    ftl_0_M_priorityOut_pin : in std_logic_vector(0 to 1);
    ftl_0_M_requestOut_pin : in std_logic;
    ftl_0_PLB_MWrBTermOut_pin : out std_logic;
    ftl_0_PLB_MRdBTermOut_pin : out std_logic;
    ftl_0_PLB_MRdDAckOut_pin : out std_logic;
    ftl_0_PLB_MRdWdAddrOut_pin : out std_logic_vector(0 to 3);
    ftl_0_PLB_MRdDBusOut_pin : out std_logic_vector(0 to 63);
    ftl_0_PLB_MWrDAckOut_pin : out std_logic;
    ftl_0_PLB_MErrOut_pin : out std_logic;
    ftl_0_PLB_MBusyOut_pin : out std_logic;
    ftl_0_PLB_MRearbitrateOut_pin : out std_logic;
    ftl_0_PLB_MSSizeOut_pin : out std_logic_vector(0 to 1);
    ftl_0_PLB_MAddrAckOut_pin : out std_logic;
    ftl_0_IP2INTC_Irpt_pin : out std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      fpga_0_net_gnd_pin : out std_logic;
      fpga_0_net_gnd_1_pin : out std_logic;
      fpga_0_net_gnd_2_pin : out std_logic;
      fpga_0_net_gnd_3_pin : out std_logic;
      fpga_0_net_gnd_4_pin : out std_logic;
      fpga_0_net_gnd_5_pin : out std_logic;
      fpga_0_net_gnd_6_pin : out std_logic;
      sys_clk_pin : in std_logic;
      sys_rst_pin : in std_logic;
      ftl_0_IP2Bus_WrAckOut_pin : in std_logic;
      ftl_0_IP2Bus_RdAckOut_pin : in std_logic;
      ftl_0_IP2Bus_ToutSupOut_pin : in std_logic;
      ftl_0_IP2Bus_ErrorOut_pin : in std_logic;
      ftl_0_IP2Bus_RetryOut_pin : in std_logic;
      ftl_0_IP2Bus_DataOut_pin : in std_logic_vector(0 to 63);
      ftl_0_Bus2IP_WrReqOut_pin : out std_logic;
      ftl_0_Bus2IP_RdReqOut_pin : out std_logic;
      ftl_0_Bus2IP_WrCEOut_pin : out std_logic_vector(0 to 1);
      ftl_0_Bus2IP_RdCEOut_pin : out std_logic_vector(0 to 1);
      ftl_0_Bus2IP_CSOut_pin : out std_logic;
      ftl_0_Bus2IP_BEOut_pin : out std_logic_vector(0 to 7);
      ftl_0_Bus2IP_DataOut_pin : out std_logic_vector(0 to 63);
      ftl_0_Bus2IP_AddrOut_pin : out std_logic_vector(0 to 31);
      ftl_0_IP2Bus_IntrEventOut_pin : in std_logic;
      ftl_0_Bus2IP_ResetOut_pin : out std_logic;
      ftl_0_Bus2IP_ClkOut_pin : out std_logic;
      ftl_0_M_rdBurstOut_pin : in std_logic;
      ftl_0_M_wrBurstOut_pin : in std_logic;
      ftl_0_M_wrDBusOut_pin : in std_logic_vector(0 to 63);
      ftl_0_M_ABusOut_pin : in std_logic_vector(0 to 31);
      ftl_0_M_abortOut_pin : in std_logic;
      ftl_0_M_lockErrOut_pin : in std_logic;
      ftl_0_M_orderedOut_pin : in std_logic;
      ftl_0_M_guardedOut_pin : in std_logic;
      ftl_0_M_compressOut_pin : in std_logic;
      ftl_0_M_typeOut_pin : in std_logic_vector(0 to 2);
      ftl_0_M_sizeOut_pin : in std_logic_vector(0 to 3);
      ftl_0_M_MSizeOut_pin : in std_logic_vector(0 to 1);
      ftl_0_M_BEOut_pin : in std_logic_vector(0 to 7);
      ftl_0_M_RNWOut_pin : in std_logic;
      ftl_0_M_busLockOut_pin : in std_logic;
      ftl_0_M_priorityOut_pin : in std_logic_vector(0 to 1);
      ftl_0_M_requestOut_pin : in std_logic;
      ftl_0_PLB_MWrBTermOut_pin : out std_logic;
      ftl_0_PLB_MRdBTermOut_pin : out std_logic;
      ftl_0_PLB_MRdDAckOut_pin : out std_logic;
      ftl_0_PLB_MRdWdAddrOut_pin : out std_logic_vector(0 to 3);
      ftl_0_PLB_MRdDBusOut_pin : out std_logic_vector(0 to 63);
      ftl_0_PLB_MWrDAckOut_pin : out std_logic;
      ftl_0_PLB_MErrOut_pin : out std_logic;
      ftl_0_PLB_MBusyOut_pin : out std_logic;
      ftl_0_PLB_MRearbitrateOut_pin : out std_logic;
      ftl_0_PLB_MSSizeOut_pin : out std_logic_vector(0 to 1);
      ftl_0_PLB_MAddrAckOut_pin : out std_logic;
      ftl_0_IP2INTC_Irpt_pin : out std_logic
    );
  end component;

begin

  system_i : system
    port map (
      fpga_0_net_gnd_pin => fpga_0_net_gnd_pin,
      fpga_0_net_gnd_1_pin => fpga_0_net_gnd_1_pin,
      fpga_0_net_gnd_2_pin => fpga_0_net_gnd_2_pin,
      fpga_0_net_gnd_3_pin => fpga_0_net_gnd_3_pin,
      fpga_0_net_gnd_4_pin => fpga_0_net_gnd_4_pin,
      fpga_0_net_gnd_5_pin => fpga_0_net_gnd_5_pin,
      fpga_0_net_gnd_6_pin => fpga_0_net_gnd_6_pin,
      sys_clk_pin => sys_clk_pin,
      sys_rst_pin => sys_rst_pin,
      ftl_0_IP2Bus_WrAckOut_pin => ftl_0_IP2Bus_WrAckOut_pin,
      ftl_0_IP2Bus_RdAckOut_pin => ftl_0_IP2Bus_RdAckOut_pin,
      ftl_0_IP2Bus_ToutSupOut_pin => ftl_0_IP2Bus_ToutSupOut_pin,
      ftl_0_IP2Bus_ErrorOut_pin => ftl_0_IP2Bus_ErrorOut_pin,
      ftl_0_IP2Bus_RetryOut_pin => ftl_0_IP2Bus_RetryOut_pin,
      ftl_0_IP2Bus_DataOut_pin => ftl_0_IP2Bus_DataOut_pin,
      ftl_0_Bus2IP_WrReqOut_pin => ftl_0_Bus2IP_WrReqOut_pin,
      ftl_0_Bus2IP_RdReqOut_pin => ftl_0_Bus2IP_RdReqOut_pin,
      ftl_0_Bus2IP_WrCEOut_pin => ftl_0_Bus2IP_WrCEOut_pin,
      ftl_0_Bus2IP_RdCEOut_pin => ftl_0_Bus2IP_RdCEOut_pin,
      ftl_0_Bus2IP_CSOut_pin => ftl_0_Bus2IP_CSOut_pin,
      ftl_0_Bus2IP_BEOut_pin => ftl_0_Bus2IP_BEOut_pin,
      ftl_0_Bus2IP_DataOut_pin => ftl_0_Bus2IP_DataOut_pin,
      ftl_0_Bus2IP_AddrOut_pin => ftl_0_Bus2IP_AddrOut_pin,
      ftl_0_IP2Bus_IntrEventOut_pin => ftl_0_IP2Bus_IntrEventOut_pin,
      ftl_0_Bus2IP_ResetOut_pin => ftl_0_Bus2IP_ResetOut_pin,
      ftl_0_Bus2IP_ClkOut_pin => ftl_0_Bus2IP_ClkOut_pin,
      ftl_0_M_rdBurstOut_pin => ftl_0_M_rdBurstOut_pin,
      ftl_0_M_wrBurstOut_pin => ftl_0_M_wrBurstOut_pin,
      ftl_0_M_wrDBusOut_pin => ftl_0_M_wrDBusOut_pin,
      ftl_0_M_ABusOut_pin => ftl_0_M_ABusOut_pin,
      ftl_0_M_abortOut_pin => ftl_0_M_abortOut_pin,
      ftl_0_M_lockErrOut_pin => ftl_0_M_lockErrOut_pin,
      ftl_0_M_orderedOut_pin => ftl_0_M_orderedOut_pin,
      ftl_0_M_guardedOut_pin => ftl_0_M_guardedOut_pin,
      ftl_0_M_compressOut_pin => ftl_0_M_compressOut_pin,
      ftl_0_M_typeOut_pin => ftl_0_M_typeOut_pin,
      ftl_0_M_sizeOut_pin => ftl_0_M_sizeOut_pin,
      ftl_0_M_MSizeOut_pin => ftl_0_M_MSizeOut_pin,
      ftl_0_M_BEOut_pin => ftl_0_M_BEOut_pin,
      ftl_0_M_RNWOut_pin => ftl_0_M_RNWOut_pin,
      ftl_0_M_busLockOut_pin => ftl_0_M_busLockOut_pin,
      ftl_0_M_priorityOut_pin => ftl_0_M_priorityOut_pin,
      ftl_0_M_requestOut_pin => ftl_0_M_requestOut_pin,
      ftl_0_PLB_MWrBTermOut_pin => ftl_0_PLB_MWrBTermOut_pin,
      ftl_0_PLB_MRdBTermOut_pin => ftl_0_PLB_MRdBTermOut_pin,
      ftl_0_PLB_MRdDAckOut_pin => ftl_0_PLB_MRdDAckOut_pin,
      ftl_0_PLB_MRdWdAddrOut_pin => ftl_0_PLB_MRdWdAddrOut_pin,
      ftl_0_PLB_MRdDBusOut_pin => ftl_0_PLB_MRdDBusOut_pin,
      ftl_0_PLB_MWrDAckOut_pin => ftl_0_PLB_MWrDAckOut_pin,
      ftl_0_PLB_MErrOut_pin => ftl_0_PLB_MErrOut_pin,
      ftl_0_PLB_MBusyOut_pin => ftl_0_PLB_MBusyOut_pin,
      ftl_0_PLB_MRearbitrateOut_pin => ftl_0_PLB_MRearbitrateOut_pin,
      ftl_0_PLB_MSSizeOut_pin => ftl_0_PLB_MSSizeOut_pin,
      ftl_0_PLB_MAddrAckOut_pin => ftl_0_PLB_MAddrAckOut_pin,
      ftl_0_IP2INTC_Irpt_pin => ftl_0_IP2INTC_Irpt_pin
    );

end architecture STRUCTURE;

