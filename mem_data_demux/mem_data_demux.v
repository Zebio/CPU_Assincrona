module mem_data_demux(input rst_n,
							 input [1:0] PH0,
							 input [15:0] data_in,
							 output[15:0] data_to_instr, data_to_cache,
							 input ack_in_instr, ack_in_cache,
							 output ack_out_instr, ack_out_cache
							 );
							 
wire [15:0] w_NCL_I, w_NCL_C;		
		
mem_data_demux_NCL NCL_demux( .PH0_t(PH0[1]),
										.PH0_f(PH0[0]),
										.D7_t(data_in[15]),
										.D7_f(data_in[14]),
										.D6_t(data_in[13]),
										.D6_f(data_in[12]),
										.D5_t(data_in[11]),
										.D5_f(data_in[10]),
										.D4_t(data_in[9 ]),
										.D4_f(data_in[8 ]),
										.D3_t(data_in[7 ]), 
										.D3_f(data_in[6 ]), 
										.D2_t(data_in[5 ]), 
										.D2_f(data_in[4 ]),
										.D1_t(data_in[3 ]),
										.D1_f(data_in[2 ]),
										.D0_t(data_in[1 ]),
										.D0_f(data_in[0 ]),  
										//outputs
									   .I7_t(w_NCL_I[15]),
										.I7_f(w_NCL_I[14]),
									   .I6_t(w_NCL_I[13]),
										.I6_f(w_NCL_I[12]),
									   .I5_t(w_NCL_I[11]),
										.I5_f(w_NCL_I[10]),
									   .I4_t(w_NCL_I[9 ]),
										.I4_f(w_NCL_I[8 ]),
									   .I3_t(w_NCL_I[7 ]),
										.I3_f(w_NCL_I[6 ]),
									   .I2_t(w_NCL_I[5 ]),
										.I2_f(w_NCL_I[4 ]),
									   .I1_t(w_NCL_I[3 ]),
										.I1_f(w_NCL_I[2 ]),
									   .I0_t(w_NCL_I[1 ]),
										.I0_f(w_NCL_I[0 ]),


										.C7_t(w_NCL_C[15]),
										.C7_f(w_NCL_C[14]),
										.C6_t(w_NCL_C[13]),
										.C6_f(w_NCL_C[12]),
										.C5_t(w_NCL_C[11]),
										.C5_f(w_NCL_C[10]),
										.C4_t(w_NCL_C[9 ]),
										.C4_f(w_NCL_C[8 ]),
										.C3_t(w_NCL_C[7 ]),
										.C3_f(w_NCL_C[6 ]),
										.C2_t(w_NCL_C[5 ]),
										.C2_f(w_NCL_C[4 ]),
										.C1_t(w_NCL_C[3 ]),
										.C1_f(w_NCL_C[2 ]),
										.C0_t(w_NCL_C[1 ]),
										.C0_f(w_NCL_C[0 ]),
										
										);
wire detInst, detCache;
										
or(detInst , w_NCL_I[15], w_NCL_I[14]);
or(detCache, w_NCL_C[15], w_NCL_C[14]);


wire habInst, habCache;
assign ack_out_instr= habInst;
assign ack_out_cache= habCache;

muller_2input control_logic_Inst(.rst_n(rst_n),
									 .a(detInst),
									 .b(~ack_in_instr),
									 .s(habInst));
			
muller_2input control_logic_Cache(.rst_n(rst_n),
									 .a(detCache),
									 .b(~ack_in_cache),
									 .s(habCache));
			

reg_assync_8bits reg_instr(.hab(habInst),
								   .in(w_NCL_I),
								   .out(data_to_instr));
								  
								  
reg_assync_8bits reg_cache(.hab(habCache),
								   .in(w_NCL_C),
								   .out(data_to_cache));
	
	
endmodule 