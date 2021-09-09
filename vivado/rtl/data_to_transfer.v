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
    input wire tx_full_1,
    input wire tx_full_2,
    input wire rx_empty_1, rx_empty_2,
    
    output reg [7:0] tx_data,
    output reg wr_en
    );
    
    reg [7:0] tx_data1, tx_data2, tx_data3, tx_data4;
    reg [1:0] UART1_pack_nr, UART2_pack_nr;
    
    always@*begin
    tx_data1 = board_ID;
    tx_data2 = points[23:16];
    tx_data3 = points[15:8];
    tx_data4 = points[7:0];
    
    if(board_ID != 0)begin
        if(tx_full_1 == 0)begin
            if(UART1_pack_nr == 0)begin
                tx_data = tx_data1;
                wr_en = 1;
                UART1_pack_nr = 1;
            end
            else if(UART1_pack_nr == 1)begin
                tx_data = tx_data2;
                wr_en = 1;
                UART1_pack_nr = 2;
            end
            else if(UART1_pack_nr == 2)begin
                tx_data = tx_data3;
                wr_en = 1;
                UART1_pack_nr = 3;
            end
            else begin
                tx_data = tx_data4;
                wr_en = 1;
                UART1_pack_nr = 0;
            end
        end
        else wr_en = 0;
            
        if(tx_full_2 == 0)begin
            if(UART2_pack_nr == 0)begin
                tx_data = tx_data1;
                wr_en = 1;
                UART2_pack_nr = 1;
            end
            else if(UART2_pack_nr == 1)begin
                tx_data = tx_data2;
                wr_en = 1;
                UART2_pack_nr = 2;
            end
            else if(UART2_pack_nr == 2)begin
                tx_data = tx_data3;
                wr_en = 1;
                UART2_pack_nr = 3;
            end
            else begin
                tx_data = tx_data4;
                wr_en = 1;
                UART2_pack_nr = 0;
            end
        end
        else wr_en = 0;    
    end    
    end  
endmodule
