module est_assync_buffer #(parameter DELAY =0) (input rst_n,
								  input [1:0] data_in,
								  output[1:0] data_out,
								  input ack_next,
								  output ack_ant
									);
									
									
									
wire det;
or (det, data_in[0], data_in[1]);


wire hab;
assign ack_ant=hab;

muller_2input #(DELAY) control_logic(.rst_n(rst_n),
									 .a(det),
									 .b(~ack_next),
									 .s(hab));
									 
reg_assync register(.hab(hab),
					.in_t(data_in[1]),
					.in_f(data_in[0]),
					.out_t(data_out[1]),
					.out_f(data_out[0]));

					
endmodule 