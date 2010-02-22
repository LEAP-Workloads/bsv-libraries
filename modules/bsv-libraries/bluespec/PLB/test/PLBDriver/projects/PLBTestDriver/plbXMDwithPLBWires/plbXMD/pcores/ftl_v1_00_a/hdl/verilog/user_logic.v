//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------
// Filename:          user_logic.v
// Version:           1.00.a
// Description:       User logic module.
// Date:              Sat May 31 14:05:36 2008 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

module user_logic
(
  Bus2IP_ClkOut,                     // Bus to IP clock
  Bus2IP_ResetOut,                   // Bus to IP reset
  IP2Bus_IntrEventOut,               // IP to Bus interrupt event
  Bus2IP_AddrOut,                    // Bus to IP address bus
  Bus2IP_DataOut,                    // Bus to IP data bus for user logic
  Bus2IP_BEOut,                      // Bus to IP byte enables for user logic
  Bus2IP_CSOut,                      // Bus to IP chip select for user logic
  Bus2IP_RdCEOut,                    // Bus to IP read chip enable for user logic
  Bus2IP_WrCEOut,                    // Bus to IP write chip enable for user logic
  Bus2IP_RdReqOut,                   // Bus to IP read request
  Bus2IP_WrReqOut,                   // Bus to IP write request
  IP2Bus_DataOut,                    // IP to Bus data bus for user logic
  IP2Bus_RetryOut,                   // IP to Bus retry response
  IP2Bus_ErrorOut,                   // IP to Bus error response
  IP2Bus_ToutSupOut,                 // IP to Bus timeout suppress
  IP2Bus_RdAckOut,                   // IP to Bus read transfer acknowledgement
  IP2Bus_WrAckOut,                   // IP to Bus write transfer acknowledgement
  
  //plb master interface
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

  Bus2IP_Clk,                     // Bus to IP clock
  Bus2IP_Reset,                   // Bus to IP reset
  IP2Bus_IntrEvent,               // IP to Bus interrupt event
  Bus2IP_Addr,                    // Bus to IP address bus
  Bus2IP_Data,                    // Bus to IP data bus for user logic
  Bus2IP_BE,                      // Bus to IP byte enables for user logic
  Bus2IP_CS,                      // Bus to IP chip select for user logic
  Bus2IP_RdCE,                    // Bus to IP read chip enable for user logic
  Bus2IP_WrCE,                    // Bus to IP write chip enable for user logic
  Bus2IP_RdReq,                   // Bus to IP read request
  Bus2IP_WrReq,                   // Bus to IP write request
  IP2Bus_Data,                    // IP to Bus data bus for user logic
  IP2Bus_Retry,                   // IP to Bus retry response
  IP2Bus_Error,                   // IP to Bus error response
  IP2Bus_ToutSup,                 // IP to Bus timeout suppress
  IP2Bus_RdAck,                   // IP to Bus read transfer acknowledgement
  IP2Bus_WrAck,                   // IP to Bus write transfer acknowledgement
  
  //plb master interface
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
	M_busLock,
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
	M_rdBurst
); // user_logic

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
parameter C_ADDR_WIDTH								= 17; //C_BUFFER_ADDR_WIDTH + log2(C_MAX_BUSSES*2)+1
parameter C_BUFFER_ADDR_WIDTH						= 13; //16384 bytes
parameter C_BUFFER_SIZE								= 8192;
parameter C_MAX_BUSSES								= 4;
parameter C_BASEADDR									= 32'h20600000;
parameter C_MAX_CHIPS								= 16;
parameter C_MAX_CHIPS_LOG2							= 4;

parameter C_MAX_CHIPS_N								= 32 - C_MAX_CHIPS;

parameter C_B0_DRAM_TRANS_ENABLE					= 1;
parameter C_B1_DRAM_TRANS_ENABLE					= 1;
parameter C_B2_DRAM_TRANS_ENABLE					= 1;
parameter C_B3_DRAM_TRANS_ENABLE					= 1;

parameter C_B0_WRITE_LOW_COUNT					= 1;
parameter C_B0_WRITE_HIGH_COUNT					= 0;
parameter C_B0_READ_LOW_COUNT						= 1;
parameter C_B0_READ_HIGH_COUNT					= 0;

parameter C_B1_WRITE_LOW_COUNT					= 1;
parameter C_B1_WRITE_HIGH_COUNT					= 0;
parameter C_B1_READ_LOW_COUNT						= 1;
parameter C_B1_READ_HIGH_COUNT					= 0;

