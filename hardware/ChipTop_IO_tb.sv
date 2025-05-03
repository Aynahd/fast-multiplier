`timescale 1ns / 1ps

module ChipTop_IO_tb();
    reg reset = 0;
    reg clk = 0;
    reg en;
    reg write;
    reg load;
    reg [8:0] AUX_MONITOR = 0;
    
    wire [7:0] data_out;
    reg [7:0] data_in;

    reg [1:0] idx_select;
    reg [2:0] reg_select;

    wire interrupt_pin;
    wire read_led, write_led, load_led, matmul_led, en_led;


    reg [31:0] clk_counter = 0;
    localparam MAX_LOAD_CYCLES = 5;  
    localparam MAX_MM_CYCLES = 12;
    
    always@(posedge clk) begin
        clk_counter <= clk_counter + 1;
    end
    

    
    always #1 CLK = ~CLK;

////////////////////////////////////////////////////////////////////

    // TEST 2

    reg [7:0] external_data_0 [0:3] = {0, 2, 3, 1};
    reg [7:0] external_data_1 [0:3] = {0, 2, 0, 3};
    reg [7:0] external_data_2 [0:3] = {1, 2, 4, 4};
    reg [7:0] external_data_3 [0:3] = {0, 2, 4, 2};

    reg [7:0] external_data_4 [0:3] = {2, 2, 0, 0};
    reg [7:0] external_data_5 [0:3] = {2, 4, 4, 0};
    reg [7:0] external_data_6 [0:3] = {4, 1, 4, 1};
    reg [7:0] external_data_7 [0:3] = {2, 4, 1, 4};


////////////////////////////////////////////////////////////////////


    initial begin
      en = 1;
      idx_select = 3;
      reg_select = 7;
      write = 1;
      load = 0;
      reset = 0;
      data_in = 8'h0008;//???
      AUX_MONITOR = {reg_select,idx_select,load,write};
      #10;
      
      $finish;
    end
    

        ChipTop top_module_00(
            .en(en),
            .clk(clk),
            .clear(reset),
            .AUX({reg_select,idx_select,load,write}),
            .data_in(data_in),
            .DATA_OUT(data_out),
            .INTERRUPT_PIN(interrupt_pin),
            .READ_LED(read_led),
            .WRITE_LED(write_led),
            .LOAD_LED(load_led),
            .MATMUL_LED(matmul_led),
            .EN_LED(en_led)
        );


endmodule