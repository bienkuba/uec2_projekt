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
  /*  
  
   input 

    output 31:0 ext_data
    
    reg 7:0 data1, data2 data3 data4
    reg 7:0 data1, data2 data3 data4_nxt
    reg 31:0 ext_data_nxt
    
    always sequential
    end
    
    always@
    if(data1 == 0) data1_nxt = input
    else if( data2 == 0) data1_nxt = input
    else if( data3 == 0) data1_nxt = input
    else( data4 == 0) data1_nxt = input
    if(data4 != 0) begin
    ext_data_nxt = {data1, data2, data3, data4}
    data1 = 0
    data2 = 0
    else ext_data_nxt = ext_data
    ..
    */
endmodule
