`timescale 1ns / 1ps

module slowe_clock_4Hz(
    input clk_in,
    output reg clk_out
);
    reg [25:0] count = 0;
    reg clk_out_nxt;

    always @* begin
       clk_out <= clk_out_nxt;
    end
    
    always @(posedge clk_in) begin
        count <= count+1;
        if (count == 9_375_000) begin
            count <= 0;
            clk_out_nxt = ~clk_out;
        end
    end

endmodule