module cpu_tb();

reg rst_n;
reg [1:0] PH0, PH1;
reg [3:0] addr;

wire [15:0] instruction;

reg instr_ack_next;

wire ctrl_ack, mem_addr_ack, instr_ack_before;


cpu dut(rst_n, PH0, PH1,addr,instruction,instr_ack_next,ctrl_ack,
			mem_addr_ack, instr_ack_before);
			
			
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

initial
begin
addr = 4'b0000;
PH0 = 2'b00;
PH1 = 2'b00;
instr_ack_next=0;
rst_n=0;

#100;

rst_n=1;

#100;

PH0 = 2'b10;

#100;


PH0 = 2'b00;

#100;

PH1 = 2'b10;

#100;

instr_ack_next=1;

#100;

$stop;
end

endmodule 