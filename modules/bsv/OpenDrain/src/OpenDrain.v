module OpenDrain(ENABLE, DOUT);
  input ENABLE;
  inout DOUT;
 
  always @(ENABLE)
    begin
      if (ENABLE)
        begin
          DOUT = 1'bZ;
        end
      else
        begin
          DOUT = 1'b0;
        end
    end

endmodule