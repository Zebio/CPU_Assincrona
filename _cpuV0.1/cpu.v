module cpu (input rst_n,
				input [1:0] PH0, PH1,
				input [3:0] addr,
				output [15:0] instruction,
				input instr_ack_next,
				output ctrl_ack, mem_addr_ack, instr_ack_before);
				

wire [1:0] ctrl_RC, ctrl_RM;
				
wire ack_memory;
	
est_controller controller_logic(.rst_n(rst_n), .PH0(PH0), .PH1(0), .Rd(0), .Ld(0),
							  .Rc(ctrl_RC), .Rm(ctrl_RM),
							  .ack_next(ack_memory),
							  .ack_before(ctrl_ack));
							 


wire [7:0] w_mem_addr;							 
mem_addr_mux mux_mem(.rst_n(rst_n),
							.address(addr),
							.PH0(PH0),
							.mem_addr(w_mem_addr),
							.ack_next(ack_memory),
							.ack_bef(mem_addr_ack));
									 
							 
							
						
wire [15:0] mem_data_out;

						
memory memoria(.rst_n(rst_n),
					.addr(w_mem_addr),
					.data_in(0),
					.read(ctrl_RM), .write(0),
					.ack_in_read(instr_ack_before),
					.data_out(mem_data_out),
					.dados(),
					.ack_read(ack_memory), 
					.ack_write());
					
					
					
instr_reg instructon(.rst_n(rst_n),
						.data(mem_data_out),
						.PH1(PH1),
						.instr(instruction),
						.ack_next(instr_ack_next),
						.ack_befo(instr_ack_before));
		
				
endmodule 