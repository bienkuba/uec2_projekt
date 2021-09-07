`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2021 17:27:57
// Design Name: 
// Module Name: board_ID
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


module board_ID(
    input wire       lock_ID_en,
    input wire       external_ID_1,
    input wire       external_ID_2,
    
    output reg [1:0] board_ID,
    output reg       ID_1_occupied, 
    output reg       ID_2_occupied
    );
    
    reg ID_reserved;
    
    always@*begin
        if(external_ID_1) ID_1_occupied = 1;
        if(external_ID_2) ID_2_occupied = 1;
        if(lock_ID_en && !ID_reserved)begin
            if(!ID_1_occupied && !ID_2_occupied)begin 
                board_ID = 2'b01;
                ID_1_occupied = 1;
                ID_reserved = 1;
            end
            else if(ID_1_occupied && !ID_2_occupied) begin
                board_ID = 2'b10;
                ID_2_occupied = 1;
                ID_reserved = 1;
            end
            else begin
                board_ID = 2'b11;
                ID_reserved = 1;
            end
        end
    end
    
endmodule
