`timescale 1ns/1ns
module muller_3input_set #(parameter DELAY=0)
						(input set_n,a,b,c,
									output s);

wire w1,w2,w3,w4,w5;

or A1(w1,a,b,c);
and A2(w2,w1,s);
and A3(w3,a,b,c);
or #(DELAY) A4(s,w2,w3,~set_n);

endmodule 