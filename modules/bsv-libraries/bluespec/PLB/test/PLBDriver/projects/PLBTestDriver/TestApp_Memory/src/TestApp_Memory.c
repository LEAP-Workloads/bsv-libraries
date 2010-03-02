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

int testMem (volatile long long *data){
	  long long i = 0;
     
	  //xil_printf("start mem test\n");
	  
	  for (i = 0; i < 16; i = i + 1) {
   	  //xil_printf("Initial %x: %x\n", data+i, *(data+i));
	     *(data+i) = data+i;  
	  }
	  //xil_printf("begin read back\n");
	  for (i = 0; i < 16; i = i + 1) {
	     if(*(data+i) != data+i) {
          xil_printf("Failed to write %x: expected %x got %x\n", data+i, data+i, *(data+i));
          return 1;			
        }	
        else{ 
          //xil_printf("Success to write %x: expected %x got %x\n", data+i, data+i, *(data+i));        }		  
        }
	  }	  
	 //xil_printf("test complete\n"); 
	 return 0;
}

int testReadableRegs (){
	  long long i = 0,j = 0, data = 0x00004018;
     volatile long long *ptr = 0x00004018;
	  
	  //xil_printf("start mem test\n");
	  
     for(j = 0; j < 100000; j = j +1) {
       //xil_printf("begin read back\n");
	    for (i = 0; i < 8; i = i + 2) {
	       if(*(ptr+i) != data+8*i) {
            xil_printf("Failed to write %x: expected %x%x got %x%x\n", ptr+i, data+8*i, *(ptr+i));
				return 1;
          }	
          else{ 
            //xil_printf("Success to write %x: expected %x%x got %x%x\n", ptr+i, data+8*i, *(ptr+i));		  
          }
	    }	
     }		 
	 //xil_printf("test complete\n"); 
  return 0;
}

int testWritableRegs() {
  long long i;
  volatile long long *regA = 0x00004000;
  volatile long long *regB = 0x00004008;
  for(i=0; i<0x100000; i=i+1) {
    *regA = 2*i;
	 *regB = *regA + 6;
	 *regA = *regA - 3;
	 if((*regB != 2*i+6) || (*regA != 2*i - 3)) {
	   xil_printf("RegA g: %x%x e: %x%x RegB g: %x%x e: %x%x\n",*regA, 2*i - 3, *regB, 2*i+6);
	   return 1;	
	 }
  }
  return 0;
}

int testCharWrite() {
  long long i;
  volatile long long *regA = 0x00004000;
  volatile char *regStr = 0x00004000;
  char * test = "0123456789abcdef"; 
  for(i=0; i<16; i=i+1) {
     regStr[i]=test[i];
  }
  for(i=0; i<16; i=i+1) {
     if(regStr[i] != test[i]) {
	    xil_printf("RegA[%d]: %x, expected %x\n",regStr[i],test[i]);
	    return 1;
	  } 
  }  
  return 0;
}

int main (void) {
   int error = 0;
   volatile int *resultReg = 0x00004010;
   print("-- Entering main() --\r\n");

   /*
    * Peripheral SelfTest will not be run for debug_module
    * because it has been selected as the STDOUT device
    */
  // print out the data 
	
   error |= testMem(0x00000000);

   error |= testWritableRegs();
   error |= testReadableRegs();
   error |= testCharWrite();
   
	/*
    * Disable cache and reinitialize it so that other
    * applications can be run with no problems
    */

   xil_printf("Passed if 0: %x\n", error);

   if(error) {
	   *resultReg = 0xffffffff;
		*(resultReg+1) = 0xffffffff;
	} else {
	   *resultReg = 0xaaaaaaaa;
	   *(resultReg+1) = 0xaaaaaaaa;		
	}
	
   print("-- Exiting main() --\r\n");
   return 0;

}

