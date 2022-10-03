module memory_out_demux (input rst_n,
								 input [15:0] memory_in,
								 input [1:0] PH0, PH1,
								 output[15:0] cache_out, instr_out,
								 input cache_ack, instr_ack,
								 output ack_to_mem);
								 
								 
wire det_data;

or (det_data, memory_in[15], memory_in[14]);
			

		
wire hab_cache, hab_instr;

or (ack_to_mem,hab_cache,hab_instr);


wire det_PH0, det_PH1;

and (det_PH0, PH0[1], ~PH0[0]);

and (det_PH1, PH1[1], ~PH1[0]);

muller_3input ctrl_cache(.rst_n(rst_n),.a(det_data),.b(~cache_ack),.c(det_PH1),.s(hab_cache));	
 
muller_3input ctrl_instr(.rst_n(rst_n),.a(det_data),.b(~instr_ack),.c(det_PH0),.s(hab_instr));	
								 
reg_assync_8bits register_cache(.hab(hab_cache),.in(memory_in),.out(cache_out));

reg_assync_8bits register_instr(.hab(hab_instr),.in(memory_in),.out(instr_out));

								 
endmodule 