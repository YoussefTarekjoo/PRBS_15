`timescale 1ns/1ps

module TOP_tb ();

reg clk , rst ;
wire Pattern_Flag  ;
reg [7:0] N ;
wire [7:0] OUT ;
reg [7:0] seq ;

TOP_PRBS TOP_PRBS_DUT
(
 .clk(clk) ,
 .rst(rst) ,
 .N(N) ,
 .seq(seq) ,
 .OUT(OUT) ,
 .Pattern_Flag(Pattern_Flag)
);

integer i ;

always #1 clk = ~clk ;	

initial 
 begin
  clk = 1 ;
  rst = 1 ;
  N = 5 ;
  #2
  rst = 0 ;
  for(i = 0 ; i<N+2 ; i = i+1)
   begin
    seq = 8'hAB ;
    #2
    seq = 8'hCD ;
    #2
    seq = 8'hEF ;
    #2
    seq = 8'h23 ;
	#2
	seq = 0 ;
   end
   
  if(Pattern_Flag == 1)
   $display("the pattern is repeated %0d times success", N) ;
  
  rst = 1 ;
  N = 3 ;
  #2
  rst = 0 ;
  for(i = 0 ; i<N+2 ; i = i+1)
   begin
    seq = 8'hAB ;
    #2
    seq = 8'hBD ;
    #2
    seq = 8'hEF ;
    #2
    seq = 8'h23 ;
	#2
	seq = 0 ;
   end
   
  if(Pattern_Flag == 0)
   $display("the pattern is repeated %0d times fail", N) ;
  
  $stop;
 end

endmodule