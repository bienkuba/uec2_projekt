// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (
  input wire clk,
  input wire rst,
  input wire btnL,
  input wire btnR,
  input wire btnD,
  input wire btnU,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  wire clkfb;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;

  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.
  
  wire mclk;
  clk_wiz_0 clk_wiz_0_my(
      .clk(clk),
      .clk75MHz(pclk),
      .clk100MHz(mclk),
      .reset(rst),
      .locked(locked)
    );

  wire [10:0] vcount, hcount, hcount_out_b, vcount_out_b, hcount_out_r, vcount_out_r;
  wire vsync, hsync, vsync_out_b, hsync_out_b, vsync_out_r, hsync_out_r;
  wire vblnk, hblnk, vblnk_out_b, hblnk_out_b, vblnk_out_r, hblnk_out_r;
  wire [2:0] rot_ctl, block_ctl;
  wire [11:0] rgb_out_b, rgb_out_r, xpos_ctl, ypos_ctl;
  wire btnD_d, btnD_u, btnD_l, btnD_r;


  vga_timing my_timing (
    .vcount(vcount),
    .rst(rst),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk)
  );

  draw_background my_background (
    .hcount_in(hcount),
    .hsync_in(hsync),
    .hblnk_in(hblnk),
    .vcount_in(vcount),
    .vsync_in(vsync),
    .vblnk_in(vblnk),
    .pclk(pclk),
    .rst(rst),
      
    .hcount_out(hcount_out_b),
    .hsync_out(hsync_out_b),
    .hblnk_out(hblnk_out_b),
    .vcount_out(vcount_out_b),
    .vsync_out(vsync_out_b),
    .vblnk_out(vblnk_out_b),
    .rgb_out(rgb_out_b)
    );
     
     
  draw_rect my_draw_rect (
    .hcount_in(hcount_out_b),
    .hsync_in(hsync_out_b),
    .hblnk_in(hblnk_out_b),
    .vcount_in(vcount_out_b),
    .vsync_in(vsync_out_b),
    .vblnk_in(vblnk_out_b),
    .rgb_in(rgb_out_b),
    .pclk(pclk),
    .rst(rst),
    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .block(block_ctl),
    .rot(rot_ctl),
          
    .hcount_out(hcount_out_r),
    .hsync_out(hsync_out_r),
    .hblnk_out(hblnk_out_r),
    .vcount_out(vcount_out_r),
    .vsync_out(vsync_out_r),
    .vblnk_out(vblnk_out_r),
    .rgb_out(rgb_out_r)
    );

  debounce my_debounce (
    .pb_d(btnD),
    .pb_u(btnU),
    .pb_l(btnL),
    .pb_r(btnR),
    .clk_in(pclk),
    .rect_down(btnD_d),
    .rect_up(btnD_u),
    .rect_right(btnD_r),
    .rect_left(btnD_l)
);

  draw_rect_ctl my_rect_ctl(
    .pclk(pclk),
    .rst(rst),       
    .btnL(btnD_l),
    .btnR(btnD_r),
    .btnD(btnD_d),
    .btnU(btnD_u),
    
    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .block(block_ctl),
    .rot(rot_ctl)
  );
  

  always @(posedge pclk)begin
    hs <= hsync_out_r;
    vs <= vsync_out_r;
    {r,g,b} <= rgb_out_b;
    {r,g,b} <= rgb_out_r;
   end

endmodule
