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

  //wire        btnL, btnR, btnD, btnU;
  wire        collision, lock_en;
  wire        vsync, hsync, vsync_out_b, hsync_out_b, vsync_out_r, hsync_out_r, vsync_out_f, hsync_out_f;
  wire        vblnk, hblnk, vblnk_out_b, hblnk_out_b, vblnk_out_r, hblnk_out_r, vblnk_out_f, hblnk_out_f;
  wire [1:0]  rot_ctl;
  wire [4:0]  sq_1_col_r, sq_1_row_r, sq_2_col_r, sq_2_row_r, sq_3_col_r, sq_3_row_r, sq_4_col_r, sq_4_row_r;
  wire [4:0]  sq_1_col_ctl, sq_1_row_ctl, sq_2_col_ctl, sq_2_row_ctl, sq_3_col_ctl, sq_3_row_ctl, sq_4_col_ctl, sq_4_row_ctl, block_ctl, xpos_ctl, ypos_ctl;
  wire [10:0] vcount, hcount, hcount_out_b, vcount_out_b, hcount_out_r, vcount_out_r, hcount_out_f, vcount_out_f;
  wire [11:0] rgb_out_b, rgb_out_r, rgb_out_f;


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
    .pclk(pclk),
    .rgb_in(rgb_out_b),
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
    .rgb_out(rgb_out_r),
    .sq_1_col(sq_1_col_r),
    .sq_1_row(sq_1_row_r),
    .sq_2_col(sq_2_col_r),
    .sq_2_row(sq_2_row_r),
    .sq_3_col(sq_3_col_r),
    .sq_3_row(sq_3_row_r),
    .sq_4_col(sq_4_col_r),
    .sq_4_row(sq_4_row_r)
    );

//  debounce_d my_d (
//    .pb_d(btnD),
//    .clk_in(pclk),
//    .rect_down(btnD_d)
//  );

//  debounce_l my_l (
//    .pb_l(btnL),
//    .clk_in(pclk),
//    .rect_left(btnD_l)
//  );

//  debounce_r my_r (
//    .pb_r(btnR),
//    .clk_in(pclk),
//    .rect_right(btnD_r)
//  );

//  debounce_u my_u (
//    .pb_u(btnU),
//    .clk_in(pclk),
//    .rect_up(btnD_u)
//  );



  draw_rect_ctl my_rect_ctl(
    .pclk(pclk),
    .rst(rst),       
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD),
    .btnU(btnU),
    .sq_1_col(sq_1_col_r),
    .sq_2_col(sq_2_col_r),
    .sq_3_col(sq_3_col_r),
    .sq_4_col(sq_4_col_r),
    .collision(collision),
    
    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .block(block_ctl),
    .rot(rot_ctl),
    .lock_en(lock_en)
  );
  
  fallen_blocks my_fallen_blocks (
    .hcount_in(hcount_out_r),
    .hsync_in(hsync_out_r),
    .hblnk_in(hblnk_out_r),
    .vcount_in(vcount_out_r),
    .vsync_in(vsync_out_r),
    .vblnk_in(vblnk_out_r),
    .rgb_in(rgb_out_r),
    .pclk(pclk),
    .rst(rst),
    .sq_1_col(sq_1_col_r),
    .sq_1_row(sq_1_row_r),
    .sq_2_col(sq_2_col_r),
    .sq_2_row(sq_2_row_r),
    .sq_3_col(sq_3_col_r),
    .sq_3_row(sq_3_row_r),
    .sq_4_col(sq_4_col_r),
    .sq_4_row(sq_4_row_r),
    .lock_en(lock_en),
        
    .hcount_out(hcount_out_f),
    .hsync_out(hsync_out_f),
    .hblnk_out(hblnk_out_f),
    .vcount_out(vcount_out_f),
    .vsync_out(vsync_out_f),
    .vblnk_out(vblnk_out_f),
    .rgb_out(rgb_out_f),
    .collision(collision)
    );


  always @(posedge pclk)begin
    hs <= hsync_out_f;
    vs <= vsync_out_f;
    {r,g,b} <= rgb_out_b;
    {r,g,b} <= rgb_out_r;
    {r,g,b} <= rgb_out_f;
   end

endmodule
