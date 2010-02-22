
/*
Bus State Machine

Responsible for keeping the bus controller busy, and handling any requests that need this bus

*/
module bus_sm(
	clk,
	reset,
	
	busy,
	chip,
	addr,
	length,
	prioritylvl,
	ramaddr,
	operation,
	valid,
	interrupt,
	
	chipbusy,
	
	transferDone,
	transferCtrl,
	transferPending,
	transferAddr,
	transferStart,
	transferRNW,
	transferLength,
	
	Cbusy,
	Coperation,
	Cchip,
	Caddr,
	Clength,
	Cstart,
	Cbuffernum,
	Creadybits,
	
	cyclecount_sum,
	cyclecount_reset,
	cyclecount_start,
	cyclecount_end,
	
	DO_DRAM_TRANSFERS
	
);

	parameter MAXCHIPS = 32;
	parameter MAXCHIPSLOG2 = 5;
	
	input 							DO_DRAM_TRANSFERS;

	input 							clk;
	input 							reset;
	
	output 							busy;
	input 	[0:MAXCHIPSLOG2-1] chip;
	input 	[0:39] 				addr;
	input 	[0:13] 				length;
	input 	[0:3] 				prioritylvl;
	input 	[0:31] 				ramaddr;
	input 	[0:3] 				operation;
	input 							valid;
	output							interrupt;
	
	output	[0:31]				cyclecount_sum;
	input							cyclecount_reset;
	input		[0:4]					cyclecount_start;
	input		[0:4]					cyclecount_end;
	
	output 	[0:MAXCHIPS-1] 	chipbusy;
	
	input 							Cbusy;
	output 	[0:3] 				Coperation;
	output 	[0:MAXCHIPSLOG2-1] Cchip;
	output 	[0:39] 				Caddr;
	output	[0:13]				Clength;
	output 							Cstart;
	output 							Cbuffernum;
	input 	[0:MAXCHIPS-1] 	Creadybits;

	input 							transferDone;
	input 	[0:1]					transferCtrl;
	output 	[0:1] 				transferPending;
	output 	[0:31] 				transferAddr;
	output 							transferStart;
	output 							transferRNW;
	output 	[0:13] 				transferLength;
	
	
	reg	[0:31]					regTransferAddr;
	reg	[0:1]						regTransferPending;
	reg								regTransferStart;
	reg								regTransferRNW;
	reg	[0:13]					regTransferLength;


	reg 								regBusy;

	reg	[0:3]						regCoperation;
	reg	[0:MAXCHIPSLOG2-1]	regCchip;
	reg	[0:39]					regCaddr;
	reg	[0:13]					regClength;
	reg								regCstart;
	reg								regCbuffernum;

	reg	[0:2]						regState;
	reg								regInterrupt;
	
	reg								regBusBusy;
	reg								regBufferAssignment;
	reg	[0:MAXCHIPS-1] 		regChipBusy;
	reg	[0:MAXCHIPS-1] 		regChipInit;


	reg	[0:9]						regNextLRU;
	reg	[0:9]						regServicingLRU;

	reg	[0:9]						regNextLRUbuffer[0:1];
	reg	[0:9]						regServicingLRUbuffer[0:1];

	
	wire	[0:4]						regChipStateBus;
	
	

	wire	[0:4]						dbgchipChip;
	wire	[0:4]						dbgchipState;
	wire	[0:39]					dbgchipAddr;
	wire	[0:13]					dbgchipLength;
	wire	[0:3]						dbgchipPriority;
	wire	[0:31]					dbgchipRamAddr;
	wire								dbgchipBuffer;
	wire	[0:9]						dbgchipLRU;
	wire	[0:9]						dbgchipLRUbuffer;
	wire	[0:35]					dbgchipDebug;
	

	wire	[0:4]						chipChip;
	wire	[0:4]						chipState;
	wire	[0:39]					chipAddr;
	wire	[0:13]					chipLength;
	wire	[0:3]						chipPriority;
	wire	[0:31]					chipRamAddr;
	wire								chipBuffer;
	wire	[0:9]						chipLRU;
	wire	[0:9]						chipLRUbuffer;
	wire	[0:35]					chipDebug;
	
	reg	[0:8]						regActIndex;
	reg	[0:4]						regNewChipChip;
	reg								regNewChipWE;
	reg	[0:4]						regNewChipState;
	reg	[0:39]					regNewChipAddr;
	reg	[0:13]					regNewChipLength;
	reg	[0:3]						regNewChipPriority;
	reg	[0:31]					regNewChipRamAddr;
	reg								regNewChipBuffer;
	reg	[0:9]						regNewChipLRU;
	reg	[0:9]						regNewChipLRUbuffer;
	
	
	reg	[0:35]					regNewChipDebug;
	
	reg								regLockRead;
	reg								regLockWrite;
	
	reg	[0:8]						regAddChipIndex;
	reg	[0:4]						regAddChipChip;
	reg								regAddChipWE;
	reg	[0:4]						regAddChipState;
	reg	[0:39]					regAddChipAddr;
	reg	[0:13]					regAddChipLength;
	reg	[0:3]						regAddChipPriority;
	reg	[0:31]					regAddChipRamAddr;
	reg								regAddChipBuffer;
	reg	[0:9]						regAddChipLRU;
	reg	[0:9]						regAddChipLRUbuffer;
	reg	[0:35]					regAddChipDebug;
	
	reg								regStatusCheck;
	
	
	reg	[0:8]						regHead; //write point
	reg	[0:8]						regTail; //lowest #d active operation
	
	reg	[0:35]					regCounter;
	reg	[0:31]					regCycleCountSum;	



	wire newread;
	wire newwrite;
	wire newerase;

	
	integer			chip_num;
	
	localparam LRU_MAX_VALUE = 1023;
	
	
	//bus controller operations
	localparam OP_CHECKSTATUS = 0;
	localparam OP_RESET = 1;
	localparam OP_STARTREAD = 2;
	localparam OP_COMPLETEREAD = 3;
	localparam OP_PROGRAM = 4;
	localparam OP_ERASE = 5;
	
	//os to local operations
	localparam HOP_READ = 0;
	localparam HOP_WRITE = 1;
	localparam HOP_ERASE = 2;
	
	//Performance Counter Start and End Point Optinos
	localparam PC_REQUEST_SUBMIT = 0; //start only
	localparam PC_READ_COMMAND_PENDING_TO_COMMAND_ONBUS = 1;
	localparam PC_READ_COMMAND_ONBUS_TO_COMMAND_DONE = 2;
	localparam PC_READ_COMMAND_DONE_TO_BUFFER_WAIT = 3;
	localparam PC_READ_BUFFER_WAIT_TO_DATA_PENDING = 4;
	localparam PC_READ_DATA_PENDING_TO_DATA_ONBUS = 5;
	localparam PC_READ_DATA_ONBUS_TO_TRANSFER_PENDING = 6;
	localparam PC_READ_TRANSFER_PENDING_TO_TRANSFER_ACTIVE = 7;
	localparam PC_READ_REQUEST_COMPLETE = 8; //end only
	
	localparam PC_WRITE_BUFFER_WAIT_TO_TRANSFER_PENDING = 9;
	localparam PC_WRITE_TRANSFER_PENDING_TO_TRANSFER_ACTIVE = 10;
	localparam PC_WRITE_TRANSFER_ACTIVE_TO_DATA_PENDING = 11;
	localparam PC_WRITE_DATA_PENDING_TO_DATA_ONBUS = 12;
	localparam PC_WRITE_DATA_ONBUS_TO_WAIT_OP = 13;
	localparam PC_WRITE_REQUEST_COMPLETE = 14; //end only

	localparam PC_ERASE_PENDING_TO_ONBUS = 15;
	localparam PC_ERASE_ONBUS_TO_WAIT_OP = 16;
	localparam PC_ERASE_REQUEST_COMPLETE = 17; //end only
	

	
	//local chip states
	localparam CS_UNINIT = 0; //chip has not been reset yet... chip might not even be there...
	localparam CS_IDLE = 1; //chip has no pending operation, and all current transfers are complete
	
	localparam CS_READ_START_PENDING = 2; //chip has a pending read operation
	localparam CS_READ_START_ONBUS = 3; //chip currently being issued read command
	localparam CS_READ_START_DONE = 4; //chip has been issued a read command
	
	localparam CS_READ_DATA_BUFFER_WAIT = 5; //waiting for buffer to be free
	localparam CS_READ_DATA_PENDING = 6; //waiting for bus to be free
	localparam CS_READ_DATA_ONBUS = 7; //copying read data from chip to local buffer
	
	localparam CS_READ_TRANSFER_PENDING = 8; //waiting to copy data to system ram
	localparam CS_READ_TRANSFER_ACTIVE = 9; //data transfer in progress
		
	
	localparam CS_WRITE_TRANSFER_BUFFER_WAIT = 10; //waiting for buffer to be free
	localparam CS_WRITE_TRANSFER_PENDING = 11;
	localparam CS_WRITE_TRANSFER_ACTIVE = 12;
	localparam CS_WRITE_DATA_PENDING = 13;
	localparam CS_WRITE_DATA_ONBUS = 14;
	localparam CS_WRITE_DATA_DONE = 15;
	
	localparam CS_ERASE_PENDING = 16;
	localparam CS_ERASE_ONBUS = 17;
	localparam CS_ERASE_DONE = 18;
	
	//state machine states
	localparam ST_IDLE = 0;
	localparam ST_ADVANCE_ACTCHIP = 1;
	localparam ST_ADVANCE_ACTCHIP2 = 2;
	localparam ST_ADVANCE_ACTCHIP3 = 3;
	localparam ST_ASSIGN_NEW_LRU = 4;
	
	
	assign chipbusy = regChipBusy;
	
	
	assign newread = (operation == HOP_READ) && valid;
	assign newwrite = (operation == HOP_WRITE) && valid;
	assign newerase = (operation == HOP_ERASE) && valid;
	
	wire [0:8] headPlus1 = regHead + 1;
	wire [0:8] headMinus1 = regHead - 1;
	wire QueueFull = regTail == headPlus1;
	wire QueueEmpty = regTail == regHead;
	



	reg regIniting;
	
	always @(posedge clk) begin
		if (reset) begin
		
			regBusy <= 0;
			
			regCoperation <= 0;
			regCchip <= 0;
			regCaddr <= 0;
			regCstart <= 0;
			regCbuffernum <= 0;
			
			regState <= 0;
			regInterrupt <= 0;
			
			regChipBusy <= 32'hffffffff;
				
			regNextLRU <= 1;
			regServicingLRU <= 1;
			regNextLRUbuffer[0] <= 1;
			regServicingLRUbuffer[0] <= 1;
			regNextLRUbuffer[1] <= 1;
			regServicingLRUbuffer[1] <= 1;
			
			regBusBusy <= 0;
			regBufferAssignment <= 0;
			
			regTransferPending <= 2'b00;
			regTransferRNW <= 0;
			regTransferAddr <= 0;
			regTransferStart <= 0;
			regTransferLength <= 0;
			
			regNewChipChip <= 0;
			regNewChipWE <= 0;
			regNewChipState <= 0;
			regNewChipAddr <= 0;
			regNewChipLength <= 0;
			regNewChipPriority <= 0;
			regNewChipRamAddr <= 0;
			regNewChipBuffer <= 0;
			regNewChipLRU <= 0;
			regNewChipLRUbuffer <= 0;
			regNewChipDebug <= 0;
			
			
			regAddChipChip <= 0;
			regAddChipWE <= 0;
			regAddChipIndex <= 0;
			regAddChipState <= 0;
			regAddChipAddr <= 0;
			regAddChipLength <= 0;
			regAddChipPriority <= 0;
			regAddChipRamAddr <= 0;
			regAddChipBuffer <= 0;
			regAddChipLRU <= 0;
			regAddChipLRUbuffer <= 0;
			regAddChipDebug <= 0;
			
			regStatusCheck <= 0;
			
			regLockRead <= 0;
			regLockWrite <= 0;
			
			regIniting <= 1;
			
			regHead <= 0;
			regTail <= 0;

			regCounter <= 0;
			regCycleCountSum <= 0;
		end else begin
			regAddChipWE <= 0;
			regNewChipWE <= 0;
			regTransferStart <= 0;
			regBusy <= regChipBusy != 0;
			regCstart <= 0;
			regInterrupt <= 0;

			//Chip Initializing 
			if (regIniting) begin
				if (regCounter < 16) begin
					regCounter <= regCounter + 1;
					regAddChipIndex <= regCounter;
					regAddChipChip <= regCounter;
					regAddChipState <= CS_UNINIT;
					regAddChipWE <= 1;
				end else begin
					regIniting <= 0;
					regCounter <= 0;
					regHead <= regCounter;
				end
			end else begin
				regCounter <= regCounter + 1;
		
			
			
			
			if ((!QueueFull) && (newread || newwrite || newerase)) begin
				regAddChipIndex <= regHead; //Insert Operation at head of list
				regHead <= regHead + 1;
				
				regAddChipWE <= 1;
				regAddChipChip <= chip;	
				regAddChipAddr <= addr;
				regAddChipLRU <= regNextLRU;
				regAddChipRamAddr <= ramaddr;
				regAddChipLength <= length;
				regAddChipPriority <= prioritylvl;
				
				//update NextLRU assignment
				if (regNextLRU != LRU_MAX_VALUE)
					regNextLRU <= regNextLRU + 1;
				else
					regNextLRU <= 1;
			
				if (cyclecount_start == PC_REQUEST_SUBMIT) 
					regAddChipDebug <= dbgCounter;
			
				//set chip state appropriately for request
				if (newread) begin
					regAddChipState <= CS_READ_START_PENDING;
				end
				if (newwrite) begin
					regAddChipState <= CS_WRITE_TRANSFER_BUFFER_WAIT;
				end
				if (newerase) begin
					regAddChipState <= CS_ERASE_PENDING;					
				end
				
				//reads and writes need a buffer assignment and buffer LRU
				if (newread | newwrite) begin
					regAddChipBuffer <= regBufferAssignment;
					regAddChipLRUbuffer <= regNextLRUbuffer[regBufferAssignment];
				
					if (regNextLRUbuffer[regBufferAssignment] != LRU_MAX_VALUE)
						regNextLRUbuffer[regBufferAssignment] <= regNextLRUbuffer[regBufferAssignment] + 1;
					else
						regNextLRUbuffer[regBufferAssignment] <= 1;
						
					regBufferAssignment <= ~regBufferAssignment;
				end
				
			end else begin
		
			regState <= ST_ADVANCE_ACTCHIP;
			case(regState)
				ST_IDLE: begin
			
					//clear busy flag if we were just doing a ready bit check
					if (regStatusCheck && !Cbusy) begin
						regBusBusy <= 0;
						regStatusCheck <= 0;
					end
			
			
					if (QueueEmpty) begin //no pending operations! don't bother doing anything
						regNewChipWE <= 0;
					end else begin
						
						case (regNewChipState)
							CS_UNINIT: begin //State 0
								if (!regBusBusy) begin
									//need to initialize chips
									regStatusCheck <= 1;
									regCoperation <= OP_RESET;
									regCchip <= regNewChipChip;
									regCstart <= 1; //start operation
									regBusBusy <= 1;
									regNewChipState <= CS_IDLE;
									regNewChipWE <= 1;
									regChipBusy[regNewChipChip] <= 0;

									//if we're the oldest op the queue to finish, advance the tail pointer
									if (regActIndex == regTail)
										regTail <= regTail + 1;

								end
							end
							CS_IDLE: begin //State 1
								
							end
							
							
							//==================
							//READ
							//==================
							CS_READ_START_PENDING: begin //State 2
								if ((!regChipBusy[regNewChipChip]) && (!regBusBusy) && (regNewChipLRU == regServicingLRU)) begin
									regChipBusy[regNewChipChip] <= 1;

									regNewChipState <= CS_READ_START_ONBUS;
									regNewChipWE <= 1;
									
									regCoperation <= OP_STARTREAD;
									regCchip <= regNewChipChip;
									regCaddr <= regNewChipAddr;
									regClength <= regNewChipLength;
									regCstart <= 1; //start operation
									regCbuffernum <= regNewChipBuffer;
									regBusBusy <= 1;
									regState <= ST_ASSIGN_NEW_LRU;
									regServicingLRU <= regServicingLRU == LRU_MAX_VALUE ? 1 : regServicingLRU + 1;

									if (cyclecount_start == PC_READ_COMMAND_PENDING_TO_COMMAND_ONBUS)
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_COMMAND_PENDING_TO_COMMAND_ONBUS)
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							
							CS_READ_START_ONBUS: begin //State 3
								if (!Cbusy) begin
									regNewChipState <= CS_READ_START_DONE;
									regNewChipWE <= 1;
									
									regBusBusy <= 0;

									if (cyclecount_start == PC_READ_COMMAND_ONBUS_TO_COMMAND_DONE )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_COMMAND_ONBUS_TO_COMMAND_DONE )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);

								end
							end
							
							
							CS_READ_START_DONE: begin //State 4
								if (Creadybits[regNewChipChip]) begin
									regNewChipState <= CS_READ_DATA_BUFFER_WAIT;
									regNewChipWE <= 1;

									if (cyclecount_start == PC_READ_COMMAND_DONE_TO_BUFFER_WAIT )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_COMMAND_DONE_TO_BUFFER_WAIT )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end else begin
									//POTENTIAL BOTTLENECK HERE.... probably want to create independent regBusyReadyCheckBus flag, since we can actually do these seperately now
									if (!regBusBusy) begin
										regBusBusy <= 1;
										regStatusCheck <= 1;
										regCoperation <= OP_CHECKSTATUS;
										regCchip <= regNewChipChip;
										regCstart <= 1; //start operation
									end
								end

							end
							//waiting for a buffer to be free
							CS_READ_DATA_BUFFER_WAIT: begin //State 5
								if (regNewChipLRUbuffer == regServicingLRUbuffer[regNewChipBuffer]) begin
									
									regNewChipState <= CS_READ_DATA_PENDING;
									regNewChipWE <= 1;

									if (cyclecount_start == PC_READ_BUFFER_WAIT_TO_DATA_PENDING )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_BUFFER_WAIT_TO_DATA_PENDING )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_READ_DATA_PENDING: begin //State 6
								if ((!regBusBusy) && (regNewChipLRU == regServicingLRU)) begin
									
									regNewChipState <= CS_READ_DATA_ONBUS;
									regNewChipWE <= 1;
									
									regCoperation <= OP_COMPLETEREAD;
									regCchip <= regNewChipChip;
									regCaddr <= regNewChipAddr;
									regClength <= regNewChipLength;
									regCstart <= 1; //start operation
									regCbuffernum <= regNewChipBuffer;
									regBusBusy <= 1;
									regServicingLRU <= regServicingLRU == LRU_MAX_VALUE ? 1 : regServicingLRU + 1;

									if (cyclecount_start == PC_READ_DATA_PENDING_TO_DATA_ONBUS )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_DATA_PENDING_TO_DATA_ONBUS )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);

								end
							end
							CS_READ_DATA_ONBUS: begin //State 7
								if (!Cbusy) begin
									regChipBusy[regNewChipChip] <= 0; //free chip here since we're technically done with it, just the dram left now
									regNewChipWE <= 1;
									regBusBusy <= 0;
									
									if (DO_DRAM_TRANSFERS) begin
										regNewChipState <= CS_READ_TRANSFER_PENDING;
										
									end else begin //not doing DRAM Transfers, so just to the idle state
										regNewChipState <= CS_IDLE;
										
										regNewChipDebug[112:139] <= dbgCounter;
										regNewChipLRU <= 0;
										if (regNewChipLRUbuffer != 0) begin
											regServicingLRUbuffer[regNewChipBuffer] <= regServicingLRUbuffer[regNewChipBuffer] == LRU_MAX_VALUE ? 1 : regServicingLRUbuffer[regNewChipBuffer] + 1;
											regNewChipLRUbuffer <= 0;
										end
										regInterrupt <= 1;
										
										//if we're the oldest op the queue to finish, advance the tail pointer
										if (regActIndex == regTail)
											regTail <= regTail + 1;
									
									end

									if (cyclecount_start == PC_READ_DATA_ONBUS_TO_TRANSFER_PENDING )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_DATA_ONBUS_TO_TRANSFER_PENDING )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_READ_TRANSFER_PENDING: begin //State 8
								regTransferPending[regNewChipBuffer] <= 1'b1;
								if (transferCtrl[regNewChipBuffer]) begin
									regNewChipState <= CS_READ_TRANSFER_ACTIVE;
									regNewChipWE <= 1;

									regTransferStart <= 1;
									regTransferAddr <= regNewChipRamAddr;
									regTransferRNW <= 0;
									regTransferLength <= regNewChipLength;

									if (cyclecount_start == PC_READ_TRANSFER_PENDING_TO_TRANSFER_ACTIVE )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_TRANSFER_PENDING_TO_TRANSFER_ACTIVE )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);

								end
							end
							CS_READ_TRANSFER_ACTIVE: begin //State 9
								if (transferDone) begin
									regTransferPending[regNewChipBuffer] <= 1'b0;	
									regNewChipState <= CS_IDLE;
									regNewChipWE <= 1;
									regNewChipLRU <= 0;
									if (regNewChipLRUbuffer != 0) begin
											regServicingLRUbuffer[regNewChipBuffer] <= regServicingLRUbuffer[regNewChipBuffer] == LRU_MAX_VALUE ? 1 : regServicingLRUbuffer[regNewChipBuffer] + 1;
											regNewChipLRUbuffer <= 0;
									end
									regInterrupt <= 1;
									
									//if we're the oldest op the queue to finish, advance the tail pointer
									if (regActIndex == regTail)
										regTail <= regTail + 1;

									if (cyclecount_start == PC_READ_REQUEST_COMPLETE )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_READ_REQUEST_COMPLETE )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
				
							//=================
							//WRITE
							//=================
							CS_WRITE_TRANSFER_BUFFER_WAIT: begin //State 10
								if (regNewChipLRUbuffer == regServicingLRUbuffer[regNewChipBuffer]) begin
									if (DO_DRAM_TRANSFERS) begin
										regNewChipState <= CS_WRITE_TRANSFER_PENDING;
										regNewChipWE <= 1;
									end else begin
										regNewChipState <= CS_WRITE_DATA_PENDING;
										regNewChipWE <= 1;
									end

									if (cyclecount_start == PC_WRITE_BUFFER_WAIT_TO_TRANSFER_PENDING )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_WRITE_BUFFER_WAIT_TO_TRANSFER_PENDING )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_WRITE_TRANSFER_PENDING: begin //State 11
								regTransferPending[regNewChipBuffer] <= 1'b1;
								if (transferCtrl[regNewChipBuffer]) begin
									regNewChipState <= CS_WRITE_TRANSFER_ACTIVE;
									regNewChipWE <= 1;
									
									regTransferStart <= 1;
									regTransferAddr <= regNewChipRamAddr;
									regTransferRNW <= 1;
									regTransferLength <= regNewChipLength;

									if (cyclecount_start == PC_WRITE_TRANSFER_PENDING_TO_TRANSFER_ACTIVE )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_WRITE_TRANSFER_PENDING_TO_TRANSFER_ACTIVE )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_WRITE_TRANSFER_ACTIVE: begin //State 12
								if (transferDone) begin
									regTransferPending[regNewChipBuffer] <= 1'b0;
									regNewChipState <= CS_WRITE_DATA_PENDING;
									regNewChipWE <= 1;

									if (cyclecount_start == PC_WRITE_TRANSFER_ACTIVE_TO_DATA_PENDING )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_WRITE_TRANSFER_ACTIVE_TO_DATA_PENDING )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_WRITE_DATA_PENDING: begin //State 13
								if ((!regChipBusy[regNewChipChip]) && (!regBusBusy) && (regNewChipLRU == regServicingLRU)) begin
									regChipBusy[regNewChipChip] <= 1;
									regNewChipState <= CS_WRITE_DATA_ONBUS;
									regNewChipWE <= 1;
									
									regCoperation <= OP_PROGRAM;
									regCchip <= regNewChipChip;
									regCaddr <= regNewChipAddr;
									regClength <= regNewChipLength;
									regCstart <= 1; //start operation
									regCbuffernum <= regNewChipBuffer;	
									regBusBusy <= 1;	
									regServicingLRU <= regServicingLRU == LRU_MAX_VALUE ? 1 : regServicingLRU + 1;

									if (cyclecount_start == PC_WRITE_DATA_PENDING_TO_DATA_ONBUS )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_WRITE_DATA_PENDING_TO_DATA_ONBUS )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end									
							end
							
							CS_WRITE_DATA_ONBUS: begin //State 14
								if (!Cbusy) begin
									regNewChipState <= CS_WRITE_DATA_DONE;
									regNewChipWE <= 1;
									
									regBusBusy <= 0;

									if (cyclecount_start == PC_WRITE_DATA_ONBUS_TO_WAIT_OP )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_WRITE_DATA_ONBUS_TO_WAIT_OP )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_WRITE_DATA_DONE: begin //State 15
								if (Creadybits[regNewChipChip]) begin
									regNewChipState <= CS_IDLE;
									regNewChipWE <= 1;
									regNewChipLRU <= 0;
									regInterrupt <= 1;
									regChipBusy[regNewChipChip] <= 0;
									
									//if we're the oldest op the queue to finish, advance the tail pointer
									if (regActIndex == regTail)
										regTail <= regTail + 1;

									if (cyclecount_start == PC_WRITE_REQUEST_COMPLETE )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_WRITE_REQUEST_COMPLETE )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end else begin
									if (!regBusBusy) begin
										//we can release the buffer once the bus becomes unbusy, since we've written data to the chip, just waiting for program to finish
										if (regNewChipLRUbuffer != 0) begin
											regServicingLRUbuffer[regNewChipBuffer] <= regServicingLRUbuffer[regNewChipBuffer] == LRU_MAX_VALUE ? 1 : regServicingLRUbuffer[regNewChipBuffer] + 1;
											regNewChipLRUbuffer <= 0;
											regNewChipWE <= 1;
										end
										regBusBusy <= 1;
										regStatusCheck <= 1;
										regCoperation <= OP_CHECKSTATUS;
										regCchip <= regNewChipChip;
										regCstart <= 1; //start operation
									end
								end
							end
							
							
							//================
							//ERASE
							//================
							CS_ERASE_PENDING: begin //State 16
								if ((!regChipBusy[regNewChipChip]) && (!regBusBusy) && (regNewChipLRU == regServicingLRU)) begin
									regChipBusy[regNewChipChip] <= 1;
									regNewChipState <= CS_ERASE_ONBUS;
									regNewChipWE <= 1;
									
									regCoperation <= OP_ERASE;
									regCchip <= regNewChipChip;
									regCaddr <= regNewChipAddr;
									regClength <= regNewChipLength;
									regCstart <= 1; //start operation
									regCbuffernum <= regNewChipBuffer; //not used... but set it anyway
									regBusBusy <= 1;
									regServicingLRU <= regServicingLRU == LRU_MAX_VALUE ? 1 : regServicingLRU + 1;

									if (cyclecount_start == PC_ERASE_PENDING_TO_ONBUS )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_ERASE_PENDING_TO_ONBUS )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_ERASE_ONBUS: begin //State 17
								if (!Cbusy) begin
									regNewChipState <= CS_ERASE_DONE;
									regNewChipWE <= 1;
									
									regBusBusy <= 0;

									if (cyclecount_start == PC_ERASE_ONBUS_TO_WAIT_OP )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_ERASE_ONBUS_TO_WAIT_OP )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end
							end
							CS_ERASE_DONE: begin //State 18
								if (Creadybits[regNewChipChip]) begin
									regNewChipState <= CS_IDLE;
									regNewChipWE <= 1;
									regNewChipLRU <= 0;
									regInterrupt <= 1;
									regChipBusy[regNewChipChip] <= 0;
									
									//if we're the oldest op the queue to finish, advance the tail pointer
									if (regActIndex == regTail)
										regTail <= regTail + 1;
									
									if (cyclecount_start == PC_ERASE_REQUEST_COMPLETE )
										regNewChipDebug <= dbgCounter; 
									if (cyclecount_end == PC_ERASE_REQUEST_COMPLETE )
										regCycleCountSum <= regCycleCountSum + (regCounter- regNewChipDebug);
								end else begin
									if (!regBusBusy) begin
										regBusBusy <= 1;
										regStatusCheck <= 1;
										regCoperation <= OP_CHECKSTATUS;
										regCchip <= regNewChipChip;
										regCstart <= 1; //start operation
									end
								end
							end
						endcase
					end
				end
				
				ST_ADVANCE_ACTCHIP: begin
					regNewChipWE <= 0;
					//values modified last cycle will update this cycle
					
					if (QueueEmpty) //nothing in the list
						regActIndex <= regTail;
					else if (regActIndex == headMinus1) //last valid entry, loop back to start
						regActIndex <= regTail;
					else //somewhere in the middle
						regActIndex <= regActIndex + 1;
						
					regState <= ST_ADVANCE_ACTCHIP2;
				end
				
				ST_ADVANCE_ACTCHIP2: begin
					//regActIndex now has new chip id, wait one cycle for the data to arrive
					regState <= ST_ADVANCE_ACTCHIP3;
				end
				ST_ADVANCE_ACTCHIP3: begin
					regNewChipChip <= chipChip;
					regNewChipState <= chipState;
					regNewChipAddr <= chipAddr;
					regNewChipLength <= chipLength;
					regNewChipPriority <= chipPriority;
					regNewChipRamAddr <= chipRamAddr;
					regNewChipBuffer <= chipBuffer;
					regNewChipLRU <= chipLRU;
					regNewChipLRUbuffer <= chipLRUbuffer;
					regNewChipDebug <= chipDebug;
					
					regState <= ST_IDLE;
				end
				
				
				ST_ASSIGN_NEW_LRU: begin
					if (!(newread || newwrite || newerase)) begin
						regState <= ST_ADVANCE_ACTCHIP;
						
						regNewChipLRU <= regNextLRU;
						regNewChipWE <= 1;
						//update NextLRU assignment
						if (regNextLRU != LRU_MAX_VALUE)
							regNextLRU <= regNextLRU + 1;
						else
							regNextLRU <= 1;
					end
				end
			
				default: begin
					regState <= ST_IDLE;
				end
			endcase
			end
			end
		end
	end


	assign busy = regBusy;

	assign Coperation = regCoperation;
	assign Cchip = regCchip;
	assign Caddr = regCaddr;
	assign Clength = regClength;
	assign Cstart = regCstart;
	assign Cbuffernum = regCbuffernum;

	assign transferStart = regTransferStart;
	assign transferAddr = regTransferAddr;
	assign transferRNW = regTransferRNW;
	assign transferPending = regTransferPending;
	assign transferLength = regTransferLength;
	
	assign interrupt = regInterrupt;
	
	assign cyclecount_sum = regCycleCountSum;
	
	
	scoreboard sb(
	.clk(clk),

	.a_index(regActIndex),
	.a_read_state(chipState),
	.a_read_page(chipAddr[0:23]),
	.a_read_pageoffset(chipAddr[24:39]),
	.a_read_length(chipLength),
	.a_read_ramaddr(chipRamAddr),
	.a_read_priority(chipPriority),
	.a_read_chip(chipChip),
	.a_read_other({chipBuffer, chipLRU, chipLRUbuffer}),
	.a_read_counter(),
	.a_read_debug(chipDebug),
	.a_write_state(regNewChipState),
	.a_write_page(regNewChipAddr[0:23]),
	.a_write_pageoffset(regNewChipAddr[24:39]),
	.a_write_length(regNewChipLength),
	.a_write_ramaddr(regNewChipRamAddr),
	.a_write_priority(regNewChipPriority),
	.a_write_chip(regNewChipChip),
	.a_write_other({regNewChipBuffer, regNewChipLRU, regNewChipLRUbuffer}),
	.a_write_counter(0),
	.a_write_debug(regNewChipDebug),
	.a_we(regNewChipWE),
	
	.b_index(regAddChipIndex),
	.b_read_state(dbgchipState),
	.b_read_page(dbgchipAddr[0:23]),
	.b_read_pageoffset(dbgchipAddr[24:39]),
	.b_read_length(dbgchipLength),
	.b_read_ramaddr(dbgchipRamAddr),
	.b_read_priority(dbgchipPriority),
	.b_read_chip(dbgchipChip),
	.b_read_other({dbgchipBuffer,dbgchipLRU,dbgchipLRUbuffer}),
	.b_read_counter(),
	.b_read_debug(dbgchipDebug),
	.b_write_state(regAddChipState),
	.b_write_page(regAddChipAddr[0:23]),
	.b_write_pageoffset(regAddChipAddr[24:39]),
	.b_write_length(regAddChipLength),
	.b_write_ramaddr(regAddChipRamAddr),
	.b_write_priority(regAddChipPriority),
	.b_write_chip(regAddChipChip),
	.b_write_other({regAddChipBuffer, regAddChipLRU, regAddChipLRUbuffer}),
	.b_write_counter(0),
	.b_write_debug(regAddChipDebug),
	.b_we(regAddChipWE)
	);
	
	

