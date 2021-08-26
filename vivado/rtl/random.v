`timescale 1ns / 1ps

module randomizer (
    input wire       pclk,
    output reg [4:0] random
    );

    initial begin
        random = 5'b10000;
    end

    always @ (posedge pclk) begin
        if (random == 5'b10110) begin
            random <= 5'b10000;
        end 
        else begin
            random <= random + 1;
        end
    end
endmodule