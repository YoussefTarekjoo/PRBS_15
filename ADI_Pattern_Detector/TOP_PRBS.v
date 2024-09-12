module TOP_PRBS
(
 input wire clk , rst ,
 input wire [7:0] N ,
 input wire [7:0] seq ,
 output wire [7:0] OUT ,
 output wire Pattern_Flag
);

wire done;
wire [31:0] Data_Parrallel ;

Patter_Detector Patter_Detector_1
(
 .clk(clk) ,
 .rst(done) ,
 .out_PRBS(OUT) ,
 .n_detec(N) ,
 .Pattern_Flag(Pattern_Flag) 
);

Serial_Parrallel Serial_Parrallel_1(
 .clk(clk) ,
 .rst(rst) ,
 .Data_Serial(seq) ,
 .Data_Parrallel(Data_Parrallel),
 .done(done)
);

PRBS PRBS_1
(
 .clk(clk) ,
 .rst(done) ,
 .seq(Data_Parrallel) ,
 .n(N) ,
 .out(OUT) 
);
 
endmodule