module cpu(input rst_n);


wire[1:0]PH0,PH1,PH2;

wire ack_PH0_addr_buffer;
wire ack_PH0_RW_buffer;
wire ack_PH0_demux_buffer;

wire ack_PH1_cache_mem;

wire ack_PH2_PC;

wire [1:0] w_PHO_buff_addr;

wire [1:0] w_PHO_buff_RW;

wire [1:0] w_PHO_buff_demux;

wire[7:0] w_PC;

wire [7:0] w_EN_ADDR;

wire ack_en_addr;

wire [1:0] w_EN_RW;

wire ack_en_rw;

wire [7:0] w_ADDR_INTO_MEM;

wire [1:0] w_RW_INTO_MEM;

wire ack_mem;

wire ack_mem_read;
wire ack_mem_write;

wire[15:0] mem_data_out;

wire[15:0] demux_to_cache;

wire[15:0] demux_to_instr;

wire ack_demux_send_to_cache;

wire ack_demux_send_to_instr;

wire ack_demux;

wire [15:0] instr_reg_data;

wire ack_instr_RW;

wire ack_instr_addr;

wire ack_controller;

wire ack_instr_reg;

wire [1:0] instr_RW_buffer_data;

wire [7:0] instr_addr_buffer_data;

wire [5:0] controller_cache_instr;

wire [15:0] data_cache_to_mem;

wire ack_cache;

wire ack_cache_read;
wire ack_cache_write;



phase_gen #(5) 
PHASE_GEN		 (.rst_n(rst_n),
					  .PH0(PH0),
					  .PH1(PH1),
					  .PH2(PH2),
					  .ackInPH01(ack_PH0_addr_buffer),
					  .ackInPH02(ack_PH0_RW_buffer),
					  .ackInPH03(ack_PH0_demux_buffer),
					  .ackInPH1(ack_PH1_cache_mem),
					  .ackInPH2(ack_PH2_PC));
					  
	


	
est_assync_buffer #(5)
PH0_BUFFER_ADDR
						(.rst_n(rst_n),
						.data_in(PH0),
						.data_out(w_PHO_buff_addr),
						.ack_next(ack_en_addr),
						.ack_ant(ack_PH0_addr_buffer)
						);
		


		
est_assync_buffer #(5)
PH0_BUFFER_RW
						(.rst_n(rst_n),
						.data_in(PH0),
						.data_out(w_PHO_buff_RW),
						.ack_next(ack_en_rw),
						.ack_ant(ack_PH0_RW_buffer)
						);
			

			
est_assync_buffer #(5)
PH0_BUFFER_DEMUX
						(.rst_n(rst_n),
						.data_in(PH0),
						.data_out(w_PHO_buff_demux),
						.ack_next(ack_demux),
						.ack_ant(ack_PH0_demux_buffer)
						);

			


			
program_counter #(5)
PROGRAM_COUNTER(.rst_n(rst_n),
					 .inc(PH2),
					 .data_out(w_PC),
					 .ack_in(ack_en_addr),
					 .ack(ack_PH2_PC));
					 
					 

					 
enable_addr #(5)
ENABLE_ADDR(.rst_n(rst_n),
				.PH0_in(w_PHO_buff_addr),
				.PC_addr_in(w_PC),
				.addr_out(w_EN_ADDR),
				.ack_in(ack_mem),
				.ack(ack_en_addr));
				
				
or_addr_mem
OR_ADDR_MEM	(.addr1(w_EN_ADDR), 
				 .addr2(instr_addr_buffer_data),
				 .addr_out(w_ADDR_INTO_MEM));
					  
				
				
est_assync_buffer #(5)
RW_ENABLE   (.rst_n(rst_n),
				 .data_in(w_PHO_buff_RW),
				 .data_out(w_EN_RW),
				 .ack_next(ack_mem),
				 .ack_ant(ack_en_rw)
					);
							  				  
or_rw_mem 
OR_RW_MEM (.rw1(w_EN_RW),
			  .rw2(instr_RW_buffer_data),
			  .rw_out(w_RW_INTO_MEM));
					  

memory #(5)
MEMORY 		(.rst_n(rst_n),
				 .addr(w_ADDR_INTO_MEM),
				 .data_in(data_cache_to_mem),
				 .read_Nwrite(w_RW_INTO_MEM),
				 .ack_in_read(ack_demux),
				 .data_out(mem_data_out),
				 .dados(),
				 .ack_read(ack_mem_read), 
				 .ack_write(ack_mem_write));					  
	
or(ack_mem,ack_mem_read,ack_mem_write); 


mem_data_demux #(5)
MEM_DATA_DEMUX			  (.rst_n(rst_n),
								.data_in(mem_data_out),
								.PH0(w_PHO_buff_demux),
								.data_out_cache(demux_to_cache),
								.data_out_instr(demux_to_instr),
								.ack_send_to_cache(ack_demux_send_to_cache),
								.ack_send_to_instr(ack_demux_send_to_instr),
								.ack_in_cache(ack_cache),
								.ack_in_instr(ack_instr_reg)
								);
or(ack_demux,ack_demux_send_to_cache,ack_demux_send_to_instr);

instr_reg #(5)
INSTR_REG		 (.rst_n(rst_n),
					  .data_in(demux_to_instr),
					  .data_out(instr_reg_data),
					  .ack1(ack_instr_RW),
					  .ack2(ack_instr_addr),
					  .ack3(ack_controller),
					  .ack(ack_instr_reg));
					  
					  
					  
est_assync_buffer #(5)
INSTR_RW				 (.rst_n(rst_n),
						  .data_in(instr_reg_data[15:14]),
						  .data_out(instr_RW_buffer_data),
						  .ack_next(ack_mem),
						  .ack_ant(ack_instr_RW));
						  
est_assync_buffer_4bits #(5)
INSTR_ADDR				(.rst_n(rst_n),
							 .data_in(instr_reg_data[7:0]),
							 .data_out(instr_addr_buffer_data),
							 .ack_next(ack_mem),
							 .ack(ack_instr_addr));						  
					  
					  
controller  #(5)
CONTROLLER		(.rst_n(rst_n),
					 .instr_in(instr_reg_data[15:8]),
					 .cache_instr(controller_cache_instr),
					 .cache_ack(ack_cache),
					 .ack(ack_controller));
					 
cache #(5)
CACHE	(.rst_n(rst_n),
		 .addr(controller_cache_instr[5:2]),
		 .data_in(demux_to_cache),
		 .read_Nwrite(controller_cache_instr[1:0]),
		 .ack_in_read(ack_mem),
		 .data_out(data_cache_to_mem),
		 .dados(),
		 .ack_read(ack_cache_read), 
		 .ack_write(ack_cache_write));
					
or (ack_cache,ack_cache_read,ack_cache_write);	

or (ack_PH1_cache_mem,ack_mem, ack_cache);				 
					 

endmodule 