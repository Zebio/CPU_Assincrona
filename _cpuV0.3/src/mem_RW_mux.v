module mem_RW_mux (input rst_n,
						 input [1:0]PH0,
						 input [1:0]MI,
						 output[1:0]RW,
						 input ack_in,
						 output ack);
						 
wire [1:0] w_RW;						 
						 
mem_RW_mux_NCL NCL_mux(.PH0_t(PH0[1]),
						 .PH0_f(PH0[0]),
						 .MI_t (MI[1]),
						 .MI_f (MI[0]), 
						 .RW_t(w_RW[1]),
						 .RW_f(w_RW[0]));			

						 
						 
wire det;
or(det,w_RW[1],w_RW[0]);

wire hab;
assign ack=hab;

muller_2input ctrl(.rst_n(rst_n),
						 .a(det),
						 .b(~ack_in),
                   .s(hab));


reg_assync register(.hab(hab),
						  .in_t(w_RW[1]),
						  .in_f(w_RW[0]),
						  .out_t(RW[1]),
						  .out_f(RW[0]));


			
endmodule 