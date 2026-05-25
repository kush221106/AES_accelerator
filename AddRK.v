`timescale 1ns / 1ps

module AddRK(
    input [127:0] message,
    input [127:0] key,
    output [127:0] out
    );

    assign out = message ^ key;
    
endmodule
   