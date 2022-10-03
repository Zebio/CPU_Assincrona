module det_2input(input [1:0] in_1, in_2,
						output det);
						
wire det1, det2;

xor (det1, in_1[0],in_1[1]);
xor (det2, in_2[0],in_2[1]);
and (det,  det1, det2);
						
						
endmodule 