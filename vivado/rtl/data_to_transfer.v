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
    input wire [1:0]  board_ID,
    input wire [23:0] points,
    
    output reg [7:0] tx_data1,
    output reg [7:0] tx_data2,
    output reg [7:0] tx_data3,
    output reg [7:0] tx_data4
    );
    
    always@*begin
        tx_data1 = board_ID;
        tx_data2 = points[23:16];
        tx_data3 = points[15:8];
        tx_data4 = points[7:0];
        
        
        
    end    
    
endmodule
