/*
Bus Controller Module

Responsible for actual interaction with flash chips over a bus
*/
module bus_controller(
	clk,
	reset,
	busy,
	operation,
	chip,
	addr,
	length,
	start,
	
	readybits,
	statusbits,
	existsbits,
	
	buffernum,
	bufferin,
	bufferout,
	bufferaddr,
	bufferwe,
	
	busdatain,
	busdataout,
	busdatatri,
	buswe,
	busre,
	busces,
	buscle,
	busale,
	buswp,
	busrb,
	busrbs,
	
	WriteLowCount,
	WriteHighCount,
	ReadLowCount,
	ReadHighCount
	
	);
	
	input [0:3] WriteLowCount;
	input [0:3] WriteHighCount;
	input [0:3] ReadLowCount;
	input [0:3] ReadHighCount;
	
	parameter MAXCHIPS = 32;
	parameter MAXCHIPSLOG2 = 5;
	
	input clk;
	input reset;
	output busy;
	input [0:3] operation;
	input [0:MAXCHIPSLOG2-1] chip;
	input [0:39] addr;
	input [0:13] length;
	input buffernum;
	input start;
	
	output [0:MAXCHIPS-1] readybits;
	output [0:MAXCHIPS-1] statusbits;
	output [0:MAXCHIPS-1] existsbits;
	
	output [0:7] bufferin;
	input [0:7] bufferout;
	output [0:13] bufferaddr;
	output bufferwe;
	
	input [0:7] busdatain;
	output [0:7] busdataout;
	output [0:7] busdatatri;
	output buswe;
	output busre;
	output [0:MAXCHIPSLOG2-1] busces;
	output buscle;
	output busale;
	output buswp;
	output [0:MAXCHIPSLOG2-1] busrbs;
	input busrb;
	
	assign buswp = 1;
	
	localparam OP_CHECKSTATUS = 0;
	localparam OP_RESET = 1;
	localparam OP_STARTREAD = 2;
	localparam OP_COMPLETEREAD = 3;
	localparam OP_PROGRAM = 4;
	localparam OP_ERASE = 5;
	localparam OP_READID = 6;
	localparam OP_READPARAM = 7;
	
	
	//chip manufacturer codes
	
	
	localparam NAND_MFR_TOSHIBA  =      8'h98;
	localparam NAND_MFR_TOSHIBA2 = 		8'h94;
	localparam NAND_MFR_TOSHIBA3 =      8'h84;
	localparam NAND_MFR_SAMSUNG  =      8'hec;
	localparam NAND_MFR_FUJITSU  =      8'h04;
	localparam NAND_MFR_NATIONAL =      8'h8f;
	localparam NAND_MFR_RENESAS  =      8'h07;
	localparam NAND_MFR_STMICRO  =      8'h20;
	localparam NAND_MFR_HYNIX    =      8'had;
	localparam NAND_MFR_MICRON   =      8'h2c;
	

	
	reg [0:7] regBusDataIn;
	
	reg	[0:MAXCHIPS-1]	regReadyBits;
	assign	readybits = regReadyBits;
	
	reg	[0:MAXCHIPS-1]	regStatusBits;
	assign	statusbits = regStatusBits;
	reg	[0:MAXCHIPS-1]	regChipExistsBits;
	assign	existsbits = regChipExistsBits;
	
	reg	[0:MAXCHIPS-1]	regChipIsToshiba;
	
	integer chip_num;
	
	reg					regBusy;
	reg	[0:3]			regOp;
	reg	[0:MAXCHIPSLOG2-1]			regChip;
	reg	[0:39]		regAddr;
	reg	[0:13]		regLength;
	reg					regBufferNum;
	reg	[0:7]			regBufferWriteData;
	reg					regBufferWE;
	reg	[0:12]		regBufferAddr;
	
	reg	[0:7]			regBusData;
	reg					regBusWE;
	reg					regBusRE;
	reg	[0:MAXCHIPSLOG2-1]		regBusCEs;
	reg	[0:MAXCHIPSLOG2-1]		regBusRBs;
	reg					regBusCLE;
	reg					regBusALE;
	
	reg					regBusDir;
	
	
	reg	[0:7]			State;
	
	reg 	[0:7] 		ReturnState;
	reg 	[0:7] 		WaitReturnState;
	reg 	[0:7]			DelayReturnState;	 
	reg 	[0:31]		DelayCount;
	reg	[0:18]		WaitCount;
	
	reg 	[0:13]		ByteCounter;
	
	reg	[0:7]			Command;
	
	
	
	
	//-------------------------------------------
	//    States
	//-------------------------------------------
	localparam STATE_IDLE 						= 0;
	
	localparam STATE_DELAY						= 1;
	
	localparam STATE_WAIT_READY_STATUS		= 3;
	localparam STATE_WAIT_READY_STATUS2		= 4;
	localparam STATE_WAIT_READY_STATUS3		= 5;
	localparam STATE_WAIT_READY_STATUS4		= 6;
	localparam STATE_WAIT_READY_STATUS5		= 7;
	localparam STATE_WAIT_READY_STATUS6		= 8;

	localparam STATE_CHECK_STATUS				= 10;
	localparam STATE_CHECK_STATUS2			= 11;
	localparam STATE_CHECK_STATUS3			= 12;
	localparam STATE_CHECK_STATUS4			= 13;
	localparam STATE_CHECK_STATUS5			= 14;
	
	localparam STATE_RESET						= 20;
	localparam STATE_RESET1						= 21;
	localparam STATE_RESET2						= 22;
	localparam STATE_RESET3						= 23;
	localparam STATE_RESET4						= 24;
	localparam STATE_RESET5						= 25;
	localparam STATE_RESET6						= 26;
	localparam STATE_RESET7						= 27;
	localparam STATE_RESET8						= 28;
	localparam STATE_RESET9						= 29;
	localparam STATE_RESET10					= 30;
	localparam STATE_RESET11					= 31;
	localparam STATE_RESET12					= 32;
	localparam STATE_RESET13					= 33;
	localparam STATE_RESET14					= 34;
	localparam STATE_RESET15					= 35;
	localparam STATE_RESET16					= 36;
	localparam STATE_RESET17					= 37;
	localparam STATE_RESET18					= 38;
	localparam STATE_RESET19					= 39;
	localparam STATE_RESET20					= 40;
	localparam STATE_RESET21					= 41;
	localparam STATE_RESET22					= 42;
	localparam STATE_RESET23					= 43;
	localparam STATE_RESET24					= 44;
	
	 
	localparam STATE_BLOCKERASE				= 50;
	localparam STATE_BLOCKERASE2				= 51;
	localparam STATE_BLOCKERASE3				= 52;
	localparam STATE_BLOCKERASE4				= 54;
	localparam STATE_BLOCKERASE5				= 55;

	localparam STATE_WRITEPAGE					= 60;
	localparam STATE_WRITEPAGE2				= 61;
	localparam STATE_WRITEPAGE3				= 62;
	localparam STATE_WRITEPAGEd0				= 63;
	localparam STATE_WRITEPAGEd1				= 64;
	localparam STATE_WRITEPAGEd2				= 65;
	localparam STATE_WRITEPAGEd3				= 66;
	localparam STATE_WRITEPAGEd4				= 67;
	localparam STATE_WRITEPAGEd5				= 68;
	localparam STATE_WRITEPAGEd5b				= 75;
	localparam STATE_WRITEPAGEd6				= 69;
	localparam STATE_WRITEPAGE4				= 70;
	localparam STATE_WRITEPAGE5				= 71;

	localparam STATE_SEND_COMMAND				= 80;
	localparam STATE_SEND_COMMAND1			= 81;
	localparam STATE_SEND_COMMAND2			= 82;
	localparam STATE_SEND_COMMAND3			= 83;
	
	localparam STATE_SEND_TOSH_ADDRESS		= 89;
	localparam STATE_SEND_SINGLE_ADDRESS	= 90;
	localparam STATE_SEND_BLOCK_ADDRESS		= 91;
	localparam STATE_SEND_FULL_ADDRESS		= 92;
	localparam STATE_SEND_FULL_ADDRESS1		= 93;
	localparam STATE_SEND_FULL_ADDRESS2		= 94;
	localparam STATE_SEND_FULL_ADDRESS3		= 95;
	localparam STATE_SEND_FULL_ADDRESS4		= 96;
	localparam STATE_SEND_FULL_ADDRESS5		= 97;
	localparam STATE_SEND_FULL_ADDRESS6		= 98;
	localparam STATE_SEND_FULL_ADDRESS7		= 99;
	localparam STATE_SEND_FULL_ADDRESS8		= 100;
	localparam STATE_SEND_FULL_ADDRESS9		= 101;
	localparam STATE_SEND_FULL_ADDRESS10	= 102;
	localparam STATE_SEND_FULL_ADDRESS11	= 103;

 	localparam STATE_READ_PARAMPAGE			= 110;
	localparam STATE_READ_PARAMPAGE2			= 111;
	
	localparam STATE_READPAGE					= 120;
	localparam STATE_READPAGE2					= 121;
	localparam STATE_READPAGE3					= 122;
	
	localparam STATE_READPAGE4					= 130;
	localparam STATE_READPAGE5					= 131;
	localparam STATE_READPAGE6					= 132;
	localparam STATE_READPAGE7					= 133;
	localparam STATE_READPAGEd0				= 134;
	localparam STATE_READPAGEd1				= 135;
	localparam STATE_READPAGEd2				= 136;
	localparam STATE_READPAGEd3				= 137;
	localparam STATE_READPAGEd4				= 138;
	localparam STATE_READPAGEd5				= 139;
	localparam STATE_READPAGEd6				= 140;
	
	localparam STATE_READID						= 150;
	localparam STATE_READID2					= 151;
	localparam STATE_READID3					= 152;
	localparam STATE_READID4					= 153;
	localparam STATE_READID5					= 154;
	

	//-------------------------------------------
	//    Delays
	//-------------------------------------------
	localparam	DELAY_tADL				=5;
	localparam	DELAY_tALH				=5;
	localparam	DELAY_tCLH				=5;
	localparam	DELAY_tWW				=10;

	localparam	DELAY_tRR				=4;
	localparam	DELAY_tWHR				=5;

	localparam	DELAY_tWB				=8;
	localparam	DELAY_tWH				=4;
	localparam	DELAY_tWP				=4;
	localparam	DELAY_tREH				=4;
	localparam	DELAY_tRP				=4;
	 
	localparam	DELAY_CMD_WELOW		=30;
	localparam	DELAY_CMD_WEHIGH		=30;
	localparam	DELAY_ADDR_WELOW		=30;
	localparam	DELAY_ADDR_WEHIGH		=30;
	 
	localparam	DELAY_CMD_CLELOW		=20;
	localparam	DELAY_ADDR_ALELOW		=20;
	
	
	//-------------------------------------------
	//    Constants
	//-------------------------------------------
	//commands
	localparam	CMD_READID				=8'h90;
	localparam	CMD_RESET				=8'hFF;
	 
	localparam	CMD_BLOCKERASE0		=8'h60;
	localparam	CMD_BLOCKERASE1		=8'hD0;
	 
	localparam	CMD_WRITEPAGE0			=8'h80;
	localparam	CMD_WRITEPAGE1			=8'h10;
	
	localparam	CMD_READPAGE0			=8'h00;
	localparam	CMD_READPAGE1			=8'h30;
	
	localparam	CMD_READPAGE_TOSH0	=8'h00;
	localparam 	CMD_READPAGE_TOSH1	=8'h01;
	
	localparam 	CMD_READ_PARAMPAGE	=8'hEC;
	 
	localparam 	CMD_STATUS				=8'h70;
	localparam 	CMD_STATUS_ENHANCED	=8'h78;
	 
	localparam 	CMD_SETFEATURES		=8'hEF;
	
	//bus direction
	localparam 	DIR_OUT 					= 0;
	localparam 	DIR_IN 					= 1;
	
	localparam	LOW						= 0;
	localparam  HIGH						= 1;

	
	always @(posedge clk) begin
		regBusDataIn <= busdatain;
		if (reset) begin
			regBusy <= 0;
			regOp <= 0;
			regChip <= 0;
			regAddr <= 0;
			regBufferNum <= 0;
			regBufferWriteData <= 0;
			regBufferWE <= 0;
			regBufferAddr <= 0;
			
			regBusData <= 0;
			regBusWE <= HIGH;
			regBusRE <= HIGH;
			regBusCLE <= LOW;
			regBusALE <= LOW;
			
			State <= STATE_IDLE;
			regBusDir <= DIR_OUT;
			regReadyBits <= 0;
			regStatusBits <= 0;
			regChipExistsBits <= 0;
			for(chip_num=0; chip_num<MAXCHIPS;chip_num=chip_num+1) begin
				regReadyBits[chip_num] <= 1;
				regStatusBits[chip_num] <= 0;
				regChipExistsBits[chip_num] <= 0;
				regChipIsToshiba[chip_num] <= 0;
			end
			
			regBusCEs <= 0;
			regBusRBs <= 0;
		end else begin
			regBufferWE <= 0;
			
			case(State)
					STATE_IDLE: begin
						regBusy <= 0;
						WaitReturnState <= STATE_IDLE;
						if (start) begin
							regOp <= operation;
							regChip <= chip;
							regBusCEs <= chip;
							regAddr <= addr;
							regBufferNum <= buffernum;
							regBusy <= 1;
							regLength <= length;
						
							//We delay a cycle or two to allow CE to propagate through mux on board
							State <= STATE_DELAY;
							DelayCount <= 20;
							case(operation)
								OP_CHECKSTATUS: 	DelayReturnState <= STATE_CHECK_STATUS;
								OP_RESET: 			DelayReturnState <= STATE_RESET;
								OP_STARTREAD: 		DelayReturnState <= STATE_READPAGE;
								OP_COMPLETEREAD:	DelayReturnState <= STATE_READPAGE4;
								OP_PROGRAM:			DelayReturnState <= STATE_WRITEPAGE;
								OP_ERASE: 			DelayReturnState <= STATE_BLOCKERASE;
								OP_READID:			DelayReturnState <= STATE_READID;
								OP_READPARAM:		DelayReturnState <= STATE_READ_PARAMPAGE;
							endcase
						end
					end
					
					
					///////////////////////////////////////////////////////
					//DELAY LOOP
					///////////////////////////////////////////////////////
					STATE_DELAY: begin
						DelayCount <= DelayCount - 1;
						if (DelayCount == 0)
							State <= DelayReturnState;
					end
					
					
					///////////////////////////////////////////////////////
					//CHECK STATUS
					///////////////////////////////////////////////////////
					STATE_CHECK_STATUS: begin
						if (regBusRBs != regChip) begin
							State <= STATE_DELAY;
							DelayCount <= 20;
							DelayReturnState <= STATE_CHECK_STATUS2;
							regBusRBs <= regChip;
						end else begin
							State <= STATE_CHECK_STATUS2;
						end
					end
					STATE_CHECK_STATUS2: begin
						regReadyBits[regChip] <= busrb; //READY BIT from status byte
						State <= WaitReturnState;
					end
