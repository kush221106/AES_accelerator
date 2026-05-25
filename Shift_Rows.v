`timescale 1ns / 1ps

module Shift_Rows(
    input  [127:0] message,
    output [127:0] out
);

//column-major
wire [7:0] s[0:15];

assign s[0]  = message[127:120];
assign s[1]  = message[119:112];
assign s[2]  = message[111:104];
assign s[3]  = message[103:96];

assign s[4]  = message[95:88];
assign s[5]  = message[87:80];
assign s[6]  = message[79:72];
assign s[7]  = message[71:64];

assign s[8]  = message[63:56];
assign s[9]  = message[55:48];
assign s[10] = message[47:40];
assign s[11] = message[39:32];

assign s[12] = message[31:24];
assign s[13] = message[23:16];
assign s[14] = message[15:8];
assign s[15] = message[7:0];

//SHIFTROWS
wire [7:0] o[0:15];

// Row 0 (no shift)
assign o[0]  = s[0];
assign o[4]  = s[4];
assign o[8]  = s[8];
assign o[12] = s[12];

// Row 1 (left shift by 1)
assign o[1]  = s[5];
assign o[5]  = s[9];
assign o[9]  = s[13];
assign o[13] = s[1];

// Row 2 (left shift by 2)
assign o[2]  = s[10];
assign o[6]  = s[14];
assign o[10] = s[2];
assign o[14] = s[6];

// Row 3 (left shift by 3)
assign o[3]  = s[15];
assign o[7]  = s[3];
assign o[11] = s[7];
assign o[15] = s[11];

//PACK OUTPUT
assign out = {
    o[0],  o[1],  o[2],  o[3],
    o[4],  o[5],  o[6],  o[7],
    o[8],  o[9],  o[10], o[11],
    o[12], o[13], o[14], o[15]
};

endmodule