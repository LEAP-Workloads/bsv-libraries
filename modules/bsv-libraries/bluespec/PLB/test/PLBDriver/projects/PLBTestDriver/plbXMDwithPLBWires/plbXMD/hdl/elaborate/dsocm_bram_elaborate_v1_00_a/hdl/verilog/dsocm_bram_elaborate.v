//-----------------------------------------------------------------------------
// dsocm_bram_elaborate.v
//-----------------------------------------------------------------------------

module dsocm_bram_elaborate
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
    C_PORT_DWIDTH = 32,
    C_PORT_AWIDTH = 32,
    C_NUM_WE = 4,
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

  wire [31:0] dina;
  wire [31:0] dinb;
  wire [31:0] douta;
  wire [31:0] doutb;

  // Internal assignments

  assign dina[31:0] = BRAM_Dout_A[0:31];
  assign BRAM_Din_A[0:31] = douta[31:0];
  assign dinb[31:0] = BRAM_Dout_B[0:31];
  assign BRAM_Din_B[0:31] = doutb[31:0];

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_0 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[31:28] ),
      .DOA ( douta[31:28] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[0] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[31:28] ),
      .DOB ( doutb[31:28] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[0] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_1 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[27:24] ),
      .DOA ( douta[27:24] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[0] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[27:24] ),
      .DOB ( doutb[27:24] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[0] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_2 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[23:20] ),
      .DOA ( douta[23:20] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[1] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[23:20] ),
      .DOB ( doutb[23:20] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[1] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_3 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[19:16] ),
      .DOA ( douta[19:16] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[1] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[19:16] ),
      .DOB ( doutb[19:16] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[1] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_4 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[15:12] ),
      .DOA ( douta[15:12] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[2] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[15:12] ),
      .DOB ( doutb[15:12] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[2] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_5 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[11:8] ),
      .DOA ( douta[11:8] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[2] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[11:8] ),
      .DOB ( doutb[11:8] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[2] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_6 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[7:4] ),
      .DOA ( douta[7:4] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[3] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[7:4] ),
      .DOB ( doutb[7:4] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[3] )
    );

  RAMB16_S4_S4
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" )
    )
    ramb16_s4_s4_7 (
      .ADDRA ( BRAM_Addr_A[18:29] ),
      .CLKA ( BRAM_Clk_A ),
      .DIA ( dina[3:0] ),
      .DOA ( douta[3:0] ),
      .ENA ( BRAM_EN_A ),
      .SSRA ( BRAM_Rst_A ),
      .WEA ( BRAM_WEN_A[3] ),
      .ADDRB ( BRAM_Addr_B[18:29] ),
      .CLKB ( BRAM_Clk_B ),
      .DIB ( dinb[3:0] ),
      .DOB ( doutb[3:0] ),
      .ENB ( BRAM_EN_B ),
      .SSRB ( BRAM_Rst_B ),
      .WEB ( BRAM_WEN_B[3] )
    );

endmodule

// synthesis attribute keep_hierarchy of dsocm_bram_elaborate is yes;

