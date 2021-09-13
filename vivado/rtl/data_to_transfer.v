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
    
    output reg [7:0] tx_data
);
    
    reg [7:0] tx_data1, tx_data2, tx_data3, tx_data4;
    reg [1:0] UART_pack;
    
    always@(posedge clk)begin
        if(rst)begin
            tx_data1 <= 0;
            tx_data2 <= 0;
            tx_data3 <= 0;
            tx_data4 <= 0;    
        end
        else begin
            tx_data1 <= board_ID[7:0];
            tx_data2 <= points[23:16];
            tx_data3 <= points[15:8];
            tx_data4 <= points[7:0];
        end
    end
    
    always@*begin     
        if(board_ID != 0)begin
            if(UART_pack == 0)begin
                tx_data = tx_data1;
                UART_pack = 1;
            end
            else if(UART_pack == 1)begin
                tx_data = tx_data2;
                UART_pack = 2;
            end
            else if(UART_pack == 2)begin
                tx_data = tx_data3;
                UART_pack = 3;
            end
            else begin
                tx_data = tx_data4;
                UART_pack = 0;    
            end
            end       
        else
            tx_data = 8'hFF;   
        end
endmodule
