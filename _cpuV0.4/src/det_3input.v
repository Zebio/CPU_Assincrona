`timescale 1ns/1ns
module det_3input #(parameter DELAY=0)
                (input [1:0] in_1, in_2, in_3,
						output det);
						
wire det1, det2, det3;

xor (det1, in_1[0],in_1[1]);
xor (det2, in_2[0],in_2[1]);
xor (det3, in_3[0],in_3[1]);
and #(DELAY) (det,  det1, det2, det3);
						
						
endmodule 