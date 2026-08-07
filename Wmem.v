`timescale 1ns / 1ps
module Wmem(input clk,
input reset,
input [9:0]R_address,
input [9:0]W_address,
input [31:0]Wdata,
input ARvalid,
input Rready,
input AWvalid,
input Wvalid,
output  wire ARready,
output reg [31:0]  Rdata,
output reg Rvalid,
output wire AWready,
output wire Wready
);
reg [31:0] memory[399:0];
assign ARready=1;
//read
always@(posedge clk)
begin 
    if(reset)
    begin 
     Rdata<=0;
     Rvalid<=0;
    end
    else
     if(ARvalid & ARready)
      begin 
         Rdata<=memory[R_address];
         Rvalid<=1;
      end
     else if(Rready & Rvalid)
     Rvalid<=0;
end
//write 
assign Wready=1;
assign AWready=1;
always@(negedge clk)
begin 
     if(Wvalid & AWvalid & Wready & AWready)
     memory[W_address]<=Wdata;
end
endmodule
