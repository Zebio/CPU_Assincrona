module or_addr_mem(input[7:0] addr1, addr2,
						 output[7:0]addr_out);
			
or(addr_out[7],addr1[7],addr2[7]);	
or(addr_out[6],addr1[6],addr2[6]);	
or(addr_out[5],addr1[5],addr2[5]);	
or(addr_out[4],addr1[4],addr2[4]);	
or(addr_out[3],addr1[3],addr2[3]);	
or(addr_out[2],addr1[2],addr2[2]);	
or(addr_out[1],addr1[1],addr2[1]);	
or(addr_out[0],addr1[0],addr2[0]);			
				
				
endmodule 