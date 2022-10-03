module reg_assync_8bits ( input hab,
								  input  [15:0]in,
								  output [15:0]out);
								  
					
reg_assync bit1(.hab(hab),.in_f(in[0]) ,.in_t(in[1]) ,.out_f(out[0]) ,.out_t(out[1]));
reg_assync bit2(.hab(hab),.in_f(in[2]) ,.in_t(in[3]) ,.out_f(out[2]) ,.out_t(out[3]));
reg_assync bit3(.hab(hab),.in_f(in[4]) ,.in_t(in[5]) ,.out_f(out[4]) ,.out_t(out[5]));
reg_assync bit4(.hab(hab),.in_f(in[6]) ,.in_t(in[7]) ,.out_f(out[6]) ,.out_t(out[7]));
reg_assync bit5(.hab(hab),.in_f(in[8]) ,.in_t(in[9]) ,.out_f(out[8]) ,.out_t(out[9]));
reg_assync bit6(.hab(hab),.in_f(in[10]),.in_t(in[11]),.out_f(out[10]),.out_t(out[11]));
reg_assync bit7(.hab(hab),.in_f(in[12]),.in_t(in[13]),.out_f(out[12]),.out_t(out[13]));
reg_assync bit8(.hab(hab),.in_f(in[14]),.in_t(in[15]),.out_f(out[14]),.out_t(out[15]));					
								  
								  
endmodule 