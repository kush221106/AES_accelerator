`timescale 1ns / 1ps

module KeyEX#(parameter Rcon = 8'h01)(
    input [127:0] key_in,
    output [127:0] key_out
);

wire [31:0] w[0:3];
assign w[0] = key_in[127:96];
assign w[1] = key_in[95:64];
assign w[2] = key_in[63:32];
assign w[3] = key_in[31:0];

wire [31:0] rot_w3;
assign rot_w3 = {w[3][23:0], w[3][31:24]};

wire [31:0] sub_w3;
AES_SBox_GF_2_2_2_PolyNormMixBasis_1 u0(.in(rot_w3[31:24]), .out(sub_w3[31:24]));
AES_SBox_GF_2_2_2_PolyNormMixBasis_1 u1(.in(rot_w3[23:16]), .out(sub_w3[23:16]));
AES_SBox_GF_2_2_2_PolyNormMixBasis_1 u2(.in(rot_w3[15:8]),  .out(sub_w3[15:8]));
AES_SBox_GF_2_2_2_PolyNormMixBasis_1 u3(.in(rot_w3[7:0]),   .out(sub_w3[7:0]));

wire [31:0] k_e[0:3];
assign k_e[0] = w[0] ^ sub_w3 ^ {Rcon,24'h0};
assign k_e[1] = w[1] ^ k_e[0];
assign k_e[2] = w[2] ^ k_e[1];
assign k_e[3] = w[3] ^ k_e[2];

assign key_out = {
    k_e[0],
    k_e[1],
    k_e[2],
    k_e[3]
};

endmodule