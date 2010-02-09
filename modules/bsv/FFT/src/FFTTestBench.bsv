import Complex::*;
import Vector::*;
import FixedPoint::*;
import FIFO::*;
import FFT::*;
import StmtFSM::*;


import "BDPI" function Action generateFFTValues(int fftSize, int realBitSize, int imagBitSize);
import "BDPI" function FixedPoint#(8,16) getRealInput(int index);
import "BDPI" function ActionValue#(Bool) checkRealResult(int index, int result);
import "BDPI" function FixedPoint#(8,16) getImagInput(int index);
import "BDPI" function ActionValue#(Bool) checkImagResult(int index, int result);
import "BDPI" function Action freeLast();

typedef 8 FFTPoints;

module mkFFTTestBench();
  Reg#(Bool) inflight <- mkReg(False);
  Reg#(Vector#(FFTPoints,Complex#(FixedPoint#(8,16)))) dataBuffer <- mkReg(newVector());
  Reg#(Int#(32)) loopCount <- mkReg(0);
  Reg#(Bit#(16)) runCount <- mkReg(0);

  FFT#(FFTPoints,Complex#(FixedPoint#(8,16))) fft <- mkFFT();

  Reg#(Bool) incorrect  <- mkReg(False);

  Stmt testSeq  = seq action generateFFTValues(fromInteger(valueof(FFTPoints)), 8, 16); endaction
                      for(loopCount <= 0; loopCount < fromInteger(valueOf(FFTPoints)); loopCount<=loopCount+1) 
                        par
                          action
                            FixedPoint#(8,16) realVal = getRealInput(loopCount);
                            FixedPoint#(8,16) imagVal = getImagInput(loopCount);
                            dataBuffer[loopCount] <= cmplx(realVal,imagVal);
                          endaction
                        endpar
                      fft.fftInput(dataBuffer);
                      action 
                        Vector#(FFTPoints,Complex#(FixedPoint#(8,16))) outputData <- fft.fftOutput();
                        dataBuffer <= outputData;
                      endaction
                      for(loopCount <= 0; loopCount < fromInteger(valueOf(FFTPoints)); loopCount<=loopCount+1) 
                        seq
                          action
                            let incorrectReal <- checkRealResult(loopCount,unpack(signExtend(pack(dataBuffer[loopCount].rel))));
                            let incorrectImag <- checkImagResult(loopCount,unpack(signExtend(pack(dataBuffer[loopCount].img))));
                            incorrect <= incorrect || incorrectReal || incorrectImag;
                          endaction
                        endseq
                      if(incorrect) 
                        seq
                          $finish;
                        endseq
                      freeLast();
                  endseq;

  FSM testbench <- mkFSM(testSeq);
   
  rule run_bench(testbench.done());
    testbench.start(); 
    runCount <= runCount + 1;
    if(runCount == 1000) 
      begin
        $display("All Tests Passed");
        $finish;
      end
  endrule
  
  
  

endmodule
