#include "cLib.h"

#define BramBaseAddress ((volatile int*)(0xE8800000))
#define BramInstructionStart (BramBaseAddress)
#define BramOutputStart (BramBaseAddress+32)

static int bramInstruction = 0;
static int bramOutput = 0;

void initialize()
{
    int i;
    bramInstruction = 0;
    bramOutput = 0;
	 for(i=0; i<64; i++)
	 {
	    *(BramBaseAddress + i) = 0;
	 }
}

inline int byteReverse(int x){

 int a =  ((x>>24) & 0xff) +
			 ( (x>>8) & 0xff00) + 
			 ( (x<<8) & 0xff0000) +
			 ((x<<24) & 0xff000000); 

 return(a);
 
}





int putValue(int value)
{
	 volatile int* ptr;
	 int i = 0;
    int x0 = 0;
	 int x1 = value;
	 int x1rev;
	 int x0rev;
	 
    ptr = BramInstructionStart + bramInstruction;
	 while(*(ptr) != 0 )
    {
       i++;
		 if(i > 1000)
		 {
		    return -1;
		 }
    }	 
	 
	 x0 = x0 | 0x80000000;
	
    x1rev = x1;
	 x0rev = x0;

	 // Write the second value first to avoid timing problems
	 (*(ptr + 1)) = x1rev;
    (*ptr)       = x0rev;

	 if((bramInstruction + 2) == 32)
    {	
      bramInstruction = 0;
    }  
	 else
    {
      bramInstruction += 2;
	 }
	 
	 return 0;
}

int getResponse()
{
    int i = 0;
	 int output;
	 int outputRev;
	 volatile int* ptr;
	 
	 ptr = BramOutputStart + bramOutput;
	  
	 while((*ptr & 0x80000000) == 0)
	 {
	    i++;
		 if(i > 1000)
		 {
		    return -1;
		 }
	 }
	 
	 output = (*(int*)(ptr + 1)); //Read next line
	 outputRev = output;
	 (*(int *)ptr) = 0;
	 
	 if(bramOutput + 2 == 32)
	 {
	    bramOutput = 0;
	 }
	 else
    {
	    bramOutput = bramOutput + 2;
	 } 
	 
    return(outputRev & 0x7FFFFFF);
}
