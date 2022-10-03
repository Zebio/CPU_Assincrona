module phase_gen(input rst_n,
					  output [1:0]PH0,PH1,PH2,
					  input ack_PH0_1, ack_PH0_2, ack_PH0_3,
					  input ack_PH1_1,
					  input ack_PH2_1
					  );
					  
parameter DELAY =0;
					  
wire [1:0] w_PH0, w_PH1, w_PH2,w_PH0_nrst;



assign PH0=w_PH0;
assign PH1=w_PH1;
assign PH2=w_PH2;

wire ack_out_to_PH0;

wire ack_PH0, ack_PH1, ack_PH2;

wire ack_into_PH0;

wire ack_into_PH1;

wire ack_into_PH2;

muller_3input #(DELAY) controlPH0out(.rst_n(rst_n),
				  .a(ack_PH0_1),
				  .b(ack_PH0_2),
				  .c(ack_PH0_3),
				  .s(ack_out_to_PH0));
				  
muller_2input #(DELAY) controlPH0_PH1(.rst_n(rst_n),
				  .a(ack_out_to_PH0),
				  .b(ack_PH1),
				  .s(ack_into_PH0));
					  
est_assync_rst1 #(DELAY) PH0_est(.rst_n(rst_n),
								.data_in(w_PH2),
								.data_out(w_PH0_nrst),
								.ack_next(ack_into_PH0),
								.ack_ant(ack_PH0)
									);
									
									
and (w_PH0[0],w_PH0_nrst[0],rst_n);
and (w_PH0[1],w_PH0_nrst[1],rst_n);
									
									
muller_2input #(DELAY) controlPH1_PH2(.rst_n(rst_n),
				  .a(ack_out_to_PH0),
				  .b(ack_PH1_1),
				  .s(ack_into_PH1));									
									
									
est_assync_buffer PH1_est(.rst_n(rst_n),
								  .data_in(w_PH0),
								  .data_out(w_PH1),
								  .ack_next(ack_into_PH1),
								  .ack_ant(ack_PH1)
									);
									
									
muller_2input #(DELAY) controlPH2_PH0(.rst_n(rst_n),
				  .a(ack_PH2_1),
				  .b(ack_PH0),
				  .s(ack_into_PH2));									
									
est_assync_buffer PH2_est(.rst_n(rst_n),
								  .data_in(w_PH1),
								  .data_out(w_PH2),
								  .ack_next(ack_into_PH2),
								  .ack_ant(ack_PH2)
									);
									
									
endmodule 								
									