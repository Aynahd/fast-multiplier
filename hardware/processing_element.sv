`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 11:11:24
// Design Name: 
// Module Name: processing_element
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

// each pe is a multiply and accumulator.
module processing_element #(
    parameter int WIDTH = 8  // 8-bit data
    )(
    input logic clk,
    input logic reset,
    input enable,
    // input from top
    input logic [WIDTH-1:0] a_in, 
    // input from left 
    input logic [WIDTH-1:0] b_in,
    // output to bottom
    output logic [WIDTH-1:0] a_out,
    // output to right 
    output logic [WIDTH-1:0] b_out,
    // accumulated a*b
    output logic [WIDTH*2-1:0] c_out    
    );
    
    // internals reg, hold values and accumulated result 
    logic [WIDTH-1:0]  a_reg, b_reg;
    logic [WIDTH-1:0] acc;
    
    initial begin 
         a_reg = 0;
         b_reg = 0;
         acc = 0;
    end
    
    always @(posedge clk) begin
        if(enable && !reset) begin
            a_reg = a_in;
            b_reg = b_in;
            acc <= acc +(a_reg * b_reg);
            end 
        if(reset) begin
            a_reg <= 0;
            b_reg <= 0;
            acc <= 0;
         end          
        
     end
     // pass a to next PE, downward
     // and b to next PE rightward 
     // cout the accumulated result 
     assign a_out = a_reg;
     assign b_out = b_reg;
     assign c_out = acc;
endmodule
