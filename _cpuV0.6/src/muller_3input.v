`timescale 1ns/1ns
module muller_3input    #(parameter DELAY=5)
						 (input rst_n,a,b,c,
						 output s);

wire w1,w2,w3,w4,w5;

or A1(w1,a,b,c);
and A2(w2,w1,s);
and A3(w3,a,b,c);
or A4(w5,w2,w3);
and #(DELAY) A5(s, rst_n,w5);

endmodule 