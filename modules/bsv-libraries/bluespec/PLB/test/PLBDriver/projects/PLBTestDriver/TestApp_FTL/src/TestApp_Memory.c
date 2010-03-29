/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * Xilinx EDK 9.1.02 EDK_J_SP2.4
 *
 * This file is a sample test application
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * XPS project when you run the "Generate Libraries" menu item
 * in XPS.
 *
 * Your XPS project directory is at:
 *    /home/kfleming/plbXMD/
 */


// Located in: ppc405_0/include/xparameters.h
#include "xparameters.h"

#include "xutil.h"

//====================================================

typedef enum {
  Read = 0,
  Write = 1,
  Erase = 2,
  ReadID = 3,
  ReadParam = 4
} GordonOps;

void initializeBlock(volatile int* memory,int length, int seed) {
  int i;
  
  for(i = 0; i < length; i++) {
    memory[i] = seed ^ ((seed+3) * i);
  }

}

int checkBlock(volatile int* memory,int length, int seed) {
  int i;
  int error = 0;
  for(i = 0; i < length; i++) {
    if(*(memory+i) != (seed ^ ((seed+3) * i))) {
	   //xil_printf("at %d: g %x e %x\n", i, memory[i],seed ^ ((seed+3) * i)); 
	   error = 1;
	 }
  }
  
  return error;
}

typedef struct {
  long long command1;
  long long command2;
} command_t;

void setCommandBus(command_t* command, int bus) {
  command->command1 = (command->command1) | (((long long)bus & 0x3) << 1);  
}

int getCommandBus(command_t* command) {
  return ((command->command1) >> 1) & 0x3;  
}

void setCommandCE(command_t* command, int ce) {
  command->command1 = (command->command1) | (((long long)ce & 0x1f)<<3);  
}

void setCommandOp(command_t* command, int op) {
  command->command1 = (command->command1) | (((long long)op & 0xf) << 8);  
}

void setCommandPrio(command_t* command, int prio) {
  command->command1 = (command->command1) | (((long long)prio & 0xf) << 12);  
}

void setCommandLength(command_t* command, int length) {
  command->command1 = (command->command1) | (((long long)length & 0x3fff) << 18);  
}

void setCommandRAMAddr(command_t* command, int RAMAddr) {
  command->command1 = (command->command1) | (((long long)RAMAddr) << 32);  
}

/* XXX these are not correct, need to look at gordon code */
void setCommandPageAddr(command_t* command, int PageAddr) {
  command->command2 = (command->command2) | (((long long)PageAddr & 0x3f) << 16);  
}

void setCommandBlockAddr(command_t* command, int BlockAddr) {
  command->command2 = (command->command2) | (((long long)BlockAddr & 0xfff) << 23);  
}

void setCommandTag(command_t* command, int tag) {
  command->command2 = (command->command2) | (((long long)(tag & 0x3f)) << 42);  
}

int getCommandTag(command_t* command) {
  return ((command->command2) >> 42) & 0x3f;  
}

volatile long long *SSD = (long long *)0x4000;

void resetFlashBuses() {
  *(SSD+3)=1;
}

long long checkCommandAvailable(command_t *command) {
  
  switch (getCommandBus(command)) {
    case 0: return (*(SSD+4) ) == 0;
    case 1: return (*(SSD+5) ) == 0;
    case 2: return (*(SSD+6) ) == 0;
    case 3: return (*(SSD+7) ) == 0;  
  }

}

long long checkOperationsComplete() {
  return ((*(SSD+4) ) == 0) && ((*(SSD+5) ) == 0) &&
         ((*(SSD+6) ) == 0) && ((*(SSD+7) ) == 0);  
}

void sendCommand(command_t * command){
  while(!checkCommandAvailable(command)) {}; //spin 
  //xil_printf("Writing command %x %x %x %x\n", command->command1, command->command2);
  *SSD = command->command1;
  *(SSD + 1) = command->command2;
  *(SSD + 2) = 0xffffffffffffffffLL; // Send command
}

void eraseFlashBlock(int bus, int blockNum) {
  command_t command = {0,0};
  setCommandOp(&command,Erase);
  setCommandBus(&command,bus);
  setCommandCE(&command,0);
  setCommandBlockAddr(&command,blockNum);
  sendCommand(&command);
}

void readFlashPage(int bus, int blockNum, int pageNum, int *ramAddr) {
  command_t command = {0,0};
  setCommandOp(&command,Read);
  setCommandBus(&command,bus);
  setCommandCE(&command,0);
  setCommandRAMAddr(&command,(int)ramAddr);
  setCommandBlockAddr(&command,blockNum);
  setCommandPageAddr(&command,pageNum);
  setCommandLength(&command,2048);
  sendCommand(&command);
}

