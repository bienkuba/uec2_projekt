`timescale 1ns / 1ps

module fallen_blocks(

 input wire [10:0] vcount_in,
 input wire vsync_in,
 input wire vblnk_in,
 input wire [10:0] hcount_in,
 input wire hsync_in,
 input wire hblnk_in,
 input wire [11:0] rgb_in,
 input wire pclk,
 input wire rst,
 input wire [4:0] sq_1_col,
 input wire [4:0] sq_1_row,
 input wire [4:0] sq_2_col,
 input wire [4:0] sq_2_row,
 input wire [4:0] sq_3_col,
 input wire [4:0] sq_3_row,          
 input wire [4:0] sq_4_col,
 input wire [4:0] sq_4_row,
  
 output reg [10:0] vcount_out,
 output reg vsync_out,
 output reg vblnk_out,
 output reg [10:0] hcount_out,
 output reg hsync_out,
 output reg hblnk_out,
 output reg [11:0] rgb_out,
 output reg collision
 );
  

  localparam X_CALIB = 201;
  localparam Y_CALIB = 10;
  localparam SIZE  = 35;
  
  
  localparam RED_L    = 12'hf_a_b;
  localparam RED_D    = 12'h8_0_0;
  localparam RED_N    = 12'hf_0_0;
  localparam YELLOW_L = 12'hf_f_8;
  localparam YELLOW_D = 12'hb_b_6;
  localparam YELLOW_N = 12'hf_f_0;
  localparam PINK_L   = 12'he_8_e;
  localparam PINK_D   = 12'h8_0_8;
  localparam PINK_N   = 12'hf_0_f;
  localparam BLUE_L   = 12'h0_b_f;
  localparam BLUE_D   = 12'h0_0_8;
  localparam BLUE_N   = 12'h0_0_f;
  localparam GREEN_L  = 12'h9_f_9;
  localparam GREEN_D  = 12'h0_8_0;
  localparam GREEN_N  = 12'h0_f_0;
  localparam CYAN_L   = 12'hc_f_f;
  localparam CYAN_D   = 12'h0_c_f;
  localparam CYAN_N   = 12'h0_f_f;
  
  integer    iy;
  integer    ix;
  integer    iiy;
  integer    iix;
  integer    ii;
  integer    j;
  integer    jj;
  reg        collision_nxt;
  reg [9:0]  sq_1_col_bit, sq_2_col_bit, sq_3_col_bit, sq_4_col_bit;
  reg [11:0] rgb_out_nxt, color_L, color_D, color_N;
  reg [20:0] my_reg[9:0], my_reg_nxt[9:0];
           
  always@(posedge pclk)begin
    if (rst) begin
      rgb_out    <= 0;
      hsync_out  <= 0;
      vsync_out  <= 0;
      hblnk_out  <= 0;
      vblnk_out  <= 0;          
      hcount_out <= 0;
      vcount_out <= 0;
      collision  <= 0;
//      for(j = 0; j < 20; j = j + 1)begin
//        for(jj = 0; jj < 10; jj = jj + 1)begin
//          my_reg[jj][j] <= 0;
//        end
//      end      
    end
    else begin
      hsync_out  <= hsync_in;
      vsync_out  <= vsync_in;
      hblnk_out  <= hblnk_in;
      vblnk_out  <= vblnk_in;  
      hcount_out <= hcount_in;
      vcount_out <= vcount_in;
      rgb_out    <= rgb_out_nxt;
      collision  <= collision_nxt;
      for(j = 0; j < 20; j = j + 1)begin
        for(jj = 0; jj < 10; jj = jj + 1)begin
          my_reg[jj][j]<=my_reg_nxt[jj][j];
        end
      end
    end
  end 
      
    
    always@*begin
      sq_1_col_bit = 2^sq_1_col;
      sq_2_col_bit = 2^sq_2_col;
      sq_3_col_bit = 2^sq_3_col;
      sq_4_col_bit = 2^sq_4_col;
      color_L = RED_L;
      color_D = RED_D;
      color_N = RED_N;
      for(ii = 0; ii < 10; ii = ii + 1)begin
        my_reg_nxt[ii][20] = 1;
        my_reg_nxt[ii][19] = 1;
      end
      
      if(my_reg[sq_1_col][sq_1_row + 1] == 1 || my_reg[sq_2_col][sq_2_row + 1] == 1 || my_reg[sq_3_col][sq_3_row + 1] == 1 || my_reg[sq_4_col][sq_4_row + 1] == 1)begin
        collision_nxt = 1; 
        my_reg_nxt[sq_1_col][sq_1_row] = 1;
        my_reg_nxt[sq_2_col][sq_2_row] = 1;
        my_reg_nxt[sq_3_col][sq_3_row] = 1;
        my_reg_nxt[sq_4_col][sq_4_row] = 1;
      end
      else begin
        collision_nxt = 0;
      end
    end
                
  always @* begin
    if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
    else begin
      if(my_reg[2][18] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_L;
      else if(my_reg[1][18] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
      else if(my_reg[1][17] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
      else if(my_reg[1][16] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
      else rgb_out_nxt = rgb_in;
    end
  end
        
endmodule