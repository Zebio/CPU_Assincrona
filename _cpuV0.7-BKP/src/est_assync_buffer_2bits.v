module est_assync_buffer_2bits 
		 #(parameter DELAY=0)
									    (input rst_n,
										  input [3:0] data_in,
										  output[3:0] data_out,
										  input ack_next,
										  output ack);
			

wire det;
or(det, data_in[3], data_in[2]);

wire hab;
assign ack=hab;

muller_2input #(DELAY) control_logic(.rst_n(rst_n),
									 .a(det),
									 .b(~ack_next),
									 .s(hab));


reg_assync_2bits register(.hab(hab),
								  .in(data_in),
								  .out(data_out));
								  									 
										  
endmodule 