module Patter_Detector 
(
 input wire clk , rst ,
 input wire [7:0] out_PRBS ,
 input wire [7:0] n_detec ,
 output reg Pattern_Flag 
);

parameter 		    IDLE	           = 3'b000       ;
parameter 		    BYTE_1	           = 3'b001       ;
parameter 		    BYTE_2	           = 3'b010       ;
parameter 		    BYTE_3             = 3'b011       ;
parameter 		    BYTE_4             = 3'b100       ;
parameter 		    DONE               = 3'b101       ; 

parameter 		    seq                = 32'hABCDEF23 ;

reg ERROR_SEQ , ERROR_SEQ_REG ;
reg [7:0] count ;
reg [2:0] current_state , next_state ;

always @(posedge clk or posedge rst) begin
 if(rst) begin
  current_state <= IDLE ;
  count <= 0 ;
  ERROR_SEQ_REG <= 0 ;
	end
 else begin
  current_state <= next_state ;
  ERROR_SEQ <= ERROR_SEQ_REG  ;
	end
end

always @(*) begin
	case (current_state)
		IDLE: begin
		 Pattern_Flag = 0 ;
		 next_state = BYTE_1 ; 
		end
			
		BYTE_1: begin
		 if(out_PRBS == seq[31:24])
		  begin
		   ERROR_SEQ_REG = 0 ;
		   next_state = BYTE_2 ; 
		  end
		 else
		  begin
		   ERROR_SEQ_REG = 1 ;
		   next_state = DONE ; 
		  end
		end
			
		BYTE_2: begin
		 if(out_PRBS == seq[23:16])
		  begin
		   ERROR_SEQ_REG = 0 ;
		   next_state = BYTE_3 ; 
		  end
		 else
		  begin
		   ERROR_SEQ_REG = 1 ;
		   next_state = DONE ; 
		  end
		 
		end
			
		BYTE_3: begin
		 if(out_PRBS == seq[15:8])
		  begin
		   ERROR_SEQ_REG = 0 ;
		   next_state = BYTE_4 ; 
		  end
		 else
		  begin
		   ERROR_SEQ_REG = 1 ;
		   next_state = DONE ; 
		  end
		 
		end
		
		BYTE_4: begin
		 if(n_detec == 1)
		  begin
		  if(out_PRBS == seq[7:0])
		   begin
		    ERROR_SEQ_REG = 0 ;
		    next_state = DONE ; 
		   end
		  else
		   begin
		    ERROR_SEQ_REG = 1 ;
		    next_state = DONE ; 
		   end
		  end
		 else if(count != n_detec-1)
		  begin
		   count = count + 1 ;
		   ERROR_SEQ_REG = 0 ;
		   next_state = BYTE_1 ;
		  end
		 else
		  begin
		   ERROR_SEQ_REG = 0 ;
		   next_state = DONE ; 
		  end
		end
		
		DONE  : begin
		 if(ERROR_SEQ_REG)
		  Pattern_Flag = 0 ;
		 else
		  Pattern_Flag = 1 ;
		end
			
		default: next_state = IDLE;
		
	endcase
end


endmodule