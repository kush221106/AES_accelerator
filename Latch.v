`timescale 1ns / 1ps

module Latch(
    input clk,
    input stall,
    input [127:0] key_in, text_in,
    input valid_in,
    input [127:0] m_in,
    output reg [127:0] key_out, text_out,
    output reg valid_out,
    output reg [127:0] m_out
    );
    always @(posedge clk) begin
        if(!stall) begin
            key_out <= key_in;
            valid_out <= valid_in;
            text_out <= text_in;
            m_out <= m_in;
        end
    end
endmodule
