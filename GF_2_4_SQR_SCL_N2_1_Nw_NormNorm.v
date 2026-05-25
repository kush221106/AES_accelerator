// Normal-Normal Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w

`timescale 1ns / 1ps
module GF_2_4_SQR_SCL_N2_1_Nw_NormNorm (q, a);
	input	[3:0]	a;
	output	[3:0]	q;
	wire	[1:0]	t00, t01, t10, t11;
	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));
	assign t00 = 2'b00;
	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));
	assign t01 = t11;
	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule
