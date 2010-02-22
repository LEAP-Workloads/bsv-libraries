-- ftl.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          ftl.vhd
-- Version:           1.00.a
-- Description:       Top level design, instantiates IPIF and user logic.
-- Date:              Sat May 31 14:05:36 2008 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.all;

library ipif_common_v1_00_e;
use ipif_common_v1_00_e.ipif_pkg.all;
library plb_ipif_v2_01_a;
use plb_ipif_v2_01_a.all;

library ftl_v1_00_a;
use ftl_v1_00_a.all;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_BASEADDR                   -- User logic base address
--   C_HIGHADDR                   -- User logic high address
--   C_PLB_AWIDTH                 -- PLB address bus width
--   C_PLB_DWIDTH                 -- PLB address data width
--   C_PLB_NUM_MASTERS            -- Number of PLB masters
--   C_PLB_MID_WIDTH              -- log2(C_PLB_NUM_MASTERS)
--   C_USER_ID_CODE               -- User ID to place in MIR/Reset register
--   C_FAMILY                     -- Target FPGA architecture
--
-- Definition of Ports:
--   PLB_Clk                      -- PLB Clock
--   PLB_Rst                      -- PLB Reset
--   Sl_addrAck                   -- Slave address acknowledge
--   Sl_MBusy                     -- Slave busy indicator
--   Sl_MErr                      -- Slave error indicator
--   Sl_rdBTerm                   -- Slave terminate read burst transfer
--   Sl_rdComp                    -- Slave read transfer complete indicator
--   Sl_rdDAck                    -- Slave read data acknowledge
--   Sl_rdDBus                    -- Slave read data bus
--   Sl_rdWdAddr                  -- Slave read word address
--   Sl_rearbitrate               -- Slave re-arbitrate bus indicator
--   Sl_SSize                     -- Slave data bus size
--   Sl_wait                      -- Slave wait indicator
--   Sl_wrBTerm                   -- Slave terminate write burst transfer
--   Sl_wrComp                    -- Slave write transfer complete indicator
--   Sl_wrDAck                    -- Slave write data acknowledge
--   PLB_abort                    -- PLB abort request indicator
--   PLB_ABus                     -- PLB address bus
--   PLB_BE                       -- PLB byte enables
--   PLB_busLock                  -- PLB bus lock
--   PLB_compress                 -- PLB compressed data transfer indicator
--   PLB_guarded                  -- PLB guarded transfer indicator
--   PLB_lockErr                  -- PLB lock error indicator
--   PLB_masterID                 -- PLB current master identifier
--   PLB_MSize                    -- PLB master data bus size
--   PLB_ordered                  -- PLB synchronize transfer indicator
--   PLB_PAValid                  -- PLB primary address valid indicator
--   PLB_pendPri                  -- PLB pending request priority
--   PLB_pendReq                  -- PLB pending bus request indicator
--   PLB_rdBurst                  -- PLB burst read transfer indicator
--   PLB_rdPrim                   -- PLB secondary to primary read request indicator
--   PLB_reqPri                   -- PLB current request priority
--   PLB_RNW                      -- PLB read/not write
--   PLB_SAValid                  -- PLB secondary address valid indicator
--   PLB_size                     -- PLB transfer size
--   PLB_type                     -- PLB transfer type
--   PLB_wrBurst                  -- PLB burst write transfer indicator
--   PLB_wrDBus                   -- PLB write data bus
--   PLB_wrPrim                   -- PLB secondary to primary write request indicator
--   M_abort                      -- Master abort bus request indicator
--   M_ABus                       -- Master address bus
--   M_BE                         -- Master byte enables
--   M_busLock                    -- Master buslock
--   M_compress                   -- Master compressed data transfer indicator
--   M_guarded                    -- Master guarded transfer indicator
--   M_lockErr                    -- Master lock error indicator
--   M_MSize                      -- Master data bus size
--   M_ordered                    -- Master synchronize transfer indicator
--   M_priority                   -- Master request priority
--   M_rdBurst                    -- Master burst read transfer indicator
--   M_request                    -- Master request
--   M_RNW                        -- Master read/nor write
--   M_size                       -- Master transfer size
--   M_type                       -- Master transfer type
--   M_wrBurst                    -- Master burst write transfer indicator
--   M_wrDBus                     -- Master write data bus
--   PLB_MBusy                    -- PLB master slave busy indicator
--   PLB_MErr                     -- PLB master slave error indicator
--   PLB_MWrBTerm                 -- PLB master terminate write burst indicator
--   PLB_MWrDAck                  -- PLB master write data acknowledge
--   PLB_MAddrAck                 -- PLB master address acknowledge
--   PLB_MRdBTerm                 -- PLB master terminate read burst indicator
--   PLB_MRdDAck                  -- PLB master read data acknowledge
--   PLB_MRdDBus                  -- PLB master read data bus
--   PLB_MRdWdAddr                -- PLB master read word address
--   PLB_MRearbitrate             -- PLB master bus re-arbitrate indicator
--   PLB_MSSize                   -- PLB slave data bus size
--   IP2INTC_Irpt                 -- Interrupt output to processor
------------------------------------------------------------------------------

