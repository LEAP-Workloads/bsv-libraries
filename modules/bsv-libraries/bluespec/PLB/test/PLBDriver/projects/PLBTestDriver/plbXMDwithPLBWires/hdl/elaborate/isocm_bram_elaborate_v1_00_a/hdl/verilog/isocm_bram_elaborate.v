//-----------------------------------------------------------------------------
// isocm_bram_elaborate.v
//-----------------------------------------------------------------------------

module isocm_bram_elaborate
  (
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    BRAM_Rst_B,
    BRAM_Clk_B,
    BRAM_EN_B,
    BRAM_WEN_B,
    BRAM_Addr_B,
    BRAM_Din_B,
    BRAM_Dout_B
  );
  parameter
    C_MEMSIZE = 'h4000,
    C_PORT_DWIDTH = 64,
    C_PORT_AWIDTH = 32,
    C_NUM_WE = 2,
    C_FAMILY = "virtex2p";
  input BRAM_Rst_A;
  input BRAM_Clk_A;
  input BRAM_EN_A;
  input [0:C_NUM_WE-1] BRAM_WEN_A;
  input [0:C_PORT_AWIDTH-1] BRAM_Addr_A;
  output [0:C_PORT_DWIDTH-1] BRAM_Din_A;
  input [0:C_PORT_DWIDTH-1] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:C_NUM_WE-1] BRAM_WEN_B;
  input [0:C_PORT_AWIDTH-1] BRAM_Addr_B;
  output [0:C_PORT_DWIDTH-1] BRAM_Din_B;
  input [0:C_PORT_DWIDTH-1] BRAM_Dout_B;

  // Internal signals

  wire [63:0] dina;
  wire [63:0] dinb;
  wire [63:0] douta;
  wire [63:0] doutb;
  wire [0:0] net_gnd1;

  // Internal assignments

  assign dina[63:0] = BRAM_Dout_A[0:63];
  assign BRAM_Din_A[0:63] = douta[63:0];
  assign dinb[63:0] = BRAM_Dout_B[0:63];
  assign BRAM_Din_B[0:63] = doutb[63:0];
  assign net_gnd1[0:0] = 1'b0;

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_0 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[63:56] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[63:56] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[0] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[63:56] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[63:56] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[0] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_1 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[55:48] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[55:48] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[0] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[55:48] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[55:48] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[0] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_2 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[47:40] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[47:40] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[0] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[47:40] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[47:40] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[0] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_3 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[39:32] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[39:32] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[0] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[39:32] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[39:32] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[0] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_4 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[31:24] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[31:24] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[1] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[31:24] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[31:24] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[1] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_5 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[23:16] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[23:16] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[1] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[23:16] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[23:16] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[1] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_6 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[15:8] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[15:8] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[1] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[15:8] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[15:8] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[1] )
    );

  RAMB16_S9_S9
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s9_s9_7 (
      .ADDRA ( BRAM_Addr_A[18:28] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[7:0] ),
      .DIPA ( net_gnd1[0:0] ),
      .DOA ( douta[7:0] ),
      .DOPA (  ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[1] ),
      .ADDRB ( BRAM_Addr_B[18:28] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[7:0] ),
      .DIPB ( net_gnd1[0:0] ),
      .DOB ( doutb[7:0] ),
      .DOPB (  ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[1] )
    );

endmodule

// synthesis attribute keep_hierarchy of isocm_bram_elaborate is yes;

