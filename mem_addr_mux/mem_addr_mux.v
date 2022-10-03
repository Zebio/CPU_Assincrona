module mem_addr_mux (input rst_n,
							input [1:0] PH0,
							input [7:0] Addr_Instr,
							input [7:0] Addr_ProgC,
							output[7:0] Addr,
							input ack_next,
							output ack);
							
		
wire [7:0] w_mux_addr;		
			
mem_addr NCL_Mux(.PH0_t(PH0[1]),
					  .PH0_f(PH0[0]),
					  .PC3_t(Addr_Instr[7]),
					  .PC3_f(Addr_Instr[6]), 
					  .PC2_t(Addr_Instr[5]), 
					  .PC2_f(Addr_Instr[4]), 
					  .PC1_t(Addr_Instr[3]),
					  .PC1_f(Addr_Instr[2]),
					  .PC0_t(Addr_Instr[1]),
					  .PC0_f(Addr_Instr[0]),
					  .I3_t(Addr_ProgC[7]),
					  .I3_f(Addr_ProgC[6]),
					  .I2_t(Addr_ProgC[5]), 
					  .I2_f(Addr_ProgC[4]),
					  .I1_t(Addr_ProgC[3]),
					  .I1_f(Addr_ProgC[2]),
					  .I0_t(Addr_ProgC[1]),
					  .I0_f(Addr_ProgC[0]), 
					  .A3_t(w_mux_addr[7]), 
					  .A3_f(w_mux_addr[6]), 
					  .A2_t(w_mux_addr[5]), 
					  .A2_f(w_mux_addr[4]), 
					  .A1_t(w_mux_addr[3]), 
					  .A1_f(w_mux_addr[2]),
					  .A0_t(w_mux_addr[1]), 
					  .A0_f(w_mux_addr[0]));
	

wire det;
det_4input detector(.in_1(w_mux_addr[7:6]),
						  .in_2(w_mux_addr[5:4]), 
						  .in_3(w_mux_addr[3:2]),
						  .in_4(w_mux_addr[1:0]),
						  .det(det));
	
							
							
wire hab;
assign ack=hab;


muller_2input controll(.rst_n(rst_n),
							  .a(det),
							  .b(~ack_next),
							  .s(hab));
							  

reg_assync_4bits register(.hab(hab),
								  .in(w_mux_addr),
								  .out(Addr));
								 
							
endmodule 