`timescale 1ns / 1ps
module AES128(  
    output valid_out,
    output [127:0] cipher_text,
    input [127:0] key, message,
    input clk,
    input valid_in,
    input start,
    input key_valid
    );

    wire stall;
    assign stall = ~start;
    // Stage 0: initial AddRoundKey 
    wire [127:0] m0, k0;
    assign m0 = message^key;
    KeyEX k1gen(.key_in(key), .key_out(k0));

    wire valid0 = valid_in & start & key_valid;
    wire [127:0] mess_out1,mess_out2,mess_out3,mess_out4,mess_out5,mess_out6,mess_out7,mess_out8,mess_out9,mess_out10,mess_out11;

    wire [127:0] k01, m01;
    wire valid01;
    Latch lr01(.clk(clk),.stall(stall),.key_in(k0),.text_in(m0),.valid_in(valid0),.key_out(k01),.text_out(m01),.valid_out(valid01),.m_in(message),.m_out(mess_out1));

    //  Round 1 
    wire [127:0] k1, m1;
    Stage_i #(.Rcon(8'h02)) s1(.key(k01),.message(m01),.key_out(k1),.out(m1));

    wire [127:0] k12, m12;
    wire valid12;
    Latch lr12(.clk(clk),.stall(stall),.key_in(k1),.text_in(m1),.valid_in(valid01),.key_out(k12),.text_out(m12),.valid_out(valid12),.m_in(mess_out1),.m_out(mess_out2));

    //  Round 2 
    wire [127:0] k2, m2;
    Stage_i #(.Rcon(8'h04)) s2(.key(k12),.message(m12),.key_out(k2),.out(m2));

    wire [127:0] k23, m23;
    wire valid23;
    Latch lr23(.clk(clk),.stall(stall),.key_in(k2),.text_in(m2),.valid_in(valid12),.key_out(k23),.text_out(m23),.valid_out(valid23),.m_in(mess_out2),.m_out(mess_out3));

    //  Round 3 
    wire [127:0] k3, m3;
    Stage_i #(.Rcon(8'h08)) s3(.key(k23),.message(m23),.key_out(k3),.out(m3));

    wire [127:0] k34, m34;
    wire valid34;
    Latch lr34(.clk(clk),.stall(stall),.key_in(k3),.text_in(m3),.valid_in(valid23),.key_out(k34),.text_out(m34),.valid_out(valid34),.m_in(mess_out3),.m_out(mess_out4));

    //  Round 4 
    wire [127:0] k4, m4;
    Stage_i #(.Rcon(8'h10)) s4(.key(k34),.message(m34),.key_out(k4),.out(m4));

    wire [127:0] k45, m45;
    wire valid45;
    Latch lr45(.clk(clk),.stall(stall),.key_in(k4),.text_in(m4),.valid_in(valid34),.key_out(k45),.text_out(m45),.valid_out(valid45),.m_in(mess_out4),.m_out(mess_out5));

    //  Round 5 
    wire [127:0] k5, m5;
    Stage_i #(.Rcon(8'h20)) s5(.key(k45),.message(m45),.key_out(k5),.out(m5));

    wire [127:0] k56, m56;
    wire valid56;
    Latch lr56(.clk(clk),.stall(stall),.key_in(k5),.text_in(m5),.valid_in(valid45),.key_out(k56),.text_out(m56),.valid_out(valid56),.m_in(mess_out5),.m_out(mess_out6));

    //  Round 6 
    wire [127:0] k6, m6;
    Stage_i #(.Rcon(8'h40)) s6(.key(k56),.message(m56),.key_out(k6),.out(m6));

    wire [127:0] k67, m67;
    wire valid67;
    Latch lr67(.clk(clk),.stall(stall),.key_in(k6),.text_in(m6),.valid_in(valid56),.key_out(k67),.text_out(m67),.valid_out(valid67),.m_in(mess_out6),.m_out(mess_out7));

    //  Round 7 
    wire [127:0] k7, m7;
    Stage_i #(.Rcon(8'h80)) s7(.key(k67),.message(m67),.key_out(k7),.out(m7));

    wire [127:0] k78, m78;
    wire valid78;
    Latch lr78(.clk(clk),.stall(stall),.key_in(k7),.text_in(m7),.valid_in(valid67),.key_out(k78),.text_out(m78),.valid_out(valid78),.m_in(mess_out7),.m_out(mess_out8));

    //  Round 8 
    wire [127:0] k8, m8;
    Stage_i #(.Rcon(8'h1B)) s8(.key(k78),.message(m78),.key_out(k8),.out(m8));

    wire [127:0] k89, m89;
    wire valid89;
    Latch lr89(.clk(clk),.stall(stall),.key_in(k8),.text_in(m8),.valid_in(valid78),.key_out(k89),.text_out(m89),.valid_out(valid89),.m_in(mess_out8),.m_out(mess_out9));

    //  Round 9 
    wire [127:0] k9, m9;
    Stage_i #(.Rcon(8'h36)) s9(.key(k89),.message(m89),.key_out(k9),.out(m9));

    wire [127:0] k910, m910;
    wire valid910;
    Latch lr910(.clk(clk),.stall(stall),.key_in(k9),.text_in(m9),.valid_in(valid89),.key_out(k910),.text_out(m910),.valid_out(valid910),.m_in(mess_out9),.m_out(mess_out10));

    //  Round 10: final round (no MixColumns) 
    wire [127:0] m10,m11,m111;
    Sbox s100(.message(m910),.out(m10));
    Shift_Rows s101(.message(m10),.out(m11));
    AddRK s102(.message(m11),.out(m111),.key(k910));

    wire [127:0] m_out;
    wire valid_out_r;
    Latch lr_out(.clk(clk),.stall(stall),.key_in(128'd0),.text_in(m111),.valid_in(valid910),.key_out(),.text_out(m_out),.valid_out(valid_out_r),.m_in(mess_out10),.m_out(mess_out11));

    //  Outputs 
    assign cipher_text = m_out;
    assign valid_out   = valid_out_r;
endmodule