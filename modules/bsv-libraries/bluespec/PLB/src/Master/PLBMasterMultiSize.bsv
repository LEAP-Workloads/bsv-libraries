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

/* This file implements a PLB bus master.  The bus master operates on static 
   sized bursts.  It is written in such a way that read/write bursts may be 
   overlapped, if the bus and target slave support such a feature. There's also
   support for pipelining of read and write requests.  The master is 
   parameterized by BeatsPerBurst (burst length) and BusWord (bus width), 
   which allow it to be used for various applications.   
*/


`include "asim/provides/plb_common.bsh"
`include "asim/provides/librl_bsv_base.bsh"
`include "asim/provides/rewind_fifo.bsh"
`include "asim/provides/commit_fifo.bsh"
`include "asim/provides/register_library.bsh"

// Global Imports
import GetPut::*;
import FIFO::*;
import RegFile::*;
import FIFOF::*;
import Vector::*;
import Clocks::*;

typedef enum {   
  Idle,
  Data,
  WaitForBusy
} StateTransfer 
    deriving(Bits, Eq);
  
typedef enum {   
  Idle,
  RequestingLoad,
  RequestingStore
} StateRequest 
    deriving(Bits, Eq);

typedef TMul#(4,BeatsPerBurst) OutputBufferSize;

module mkPLBMaster#(Clock externalClock, Reset externalReset) (PLBMaster);
  Clock plbClock <- exposeCurrentClock();
  Reset plbReset <- exposeCurrentReset();
  // state for the actual magic memory hardware

  SyncFIFOIfc#(BURST_REQUEST#(PLBAddr,PLBMaxBurst)) plbMasterCommandInfifo <- mkSyncFIFOToCC(2,externalClock,externalReset);


  // Output buffers
  CommitFIFOLevel#(BusWord,OutputBufferSize) outfifo <- mkCommitFIFOLevel;
  RewindFIFOLevel#(BusWord,OutputBufferSize) infifo <- mkRewindFIFOLevel;

  // For now put the clock crossing as a seperate FIFO...
  
  SyncFIFOIfc#(BusWord) infifoCC <- mkSyncFIFOToCC(2,externalClock,externalReset);
  SyncFIFOIfc#(BusWord) outfifoCC <- mkSyncFIFOFromCC(2,externalClock);

  
  Reg#(PLBAddr)                             rowAddrOffsetLoad <- mkReg(0);
  Reg#(PLBAddr)                             rowAddrOffsetStore <- mkReg(0);  

  Reg#(PLBLength)                           lengthLoad  <- mkReg(0);
  Reg#(PLBLength)                           lengthStore <- mkReg(0);

  Reg#(Bool)                                doingLoad <- mkReg(False);
  Reg#(Bool)                                doingStore <- mkReg(False);

  Reg#(Bool)                                requestingStore <- mkReg(False);
  PLBAddr addressOffset                   = zeroExtend((requestingStore)?rowAddrOffsetStore:rowAddrOffsetLoad);
  

  Reg#(StateRequest)                        stateRequest <- mkReg(Idle);
  Reg#(StateTransfer)                       stateLoad <- mkReg(Idle); 
  Reg#(StateTransfer)                       stateStore <- mkReg(Idle); 
  Reg#(Bit#(1))                             request <- mkReg(0);
  Reg#(Bit#(1))                             rnw <- mkReg(0);


  Reg#(Bit#(TAdd#(1,TLog#(BeatsPerBurst))))              loadDataCount <- mkReg(0);
  Reg#(Bit#(TAdd#(1,TLog#(BeatsPerBurst))))              storeDataCount <-mkReg(0);// If you change this examine mWrDBus_o
  Reg#(Bit#(TAdd#(1,TLog#(BeatsPerBurst))))      loadDataCount_plus2 <- mkReg(2);
  Reg#(Bit#(TAdd#(1,TLog#(BeatsPerBurst))))      storeDataCount_plus2 <-mkReg(2);  
  
  Reg#(Bool)                                doAckinIdle <- mkReg(False);

  Reg#(Bit#(1))                             rdBurst <- mkReg(0);
  Reg#(Bit#(1))                             wrBurst <- mkReg(0);

  // Input wires  
  Wire#(Bit#(1)) mRst_i <- mkBypassWire();
  Wire#(Bit#(1)) mAddrAck_i <- mkBypassWire();	
  Wire#(Bit#(1)) mBusy_i <- mkBypassWire(); 	
  Wire#(Bit#(1)) mErr_i <- mkBypassWire();		
  Wire#(Bit#(1)) mRdBTerm_i <- mkBypassWire(); 	
  Wire#(Bit#(1)) mRdDAck_i <- mkBypassWire();
  Wire#(Bit#(64))mRdDBus_i <- mkBypassWire(); 
  Wire#(Bit#(4)) mRdWdAddr_i <- mkBypassWire(); 	
  Wire#(Bit#(1)) mRearbitrate_i <- mkBypassWire(); 
  Wire#(Bit#(1)) mWrBTerm_i <- mkBypassWire(); 	
  Wire#(Bit#(1)) mWrDAck_i <- mkBypassWire(); 	
  Wire#(Bit#(2)) mSSize_i <- mkBypassWire(); 	
  Wire#(Bit#(1)) sMErr_i <- mkBypassWire(); // on a read, during the data ack		
  Wire#(Bit#(1)) sMBusy_i <- mkBypassWire();


  // Debug Registers 
  Reg#(Bit#(32)) loadCommandCountReg <- mkReg(0);
  Reg#(Bit#(32)) storeCommandCountReg <- mkReg(0);
  Reg#(Bit#(32)) loadDataCountReg <- mkReg(0);
  Reg#(Bit#(32)) storeDataCountReg <- mkReg(0);

  ReadOnly#(Bit#(32)) loadCommandCountWire <- mkNullCrossingWire(externalClock,loadCommandCountReg._read);
  ReadOnly#(Bit#(32)) storeCommandCountWire <- mkNullCrossingWire(externalClock,storeCommandCountReg._read);
  ReadOnly#(Bit#(32)) loadDataCountWire <- mkNullCrossingWire(externalClock,loadDataCountReg._read);
  ReadOnly#(Bit#(32)) storeDataCountWire <- mkNullCrossingWire(externalClock,storeDataCountReg._read);

  //  Outputs


  PLBAddr mABus_o = addressOffset; // Our address Address Bus, we extend to compensate for word 

  
  Bit#(64)mWrDBus_o   = infifo.first();
  Bit#(1) mRequest_o  = request & ~mRst_i; // Request
  Bit#(1) mBusLock_o  = 1'b0 & ~mRst_i; // Bus lock
  Bit#(1) mRdBurst_o  = rdBurst & ~mRst_i; // read burst 
  Bit#(1) mWrBurst_o  = wrBurst & ~mRst_i; // write burst
  Bit#(1) mRNW_o      = rnw; // Read Not Write
  Bit#(1) mAbort_o    = 1'b0; // Abort
  Bit#(2) mPriority_o = 2'b11;// priority indicator
  Bit#(1) mCompress_o = 1'b0;// compressed transfer
  Bit#(1) mGuarded_o  = 1'b0;// guarded transfer
  Bit#(1) mOrdered_o  = 1'b0;// synchronize transfer
  Bit#(1) mLockErr_o  = 1'b0;// lock erro
  Bit#(4) mSize_o     = 4'b1011; // Burst double word transfer - see PLB p.24
  Bit#(3) mType_o     = 3'b000; // Memory Transfer
  Bit#(8) mBE_o       = 8'b00001111; // 16 word burst
  Bit#(2) mMSize_o    = 2'b00;


  // precompute the next address offset.  Sometimes
  
  
  BURST_REQUEST#(PLBAddr,PLBMaxBurst) cmd_in_first = plbMasterCommandInfifo.first();

  let newloadDataCount  =  loadDataCount + 1;
  let newstoreDataCount = storeDataCount + 1;
  let newloadDataCount_plus2  =  loadDataCount_plus2 + 1;
  let newstoreDataCount_plus2 = storeDataCount_plus2 + 1;

  let storeDataAvailable =  infifo.isGreaterThan(zeroExtend(lengthStore));
  let loadBufferAvailable = outfifo.isGreaterThan(fromInteger(valueof(OutputBufferSize)) - zeroExtend(lengthLoad));

  //Check for buffer space
 
  rule startPageLoad(cmd_in_first matches tagged ReadReq .command &&& !doingLoad);
    $display("Start Page");
    plbMasterCommandInfifo.deq();
    $display("Load Page");
    rowAddrOffsetLoad   <= truncate(command.addr()); // this is the log 
    lengthLoad <= command.size;        
    doingLoad <= True;
    loadCommandCountReg <= loadCommandCountReg + 1;
  endrule

  rule startPageStore(cmd_in_first matches tagged WriteReq .command &&& !doingStore);
    $display("Start Page");
    plbMasterCommandInfifo.deq();
    $display("Store Page");
    rowAddrOffsetStore <= truncate(command.addr); 
    lengthStore <= command.size;        
    doingStore <= True;	
    storeCommandCountReg <= storeCommandCountReg + 1;
  endrule


  rule loadPage_Idle(doingLoad && stateRequest == Idle && stateLoad == Idle && !loadBufferAvailable);
    // We should not initiate a transfer if the wordOutfifo is not valid
    requestingStore <= False;
    request <= 1'b1;
    stateRequest <= RequestingLoad;
    rnw <= 1'b1; // We're reading
  endrule

  // Store page idle is somehow running!!!
  rule storePage_Idle(doingStore && stateRequest == Idle && stateStore == Idle&& !storeDataAvailable);
    requestingStore <= True;
    request <= 1'b1;
    stateRequest <= RequestingStore;
    wrBurst <= 1'b1; // Write burst is asserted with the write request
    rnw <= 1'b0; // We're writing
  endrule

  rule continueIdling (stateRequest == Idle && stateStore == Idle && (!(doingStore && storeDataAvailable) && !(doingLoad && loadBufferAvailable))); // Gotta work out the complements of the stuff up above
    request <= 1'b0;
    requestingStore <= True;
    wrBurst <= 1'b1; // Write burst is asserted with the write request
    rnw <= 1'b0; // We're writing
  endrule

  
  rule loadPage_Requesting(doingLoad && stateRequest == RequestingLoad && stateLoad == Idle);
    // We've just requested the bus and are waiting for an ack
    //$display("loadPage_Requesting");
    //reset Counters
    loadDataCount <= 0;
    loadDataCount_plus2 <= 2;

    if(mAddrAck_i == 1 )
      begin
        stateRequest <= Idle;
	// Check for error conditions  
	if(mRearbitrate_i == 1) 
	  begin
	    // Got terminated by the bus
	    $display("Terminated by BUS @ %d",$time);
	    stateLoad <= Idle;
	    rdBurst <= 1'b0; // if we're rearbing this should be off. It may be off anyway? 
	    request <= 1'b0;
	  end 
        else
	  begin
	    //Whew! didn't die yet.. wait for acks to come back
	    stateLoad <= Data;
	    // Not permissible to assert burst until after addrAck p. 35
	    rdBurst <= 1'b1;
	    // Set down request, as we are not request pipelining
	    request <= 1'b0;
	  end
      end
  endrule    

  // Now we only want to go for loadLength beats
  rule loadPage_Data(doingLoad && stateLoad == Data);
    if(((mRdBTerm_i == 1) && (loadDataCount_plus2 < lengthLoad)) || (mErr_i == 1))
      begin
	// We got terminated / Errored 
	rdBurst <= 1'b0;
	loadDataCount <= 0;
 	loadDataCount_plus2 <= 2;   	
	stateLoad <= Idle;  
        outfifo.abort();           
      end
    else if(mRdDAck_i == 1)
      begin
	loadDataCount <= newloadDataCount;
        loadDataCount_plus2 <= newloadDataCount_plus2;
        outfifo.enq(mRdDBus_i);
	if(newloadDataCount == lengthLoad)
	  begin
	    //We're now done reading... what should we do?
            outfifo.commit();// This signifies that the data is valid
	    doingLoad <= False;
            stateLoad <= Idle;
            loadDataCountReg <= loadDataCountReg + zeroExtend(lengthStore);
	  end
	else if(newloadDataCount == lengthLoad - 1) 
	  begin
	    // Last read is upcoming.  Need to set down the 
	    // rdBurst signal.
	    rdBurst <= 1'b0;
	  end
      end
  endrule
  
  rule storePage_Requesting(doingStore && stateRequest == RequestingStore && stateStore == Idle);
    // We've just requested the bus and are waiting for an ack
    storeDataCount <= 0;
    storeDataCount_plus2 <= 2;

    if(mAddrAck_i == 1 )
      begin
        stateRequest <= Idle; 
	// Check for error conditions
	if(mRearbitrate_i == 1)
	  begin
	    // Got terminated by the bus
	    wrBurst <= 1'b0;
	    request <= 1'b0;
	  end
        else
	  begin
	    // Set down request, as we are not request pipelining
	    request <= 1'b0;
	    // We can be WrDAck'ed at this time p.29 or WrBTerm p.30 
	    if(mWrBTerm_i == 1)
	      begin  
		wrBurst <= 1'b0;
	      end
            else if(mWrDAck_i == 1)
	      begin
		stateStore <= Data;
	      end
            else
	      begin
		stateStore <= Data;
	      end                             
	  end
      end
  endrule


  rule storePage_Data(doingStore && stateStore == Data);
    if(((mWrBTerm_i == 1) && (storeDataCount_plus2 < lengthStore)) || (mErr_i == 1))
      begin
	// We got terminated / Errored 
	wrBurst <= 1'b0;
	storeDataCount <= 0;
        storeDataCount_plus2 <= 2;
	stateStore <= Idle; // Can't burst for a cycle p. 30             
        infifo.rewind();
      end
    else if(mWrDAck_i == 1)
      begin
	storeDataCount <= newstoreDataCount;                   
	storeDataCount_plus2 <= newstoreDataCount_plus2;
        infifo.deq();
	if(newstoreDataCount == lengthStore)
	  begin
	    //We're now done reading... what should we do?
	    // Data transfer complete
            if(mBusy_i == 0) 
              begin
                infifo.commit();
                doingStore <= False;
                stateStore <= Idle;                
                storeDataCountReg <= storeDataCountReg + zeroExtend(lengthStore);
              end
            else
              begin
                stateStore <= WaitForBusy;
              end
	  end
	else if(newstoreDataCount == lengthStore - 1) //YYY: used to be ~0
	  begin
	    // Last read is upcoming.  Need to set down the 
	    // wrBurst signal.
	    wrBurst <= 1'b0;
	  end
      end
  endrule

  rule storePage_WaitForBusy(doingStore && stateStore == WaitForBusy);
    if(mErr_i == 1)
      begin
	// We got terminated / Errored 
	wrBurst <= 1'b0;
	storeDataCount <= 0; // may not be necessary
        storeDataCount_plus2 <= 2; 
	stateStore <= Idle; // Can't burst for a cycle p. 30     
        infifo.rewind();        
      end    
    else if(mBusy_i == 0)
      begin
        infifo.commit();
        doingStore <= False;
        stateStore <= Idle;
      end
  endrule

  rule connectInfifo;
    infifoCC.deq;
    infifo.enq(infifoCC.first);
  endrule

  rule connectOutfifo;
    outfifo.deq;
    outfifoCC.enq(outfifo.first);
  endrule


  interface BURST_MEMORY_IFC burstIfc;
    method ActionValue#(BusWord) readRsp();
      outfifoCC.deq();
      return outfifoCC.first();
    endmethod

    // Look at the read response value without popping it
    method BusWord peek();
      return outfifoCC.first();
    endmethod

    // Read response ready
    method Bool notEmpty();
      return outfifoCC.notEmpty();
    endmethod

    // Read request possible?
    method Bool notFull();
      return outfifoCC.notFull;
    endmethod

    // We must split the write request and response...
    method Action writeData(BusWord data); 
      infifoCC.enq(data);
    endmethod
  
    method Action burstReq(BURST_REQUEST#(PLBAddr, PLBMaxBurst) burstReqIn);
      plbMasterCommandInfifo.enq(burstReqIn);
    endmethod    

    // Write request possible?
    method Bool writeNotFull();
      return infifoCC.notFull();
    endmethod
  endinterface


  interface PLBMasterWires  plbMasterWires;
 
    method Bit#(PLBAddrSize) mABus();     // Address Bus
      return mABus_o;   
    endmethod
    method Bit#(8)           mBE();       // Byte Enable
      return mBE_o;    
    endmethod
	
    method Bit#(1)           mRNW();      // Read Not Write
      return mRNW_o;    
    endmethod

    method Bit#(1)           mAbort();    // Abort
      return mAbort_o;    
    endmethod

    method Bit#(1)           mBusLock();  // Bus lock
      return mBusLock_o;    
    endmethod

    method Bit#(1)           mCompress(); // compressed transfer
      return mCompress_o;    
    endmethod

    method Bit#(1)           mGuarded();  // guarded transfer
      return mGuarded_o;    
    endmethod

    method Bit#(1)           mLockErr();  // lock error
      return mLockErr_o;    
    endmethod

    method Bit#(2)           mMSize();    // data bus width?
      return mMSize_o;    
    endmethod

    method Bit#(1)           mOrdered();  // synchronize transfer
      return mOrdered_o;    
    endmethod

    method Bit#(2)           mPriority(); // priority indicator
      return mPriority_o;    
    endmethod

    method Bit#(1)           mRdBurst();  // read burst
      return mRdBurst_o;    
    endmethod

    method Bit#(1)           mRequest();  // bus request
      return mRequest_o;    
    endmethod
	
    method Bit#(4)           mSize();     // transfer size 
      return mSize_o;    
    endmethod

    method Bit#(3)           mType();     // transfer type (dma) 
      return mType_o;    
    endmethod

    method Bit#(1)           mWrBurst();  // write burst
      return mWrBurst_o;    
    endmethod
	
    method Bit#(64)          mWrDBus();   // write data bus
      return mWrDBus_o;    
    endmethod


    method Action mRst(Bit#(1) mRst_in);
      mRst_i <= mRst_in;       
    endmethod

    method Action mAddrAck(Bit#(1) mAddrAck_in);
      mAddrAck_i <= mAddrAck_in;	
    endmethod

    method Action mBusy(Bit#(1) mBusy_in);
      mBusy_i <= mBusy_in;		
    endmethod

    method Action mErr(Bit#(1) mErr_in);
     mErr_i <= mErr_in;		
    endmethod

    method Action mRdBTerm(Bit#(1) mRdBTerm_in);
     mRdBTerm_i <= mRdBTerm_in;	
    endmethod

    method Action mRdDAck(Bit#(1) mRdDAck_in);
      mRdDAck_i <= mRdDAck_in;	
    endmethod

    method Action mRdDBus(Bit#(64) mRdDBus_in);
      mRdDBus_i <= mRdDBus_in;	
    endmethod

    method Action mRdWdAddr(Bit#(4) mRdWdAddr_in);
      mRdWdAddr_i <= mRdWdAddr_in;	
    endmethod

    method Action mRearbitrate(Bit#(1) mRearbitrate_in);
      mRearbitrate_i <= mRearbitrate_in;
    endmethod

    method Action mWrBTerm(Bit#(1) mWrBTerm_in);
      mWrBTerm_i <= mWrBTerm_in;	
    endmethod

    method Action mWrDAck(Bit#(1) mWrDAck_in);
      mWrDAck_i <= mWrDAck_in;	
    endmethod

    method Action mSSize(Bit#(2) mSSize_in);
      mSSize_i <= mSSize_in; 	
    endmethod

    method Action sMErr(Bit#(1) sMErr_in);
      sMErr_i <= sMErr_in;		
    endmethod

    method Action sMBusy(Bit#(1) sMBusy_in);
      sMBusy_i <= sMBusy_in;	    
    endmethod

  endinterface

 interface loadCommandTotal = loadCommandCountWire;
 interface storeCommandTotal = storeCommandCountWire;
 interface loadDataTotal = loadDataCountWire;
 interface storeDataTotal = storeDataCountWire;
endmodule