endmodule




module scoreboard(
	clk,

	a_index,
	a_read_state,
	a_read_page,
	a_read_pageoffset,
	a_read_length,
	a_read_ramaddr,
	a_read_priority,
	a_read_chip,
	a_read_other,
	a_read_counter,
	a_read_debug,
	a_write_state,
	a_write_page,
	a_write_pageoffset,
	a_write_length,
	a_write_ramaddr,
	a_write_priority,
	a_write_chip,
	a_write_other,
	a_write_counter,
	a_write_debug,
	a_we,
	
	b_index,
	b_read_state,
	b_read_page,
	b_read_pageoffset,
	b_read_length,
	b_read_ramaddr,
	b_read_priority,
	b_read_chip,
	b_read_other,
	b_read_counter,
	b_read_debug,
	b_write_state,
	b_write_page,
	b_write_pageoffset,
	b_write_length,
	b_write_ramaddr,
	b_write_priority,
	b_write_chip,
	b_write_other,
	b_write_counter,
	b_write_debug,
	b_we
);
	input 				clk;
	
	input 	[0:8] 	a_index, 				b_index;
	
	output 	[0:4] 	a_read_state, 			b_read_state;
	output 	[0:23] 	a_read_page, 			b_read_page;
	output 	[0:15] 	a_read_pageoffset,	b_read_pageoffset;
	output 	[0:13] 	a_read_length, 		b_read_length;
	output 	[0:3] 	a_read_priority, 		b_read_priority;
	output 	[0:31] 	a_read_ramaddr, 		b_read_ramaddr;
	output	[0:4]		a_read_chip,			b_read_chip;
	output 	[0:12] 	a_read_other, 			b_read_other;
	output	[0:30]	a_read_counter,		b_read_counter;
	
	output	[0:35]	a_read_debug,			b_read_debug;
	
	input 	[0:4] 	a_write_state, 		b_write_state;
	input 	[0:23] 	a_write_page, 			b_write_page;
	input 	[0:15] 	a_write_pageoffset,	b_write_pageoffset;
	input 	[0:13] 	a_write_length, 		b_write_length;
	input 	[0:3] 	a_write_priority, 	b_write_priority;
	input 	[0:31] 	a_write_ramaddr, 		b_write_ramaddr;
	input		[0:4]		a_write_chip,			b_write_chip;
	input 	[0:12] 	a_write_other, 		b_write_other;
	input		[0:30]	a_write_counter,		b_write_counter;
	
	input		[0:35]	a_write_debug,			b_write_debug;
	
	input					a_we,						b_we;
	
	
	wire 		[0:179] 	a_read_data, 			b_read_data;
	wire 		[0:179] 	a_write_data, 			b_write_data;
	
	assign a_write_data[0:179] = {a_write_state, a_write_page, a_write_pageoffset, a_write_length, a_write_priority, a_write_ramaddr, a_write_chip, a_write_other, a_write_counter, a_write_debug};
	assign b_write_data[0:179] = {b_write_state, b_write_page, b_write_pageoffset, b_write_length, b_write_priority, b_write_ramaddr, b_write_chip, b_write_other, b_write_counter, b_write_debug};
	
	assign {a_read_state, a_read_page, a_read_pageoffset, a_read_length, a_read_priority, a_read_ramaddr, a_read_chip, a_read_other, a_read_counter, a_read_debug} = a_read_data[0:179];
	assign {b_read_state, b_read_page, b_read_pageoffset, b_read_length, b_read_priority, b_read_ramaddr, b_read_chip, b_read_other, b_read_counter, b_read_debug} = b_read_data[0:179];
	
	
	RAMB16_S36_S36 sbdata0 (
		.DOA (a_read_data[0:31]), 
		.DOB (b_read_data[0:31]), 
		.DOPA(a_read_data[32:35]),
		.DOPB(b_read_data[32:35]),
		.ADDRA (a_index), 
		.ADDRB (b_index), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (a_write_data[0:31]), 
		.DIB (b_write_data[0:31]), 
		.DIPA(a_write_data[32:35]),
		.DIPB(b_write_data[32:35]),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA (a_we), 
		.WEB (b_we));
	defparam sbdata0.WRITE_MODE_A = "READ_FIRST";
	defparam sbdata0.WRITE_MODE_B = "READ_FIRST";
	RAMB16_S36_S36 sbdata1 (
		.DOA (a_read_data[36:67]), 
		.DOB (b_read_data[36:67]), 
		.DOPA(a_read_data[68:71]),
		.DOPB(b_read_data[68:71]),
		.ADDRA (a_index), 
		.ADDRB (b_index), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (a_write_data[36:67]), 
		.DIB (b_write_data[36:67]), 
		.DIPA(a_write_data[68:71]),
		.DIPB(b_write_data[68:71]),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA (a_we), 
		.WEB (b_we));
	defparam sbdata1.WRITE_MODE_A = "READ_FIRST";
	defparam sbdata1.WRITE_MODE_B = "READ_FIRST";
	RAMB16_S36_S36 sbdata2 (
		.DOA (a_read_data[72:103]), 
		.DOB (b_read_data[72:103]), 
		.DOPA(a_read_data[104:107]),
		.DOPB(b_read_data[104:107]),
		.ADDRA (a_index), 
		.ADDRB (b_index), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (a_write_data[72:103]), 
		.DIB (b_write_data[72:103]), 
		.DIPA(a_write_data[104:107]),
		.DIPB(b_write_data[104:107]),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA (a_we), 
		.WEB (b_we));
	defparam sbdata2.WRITE_MODE_A = "READ_FIRST";
	defparam sbdata2.WRITE_MODE_B = "READ_FIRST";
	RAMB16_S36_S36 sbdata3 (
		.DOA (a_read_data[108:139]), 
		.DOB (b_read_data[108:139]), 
		.DOPA(a_read_data[140:143]),
		.DOPB(b_read_data[140:143]),
		.ADDRA (a_index), 
		.ADDRB (b_index), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (a_write_data[108:139]), 
		.DIB (b_write_data[108:139]), 
		.DIPA(a_write_data[140:143]),
		.DIPB(b_write_data[140:143]),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA (a_we), 
		.WEB (b_we));
	defparam sbdata3.WRITE_MODE_A = "READ_FIRST";
	defparam sbdata3.WRITE_MODE_B = "READ_FIRST";






	RAMB16_S36_S36 sbdata4 (
		.DOA (a_read_data[144:175]), 
		.DOB (b_read_data[144:175]), 
		.DOPA(a_read_data[176:179]),
		.DOPB(b_read_data[176:179]),
		.ADDRA (a_index), 
		.ADDRB (b_index), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (a_write_data[144:175]), 
		.DIB (b_write_data[144:175]), 
		.DIPA(a_write_data[176:179]),
		.DIPB(b_write_data[176:179]),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA (a_we), 
		.WEB (b_we));
	defparam sbdata3.WRITE_MODE_A = "READ_FIRST";
	defparam sbdata3.WRITE_MODE_B = "READ_FIRST";

endmodule





