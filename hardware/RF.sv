module rf (
    input logic clk,
    input logic rf_enable,
    input logic write,
    input logic [2:0] idx,

    input logic [7:0] data_in_0,
    input logic [7:0] data_in_1,
    input logic [7:0] data_in_2,
    input logic [7:0] data_in_3,
    input logic [7:0] data_in_4,
    input logic [7:0] data_in_5,
    input logic [7:0] data_in_6,
    input logic [7:0] data_in_7,


    output logic [7:0] x_out [0:7],
    output logic [7:0] w_out [0:7]
);


    // input matrix
    x_reg x_reg_0(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}), .din(data_in_0), .dout(x_out[0]));

    x_reg x_reg_1(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}+1), .din(data_in_1), .dout(x_out[1]));

    x_reg x_reg_2(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}+2), .din(data_in_2), .dout(x_out[2]));

    x_reg x_reg_3(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}+3), .din(data_in_3), .dout(x_out[3]));


    // weights matrix    
    x_reg x_reg_4(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}), .din(data_in_4), .dout(w_out[0]));

    x_reg x_reg_5(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}+1), .din(data_in_5), .dout(w_out[1]));

    x_reg x_reg_6(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}+2), .din(data_in_6), .dout(w_out[2]));

    x_reg x_reg_7(.clk(clk), .en(rf_en), .write(write),
        .idx({2'b0,idx}+3), .din(data_in_7), .dout(w_out[3]));

endmodule
