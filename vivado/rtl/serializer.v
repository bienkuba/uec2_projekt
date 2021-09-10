module serializer(
    input wire clk,
    input wire [31:0] data_32,
    output reg [7:0] data_8
    );

    reg [1:0] counter = 2'b00;
    always @(posedge clk)
      counter <= counter + 1;

    always @* begin
      case (counter)
        2'd0: data_8 = data_32[7:0];
        2'd1: data_8 = data_32[15:8];
        2'd2: data_8 = data_32[23:16];
        2'd3: data_8 = data_32[31:24];
        default: data_8 = 8'h00;
      endcase
    end
endmodule
