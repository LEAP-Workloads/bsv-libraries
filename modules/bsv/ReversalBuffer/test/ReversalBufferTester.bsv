import RegFile::*;
import GetPut::*;
import FIFO::*;
import FIFOF::*;

import ReversalBuffer::*;
import FIFOUtility::*;

module mkReversalBufferTester();
  ReversalBuffer#(Bit#(15), Bool, 64) buffer <- mkReversalBuffer("testbench");
  Reg#(Bit#(15)) counter <- mkReg(0);
  Reg#(Bit#(15)) rev_count <- mkReg(0); 
  Reg#(Bit#(8)) iter_count <- mkReg(0); 
  RegFile#(Bit#(16),Bit#(16)) rfile <- mkRegFileFull();  

  Bit#(15) reverse_unit = 64;
  Bit#(15) packet_length[16] = {31,128,0,64,257,1024,1,65,0,729,0,0,0,31,31,0};
  Bit#(3)  packet_index = truncate(iter_count); 
  Bit#(15) packet_remainder = packet_length[packet_index] - packet_length[packet_index]%64; 

  rule push_data(counter <= packet_length[packet_index]);
    counter <= counter + 1;
    if(counter == packet_length[packet_index])
      begin
        buffer.inputData.put(tuple2(True,counter));
      end
    else
      begin
        buffer.inputData.put(tuple2(False,counter));
      end

    $display("Testbench iter %d pushes %d,%h",iter_count, packet_length[packet_index],counter);
  endrule

  rule read_data(rev_count <= packet_length[packet_index]);
    $display("Testbench: rev_count: %d", rev_count);
    match {.ctrl, .outdata} <- buffer.outputData.get();
    Bit#(6)  rev_bits = (rev_count >= packet_remainder) ?
                                  truncate(packet_length[packet_index] - reverse_unit - zeroExtend(rev_count[5:0]) - 1) :
                                  truncate(reverse_unit - zeroExtend(rev_count[5:0]) - 1);
    
    if(rev_count == packet_length[packet_index])
      begin
        $display("Testbench eats end of packet value");
        if(!ctrl)
          begin
            $display("Control not correct at end of packet");
            $finish;
          end
        iter_count <= iter_count + 1;
        counter <= 0;
        rev_count <= 0;
        $display("Finished iteration %d", iter_count);
        if(iter_count+1==0)
          begin
            $display("PASS");
            $finish;
          end
      end            
    else if(outdata != {rev_count[14:6], rev_bits})
      begin
        $display("Got: %d, Expected: %d Rev: %d iter:%d rev_count: %d, packet_remainder: %d\n", outdata, {rev_count[14:6], rev_bits}, rev_bits, iter_count, rev_count, packet_remainder);
        $display("FAIL");
        $finish;
      end 
    else
      begin
        rev_count <= rev_count + 1;
      end
  endrule

endmodule

