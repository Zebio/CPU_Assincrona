module est_ass_buffer_5ack_set (input rst_n,
										  input [1:0] data_in,
										  output[1:0] data_out,
										  input ack1,ack2,ack3,ack4,
										  output ack);
										  
										  
wire det;
or (det, data_in[1], data_in[0]);

wire hab;
assign ack=hab;
muller_5input_set control_logic(.set_n(rst_n),
										  .a(det),
										  .b(~ack1),
										  .c(~ack2),
										  .d(~ack3),
										  .e(~ack4),
										  .s(hab));
										  

wire w_data_out_t;
wire w_data_out_f;
															  

reg_assync register(.hab(hab),
						  .in_t(data_in[1]),
						  .in_f(data_in[0]),
						  .out_t(w_data_out_t),
						  .out_f(w_data_out_f));
						  

and (data_out[1],rst_n,w_data_out_t);
and (data_out[0],rst_n,w_data_out_f);


						
endmodule 
					