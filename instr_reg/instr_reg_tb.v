module instr_reg_tb();

reg rst_n;
reg [15:0] data;
reg [1:0] PH1;

wire [15:0]instr;

reg ack_next;

wire ack_befo;


 instr_reg dit(rst_n,
					data,
					PH1,
					instr,
					ack_next,
					ack_befo);

initial begin
rst_n=0;
data=16'b0000000000000000;
PH1= 2'b00;
ack_next=0;

#50;
rst_n=1;
#50;

data=16'b1001010110101010;

#50;
PH1= 2'b10;

#50;
ack_next=1;

#50;
data=16'b0000000000000000;
PH1= 2'b00;
 #50;
 ack_next=0;

end
					

					
endmodule 