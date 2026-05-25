`timescale 1ns / 1ps
module AES_SBox_GF_2_2_2_PolyNormMixBasis_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [7:0] g_in, g_out;

	wire [3:0] t1, t2, t3, t4, t5, t6, t7;


	assign g_in[7] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1] ^ in[0];
	assign g_in[6] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[0];
	assign g_in[5] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1] ^ in[0];
	assign g_in[4] = in[6] ^ in[5] ^ in[2] ^ in[0];
	assign g_in[3] = in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];
	assign g_in[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1] ^ in[0];
	assign g_in[1] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[0];
	assign g_in[0] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[0];

	

	assign t1 = g_in[7:4] ^ g_in[3:0];
	GF_2_4_MUL_Nw_NormNorm u_mul_1 (.q(t2), .a(g_in[7:4]), .b(g_in[3:0]));
	GF_2_4_SQR_SCL_N2_1_Nw_NormNorm u_sqr_scl (.q(t3), .a(t1));
	assign t4 = t2 ^ t3;
	GF_2_4_INV_Nw_NormNorm u_inv (.q(t5), .a(t4));
	GF_2_4_MUL_Nw_NormNorm u_mul_2 (.q(t6), .a(t5), .b(g_in[3:0]));
	GF_2_4_MUL_Nw_NormNorm u_mul_3 (.q(t7), .a(t5), .b(g_in[7:4]));
	assign g_out = {t6, t7};

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 1 1 1 
	*	0 1 1 1 0 1 1 1 
	*	1 1 1 0 1 0 1 1 
	*	1 0 1 0 0 1 1 1 
	*	1 1 1 1 0 1 1 1 
	*	0 0 1 1 0 0 1 0 
	*	0 1 1 0 1 1 0 1 
	*	0 1 0 1 1 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = g_out[7] ^ g_out[6] ^ g_out[4] ^ g_out[2] ^ g_out[1] ^ g_out[0];
	assign out[6] = ~( g_out[6] ^ g_out[5] ^ g_out[4] ^ g_out[2] ^ g_out[1] ^ g_out[0] );
	assign out[5] = ~( g_out[7] ^ g_out[6] ^ g_out[5] ^ g_out[3] ^ g_out[1] ^ g_out[0] );
	assign out[4] = g_out[7] ^ g_out[5] ^ g_out[2] ^ g_out[1] ^ g_out[0];
	assign out[3] = g_out[7] ^ g_out[6] ^ g_out[5] ^ g_out[4] ^ g_out[2] ^ g_out[1] ^ g_out[0];
	assign out[2] = g_out[5] ^ g_out[4] ^ g_out[1];
	assign out[1] = ~( g_out[6] ^ g_out[5] ^ g_out[3] ^ g_out[2] ^ g_out[0] );
	assign out[0] = ~( g_out[6] ^ g_out[4] ^ g_out[3] ^ g_out[2] ^ g_out[0] );

endmodule
