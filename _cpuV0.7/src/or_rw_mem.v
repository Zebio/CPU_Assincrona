module or_rw_mem (input[1:0] rw1,rw2,
						output[1:0]rw_out);
			
or(rw_out[1],rw1[1],rw2[1]);
or(rw_out[0],rw1[0],rw2[0]);			
						
endmodule 