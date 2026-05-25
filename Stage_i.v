`timescale 1ns / 1ps

module Stage_i#(parameter Rcon = 8'h01)(
    input [127:0] key,
    input [127:0] message,
    output [127:0] key_out,
    output [127:0] out
);

wire [127:0] after_sub;
wire [127:0] after_sr;
wire [127:0] after_mc;

Sbox SubBytes(
    .message(message),
    .out(after_sub)
);

Shift_Rows sr(
    .message(after_sub),
    .out(after_sr)
);

MixColumns mc(
    .message(after_sr),
    .out(after_mc)
);

AddRK adrk(
    .message(after_mc),
    .key(key),
    .out(out)
);

KeyEX #(
    .Rcon(Rcon)
) key_exp_inst (
    .key_in(key),
    .key_out(key_out)
);

endmodule