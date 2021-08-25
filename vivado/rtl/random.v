`timescale 1 ns / 1 ps

module random (
    input wire       pclk,
    output reg [4:0] random
    );

    initial begin
        random = 16;
    end

    always @ (posedge pclk) begin
        if (random == 22) begin
            random <= 16;
        end 
        else begin
            random <= random + 1;
        end
    end
endmodule