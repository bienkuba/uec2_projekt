`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 11:18:13
// Design Name: 
// Module Name: draw_rect
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


module draw_rect(

 input wire [10:0] vcount_in,
 input wire vsync_in,
 input wire vblnk_in,
 input wire [10:0] hcount_in,
 input wire hsync_in,
 input wire hblnk_in,
 input wire pclk,
 input wire [11:0] rgb_in,
 input wire rst,
 
 output reg [10:0] vcount_out,
 output reg vsync_out,
 output reg vblnk_out,
 output reg [10:0] hcount_out,
 output reg hsync_out,
 output reg hblnk_out,
 output reg [11:0] rgb_out
 );
  
  localparam x = 9; //from 0 to 9
  localparam y = 19; //from 0 to 19
  localparam X_POS = 201+35*x;
  localparam Y_POS = 10+35*y;
  localparam SIZE  = 35;
  localparam COLOR = 12'hf_0_0;
    
  reg [11:0] rgb_out_nxt;
           
  always@(posedge pclk or posedge rst)begin
    if (rst) begin
      rgb_out    <= 0;
      hsync_out  <= 0;
      vsync_out  <= 0;
      hblnk_out  <= 0;
      vblnk_out  <= 0;          
      hcount_out <= 0;
      vcount_out <= 0;
    end
    else begin
      hsync_out  <= hsync_in;
      vsync_out  <= vsync_in;
      hblnk_out  <= hblnk_in;
      vblnk_out  <= vblnk_in;  
      hcount_out <= hcount_in;
      vcount_out <= vcount_in;
      rgb_out    <= rgb_out_nxt;
    end
  end 
                
  always @*
    begin
      if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
        else begin
          // left and top edge -> bright
          if      (vcount_in >= Y_POS     && vcount_in < SIZE + Y_POS - 1 && hcount_in == X_POS)            rgb_out_nxt = 12'hf_a_b; 
          else if (vcount_in >= Y_POS     && vcount_in < SIZE + Y_POS - 2 && hcount_in == X_POS + 1)        rgb_out_nxt = 12'hf_a_b; 
          else if (vcount_in >= Y_POS     && vcount_in < SIZE + Y_POS - 3 && hcount_in == X_POS + 2)        rgb_out_nxt = 12'hf_a_b;
          else if (vcount_in == Y_POS     && hcount_in > X_POS             && hcount_in < SIZE + X_POS - 1) rgb_out_nxt = 12'hf_a_b;
          else if (vcount_in == Y_POS + 1 && hcount_in > X_POS             && hcount_in < SIZE + X_POS - 2) rgb_out_nxt = 12'hf_a_b;
          else if (vcount_in == Y_POS + 2 && hcount_in > X_POS             && hcount_in < SIZE + X_POS - 3) rgb_out_nxt = 12'hf_a_b;
          // right and bottom edge -> dark
          else if (vcount_in >= Y_POS + 1        && vcount_in < SIZE + Y_POS && hcount_in == X_POS + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
          else if (vcount_in >= Y_POS + 2        && vcount_in < SIZE + Y_POS && hcount_in == X_POS + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
          else if (vcount_in >= Y_POS + 3        && vcount_in < SIZE + Y_POS && hcount_in == X_POS + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
          else if (vcount_in == Y_POS + SIZE - 1 && hcount_in > X_POS         && hcount_in < SIZE + X_POS)     rgb_out_nxt = 12'h8_0_0;
          else if (vcount_in == Y_POS + SIZE - 2 && hcount_in > X_POS + 1     && hcount_in < SIZE + X_POS)     rgb_out_nxt = 12'h8_0_0;
          else if (vcount_in == Y_POS + SIZE - 3 && hcount_in > X_POS + 2     && hcount_in < SIZE + X_POS)     rgb_out_nxt = 12'h8_0_0;          
          // inside color
          else if (vcount_in >= Y_POS && vcount_in < SIZE + Y_POS && hcount_in >= X_POS && hcount_in < SIZE + X_POS) rgb_out_nxt = COLOR;
            else rgb_out_nxt = rgb_in;
          end
      end
        
endmodule