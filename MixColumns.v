`timescale 1ns / 1ps

module MixColumns(
    input [127:0] message,
    output [127:0] out
);

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

function [7:0] mult2;
    input [7:0] x;
    begin
        mult2 = (x << 1) ^ (x[7] ? 8'h1B : 8'h00);
    end
endfunction

function [7:0] mult3;
    input [7:0] x;
    begin
        mult3 = mult2(x) ^ x;
    end
endfunction

wire [7:0] o[0:15];

// Column 0
assign o[0] = mult2(s[0]) ^ mult3(s[1]) ^ s[2] ^ s[3];
assign o[1] = s[0] ^ mult2(s[1]) ^ mult3(s[2]) ^ s[3];
assign o[2] = s[0] ^ s[1] ^ mult2(s[2]) ^ mult3(s[3]);
assign o[3] = mult3(s[0]) ^ s[1] ^ s[2] ^ mult2(s[3]);

// Column 1
assign o[4] = mult2(s[4]) ^ mult3(s[5]) ^ s[6] ^ s[7];
assign o[5] = s[4] ^ mult2(s[5]) ^ mult3(s[6]) ^ s[7];
assign o[6] = s[4] ^ s[5] ^ mult2(s[6]) ^ mult3(s[7]);
assign o[7] = mult3(s[4]) ^ s[5] ^ s[6] ^ mult2(s[7]);

// Column 2
assign o[8]  = mult2(s[8]) ^ mult3(s[9]) ^ s[10] ^ s[11];
assign o[9]  = s[8] ^ mult2(s[9]) ^ mult3(s[10]) ^ s[11];
assign o[10] = s[8] ^ s[9] ^ mult2(s[10]) ^ mult3(s[11]);
assign o[11] = mult3(s[8]) ^ s[9] ^ s[10] ^ mult2(s[11]);

// Column 3
assign o[12] = mult2(s[12]) ^ mult3(s[13]) ^ s[14] ^ s[15];
assign o[13] = s[12] ^ mult2(s[13]) ^ mult3(s[14]) ^ s[15];
assign o[14] = s[12] ^ s[13] ^ mult2(s[14]) ^ mult3(s[15]);
assign o[15] = mult3(s[12]) ^ s[13] ^ s[14] ^ mult2(s[15]);


assign out = {
    o[0],  o[1],  o[2],  o[3],
    o[4],  o[5],  o[6],  o[7],
    o[8],  o[9],  o[10], o[11],
    o[12], o[13], o[14], o[15]
};

endmodule