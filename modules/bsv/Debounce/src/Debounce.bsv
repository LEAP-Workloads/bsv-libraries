
module mkDebouncedReg#(data initialVal, Integer debounceCycles) (Reg#(data))
   provisos(Bits#(data,dataSz),
            Eq#(data));

   Reg#(data) debounced <- mkReg(initialVal);
   Reg#(data) debounceTarget <- mkReg(initialVal);
   Reg#(data) debouncee <- mkReg(initialVal);
   Reg#(Bit#(32)) debounceTime <- mkReg(0);
 
   rule done (debouncee == debounceTarget && debounceTime == 0);
     debounced <= debounceTarget;
   endrule

   rule startDebounce(debounceTarget != debouncee);
     debounceTime <= fromInteger(debounceCycles);
     debounceTarget <= debouncee;
   endrule

   rule tickDebounce (debouncee == debounceTarget && debounceTime > 0);
     debounceTime <= debounceTime - 1;
   endrule

   method _read = debounced._read;
   method _write = debouncee._write;
endmodule