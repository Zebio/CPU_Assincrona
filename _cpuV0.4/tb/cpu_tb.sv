typedef enum bit[3:0]  {NOP      = 4'b0000,
                        HALT     = 4'b0001,
                        JUMP     = 4'b0010,
                        JUMP_NEG = 4'b0011,
                        READ_A   = 4'b0100,
                        READ_B   = 4'b0101,
                        READ_C   = 4'b0110,
                        READ_D   = 4'b0111,
                        LOAD_A   = 4'b1000,
                        LOAD_B   = 4'b1001,
                        LOAD_C   = 4'b1010,
                        LOAD_D   = 4'b1011,
                        ADD      = 4'b1100,
                        SUB      = 4'b1101,
                        AND      = 4'b1110,
                        OR       = 4'b1111  } instruction_code;

typedef enum bit[1:0] { REG_A = 2'b00,
                        REG_B = 2'b01,
                        REG_C = 2'b10,
                        REG_D = 2'b11 } register_code;


`timescale 1ns/1ns
module cpu_tb();     
reg rst_n;
wire ack0,ack1,ack2;


cpu dut(rst_n,ack0,ack1,ack2);
				

initial begin
    $readmemb("../../tb/bin_memory_file.mem", dut.memoria.memoria, 0, 15);

	rst_n=0;


	#50;
	rst_n=1;
    print_status();
	
	
	#400;
    print_status();
	$stop;
	
end				


task automatic print_status();
$display ("\n MEMORY STATUS: ");
for (int i = 0; i<16 ;i++ ) begin
    $display ("%2d: %b" , i , dut.memoria.memoria[i]);
end

$display ("\n CACHE STATUS: ");

    $display ("REG_A: %b"  , dut.c.memoria[0]);
    $display ("REG_B: %b"  , dut.c.memoria[1]);
    $display ("REG_C: %b"  , dut.c.memoria[2]);
    $display ("REG_D: %b"  , dut.c.memoria[3]);

//$display ("\n FLAGS STATUS: ");
   // $display ("FLAG NEG: %b, FLAG ZERO: %b, FLAG OF: %b",dut.ctrl.flag_neg,dut.ctrl.flag_zero,dut.ctrl.flag_of);
    $display ("-----------------------------------------------\n");

endtask

endmodule 