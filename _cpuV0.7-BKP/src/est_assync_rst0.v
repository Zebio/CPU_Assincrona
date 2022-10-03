module est_assync_rst0 #(parameter DELAY=0)
								 (input rst_n,
								  input [1:0] data_in,
								  output[1:0] data_out,
								  output ack_ant,
								  input  ack_next
									);
									
									
									
wire det;
or (det, data_in[0], data_in[1]);


wire w_in_t;
and(w_in_t,rst_n,data_in[1]);

wire w_in_f;
or(w_in_f,~rst_n,data_in[0]);

wire hab;
assign ack_ant=hab;

muller_2input_set #(DELAY) control_logic(.set_n(rst_n),
									 .a(det),
									 .b(~ack_next),
									 .s(hab));
									 
reg_assync register(.hab(hab),
					.in_t(w_in_t),
					.in_f(w_in_f),
					.out_t(data_out[1]),
					.out_f(data_out[0]));

					
endmodule 