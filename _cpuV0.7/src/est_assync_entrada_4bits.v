`timescale 1ns/1ns
module est_assync_entrada_4bits #(parameter DATA=8'b01010110,
											 parameter DELAY=0)
										  (input rst_n,
										   output[7:0]data_out,
											input ack_next);
											
			
wire ack_hab;
not #(DELAY) (ack_hab,ack_next);

wire[7:0] DATA_rst;

reg_assync_4bits register( .hab(ack_hab),
								  .in(DATA),
								  .out(DATA_rst));
								  
								  
and(data_out[7],DATA_rst[7],rst_n);
and(data_out[6],DATA_rst[6],rst_n);
and(data_out[5],DATA_rst[5],rst_n);
and(data_out[4],DATA_rst[4],rst_n);
and(data_out[3],DATA_rst[3],rst_n);
and(data_out[2],DATA_rst[2],rst_n);
and(data_out[1],DATA_rst[1],rst_n);
and(data_out[0],DATA_rst[0],rst_n);			
																			  
								  
								  
								  
endmodule 