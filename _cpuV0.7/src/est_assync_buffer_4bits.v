module est_assync_buffer_4bits 
		 #(parameter DELAY=0)
									    (input rst_n,
										  input [7:0] data_in,
										  output[7:0] data_out,
										  input ack_next,
										  output ack);
			

wire det;
or(det, data_in[7], data_in[6]);

wire hab;
assign ack=hab;

muller_2input #(DELAY) control_logic(.rst_n(rst_n),
									 .a(det),
									 .b(~ack_next),
									 .s(hab));


reg_assync_4bits register(.hab(hab),
								  .in(data_in),
								  .out(data_out));
								  									 
										  
endmodule 