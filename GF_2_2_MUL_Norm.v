
`timescale 1ns / 1ps
// GF(2^2) / GF(2): w^2 + w + 1

// Normal Basis GF(2^2) Multiplier

module GF_2_2_MUL_Norm (q, a, b);

    input   [1:0]   a, b;

    output  [1:0]   q;

    wire    t;

    assign t = (a[1] ^ a[0]) & (b[1] ^ b[0]);

    assign q[1] = t ^ (a[1] & b[1]);
    assign q[0] = t ^ (a[0] & b[0]);

endmodule
