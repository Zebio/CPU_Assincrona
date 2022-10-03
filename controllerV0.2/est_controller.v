module est_controller(input rst_n,
							 input  [15:0]instruction,
							 output [5:0] C1_out,C2_out,C3_out,
							 output [1:0] MemRead,
							 output ack_ant,
							 input  ack_pos);


wire [5:0]C1, C2, C3;
wire [1:0]Mr;

controller NCL_controller(


			//NCL data inputs
			.I7_t(instruction[15]), .I7_f(instruction[14]), 
			.I6_t(instruction[13]), .I6_f(instruction[12]),
			.I5_t(instruction[11]), .I5_f(instruction[10]),
			.I4_t(instruction[9 ]), .I4_f(instruction[8 ]),
			.I3_t(instruction[7 ]), .I3_f(instruction[6 ]),
			.I2_t(instruction[5 ]), .I2_f(instruction[4 ]),
			.I1_t(instruction[3 ]), .I1_f(instruction[2 ]),
			.I0_t(instruction[1 ]), .I0_f(instruction[0 ]),
			//NCL data outputs			
			.C1i_t(C1[5]), .C1i_f(C1[4]), .C11_t(C1[3]), .C11_f(C1[2]), .C10_t(C1[1]), .C10_f(C1[0]),
			.C2i_t(C2[5]), .C2i_f(C2[4]), .C21_t(C2[3]), .C21_f(C2[2]), .C20_t(C2[1]), .C20_f(C2[0]),
			.C3i_t(C3[5]), .C3i_f(C3[4]), .C31_t(C3[3]), .C31_f(C3[2]), .C30_t(C3[1]), .C30_f(C3[0]),
			.Mr_t(Mr[1]), .Mr_f(Mr[0]));


wire det;
det_3input detector(.in_1(C1[5:4]), .in_2(C1[3:2]), .in_3(C1[1:0]),
						  .det(det));

			 
wire hab;
muller_2input ctrl_logic(.rst_n(rst_n),.a(det),.b(~ack_pos),.s(hab));

assign ack_ant = hab;


reg_assync_3bits C1reg(.hab(hab),.in(C1),.out(C1_out));		
reg_assync_3bits C2reg(.hab(hab),.in(C2),.out(C2_out));
reg_assync_3bits C3reg(.hab(hab),.in(C3),.out(C3_out));

		
reg_assync MRreg(.hab(hab),.in_t(Mr[1]),.in_f(Mr[0]),.out_t(MemRead[1]),.out_f(MemRead[0]));		

endmodule 