entity ftl is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_PLB_AWIDTH                   : integer              := 32;
    C_PLB_DWIDTH                   : integer              := 64;
    C_PLB_NUM_MASTERS              : integer              := 8;
    C_PLB_MID_WIDTH                : integer              := 3;
    C_USER_ID_CODE                 : integer              := 3;
    C_FAMILY                       : string               := "virtex2p"
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
		Bus2IP_ClkOut                     : out  std_logic;
      Bus2IP_ResetOut                   : out  std_logic;
      IP2Bus_IntrEventOut               : in std_logic_vector(0 to 0);
      Bus2IP_AddrOut                    : out  std_logic_vector(0 to C_PLB_AWIDTH-1);
      Bus2IP_DataOut                    : out  std_logic_vector(0 to C_PLB_DWIDTH-1);
      Bus2IP_BEOut                      : out  std_logic_vector(0 to C_PLB_DWIDTH/8-1);
      Bus2IP_CSOut                      : out  std_logic_vector(0 to 0);
      Bus2IP_RdCEOut                    : out  std_logic_vector(0 to 1);
      Bus2IP_WrCEOut                    : out  std_logic_vector(0 to 1);
      Bus2IP_RdReqOut                   : out  std_logic;
      Bus2IP_WrReqOut                   : out  std_logic;
      IP2Bus_DataOut                    : in std_logic_vector(0 to C_PLB_DWIDTH-1);
      IP2Bus_RetryOut                   : in std_logic;
      IP2Bus_ErrorOut                   : in std_logic;
      IP2Bus_ToutSupOut                 : in std_logic;
      IP2Bus_RdAckOut                   : in std_logic;
      IP2Bus_WrAckOut                   : in std_logic;
		
		 M_abortOut                        : in std_logic;
		 M_ABusOut                         : in std_logic_vector(0 to C_PLB_AWIDTH-1);
		 M_BEOut                           : in std_logic_vector(0 to C_PLB_DWIDTH/8-1);
		 M_busLockOut                      : in std_logic;
		 M_compressOut                     : in std_logic;
		 M_guardedOut                      : in std_logic;
		 M_lockErrOut                      : in std_logic;
		 M_MSizeOut                        : in std_logic_vector(0 to 1);
		 M_orderedOut                      : in std_logic;
		 M_priorityOut                     : in std_logic_vector(0 to 1);
		 M_rdBurstOut                      : in std_logic;
		 M_requestOut                      : in std_logic;
		 M_RNWOut                          : in std_logic;
		 M_sizeOut                         : in std_logic_vector(0 to 3);
		 M_typeOut                         : in std_logic_vector(0 to 2);
		 M_wrBurstOut                      : in std_logic;
		 M_wrDBusOut                       : in std_logic_vector(0 to C_PLB_DWIDTH-1);
		 PLB_MBusyOut                      : out  std_logic;
		 PLB_MErrOut                       : out  std_logic;
		 PLB_MWrBTermOut                   : out  std_logic;
		 PLB_MWrDAckOut                    : out  std_logic;
		 PLB_MAddrAckOut                   : out  std_logic;
		 PLB_MRdBTermOut                   : out  std_logic;
		 PLB_MRdDAckOut                    : out  std_logic;
		 PLB_MRdDBusOut                    : out  std_logic_vector(0 to (C_PLB_DWIDTH-1));
		 PLB_MRdWdAddrOut                  : out  std_logic_vector(0 to 3);
		 PLB_MRearbitrateOut               : out  std_logic;
		 PLB_MSSizeOut                     : out  std_logic_vector(0 to 1);
	 	 	 
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    PLB_Clk                        : in  std_logic;
    PLB_Rst                        : in  std_logic;
    Sl_addrAck                     : out std_logic;
    Sl_MBusy                       : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
    Sl_MErr                        : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
    Sl_rdBTerm                     : out std_logic;
    Sl_rdComp                      : out std_logic;
    Sl_rdDAck                      : out std_logic;
    Sl_rdDBus                      : out std_logic_vector(0 to C_PLB_DWIDTH-1);
    Sl_rdWdAddr                    : out std_logic_vector(0 to 3);
    Sl_rearbitrate                 : out std_logic;
    Sl_SSize                       : out std_logic_vector(0 to 1);
    Sl_wait                        : out std_logic;
    Sl_wrBTerm                     : out std_logic;
    Sl_wrComp                      : out std_logic;
    Sl_wrDAck                      : out std_logic;
    PLB_abort                      : in  std_logic;
    PLB_ABus                       : in  std_logic_vector(0 to C_PLB_AWIDTH-1);
    PLB_BE                         : in  std_logic_vector(0 to C_PLB_DWIDTH/8-1);
    PLB_busLock                    : in  std_logic;
    PLB_compress                   : in  std_logic;
    PLB_guarded                    : in  std_logic;
    PLB_lockErr                    : in  std_logic;
    PLB_masterID                   : in  std_logic_vector(0 to C_PLB_MID_WIDTH-1);
    PLB_MSize                      : in  std_logic_vector(0 to 1);
    PLB_ordered                    : in  std_logic;
    PLB_PAValid                    : in  std_logic;
    PLB_pendPri                    : in  std_logic_vector(0 to 1);
    PLB_pendReq                    : in  std_logic;
    PLB_rdBurst                    : in  std_logic;
    PLB_rdPrim                     : in  std_logic;
    PLB_reqPri                     : in  std_logic_vector(0 to 1);
    PLB_RNW                        : in  std_logic;
    PLB_SAValid                    : in  std_logic;
    PLB_size                       : in  std_logic_vector(0 to 3);
    PLB_type                       : in  std_logic_vector(0 to 2);
    PLB_wrBurst                    : in  std_logic;
    PLB_wrDBus                     : in  std_logic_vector(0 to C_PLB_DWIDTH-1);
    PLB_wrPrim                     : in  std_logic;
    M_abort                        : out std_logic;
    M_ABus                         : out std_logic_vector(0 to C_PLB_AWIDTH-1);
    M_BE                           : out std_logic_vector(0 to C_PLB_DWIDTH/8-1);
    M_busLock                      : out std_logic;
    M_compress                     : out std_logic;
    M_guarded                      : out std_logic;
    M_lockErr                      : out std_logic;
    M_MSize                        : out std_logic_vector(0 to 1);
    M_ordered                      : out std_logic;
    M_priority                     : out std_logic_vector(0 to 1);
    M_rdBurst                      : out std_logic;
    M_request                      : out std_logic;
    M_RNW                          : out std_logic;
    M_size                         : out std_logic_vector(0 to 3);
    M_type                         : out std_logic_vector(0 to 2);
    M_wrBurst                      : out std_logic;
    M_wrDBus                       : out std_logic_vector(0 to C_PLB_DWIDTH-1);
    PLB_MBusy                      : in  std_logic;
    PLB_MErr                       : in  std_logic;
    PLB_MWrBTerm                   : in  std_logic;
    PLB_MWrDAck                    : in  std_logic;
    PLB_MAddrAck                   : in  std_logic;
    PLB_MRdBTerm                   : in  std_logic;
    PLB_MRdDAck                    : in  std_logic;
    PLB_MRdDBus                    : in  std_logic_vector(0 to (C_PLB_DWIDTH-1));
    PLB_MRdWdAddr                  : in  std_logic_vector(0 to 3);
    PLB_MRearbitrate               : in  std_logic;
    PLB_MSSize                     : in  std_logic_vector(0 to 1);
    IP2INTC_Irpt                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of PLB_Clk       : signal is "Clk";
  attribute SIGIS of PLB_Rst       : signal is "Rst";
  attribute SIGIS of IP2INTC_Irpt  : signal is "INTR_LEVEL_HIGH";

