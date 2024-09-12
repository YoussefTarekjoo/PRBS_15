`timescale 1ns/1ps

module PRBS_tb();

reg clk , rst ;
reg [31:0] seq ;
reg [7:0] n ;
wire [7:0] out ;
reg [15:0] SHIFT_REG ;

PRBS PRBS_DUT(
 .clk(clk) ,
 .rst(rst) ,
 .seq(seq) ,
 .n(n)     ,
 .out(out)
 );

always #1 clk = ~clk ;

initial 
 begin
  clk = 0 ;
  rst = 1 ;
  #2
  rst = 0 ;
  seq = 32'hABCDEF23 ;
  n = 5 ;
  #42
  seq = 32'hABCDEF23 ;
  $stop;
 end

endmodule