`timescale 1ns / 1ps
// Normal Basis GF(2^2) Squarer-w-Scaler
module GF_2_2_SQR_SCLw_Norm (q, a);
    input   [1:0]   a;
    output  [1:0]   q;
    assign q[1] = a[1] ^ a[0];
    assign q[0] = a[0];

endmodule