//					STATE_CHECK_STATUS: begin
//						State <= STATE_DELAY;
//						DelayCount <= DELAY_tWP;
//						DelayReturnState <= STATE_CHECK_STATUS2;
//						regBusCLE <= HIGH;
//						regBusRBs <= regChip;
//					end
//					STATE_CHECK_STATUS2: begin
//						State <= STATE_DELAY;
//						DelayCount <= DELAY_tWP;
//						DelayReturnState <= STATE_SEND_COMMAND;
//						ReturnState <= STATE_CHECK_STATUS3;
//						Command <= CMD_STATUS;
//					end
//					STATE_CHECK_STATUS3: begin
//						regBusCLE <= LOW;
//						regBusALE <= LOW;
//						regBusWE <= HIGH;
//						regBusRE <= HIGH;
//						State <= STATE_DELAY;
//						DelayCount <= DELAY_tWHR;
//						DelayReturnState <= STATE_CHECK_STATUS4;
//					end
//					STATE_CHECK_STATUS4: begin
//						State <= STATE_DELAY;
//						DelayCount <= DELAY_tRP;
//						DelayReturnState <= STATE_CHECK_STATUS5;
//						regBusRE <= LOW;
//						regBusDir <= DIR_IN;
//					end
//					STATE_CHECK_STATUS5: begin
//						regBusRE <= HIGH;
//						regStatusBits[regChip] <= busdatain[7]; //OPERATION RESULT BIT from status byte  (0=Success)
//						regReadyBits[regChip] <= busdatain[1]; //READY BIT from status byte
//						State <= STATE_DELAY;
//						DelayCount <= DELAY_tREH;
//						DelayReturnState <= WaitReturnState;
//					end
					
					
					///////////////////////////////////////////////////////
					//WAIT FOR READY AND CHECK STATUS
					///////////////////////////////////////////////////////
					STATE_WAIT_READY_STATUS: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWW;
						DelayReturnState <= STATE_WAIT_READY_STATUS2;
						regBusCLE <= HIGH;
						regBusRBs <= regChip;
					end
					STATE_WAIT_READY_STATUS2: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWP;
						DelayReturnState <= STATE_SEND_COMMAND;
						ReturnState <= STATE_WAIT_READY_STATUS3;
						Command <= CMD_STATUS;
					end
					STATE_WAIT_READY_STATUS3: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWHR;
						DelayReturnState <= STATE_WAIT_READY_STATUS4;
						regBusDir <= DIR_IN;
					end
					STATE_WAIT_READY_STATUS4: begin
						State <= STATE_DELAY;
						DelayCount <= 100;
						DelayReturnState <= STATE_WAIT_READY_STATUS5;
						regBusRE <= LOW;
						regBusDir <= DIR_IN;
					end
					STATE_WAIT_READY_STATUS5: begin
						regBusRE <= HIGH;
						
						regReadyBits[regChip] <= regBusDataIn[1]; //READY BIT from status byte
						regStatusBits[regChip] <= regBusDataIn[7]; //OPERATION RESULT BIT from status byte  (0=Success)
						
						State <= STATE_DELAY;
						DelayCount <= DELAY_tREH;
						DelayReturnState <= STATE_WAIT_READY_STATUS6;
					end
					
					STATE_WAIT_READY_STATUS6: begin
						State <= STATE_WAIT_READY_STATUS;
						WaitCount <= WaitCount + 1;
						if (WaitCount[0] || regReadyBits[regChip]) begin
							State <= WaitReturnState;
						end
					end
					
					
					///////////////////////////////////////////////////////
					//WRITE PAGE SEQUENCE
					///////////////////////////////////////////////////////
					STATE_WRITEPAGE: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_WRITEPAGE2;
						Command <= CMD_WRITEPAGE0;
					end
					STATE_WRITEPAGE2: begin
						State <= STATE_SEND_FULL_ADDRESS;
						ReturnState <= STATE_WRITEPAGE3;
						ByteCounter <= 0;
						regBufferAddr <= 0;
					end
					STATE_WRITEPAGE3: begin
						regBusCLE <= LOW;
						regBusALE <= LOW;
						regBusWE <= HIGH;
						regBusRE <= HIGH;
						State <= STATE_WRITEPAGEd0;
					end
					
					//byte write loop
					STATE_WRITEPAGEd0: begin
						if (WriteLowCount == 0)
							State <= STATE_WRITEPAGEd1;
						else
							State <= STATE_DELAY;
						DelayCount <= WriteLowCount - 1;
						DelayReturnState <= STATE_WRITEPAGEd1;
						
						regBusData <= bufferout;
						regBusDir <= DIR_OUT;
						ByteCounter <= ByteCounter + 1;
						regBufferAddr <= regBufferAddr + 1;
						regBusWE <= LOW;
					
					end
					STATE_WRITEPAGEd1: begin
						if (ByteCounter == regLength)
							State <= STATE_WRITEPAGE4;
						else begin
							if (WriteHighCount == 0)
								State <= STATE_WRITEPAGEd0;
							else
								State <= STATE_DELAY;
						end
						DelayCount <= WriteHighCount - 1;
						DelayReturnState <= STATE_WRITEPAGEd0;
						
						regBusWE <= HIGH;
					end
					//end loop
					
					STATE_WRITEPAGE4: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_WRITEPAGE5;
						Command <= CMD_WRITEPAGE1;
					end
					STATE_WRITEPAGE5: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWB;
						DelayReturnState <= STATE_IDLE;
						regReadyBits[regChip] <= 0;
					end
					
					
					///////////////////////////////////////////////////////
					//START READ PAGE SEQUENCE
					///////////////////////////////////////////////////////
					STATE_READPAGE: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_READPAGE2;
						if (regChipIsToshiba[regChip]) begin
							if (regAddr[31]) begin
								Command <= CMD_READPAGE_TOSH1;
							end else begin
								Command <= CMD_READPAGE_TOSH0;
							end
						end else begin
							Command <= CMD_READPAGE0;
						end
					end
					STATE_READPAGE2: begin
						if (regChipIsToshiba[regChip]) begin
							State <= STATE_SEND_TOSH_ADDRESS;
						end else begin
							State <= STATE_SEND_FULL_ADDRESS;
						end
						ReturnState <= STATE_READPAGE3;
					end
					STATE_READPAGE3: begin
						ReturnState <= STATE_IDLE;
						Command <= CMD_READPAGE1;
						if (regChipIsToshiba[regChip]) begin	
							//toshiba devices don't require a second command to begin the read
							State <= STATE_IDLE;
						end else begin
							State <= STATE_SEND_COMMAND;
						end
						regReadyBits[regChip] <= 0;
					end
					
					
					///////////////////////////////////////////////////////
					//COMPLETE READ PAGE SEQUENCE
					///////////////////////////////////////////////////////
					STATE_READPAGE4: begin 
						State <= STATE_READPAGE5;
