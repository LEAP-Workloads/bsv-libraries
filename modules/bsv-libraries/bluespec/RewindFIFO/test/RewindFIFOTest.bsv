`include "asim/provides/commit_fifo.bsh"
`include "asim/provides/rewind_fifo.bsh"

import FIFO::*;
import StmtFSM::*;
import LFSR::*;

typedef 1024 MaxEntries;

//Use the commit fifo to replicate the magic stream !

module mkHWOnlyApplication(Empty);

  Reg#(Bit#(16)) counter <- mkReg(0);
  Reg#(Bit#(8)) outputCount <- mkReg(0);

  Reg#(Bool) shouldRewind <- mkReg(False); 
  LFSR#(Bit#(8)) lfsr <- mkLFSR_8();
  Reg#(Bit#(8)) rewindCounter <- mkReg(25);

  RewindFIFOLevel#(Bit#(16),MaxEntries) rewindFIFO <- mkRewindFIFOLevel();
  CommitFIFO#(Bit#(16),MaxEntries) commitFIFO <- mkCommitFIFO();
  FIFO#(Bit#(16)) expectedFIFO <- mkSizedFIFO(valueof(MaxEntries));
  
  rule enqValues;
    rewindFIFO.enq(counter);
    expectedFIFO.enq(counter);
    counter <= counter + 1;
  endrule

  rule driveTest (rewindCounter - 1 == 0);   
    rewindCounter <= lfsr.value;
    shouldRewind <= !shouldRewind;
    lfsr.next;
    if(shouldRewind)
      begin 
        $display("Aborting");
        rewindFIFO.rewind;
        commitFIFO.abort;
      end
    else 
      begin
        $display("Committing");
        rewindFIFO.commit;
        commitFIFO.commit;
      end
    rewindFIFO.deq;
    commitFIFO.enq(rewindFIFO.first);
  endrule

  rule connectFIFO(rewindCounter-1 != 0);
    rewindCounter <= rewindCounter - 1;
    rewindFIFO.deq;
    commitFIFO.enq(rewindFIFO.first);
    $display("Sending %h", rewindFIFO.first);
  endrule

  rule checkResults;
   expectedFIFO.deq;
   commitFIFO.deq;
  
   if(expectedFIFO.first != commitFIFO.first)
     begin
       $display("Error: Expected %h, Commit %h", expectedFIFO.first, commitFIFO.first);
       $finish;
     end
   outputCount <= outputCount + 1;
   if(outputCount + 1 == 0) 
     begin
       $display("Pass");
       $finish;
     end
  endrule


endmodule