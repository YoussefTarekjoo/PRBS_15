module Serial_Parrallel(
    input       clk,
    input       rst,
    input   [7:0]  Data_Serial,
    output reg [31:0]  Data_Parrallel,
	output reg done
);

reg [1:0] count;

always @(posedge clk or posedge rst) begin
    if(rst)
	begin
     Data_Parrallel <= 0;
     count <= 0;
	 done <= 1;
    end
    else
    begin
	if(done) begin
            case (count)
                0 : 
				 begin
				  Data_Parrallel[31:24] <= Data_Serial;
				 end
                1 : 
				 begin
				  Data_Parrallel[23:16] <= Data_Serial;
				 end
                2 : 
				 begin
				Data_Parrallel[15:8] <= Data_Serial;
				 end
                3 : 
				 begin
				  Data_Parrallel[7:0] <= Data_Serial;
				 end
                default : Data_Parrallel <= 0;
            endcase
			if(count == 3)
			done <= 0;
            count <= count +1;
		end
    end
end
    
endmodule