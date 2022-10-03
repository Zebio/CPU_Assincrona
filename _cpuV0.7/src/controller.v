module controller#(parameter DELAY=0)
					  (input rst_n,
						input [7:0]instr_in,
						output[5:0]cache_instr,
						input cache_ack,
						output ack);
			

wire [5:0] w_cache_instr;			
			
controllerNCL 
CONTROLLER	(.I7_t(instr_in[7]),
				 .I7_f(instr_in[6]), 
				 .I6_t(instr_in[5]),
				 .I6_f(instr_in[4]),
				 .I5_t(instr_in[3]),
				 .I5_f(instr_in[2]), 
				 .I4_t(instr_in[1]), 
				 .I4_f(instr_in[0]), 
				 .C1A1_t(w_cache_instr[5]),
				 .C1A1_f(w_cache_instr[4]), 
				 .C1A0_t(w_cache_instr[3]), 
				 .C1A0_f(w_cache_instr[2]),
				 .C1O_t(w_cache_instr[1]), 
				 .C1O_f(w_cache_instr[0]));

				 
wire det;				 
det_3input
DETECTOR(.in(w_cache_instr),
			.det(det));
			
wire hab;
assign ack=hab;

muller_2input #(DELAY)
CONTROL_LOGIC		(.rst_n(rst_n),
						 .a(det),
						 .b(~cache_ack),
                   .s(hab));
						 
						 
reg_assync_3bits 
REGISTER			(.hab(hab),
					 .in(w_cache_instr),
					 .out(cache_instr));			

						
endmodule 