module program_counter
		 #(parameter DELAY=0)(input rst_n,
							  input [1:0] inc,
							  output[7:0]data_out,
							  input ack_in,
							  output ack);
							  
			
wire [7:0] w_a;
wire ack_somador;
			
			
est_assync_entrada_4bits #(8'b01010110, DELAY) 
								 entrada(.rst_n(rst_n),
										   .data_out(w_a),
											.ack_next(ack_somador));
											

											
wire [7:0] w_b, w_soma;
wire ack_est2;
assign ack=ack_somador;
est_somador_4bits #(DELAY)
						somador(.rst_n(rst_n),
								  .opr(inc),
								  .a(w_a),
								  .b(w_b),
								  .soma(w_soma),
								  .ack_next(ack_est2),
								  .ack(ack_somador));
								  
								  
								  
wire [7:0]w_est2;		
wire ack_est3;	
est_assync_4bits_rst0 #(DELAY) est2(.rst_n(rst_n),
								   .data_in(w_soma),
								   .data_out(w_est2),
								   .ack_ant(ack_est2),
								   .ack_next1(ack_est3),
								   .ack_next2(ack_in)
									);
									
assign data_out=w_est2;

est_assync_buffer_4bits #(DELAY)
								est3(.rst_n(rst_n),
									  .data_in(w_est2),
									  .data_out(w_b),
									  .ack_next(ack_somador),
									  .ack(ack_est3));
														
							  
endmodule 