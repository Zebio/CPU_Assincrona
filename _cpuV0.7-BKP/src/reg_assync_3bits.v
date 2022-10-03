module reg_assync_3bits ( input hab,
								  input  [5:0]in,
								  output [5:0]out);
								  
					
reg_assync bit1(.hab(hab),.in_f(in[0]) ,.in_t(in[1]) ,.out_f(out[0]) ,.out_t(out[1]));
reg_assync bit2(.hab(hab),.in_f(in[2]) ,.in_t(in[3]) ,.out_f(out[2]) ,.out_t(out[3]));
reg_assync bit3(.hab(hab),.in_f(in[4]) ,.in_t(in[5]) ,.out_f(out[4]) ,.out_t(out[5]));
								  
								  
endmodule 