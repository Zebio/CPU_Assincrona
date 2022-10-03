module cpu( input rst_n,
			   input [1:0]PH0,PH1,PH2,
				input [7:0] mem_addr_input,
				output mem_ack_read, mem_ack_write,
				ack_write_cache, ack_read_cache);
				
				

wire [7:0]  w_mem_addr; //wire to mem addr
wire [15:0]	w_mem_data_in; //wire to memory data_in
wire [1:0]  w_mem_R_nW; //wire to memory Read_Nwrite


wire intr_reg_ack; //wire to ack signal of instr reg
wire cache_write_ack; //wire to cache write operaton
wire ack_into_memory; //wire to OR acks into memory

 
wire [15:0] w_mem_data_out; //wire to memory data_out
 
//wire mem_ack_read, mem_ack_write; //wires to memory acks
wire mem_ack;
or (mem_ack, mem_ack_read, mem_ack_write);

wire [15:0] w_instr_out; //wire to instruction_out

wire [7:0]instr_reg_addr;
assign instr_reg_addr = w_instr_out[7:0];
 
or (w_mem_addr[7], instr_reg_addr[7], mem_addr_input[7]); 
or (w_mem_addr[6], instr_reg_addr[6], mem_addr_input[6]); 
or (w_mem_addr[5], instr_reg_addr[5], mem_addr_input[5]); 
or (w_mem_addr[4], instr_reg_addr[4], mem_addr_input[4]); 
or (w_mem_addr[3], instr_reg_addr[3], mem_addr_input[3]); 
or (w_mem_addr[2], instr_reg_addr[2], mem_addr_input[2]); 
or (w_mem_addr[1], instr_reg_addr[1], mem_addr_input[1]); 
or (w_mem_addr[0], instr_reg_addr[0], mem_addr_input[0]); 
 
wire [1:0]w_mem_RnW ;
wire [1:0]w_Mem_read;
 
or (w_mem_RnW[1],w_Mem_read[1],PH0[1] );
or (w_mem_RnW[0],w_Mem_read[0],PH0[0] );
 
 
memory memoria(.rst_n(rst_n),
					.addr(w_mem_addr),
					.data_in(w_mem_data_in),
					.read_Nwrite(w_mem_RnW),
					.ack_in_read(ack_into_memory),
					.data_out(w_mem_data_out),
					.dados(),
					.ack_read(mem_ack_read), 
					.ack_write(mem_ack_write));
					
					
wire [15:0] mem_demux_to_cache, mem_demux_to_instr;	
wire instr_reg_ack;

memory_out_demux Mem_demux( .rst_n(rst_n),
									 .memory_in(w_mem_data_out),
								    .PH0(PH0),
									 .PH1(PH1),
								    .cache_out(mem_demux_to_cache),
									 .instr_out(mem_demux_to_instr),
								    .cache_ack(ack_write_cache), 
									 .instr_ack(instr_reg_ack),
								    .ack_to_mem(ack_into_memory));				
					


wire ack_from_controller; //ack output of controller

					
instr_reg Instruction_register (.rst_n(rst_n),
						.data(mem_demux_to_instr),
						.PH1(PH1),
						.instr(w_instr_out),
						.ack_next(ack_from_controller),
						.ack_befo(instr_reg_ack));
						
						
wire [5:0] w_C1, w_C2, w_C3; //wires to cache instructions

wire [1:0] w_MemRead; //wito from controller into memory	


wire ack_into_controller; //Ack into controller
//wire ack_write_cache;
//wire ack_read_cache;	

wire ack_temp;
and (ack_temp,mem_ack_write,ack_read_cache);
or  (ack_into_controller,ack_temp,ack_write_cache);	
			
wire cache_ack;
or (cache_ack, ack_write_cache, ack_read_cache);




								 
			
est_controller Controller(.rst_n(rst_n),
							 .instruction(w_instr_out),
							 .C1_out(w_C1),
							 .C2_out(w_C2),
							 .C3_out(w_C3),
							 .MemRead(w_Mem_read),
							 .ack_ant(ack_from_controller),
							 .ack_pos(ack_into_controller));
							 
wire [15:0] cache_data_out;							 
assign w_mem_data_in=cache_data_out;
							 
cache c(.rst_n(rst_n),
					.read_Nwrite(w_C1[5:4]),
					.addr(w_C1[3:0]),
					.data_in(mem_demux_to_cache),
					.ack_in_read(mem_ack_write),
					.data_out(cache_data_out),
					.dados(),
					.ack_read(ack_read_cache), .ack_write(ack_write_cache));
					


endmodule 