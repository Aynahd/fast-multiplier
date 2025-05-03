`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2025 22:54:43
// Design Name: 
// Module Name: tile8x8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tile4x4(
    //AUX
    input logic reset,
    input logic clk,
    input enable, 
    input logic [15:0] n_c0y, n_c1y, n_c2y, n_c3y,
    input logic [15:0] n_r0y, n_r1y, n_r2y, n_r3y,
    
    output wire n_r0x, n_r1x, n_r2x,n_r3x,
            n_c0x, n_c1x, n_c2x, n_c3x,
            
    output wire [7:0] y0, y1, y2, y3, y4, y5, y6, y7,y8, y9,y10, y11,y12,y13,y14,y15

    );



    // interconnetcing wires between the rows and columns 

    // interconnect (row) 
    wire [7:0] n_r00, n_r10, n_r20;
    wire [7:0] n_r01, n_r11, n_r21;
    wire [7:0] n_r02, n_r12, n_r22;
    wire [7:0] n_r03, n_r13, n_r23;


    // interconnect (col)
    wire [7:0] n_c00, n_c10, n_c20, n_c30;
    wire [7:0] n_c01, n_c11, n_c21, n_c31;
    wire [7:0] n_c02, n_c12, n_c22, n_c32;

    // architecture

    // row 0
    hpe c00(.rst(rst), .clk(clk), .en(en), .c(y_00), .a(n_r0x), .b(n_c0x), .a_out(n_r00), .b_out(n_c00));
    hpe c10(.rst(rst), .clk(clk), .en(en), .c(y_10), .a(n_r00), .b(n_c1x), .a_out(n_r10), .b_out(n_c10));
    hpe c20(.rst(rst), .clk(clk), .en(en), .c(y_20), .a(n_r10), .b(n_c2x), .a_out(n_r20), .b_out(n_c20));
    hpe c30(.rst(rst), .clk(clk), .en(en), .c(y_30), .a(n_r20), .b(n_c3x), .a_out(n_r30), .b_out(n_c30));

    // row 1
    hpe c01(.rst(rst), .clk(clk), .en(en), .c(y_01), .a(n_r1x), .b(n_c00), .a_out(n_r01), .b_out(n_c01));
    hpe c11(.rst(rst), .clk(clk), .en(en), .c(y_11), .a(n_r01), .b(n_c10), .a_out(n_r11), .b_out(n_c11));
    hpe c21(.rst(rst), .clk(clk), .en(en), .c(y_21), .a(n_r11), .b(n_c20), .a_out(n_r21), .b_out(n_c21));
    hpe c31(.rst(rst), .clk(clk), .en(en), .c(y_31), .a(n_r21), .b(n_c30), .a_out(n_r31), .b_out(n_c31));

    // row 2
    hpe c02(.rst(rst), .clk(clk), .en(en), .c(y_02), .a(n_r2x), .b(n_c01), .a_out(n_r02), .b_out(n_c02));
    hpe c12(.rst(rst), .clk(clk), .en(en), .c(y_12), .a(n_r02), .b(n_c11), .a_out(n_r12), .b_out(n_c12));
    hpe c22(.rst(rst), .clk(clk), .en(en), .c(y_22), .a(n_r12), .b(n_c21), .a_out(n_r22), .b_out(n_c22));
    hpe c32(.rst(rst), .clk(clk), .en(en), .c(y_32), .a(n_r22), .b(n_c31), .a_out(n_r32), .b_out(n_c32));

    // row 3
    hpe c03(.rst(rst), .clk(clk), .en(en), .c(y_03), .a(n_r3x), .b(n_c02), .a_out(n_r03), .b_out(n_c03));
    hpe c13(.rst(rst), .clk(clk), .en(en), .c(y_13), .a(n_r03), .b(n_c12), .a_out(n_r13), .b_out(n_c13));
    hpe c23(.rst(rst), .clk(clk), .en(en), .c(y_23), .a(n_r13), .b(n_c22), .a_out(n_r23), .b_out(n_c23));
    hpe c33(.rst(rst), .clk(clk), .en(en), .c(y_33), .a(n_r23), .b(n_c32), .a_out(n_r33), .b_out(n_c33));



endmodule
