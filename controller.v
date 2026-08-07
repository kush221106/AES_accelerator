`timescale 1ns / 1ps
module Controller(input clk,
input reset,
input [9:0]source_address,
input ARready,
input [31:0]Rdata,
input [127:0]cipher_text,
input Rvalid,
input AWready,
input Wready,
input Aes_ready,
input [8:0]blocks,
input [127:0]key_in,
input start_in,
input key_valid,
input valid,
input [95:0]nounce_in,
output Rready,
output reg [9:0]ARaddr,
output reg ARvalid,
output reg [9:0]Awaddr,
output reg AWvalid,
output reg [127:0]message,
output [127:0] key_out,
output reg [31:0]Wdata,
output reg Wvalid,
output reg message_valid,
output [95:0]nounce_out,
output start_out,
output key_valid_out,
output wire [1:0] status,
output done);
reg [8:0]Rcounter;
reg [8:0]Wcounter;
reg [1:0] tempcnt;

always@(posedge clk)
begin 
if(reset) begin
Rcounter<=0;
end
else if(ARready & Rcounter<blocks & start_in & key_valid & Rvalid) begin
Rcounter<=Rcounter+1;
end
end
always@(posedge clk)
begin 
if(reset) begin
tempcnt<=3;
end
else if(ARready & Rcounter<=blocks & start_in & key_valid & Rvalid) begin
tempcnt<=tempcnt+1;
end
end
reg [1:0] tempw_cnt;
always@(posedge clk)
begin 
if(reset) begin
Wcounter <= 0;
tempw_cnt <= 0;
end
else if(start_in & Wvalid & Wcounter<blocks ) begin
Wcounter<=Wcounter+1;
tempw_cnt<= tempw_cnt + 1;
end
end 
always@(*)
begin 
if(start_in && key_valid && ARready && Rcounter<blocks)
begin
    ARaddr = source_address+Rcounter;
    ARvalid=1;
end
else 
    ARvalid =0;
end
assign Rready=start_in & key_valid;
always@(posedge clk) begin
    case (tempcnt)
        0 : message[127:96]<= Rdata;
        1 : message[95:64]<=Rdata;
        2 : message[63:32]<=Rdata;
        3 : message[31:0]<=Rdata; 
        
    endcase
end
always@(posedge clk)
begin
    if(tempcnt==3 && Rcounter!=0)
    begin 
        message_valid<=1;
    end
    else 
    message_valid<=0;
end
reg [127:0] cipher_accum;
assign nounce_out=nounce_in;
assign start_out=start_in;
assign key_out=key_in;
assign key_valid_out=key_valid;
always@(posedge clk)
begin
    if(AWready & Wready & valid)
    begin 
     AWvalid <= valid & ~done;
     Wvalid <= valid & ~done;
     cipher_accum <= cipher_text;
    end
end
always@(posedge clk)
Awaddr <= Wcounter;
always@(negedge clk) begin
    Wvalid<=0;
    if(start_in & Wcounter<blocks && Wvalid) Wvalid<=1; 
    case (tempw_cnt)
        0 : Wdata <= cipher_accum[127:96];
        1 : Wdata <= cipher_accum[95:64];
        2 : Wdata <= cipher_accum[63:32];
        3 : Wdata <= cipher_accum[31:0]; 
    endcase
end
assign done = (Wcounter==blocks);
assign status = (done? 2'b11 : (start_in ? 2'b00 : 2'b01)) ;
endmodule
