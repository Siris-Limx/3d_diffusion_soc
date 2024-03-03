// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module xlnx_bram_128x64(clka, ena, wea, addra, dina, douta);
  input clka;
  input ena;
  input [7:0]wea;
  input [6:0]addra;
  input [63:0]dina;
  output [63:0]douta;
endmodule
