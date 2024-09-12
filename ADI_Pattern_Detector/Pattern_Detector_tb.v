`timescale 1ns/1ps

module Pattern_Detector_tb ();

reg clk , rst ;
wire Pattern_Flag  ;
reg [7:0] n_detec ;
reg [7:0] out_PRBS ;

Patter_Detector Patter_Detector_DUT
(
 .clk(clk) , 
 .rst(rst) ,
 .out_PRBS(out_PRBS) ,
 .n_detec(n_detec) ,
 .Pattern_Flag(Pattern_Flag)
);

always #1 clk = ~clk ;

initial 
 begin
  clk = 0 ;
  rst = 1 ;
  n_detec = 2 ;
  #2
  rst = 0 ;
  #2
  out_PRBS = 8'hAB ;
  #2
  out_PRBS = 8'hCD ;
  #2
  out_PRBS = 8'hEF ;
  #2
  out_PRBS = 8'h23 ;
  #2
  out_PRBS = 8'hAB ;
  #2
  out_PRBS = 8'hCD ;
  #2
  out_PRBS = 8'hEF ;
  #2
  out_PRBS = 8'h23 ;
  #2
  if(Pattern_Flag == 1)
   $display("correct");
  $stop;
 end

endmodule