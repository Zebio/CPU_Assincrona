module est_assync_entrada_4bits #(parameter DATA=8'b01010110)
										  (input rst_n,
										   output[7:0]data_out,
											input ack_next);
											
											
wire hab;
and(hab,~ack_next,rst_n);	
	
reg_assync_4bits register( .hab(hab),
								  .in(DATA),
								  .out(data_out));
								  
								  
								  
								  
								  
								  
endmodule 