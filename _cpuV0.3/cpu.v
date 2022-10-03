module cpu(input rst_n,
			input[7:0] addr_PC);



wire [1:0] PH0,PH1,PH2;
wire ack_into_PHgen;

phase_gen PHgen(.rst_n(rst_n),
					 .PH0(PH0),
					 .PH1(PH1),
					 .PH2(PH2),
					 .ack(ack_into_PHgen));


wire ack_buffer;	
wire ack_into_controller_PH1;		
wire ack_mem_data_demux_to_buffer;		 
or(ack_into_PHgen, ack_mem_data_demux_to_buffer, ack_into_controller_PH1);

wire[1:0] controllerMI;
wire[1:0] RW_into_memory;

wire memory_read_ack;
wire memory_write_ack;
wire ack_memory_RW_mux;

mem_RW_mux memory_RW_mux(.rst_n(rst_n),
						       .PH0(PH0),
						       .MI(controllerMI),
						       .RW(RW_into_memory),
						       .ack_in(memory_read_ack),
						 	   .ack(ack_memory_RW_mux));
		
wire [15:0] instruction_data;
wire [7:0]  addr_into_memory;
wire ack_memory_addr_mux;
mem_addr_mux memory_addr_mux(.rst_n(rst_n),
							 .PH0(PH0),
							 .Addr_Instr(instruction_data[7:0]),
							 .Addr_ProgC(addr_PC),
							 .Addr(addr_into_memory),
							 .ack_next(memory_read_ack),
							 .ack(ack_memory_addr_mux));							   

wire[15:0]data_into_memory;
wire[15:0]memory_data_out;
wire ack_mem_data_demux;
memory memoria(	.rst_n(rst_n),
				.addr(addr_into_memory),
				.data_in(data_into_memory),
				.read_Nwrite(RW_into_memory),
				.ack_in_read(ack_mem_data_demux),
				.data_out(memory_data_out),
				.dados(),
				.ack_read(memory_read_ack), 
				.ack_write(memory_write_ack));

wire [15:0] mem_mux_data_into_cache;
wire [15:0] mem_mux_data_into_buffer;


wire ack_write_cache;
wire ack_read_cache;


wire ack_mem_data_demux_to_cache;
or(ack_mem_data_demux,ack_mem_data_demux_to_cache,ack_mem_data_demux_to_buffer);

mem_data_demux memory_data_out_demux(	.rst_n(rst_n),
										.PH0(PH0),
										.data_in(memory_data_out),
										.data_to_instr(mem_mux_data_into_buffer),
										.data_to_cache(mem_mux_data_into_cache),
										.ack_in_instr(ack_buffer), 
										.ack_in_cache(ack_write_cache),
										.ack_out_instr(ack_mem_data_demux_to_buffer),
										.ack_out_cache(ack_mem_data_demux_to_cache)
				);				
	
				
wire ack_instr_reg;
wire [15:0] mux_buffer_into_instr;


est_assync_buffer_8bits buffer_into_instr(	.rst_n(rst_n),
											.data_in(mem_mux_data_into_buffer),
										    .data_out(mux_buffer_into_instr),
										    .ack_next(ack_instr_reg),
										    .ack(ack_buffer));


wire ack_controller;

instr_reg instruction_register(	.rst_n(rst_n),
								.data(mux_buffer_into_instr),
								.PH1(PH1),
								.instr(instruction_data),
								.ack_next(ack_controller),
								.ack_next2(ack_memory_addr_mux),
								.ack_befo(ack_instr_reg));


wire [5:0]C1_instr, C2_instr, C3_instr;


assign ack_into_controller_PH1= (memory_write_ack && ack_read_cache) || ack_write_cache;
//continuar depois da cache

est_controller controller(	.rst_n(rst_n),
							.instruction(instruction_data),
							.C1_out(C1_instr),
							.C2_out(C2_instr),
							.C3_out(C3_instr),
							.MemRead(controllerMI),
							.ack_ant(ack_controller),
							.ack_pos(ack_into_controller_PH1),
							.ack_pos2(ack_memory_RW_mux));



cache c(	.rst_n(rst_n),
			.addr(C1_instr[3:0]),
			.data_in(mem_mux_data_into_cache),
			.read_Nwrite(C1_instr[5:4]),
			.ack_in_read(memory_write_ack),
			.data_out(data_into_memory),
			.dados(),
			.ack_read(ack_read_cache), 
			.ack_write(ack_write_cache));


endmodule 