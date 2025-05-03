`timescale 1ns / 1ps
module control(
    input reset,
    input clk,
    input en,                       // EN only for controller --> disable when changing inputs before load or read!
    input write,                    // WRITE TO INT_MEM
    input [1:0] idx,                // index of the element
    input [2:0] reg_select,         // which register
    input load,                     // Load to REGISTER FILE
    input [7:0] data_in,
    output [7:0] data_out
);
    ///////////////////////////////////////////////////////////

    //                      SYSTOLIC ARRAY

    // reg [4:0]   IDX = 0;
    
    reg [7:0]  data_1 = 0;
    reg [7:0]  data_2 = 0;
    reg [7:0]  data_3 = 0;
    reg [7:0]  data_4 = 0;
    reg [7:0]  data_5 = 0;
    reg [7:0]  data_6 = 0;
    reg [7:0]  data_7 = 0;



    /////////////////////////////////////////////////////////////
    
    //                  CONTROLLER


    reg [15:0] data_out_buffer = 0;

    // matrix 1
    reg [7:0] mat_a0 [0:3];
    reg [7:0] mat_a1 [0:3];
    reg [7:0] mat_a2 [0:3];
    reg [7:0] mat_a3 [0:3];

    // matrix 2
    reg [7:0] mat_b0 [0:3];
    reg [7:0] mat_b1 [0:3];
    reg [7:0] mat_b2 [0:3];
    reg [7:0] mat_b3 [0:3];

    // result matrix
    reg [7:0] mat_c0 [0:3];
    reg [7:0] mat_c1 [0:3];
    reg [7:0] mat_c2 [0:3];
    reg [7:0] mat_c3 [0:3];

    reg [1:0] idx_counter = 0;
    reg [1:0] idx_in_buffer = 0;
    reg [7:0] data_in_buffer = 0;

    reg sa_en = 0;
    reg sa_write = 0;


    always@(posedge CLK) begin
        if(en) begin
            // Always connect results register!
            if(load) begin
                // Load to registers (constant addresses)
                if (!write) begin
                    sa_en <= 1;
                    sa_write <= 1;
                    
                    data_0 <= mat_a0[idx_counter];
                    data_1 <= mat_a1[idx_counter];
                    data_2 <= mat_a2[idx_counter];
                    data_3 <= mat_a3[idx_counter];

                    data_4 <= mat_b0[idx_counter];
                    data_5 <= mat_b1[idx_counter];
                    data_6 <= mat_b2[idx_counter];
                    data_7 <= mat_b3[idx_counter];


                    
                    idx_counter <= idx_counter + 1;
                    idx_in_buffer <= idx_counter;                    
                end

                // LOAD && WRITE == READ!
                else if(write) begin
                    sa_en <= 0;
                    sa_write <= 0;
                    case (reg_select) 
                        0: data_out_buffer <= mat_c0[idx];
                        1: data_out_buffer <= mat_c1[idx];
                        2: data_out_buffer <= mat_c2[idx];
                        3: data_out_buffer <= mat_c3[idx];
                    endcase
                end
            end

            // If not loading, then 
            else if(!load) begin
                
                // Writing to sequence registers (outside the systolic array)
                // can safely turn SA off; for now.
                if(write) begin
                    sa_write <= 0;
                    sa_en <= 0;
                    case (reg_select)
                        4'd0 : mat_a0[idx] <= data_in;
                        4'd1 : mat_a1[idx] <= data_in;
                        4'd2 : mat_a2[idx] <= data_in;
                        4'd3 : mat_a3[idx] <= data_in;
                        4'd4 : mat_b0[idx] <= data_in;
                        4'd5 : mat_b1[idx] <= data_in;
                        4'd6 : mat_b2[idx] <= data_in;
                        4'd7 : mat_b3[idx] <= data_in;

                    endcase
                end

                // DO MATMUL IF NOT LOADING AND WRITING (IE IDLE!)
                else if (!write) begin
                    sa_write <= 0;
                    sa_en <= 1;
                end
            end
        end

    end

    ///////////////////////////////////////////////////////////////
    // Only when !WRITE (!SA_WRITE), will the matmul begin
        
    systolic_array sa_module(
        .rst(rst),
        .clk(clk), .en(sa_en), .write(sa_write), .idx(idx_in_buffer), 
        
        // Inputs to registers
        .din_0(data_0), 
        .din_1(data_1), 
        .din_2(data_2), 
        .din_3(data_3), 
        .din_4(data_4), 
        .din_5(data_5), 
        .din_6(data_6), 
        .din_7(data_7), 

        // Systolic Array Outputs
        .y_00(mat_c0[0]), .y_10(mat_c0[1]), .y_20(mat_c0[2]), .y_30(mat_c0[3]),
        .y_01(mat_c1[0]), .y_11(mat_c1[1]), .y_21(mat_c1[2]), .y_31(mat_c1[3]),
        .y_02(mat_c2[0]), .y_12(mat_c2[1]), .y_22(mat_c2[2]), .y_32(mat_c2[3]), 
        .y_03(mat_c3[0]), .y_13(mat_c3[1]), .y_23(mat_c3[2]), .y_33(mat_c3[3])

    );

    assign data_out = data_out_buffer;


endmodule