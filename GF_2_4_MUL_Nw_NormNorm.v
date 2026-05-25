`timescale 1ns / 1ps
// Normal-Normal Basis GF(2^4) Multiplier with N = w

module GF_2_4_MUL_Nw_NormNorm (q, a, b);
    input   [3:0]   a, b;
    output  [3:0]   q;
    wire    [1:0]   t0, t1, t2, t3;
    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    GF_2_2_MUL_Norm u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    GF_2_2_MUL_Norm u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));
    GF_2_2_SCLw_Norm u_scl (.q(t3), .a(t2));
    assign q = {(t3 ^ t1), (t3 ^ t0)};

endmodule
