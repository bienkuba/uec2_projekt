// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output reg [10:0] vcount,
  output reg vsync,
  output reg vblnk,
  output reg [10:0] hcount,
  output reg hsync,
  output reg hblnk,
  input wire pclk,
  input wire rst
  );

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.

  localparam HOR_TOTAL_TIME  = 1650;
  localparam HOR_BLANK_START = 1280;
  localparam HOR_BLANK_TIME  = 370;
  localparam HOR_SYNC_START  = 1500; //__________________________________?
  localparam HOR_SYNC_TIME   = 40;

  localparam VER_TOTAL_TIME  = 750;
  localparam VER_BLANK_START = 720;
  localparam VER_BLANK_TIME  = 30;
  localparam VER_SYNC_START  = 725;
  localparam VER_SYNC_TIME   = 5;


  reg [10:0] vcount_nxt = 0;
  reg [10:0] hcount_nxt = 0;
  reg vsync_nxt, vblnk_nxt, hsync_nxt, hblnk_nxt; 
    
  always@* begin
    hcount = hcount_nxt;
    vcount = vcount_nxt;
    vsync  = vsync_nxt;
    vblnk  = vblnk_nxt;
    hsync  = hsync_nxt;
    hblnk  = hblnk_nxt;
  end
 
  always@(posedge pclk or posedge rst)
    if(rst)begin
      vsync_nxt  = 0;
      vblnk_nxt  = 0;
      hblnk_nxt  = 0;
      hsync_nxt  = 0;
      vcount_nxt = 0;
      hcount_nxt = 0;
     end
    else begin
        if (hcount == HOR_TOTAL_TIME-1)begin
            hcount_nxt = -1;
            vcount_nxt = (vcount == VER_TOTAL_TIME - 1) ? 0 : vcount + 1;
            vblnk_nxt  = (vcount >= VER_BLANK_START - 1) && (vcount < VER_BLANK_START + VER_BLANK_TIME - 1);
            vsync_nxt  = (vcount >= VER_SYNC_START - 1) && (vcount < VER_SYNC_TIME + VER_SYNC_START -1);
        end
        else begin
            hcount_nxt = hcount + 1;
            hblnk_nxt  = (hcount > HOR_BLANK_START - 1) && (hcount <= HOR_BLANK_START + HOR_BLANK_TIME - 1);
            hsync_nxt  = (hcount > HOR_SYNC_START - 1) && (hcount <= HOR_SYNC_TIME + HOR_SYNC_START -1);
        end   
    end
endmodule