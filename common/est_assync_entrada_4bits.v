module est_assync_entrada_4bits #(parameter DATA=8'b01010110)
										  (input rst_n,
										   output[7:0]data_out,
											input ack_next);
											
											
											
reg_assync_4bits register( .hab(~ack_next),
								  .in(DATA),
								  .out(data_out));
								  
								  
								  
								  
								  
								  
endmodule 