parameter C_B2_WRITE_LOW_COUNT					= 1;
parameter C_B2_WRITE_HIGH_COUNT					= 0;
parameter C_B2_READ_LOW_COUNT						= 1;
parameter C_B2_READ_HIGH_COUNT					= 0;

parameter C_B3_WRITE_LOW_COUNT					= 1;
parameter C_B3_WRITE_HIGH_COUNT					= 0;
parameter C_B3_READ_LOW_COUNT						= 1;
parameter C_B3_READ_HIGH_COUNT					= 0;


//transfer state machine
localparam TRANS_IDLE = 0;
localparam TRANS_READ = 1;
localparam TRANS_WRITE = 2;
localparam TRANS_WAIT_ADDR_ACK = 3;
localparam TRANS_WAIT_READ_ACK = 4;
localparam TRANS_WAIT_WRITE_ACK = 5;
localparam TRANS_DONE = 6;


//bus state machine
localparam BUS_IDLE = 0;

localparam BUS_SELECT_CHIP = 1;

localparam BUS_RESET = 2;
localparam BUS_RESET_WAIT = 3;
localparam BUS_RESET_COMPLETE = 4;

localparam BUS_READID = 5;
localparam BUS_READID_WAIT = 6;
localparam BUS_READID_COMPLETE = 7;

localparam BUS_READ = 8;
localparam BUS_READ_WAIT = 9;
localparam BUS_READ_TRANSFER = 10;
localparam BUS_READ_COMPLETE = 11;

localparam BUS_WRITE_TRANSFER = 12;
localparam BUS_WRITE = 13;
localparam BUS_WRITE_WAIT = 14;
localparam BUS_WRITE_COMPLETE = 15;

localparam BUS_ERASE = 16;
localparam BUS_ERASE_WAIT = 17;
localparam BUS_ERASE_COMPLETE = 18;


// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_AWIDTH                       = 32;
parameter C_DWIDTH                       = 64;
parameter C_NUM_CS                       = 1;
parameter C_NUM_CE                       = 2;
parameter C_IP_INTR_NUM                  = 1;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
output                                     Bus2IP_ClkOut;
output                                     Bus2IP_ResetOut;
input     [0 : C_IP_INTR_NUM-1]          IP2Bus_IntrEventOut;
output      [0 : C_AWIDTH-1]               Bus2IP_AddrOut;
output      [0 : C_DWIDTH-1]               Bus2IP_DataOut;
output      [0 : C_DWIDTH/8-1]             Bus2IP_BEOut;
output      [0 : C_NUM_CS-1]               Bus2IP_CSOut;
output      [0 : C_NUM_CE-1]               Bus2IP_RdCEOut;
output      [0 : C_NUM_CE-1]               Bus2IP_WrCEOut;
output                                     Bus2IP_RdReqOut;
output                                     Bus2IP_WrReqOut;
input     [0 : C_DWIDTH-1]               IP2Bus_DataOut;
input                                    IP2Bus_RetryOut;
input                                    IP2Bus_ErrorOut;
input                                    IP2Bus_ToutSupOut;
input                                    IP2Bus_RdAckOut;
input                                    IP2Bus_WrAckOut;


output						PLB_MAddrAckOut;
output	[0:1] 			PLB_MSSizeOut;
output						PLB_MRearbitrateOut;
output						PLB_MBusyOut;
output						PLB_MErrOut;
output						PLB_MWrDAckOut;
output	[0:63] 			PLB_MRdDBusOut;
output	[0:3] 			PLB_MRdWdAddrOut;
output						PLB_MRdDAckOut;
output						PLB_MRdBTermOut;
output						PLB_MWrBTermOut;
input					M_requestOut; 	//
input	[0:1] 		M_priorityOut;
input					M_busLockOut; 	//
input					M_RNWOut;     	//
input	[0:7] 		M_BEOut;
input	[0:1] 		M_MSizeOut;
input	[0:3] 		M_sizeOut;
input	[0:2] 		M_typeOut;
input					M_compressOut;
input					M_guardedOut;
input					M_orderedOut;
input					M_lockErrOut;
input					M_abortOut;
input	[0:31] 		M_ABusOut;		//
input	[0:63] 		M_wrDBusOut;	//
input					M_wrBurstOut;
input					M_rdBurstOut;
// -- ADD USER PORTS ABOVE THIS LINE -----------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol ports, do not add to or delete
input                                     Bus2IP_Clk;
input                                     Bus2IP_Reset;
output     [0 : C_IP_INTR_NUM-1]          IP2Bus_IntrEvent;
input      [0 : C_AWIDTH-1]               Bus2IP_Addr;
input      [0 : C_DWIDTH-1]               Bus2IP_Data;
input      [0 : C_DWIDTH/8-1]             Bus2IP_BE;
input      [0 : C_NUM_CS-1]               Bus2IP_CS;
input      [0 : C_NUM_CE-1]               Bus2IP_RdCE;
input      [0 : C_NUM_CE-1]               Bus2IP_WrCE;
input                                     Bus2IP_RdReq;
input                                     Bus2IP_WrReq;
output     [0 : C_DWIDTH-1]               IP2Bus_Data;
output                                    IP2Bus_Retry;
output                                    IP2Bus_Error;
output                                    IP2Bus_ToutSup;
output                                    IP2Bus_RdAck;
output                                    IP2Bus_WrAck;


