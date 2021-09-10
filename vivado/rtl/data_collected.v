`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2021 19:48:49
// Design Name: 
// Module Name: data_to_transfer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_to_transfer(
    input wire clk,
    input wire rst,
    input wire [7:0]  c_data_in1,
    input wire [7:0]  c_data_in2,
    
    output reg [31:0] c_data_out1,
    output reg [31:0] c_data_out2,
    );

    reg [1:0] counter = 2'b00;
    always @(posedge clk)
      counter <= counter + 1;
    
    always @* begin
      case (counter)
        2'd0: c_data_out1[7:0] = c_data_in1;
        2'd1: c_data_out1[15:8] = c_data_in1;
        2'd2: c_data_out1[23:16] = c_data_in1;
        2'd3: c_data_out1[31:24] = c_data_in1;
        default: c_data_out1= 8'h00;
      endcase
    end

endmodule
