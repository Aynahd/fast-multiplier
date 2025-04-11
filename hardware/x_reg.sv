`timescale 1ns / 1ps

// Parallel Shifting Register --> Replace FIFOs

module x_reg(clk, enable, write, idx, din, dout);
    input           clk;
    input           enable;

    input           write;         // When en && !write, every clock cycle, spit data

    input   [4:0]   idx;           // Absolute index
    input   [7:0]  din;
    output  [7:0]  dout;
    reg     [7:0] pipe [0:7];    // max pipelining stages 2N - 2, safer 8
    reg     [7:0]  dout_buffer = 0;

    initial begin
        // Initialize memory 
        for (integer i = 0; i < 7; i = i + 1) begin
            pipe[i] = 0;
        end
    end

    // Data Sampling (in reg)
    always @(posedge clk) begin
        if (en) begin
            if (write) begin
                pipe[idx] <= din;
            end else begin
                dout_buffer <= pipe[0];

                for (integer i = 0; i < 6; i = i + 1) begin
                    pipe[i] <= pipe[i+1];
                end

                pipe[6] <= 0;
            end
        end
    end

    // Output register
    assign dout = dout_buffer;

endmodule
