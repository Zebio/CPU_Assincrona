`timescale 1ns/1ps
module phase_gen_tb();



reg rst_n;
wire [1:0]PH0,PH1,PH2;
reg ack_PH0_1, ack_PH0_2, ack_PH0_3;
reg ack_PH1_1;
reg ack_PH2_1;


phase_gen dut(rst_n,PH0,PH1,PH2,ack_PH0_1, ack_PH0_2, ack_PH0_3,
				ack_PH1_1, ack_PH2_1
);


initial 
begin
rst_n =0;
ack_PH0_1=0;
ack_PH0_2=0;
ack_PH0_3=0;
ack_PH1_1=0;
ack_PH2_1=0;
#50;

rst_n=1;

#200;

end

endmodule 