module enable_addr #(parameter DELAY=0)
					   (input rst_n,
						 input [1:0] PH0_in,
						 input [7:0] PC_addr_in,
						 output[7:0] addr_out,
						 input ack_in,
						 output ack);

wire [7:0]w_ncl_addr;
						 
NCL_enable_addr ENABLE_ADDR(.A3_t(PC_addr_in[7]),
									 .A3_f(PC_addr_in[6]),
									 .A2_t(PC_addr_in[5]), 
									 .A2_f(PC_addr_in[4]), 
									 .A1_t(PC_addr_in[3]), 
									 .A1_f(PC_addr_in[2]), 
									 .A0_t(PC_addr_in[1]), 
									 .A0_f(PC_addr_in[0]), 
									 .PH0_t(PH0_in[1]), 
									 .PH0_f(PH0_in[0]), 
									 .O3_t(w_ncl_addr[7]), 
									 .O3_f(w_ncl_addr[6]), 
									 .O2_t(w_ncl_addr[5]), 
									 .O2_f(w_ncl_addr[4]), 
									 .O1_t(w_ncl_addr[3]), 
									 .O1_f(w_ncl_addr[2]), 
									 .O0_t(w_ncl_addr[1]), 
									 .O0_f(w_ncl_addr[0]));					 

						 
wire det;
or(det,w_ncl_addr[7],w_ncl_addr[6] );

wire hab;
assign ack=hab;

muller_2input #(DELAY)
CONTROL(.rst_n(rst_n),
							  .a(det),
							  .b(~ack_in),
                       .s(hab));
							  
							  
reg_assync_4bits register( .hab(hab),
								   .in(w_ncl_addr),
								   .out(addr_out));
						 
						
endmodule 