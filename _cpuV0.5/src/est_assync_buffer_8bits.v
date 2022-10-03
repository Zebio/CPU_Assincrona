module est_assync_buffer_8bits (input rst_n,
										  input [15:0] data_in,
										  output[15:0] data_out,
										  input ack_next,
										  output ack);
			

wire det;
or(det, data_in[15], data_in[14]);

wire hab;
assign ack=hab;

muller_2input control_logic(.rst_n(rst_n),
									 .a(det),
									 .b(~ack_next),
									 .s(hab));


reg_assync_8bits register(.hab(hab),
								  .in(data_in),
								  .out(data_out));
								  									 
										  
endmodule 