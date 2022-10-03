module instr_reg #(parameter DELAY=0)
					 (input rst_n,
					  input [15:0]data_in,
					  output[15:0]data_out,
					  input ack1,ack2,ack3,
					  output ack);
			

wire det;
or(det,data_in[15],data_in[14]);

wire hab;
assign ack=hab;

muller_4input #(DELAY)
CONTROL_LOGIC( .rst_n(rst_n),
					.a(det),
					.b(~ack1),
					.c(~ack2),
					.d(~ack3),
					.s(hab));
			
reg_assync_8bits 
REGISTER				(.hab(hab),
						 .in(data_in),
						 .out(data_out));
			
					  
endmodule 