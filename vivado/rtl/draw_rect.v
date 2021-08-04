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
  
  localparam X_POSITION = 20;
  localparam Y_POSITION = 20;
  localparam WIDTH      = 50;
  localparam HEIGHT     = 50;
  localparam COLOR      = 12'hf_b_5;
    
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
          if (vcount_in <= WIDTH + Y_POSITION && vcount_in >= Y_POSITION && hcount_in <= HEIGHT + X_POSITION && hcount_in >= X_POSITION) rgb_out_nxt = COLOR;
            else rgb_out_nxt = rgb_in;
          end
      end
        
endmodule