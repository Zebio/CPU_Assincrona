module negedge_detector (input rst_n, signal, reset,
								 output reg det);
								 

wire rst;
or (rst, reset, rst_n);
								 
always @(posedge signal or posedge rst)

begin
	if (rst == 1)
		det<=0;
	else
		det<=1;

end 

endmodule 