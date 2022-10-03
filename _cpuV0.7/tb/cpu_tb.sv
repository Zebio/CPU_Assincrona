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
bit halt;

cpu dut(rst_n);
				
int pc;
initial begin
    $readmemb("../../tb/bin_memory_file.mem", dut.MEMORY.memoria, 0, 15);
	rst_n=0;
    pc=0;
    halt=0;

	#50;
	rst_n=1;
    while(halt==0)
    begin
        instruction_verifier(halt);
    end
	
end		

task automatic instruction_verifier(output bit halt);

instruction_code instruction;
register_code register1,register2;
logic[7:0] data;

@(posedge dut.INSTR_REG.hab);
print_status();
data={dut.instr_reg_data[15],dut.instr_reg_data[13],dut.instr_reg_data[11],
dut.instr_reg_data[9],dut.instr_reg_data[7],dut.instr_reg_data[5],
dut.instr_reg_data[3],dut.instr_reg_data[1]};

instruction = instruction_code'(data[7:4]) ;
$write("NEXT INSTRUCTION: %s" ,instruction.name);
if (instruction <12 && instruction>1) begin
    $write(", Addr: %d ",data[3:0]);
end
else if (instruction >=12)
begin
    register1= register_code'(data[3:2]);
    register2= register_code'(data[1:0]);
    $write(", %s , %s ",register1.name,register2.name);
end
if(instruction==HALT)
    halt=1;
else
    halt=0;
endtask 

task automatic print_status();
reg [3:0] getPC;
$display ("\n-----------------------------------------------");

$display ("\nMEMORY STATUS: ");
for (reg[4:0] i = 0; i<=15 ;i++ ) begin
        $display ("%2d: %b" , i , dut.MEMORY.memoria[i]); 
end

$display ("\nCACHE STATUS: ");

    $display ("REG_A: %b"  , dut.CACHE.memoria[0]);
    $display ("REG_B: %b"  , dut.CACHE.memoria[1]);
    $display ("REG_C: %b"  , dut.CACHE.memoria[2]);
    $display ("REG_D: %b"  , dut.CACHE.memoria[3]);

    getPC={ dut.PROGRAM_COUNTER.w_soma[7],dut.PROGRAM_COUNTER.w_soma[5],
            dut.PROGRAM_COUNTER.w_soma[3],dut.PROGRAM_COUNTER.w_soma[1]};
    $display ("\nPROGRAM_COUNTER: %2d",getPC-1);
//$display ("\n FLAGS STATUS: ");
   // $display ("FLAG NEG: %b, FLAG ZERO: %b, FLAG OF: %b",dut.ctrl.flag_neg,dut.ctrl.flag_zero,dut.ctrl.flag_of);


endtask


endmodule 