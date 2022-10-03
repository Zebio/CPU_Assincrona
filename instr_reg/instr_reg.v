module instr_reg (input rst_n,
						input [15:0] data,
						input [1:0] PH1,
						output [15:0] instr,
						input ack_next,
						output ack_befo);


wire det;
						
det_2input detector(.in_1(data[15:14]), .in_2(PH1),.det(det));

wire hab;

muller_2input control_logic(.rst_n(rst_n), .a(det),.b(~ack_next),.s(hab));

assign ack_befo = hab;

reg_assync_8bits register( .hab(hab),.in(data),.out(instr));
						

endmodule 