void writeFlashPage(int bus, int blockNum, int pageNum, int *ramAddr) {
  command_t command = {0,0};
  setCommandOp(&command,Write);
  setCommandBus(&command,bus);
  setCommandCE(&command,0);
  setCommandRAMAddr(&command,(int)ramAddr);
  setCommandBlockAddr(&command,blockNum);
  setCommandPageAddr(&command,pageNum);
  setCommandLength(&command,2048);
  sendCommand(&command);
}

long long checkBusy() {
  long long status = *(SSD+8);
  return (status & 0xf) != 0;   
}

void dumpControllerStatus() {
   long long status = *(SSD+8);
   xil_printf("SSD status: version: %x\n, busBusy: %x\n exists: %x%x\n",
          status >> 4 & 0xf,
			 status &0xf,
			 *(SSD+2),
			 *(SSD+3));
}

int testFlash(int bus, int blockNum, int pageNum, int seed) {
  initializeBlock((int*)0x00000000,512, seed);
  //xil_printf("calling erase block\n");
  eraseFlashBlock(bus,blockNum);
  while(!checkOperationsComplete()){};
  //xil_printf("calling write page\n");
  writeFlashPage(bus,blockNum,pageNum,0x00000000);
  while(!checkOperationsComplete()){}; 
  initializeBlock((int*)0x00000000,512, 1<<16);
  //xil_printf("calling read page\n");
  readFlashPage(bus,blockNum,pageNum,0x00000000);
  while(!checkOperationsComplete()){}; // gotta wait a bit
  return checkBlock((int*)0x00000000,512,seed);
}

int testFlashBlock(int bus, int blockNum, int seed) {
  int i,error=0;
  eraseFlashBlock(bus,blockNum);
  while(!checkOperationsComplete()){};
  
  for(i = 0; i < 64;  i++) {
     initializeBlock((int*)0x00000000,512, i+seed);
     writeFlashPage(bus,blockNum,i,0x00000000);
	  while(!checkOperationsComplete()){}; 
  }
  
  for(i = 0; i < 64;  i++) {
     initializeBlock((int*)0x00000000,512, i+seed);
     readFlashPage(bus,blockNum,i,0x00000000);
	  while(!checkOperationsComplete()){}; 
	  error = error | checkBlock((int*)0x00000000,512,seed+i); 
  }
  
  return error;
}

int testFlashBlockReadOnly(int bus, int blockNum, int seed) {
  int i,error=0;
  
  for(i = 0; i < 64;  i++) {
     initializeBlock((int*)0x00000000,512, i+seed);
     readFlashPage(bus,blockNum,i,0x00000000);
	  while(!checkOperationsComplete()){}; 
	  error = error | checkBlock((int*)0x00000000,512,seed+i); 
  }
  
  return error;
}

int testFlashWriteOnly(int bus, int blockNum, int pageNum, int seed) {
  initializeBlock((int*)0x00000000,512, seed);
  while(!checkOperationsComplete()){};
  //xil_printf("calling write page\n");
  writeFlashPage(bus,blockNum,pageNum,0x00000000);
  while(!checkOperationsComplete()){}; 
  return 0;
}


int testFlashReadOnly(int bus, int blockNum, int pageNum, int seed) {
  readFlashPage(bus,blockNum,pageNum,0x00000000);
  while(!checkOperationsComplete()){};  // gotta wait a bit
  return checkBlock((int*)0x00000000,512,seed);
}

int main (void) {
   int error = 0;
	int i,bus,iter;
   volatile int *resultReg = 0x00004010;
   print("-- Entering main() --\r\n");
   if(sizeof(long long) != 8) {
	   print("long long not 8\n");
	}
   /*
    * Peripheral SelfTest will not be run for debug_module
    * because it has been selected as the STDOUT device
    */
   // print out the data 
   dumpControllerStatus();
   while(checkBusy()){};
	dumpControllerStatus();
	resetFlashBuses();
   xil_printf("SSD intialized\n");
	for(iter = 0 ; iter < 30; iter++) {  
	  for(bus = 0; bus < 4; bus = bus + 1) {
       for(i = 0; i < 64; i++) {
	      if(testFlashBlock(bus,i,iter+bus+i)) {
           xil_printf("Test Error %d %d %d\n", iter, bus, i);
         }
	    }
	

       for(i = 0; i < 64; i++) {
	      if(testFlashBlockReadOnly(bus,i,iter+bus+i)) {
           xil_printf("Test Error RO %d %d %d\n", iter, bus, i);
         }
	    }
	  }
	}
	
	

   dumpControllerStatus();
	/*
    * Disable cache and reinitialize it so that other
    * applications can be run with no problems
    */

   //xil_printf("Passed if 0: %x\n", error);


	
   print("-- Exiting main() --\r\n");
   return 0;

}

