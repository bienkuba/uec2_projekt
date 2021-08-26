`timescale 1ns / 1ps

module d_ff (
    input clk, //input slow clock
    input D, //buttons
    output reg Q
);
    
    always @(posedge clk) begin
        Q <= D;
    end

endmodule