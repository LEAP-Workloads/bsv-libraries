#include<assert.h>
#include<stdlib.h>
#include<math.h>
#include<stdio.h>

#define DEBUG

int fftLength = 0;
int intSize = 0;
int fracSize = 0;
int *realValues = NULL;
int *imagValues = NULL;
double *realResult = NULL;
double *imagResult = NULL;


int DFT(int dir,int m,double *x1,double *y1)
{
   long i,k;
   double arg;
   double cosarg,sinarg;
   double *x2=NULL,*y2=NULL;

   x2 = malloc(m*sizeof(double));
   y2 = malloc(m*sizeof(double));
   if (x2 == NULL || y2 == NULL)
      return 0;

   for (i=0;i<m;i++) {
      x2[i] = 0;
      y2[i] = 0;
      arg = - dir * 2.0 * 3.141592654 * (double)i / (double)m;
      for (k=0;k<m;k++) {
         cosarg = cos(k * arg);
         sinarg = sin(k * arg);
         x2[i] += (x1[k] * cosarg - y1[k] * sinarg);
         y2[i] += (x1[k] * sinarg + y1[k] * cosarg);
      }
   }

   /* Copy the data back */
   if (dir == 1) {
      for (i=0;i<m;i++) {
         x1[i] = x2[i] ;
         y1[i] = y2[i] ;
      }
   } else {
      for (i=0;i<m;i++) {
         x1[i] = x2[i];
         y1[i] = y2[i];
      }
   }

   free(x2);
   free(y2);
   return 1;
}


void generateFFTValues (int fftSize, int realBitSize, int fracBitSize) {
  int i;

  if(realValues != NULL) {
    free(realValues);
  }
  if(imagValues != NULL) {
    free(imagValues);
  }

  if(realResult != NULL) {
    free(realResult);
  }
  if(imagResult != NULL) {
    free(imagResult);
  }


  assert(fftSize);
  fftLength = fftSize;
  intSize = realBitSize;
  fracSize = fracBitSize;

  realValues = malloc(sizeof(int) * fftLength);
  imagValues = malloc(sizeof(int) * fftLength);
  realResult = malloc(sizeof(double) * fftLength);
  imagResult = malloc(sizeof(double) * fftLength);
  #ifdef DEBUG
    printf("C Input\n");
  #endif
  for(i = 0; i < fftSize; i++) {
    realValues[i] = (rand()%(1<<(intSize+fracSize)));
    imagValues[i] = (rand()%(1<<(intSize+fracSize)));
    if(realValues[i] > ((1<<(intSize+fracSize-1))-1)) {
      realResult[i] = ((realValues[i])/((float)(1<<fracSize)) - (1<<(intSize)))/fftSize;    
      realValues[i] = realValues[i] - (1<<(intSize+fracSize));      
      
    } else {
      realResult[i] = (realValues[i]/((float)(1<<fracSize)))/fftSize;
    }

    if(imagValues[i] > ((1<<(intSize+fracSize-1))-1)) {
      imagResult[i] = (imagValues[i]/((float)(1<<fracSize))- (1<<(intSize)))/fftSize;
      imagValues[i] = imagValues[i] - (1<<(intSize+fracSize)); 
    } else {
      imagResult[i] = (imagValues[i]/((float)(1<<fracSize)))/fftSize;    
    }

    realValues[i] = realValues[i]/fftSize;
    imagValues[i] = imagValues[i]/fftSize;
    #ifdef DEBUG
      printf("  %f+%fi  ",realResult[i],imagResult[i]);
    #endif
  }

  DFT(1,fftSize,realResult,imagResult);


  #ifdef DEBUG
    printf("\r\n");
    for(i = 0; i < fftSize; i++) {
      printf("C FFT[%d]: %f+%f\r\n", i,realResult[i],imagResult[i]);
    }
  #endif
}


int getRealInput(int index) {
  return realValues[index];
}

int checkRealResult(int index, int result) {
  #ifdef DEBUG
    printf("Real result: %f, expect %f\n", result/((double) (1<<fracSize)), realResult[index]);
  #endif
  assert((realResult[index] - 16/fracSize < result/((double) (1<<fracSize))) &&
	 (realResult[index] + 16/fracSize > result/((double) (1<<fracSize))));
  return 1;
} 

int getImagInput(int index) {
  return imagValues[index];
}

int checkImagResult(int index, int result ) {
  #ifdef DEBUG
  printf("Imag result: %f expect: %f\n", result/((double) (1<<fracSize)), imagResult[index]);  
  #endif
  assert((imagResult[index] - 16/fracSize < result/((double) (1<<fracSize))) &&
	 (imagResult[index] + 16/fracSize > result/((double) (1<<fracSize))));
  return 1;
} 
