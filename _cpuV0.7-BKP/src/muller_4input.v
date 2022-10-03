`timescale 1ns/1ns
module muller_4input #(parameter DELAY=0)
						   (input rst_n,
							input a,b,c,d,
							output s);
							
wire w1,w2,w3,w4;

or(w1,a,b,c,d);

and(w2,a,b,c,d);

and(w3,w1,s);

or(w4,w3,w2);

and #(DELAY) (s,w4,rst_n);

endmodule 