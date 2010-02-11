`include "asim/provides/debug_utils.bsh"

import FIFO::*;
import FIFOF::*;
import GetPut::*;
import Vector::*;


Bool crcDebug = False;

interface CRC#(type data, type in);
   method Action        inputBits(in bitIn);
   method data          getRemainder();
   method Action        init();
endinterface

module mkNaiveCRC#(Bit#(TAdd#(1,width)) initPoly, Bit#(width) initRem) (CRC#(Bit#(width),Bit#(1)))
   provisos(Add#(width, 1, TAdd#(1, width)));
   
   Reg#(Bit#(TAdd#(1,width)))  poly    <- mkReg(initPoly);
   Reg#(Bit#(width))           rem     <- mkReg(0);


   method Bit#(width)   getRemainder();
     return rem;
   endmethod      

   method Action init();
     rem <= initRem;
   endmethod

   method Action inputBits(Bit#(1) bitIn);
      Bit#(TAdd#(1,width)) new_rem = ({0,rem} << 1) | zeroExtend(bitIn);
      if(new_rem[valueof(width)]==1) // grab top bit
	 new_rem = new_rem ^ poly;
      debug(crcDebug,$display("CRC input %b rem %b new_rem %b poly %b init %b", bitIn, rem, new_rem, poly, initRem));
      rem <= truncate(new_rem);     
   endmethod
   
endmodule


module mkParallelCRC#(Bit#(TAdd#(1,width)) initPoly, Bit#(width) initRem) (CRC#(Bit#(width),Bit#(in)))
   provisos(Add#(width, 1, TAdd#(1, width)),
            Mul#(xxx, in, width)
   );
   
   Reg#(Bit#(TAdd#(1,width)))  poly    <- mkReg(initPoly);
   Reg#(Bit#(width))           rem     <- mkReg(0);

   method Bit#(width)   getRemainder();
     return rem;
   endmethod      

   method Action init();
     rem <= initRem;
   endmethod

   // silly unfolding, but whatever...
   // should probably do this as a foldr but i'm too lazy today.
   method Action inputBits(Bit#(in) bitIn);
      Bit#(TAdd#(1,width)) new_rem = ?;
      Bit#(width) rem_temp = rem;
      for(Integer i = 0; i < valueof(in); i = i + 1)
        begin
          new_rem = {rem_temp, reverseBits(bitIn)[i]};
          if(new_rem[valueof(width)]==1) // grab top bit
	    new_rem = new_rem ^ poly;
          rem_temp = truncate(new_rem);
        end
      Bit#(width) rem_trunc= truncate(new_rem);
      debug(crcDebug,$display("CRC input %b rem %b new_rem %b poly %b init %b", bitIn, rem, rem_trunc, poly, initRem));
      rem <= truncate(new_rem);     
   endmethod
   
endmodule



