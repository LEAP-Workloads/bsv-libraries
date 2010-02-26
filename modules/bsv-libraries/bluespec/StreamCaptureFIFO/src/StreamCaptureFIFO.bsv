`include "asim/provides/stream_capture_fifo.bsh"

import FIFOF::*;

import BRAMFIFO::*;

module mkStreamCaptureFIFOF#(Integer streamSize) (FIFOF#(data_t))
  provisos(Bits#(data_t, data_sz),
           Literal#(data_t)); // required by bramfifo

  FIFOF#(data_t) fifo <- mkSizedFIFOF(streamSize);
  Reg#(State) state <- mkReg(Filling);
   
  rule setState (!fifo.notFull && state != Draining); 
    state <= Draining; 
  endrule

  rule setFilling (!fifo.notEmpty && state != Filling); 
    state <= Filling; 
  endrule
  

  method data_t first() if(state == Draining);
    return fifo.first;
  endmethod

  method Action deq() if(state == Draining);
    fifo.deq; 
  endmethod

  method Action enq(data_t data) if(state == Filling); 
    fifo.enq(data);
  endmethod

  method notEmpty = fifo.notEmpty;
  method notFull = fifo.notFull;
  method Action clear;
    fifo.clear;
    state <= Filling;
  endmethod
endmodule