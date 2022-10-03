module est_ass_buffer_5ack_set
					#(parameter DELAY=0)(input rst_n,
										  input [1:0] data_in,
										  output[1:0] data_out,
										  input ack1,ack2,ack3,ack4,
										  output ack);
										  
										  
wire det;
or (det, data_in[1], data_in[0]);

wire hab;
assign ack=hab;
muller_5input_set #(DELAY) control_logic(.set_n(rst_n),
										  .a(det),
										  .b(~ack1),
										  .c(~ack2),
										  .d(~ack3),
										  .e(~ack4),
										  .s(hab));
										  

wire w_in_t;
or(w_in_t,~rst_n,data_in[1]);

wire w_in_f;
and(w_in_f,rst_n,data_in[0]);

															  

reg_assync register(.hab(hab),
						  .in_t(w_in_t),
						  .in_f(w_in_f),
						  .out_t(data_out[1]),
						  .out_f(data_out[0]));
						  


						
endmodule 
					