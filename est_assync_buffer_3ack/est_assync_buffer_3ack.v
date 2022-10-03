module est_assync_buffer_3ack(input rst_n,
										input [1:0]data_in,
										output[1:0]data_out,
										input ackIn1,
										input ackIn2,
										output ack);
										
										
										
wire det;
or(det, data_in[1],data_in[0]);

wire hab;
assign ack=hab;
muller_3input control_logic(.rst_n(rst_n),
									 .a(det),
									 .b(~ackIn1),
									 .c(~ackIn2),
									 .s(hab));
										
										
reg_assync register(.hab(hab),
						  .in_t(data_in[1]),
						  .in_f(data_in[0]),
						  .out_t(data_out[1]),
						  .out_f(data_out[0]));

endmodule 