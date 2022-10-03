module reg_assync (input hab,
								 in_t,
								 in_f,
						 output out_t,
								  out_f);


wire w1,w2;

nor f(w1,in_t,w2);
nor t(w2,in_f,w1);	
and a(out_f,w1,hab);
and b(out_t,w2,hab);

endmodule 