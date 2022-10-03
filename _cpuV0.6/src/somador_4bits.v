module somador_4bits(input[7:0] in_a,in_b,
							input[1:0] cin,
							output[7:0] soma);
							

wire [7:0]w_cout;
							
							
full_adder a0(.A_t(in_a[1]),.A_f(in_a[0]), .B_t(in_b[1]),.B_f(in_b[0]), .Cin_t(cin[1]), .Cin_f(cin[0]),.Soma_t(soma[1]), .Soma_f(soma[0]),.Cout_t(w_cout[1]),.Cout_f(w_cout[0]));
full_adder a1(.A_t(in_a[3]),.A_f(in_a[2]), .B_t(in_b[3]),.B_f(in_b[2]), .Cin_t(w_cout[1]), .Cin_f(w_cout[0]),.Soma_t(soma[3]), .Soma_f(soma[2]),.Cout_t(w_cout[3]),.Cout_f(w_cout[2]));
full_adder a2(.A_t(in_a[5]),.A_f(in_a[4]), .B_t(in_b[5]),.B_f(in_b[4]), .Cin_t(w_cout[3]), .Cin_f(w_cout[2]),.Soma_t(soma[5]), .Soma_f(soma[4]),.Cout_t(w_cout[5]),.Cout_f(w_cout[4]));
full_adder a3(.A_t(in_a[7]),.A_f(in_a[6]), .B_t(in_b[7]),.B_f(in_b[6]), .Cin_t(w_cout[5]), .Cin_f(w_cout[4]),.Soma_t(soma[7]), .Soma_f(soma[6]),.Cout_t(w_cout[7]),.Cout_f(w_cout[6]));


endmodule 