module phase_gen(input rst_n,
					  output[1:0] PH0, PH1, PH2,
					  input ack);


					  
wire [1:0] w_BF3_PH0;
wire [1:0] w_PH0_BF0;

wire [1:0] w_BF0_PH1;
wire [1:0] w_PH1_BF1;

wire [1:0] w_BF1_PH2;
wire [1:0] w_PH2_BF2;

wire [1:0] w_BF2_BF3;

wire ack_PH0;
wire ack_PH1;
wire ack_PH2;
wire ack_BF0;
wire ack_BF1;
wire ack_BF2;
wire ack_BF3;
wire ack_BF0_a;
wire ack_BF1_a;
wire ack_BF2_a;


parameter DELAY =0.5 ;
//and(ack_BF0_a, ack_BF0, ack);
muller_2input #(DELAY) ctrl0(.rst_n(rst_n),.a(ack_BF0),.b(ack),.s(ack_BF0_a));

//and(ack_BF1_a, ack_BF1, ack);
muller_2input #(DELAY) ctrl1(.rst_n(rst_n),.a(ack_BF1),.b(ack),.s(ack_BF1_a));

//and(ack_BF2_a, ack_BF2, ack);
muller_2input #(DELAY) ctrl2(.rst_n(rst_n),.a(ack_BF2),.b(ack),.s(ack_BF2_a));


assign PH0[0]=w_PH0_BF0[0] && rst_n;
assign PH0[1]=w_PH0_BF0[1] && rst_n;
assign PH1[0]=w_PH1_BF1[0] && rst_n;
assign PH1[1]=w_PH1_BF1[1] && rst_n;
assign PH2[0]=w_PH2_BF2[0] && rst_n;
assign PH2[1]=w_PH2_BF2[1] && rst_n;

					  
est_assync_rst1 #(DELAY) PH0_est( .rst_n(rst_n),
								 .data_in (w_BF3_PH0),
								 .data_out(w_PH0_BF0),
								 .ack_next(ack_BF0_a),
								 .ack_ant(ack_PH0));
									

						
est_assync_buffer #(DELAY) BF0(	.rst_n(rst_n),
								.data_in(w_PH0_BF0),
								.data_out(w_BF0_PH1),
								.ack_next(ack_PH1),
								.ack_ant(ack_BF0)
									);
									
est_assync_rst0 #(DELAY) PH1_est( .rst_n(rst_n),
								 .data_in (w_BF0_PH1),
								 .data_out(w_PH1_BF1),
								 .ack_next(ack_BF1_a),
								 .ack_ant(ack_PH1));
								 
								 
est_assync_buffer #(DELAY) BF1(	.rst_n(rst_n),
								.data_in(w_PH1_BF1),
								.data_out(w_BF1_PH2),
								.ack_next(ack_PH2),
								.ack_ant(ack_BF1)
									);
									
est_assync_rst0 #(DELAY) PH2_est( .rst_n(rst_n),
								 .data_in (w_BF1_PH2),
								 .data_out(w_PH2_BF2),
								 .ack_next(ack_BF2_a),
								 .ack_ant(ack_PH2));
								 
									
est_assync_buffer #(DELAY) BF2(	.rst_n(rst_n),
								.data_in(w_PH2_BF2),
								.data_out(w_BF2_BF3),
								.ack_next(ack_BF3),
								.ack_ant(ack_BF2)
									);	
	
est_assync_buffer #(DELAY) BF3(	.rst_n(rst_n),
								.data_in(w_BF2_BF3),
								.data_out(w_BF3_PH0),
								.ack_next(ack_PH0),
								.ack_ant(ack_BF3)
									);			
												


endmodule 