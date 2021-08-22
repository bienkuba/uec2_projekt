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
  reg [9:0]  sq_1_col_bit, sq_1_row_nxt, sq_2_col_bit, sq_2_row_nxt, sq_3_col_bit, sq_3_row_nxt,sq_4_col_bit, sq_4_row_nxt;
  reg [11:0] rgb_out_nxt, color_L, color_D, color_N;
  reg [20:0] my_reg[9:0], my_reg_nxt[9:0];
           
  always@(posedge pclk or posedge rst)begin
    if (rst) begin
      rgb_out    <= 0;
      hsync_out  <= 0;
      vsync_out  <= 0;
      hblnk_out  <= 0;
      vblnk_out  <= 0;          
      hcount_out <= 0;
      vcount_out <= 0;
      collision  <= 0;
      for(j = 0; j < 20; j = j + 1)begin
        for(jj = 0; jj < 10; jj = jj + 1)begin
          my_reg[jj][j] <= 0;
        end
      end      
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
        my_reg[ii][20] = 1;
      end
    end
    
    always@*begin       
      for(iy = 2; iy < 20; iy = iy + 1)begin
        if(sq_1_row == iy || sq_2_row == iy || sq_3_row == iy || sq_4_row == iy)begin
          for(ix = 0; ix < 10; ix = ix + 1)begin
            if ((sq_1_col_bit == my_reg[ix][iy+1] & sq_1_col_bit)||(sq_2_col_bit == my_reg[ix][iy+1] & sq_2_col_bit)||(sq_3_col_bit == my_reg[ix][iy+1] & sq_3_col_bit)||(sq_4_col_bit == my_reg[ix][iy+1] & sq_4_col_bit)) begin
              collision_nxt = 1; 
              my_reg_nxt[ix][iy] = my_reg[ix][iy];
              my_reg_nxt[sq_1_col][sq_1_row] = 1;
              my_reg_nxt[sq_2_col][sq_2_row] = 1;
              my_reg_nxt[sq_3_col][sq_3_row] = 1;
              my_reg_nxt[sq_4_col][sq_4_row] = 1;
            end
            else begin
              collision_nxt = 0;
            end
          end
        end
      end
    end
                
  always @* begin
    if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
    else begin
      for(iiy = 0; iiy < 20; iiy = iiy + 1)begin
        for(iix = 0; iix < 10; iix = iix + 1)begin
          if(my_reg[iix][iiy] == 1)begin
            // left and top edge -> bright
            if      (vcount_in >= Y_CALIB + 35*iiy     && vcount_in < SIZE + Y_CALIB + 35*iiy - 1 && hcount_in == X_CALIB + 35*iix)            rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*iiy     && vcount_in < SIZE + Y_CALIB + 35*iiy - 2 && hcount_in == X_CALIB + 35*iix + 1)        rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*iiy     && vcount_in < SIZE + Y_CALIB + 35*iiy - 3 && hcount_in == X_CALIB + 35*iix + 2)        rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*iiy     && hcount_in > X_CALIB + 35*iix            && hcount_in < SIZE + X_CALIB + 35*iix - 1)  rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*iiy + 1 && hcount_in > X_CALIB + 35*iix            && hcount_in < SIZE + X_CALIB + 35*iix - 2)  rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*iiy + 2 && hcount_in > X_CALIB + 35*iix            && hcount_in < SIZE + X_CALIB + 35*iix - 3)  rgb_out_nxt = color_L;
            // right and bottom edge -> dark
            else if (vcount_in >= Y_CALIB + 35*iiy + 1        && vcount_in < SIZE + Y_CALIB + 35*iiy && hcount_in == X_CALIB + 35*iix + SIZE - 1) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*iiy + 2        && vcount_in < SIZE + Y_CALIB + 35*iiy && hcount_in == X_CALIB + 35*iix + SIZE - 2) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*iiy + 3        && vcount_in < SIZE + Y_CALIB + 35*iiy && hcount_in == X_CALIB + 35*iix + SIZE - 3) rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*iiy + SIZE - 1 && hcount_in > X_CALIB + 35*iix        && hcount_in < SIZE + X_CALIB + 35*iix)      rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*iiy + SIZE - 2 && hcount_in > X_CALIB + 35*iix + 1    && hcount_in < SIZE + X_CALIB + 35*iix)      rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*iiy + SIZE - 3 && hcount_in > X_CALIB + 35*iix + 2    && hcount_in < SIZE + X_CALIB + 35*iix)      rgb_out_nxt = color_D;          
            // inside color
            else if (vcount_in >= Y_CALIB + 35*iiy && vcount_in < SIZE + Y_CALIB + 35*iiy && hcount_in >= X_CALIB + 35*iix && hcount_in < SIZE + X_CALIB + 35*iix) rgb_out_nxt = color_N;                 
            
            else rgb_out_nxt = rgb_in;
          end
        end
      end
    end
  end
        
endmodule