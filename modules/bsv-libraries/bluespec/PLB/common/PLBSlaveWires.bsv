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

// Global Imports
import GetPut::*;

interface PLBSlaveWires#(numeric type addr_width,
                         numeric type data_width);

  (* always_ready *)
  method Action sABus(Bit#(addr_width) addr); // Address Bus

  (* always_ready *)
  method Action sBE(Bit#(TDiv#(data_width,8)) be);       // Byte Enable

  (* always_ready *)
  method Action sCS(Bit#(1) cs);  // Bus lock

  (* always_ready *)
  method Action sRdCE(Bit#(2) rdCE);  // Bus lock

  (* always_ready *)
  method Action sWrCE(Bit#(2) wrCE);  // Bus lock

  (* always_ready *)
  method Action sRdReq(Bit#(1) rdReq);  // Bus lock

  (* always_ready *)
  method Action sWrReq(Bit#(1) wrReq);  // Bus lock

  (* always_ready *)
  method Action sDataIn(Bit#(data_width) data);
  
  (* always_ready, always_enabled *)
  method Bit#(data_width) sDataOut();

  (* always_ready, always_enabled *)
  method Bit#(1) sBusy();

  (* always_ready, always_enabled *)
  method Bit#(1) sRetry();

  (* always_ready, always_enabled *)  
  method Bit#(1) sError();

  (* always_ready, always_enabled *)
  method Bit#(1) sToutSup();

  (* always_ready, always_enabled *)
  method Bit#(1) sRdAck();

  (* always_ready, always_enabled *)
  method Bit#(1) sWrAck();
   
endinterface
