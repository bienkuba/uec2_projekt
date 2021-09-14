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
    input wire [7:0] board_ID,
    input wire [23:0] points,
    input wire tx_busy1, tx_busy2,
    
    output reg [7:0] tx_data,
    output reg tx_start1, tx_start2 
);
    
    reg [7:0] tx_data1, tx_data2, tx_data3, tx_data4;
    reg [7:0] tx_data_nxt;
    reg [1:0] UART1_pack_nr, UART2_pack_nr;
    
    always@(posedge clk)begin
        if(rst)begin
            tx_data1 <= 0;
            tx_data2 <= 0;
            tx_data3 <= 0;
            tx_data4 <= 0;
            tx_data <= 0;
        end
        else begin
            tx_data1 <= board_ID[7:0];
            tx_data2 <= points[23:16];
            tx_data3 <= points[15:8];
            tx_data4 <= points[7:0];
            tx_data <= tx_data_nxt;
        end
    end
    
     always@*begin
        if(board_ID != 0)begin
            if(tx_busy1 == 0)begin
                if(UART1_pack_nr == 0)begin
                    tx_data_nxt = tx_data1;
                    tx_start1 = 1;
                    UART1_pack_nr = 1;
                end
                else if(UART1_pack_nr == 1)begin
                    tx_data_nxt = tx_data2;
                    tx_start1 = 1;
                    UART1_pack_nr = 2;
                end
                else if(UART1_pack_nr == 2)begin
                    tx_data_nxt = tx_data3;
                    tx_start1 = 1;
                    UART1_pack_nr = 3;
                end
                else begin
                    tx_data_nxt = tx_data4;
                    tx_start1 = 1;
                    UART1_pack_nr = 0;
                end
            end
            else tx_start1 = 0;
                
            if(tx_busy2 == 0)begin
                if(UART2_pack_nr == 0)begin
                    tx_data_nxt = tx_data1;
                    tx_start2 = 1;
                    UART2_pack_nr = 1;
                end
                else if(UART2_pack_nr == 1)begin
                    tx_data_nxt = tx_data2;
                    tx_start2 = 1;
                    UART2_pack_nr = 2;
                end
                else if(UART2_pack_nr == 2)begin
                    tx_data_nxt = tx_data3;
                    tx_start2 = 1;
                    UART2_pack_nr = 3;
                end
                else begin
                    tx_data_nxt = tx_data4;
                    tx_start2 = 1;
                    UART2_pack_nr = 0;
                end
            end
            else tx_start2 = 0;    
        end
        else
            tx_data_nxt = 8'hFF; 
        
    end
endmodule
