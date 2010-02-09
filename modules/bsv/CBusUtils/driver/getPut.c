#include "getPut.h"

#define FOREVER for(;;)

int attemptPut(Put* dev, int *data, int dataLength) {
  int count = 0;
  //alt_printf("put ctrl@%x= %x\r\n", (dev->ptr), (*(dev->ptr)) >> 1) ; 
  FOREVER {   
    if((*(dev->ptr)) & 0x1 != 0) {
        //alt_printf("put ctrl@%x= %x\r\n", (dev->ptr), *(dev->ptr) >> 1) ; 
        count++;
    } else {
      break;   
    }
    if(count == 100) {
      //alt_printf("put ctrl@%x= %x\r\n", (dev->ptr), *(dev->ptr) >> 1) ; 
      //alt_printf("put time out\r\n") ; 
      goto error;   
    }
  }
//  alt_printf("sending a put\r\n");
  for(count = 0; count < dataLength; count++) {
    *((dev->ptr) + 1 + count) = data[count];  
  }
  *(dev->ptr) = 1;
  
  return 0;
  
  error:
    return -1;
}

int attemptGet(Get* dev, int *data, int dataLength) {
  int count = 0;
  //alt_printf("get ctrl@%x= %x\r\n", (dev->ptr), (*(dev->ptr)) >> 1) ; 
  if(!dev->pending) {  
     
    FOREVER {   
      if(((*(dev->ptr)) & 0x1) != 0) {
        count++;
      }
      else {
        dev->pending = 1;
        *(dev->ptr) = 1;
        break; 
      }
      if(count == 100) {
        //alt_printf("get ctrl@%x= %x\r\n", dev->ptr, *(dev->ptr)>>1) ;
        //alt_printf("get timeout\r\n");
        goto error;   
      }
    }
  }
  
  // Check for flag set down
  count = 0;
  FOREVER {
    if(((*(dev->ptr)) & 0x1) == 1) {
      count++;   
    } else {
        dev->pending = 0;
        break;
    }
    if(count == 100) {
      //alt_printf("get ctrl@%x= %x\r\n", dev->ptr, *(dev->ptr)>>1) ;
      //alt_printf("get timeout\r\n");
      goto error;   
    }
  }
  
  for(count = 0; count < dataLength; count++) {
    //alt_printf("Get: *dev->ptr: %x->%x\r\n", ((dev->ptr) + 1 + count), *(int*)((dev->ptr) + 1 + count));
    data[count] = *((dev->ptr) + 1 + count) ;  
  }
 
  return 0;
  
  error:
    return -1;
}