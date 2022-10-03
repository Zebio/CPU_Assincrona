module est_controller (input rst_n,
							  input [1:0] PH0, PH1, Rd, Ld,
							  output[1:0] Rc, Rm,
							  input ack_next,
							  output ack_before);
							  
wire [1:0] w_Rc, w_Rm;
							  
controller NCL_controller(.PH0_t(PH0[1]), .PH0_f(PH0[0]), .PH1_t(PH1[1]), .PH1_f(PH1[0]),
 .Rd_t(Rd[1]), .Rd_f(Rd[0]), .Ld_t(Ld[1]), .Ld_f(Ld[0]), 
  .R_c_t(w_Rc[1]), .R_c_f(w_Rc[0]), .R_m_t(w_Rm[1]), .R_m_f(w_Rm[0]));
  
  
 
wire det;

or (det, w_Rm[1], w_Rm[0]) ;

//det_2input detector(.in_1(w_Rc), .in_2(w_Rm), .det(det));

wire hab;

muller_2input control_cell(.rst_n(rst_n), .a(det),.b(~ack_next), .s(hab));

assign ack_before = hab;

reg_assync registerRC(.hab(hab),
							 .in_t(w_Rc[1]),
							 .in_f(w_Rc[0]),
							 .out_t(Rc[1]),
							 .out_f(Rc[0]));
							 
reg_assync registerRM(.hab(hab),
							 .in_t(w_Rm[1]),
							 .in_f(w_Rm[0]),
							 .out_t(Rm[1]),
							 .out_f(Rm[0]));


endmodule 