end entity ftl;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of ftl is

  ------------------------------------------
  -- constants : generated by wizard for instantiation - do not change
  ------------------------------------------
  -- specify address range definition identifier value, each entry with
  -- predefined identifier indicates inclusion of corresponding ipif
  -- service, following ipif mandatory service identifiers are predefined:
  --   IPIF_INTR
  --   IPIF_RST
  --   IPIF_SEST_SEAR
  --   IPIF_DMA_SG
  --   IPIF_WRFIFO_REG
  --   IPIF_WRFIFO_DATA
  --   IPIF_RDFIFO_REG
  --   IPIF_RDFIFO_DATA
  constant USER_MASTER                    : integer              := USER_10;

  constant ARD_ID_ARRAY                   : INTEGER_ARRAY_TYPE   := 
    (
      0  => USER_MASTER,            -- user logic master space (ip master model registers)
      1  => IPIF_RST,               -- ipif reset/mir service
      2  => IPIF_INTR               -- ipif interrupt service
    );

  -- specify actual address range (defined by a pair of base address and
  -- high address) for each address space, which are byte relative.
  constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 31) := (others => '0');

  constant MASTER_BASEADDR                : std_logic_vector     := C_BASEADDR or X"00000000";

  constant MASTER_HIGHADDR                : std_logic_vector     := C_BASEADDR or X"000000FF";

  constant RST_BASEADDR                   : std_logic_vector     := C_BASEADDR or X"00000100";

  constant RST_HIGHADDR                   : std_logic_vector     := C_BASEADDR or X"000001FF";

  constant INTR_BASEADDR                  : std_logic_vector     := C_BASEADDR or X"00000200";

  constant INTR_HIGHADDR                  : std_logic_vector     := C_BASEADDR or X"000002FF";

  constant ARD_ADDR_RANGE_ARRAY           : SLV64_ARRAY_TYPE     := 
    (
      ZERO_ADDR_PAD & MASTER_BASEADDR,            -- user logic master space base address
      ZERO_ADDR_PAD & MASTER_HIGHADDR,            -- user logic master space high address
      ZERO_ADDR_PAD & RST_BASEADDR,               -- ipif reset/mir base address
      ZERO_ADDR_PAD & RST_HIGHADDR,               -- ipif reset/mir high address
      ZERO_ADDR_PAD & INTR_BASEADDR,              -- ipif interrupt base address
      ZERO_ADDR_PAD & INTR_HIGHADDR               -- ipif interrupt high address
    );

  -- specify data width for each target address range.
  constant USER_DWIDTH                    : integer              := 64;

  constant ARD_DWIDTH_ARRAY               : INTEGER_ARRAY_TYPE   := 
    (
      0  => USER_DWIDTH,            -- user logic master space data width
      1  => 32,                     -- ipif reset/mir data width
      2  => 32                      -- ipif interrupt data width
    );

  -- specify desired number of chip enables for each address range,
  -- typically one ce per register and each ipif service has its
  -- predefined value.
  constant USER_NUM_MASTER_CE             : integer              := 2;

  constant USER_NUM_CE                    : integer              := USER_NUM_MASTER_CE;

  constant ARD_NUM_CE_ARRAY               : INTEGER_ARRAY_TYPE   := 
    (
      0  => pad_power2(USER_NUM_MASTER_CE),   -- number of chip enables for user logic master space (one per register)
      1  => 1,                                -- ipif reset/mir service (always 1 chip enable)
      2  => 16                                -- ipif interrupt service (always 16 chip enables)
    );

  -- specify unique properties for each address range, currently
  -- only used for packet fifo data spaces.
  constant ARD_DEPENDENT_PROPS_ARRAY      : DEPENDENT_PROPS_ARRAY_TYPE := 
    (
      0  => (others => 0),          -- user logic master space dependent properties (none defined)
      1  => (others => 0),          -- ipif reset/mir dependent properties (none defined)
      2  => (others => 0)           -- ipif interrupt dependent properties (none defined)
    );

  -- specify determinate timing parameters to be used during read
  -- accesses for each address range, these values are used to optimize
  -- data beat timing response for burst reads from addresses sources such
  -- as ddr and sdram memory, each address space requires three integer
  -- entries for mode [0-2], latency [0-31] and wait states [0-31].
  constant ARD_DTIME_READ_ARRAY           : INTEGER_ARRAY_TYPE   := 
    (
      0, 0, 0,    -- user logic master space determinate read parameters
      0, 0, 0,    -- ipif reset/mir determinate read parameters
      0, 0, 0     -- ipif interrupt determinate read parameters
    );

  -- specify determinate timing parameters to be used during write
  -- accesses for each address range, they not used currently, so
  -- all entries should be set to zeros.
  constant ARD_DTIME_WRITE_ARRAY          : INTEGER_ARRAY_TYPE   := 
    (
      0, 0, 0,    -- user logic master space determinate write parameters
      0, 0, 0,    -- ipif reset/mir determinate write parameters
      0, 0, 0     -- ipif interrupt determinate write parameters
    );

  -- specify user defined device block id, which is used to uniquely
  -- identify a device within a system.
  constant DEV_BLK_ID                     : integer              := C_USER_ID_CODE;

  -- specify inclusion/omission of module information register to be
  -- read via the plb bus.
  constant DEV_MIR_ENABLE                 : integer              := 1;

  -- specify inclusion/omission of additional logic needed to support
  -- plb fixed burst transfers and optimized cacahline transfers.
  constant DEV_BURST_ENABLE               : integer              := 0;

  -- specify the maximum number of bytes that are allowed to be
  -- transferred in a single burst operation, currently this needs
  -- to be fixed at 128.
  constant DEV_MAX_BURST_SIZE             : integer              := 128;

  -- specify size of the largest target burstable memory space (in
  -- bytes and a power of 2), this is to optimize the size of the
  -- internal burst address counters.
  constant DEV_BURST_PAGE_SIZE            : integer              := 1024;

  -- specify number of plb clock cycles are allowed before a
  -- data phase transfer timeout, this feature is useful during
  -- system integration and debug.
  constant DEV_DPHASE_TIMEOUT             : integer              := 64;

  -- specify inclusion/omission of device interrupt source
  -- controller for internal ipif generated interrupts.
  constant INCLUDE_DEV_ISC                : integer              := 1;

  -- specify inclusion/omission of device interrupt priority
  -- encoder, this is useful in aiding the user interrupt service
  -- routine to resolve the source of an interrupt within a plb
  -- device incorporating an ipif.
  constant INCLUDE_DEV_PENCODER           : integer              := 1;

  -- specify number and capture mode of interrupt events from the
  -- user logic to the ip isc located in the ipif interrupt service,
  -- user logic interrupt event capture mode [1-6]:
  --   1 = Level Pass through (non-inverted)
  --   2 = Level Pass through (invert input)
  --   3 = Registered Event (non-inverted)
  --   4 = Registered Event (inverted input)
  --   5 = Rising Edge Detect
  --   6 = Falling Edge Detect
  constant USER_INTERRUPT_CAPTURE_MODE    : integer              := 3;

  constant IP_INTR_MODE_ARRAY             : INTEGER_ARRAY_TYPE   := 
    (
      0  => USER_INTERRUPT_CAPTURE_MODE 
    );

  -- specify inclusion/omission of plb master service for user logic.
  constant IP_MASTER_PRESENT              : integer              := 0;

  -- specify dma type for each channel (currently only 2 channels
  -- supported), use following number:
  --   0 - simple dma
  --   1 - simple scatter gather
  --   2 - tx scatter gather with packet mode support
  --   3 - rx scatter gather with packet mode support
  constant DMA_CHAN_TYPE_ARRAY            : INTEGER_ARRAY_TYPE   := 
    (
      0 => 0     -- not used
    );

  -- specify maximum width in bits for dma transfer byte counters.
  constant DMA_LENGTH_WIDTH_ARRAY         : INTEGER_ARRAY_TYPE   := 
    (
      0 => 0     -- not used
    );

  -- specify address assigement for the length fifos used in
  -- scatter gather operation.
  constant DMA_PKT_LEN_FIFO_ADDR_ARRAY    : SLV64_ARRAY_TYPE     := 
    (
      0 => X"00000000_00000000"     -- not used
    );

  -- specify address assigement for the status fifos used in
  -- scatter gather operation.
  constant DMA_PKT_STAT_FIFO_ADDR_ARRAY   : SLV64_ARRAY_TYPE     := 
    (
      0 => X"00000000_00000000"     -- not used
    );

  -- specify interrupt coalescing value (number of interrupts to
  -- accrue before issuing interrupt to system) for each dma
  -- channel, apply to software design consideration.
  constant DMA_INTR_COALESCE_ARRAY        : INTEGER_ARRAY_TYPE   := 
    (
      0 => 0     -- not used
    );

  -- specify allowing dma busrt mode transactions or not.
  constant DMA_ALLOW_BURST                : integer              := 0;

  -- specify maximum allowed time period (in ns) a packet may wait
  -- before transfer by the scatter gather dma, apply to software
  -- design consideration.
  constant DMA_PACKET_WAIT_UNIT_NS        : integer              := 1000;

  -- specify period of the plb clock in picoseconds, which is used
  --  by the dma/sg service for timing funtions.
  constant PLB_CLK_PERIOD_PS              : integer              := 10000;

  -- specify ipif data bus size, used for future ipif optimization,
  -- should be set equal to the plb data bus width.
  constant IPIF_DWIDTH                    : integer              := C_PLB_DWIDTH;

  -- specify ipif address bus size, used for future ipif optimization,
  -- should be set equal to the plb address bus width.
  constant IPIF_AWIDTH                    : integer              := C_PLB_AWIDTH;

  -- specify number of interrupt events coming out from user logic,
  -- must be equal to the number of entries in IP_INTR_MODE_ARRAY.
  constant USER_IP_INTR_NUM               : integer              := 1;

  -- specify user logic address bus width, must be same as the target bus.
  constant USER_AWIDTH                    : integer              := C_PLB_AWIDTH;

  -- specify number of chip selects for user logic slave/master spaces.
  constant USER_NUM_CS                    : integer              := 1;

  constant USER_CS_INDEX                  : integer              := get_id_index(ARD_ID_ARRAY, USER_MASTER);

  -- specify index for user logic slave/master spaces chip enable.
  constant USER_MASTER_CE_INDEX           : integer              := calc_start_ce_index(ARD_NUM_CE_ARRAY, get_id_index(ARD_ID_ARRAY, USER_MASTER));

  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations -- do not delete
  -- prefix 'i' stands for IPIF while prefix 'u' stands for user logic
  -- typically user logic will be hooked up to IPIF directly via i<sig>
  -- unless signal slicing and muxing are needed via u<sig>
  ------------------------------------------
  signal iBus2IP_Clk                    : std_logic;
  signal iBus2IP_Reset                  : std_logic;
  signal iIP2Bus_IntrEvent              : std_logic_vector(0 to IP_INTR_MODE_ARRAY'length - 1)   := (others => '0');
  signal iIP2Bus_Data                   : std_logic_vector(0 to C_PLB_DWIDTH-1)   := (others => '0');
  signal iIP2Bus_WrAck                  : std_logic   := '0';
  signal iIP2Bus_RdAck                  : std_logic   := '0';
  signal iIP2Bus_Retry                  : std_logic   := '0';
  signal iIP2Bus_Error                  : std_logic   := '0';
  signal iIP2Bus_ToutSup                : std_logic   := '0';
  signal iBus2IP_Addr                   : std_logic_vector(0 to C_PLB_AWIDTH - 1);
  signal iBus2IP_Data                   : std_logic_vector(0 to C_PLB_DWIDTH - 1);
  signal iBus2IP_BE                     : std_logic_vector(0 to (C_PLB_DWIDTH/8) - 1);
  signal iBus2IP_WrReq                  : std_logic;
  signal iBus2IP_RdReq                  : std_logic;
  signal iBus2IP_CS                     : std_logic_vector(0 to ((ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1);
  signal iBus2IP_RdCE                   : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal iBus2IP_WrCE                   : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal iIP2Bus_Addr                   : std_logic_vector(0 to IPIF_AWIDTH - 1)   := (others => '0');
  signal iIP2Bus_MstBE                  : std_logic_vector(0 to (IPIF_DWIDTH/8) - 1)   := (others => '0');
  signal iIP2IP_Addr                    : std_logic_vector(0 to IPIF_AWIDTH - 1)   := (others => '0');
  signal iIP2Bus_MstWrReq               : std_logic   := '0';
  signal iIP2Bus_MstRdReq               : std_logic   := '0';
  signal iIP2Bus_MstBurst               : std_logic   := '0';
  signal iIP2Bus_MstBusLock             : std_logic   := '0';
  signal iIP2Bus_MstNum                 : std_logic_vector(0 to log2(DEV_MAX_BURST_SIZE/(C_PLB_DWIDTH/8)))   := (others => '0');
  signal iBus2IP_MstWrAck               : std_logic;
  signal iBus2IP_MstRdAck               : std_logic;
  signal iBus2IP_MstRetry               : std_logic;
  signal iBus2IP_MstError               : std_logic;
  signal iBus2IP_MstTimeOut             : std_logic;
  signal iBus2IP_MstLastAck             : std_logic;
  signal ZERO_IP2RFIFO_Data             : std_logic_vector(0 to find_id_dwidth(ARD_ID_ARRAY, ARD_DWIDTH_ARRAY, IPIF_RDFIFO_DATA, 32)-1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal uBus2IP_Data                   : std_logic_vector(0 to USER_DWIDTH-1);
  signal uBus2IP_BE                     : std_logic_vector(0 to USER_DWIDTH/8-1);
  signal uBus2IP_CS                     : std_logic_vector(0 to USER_NUM_CS-1);
  signal uBus2IP_RdCE                   : std_logic_vector(0 to USER_NUM_CE-1);
  signal uBus2IP_WrCE                   : std_logic_vector(0 to USER_NUM_CE-1);
  signal uIP2Bus_Data                   : std_logic_vector(0 to USER_DWIDTH-1);
  signal uIP2Bus_MstBE                  : std_logic_vector(0 to USER_DWIDTH/8-1);
  
  signal ZERO_IP2Bus_Addr               : std_logic_vector(0 to C_PLB_AWIDTH - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2Bus_MstBE              : std_logic_vector(0 to (C_PLB_DWIDTH/8) - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2IP_Addr                : std_logic_vector(0 to C_PLB_AWIDTH - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2Bus_MstNum                : std_logic_vector(0 to log2(DEV_MAX_BURST_SIZE/(C_PLB_DWIDTH/8)))   := (others => '0'); 
  

  ------------------------------------------
  -- Component declaration for verilog user logic
  ------------------------------------------
  component user_logic is
    generic
    (
      -- ADD USER GENERICS BELOW THIS LINE ---------------
      --USER generics added here
      -- ADD USER GENERICS ABOVE THIS LINE ---------------

      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol parameters, do not add to or delete
      C_AWIDTH                       : integer              := 32;
      C_DWIDTH                       : integer              := 64;
      C_NUM_CS                       : integer              := 1;
      C_NUM_CE                       : integer              := 2;
      C_IP_INTR_NUM                  : integer              := 1
      -- DO NOT EDIT ABOVE THIS LINE ---------------------
    );
    port
    (
      -- ADD USER PORTS BELOW THIS LINE ------------------
		Bus2IP_ClkOut                     : out  std_logic;
      Bus2IP_ResetOut                   : out  std_logic;
      IP2Bus_IntrEventOut               : in std_logic_vector(0 to C_IP_INTR_NUM-1);
      Bus2IP_AddrOut                    : out  std_logic_vector(0 to C_AWIDTH-1);
      Bus2IP_DataOut                    : out  std_logic_vector(0 to C_DWIDTH-1);
      Bus2IP_BEOut                      : out  std_logic_vector(0 to C_DWIDTH/8-1);
      Bus2IP_CSOut                      : out  std_logic_vector(0 to C_NUM_CS-1);
      Bus2IP_RdCEOut                    : out  std_logic_vector(0 to C_NUM_CE-1);
      Bus2IP_WrCEOut                    : out  std_logic_vector(0 to C_NUM_CE-1);
      Bus2IP_RdReqOut                   : out  std_logic;
      Bus2IP_WrReqOut                   : out  std_logic;
      IP2Bus_DataOut                    : in std_logic_vector(0 to C_DWIDTH-1);
      IP2Bus_RetryOut                   : in std_logic;
      IP2Bus_ErrorOut                   : in std_logic;
      IP2Bus_ToutSupOut                 : in std_logic;
      IP2Bus_RdAckOut                   : in std_logic;
      IP2Bus_WrAckOut                   : in std_logic;
		
		 M_abortOut                        : in std_logic;
		 M_ABusOut                         : in std_logic_vector(0 to C_PLB_AWIDTH-1);
		 M_BEOut                           : in std_logic_vector(0 to C_PLB_DWIDTH/8-1);
		 M_busLockOut                      : in std_logic;
		 M_compressOut                     : in std_logic;
		 M_guardedOut                      : in std_logic;
		 M_lockErrOut                      : in std_logic;
		 M_MSizeOut                        : in std_logic_vector(0 to 1);
		 M_orderedOut                      : in std_logic;
		 M_priorityOut                     : in std_logic_vector(0 to 1);
		 M_rdBurstOut                      : in std_logic;
		 M_requestOut                      : in std_logic;
		 M_RNWOut                          : in std_logic;
		 M_sizeOut                         : in std_logic_vector(0 to 3);
		 M_typeOut                         : in std_logic_vector(0 to 2);
		 M_wrBurstOut                      : in std_logic;
		 M_wrDBusOut                       : in std_logic_vector(0 to C_PLB_DWIDTH-1);
		 PLB_MBusyOut                      : out  std_logic;
		 PLB_MErrOut                       : out  std_logic;
		 PLB_MWrBTermOut                   : out  std_logic;
		 PLB_MWrDAckOut                    : out  std_logic;
		 PLB_MAddrAckOut                   : out  std_logic;
		 PLB_MRdBTermOut                   : out  std_logic;
		 PLB_MRdDAckOut                    : out  std_logic;
		 PLB_MRdDBusOut                    : out  std_logic_vector(0 to (C_PLB_DWIDTH-1));
		 PLB_MRdWdAddrOut                  : out  std_logic_vector(0 to 3);
		 PLB_MRearbitrateOut               : out  std_logic;
		 PLB_MSSizeOut                     : out  std_logic_vector(0 to 1);
	 	 
      -- ADD USER PORTS ABOVE THIS LINE ------------------

      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol ports, do not add to or delete
      Bus2IP_Clk                     : in  std_logic;
      Bus2IP_Reset                   : in  std_logic;
      IP2Bus_IntrEvent               : out std_logic_vector(0 to C_IP_INTR_NUM-1);
      Bus2IP_Addr                    : in  std_logic_vector(0 to C_AWIDTH-1);
      Bus2IP_Data                    : in  std_logic_vector(0 to C_DWIDTH-1);
      Bus2IP_BE                      : in  std_logic_vector(0 to C_DWIDTH/8-1);
      Bus2IP_CS                      : in  std_logic_vector(0 to C_NUM_CS-1);
      Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
      Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
      Bus2IP_RdReq                   : in  std_logic;
      Bus2IP_WrReq                   : in  std_logic;
      IP2Bus_Data                    : out std_logic_vector(0 to C_DWIDTH-1);
      IP2Bus_Retry                   : out std_logic;
      IP2Bus_Error                   : out std_logic;
      IP2Bus_ToutSup                 : out std_logic;
      IP2Bus_RdAck                   : out std_logic;
      IP2Bus_WrAck                   : out std_logic;
		
		 M_abort                        : out std_logic;
		 M_ABus                         : out std_logic_vector(0 to C_PLB_AWIDTH-1);
		 M_BE                           : out std_logic_vector(0 to C_PLB_DWIDTH/8-1);
		 M_busLock                      : out std_logic;
		 M_compress                     : out std_logic;
		 M_guarded                      : out std_logic;
		 M_lockErr                      : out std_logic;
		 M_MSize                        : out std_logic_vector(0 to 1);
		 M_ordered                      : out std_logic;
		 M_priority                     : out std_logic_vector(0 to 1);
		 M_rdBurst                      : out std_logic;
		 M_request                      : out std_logic;
		 M_RNW                          : out std_logic;
		 M_size                         : out std_logic_vector(0 to 3);
		 M_type                         : out std_logic_vector(0 to 2);
		 M_wrBurst                      : out std_logic;
		 M_wrDBus                       : out std_logic_vector(0 to C_PLB_DWIDTH-1);
		 PLB_MBusy                      : in  std_logic;
		 PLB_MErr                       : in  std_logic;
		 PLB_MWrBTerm                   : in  std_logic;
		 PLB_MWrDAck                    : in  std_logic;
		 PLB_MAddrAck                   : in  std_logic;
		 PLB_MRdBTerm                   : in  std_logic;
		 PLB_MRdDAck                    : in  std_logic;
		 PLB_MRdDBus                    : in  std_logic_vector(0 to (C_PLB_DWIDTH-1));
		 PLB_MRdWdAddr                  : in  std_logic_vector(0 to 3);
		 PLB_MRearbitrate               : in  std_logic;
		 PLB_MSSize                     : in  std_logic_vector(0 to 1)
      -- DO NOT EDIT ABOVE THIS LINE ---------------------
    );
  end component user_logic;

begin

  ------------------------------------------
  -- instantiate the PLB IPIF
  ------------------------------------------
  PLB_IPIF_I : entity plb_ipif_v2_01_a.plb_ipif
    generic map
    (
      C_ARD_ID_ARRAY                 => ARD_ID_ARRAY,
      C_ARD_ADDR_RANGE_ARRAY         => ARD_ADDR_RANGE_ARRAY,
      C_ARD_DWIDTH_ARRAY             => ARD_DWIDTH_ARRAY,
      C_ARD_NUM_CE_ARRAY             => ARD_NUM_CE_ARRAY,
      C_ARD_DEPENDENT_PROPS_ARRAY    => ARD_DEPENDENT_PROPS_ARRAY,
      C_ARD_DTIME_READ_ARRAY         => ARD_DTIME_READ_ARRAY,
      C_ARD_DTIME_WRITE_ARRAY        => ARD_DTIME_WRITE_ARRAY,
      C_DEV_BLK_ID                   => DEV_BLK_ID,
      C_DEV_MIR_ENABLE               => DEV_MIR_ENABLE,
      C_DEV_BURST_ENABLE             => DEV_BURST_ENABLE,
      C_DEV_MAX_BURST_SIZE           => DEV_MAX_BURST_SIZE,
      C_DEV_BURST_PAGE_SIZE          => DEV_BURST_PAGE_SIZE,
      C_DEV_DPHASE_TIMEOUT           => DEV_DPHASE_TIMEOUT,
      C_INCLUDE_DEV_ISC              => INCLUDE_DEV_ISC,
      C_INCLUDE_DEV_PENCODER         => INCLUDE_DEV_PENCODER,
      C_IP_INTR_MODE_ARRAY           => IP_INTR_MODE_ARRAY,
      C_IP_MASTER_PRESENT            => IP_MASTER_PRESENT,
      C_DMA_CHAN_TYPE_ARRAY          => DMA_CHAN_TYPE_ARRAY,
      C_DMA_LENGTH_WIDTH_ARRAY       => DMA_LENGTH_WIDTH_ARRAY,
      C_DMA_PKT_LEN_FIFO_ADDR_ARRAY  => DMA_PKT_LEN_FIFO_ADDR_ARRAY,
      C_DMA_PKT_STAT_FIFO_ADDR_ARRAY => DMA_PKT_STAT_FIFO_ADDR_ARRAY,
      C_DMA_INTR_COALESCE_ARRAY      => DMA_INTR_COALESCE_ARRAY,
      C_DMA_ALLOW_BURST              => DMA_ALLOW_BURST,
      C_DMA_PACKET_WAIT_UNIT_NS      => DMA_PACKET_WAIT_UNIT_NS,
      C_PLB_MID_WIDTH                => C_PLB_MID_WIDTH,
      C_PLB_NUM_MASTERS              => C_PLB_NUM_MASTERS,
      C_PLB_AWIDTH                   => C_PLB_AWIDTH,
      C_PLB_DWIDTH                   => C_PLB_DWIDTH,
      C_PLB_CLK_PERIOD_PS            => PLB_CLK_PERIOD_PS,
      C_IPIF_DWIDTH                  => IPIF_DWIDTH,
      C_IPIF_AWIDTH                  => IPIF_AWIDTH,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
	 		
	 
      PLB_clk                        => PLB_Clk,
      Reset                          => PLB_Rst,
      Freeze                         => '0',
      IP2INTC_Irpt                   => IP2INTC_Irpt,
      PLB_ABus                       => PLB_ABus,
      PLB_PAValid                    => PLB_PAValid,
      PLB_SAValid                    => PLB_SAValid,
      PLB_rdPrim                     => PLB_rdPrim,
      PLB_wrPrim                     => PLB_wrPrim,
      PLB_masterID                   => PLB_masterID,
      PLB_abort                      => PLB_abort,
      PLB_busLock                    => PLB_busLock,
      PLB_RNW                        => PLB_RNW,
      PLB_BE                         => PLB_BE,
      PLB_MSize                      => PLB_MSize,
      PLB_size                       => PLB_size,
      PLB_type                       => PLB_type,
      PLB_compress                   => PLB_compress,
      PLB_guarded                    => PLB_guarded,
      PLB_ordered                    => PLB_ordered,
      PLB_lockErr                    => PLB_lockErr,
      PLB_wrDBus                     => PLB_wrDBus,
      PLB_wrBurst                    => PLB_wrBurst,
      PLB_rdBurst                    => PLB_rdBurst,
      PLB_pendReq                    => PLB_pendReq,
      PLB_pendPri                    => PLB_pendPri,
      PLB_reqPri                     => PLB_reqPri,
      Sl_addrAck                     => Sl_addrAck,
      Sl_SSize                       => Sl_SSize,
      Sl_wait                        => Sl_wait,
      Sl_rearbitrate                 => Sl_rearbitrate,
      Sl_wrDAck                      => Sl_wrDAck,
      Sl_wrComp                      => Sl_wrComp,
      Sl_wrBTerm                     => Sl_wrBTerm,
      Sl_rdDBus                      => Sl_rdDBus,
      Sl_rdWdAddr                    => Sl_rdWdAddr,
      Sl_rdDAck                      => Sl_rdDAck,
      Sl_rdComp                      => Sl_rdComp,
      Sl_rdBTerm                     => Sl_rdBTerm,
      Sl_MBusy                       => Sl_MBusy,
      Sl_MErr                        => Sl_MErr,
      PLB_MAddrAck                   => PLB_MAddrAck,
      PLB_MSSize                     => PLB_MSSize,
      PLB_MRearbitrate               => PLB_MRearbitrate,
      PLB_MBusy                      => PLB_MBusy,
      PLB_MErr                       => PLB_MErr,
      PLB_MWrDAck                    => PLB_MWrDAck,
      PLB_MRdDBus                    => PLB_MRdDBus,
      PLB_MRdWdAddr                  => PLB_MRdWdAddr,
      PLB_MRdDAck                    => PLB_MRdDAck,
      PLB_MRdBTerm                   => PLB_MRdBTerm,
      PLB_MWrBTerm                   => PLB_MWrBTerm,
      M_request                      => open,
      M_priority                     => open,
      M_busLock                      => open,
      M_RNW                          => open,
      M_BE                           => open,
      M_MSize                        => open,
      M_size                         => open,
      M_type                         => open,
      M_compress                     => open,
      M_guarded                      => open,
      M_ordered                      => open,
      M_lockErr                      => open,
      M_abort                        => open,
      M_ABus                         => open,
      M_wrDBus                       => open,
      M_wrBurst                      => open,
      M_rdBurst                      => open,
      IP2Bus_Clk                     => '0',
      Bus2IP_Clk                     => iBus2IP_Clk,
      Bus2IP_Reset                   => iBus2IP_Reset,
      Bus2IP_Freeze                  => open,
      IP2Bus_IntrEvent               => iIP2Bus_IntrEvent,
      IP2Bus_Data                    => iIP2Bus_Data,
      IP2Bus_WrAck                   => iIP2Bus_WrAck,
      IP2Bus_RdAck                   => iIP2Bus_RdAck,
      IP2Bus_Retry                   => iIP2Bus_Retry,
      IP2Bus_Error                   => iIP2Bus_Error,
      IP2Bus_ToutSup                 => iIP2Bus_ToutSup,
      IP2Bus_PostedWrInh             => '0',
      Bus2IP_Addr                    => iBus2IP_Addr,
      Bus2IP_Data                    => iBus2IP_Data,
      Bus2IP_RNW                     => open,
      Bus2IP_BE                      => iBus2IP_BE,
      Bus2IP_Burst                   => open,
      Bus2IP_WrReq                   => iBus2IP_WrReq,
      Bus2IP_RdReq                   => iBus2IP_RdReq,
      Bus2IP_CS                      => iBus2IP_CS,
      Bus2IP_CE                      => open,
      Bus2IP_RdCE                    => iBus2IP_RdCE,
      Bus2IP_WrCE                    => iBus2IP_WrCE,
      IP2DMA_RxLength_Empty          => '0',
      IP2DMA_RxStatus_Empty          => '0',
      IP2DMA_TxLength_Full           => '0',
      IP2DMA_TxStatus_Empty          => '0',
      IP2Bus_Addr                    => ZERO_IP2Bus_Addr,
      IP2Bus_MstBE                   => ZERO_IP2Bus_MstBE,
      IP2IP_Addr                     => ZERO_IP2IP_Addr,
      IP2Bus_MstWrReq                => '0',
      IP2Bus_MstRdReq                => '0',
      IP2Bus_MstBurst                => '0',
      IP2Bus_MstBusLock              => '0',
      IP2Bus_MstNum                  => ZERO_IP2Bus_MstNum,
      Bus2IP_MstWrAck                => iBus2IP_MstWrAck,
      Bus2IP_MstRdAck                => iBus2IP_MstRdAck,
      Bus2IP_MstRetry                => iBus2IP_MstRetry,
      Bus2IP_MstError                => iBus2IP_MstError,
      Bus2IP_MstTimeOut              => iBus2IP_MstTimeOut,
      Bus2IP_MstLastAck              => iBus2IP_MstLastAck,
      Bus2IP_IPMstTrans              => open,
      IP2RFIFO_WrReq                 => '0',
      IP2RFIFO_Data                  => ZERO_IP2RFIFO_Data,
      IP2RFIFO_WrMark                => '0',
      IP2RFIFO_WrRelease             => '0',
      IP2RFIFO_WrRestore             => '0',
      RFIFO2IP_WrAck                 => open,
      RFIFO2IP_AlmostFull            => open,
      RFIFO2IP_Full                  => open,
      RFIFO2IP_Vacancy               => open,
      IP2WFIFO_RdReq                 => '0',
      IP2WFIFO_RdMark                => '0',
      IP2WFIFO_RdRelease             => '0',
      IP2WFIFO_RdRestore             => '0',
      WFIFO2IP_Data                  => open,
      WFIFO2IP_RdAck                 => open,
      WFIFO2IP_AlmostEmpty           => open,
      WFIFO2IP_Empty                 => open,
      WFIFO2IP_Occupancy             => open,
      IP2Bus_DMA_Req                 => '0',
      Bus2IP_DMA_Ack                 => open
    );

  ------------------------------------------
  -- instantiate the User Logic
  ------------------------------------------
  USER_LOGIC_I : component user_logic
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_AWIDTH                       => USER_AWIDTH,
      C_DWIDTH                       => USER_DWIDTH,
      C_NUM_CS                       => USER_NUM_CS,
      C_NUM_CE                       => USER_NUM_CE,
      C_IP_INTR_NUM                  => USER_IP_INTR_NUM
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      Bus2IP_ClkOut                     => Bus2IP_ClkOut,
      Bus2IP_ResetOut                   => Bus2IP_ResetOut,
      IP2Bus_IntrEventOut               => IP2Bus_IntrEventOut,
      Bus2IP_AddrOut                    => Bus2IP_AddrOut,
      Bus2IP_DataOut                    => Bus2IP_DataOut,
      Bus2IP_BEOut                      => Bus2IP_BEOut,
      Bus2IP_CSOut                      => Bus2IP_CSOut,
      Bus2IP_RdCEOut                    => Bus2IP_RdCEOut,
      Bus2IP_WrCEOut                    => Bus2IP_WrCEOut,
      Bus2IP_RdReqOut                   => Bus2IP_RdReqOut,
      Bus2IP_WrReqOut                   => Bus2IP_WrReqOut,
      IP2Bus_DataOut                    => IP2Bus_DataOut,
      IP2Bus_RetryOut                   => IP2Bus_RetryOut,
      IP2Bus_ErrorOut                   => IP2Bus_ErrorOut,
      IP2Bus_ToutSupOut                 => IP2Bus_ToutSupOut,
      IP2Bus_RdAckOut                   => IP2Bus_RdAckOut,
      IP2Bus_WrAckOut                   => IP2Bus_WrAckOut,
		
		PLB_MAddrAckOut                   => PLB_MAddrAckOut,
      PLB_MSSizeOut                     => PLB_MSSizeOut,
      PLB_MRearbitrateOut               => PLB_MRearbitrateOut,
      PLB_MBusyOut                      => PLB_MBusyOut,
      PLB_MErrOut                       => PLB_MErrOut,
      PLB_MWrDAckOut                    => PLB_MWrDAckOut,
      PLB_MRdDBusOut                    => PLB_MRdDBusOut,
      PLB_MRdWdAddrOut                  => PLB_MRdWdAddrOut,
      PLB_MRdDAckOut                    => PLB_MRdDAckOut,
      PLB_MRdBTermOut                   => PLB_MRdBTermOut,
      PLB_MWrBTermOut                   => PLB_MWrBTermOut,
      M_requestOut                      => M_requestOut,
      M_priorityOut                     => M_priorityOut,
      M_busLockOut                      => M_busLockOut,
      M_RNWOut                          => M_RNWOut,
      M_BEOut                           => M_BEOut,
      M_MSizeOut                        => M_MSizeOut,
      M_sizeOut                         => M_sizeOut,
      M_typeOut                         => M_typeOut,
      M_compressOut                     => M_compressOut,
      M_guardedOut                      => M_guardedOut,
      M_orderedOut                      =>M_orderedOut,
      M_lockErrOut                      => M_lockErrOut,
      M_abortOut                        => M_abortOut,
      M_ABusOut                         => M_ABusOut,
      M_wrDBusOut                       => M_wrDBusOut,
      M_wrBurstOut                      => M_wrBurstOut,
      M_rdBurstOut                      => M_rdBurstOut,
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      Bus2IP_Clk                     => iBus2IP_Clk,
      Bus2IP_Reset                   => iBus2IP_Reset,
      IP2Bus_IntrEvent               => iIP2Bus_IntrEvent,
      Bus2IP_Addr                    => iBus2IP_Addr,
      Bus2IP_Data                    => uBus2IP_Data,
      Bus2IP_BE                      => uBus2IP_BE,
      Bus2IP_CS                      => uBus2IP_CS,
      Bus2IP_RdCE                    => uBus2IP_RdCE,
      Bus2IP_WrCE                    => uBus2IP_WrCE,
      Bus2IP_RdReq                   => iBus2IP_RdReq,
      Bus2IP_WrReq                   => iBus2IP_WrReq,
      IP2Bus_Data                    => uIP2Bus_Data,
      IP2Bus_Retry                   => iIP2Bus_Retry,
      IP2Bus_Error                   => iIP2Bus_Error,
      IP2Bus_ToutSup                 => iIP2Bus_ToutSup,
      IP2Bus_RdAck                   => iIP2Bus_RdAck,
      IP2Bus_WrAck                   => iIP2Bus_WrAck,
		
		PLB_MAddrAck                   => PLB_MAddrAck,
      PLB_MSSize                     => PLB_MSSize,
      PLB_MRearbitrate               => PLB_MRearbitrate,
      PLB_MBusy                      => PLB_MBusy,
      PLB_MErr                       => PLB_MErr,
      PLB_MWrDAck                    => PLB_MWrDAck,
      PLB_MRdDBus                    => PLB_MRdDBus,
      PLB_MRdWdAddr                  => PLB_MRdWdAddr,
      PLB_MRdDAck                    => PLB_MRdDAck,
      PLB_MRdBTerm                   => PLB_MRdBTerm,
      PLB_MWrBTerm                   => PLB_MWrBTerm,
      M_request                      => M_request,
      M_priority                     => M_priority,
      M_busLock                      => M_busLock,
      M_RNW                          => M_RNW,
      M_BE                           => M_BE,
      M_MSize                        => M_MSize,
      M_size                         => M_size,
      M_type                         => M_type,
      M_compress                     => M_compress,
      M_guarded                      => M_guarded,
      M_ordered                      =>M_ordered,
      M_lockErr                      => M_lockErr,
      M_abort                        => M_abort,
      M_ABus                         => M_ABus,
      M_wrDBus                       => M_wrDBus,
      M_wrBurst                      => M_wrBurst,
      M_rdBurst                      => M_rdBurst
    );

  ------------------------------------------
  -- hooking up signal slicing
  ------------------------------------------
  uBus2IP_Data <= iBus2IP_Data(0 to USER_DWIDTH-1);
  uBus2IP_BE <= iBus2IP_BE(0 to USER_DWIDTH/8-1);
  uBus2IP_CS <= iBus2IP_CS(USER_CS_INDEX to USER_CS_INDEX+USER_NUM_CS-1);
  uBus2IP_RdCE(0 to USER_NUM_MASTER_CE-1) <= iBus2IP_RdCE(USER_MASTER_CE_INDEX to USER_MASTER_CE_INDEX+USER_NUM_MASTER_CE-1);
  uBus2IP_WrCE(0 to USER_NUM_MASTER_CE-1) <= iBus2IP_WrCE(USER_MASTER_CE_INDEX to USER_MASTER_CE_INDEX+USER_NUM_MASTER_CE-1);
  iIP2Bus_Data(0 to USER_DWIDTH-1) <= uIP2Bus_Data;

end IMP;
