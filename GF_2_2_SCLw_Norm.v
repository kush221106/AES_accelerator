`timescale 1ns / 1ps
// Normal Basis GF(2^2) w-Scaler
module GF_2_2_SCLw_Norm (output  [1:0] q,input   [1:0] a);
    assign q[1] = a[1] ^ a[0];
    assign q[0] = a[1];

endmodule