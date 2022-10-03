`timescale 1ns/1ns
module cpu_tb();



reg rst_n;
reg [1:0] PH0, PH1, PH2;
reg [7:0] mem_addr_input;

wire mem_ack_read, mem_ack_write;
wire ack_write_cache, ack_read_cache;




cpu dut( 	rst_n,
			   PH0,PH1,PH2,
				mem_addr_input,
				mem_ack_read, mem_ack_write,
				ack_write_cache, ack_read_cache);
				

initial begin

	rst_n=0;
	PH0=2'b00;
	PH1=2'b00;
	PH2=2'b00;
	mem_addr_input= 8'b00000000;


	#50;
	rst_n=1;
	
	#50;
	mem_addr_input= 8'b01010101;
	PH0=2'b10;
	
	#50;
	mem_addr_input= 8'b00000000;
	PH0=2'b00;
	
	#50;
	PH1=2'b10;
	PH0=2'b01;
	
	#100;
	$stop;
	
end				
				
				

initial
begin
dut.memoria.memoria[0] =8'b10001111; //0 -- LOAD_A MEM[15]
dut.memoria.memoria[1] =8'b01000111; //1 -- READ_A MEM[7]
dut.memoria.memoria[2] =8'b10010111; //2 -- LOAD_B MEM[7]
dut.memoria.memoria[3] =8'b00000000; //3
dut.memoria.memoria[4] =8'b00000000; //4
dut.memoria.memoria[5] =8'b00000000; //5
dut.memoria.memoria[6] =8'b00000000; //6
dut.memoria.memoria[7] =8'b00000000; //7 -- destination
dut.memoria.memoria[8] =8'b00000000; //8
dut.memoria.memoria[9] =8'b00000000; //9
dut.memoria.memoria[10]=8'b00000000; //10
dut.memoria.memoria[11]=8'b00000000; //11
dut.memoria.memoria[12]=8'b00000000; //12
dut.memoria.memoria[13]=8'b00000000; //13
dut.memoria.memoria[14]=8'b00000000; //14
dut.memoria.memoria[15]=8'b11001100; //15 -- decimal 204
end 



endmodule 