input						PLB_MAddrAck;
input	[0:1] 			PLB_MSSize;
input						PLB_MRearbitrate;
input						PLB_MBusy;
input						PLB_MErr;
input						PLB_MWrDAck;
input	[0:63] 			PLB_MRdDBus;
input	[0:3] 			PLB_MRdWdAddr;
input						PLB_MRdDAck;
input						PLB_MRdBTerm;
input						PLB_MWrBTerm;
output					M_request; 	//
output	[0:1] 		M_priority;
output					M_busLock; 	//
output					M_RNW;     	//
output	[0:7] 		M_BE;
output	[0:1] 		M_MSize;
output	[0:3] 		M_size;
output	[0:2] 		M_type;
output					M_compress;
output					M_guarded;
output					M_ordered;
output					M_lockErr;
output					M_abort;
output	[0:31] 		M_ABus;		//
output	[0:63] 		M_wrDBus;	//
output					M_wrBurst;
output					M_rdBurst;


// Now pipe all these wires in reverse




// And tie everything together...


assign Bus2IP_ClkOut = Bus2IP_Clk;
assign Bus2IP_ResetOut = Bus2IP_Reset;
assign IP2Bus_IntrEvent = IP2Bus_IntrEventOut;
assign Bus2IP_AddrOut = Bus2IP_Addr;
assign Bus2IP_DataOut = Bus2IP_Data;
assign Bus2IP_BEOut = Bus2IP_BE;
assign Bus2IP_CSOut = Bus2IP_CS;
assign Bus2IP_RdCEOut = Bus2IP_RdCE;
assign Bus2IP_WrCEOut = Bus2IP_WrCE;
assign Bus2IP_RdReqOut = Bus2IP_RdReq;
assign Bus2IP_WrReqOut = Bus2IP_WrReq;
assign IP2Bus_Data = IP2Bus_DataOut;
assign IP2Bus_Retry = IP2Bus_RetryOut;
assign IP2Bus_Error = IP2Bus_ErrorOut;
assign IP2Bus_ToutSup = IP2Bus_ToutSupOut;
assign IP2Bus_RdAck = IP2Bus_RdAckOut;
assign IP2Bus_WrAck = IP2Bus_WrAckOut;


assign PLB_MAddrAckOut = PLB_MAddrAck;
assign PLB_MSSizeOut = PLB_MSSize;
assign PLB_MRearbitrateOut = PLB_MRearbitrate;
assign PLB_MBusyOut = PLB_MBusy;
assign PLB_MErrOut = PLB_MErr;
assign PLB_MWrDAckOut = PLB_MWrDAck;
assign PLB_MRdDBusOut = PLB_MRdDBus;
assign PLB_MRdWdAddrOut = PLB_MRdWdAddr;
assign PLB_MRdDAckOut = PLB_MRdDAck;
assign PLB_MRdBTermOut = PLB_MRdBTerm;
assign PLB_MWrBTermOut = PLB_MWrBTerm;
assign M_request = M_requestOut; 
assign M_priority = M_priorityOut;
assign M_busLock = M_busLockOut;
assign M_RNW = M_RNWOut;
assign M_BE = M_BEOut;
assign M_MSize = M_MSizeOut;
assign M_size = M_sizeOut;
assign M_type = M_typeOut;
assign M_compress = M_compressOut;
assign M_guarded = M_guardedOut;
assign M_ordered = M_orderedOut;
assign M_lockErr = M_lockErrOut;
assign M_abort = M_abortOut;
assign M_ABus = M_ABusOut;
assign M_wrDBus = M_wrDBusOut;
assign M_wrBurst = M_wrBurstOut;
assign M_rdBurst = M_rdBurstOut;

endmodule





