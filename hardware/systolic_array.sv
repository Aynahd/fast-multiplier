`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 11:20:06
// Design Name: 
// Module Name: systolic_array
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


module systolic_array #(
 // 4 by 4 matrices for now, 8 bit data
    parameter int SIZE = 4,  
    parameter int WIDTH = 8
    )(
     input logic clk,
     input logic enable,
     input logic write,
     input logic reset,
     input logic idx,
     input [7:0] d0,
     input [7:0] d1,
     input [7:0] d2,
     input [7:0] d3,
     input [7:0] d4,
     input [7:0] d5,
     input [7:0] d6,
     input [7:0] d7,
     output wire [7:0] y0, y1, y2, y3, y4, y5, y6, y7,y8, y9,y10, y11,y12,y13,y14,y15
    );
    
 //a genvar is a special type of variable used
 //for creating multiple instances of code during elaboration
 // not during simulation
 // It's similar to a loop counter
 //  it's used to control the instantiation of hardware, 
 //not for runtime calculations. 
 
 
 // if i == 0, take ip from a_in, else take  from previos PE
 // verilog does not support multi dimensional ports ,
 // system verilog does 
 
 // Internal wires for a_out and b_out from each PE
 reg [SIZE-1:0] data_buffer [0:7];
 reg [2:0]idx_buffer = 0;
 //reg []  CHECK THIS  
 
 initial begin
    for(integer i = 0; i < 16; i =i+1 ) begin 
        data_buffer[i[3:0]] = 16'b0;
        end
        end
        
        always@(posedge clk) begin
        if(enable) begin
            if(write) begin 
            data_buffer[0] <= d0;
            data_buffer[1] <= d1;
            data_buffer[2] <= d2;
            data_buffer[3] <= d3;
            data_buffer[4] <= d4;
            data_buffer[5] <= d5;
            data_buffer[6] <= d6;
            data_buffer[7] <= d7;
            
            idx_buffer <= idx;
            
            end
            end
            end
            
  //write= 0
  wire [WIDTH - 1:0] x [0:7];
  wire [WIDTH - 1 :0] w [0:7];
  
  reg SA_enable ;
  always_comb begin
  SA_enable = !write;
  end
  
  
  //edge registers 
  wire [15:0] n_c0y, n_c1y, n_c2y, n_c3y;
  wire [15:0] n_r0y, n_r1y, n_r2y, n_r3y;
  
  
  tile8x8 systolicArray8x8(
            // AUX
            .reset(reset),
            .clk(clk), .enable(enable),
            

            // Edge Registers Inputs
            .n_r0x(x[0]), .n_r1x(x[1]), .n_r2x(x[2]), .n_r3x(x[3]),
            .n_c0x(w[0]), .n_c1x(w[1]), .n_c2x(w[2]), .n_c3x(w[3]),
            

            // Systolic Array Outputs
            .y0(y0), .y1(y1), .y2(y2), .y3(y3),
            .y4(y4), .y5(y5), .y6(y6), .y7(y7),
            .y8(y8), .y9(y9), .y10(y10), .y11(y11),
            .y12(y12), .y13(y13), .y14(y14), .y15(y15),



            // Unused Edge Pins
            .n_c0y(n_c0y), .n_c1y(n_c1y), .n_c2y(n_c2y), .n_c3y(n_c3y), .n_c4y(n_c4y), .n_c5y(n_c5y), .n_c6y(n_c6y), .n_c7y(n_c7y), 
            .n_r0y(n_r0y), .n_r1y(n_r1y), .n_r2y(n_r2y), .n_r3y(n_r3y), .n_r4y(n_r4y), .n_r5y(n_r5y), .n_r6y(n_r6y), .n_r7y(n_r7y)

    );
  
  
            
endmodule
