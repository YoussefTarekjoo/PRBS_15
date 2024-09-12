module PRBS (
 input wire clk ,
 input wire rst ,
 input wire [31:0] seq ,
 input wire [7:0] n ,
 output reg [7:0] out 
 );
 
reg [1:0] count ;
reg [7:0] count_n ;
reg [14:0] SHIFT_REG ;

always @(posedge clk or posedge rst)
 begin
  if(rst)
   begin
    out <= 0 ;
	count <= 0 ;
	count_n <= 0 ;
	SHIFT_REG <= 15'h7ABC ;
   end
  else
   begin
    SHIFT_REG <= seq[15:0] ;
    if(count_n <= n-1)
	 begin
      out <= seq[31 - (count*8) -: 8] ;
	  if(count == 3)
	   begin
	   count <= 0 ;
	   count_n <= count_n +1 ;
	   end
	   count <= count + 1 ;
	 end
	else 
	 begin
	  SHIFT_REG <= {SHIFT_REG[13:0],SHIFT_REG[14]^SHIFT_REG[13]} ;
	  out <= {SHIFT_REG[11:5],SHIFT_REG[0]} ;
	 end
   end
 end 

endmodule