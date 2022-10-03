`timescale 1ns/1ns
module muller_5input_set
			#(parameter DELAY=0)(input set_n,a,b,c,d,e,
							output s);
							
							
							
wire w1,w2,w3;


or(w1,a,b,c,d,e);
and(w2,a,b,c,d,e);
and(w3,w1,s);
or #(DELAY)(s,w2,w3,~set_n);

endmodule 