`timescale 1ns / 1ps

/*
Autor: Jakub Bien
*/

module fallen_blocks(

 input wire [10:0] vcount_in,
 input wire        vsync_in,
 input wire        vblnk_in,
 input wire [10:0] hcount_in,
 input wire        hsync_in,
 input wire        hblnk_in,
 input wire [11:0] rgb_in,
 input wire        pclk,
 input wire        rst,
 input wire [3:0]  sq_1_col,
 input wire [4:0]  sq_1_row,
 input wire [3:0]  sq_2_col,
 input wire [4:0]  sq_2_row,
 input wire [3:0]  sq_3_col,
 input wire [4:0]  sq_3_row,          
 input wire [3:0]  sq_4_col,
 input wire [4:0]  sq_4_row,
 input wire        lock_en,
 input wire [19:0] points_in,
 
 output reg [10:0] vcount_out,
 output reg        vsync_out,
 output reg        vblnk_out,
 output reg [10:0] hcount_out,
 output reg        hsync_out,
 output reg        hblnk_out,
 output reg [11:0] rgb_out,
 output reg        collision,
 output reg [19:0] points_out
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
  
  integer    i;
  integer    j;
  integer    k;
  integer    l;
  reg        collision_nxt;
  reg [2:0]  cleared_lane, cleared_lane_nxt;
  reg [3:0]  level_nxt;
  reg [0:9]  my_reg[19:0], my_reg_nxt[19:0];
  reg [11:0] rgb_out_nxt, color_L, color_D, color_N;  
  reg [19:0] points, points_nxt;
           
  always@(posedge pclk)begin
    if (rst) begin
      rgb_out      <= 0;
      hsync_out    <= 0;
      vsync_out    <= 0;
      hblnk_out    <= 0;
      vblnk_out    <= 0;          
      hcount_out   <= 0;
      vcount_out   <= 0;
      collision    <= 0;
      points       <= 0;
      cleared_lane <= 0;
      for(i = 0; i < 20; i = i + 1) my_reg[i] <= 0;
    end
    else begin
      hsync_out    <= hsync_in;
      vsync_out    <= vsync_in;
      hblnk_out    <= hblnk_in;
      vblnk_out    <= vblnk_in;  
      hcount_out   <= hcount_in;
      vcount_out   <= vcount_in;
      rgb_out      <= rgb_out_nxt;
      collision    <= collision_nxt;
      points       <= points_nxt;
      cleared_lane <= cleared_lane_nxt;
      for(j = 0; j < 20; j = j + 1) my_reg[j] <= my_reg_nxt[j];
    end
  end 
      
    
    always@*begin
      color_L = RED_L;
      color_D = RED_D;
      color_N = RED_N;
      collision_nxt = collision;
      cleared_lane_nxt = cleared_lane;
      points_nxt = points;
      points_out = points + points_in;
      for(k = 0; k < 20; k = k + 1) my_reg_nxt[k] = my_reg[k];
      if(sq_1_row == 19 || sq_2_row == 19 || sq_3_row == 19 || sq_4_row == 19)begin
        collision_nxt = 1; 
          if(lock_en == 1)begin
            my_reg_nxt[sq_1_row][sq_1_col] = 1;
            my_reg_nxt[sq_2_row][sq_2_col] = 1;
            my_reg_nxt[sq_3_row][sq_3_col] = 1;
            my_reg_nxt[sq_4_row][sq_4_col] = 1;
            points_nxt = points + 1;
          end
      end    
      else if(my_reg[sq_1_row + 1][sq_1_col] == 1 || my_reg[sq_2_row + 1][sq_2_col] == 1 || my_reg[sq_3_row + 1][sq_3_col] == 1 || my_reg[sq_4_row + 1][sq_4_col] == 1)begin
        collision_nxt = 1; 
          if(lock_en == 1)begin
            my_reg_nxt[sq_1_row][sq_1_col] = 1;
            my_reg_nxt[sq_2_row][sq_2_col] = 1;
            my_reg_nxt[sq_3_row][sq_3_col] = 1;
            my_reg_nxt[sq_4_row][sq_4_col] = 1;
            points_nxt = points + 5;
          end
      end
      else if(my_reg_nxt[19] == 10'b1111111111) for(l = 1; l < 20; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;
      end
      else if(my_reg_nxt[18] == 10'b1111111111) for(l = 1; l < 19; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;
      end
      else if(my_reg_nxt[17] == 10'b1111111111) for(l = 1; l < 18; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;   
      end
      else if(my_reg_nxt[16] == 10'b1111111111) for(l = 1; l < 17; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[15] == 10'b1111111111) for(l = 1; l < 16; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[14] == 10'b1111111111) for(l = 1; l < 15; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;     
      end
      else if(my_reg_nxt[13] == 10'b1111111111) for(l = 1; l < 14; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[12] == 10'b1111111111) for(l = 1; l < 13; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[11] == 10'b1111111111) for(l = 1; l < 12; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[10] == 10'b1111111111) for(l = 1; l < 11; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[9] == 10'b1111111111) for(l = 1; l < 10; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[8] == 10'b1111111111) for(l = 1; l < 9; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[7] == 10'b1111111111) for(l = 1; l < 8; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[6] == 10'b1111111111) for(l = 1; l < 7; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[5] == 10'b1111111111) for(l = 1; l < 6; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[4] == 10'b1111111111) for(l = 1; l < 5; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[3] == 10'b1111111111) for(l = 1; l < 4; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[2] == 10'b1111111111) for(l = 1; l < 3; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else if(my_reg_nxt[1] == 10'b1111111111) for(l = 1; l < 2; l = l + 1) begin
        my_reg_nxt[l] = my_reg[l-1];   
        cleared_lane_nxt = cleared_lane + 1;      
      end
      else begin
        collision_nxt = 0;
        if (cleared_lane == 1) begin
          points_nxt = points + 80;
          cleared_lane_nxt = 0;
          end
        else if (cleared_lane == 2) begin
          points_nxt = points + 200;
          cleared_lane_nxt = 0;
        end
        else if (cleared_lane == 3) begin
          points_nxt = points + 600;
          cleared_lane_nxt = 0;
        end
        else if (cleared_lane >= 4) begin
          points_nxt = points + 1200;
          cleared_lane_nxt = 0;
        end
        else points_nxt = points;
      end
    end

  
  always@*begin
    if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
    else begin
        if(my_reg[19][0] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[19][1] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[19][2] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[19][3] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[19][4] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[19][5] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[19][6] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[19][7] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[19][8] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[19][9] == 1 && vcount_in >= Y_CALIB + 35*19 && vcount_in < SIZE + Y_CALIB + 35*19 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[18][0] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[18][1] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[18][2] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[18][3] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[18][4] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[18][5] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[18][6] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[18][7] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[18][8] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[18][9] == 1 && vcount_in >= Y_CALIB + 35*18 && vcount_in < SIZE + Y_CALIB + 35*18 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[17][0] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[17][1] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[17][2] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[17][3] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[17][4] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[17][5] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[17][6] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[17][7] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[17][8] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[17][9] == 1 && vcount_in >= Y_CALIB + 35*17 && vcount_in < SIZE + Y_CALIB + 35*17 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[16][0] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[16][1] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[16][2] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[16][3] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[16][4] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[16][5] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[16][6] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[16][7] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[16][8] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[16][9] == 1 && vcount_in >= Y_CALIB + 35*16 && vcount_in < SIZE + Y_CALIB + 35*16 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[15][0] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[15][1] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[15][2] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[15][3] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[15][4] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[15][5] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[15][6] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[15][7] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[15][8] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[15][9] == 1 && vcount_in >= Y_CALIB + 35*15 && vcount_in < SIZE + Y_CALIB + 35*15 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[14][0] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[14][1] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[14][2] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[14][3] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[14][4] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[14][5] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[14][6] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[14][7] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[14][8] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[14][9] == 1 && vcount_in >= Y_CALIB + 35*14 && vcount_in < SIZE + Y_CALIB + 35*14 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
              
        else if(my_reg[13][0] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[13][1] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[13][2] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[13][3] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[13][4] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[13][5] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[13][6] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[13][7] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[13][8] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[13][9] == 1 && vcount_in >= Y_CALIB + 35*13 && vcount_in < SIZE + Y_CALIB + 35*13 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
        
        else if(my_reg[12][0] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[12][1] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[12][2] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[12][3] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[12][4] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[12][5] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[12][6] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[12][7] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[12][8] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[12][9] == 1 && vcount_in >= Y_CALIB + 35*12 && vcount_in < SIZE + Y_CALIB + 35*12 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
        
        else if(my_reg[11][0] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[11][1] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[11][2] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[11][3] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[11][4] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[11][5] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[11][6] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[11][7] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[11][8] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[11][9] == 1 && vcount_in >= Y_CALIB + 35*11 && vcount_in < SIZE + Y_CALIB + 35*11 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          

        else if(my_reg[10][0] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[10][1] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[10][2] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[10][3] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[10][4] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[10][5] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[10][6] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[10][7] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[10][8] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[10][9] == 1 && vcount_in >= Y_CALIB + 35*10 && vcount_in < SIZE + Y_CALIB + 35*10 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
        
        else if(my_reg[9][0] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[9][1] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[9][2] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[9][3] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[9][4] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[9][5] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[9][6] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[9][7] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[9][8] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[9][9] == 1 && vcount_in >= Y_CALIB + 35*9 && vcount_in < SIZE + Y_CALIB + 35*9 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
        
        else if(my_reg[8][0] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[8][1] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[8][2] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[8][3] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[8][4] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[8][5] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[8][6] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[8][7] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[8][8] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[8][9] == 1 && vcount_in >= Y_CALIB + 35*8 && vcount_in < SIZE + Y_CALIB + 35*8 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          

        else if(my_reg[7][0] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[7][1] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[7][2] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[7][3] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[7][4] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[7][5] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[7][6] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[7][7] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[7][8] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[7][9] == 1 && vcount_in >= Y_CALIB + 35*7 && vcount_in < SIZE + Y_CALIB + 35*7 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[6][0] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[6][1] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[6][2] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[6][3] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[6][4] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[6][5] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[6][6] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[6][7] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[6][8] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[6][9] == 1 && vcount_in >= Y_CALIB + 35*6 && vcount_in < SIZE + Y_CALIB + 35*6 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[5][0] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[5][1] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[5][2] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[5][3] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[5][4] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[5][5] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[5][6] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[5][7] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[5][8] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[5][9] == 1 && vcount_in >= Y_CALIB + 35*5 && vcount_in < SIZE + Y_CALIB + 35*5 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;
        
        else if(my_reg[4][0] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[4][1] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[4][2] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[4][3] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[4][4] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[4][5] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[4][6] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[4][7] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[4][8] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[4][9] == 1 && vcount_in >= Y_CALIB + 35*4 && vcount_in < SIZE + Y_CALIB + 35*4 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
              
        else if(my_reg[3][0] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[3][1] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[3][2] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[3][3] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[3][4] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[3][5] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[3][6] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[3][7] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[3][8] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[3][9] == 1 && vcount_in >= Y_CALIB + 35*3 && vcount_in < SIZE + Y_CALIB + 35*3 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
        
        else if(my_reg[2][0] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[2][1] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[2][2] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[2][3] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[2][4] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[2][5] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[2][6] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[2][7] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[2][8] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[2][9] == 1 && vcount_in >= Y_CALIB + 35*2 && vcount_in < SIZE + Y_CALIB + 35*2 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;          
        
        else if(my_reg[1][0] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*0 && hcount_in < SIZE + X_CALIB + 35*0) rgb_out_nxt = color_D;
        else if(my_reg[1][1] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*1 && hcount_in < SIZE + X_CALIB + 35*1) rgb_out_nxt = color_D;
        else if(my_reg[1][2] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*2 && hcount_in < SIZE + X_CALIB + 35*2) rgb_out_nxt = color_D;
        else if(my_reg[1][3] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*3 && hcount_in < SIZE + X_CALIB + 35*3) rgb_out_nxt = color_D;
        else if(my_reg[1][4] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*4 && hcount_in < SIZE + X_CALIB + 35*4) rgb_out_nxt = color_D;
        else if(my_reg[1][5] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*5 && hcount_in < SIZE + X_CALIB + 35*5) rgb_out_nxt = color_D;
        else if(my_reg[1][6] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*6 && hcount_in < SIZE + X_CALIB + 35*6) rgb_out_nxt = color_D;
        else if(my_reg[1][7] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*7 && hcount_in < SIZE + X_CALIB + 35*7) rgb_out_nxt = color_D;
        else if(my_reg[1][8] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*8 && hcount_in < SIZE + X_CALIB + 35*8) rgb_out_nxt = color_D;
        else if(my_reg[1][9] == 1 && vcount_in >= Y_CALIB + 35*1 && vcount_in < SIZE + Y_CALIB + 35*1 && hcount_in >= X_CALIB + 35*9 && hcount_in < SIZE + X_CALIB + 35*9) rgb_out_nxt = color_D;

      else rgb_out_nxt = rgb_in;
    end
  end
        
endmodule