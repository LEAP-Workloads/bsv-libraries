#ifndef GETPUT_H_
#define GETPUT_H_

// XXX define these as void pointers to test theory...

typedef struct {
  volatile int *ptr;
} Put;

int attemptPut(Put* dev, int *data, int dataLength);
 
typedef struct {
  volatile int *ptr;
  int pending;
} Get;

// need to maintain information about gets, since 
// we have state.
int attemptGet(Get* dev, int *data, int dataLength);
 
#endif /*GETPUT_H_*/
