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


module tile8x8(
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




endmodule
