module reg_assync_2bits ( input hab,
								  input  [3:0]in,
								  output [3:0]out);
								  
					
reg_assync bit1(.hab(hab),.in_f(in[0]) ,.in_t(in[1]) ,.out_f(out[0]) ,.out_t(out[1]));
reg_assync bit2(.hab(hab),.in_f(in[2]) ,.in_t(in[3]) ,.out_f(out[2]) ,.out_t(out[3]));
								  
								  
endmodule 