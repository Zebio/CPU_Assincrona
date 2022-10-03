`timescale 1ns/1ns
module muller_2input #(parameter DELAY=0)(input rst_n,a,b,
                     output s);

wire w1,w2,w3,w4;

and a1(w1,a,b);
and a2(w2,a,s);
and a3(w3,s,b);
or  a4(w4,w1,w2,w3);
and #(DELAY) a5 (s,w4,rst_n);


endmodule 