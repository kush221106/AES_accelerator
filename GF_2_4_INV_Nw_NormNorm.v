`timescale 1ns / 1ps
// Normal-Normal Basis GF(2^4) Inverter with N = w

module GF_2_4_INV_Nw_NormNorm (q, a);
    input   [3:0]   a;
    output  [3:0]   q;
    wire    [1:0]   t, t0, t1, t2, q1, q0;
    assign t = a[3:2] ^ a[1:0];
    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[3:2]), .b(a[1:0]));
    GF_2_2_SQR_SCLw_Norm u_sqr_scl (.q(t1), .a(t));
    GF_2_2_INV_Norm u_inv (.q(t2), .a(t0 ^ t1));
    GF_2_2_MUL_Norm u_mul_1 (.q(q1), .a(t2), .b(a[1:0]));
    GF_2_2_MUL_Norm u_mul_2 (.q(q0), .a(t2), .b(a[3:2]));
    assign q = {q1, q0};

endmodule
