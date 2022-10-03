module somador_8bits(input[15:0] in_a,in_b,
							input[1:0] cin,
							output[15:0] soma,
							output[1:0] overflow);
							

wire [15:0]w_cout;
							
							
full_adder a0(.A_t(in_a[1]),.A_f(in_a[0]), .B_t(in_b[1]),.B_f(in_b[0]), .Cin_t(cin[1]), .Cin_f(cin[0]),.Soma_t(soma[1]), .Soma_f(soma[0]),.Cout_t(w_cout[1]),.Cout_f(w_cout[0]));
full_adder a1(.A_t(in_a[3]),.A_f(in_a[2]), .B_t(in_b[3]),.B_f(in_b[2]), .Cin_t(w_cout[1]), .Cin_f(w_cout[0]),.Soma_t(soma[3]), .Soma_f(soma[2]),.Cout_t(w_cout[3]),.Cout_f(w_cout[2]));
full_adder a2(.A_t(in_a[5]),.A_f(in_a[4]), .B_t(in_b[5]),.B_f(in_b[4]), .Cin_t(w_cout[3]), .Cin_f(w_cout[2]),.Soma_t(soma[5]), .Soma_f(soma[4]),.Cout_t(w_cout[5]),.Cout_f(w_cout[4]));
full_adder a3(.A_t(in_a[7]),.A_f(in_a[6]), .B_t(in_b[7]),.B_f(in_b[6]), .Cin_t(w_cout[5]), .Cin_f(w_cout[4]),.Soma_t(soma[7]), .Soma_f(soma[6]),.Cout_t(w_cout[7]),.Cout_f(w_cout[6]));
full_adder a4(.A_t(in_a[9]),.A_f(in_a[8]), .B_t(in_b[9]),.B_f(in_b[8]), .Cin_t(w_cout[7]), .Cin_f(w_cout[6]),.Soma_t(soma[9]), .Soma_f(soma[8]),.Cout_t(w_cout[9]),.Cout_f(w_cout[8]));
full_adder a5(.A_t(in_a[11]),.A_f(in_a[10]), .B_t(in_b[11]),.B_f(in_b[10]), .Cin_t(w_cout[9]), .Cin_f(w_cout[8]),.Soma_t(soma[11]), .Soma_f(soma[10]),.Cout_t(w_cout[11]),.Cout_f(w_cout[10]));
full_adder a6(.A_t(in_a[13]),.A_f(in_a[12]), .B_t(in_b[13]),.B_f(in_b[12]), .Cin_t(w_cout[11]), .Cin_f(w_cout[10]),.Soma_t(soma[13]), .Soma_f(soma[12]),.Cout_t(w_cout[13]),.Cout_f(w_cout[12]));
full_adder a7(.A_t(in_a[15]),.A_f(in_a[14]), .B_t(in_b[15]),.B_f(in_b[14]), .Cin_t(w_cout[13]), .Cin_f(w_cout[12]),.Soma_t(soma[15]), .Soma_f(soma[14]),.Cout_t(w_cout[15]),.Cout_f(w_cout[14]));

NCL_xor xor_gate(.in_a_t(w_cout[13]), .in_a_f(w_cout[12]), .in_b_t(w_cout[15]), .in_b_f(w_cout[14]),.out_t(overflow[1]), .out_f(overflow[0]));


endmodule 