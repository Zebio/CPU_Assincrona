module det10_input(input [1:0] in_1, in_2, in_3,in_4,in_5,
							in_6,in_7,in_8,in_9,in_10,
						output det);
						
wire det1, det2, det3, det4, det5, det6, det7, det8, det9, det10;

xor (det1, in_1[0],in_1[1]);
xor (det2, in_2[0],in_2[1]);
xor (det3, in_3[0],in_3[1]);
xor (det4, in_4[0],in_4[1]);
xor (det5, in_5[0],in_5[1]);
xor (det6, in_6[0],in_6[1]);
xor (det7, in_7[0],in_7[1]);
xor (det8, in_8[0],in_8[1]);
xor (det9, in_9[0],in_9[1]);
xor (det10,in_10[0],in_10[1]);
and (det,  det1, det2, det3,det4,det5,det6,det7,det8,det9,det10);
						
						
endmodule 