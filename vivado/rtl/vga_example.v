`timescale 1 ns / 1 ps

module vga_example (
  input wire clk,
  input wire rst, 
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
  );


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

  
  wire vsync, hsync, vsync_out_b, hsync_out_b, vsync_out_r, hsync_out_r, vblnk, hblnk, 
       vblnk_out_b, hblnk_out_b, vblnk_out_r, hblnk_out_r, vblnk_delay, hblnk_delay, 
       vblnk_out_ch, hblnk_out_ch, vblnk_delay_ch, hblnk_delay_ch, vsync_delay, hsync_delay, 
       vsync_delay_r, hsync_delay_r, vsync_out_ch, hsync_out_ch, hsync_delay_th, vsync_delay_th, 
       hsync_delay_ch, vsync_delay_ch;
  
  wire [3:0] char_line;
  wire [6:0] char_code;
  wire [7:0] char_pixels, char_xy;
  wire [10:0] vcount, hcount, hcount_out_b, vcount_out_b, hcount_out_r, vcount_out_r, hcount_out_ch, vcount_out_ch;
  wire [11:0] rgb_out_b, rgb_out_r, rgb_out_ch;
  
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
           
    .hcount_out(hcount_out_r),
    .hsync_out(hsync_out_r),
    .hblnk_out(hblnk_out_r),
    .vcount_out(vcount_out_r),
    .vsync_out(vsync_out_r),
    .vblnk_out(vblnk_out_r),
    .rgb_out(rgb_out_r)
    );

draw_rect_char my_draw_rect_char (
    .rst(rst),
    .pclk(pclk),
    
    .vcount_in(vcount_out_r),
    .vsync_in(vsync_out_r),
    .vblnk_in(vblnk_out_r),
    .hcount_in(hcount_out_r),
    .hsync_in(vsync_out_r),
    .hblnk_in(hblnk_out_r),   
    .rgb_in(rgb_out_r),
    .char_pixels(char_pixels),
           
    .vcount_out(vcount_out_ch),
    .vsync_out(vsync_delay_r),
    .vblnk_out(vblnk_out_ch),
    .hcount_out(hcount_out_ch),
    .hsync_out(hsync_delay_r),
    .hblnk_out(hblnk_out_ch),
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
    .char_code(char_code) 
  );      
  always @(posedge pclk)begin
    hs <= hsync_out_r;
    vs <= vsync_out_r;
    {r,g,b} <= rgb_out_b;
    {r,g,b} <= rgb_out_r;
    {r,g,b} <= rgb_out_ch;
   end

endmodule
