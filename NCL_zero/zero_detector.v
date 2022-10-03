module zero_detector(
	input E1_t, E1_f, E2_t, E2_f, E3_t, E3_f, E4_t, E4_f, E5_t, E5_f, E6_t, E6_f, E7_t, E7_f, E8_t, E8_f,
	output zero_t, zero_f);

	wire hysteresis;
	assign hysteresis = E1_t | E1_f | E2_t | E2_f | E3_t | E3_f | E4_t | E4_f | E5_t | E5_f | E6_t | E6_f | E7_t | E7_f | E8_t | E8_f;

	assign zero_f= (E8_t) | (E7_t) | (E6_t) | (E5_t) | (E4_t) | (E3_t) | (E2_t) | (E1_t) | (hysteresis & zero_f);
	assign zero_t= (E1_f & E2_f & E3_f & E4_f & E5_f & E6_f & E7_f & E8_f) | (hysteresis & zero_t);

endmodule 