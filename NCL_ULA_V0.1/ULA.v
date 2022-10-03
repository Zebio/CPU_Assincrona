module ULA( input [15:0] in_a,in_b, //8 bit operands
			input [1:0] in_opr, 		   //operation selector
			output[15:0] resultado,    //result
			output[1:0] neg,zero,of);  //flags
				
wire [15:0]wire_b ;

NCL_xor xor1(.in_a_t(in_b[1]), .in_a_f(in_b[0]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[1]), .out_f(wire_b[0]));
NCL_xor xor2(.in_a_t(in_b[3]), .in_a_f(in_b[2]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[3]), .out_f(wire_b[2]));
NCL_xor xor3(.in_a_t(in_b[5]), .in_a_f(in_b[4]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[5]), .out_f(wire_b[4]));
NCL_xor xor4(.in_a_t(in_b[7]), .in_a_f(in_b[6]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[7]), .out_f(wire_b[6]));
NCL_xor xor5(.in_a_t(in_b[9]), .in_a_f(in_b[8]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[9]), .out_f(wire_b[8]));
NCL_xor xor6(.in_a_t(in_b[11]), .in_a_f(in_b[10]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[11]), .out_f(wire_b[10]));
NCL_xor xor7(.in_a_t(in_b[13]), .in_a_f(in_b[12]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[13]), .out_f(wire_b[12]));
NCL_xor xor8(.in_a_t(in_b[15]), .in_a_f(in_b[14]), .in_b_t(in_opr[1]), .in_b_f(in_opr[0]), .out_t(wire_b[15]), .out_f(wire_b[14]));

				
				
somador_8bits somador_8bits(.in_a(in_a),.in_b(wire_b),.cin(in_opr),.soma(resultado),.overflow(of));

assign neg[1] = resultado[15];
assign neg[0] = resultado[14];

zero_detector zero_detector(resultado[0],resultado[1],resultado[2],resultado[3],resultado[4],resultado[5],resultado[6],resultado[7],
									 resultado[8],resultado[9],resultado[10],resultado[11],resultado[12],resultado[13],resultado[14],resultado[15],
	 zero[1], zero[0]);

endmodule 