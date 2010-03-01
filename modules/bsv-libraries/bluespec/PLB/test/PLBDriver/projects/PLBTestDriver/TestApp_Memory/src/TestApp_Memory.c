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

void testMem (volatile int *data){
	  int i = 0;
     
	  xil_printf("start mem test\n");
	  
	  for (i = 0; i < 16; i = i + 1) {
   	  xil_printf("Initial %x: %x\n", data+i, *(data+i));
	     *(data+i) = data+i;  
	  }
	  xil_printf("begin read back\n");
	  for (i = 0; i < 16; i = i + 1) {
	     if(*(data+i) != data+i) {
          xil_printf("Failed to write %x: expected %x got %x\n", data+i, data+i, *(data+i));
        }	
        else{ 
          xil_printf("Success to write %x: expected %x got %x\n", data+i, data+i, *(data+i));        }		  
	  }	  
	 xil_printf("test complete\n"); 
}



int main (void) {


   print("-- Entering main() --\r\n");

   /*
    * Peripheral SelfTest will not be run for debug_module
    * because it has been selected as the STDOUT device
    */
  // print out the data 
	
   testMem(0x00000000);
	testMem(0x00001000);
   testMem(0x00002000);
	testMem(0x00003000);
   testMem(0x00004000);
   /*
    * Disable cache and reinitialize it so that other
    * applications can be run with no problems
    */



   print("-- Exiting main() --\r\n");
   return 0;

}

