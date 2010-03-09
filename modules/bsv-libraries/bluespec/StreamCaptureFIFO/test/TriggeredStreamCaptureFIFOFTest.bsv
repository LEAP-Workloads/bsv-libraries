`include "asim/provides/stream_capture_fifo.bsh"

import FIFOF::*;
import LFSR::*;


module mkHWOnlyApplication (Empty);
  TriggeredStreamCaptureFIFOF#(Bit#(32)) fifof <- mkTriggeredStreamCaptureFIFOF(512);
  Reg#(Bit#(32)) counter <- mkReg(0);
  LFSR#(Bit#(16)) lfsr <- mkLFSR_16;  
  Reg#(Bit#(9)) checkCount <- mkReg(~0);
  Reg#(Bit#(10)) totalPasses <- mkReg(0);
  let offset = (512>lfsr.value)?512:lfsr.value;

  rule stuffData (counter <= zeroExtend(offset));
    fifof.fifof.enq(counter);
    counter <= counter + 1;
    if(`DEBUG_STREAM_CAPTURE_FIFO == 1) 
      begin
        $display("TB: Enq %h", counter);
      end
  endrule

  rule trigger(counter > zeroExtend(offset));
    fifof.trigger;
    if(`DEBUG_STREAM_CAPTURE_FIFO == 1) 
      begin
        $display("TB: Firing trigger");
      end
  endrule
  

  rule check;
    fifof.fifof.deq;

    if(fifof.fifof.first != zeroExtend(offset - zeroExtend(checkCount)))
      begin
        $display("Error: expected: %h, got %h", offset   - zeroExtend(checkCount),fifof.fifof.first);
        $finish; 
      end

    if(`DEBUG_STREAM_CAPTURE_FIFO == 1) 
      begin
        $display("deqed: %h", fifof.fifof.first);
      end

    checkCount <= checkCount - 1;
    if(checkCount == 0) 
      begin
        totalPasses <= totalPasses + 1;
        lfsr.next;
        counter <= 0;
        if(`DEBUG_STREAM_CAPTURE_FIFO == 1) 
          begin
            $display("TB: Check complete");
          end
      end
    if(totalPasses + 1 == 0) 
      begin
        $display("PASS");
        $finish;
      end
  endrule


endmodule