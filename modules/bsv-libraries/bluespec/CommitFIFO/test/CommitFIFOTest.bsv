import FIFO::*;
import StmtFSM::*;
import LFSR::*;

import CommitFIFO::*;

typedef 1024 MaxEntries;

module mkHWOnlyApplication(Empty);

  LFSR#(Bit#(16)) lfsr <- mkLFSR_16();
  FIFO#(Bit#(16)) expected <- mkSizedFIFO(valueof(MaxEntries));
  CommitFIFO#(Bit#(16),MaxEntries) commitFIFO <- mkCommitFIFO;
  Reg#(Bit#(TAdd#(1,TLog#(MaxEntries)))) commitSize    <- mkReg(0); 
  Reg#(Bit#(TAdd#(1,TLog#(MaxEntries)))) commitCounter <- mkReg(0); 
  Reg#(Bit#(18)) rxCount <- mkReg(0); 
  Reg#(Bool) initialized <- mkReg(False);
  
  Stmt sender = seq
                  while(True)
                  action
                    commitFIFO.enq(lfsr.value);
                    lfsr.next;
                    if(commitSize[0] == 0)
                      action
                        expected.enq(lfsr.value);
                      endaction      
                    if(commitCounter + 1 >= commitSize)  
                      action
                        commitCounter <= 0;
                        commitSize <= commitSize + 1;
                        if(commitSize[0] == 0)
                          action
                            commitFIFO.commit;
                          endaction
                        else 
                          action
                            commitFIFO.abort;
                          endaction
                      endaction
                    else 
                      action 
                        commitCounter <= commitCounter + 1;
                      endaction
                  endaction
                endseq;

  rule init(!initialized);
    initialized <= True;
    lfsr.seed(1);
  endrule

  rule checkOutput;
    rxCount <= rxCount + 1; 
    expected.deq;
    commitFIFO.deq;
    if(expected.first != commitFIFO.first)
      begin 
        $display("ERROR: expected: %h got: %h", expected.first, commitFIFO.first);
        $finish;
      end
    else 
      begin
        $display("expected: %h got: %h", expected.first, commitFIFO.first);
      end
    if(rxCount + 1 == 0)
      begin
        $display("PASS");
        $finish;
      end
  endrule


  FSM fsmSender  <- mkFSM(sender);

  rule makePackets(initialized && fsmSender.done);
    fsmSender.start;
  endrule

endmodule