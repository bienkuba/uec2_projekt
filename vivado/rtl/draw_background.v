`timescale 1ns / 1ps

  module draw_background(
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire pclk,
    input wire rst,
 
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out
    );
    
  reg [11:0] rgb_out_nxt = 0;
       
  always@(posedge pclk or posedge rst)begin
    if(rst)begin
      rgb_out    <= 0;
      hsync_out  <= 0;
      vsync_out  <= 0;
      hblnk_out  <= 0;
      vblnk_out  <= 0;
      hcount_out <= 0;
      vcount_out <= 0;
      end
      else begin
      rgb_out    <= rgb_out_nxt;
      hsync_out  <= hsync_in;
      vsync_out  <= vsync_in;
      hblnk_out  <= hblnk_in;
      vblnk_out  <= vblnk_in;
      vcount_out <= vcount_in;
      hcount_out <= hcount_in;
    end
  end
 
  always @(posedge pclk)begin
    // During blanking, make it it black.
    if (vblnk_in || hblnk_in) rgb_out_nxt <= 12'h0_0_0; 
    else begin
      // guide net      
           if (hcount_in == 235) rgb_out_nxt <= 12'h0_f_0;
      else if (hcount_in == 270) rgb_out_nxt <= 12'h0_f_0;
      else if (hcount_in == 200+315) rgb_out_nxt <= 12'h0_f_0;
      else if (vcount_in == 45) rgb_out_nxt <= 12'hf_f_0;
      else if (vcount_in == 80) rgb_out_nxt <= 12'hf_f_0;
      else if (vcount_in == 10+665) rgb_out_nxt <= 12'hf_f_0;
      // frame bright part
      else if (hcount_in >= 190 && hcount_in <= 191) rgb_out_nxt <= 12'ha_a_a;
      else if ((hcount_in >= 550 && hcount_in <= 551) && (vcount_in >= 10 && vcount_in <= 710)) rgb_out_nxt <= 12'ha_a_a;      
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 0 && vcount_in <= 1)) rgb_out_nxt <= 12'ha_a_a;
      else if ((hcount_in >= 200 && hcount_in <= 551) && (vcount_in >= 710 && vcount_in <= 711)) rgb_out_nxt <= 12'ha_a_a;
      // frame dark part
      else if ((hcount_in >= 198 && hcount_in <= 199) && (vcount_in >= 10 && vcount_in <= 710)) rgb_out_nxt <= 12'h6_6_6;
      else if (hcount_in >= 559 && hcount_in <= 560) rgb_out_nxt <= 12'h6_6_6;      
      else if ((hcount_in >= 199 && hcount_in <= 550) && (vcount_in >= 8 && vcount_in <= 9)) rgb_out_nxt <= 12'h6_6_6;
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 718 && vcount_in <= 719)) rgb_out_nxt <= 12'h6_6_6;
      // basic frame of game area
      else if (hcount_in >= 190 && hcount_in <= 199) rgb_out_nxt <= 12'h8_8_8; 
      else if (hcount_in >= 550 && hcount_in <= 560) rgb_out_nxt <= 12'h8_8_8;
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 0 && vcount_in <= 9)) rgb_out_nxt <= 12'h8_8_8;
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 710 && vcount_in <= 719)) rgb_out_nxt <= 12'h8_8_8;
      // game area background
      else if ((hcount_in >= 200 && hcount_in <= 549) && (vcount_in >= 10 && vcount_in <= 710)) rgb_out_nxt <= 12'h0_0_0;   
      
      
      // ____________________________________________________DELETE LATER 
      // Active display, top edge, make a yellow line.
      else if (vcount_in == 0) rgb_out_nxt <= 12'hf_f_0;
      // Active display, bottom edge, make a red line.
      else if (vcount_in == 719) rgb_out_nxt <= 12'hf_0_0;
      // Active display, left edge, make a green line.
      else if (hcount_in == 0) rgb_out_nxt <= 12'h0_f_0;
      // Active display, right edge, make a blue line.
      else if (hcount_in == 1279) rgb_out_nxt <= 12'h0_0_f;
      // Active display, interior, fill with gray.  
      //_____________________________________________________DELETE LATER 
      else rgb_out_nxt <= 12'h1_9_f;  
    end
  end
            
            
endmodule