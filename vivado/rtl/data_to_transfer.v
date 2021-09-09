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
    input wire [7:0]  board_ID,
    input wire [23:0] points,
    input wire tx_full,
    input wire rx_empty_1, rx_empty_2,
    
    output reg [31:0] tx_data_stack
    );
    
    always@*begin
        if(board_ID != 0) tx_data_stack = {board_ID, points};
        else tx_data_stack = 0;
    end  
  
endmodule
