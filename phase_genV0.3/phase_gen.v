module phase_gen(input rst_n,
					  output[1:0]PH0,PH1,PH2,
					  input ackInPH01,
					  input ackInPH02,
					  input ackInPH03,
					  input ackInPH1,
					  input ackInPH2);
					  
						
wire ackPH0, ackPH1, ackPH2;						
			
est_ass_buffer_5ack_set PH0_est(.rst_n(rst_n),
									 .data_in(PH2),
									 .data_out(PH0),
									 .ack1(ackPH1),
									 .ack2(ackInPH01),
									 .ack3(ackInPH02),
									 .ack4(ackInPH03),
									 .ack(ackPH0));
									 
									 
est_assync_buffer_3ack PH1_est(.rst_n(rst_n),
									.data_in(PH0),
									.data_out(PH1),
									.ackIn1(ackPH2),
									.ackIn2(ackInPH1),
									.ack(ackPH1));
										
est_assync_buffer_3ack PH2_est(.rst_n(rst_n),
									.data_in(PH1),
									.data_out(PH2),
									.ackIn1(ackPH0),
									.ackIn2(ackInPH2),
									.ack(ackPH2));
			
					  
					  
endmodule 