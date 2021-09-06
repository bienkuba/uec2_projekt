`timescale 1ns / 1ps

module bin_to_BCD_converter(
    input wire [19:0] bin,    
    output reg [23:0] BCD 
    );
    
    integer i;
    
    always @* begin
      BCD = 0;             
      for (i = 0; i < 20; i = i+1) begin
        if (BCD[3:0] >= 5) BCD[3:0] = BCD[3:0] + 3;
        if (BCD[7:4] >= 5) BCD[7:4] = BCD[7:4] + 3;
        if (BCD[11:8] >= 5) BCD[11:8] = BCD[11:8] + 3;
        if (BCD[15:12] >= 5) BCD[15:12] = BCD[15:12] + 3;
        if (BCD[19:16] >= 5) BCD[19:16] = BCD[19:16] + 3;
        if (BCD[23:20] >= 5) BCD[23:20] = BCD[23:20] + 3;
      BCD = {BCD[22:0],bin[19-i]};
      end
    end
    endmodule