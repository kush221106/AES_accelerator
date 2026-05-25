`timescale 1ns / 1ps

module Sbox(
    input [127:0] message,
    output [127:0] out
);

    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e0  (.in(message[7:0]),     .out(out[7:0]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e1  (.in(message[15:8]),    .out(out[15:8]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e2  (.in(message[23:16]),   .out(out[23:16]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e3  (.in(message[31:24]),   .out(out[31:24]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e4  (.in(message[39:32]),   .out(out[39:32]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e5  (.in(message[47:40]),   .out(out[47:40]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e6  (.in(message[55:48]),   .out(out[55:48]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e7  (.in(message[63:56]),   .out(out[63:56]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e8  (.in(message[71:64]),   .out(out[71:64]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e9  (.in(message[79:72]),   .out(out[79:72]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e10 (.in(message[87:80]),   .out(out[87:80]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e11 (.in(message[95:88]),   .out(out[95:88]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e12 (.in(message[103:96]),  .out(out[103:96]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e13 (.in(message[111:104]), .out(out[111:104]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e14 (.in(message[119:112]), .out(out[119:112]));
    AES_SBox_GF_2_2_2_PolyNormMixBasis_1 e15 (.in(message[127:120]), .out(out[127:120]));

endmodule