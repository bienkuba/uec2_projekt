`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2021 13:15:24
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char(
 input wire rst,
 input wire pclk,
 
 input wire [10:0] vcount_in,
 input wire vsync_in,
 input wire vblnk_in,
 input wire [10:0] hcount_in,
 input wire hsync_in,
 input wire hblnk_in,
 input wire [11:0] rgb_in,
 input wire [7:0] char_pixels,
 
 //output reg [10:0] vcount_out,
 output reg vsync_out,
 //output reg vblnk_out,
 //output reg [10:0] hcount_out,
 output reg hsync_out,
 //output reg hblnk_out,
 output reg [11:0] rgb_out,
 output reg [7:0]  char_xy, 
 output reg [3:0]  char_line
 //output reg [10:0] addr
 );
 
 localparam COLOR  = 12'h0_9_9;

 localparam BACKGROUND = 12'h3_3_f; 
 localparam LETTERS_COLOR = 12'ha_b_c;
 localparam XPOS = 570, YPOS = 400;
 
 reg [10:0] addrx, addry;
 reg [11:0] rgb_out_nxt;
          
 always@(posedge pclk)begin
   if (rst) begin
     rgb_out    <= 0;
     hsync_out  <= 0;
     vsync_out  <= 0;
//     hblnk_out  <= 0;
//     vblnk_out  <= 0;          
//     hcount_out <= 0;
//     vcount_out <= 0;
   end
   else begin
     hsync_out  <= hsync_in;
     vsync_out  <= vsync_in;
//     hblnk_out  <= hblnk_in;
//     vblnk_out  <= vblnk_in;  
//     hcount_out <= hcount_in;
//     vcount_out <= vcount_in;
     rgb_out    <= rgb_out_nxt;
   end
 end 
         
  always @*begin
  // During blanking, paint it black. 
    if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
    
    else begin
      if ((vcount_in >= YPOS && vcount_in <= 16*4 + YPOS) && (hcount_in >= XPOS && hcount_in <= 128 + XPOS))begin
        if (char_pixels[4'b1000-addrx[2:0]])
          rgb_out_nxt = LETTERS_COLOR;
        else
          rgb_out_nxt = BACKGROUND;
        end
      else
        rgb_out_nxt = rgb_in;
      end
    end
 
   always@* begin
     addry     = vcount_in - YPOS;
     addrx     = hcount_in - XPOS;
     char_xy   = {addry[7:4], addrx[6:3]};
     char_line = addry[3:0];
   end   
    
    
endmodule  