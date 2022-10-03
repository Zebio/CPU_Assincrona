module est_somador_4bits(input rst_n,
								 input [1:0]opr,
								 input [7:0]a,b,
								 output[7:0]soma,
								 input ack_next,
								 output ack);
			
wire [7:0] w_soma;
			
somador_4bits somadorNCL(.in_a(a),
								 .in_b(b),
								 .cin(opr),
								 .soma(w_soma));
								 
								 
wire det,det3,det2,det1,det0;
or (det3,w_soma[7],w_soma[6]);
or (det2,w_soma[5],w_soma[4]);
or (det1,w_soma[3],w_soma[2]);
or (det0,w_soma[1],w_soma[0]);
and(det,det3,det2,det1,det0);

wire hab;
assign ack=hab;

muller_2input control_logic(	.rst_n(rst_n),
										.a(det),
										.b(~ack_next),
										.s(hab));
										
										
reg_assync_4bits register(	.hab(hab),
								   .in(w_soma),
									.out(soma));

										
								 
endmodule 