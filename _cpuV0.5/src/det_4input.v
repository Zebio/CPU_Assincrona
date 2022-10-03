module det_4input(input [1:0] in_1, in_2, in_3,in_4,
						output det);
						
wire det1, det2, det3, det4;

xor (det1, in_1[0],in_1[1]);
xor (det2, in_2[0],in_2[1]);
xor (det3, in_3[0],in_3[1]);
xor (det4, in_3[0],in_3[1]);
and (det,  det1, det2, det3, det4);
						
						
endmodule 