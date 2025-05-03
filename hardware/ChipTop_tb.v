`timescale 1ns / 1ps

module ChipTop_tb();
    reg reset = 0;
    reg clk = 0;
    reg en;
    reg write;
    reg load;
    
    wire [7:0] data_out;
    reg [7:0] data_in;

    reg [1:0] idx_select;
    reg [2:0] reg_select;

    wire interrupt_pin;
    wire read_led, write_led, load_led, matmul_led;


    reg [31:0] clk_counter = 0;
    localparam MAX_LOAD_CYCLES = 5;
    localparam MAX_MM_CYCLES = 12;
    
    always@(posedge clk) begin
        clk_counter <= clk_counter + 1;
    end
    

    
    always #1 clk = ~clk;

////////////////////////////////////////////////////////////////////

    // TEST 2
    reg [7:0] external_data_0 [0:3] = {0, 2, 3, 1};
    reg [7:0] external_data_1 [0:3] = {0, 2, 0, 3};
    reg [7:0] external_data_2 [0:3] = {1, 2, 4, 4};
    reg [7:0] external_data_3 [0:3] = {0, 2, 4, 2};

//    // transposed weights matrix

    reg [7:0] external_data_4 [0:3] = {2, 2, 0, 0};
    reg [7:0] external_data_5 [0:3] = {2, 4, 4, 0};
    reg [7:0] external_data_6 [0:3] = {4, 1, 4, 1};
    reg [7:0] external_data_7 [0:3] = {2, 4, 1, 4};



////////////////////////////////////////////////////////////////////


    initial begin
        #3 en = 1; // enable

        $display("Writing INPUTS to Memory...");
        en = 0;
        write = 1;
        load = 0;
        #2;
        
        
        for(integer register = 0; register < 8; register = register + 1) begin
            
            reg_select = register[2:0];
            for(integer element = 0; element < 4; element = element + 1) begin
                en = 0; #3;
                idx_select = element[1:0];

                case (reg_select)
                    0: data_in = external_data_0[idx_select];
                    1: data_in = external_data_1[idx_select];
                    2: data_in = external_data_2[idx_select];
                    3: data_in = external_data_3[idx_select];
                    4: data_in = external_data_4[idx_select];
                    5: data_in = external_data_5[idx_select];
                    6: data_in = external_data_6[idx_select];
                    7: data_in = external_data_7[idx_select];
                endcase
                en = 1; #3;
                #2;
                  
            end     
        end
        
//        #2;
        
        $display("Loading to REGISTER FILE...");
        en=0;
        write = 0;
        load = 1;
        #2
        en = 1;
        
        while(!interrupt_pin) begin
            #2;
        end

//        #5;

        $display("Doing MATMUL...");
        en = 0;
        write = 0;
        load = 0;
        #2;
        en = 1;
        
        while(!interrupt_pin) begin
            #2;
        end
        

//        #5;

         $display("Reading Results...");
         en = 0;
         write = 1;
         load = 1;
         #2;
         en = 1;
         
         
        for(integer register = 0; register < 4; register = register + 1) begin
            reg_select = register[2:0];
            for(integer element = 0; element < 4; element = element + 1) begin
                en = 0; #3;
                idx_select = element[1:0];
                en = 1; #3;
                #2;                
            end     
        end
        
        
        #5;
        reset = 1;
        #5;
        reset = 0;
        
        external_data_0 [0:3] = {1,2,3,4};
        external_data_1 [0:3] = {1,2,3,4};
        external_data_2 [0:3] = {1,2,3,4};
        external_data_3 [0:3] = {1,2,3,4};


        external_data_4 [0:3] = {1,2,3,4};
        external_data_5 [0:3] = {1,2,3,4};
        external_data_6 [0:3] = {1,2,3,4};
        external_data_7 [0:3] = {1,2,3,4};
    
    

        
        #10;
        
                #3 en = 1; // enable

        $display("Writing INPUTS to Memory...");
        en = 0;
        write = 1;
        load = 0;
        #2;
        
        
        for(integer register = 0; register < 8; register = register + 1) begin
            
            reg_select = register[2:0];
            for(integer element = 0; element < 4; element = element + 1) begin
                en = 0; #3;
                idx_select = element[2:0];
                case (reg_select)
                    0: data_in = external_data_0[idx_select];
                    1: data_in = external_data_1[idx_select];
                    2: data_in = external_data_2[idx_select];
                    3: data_in = external_data_3[idx_select];
                    4: data_in = external_data_4[idx_select];
                    5: data_in = external_data_5[idx_select];
                    6: data_in = external_data_6[idx_select];
                    7: data_in = external_data_7[idx_select];
                endcase
                en = 1; #3;
                  #2;
                  
            end     
        end
        
//        #2;
        
        $display("Loading to REGISTER FILE...");
        en = 0;
        write = 0;
        load = 1;
        #2
        en = 1;
        
        while(!interrupt_pin) begin
            #2;
        end

//        #5;

        $display("Doing MATMUL...");
        en = 0;
        write = 0;
        load = 0;
        #2;
        en = 1;
        
        while(!interrupt_pin) begin
            #2;
        end
        

//        #5;

         $display("Reading Results...");
         en = 0;
         write = 1;
         load = 1;
         #2;
         en = 1;
         
         
        for(integer register = 0; register < 4; register = register + 1) begin
            reg_select = register[3:0];
            for(integer element = 0; element < 4; element = element + 1) begin
                en = 0; #3;
                idx_select = element[1:0];
                en = 1; #3;
                #2;                
            end     
        end
        
        
        
        $display("BYE!");
        $finish; 
    end
    
    
//        input CLK,
//    input RST,
//    input [8:0] AUX,
//    input [15:0] DATA_IN,
//    output [15:0] DATA_OUT,
//    output INTERRUPT_PIN,
//    output READ_LED,
//    output WRITE_LED,
//    output LOAD_LED,
//    output MATMUL_LED
    
//        wire load_buffer = AUX[1];
//    wire write_buffer = AUX[0];
//    wire idx_buffer = AUX[4:2];
//    wire reg_select_buffer = AUX[8:5];
    
        ChipTop top_module_00(
            .en(en),
            .clk(clk),
            .clear(reset),
            .AUX({reg_select, idx_select, load, write}),
            .data_in(data_in),
            .data_out(data_out),
            .INTERRUPT_PIN(interrupt_pin),
            .READ_LED(read_led),
            .WRITE_LED(write_led),
            .LOAD_LED(load_led),
            .MATMUL_LED(matmul_led)
        );

//    FSM top_module_0(
//        .rst(RST),
//        .clk(CLK),
//        .en(EN),
//        .write(WRITE),      
//        .load(LOAD),
//        .idx(IDX_SELECT),
//        .reg_select(REG_SELECT),
//        .data_in(DATA_IN),
//        .data_out(DATA_OUT),
//        .int_to_ps(interrupt_pin),
//        .read_led(read_led),
//        .write_led(write_led),
//        .load_led(load_led),
//        .matmul_led(matmul_led)
//    );

endmodule