//						State <= STATE_SEND_COMMAND;
//						ReturnState <= STATE_READPAGE5;
//						Command <= CMD_READPAGE0;
//						regBusALE <= LOW;
//						regBusCLE <= LOW;
//						regBusRE <= HIGH;
//						regBusWE <= HIGH;
					end
					STATE_READPAGE5: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWB;
						DelayReturnState <= STATE_READPAGE6;
					end
					STATE_READPAGE6: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tRR;
						DelayReturnState <= STATE_READPAGE7;
						regBusDir <= DIR_IN;
					end
					
					STATE_READPAGE7: begin
						State <= STATE_READPAGEd0;
						ByteCounter <= 0;
						regBufferAddr <= 0;
					end
					
					//byte read loop
					STATE_READPAGEd0: begin
						regBusRE <= LOW;
						if (ReadLowCount == 0)
							State <= STATE_READPAGEd1;
						else
							State <= STATE_DELAY;
						DelayCount <= ReadLowCount - 1;
						DelayReturnState <= STATE_READPAGEd1;
					end
					STATE_READPAGEd1: begin
						regBusRE <= HIGH;
						
						if (ByteCounter == regLength) begin
							State <= STATE_IDLE;
						end else begin
							if (ReadHighCount == 0)
								State <= STATE_READPAGEd2;
							else
								State <= STATE_DELAY;
						end
						DelayCount <= ReadHighCount - 1;
						DelayReturnState <= STATE_READPAGEd2;						
					end
					STATE_READPAGEd2: begin
						regBufferWriteData <= busdatain;
						regBufferAddr <= ByteCounter;
						regBufferWE <= 1;
						ByteCounter <= ByteCounter + 1;
						regBusRE <= LOW;
						if (ReadLowCount == 0)
							State <= STATE_READPAGEd1;
						else
							State <= STATE_DELAY;
						DelayCount <= ReadLowCount - 1;
						DelayReturnState <= STATE_READPAGEd1;

					
					end
					
					//end loop
					
					
					///////////////////////////////////////////////////////
					//READ PARAM PAGE
					///////////////////////////////////////////////////////
					STATE_READ_PARAMPAGE: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_READ_PARAMPAGE2;
						Command <= CMD_READ_PARAMPAGE;
					end
					STATE_READ_PARAMPAGE2: begin
						State <= STATE_SEND_SINGLE_ADDRESS;
						ReturnState <= STATE_IDLE;
						regBusData <= 8'h00;
						regReadyBits[regChip] <= 0;
					end
					
					///////////////////////////////////////////////////////
					//READ ID PAGE
					///////////////////////////////////////////////////////
					STATE_READID: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_READID2;
						Command <= CMD_READID;
					end
					STATE_READID2: begin
						State <= STATE_SEND_SINGLE_ADDRESS;
						ReturnState <= STATE_READID3;
						regBusData <= 8'h00; //single 00 address cycle per datasheet
					end
					STATE_READID3: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tADL;
						DelayReturnState <= STATE_READID4;
						ByteCounter <= 0;
					end
					
					STATE_READID4: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tRP;
						DelayReturnState <= STATE_READID5;
						regBusRE <= LOW;
						regBusDir <= DIR_IN;
					end
					STATE_READID5: begin
						regBusRE <= HIGH;
						
						regBufferWriteData <= regBusDataIn;
						regBufferAddr <= ByteCounter;
						regBufferWE <= 1;
						ByteCounter <= ByteCounter + 1;
						
						State <= STATE_DELAY;
						DelayCount <= DELAY_tRP;
						if (ByteCounter == 3)
							DelayReturnState <= STATE_IDLE;
						else
							DelayReturnState <= STATE_READID4;
					end
		
					///////////////////////////////////////////////////////
					//BLOCK ERASE SEQUENCE
					///////////////////////////////////////////////////////
					STATE_BLOCKERASE: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_BLOCKERASE2;
						Command <= CMD_BLOCKERASE0;
					end
					STATE_BLOCKERASE2: begin
						State <= STATE_SEND_BLOCK_ADDRESS;
						ReturnState <= STATE_BLOCKERASE3;
					end
					STATE_BLOCKERASE3: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_BLOCKERASE4;
						Command <= CMD_BLOCKERASE1;
					end
					STATE_BLOCKERASE4: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWB;
						DelayReturnState <= STATE_IDLE;
						regReadyBits[regChip] <= 0;
					end
					
					
					///////////////////////////////////////////////////////
					//RESET SEQUENCE
					///////////////////////////////////////////////////////
					STATE_RESET: begin
						State <= STATE_DELAY;
						DelayCount <= 1000;
						DelayReturnState <= STATE_RESET1;
					end
					STATE_RESET1: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_RESET2;
						Command <= CMD_RESET;
					end
					STATE_RESET2: begin
						State <= STATE_DELAY;
						DelayCount <= 100;
						WaitCount <= 0;
						DelayReturnState <= STATE_WAIT_READY_STATUS;
						WaitReturnState <= STATE_RESET6;
					end
					
					STATE_RESET6: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_RESET7;
						Command <= CMD_SETFEATURES;
					end
					STATE_RESET7: begin
						State <= STATE_SEND_SINGLE_ADDRESS;
						ReturnState <= STATE_RESET8;
						regBusData <= 8'h01; //CHANGE TIMING MODE COMMAND
					end
					STATE_RESET8: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tADL;
						DelayReturnState <= STATE_RESET9;
					end
					STATE_RESET9: begin
						regBusDir <= DIR_OUT;
						regBusData <= 8'h04;  //SET TIMING MODE 4
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWP;
						DelayReturnState <= STATE_RESET10;
						regBusWE <= LOW;
					end
					STATE_RESET10: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWH;
						DelayReturnState <= STATE_RESET11;
						regBusWE <= HIGH;
					end
					STATE_RESET11: begin
						regBusData <= 8'h00;  
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWP;
						DelayReturnState <= STATE_RESET12;
						regBusWE <= LOW;
					end
					STATE_RESET12: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWH;
						DelayReturnState <= STATE_RESET13;
						regBusWE <= HIGH;
					end
					STATE_RESET13: begin
						regBusData <= 8'h00; 
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWP;
						DelayReturnState <= STATE_RESET14;
						regBusWE <= LOW;
					end
					STATE_RESET14: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWH;
						DelayReturnState <= STATE_RESET15;
						regBusWE <= HIGH;
					end
					STATE_RESET15: begin
						regBusData <= 8'h00;  
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWP;
						DelayReturnState <= STATE_RESET16;
						regBusWE <= LOW;
					end
					STATE_RESET16: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tWH;
						DelayReturnState <= STATE_RESET17;
						regBusWE <= HIGH;
					end
					STATE_RESET17: begin
						State <= STATE_DELAY;
						DelayCount <= 10000;
						DelayReturnState <= STATE_RESET18;
					end
					
					//Check Device MFG Code for known values
					STATE_RESET18: begin
						State <= STATE_SEND_COMMAND;
						ReturnState <= STATE_RESET19;
						Command <= CMD_READID;
					end
					STATE_RESET19: begin
						State <= STATE_SEND_SINGLE_ADDRESS;
						ReturnState <= STATE_RESET20;
						regBusData <= 8'h00; //single 00 address cycle per datasheet
					end
					STATE_RESET20: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tADL;
						DelayReturnState <= STATE_RESET21;
					end
					
					STATE_RESET21: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tRP;
						DelayReturnState <= STATE_RESET22;
						regBusRE <= LOW;
						regBusDir <= DIR_IN;
					end
					STATE_RESET22: begin
						regBusRE <= HIGH;
						
						/*if (regBusDataIn == NAND_MFR_TOSHIBA)
							regChipIsToshiba[regChip] <= 1; //Disabled
						else
							regChipIsToshiba[regChip] <= 0;*/
						
						if (regBusDataIn == NAND_MFR_TOSHIBA
						|| regBusDataIn == NAND_MFR_TOSHIBA2
						|| regBusDataIn == NAND_MFR_TOSHIBA3
						|| regBusDataIn == NAND_MFR_SAMSUNG
						|| regBusDataIn == NAND_MFR_FUJITSU
						|| regBusDataIn == NAND_MFR_NATIONAL
						|| regBusDataIn == NAND_MFR_RENESAS
						|| regBusDataIn == NAND_MFR_STMICRO
						|| regBusDataIn == NAND_MFR_HYNIX
						|| regBusDataIn == NAND_MFR_MICRON)
							regChipExistsBits[regChip] <= 1;
						else
							regChipExistsBits[regChip] <= 0;
													
						State <= STATE_IDLE;
					end
					
		
					/////////////////////////////////////////
					//Command and Address Sequences
					/////////////////////////////////////////
					STATE_SEND_COMMAND: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tCLH;
						DelayReturnState <= STATE_SEND_COMMAND1;
					end
					STATE_SEND_COMMAND1: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_CMD_WELOW;
						DelayReturnState <= STATE_SEND_COMMAND2;
						regBusCLE <= HIGH;
						regBusWE <= LOW;
						regBusRE <= HIGH;
						regBusALE <= LOW;
						regBusDir <= DIR_OUT;
						regBusData <= Command;
					end
					STATE_SEND_COMMAND2: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_CMD_WEHIGH;
						DelayReturnState <= STATE_SEND_COMMAND3;
						regBusWE <= HIGH;
					end
					STATE_SEND_COMMAND3: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_CMD_CLELOW;
						DelayReturnState <= ReturnState;
						regBusCLE <= LOW;
					end
					
					
					
					STATE_SEND_FULL_ADDRESS: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_tALH;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS1;
					end
					STATE_SEND_FULL_ADDRESS1: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS2;
						regBusCLE <= LOW;
						regBusWE <= LOW;
						regBusRE <= HIGH;
						regBusALE <= HIGH;
						regBusDir <= DIR_OUT;
						regBusData <= regAddr[32:39];
					end
					STATE_SEND_FULL_ADDRESS2: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WEHIGH;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS3;
						regBusWE <= HIGH;
					end
					STATE_SEND_FULL_ADDRESS3: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS4;
						regBusWE <= LOW;
						regBusData <= regAddr[24:31];
					end
					STATE_SEND_FULL_ADDRESS4: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WEHIGH;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS5;
						regBusWE <= HIGH;
					end
					STATE_SEND_FULL_ADDRESS5: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS6;
						regBusWE <= LOW;
						regBusData <= regAddr[16:23];
					end
					STATE_SEND_FULL_ADDRESS6: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WEHIGH;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS7;
						regBusWE <= HIGH;
					end
					STATE_SEND_FULL_ADDRESS7: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS8;
						regBusWE <= LOW;
						regBusData <= regAddr[8:15];
					end
					STATE_SEND_FULL_ADDRESS8: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WEHIGH;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS9;
						regBusWE <= HIGH;
					end
					STATE_SEND_FULL_ADDRESS9: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS10;
						regBusWE <= LOW;
						regBusData <= regAddr[0:7];
					end
					STATE_SEND_FULL_ADDRESS10: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WEHIGH;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS11;
						regBusWE <= HIGH;
					end
					STATE_SEND_FULL_ADDRESS11: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_ALELOW;
						DelayReturnState <= ReturnState;
						regBusALE <= LOW;
					end
		
		
					STATE_SEND_BLOCK_ADDRESS: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS6;
						regBusCLE <= LOW;
						regBusWE <= LOW;
						regBusRE <= HIGH;
						regBusALE <= HIGH;
						regBusDir <= DIR_OUT;
						regBusData <= regAddr[16:23];
					end
		
					STATE_SEND_SINGLE_ADDRESS: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS10;
						regBusCLE <= LOW;
						regBusWE <= LOW;
						regBusRE <= HIGH;
						regBusALE <= HIGH;
						regBusDir <= DIR_OUT;
					end
		
					//Only sends four bytes... 3 highest + lowest byte
					STATE_SEND_TOSH_ADDRESS: begin
						State <= STATE_DELAY;
						DelayCount <= DELAY_ADDR_WELOW;
						DelayReturnState <= STATE_SEND_FULL_ADDRESS4;
						regBusCLE <= LOW;
						regBusWE <= LOW;
						regBusRE <= HIGH;
						regBusALE <= HIGH;
						regBusDir <= DIR_OUT;
						regBusData <= regAddr[32:39];
					end
					
					
			endcase
			
		end
	end
	
	
	
	assign busy = regBusy;
	assign busdataout = regBusData;
	assign busdatatri = {8{regBusDir}};
	assign buswe = regBusWE;
	assign busre = regBusRE;
	assign busces = regBusCEs;
	assign busrbs = regBusRBs;
	assign buscle = regBusCLE;
	assign busale = regBusALE;
	assign buswp = 1'b1;
	
	assign bufferin = regBufferWriteData;
	assign bufferwe = regBufferWE;
	assign bufferaddr = {regBufferNum,regBufferAddr};
	
	
	
	
endmodule


