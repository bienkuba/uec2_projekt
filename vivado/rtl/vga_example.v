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
  input wire pad_R,
  input wire pad_L,
  input wire pad_U,
  input wire pad_D,
  input wire pad_S,
  input wire btnL,
  input wire btnR,
  input wire btnD,
  input wire btnU,
  input wire rx1, rx2,
  output wire tx1, tx2,
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
    
  localparam WIDTH = 16;

  wire        collision, lock_en;
  wire        vsync, hsync, vsync_out_b, hsync_out_b, vsync_out_r, hsync_out_r, vsync_out_f, hsync_out_f, vsync_out_nb, hsync_out_nb, vsync_out_ch, hsync_out_ch;
  wire        vblnk, hblnk, vblnk_out_b, hblnk_out_b, vblnk_out_r, hblnk_out_r, vblnk_out_f, hblnk_out_f, vblnk_out_nb, hblnk_out_nb, vblnk_out_ch, hblnk_out_ch;
  wire [1:0]  rot_ctl;
  wire [3:0]  xpos_ctl, char_line, level_f;
  wire [3:0]  sq_1_col_r, sq_2_col_r, sq_3_col_r, sq_4_col_r, sq_1_col_ctl, sq_2_col_ctl, sq_3_col_ctl, sq_4_col_ctl;
  wire [4:0]  sq_1_row_r, sq_2_row_r, sq_3_row_r, sq_4_row_r, sq_1_row_ctl, sq_2_row_ctl, sq_3_row_ctl, sq_4_row_ctl;
  wire [4:0]  random_out, block_ctl, buf_block_ctl, ypos_ctl;
  wire [6:0]  char_code;
  wire [7:0]  char_pixels, char_xy;
  wire [10:0] vcount, hcount, hcount_out_b, vcount_out_b, hcount_out_r, vcount_out_r, hcount_out_f, vcount_out_f, hcount_out_nb, vcount_out_nb, hcount_out_ch, vcount_out_ch;
  wire [11:0] rgb_out_b, rgb_out_r, rgb_out_f, rgb_out_nb, rgb_out_ch;
  wire [19:0] points_ctl, points_f;
  wire [23:0] BCD_out;
  
  reg [7:0] data = 0;
  wire [7:0] dout;
  reg enable = 0;
  
  wire tx_busy;
  wire rdy;
  reg rdy_clr = 0;
  
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
    .hcount_in(hcount_out_nb),
    .hsync_in(hsync_out_nb),
    .hblnk_in(hblnk_out_nb),
    .vcount_in(vcount_out_nb),
    .vsync_in(vsync_out_nb),
    .vblnk_in(vblnk_out_nb),
    .pclk(pclk),
    .rgb_in(rgb_out_nb),
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

  randomizer my_randomizer (
    .pclk(pclk),
    .random(random_out)
   );

  draw_rect_ctl my_rect_ctl(
    .pclk(pclk),
    .rst(rst),
    .pad_R(pad_R),
    .pad_L(pad_L),
    .pad_U(pad_U),
    .pad_D(pad_D),
    .pad_S(pad_S),
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD),
    .btnU(btnU),
    .sq_1_col(sq_1_col_r),
    .sq_2_col(sq_2_col_r),
    .sq_3_col(sq_3_col_r),
    .sq_4_col(sq_4_col_r),
    .collision(collision),
    .random(random_out),
    .level(level_f),
    
    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .block(block_ctl),
    .buf_block(buf_block_ctl),
    .rot(rot_ctl),
    .lock_en(lock_en),
    .points(points_ctl)
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
    .points_in(points_ctl),
        
    .hcount_out(hcount_out_f),
    .hsync_out(hsync_out_f),
    .hblnk_out(hblnk_out_f),
    .vcount_out(vcount_out_f),
    .vsync_out(vsync_out_f),
    .vblnk_out(vblnk_out_f),
    .rgb_out(rgb_out_f),
    .collision(collision),
    .points_out(points_f),
    .level(level_f)
    );
  
  draw_nxt_block my_draw_nxt_block (
    .hcount_in(hcount_out_b),
    .hsync_in(hsync_out_b),
    .hblnk_in(hblnk_out_b),
    .vcount_in(vcount_out_b),
    .vsync_in(vsync_out_b),
    .vblnk_in(vblnk_out_b),
    .pclk(pclk),
    .rgb_in(rgb_out_b),
    .rst(rst),
    .buf_block(buf_block_ctl),
      
    .hcount_out(hcount_out_nb),
    .hsync_out(hsync_out_nb),
    .hblnk_out(hblnk_out_nb),
    .vcount_out(vcount_out_nb),
    .vsync_out(vsync_out_nb),
    .vblnk_out(vblnk_out_nb),
    .rgb_out(rgb_out_nb)
     );

draw_rect_char my_draw_rect_char (
    .rst(rst),
    .pclk(pclk),
    
    .vcount_in(vcount_out_f),
    .vsync_in(vsync_out_f),
    .vblnk_in(vblnk_out_f),
    .hcount_in(hcount_out_f),
    .hsync_in(vsync_out_f),
    .hblnk_in(hblnk_out_f),   
    .rgb_in(rgb_out_f),
    .char_pixels(char_pixels),
           
    //.vcount_out(vcount_out_ch),
    .vsync_out(vsync_out_ch),
    //.vblnk_out(vblnk_out_ch),
    //.hcount_out(hcount_out_ch),
    .hsync_out(hsync_out_ch),
    //.hblnk_out(hblnk_out_ch),
    .char_line(char_line),  
    .char_xy(char_xy),
    .rgb_out(rgb_out_ch)   
  );      

  font_rom my_font_rom(
    .clk(pclk),
    .addr({char_code, char_line}),
          
    .char_line_pixels(char_pixels)
  );
  
  char_rom_16x16 my_char_rom(
    .char_xy(char_xy),
    .points(BCD_out),
    
    .char_code(char_code)
  );
  
  bin_to_BCD_converter my_bin_to_BCD_converter(
    .bin(points_f),    
      
    .BCD(BCD_out)
   );
 
uart uart_1(
    .din(BCD_out),
    .pclk(pclk),
    .rdy_clr(rdy_clr),
    .tx(tx1),
    .tx_busy(tx_busy),
    .rx(rx1),
    .rdy(rdy),
    .dout(dout)
);

uart uart_2(
    .din(BCD_out),
    .pclk(pclk),
    .rdy_clr(rdy_clr),
    .tx(tx2),
    .tx_busy(tx_busy),
    .rx(rx2),
    .rdy(rdy),
    .dout(dout)
);

  always @(posedge pclk)begin
    hs <= hsync_out_f;
    vs <= vsync_out_f;
    {r,g,b} <= rgb_out_b;
    {r,g,b} <= rgb_out_nb;
    {r,g,b} <= rgb_out_r;
    {r,g,b} <= rgb_out_f;
    {r,g,b} <= rgb_out_ch;
   end

endmodule
