//**********************************************************************
// Bypass FIFO
//----------------------------------------------------------------------
// $Id: BFIFO.bsv,v 1.5 2006/03/22 14:56:40 pellauer Exp $
//
//

package BFIFO;

import FIFO::*;
import FIFOF::*;
import List::*;
import Monad::*;
import Assert::*;

module mkBFIFO1( FIFO#(item_t) ) provisos ( Bits#(item_t,item_sz) );

  RWire#(item_t) inputWire  <- mkRWire();
  PulseWire      deqEnabled <- mkPulseWire();
  PulseWire      clearEnabled <- mkPulseWire();

  Reg#(item_t) register <- mkRegU();
  Reg#(Bool)   valid <- mkReg(False);

  // If there is an input item on the inputWire wire and dequeue did not 
  // execute this cycle then we need to store the item in the register

  (*fire_when_enabled*)   
  rule update ( True );
    case (inputWire.wget()) matches 
      tagged Invalid:
         if (deqEnabled || clearEnabled)
	   valid <= False;
      tagged Valid .x:
        begin
          register <= x;
	  valid <= !(deqEnabled || clearEnabled);
	end
    endcase
  endrule

  // On enqueue we write the input item to the inputWire wire

  method Action enq( item_t item ) if ( !valid );
    inputWire.wset(item);
  endmethod

  // On dequeue we always invalidate the storage register regardless
  // of whether or not the item was actually bypassed or not. We also
  // set a combinational signal so that we know not to move the item
  // into the register this cycle.

  method Action deq() if ( valid || isValid(inputWire.wget()) );
    deqEnabled.send();
  endmethod  

  // We get the item either from the register (if register is valid) or
  // from the combinational bypasss (if the rwire is valid).

  method item_t first() if ( valid || isValid(inputWire.wget()) );
    if ( valid )
      return register;
    else
      return unJust(inputWire.wget());    
  endmethod

  method Action clear();
    clearEnabled.send();
  endmethod

endmodule

module mkSizedBFIFO#(Integer n)  ( FIFO#(item_t) ) provisos ( Bits#(item_t,item_sz) );

  RWire#(item_t) inputWire  <- mkRWire();
  PulseWire      deqEnabled <- mkPulseWire();
  PulseWire      clearEnabled <- mkPulseWire();

  List#(Reg#(item_t)) registers <- replicateM(n, mkRegU);
  List#(Reg#(Bool))   valids <- replicateM(n, mkReg(False));

  function Nat getNextFree (List#(Reg#(Bool)) vs);

    Nat res = fromInteger(n - 1);

    for (Integer x = n - 1; x > -1; x = x - 1)
      res = !vs[x]._read() ? fromInteger(x) : res;

    return res;
  
  endfunction

  function Bool notFull();
  
    Bool full = True;

    for (Integer x = 0; x < length(valids); x = x + 1)
      full = full && valids[x]._read();

    return !full;
  
  endfunction
  // If there is an input item on the inputWire wire and dequeue did not 
  // execute this cycle then we need to store the item in the register

  rule update ( True );
    Nat next = getNextFree(valids);
    
    next = (deqEnabled) ? next - 1 : next;
    
    (valids[next]) <= isValid(inputWire.wget());
    (registers[next]) <= validValue(inputWire.wget());
    
    if (deqEnabled && !clearEnabled)
    begin
      
      for (Nat x = 0; x < (next - 1); x = x + 1)
      begin
	(valids[x]) <= valids[x+1]._read();
	(registers[x]) <= registers[x+1]._read();
      end
      
    end
    else if (clearEnabled)
    begin
    
      for (Integer x = 0; x < n; x = x + 1)
	(valids[x]) <= False;
    
    end
  endrule

  // On enqueue we write the input item to the inputWire wire

  method Action enq( item_t item ) if ( notFull );
    inputWire.wset(item);
  endmethod

  // On dequeue we always invalidate the storage register regardless
  // of whether or not the item was actually bypassed or not. We also
  // set a combinational signal so that we know not to move the item
  // into the register this cycle.

  method Action deq() if ( valids[0]._read() || isValid(inputWire.wget()) );
    deqEnabled.send();
  endmethod  

  // We get the item either from the register (if register is valid) or
  // from the combinational bypasss (if the rwire is valid).

  method item_t first() if ( valids[0]._read() || isValid(inputWire.wget()) );
    if ( valids[0]._read() )
      return registers[0]._read();
    else
      return unJust(inputWire.wget());    
  endmethod


  method Action clear();
    clearEnabled.send();
  endmethod

endmodule


module mkBFIFOF1( FIFOF#(item_t) ) provisos ( Bits#(item_t,item_sz) );

  RWire#(item_t) inputWire  <- mkRWire();
  RWire#(Bool)   deqEnabled <- mkRWire();

  Reg#(Maybe#(item_t)) register <- mkReg(Invalid);

  // If there is an input item on the inputWire wire and dequeue did not 
  // execute this cycle then we need to store the item in the register

  rule noDeq ( isValid(inputWire.wget()) && !isValid(deqEnabled.wget()) );
    register <= inputWire.wget();
  endrule

  // On enqueue we write the input item to the inputWire wire

  method Action enq( item_t item ) if ( !isValid(register) );
    inputWire.wset(item);
  endmethod

  // On dequeue we always invalidate the storage register regardless
  // of whether or not the item was actually bypassed or not. We also
  // set a combinational signal so that we know not to move the item
  // into the register this cycle.

  method Action deq() if ( isValid(register) || isValid(inputWire.wget()) );
    register <= Invalid;
    deqEnabled.wset(True);
  endmethod  

  // We get the item either from the register (if register is valid) or
  // from the combinational bypasss (if the rwire is valid).

  method item_t first() if ( isValid(register) || isValid(inputWire.wget()) );
    if ( isValid(register) )
      return unJust(register);
    else
      return unJust(inputWire.wget());    
  endmethod

  // FIFOF adds the following two methods

  method Bool notFull();
    return !isValid(register);
  endmethod

  method Bool notEmpty();
    return (isValid(register) || isValid(inputWire.wget()));
  endmethod

  // Not sure about the clear method ...

  method Action clear();
    dynamicAssert( False, "BFIFO.clear() not implemented yet!" );
  endmethod

endmodule

(* synthesize *)
module mkBFIFO_16 (FIFO#(Bit#(16)));

  let f <- mkBFIFO1();
  
  return f;

endmodule

endpackage
