module memory (input rst_n,
					input[7:0] addr,
					input[15:0] data_in,
					input[1:0] read_Nwrite,
					input ack_in_read,
					output [15:0] data_out,
					output reg [7:0] dados,
					output ack_read, ack_write);
					
					

reg [7:0] memoria [15:0];
//wire [7:0] dados;

wire det_read, det_write;	

always @ (posedge det_write)
begin 
//	if(read[1])
//		dados <= memoria [{addr[7],addr[5],addr[3],addr[1]}];
	
	if(read_Nwrite[0])
		memoria [{addr[7],addr[5],addr[3],addr[1]}] <= {data_in[15],data_in[13],data_in[11],data_in[9],data_in[7],data_in[5],data_in[3],data_in[1]} ;
		
end
wire hab;
always @(posedge hab)
begin
	dados = memoria [{addr[7],addr[5],addr[3],addr[1]}];
end


	


det_2input detector_read (.in_1(addr[7:6]), .in_2({read_Nwrite[1],1'b0}), .det(det_read));

det_3input detector_write(.in_1(addr[7:6]), .in_2({read_Nwrite[0],1'b0}), .in_3(data_in[15:14]), .det(det_write));



wire[15:0] buffer_in;
assign ack_read = hab;
assign ack_write = det_write;

assign buffer_in = {dados[7],~dados[7],dados[6],~dados[6],dados[5],~dados[5],
						  dados[4],~dados[4],dados[3],~dados[3],dados[2],~dados[2],
						  dados[1],~dados[1],dados[0],~dados[0]};


muller_2input control_cell(.rst_n(rst_n), .a(det_read),.b(~ack_in_read), .s(hab));
						  
reg_assync_8bits async_buffer ( .hab(hab), .in(buffer_in), .out(data_out));

endmodule 

