`timescale 1 ns / 1 ps

module tetris (
  input wire clk,
  input wire rst,
  input wire pad_R,
  input wire pad_L,
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

  wire locked;
  wire pclk;

  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );


  wire reset;
  clock my_clock(
      .clk(clk),
      .clk75MHz(pclk),
      .reset(reset),
      .locked(locked)
    );
    
  localparam WIDTH = 16;

  wire        collision, lock_en, lock_ID_en, ID_1_occupied, ID_2_occupied;
  wire        vsync, hsync, vsync_out_b, hsync_out_b, vsync_out_r, hsync_out_r, vsync_out_f, hsync_out_f, vsync_out_nb, hsync_out_nb, vsync_out_ch, hsync_out_ch;
  wire        vblnk, hblnk, vblnk_out_b, hblnk_out_b, vblnk_out_r, hblnk_out_r, vblnk_out_f, hblnk_out_f, vblnk_out_nb, hblnk_out_nb, vblnk_out_ch, hblnk_out_ch;
  wire [1:0]  rot_ctl;
  wire [3:0]  xpos_ctl, char_line;
  wire [3:0]  sq_1_col_r, sq_2_col_r, sq_3_col_r, sq_4_col_r, sq_1_col_ctl, sq_2_col_ctl, sq_3_col_ctl, sq_4_col_ctl;
  wire [4:0]  sq_1_row_r, sq_2_row_r, sq_3_row_r, sq_4_row_r, sq_1_row_ctl, sq_2_row_ctl, sq_3_row_ctl, sq_4_row_ctl;
  wire [4:0]  random_out, block_ctl, buf_block_ctl, ypos_ctl;
  wire [6:0]  char_code;
  wire [7:0]  char_pixels, char_xy, external_ID_1, external_ID_2;
  wire [10:0] vcount, hcount, hcount_out_b, vcount_out_b, hcount_out_r, vcount_out_r, hcount_out_f, vcount_out_f, hcount_out_nb, vcount_out_nb, hcount_out_ch, vcount_out_ch;
  wire [11:0] rgb_out_b, rgb_out_r, rgb_out_f, rgb_out_nb, rgb_out_ch;
  wire [19:0] points_ctl, points_f;
  wire [23:0] BCD_out;

  wire pad_Sd, pad_Dd, pad_Ld, pad_Rd, btnDd, btnLd, btnRd, btnUd;
  
  wire tx_busy1, tx_busy2, tx_start1, tx_start2, rx_done_tick1, tx_done_tick1, tx_done_tick2, rx_done_tick2;
  
  wire [23:0] ext_data1, ext_data2;
  wire [7:0] din, tx_data1, tx_data2, tx_data;
  wire [7:0] dout1, dout2;
  
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

debouncer my_debouncer(
    .pclk(pclk),
    .rst(rst),
    .sw_S(!pad_S),
    .sw_R(!pad_R),
    .sw_L(!pad_L),
    .sw_D(!pad_D),
    .bttn_D(btnD),
    .bttn_L(btnL),
    .bttn_R(btnR),
    .bttn_U(btnU),
    .pad_Sd(pad_Sd),
    .pad_Rd(pad_Rd),
    .pad_Ld(pad_Ld),
    .pad_Dd(pad_Dd),
    .bttn_Dd(btnDd),
    .bttn_Rd(btnRd),
    .bttn_Ld(btnLd),
    .bttn_Ud(btnUd)
  );


  draw_rect_ctl my_rect_ctl(
    .pclk(pclk),
    .rst(rst),
    .pad_R(pad_Rd),
    .pad_L(pad_Ld),
    .pad_D(pad_Dd),
    .pad_S(pad_Sd),
    .btnL(btnLd),
    .btnR(btnRd),
    .btnD(btnDd),
    .btnU(btnUd),
    .sq_1_col(sq_1_col_r),
    .sq_2_col(sq_2_col_r),
    .sq_3_col(sq_3_col_r),
    .sq_4_col(sq_4_col_r),
    .collision(collision),
    .random(random_out),
    
    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .block(block_ctl),
    .buf_block(buf_block_ctl),
    .rot(rot_ctl),
    .lock_en(lock_en),
    .points(points_ctl),
    .lock_ID_en(lock_ID_en)
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
    .points_out(points_f)
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
    .hsync_in(hsync_out_f),
    .hblnk_in(hblnk_out_f),   
    .rgb_in(rgb_out_f),
    .char_pixels(char_pixels),

    .vsync_out(vsync_out_ch),
    .hsync_out(hsync_out_ch),
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
    .pclk(pclk),
    .rst(rst),
    .char_xy(char_xy),
    .points(BCD_out),
    .ext_data_1(ext_data1),
    .ext_data_2(ext_data2),
    
    .char_code(char_code)
  );
 
  bin_to_BCD_converter my_bin_to_BCD_converter(
    .bin(points_f),  
      
    .BCD(BCD_out)
   );
  
  data_to_transfer my_data_to_transfer(
    .clk(pclk),
    .rst(rst),
    .tx_done_tick1(tx_done_tick1),
    .tx_done_tick2(tx_done_tick2),    
    .points(BCD_out),
    
    .tx_data1(tx_data1),
    .tx_data2(tx_data2)
  );
  

  uart uart_1(
    .clk(pclk), 
    .reset(rst),
    .wr_uart(1),
    .rx(rx1), 
    .w_data(tx_data1),
    .r_data(dout1),
    .tx(tx1),
    .rx_done_tick(rx_done_tick1),
    .tx_done_tick(tx_done_tick1)
);

  uart uart_2(
    .clk(pclk), 
    .reset(rst),
    .wr_uart(1),
    .rx(rx2), 
    .w_data(tx_data2),
    .r_data(dout2),
    .tx(tx2),
    .rx_done_tick(rx_done_tick2),
    .tx_done_tick(tx_done_tick2)
);

  mux my_mux(
  .rx_done_tick1(rx_done_tick1),
  .rx_done_tick2(rx_done_tick2),
  .mux_in_1(dout1),
  .mux_in_2(dout2),
  .clk(pclk),
  .rst(rst),

  .ext_data_1(ext_data1),
  .ext_data_2(ext_data2)
  );

  always @(posedge pclk)begin
    hs <= hsync_out_ch;
    vs <= vsync_out_ch;
    {r,g,b} <= rgb_out_b;
    {r,g,b} <= rgb_out_nb;
    {r,g,b} <= rgb_out_r;
    {r,g,b} <= rgb_out_f;
    {r,g,b} <= rgb_out_ch;
   end

endmodule
