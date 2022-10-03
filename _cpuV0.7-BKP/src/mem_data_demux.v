module mem_data_demux#(parameter DELAY=0)
							  (input rst_n,
								input [15:0]data_in,
								input [1:0] PH0,
								output[15:0]data_out_cache,
								output[15:0]data_out_instr,
								output ack_send_to_cache,
								output ack_send_to_instr,
								input ack_in_cache,
								input ack_in_instr
								);
								
								
wire det_data;

wire det_PH0_true;

wire det_PH0_false;

wire data_to_instr;

wire data_to_cache;

or(det_data,data_in[15],data_in[14]);

and(det_PH0_true,PH0[1],~PH0[0]);

and(det_PH0_false,~PH0[1],~PH0[0]);

and(data_to_instr,det_PH0_true,det_data);

and(data_to_cache,det_PH0_false,det_data);


wire hab_instr;
assign ack_send_to_instr=hab_instr;



muller_2input #(DELAY)
CONTROL_INSTR (.rst_n(rst_n),
					.a(data_to_instr),
					.b(~ack_in_instr),
               .s(hab_instr));
					
					
reg_assync_8bits register_to_instr( .hab(hab_instr),
												.in(data_in),
												.out(data_out_instr));
								  
					
					
wire hab_cache;
assign ack_send_to_cache=hab_cache;


muller_2input #(DELAY)
CONTROL_CACHE (.rst_n(rst_n),
					.a(data_to_cache),
					.b(~ack_in_cache),
               .s(hab_cache));
					
reg_assync_8bits register_to_cache( .hab(hab_cache),
												.in(data_in),
												.out(data_out_cache));
												
endmodule 
								  
