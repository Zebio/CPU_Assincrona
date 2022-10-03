module det_3input(input [5:0]in,
						 output det);
	
wire w1,w2,w3;
	
xor (w1,in[5],in[4]);
xor (w2,in[3],in[2]);
xor (w3,in[1],in[0]);
and(det,w1,w2,w3);

endmodule 