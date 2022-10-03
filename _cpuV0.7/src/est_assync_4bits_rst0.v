module est_assync_4bits_rst0
				#(parameter DELAY=0)
								 (input rst_n,
								  input [7:0] data_in,
								  output[7:0] data_out,
								  output ack_ant,
								  input  ack_next1,
								  input  ack_next2
									);
									
									
									
wire det;
or (det, data_in[7], data_in[6]);


wire w_in[7:0];
and(w_in[7],rst_n,data_in[7]);

or(w_in[6],~rst_n,data_in[6]);

and(w_in[5],rst_n,data_in[5]);

or(w_in[4],~rst_n,data_in[4]);

and(w_in[3],rst_n,data_in[3]);

or(w_in[2],~rst_n,data_in[2]);

and(w_in[1],rst_n,data_in[1]);

or(w_in[0],~rst_n,data_in[0]);


wire hab;
assign ack_ant=hab;

muller_3input_set #(DELAY) control_logic(.set_n(rst_n),
									 .a(det),
									 .b(~ack_next1),
									 .c(~ack_next2),
									 .s(hab));
									 

wire [7:0] d_out_reg;									 
									 
reg_assync register3(.hab(hab),
					.in_t(w_in[7]),
					.in_f(w_in[6]),
					.out_t(d_out_reg[7]),
					.out_f(d_out_reg[6]));
					
reg_assync register2(.hab(hab),
					.in_t(w_in[5]),
					.in_f(w_in[4]),
					.out_t(d_out_reg[5]),
					.out_f(d_out_reg[4]));


reg_assync register1(.hab(hab),
					.in_t(w_in[3]),
					.in_f(w_in[2]),
					.out_t(d_out_reg[3]),
					.out_f(d_out_reg[2]));					

reg_assync register0(.hab(hab),
					.in_t(w_in[1]),
					.in_f(w_in[0]),
					.out_t(d_out_reg[1]),
					.out_f(d_out_reg[0]));



and (data_out[7],rst_n,d_out_reg[7]);
and (data_out[6],rst_n,d_out_reg[6]);
and (data_out[5],rst_n,d_out_reg[5]);
and (data_out[4],rst_n,d_out_reg[4]);
and (data_out[3],rst_n,d_out_reg[3]);
and (data_out[2],rst_n,d_out_reg[2]);
and (data_out[1],rst_n,d_out_reg[1]);
and (data_out[0],rst_n,d_out_reg[0]);
					
					
endmodule 