/*
Copyright (c) 2007 MIT

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

Author: Kermin Fleming
*/

import BRAMInitiatorWires::*;
import BRAMLegacy::*;
import FIFOF::*;
 
interface BRAMInitiator#(type idx_type);
  interface BRAM#(idx_type, Bit#(32)) bram;
  interface BRAMInitiatorWires#(idx_type) bramInitiatorWires;
endinterface

typedef enum{
  Init,
  Idle,
  Write, 
  Read,
  ReadWait
} BRAMInitiatorState deriving (Bits,Eq);

 
module mkBRAMInitiatorBSV (BRAMInitiator#(idx_type))
  provisos
          (Bits#(idx_type, idx),
	   Literal#(idx_type));
  FIFOF#(Bit#(32)) readRespQ <- mkSizedFIFOF(2);
  Reg#(BRAMInitiatorState) state  <- mkReg(Init);
  Reg#(Bool) driveWEN <- mkReg(True);
  PulseWire  wen <- mkPulseWire;
  Reg#(idx_type) addr <- mkReg(0);
  Reg#(Bit#(32))   dataOut <- mkReg(0);
  RWire#(Bit#(32)) dataInWire <- mkRWire; 
  let clock <- exposeCurrentClock;

  rule flopEnable(state == Init);
    state <= Idle;
  endrule

  rule handleRead(dataInWire.wget matches tagged Valid .data &&& 
                  state == Read);  
    readRespQ.enq(data);
    state <= Idle;
  endrule

  rule handleReadWait(state == ReadWait);
    state <= Read;
  endrule
 
  rule handleWrite(state == Write);
    state <= Idle;
  endrule

  interface BRAM bram;
    method Action write(idx_type idx, Bit#(32) value) if(state == Idle);
      addr <= idx;
      dataOut <= value;
      state <= Write;
    endmethod 

    method Action read_req(idx_type idx) if(state == Idle && 
                                            readRespQ.notFull); 
      addr <= idx;
      state <= ReadWait;
    endmethod

    method ActionValue#(Bit#(32)) read_resp;
      readRespQ.deq;
      return readRespQ.first;
    endmethod 
  endinterface


  interface BRAMInitiatorWires bramInitiatorWires;
    interface bramCLK  = clock;

    method Bit#(1) bramRST;
      return 0;// Xilinx is posedge reset.
    endmethod 

    // XXX Handle idx type in the wrapper vlog...
    method idx_type bramAddr = addr._read;
  
    method Bit#(32) bramDout = dataOut._read;
  
    method Action bramDin (Bit#(32) data); 
      dataInWire.wset(data);    
    endmethod  

    method Bit#(4) bramWEN;
      return (state == Write)?~0:0;
    endmethod

    method Bit#(1) bramEN;
      return (state != Init)?1:0;
    endmethod
  endinterface
endmodule



/*
interface BRAMInitiatorFlat#(type idx_type);
  method ActionValue#(Bit#(32)) read_resp();
  method Action read_req(idx_type idx);
  method Action write(idx_type idx, Bit#(32) value);
  method Bit#(1) bramCLK();
  method Bit#(1) bramRST();
  method idx_type bramAddr();
  method Bit#(32) bramDout();
  method Action bramDin(Bit#(32) value);
  method Bit#(4) bramWEN();
  method Bit#(1) bramEN();
endinterface


module mkBRAMInitiator (BRAMInitiator#(idx_type))
  provisos
          (Bits#(idx_type, idx),
	   Literal#(idx_type));
  BRAMInitiatorFlat#(idx_type) bramFlat <- mkBRAMInitiatorFlat();  
 
  interface BRAM bram;
     method write = bramFlat.write;
     method read_req = bramFlat.read_req;
     method read_resp = bramFlat.read_resp;
  endinterface

  interface BRAMInitiatorWires bramInitiatorWires;
  method bramCLK    = bramFlat.bramCLK;
  method bramRST    = bramFlat.bramRST;
  method bramAddr   = bramFlat.bramAddr;
  method bramDout   = bramFlat.bramDout;
  method bramDin    = bramFlat.bramDin;
  method bramWEN    = bramFlat.bramWEN;
  method bramEN     = bramFlat.bramEN;
  endinterface

endmodule



import "BVI" BRAMInitiator = module mkBRAMInitiatorFlat
  //interface:
              (BRAMInitiatorFlat#(idx_type)) 
  provisos
          (Bits#(idx_type, idx),
	   Literal#(idx_type));

  default_clock clk(CLK);

  parameter addr_width = valueof(idx);

  method DOUT read_resp() ready(DOUT_RDY) enable(DOUT_EN);
  
  method read_req(RD_ADDR) ready(RD_RDY) enable(RD_EN);
  method write(WR_ADDR, WR_VAL) enable(WR_EN);

  method BRAM_CLK bramCLK();
  method BRAM_RST bramRST();
  method BRAM_Addr bramAddr();
  method BRAM_Dout bramDout();
  method bramDin(BRAM_Din) enable(BRAM_Dummy_Enable);
  method BRAM_WEN bramWEN();
  method BRAM_EN bramEN();

  schedule read_req  CF (read_resp, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule read_resp CF (read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule write     CF (read_req, read_resp, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  // All the BRAM methods are CF
  schedule bramCLK  CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule bramRST  CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule bramAddr CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule bramDout CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule bramDin  CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule bramWEN  CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
  schedule bramEN   CF (read_resp, read_req, write, bramCLK, bramRST, bramAddr, bramDout, bramDin, bramWEN, bramEN);
 
  schedule read_req  C read_req;
  schedule read_resp C read_resp;
  schedule write     C write;

endmodule
*/