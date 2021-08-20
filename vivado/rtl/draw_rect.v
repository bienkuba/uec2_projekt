`timescale 1ns / 1ps

module draw_rect(

 input wire [10:0] vcount_in,
 input wire vsync_in,
 input wire vblnk_in,
 input wire [10:0] hcount_in,
 input wire hsync_in,
 input wire hblnk_in,
 input wire pclk,
 input wire [11:0] rgb_in,
 input wire rst,
 input wire [4:0] xpos,
 input wire [4:0] ypos,
 input wire [4:0] block, 
 input wire [1:0] rot,
  
 output reg [10:0] vcount_out,
 output reg vsync_out,
 output reg vblnk_out,
 output reg [10:0] hcount_out,
 output reg hsync_out,
 output reg hblnk_out,
 output reg [11:0] rgb_out,
 output reg [4:0] sq_1_col,
 output reg [4:0] sq_1_row,
 output reg [4:0] sq_2_col,
 output reg [4:0] sq_2_row,
 output reg [4:0] sq_3_col,
 output reg [4:0] sq_3_row,          
 output reg [4:0] sq_4_col,
 output reg [4:0] sq_4_row,
 output reg [1:0] offset_R,
 output reg [1:0] offset_L
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
  
  localparam I_BLOCK = 'b10000;
  localparam O_BLOCK = 'b10001;
  localparam T_BLOCK = 'b10010;
  localparam S_BLOCK = 'b10011;
  localparam Z_BLOCK = 'b10100;
  localparam J_BLOCK = 'b10101;
  localparam L_BLOCK = 'b10110;

  reg [11:0] rgb_out_nxt, color_L, color_D, color_N;
           
  always@(posedge pclk or posedge rst)begin
    if (rst) begin
      rgb_out    <= 0;
      hsync_out  <= 0;
      vsync_out  <= 0;
      hblnk_out  <= 0;
      vblnk_out  <= 0;          
      hcount_out <= 0;
      vcount_out <= 0;      
    end
    else begin
      hsync_out  <= hsync_in;
      vsync_out  <= vsync_in;
      hblnk_out  <= hblnk_in;
      vblnk_out  <= vblnk_in;  
      hcount_out <= hcount_in;
      vcount_out <= vcount_in;
      rgb_out    <= rgb_out_nxt;
    end
  end 
      
    
    always@*begin
      case (block) 
        I_BLOCK: begin
          color_L = RED_L;
          color_D = RED_D;
          color_N = RED_N;
          if(rot == 0 || rot == 2) begin  
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 2;
            sq_4_row = ypos + 0;
            offset_L = 1;
            offset_R = 2;
          end
          else begin            
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 2;
            offset_L = 0;
            offset_R = 0;
          end       
        end
        O_BLOCK: begin
          color_L = YELLOW_L;
          color_D = YELLOW_D;
          color_N = YELLOW_N;
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;
            offset_L = 0;
            offset_R = 1;            
        end
        T_BLOCK: begin
          color_L = PINK_L;
          color_D = PINK_D;
          color_N = PINK_N;        
          if(rot == 0) begin   
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 1;
            offset_L = 1;
            offset_R = 1;
          end  
          else if (rot == 1) begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos - 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 1;
            offset_L = 1;
            offset_R = 0;                     
          end
          else if (rot == 2) begin
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos - 1;          
            offset_L = 1;
            offset_R = 1;          
          end 
          else begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 1;          
            offset_L = 0;
            offset_R = 1;          
          end 
        end        
        S_BLOCK: begin
          color_L = GREEN_L;
          color_D = GREEN_D;
          color_N = GREEN_N;        
          if(rot == 0 || rot == 2) begin  
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 0;
            offset_L = 1;
            offset_R = 1;
          end
          else begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;
            offset_L = 0;
            offset_R = 1;
          end
        end        
        Z_BLOCK: begin
          color_L = BLUE_L;
          color_D = BLUE_D;
          color_N = BLUE_N;        
          if(rot == 0 || rot == 2) begin  
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;
            offset_L = 1;
            offset_R = 1;
          end
          else begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos - 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos - 1;
            sq_4_row = ypos + 1;
            offset_L = 1;
            offset_R = 0;
          end       
        end
        J_BLOCK: begin
          color_L = CYAN_L;
          color_D = CYAN_D;
          color_N = CYAN_N;          
          if(rot == 0) begin   
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;
            offset_L = 1;
            offset_R = 1;
          end  
          else if (rot == 1) begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos - 1;
            offset_L = 0;
            offset_R = 1;                     
          end
          else if (rot == 2) begin
            sq_1_col = xpos - 1;
            sq_1_row = ypos - 1;
            sq_2_col = xpos - 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 0;          
            offset_L = 1;
            offset_R = 1;          
          end 
          else begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos - 1;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 1;          
            offset_L = 1;
            offset_R = 0;          
          end     
        end
        L_BLOCK: begin
          color_L = RED_L;
          color_D = RED_D;
          color_N = RED_N;        
          if(rot == 0) begin   
            sq_1_col = xpos - 1;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos - 1;
            sq_4_row = ypos + 1;
            offset_L = 1;
            offset_R = 1;
          end  
          else if (rot == 1) begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;
            offset_L = 0;
            offset_R = 1;                     
          end
          else if (rot == 2) begin
            sq_1_col = xpos + 1;
            sq_1_row = ypos - 1;
            sq_2_col = xpos - 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 1;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 0;          
            offset_L = 1;
            offset_R = 1;          
          end 
          else begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos - 1;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos - 1;
            sq_3_row = ypos - 1;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 1;          
            offset_L = 1;
            offset_R = 0;          
          end     
        end
        default: begin
            color_L = CYAN_L;
            color_D = CYAN_D;
            color_N = CYAN_N;
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 0;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 0;
            sq_4_row = ypos + 0;
            offset_L = 0;
            offset_R = 0;                
        end        
      endcase
    end
                 
  always @*
    begin
      if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
        else begin
              // left and top edge -> bright
            if      (vcount_in >= Y_CALIB + 35*sq_1_row     && vcount_in < SIZE + Y_CALIB + 35*sq_1_row - 1 && hcount_in == X_CALIB + 35*sq_1_col)            rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_1_row     && vcount_in < SIZE + Y_CALIB + 35*sq_1_row - 2 && hcount_in == X_CALIB + 35*sq_1_col + 1)        rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_1_row     && vcount_in < SIZE + Y_CALIB + 35*sq_1_row - 3 && hcount_in == X_CALIB + 35*sq_1_col + 2)        rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_1_row     && hcount_in > X_CALIB + 35*sq_1_col             && hcount_in < SIZE + X_CALIB + 35*sq_1_col - 1) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_1_row + 1 && hcount_in > X_CALIB + 35*sq_1_col             && hcount_in < SIZE + X_CALIB + 35*sq_1_col - 2) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_1_row + 2 && hcount_in > X_CALIB + 35*sq_1_col             && hcount_in < SIZE + X_CALIB + 35*sq_1_col - 3) rgb_out_nxt = color_L;
            // right and bottom edge -> dark
            else if (vcount_in >= Y_CALIB + 35*sq_1_row + 1        && vcount_in < SIZE + Y_CALIB + 35*sq_1_row && hcount_in == X_CALIB + 35*sq_1_col + SIZE - 1) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_1_row + 2        && vcount_in < SIZE + Y_CALIB + 35*sq_1_row && hcount_in == X_CALIB + 35*sq_1_col + SIZE - 2) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_1_row + 3        && vcount_in < SIZE + Y_CALIB + 35*sq_1_row && hcount_in == X_CALIB + 35*sq_1_col + SIZE - 3) rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_1_row + SIZE - 1 && hcount_in > X_CALIB + 35*sq_1_col         && hcount_in < SIZE + X_CALIB + 35*sq_1_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_1_row + SIZE - 2 && hcount_in > X_CALIB + 35*sq_1_col + 1     && hcount_in < SIZE + X_CALIB + 35*sq_1_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_1_row + SIZE - 3 && hcount_in > X_CALIB + 35*sq_1_col + 2     && hcount_in < SIZE + X_CALIB + 35*sq_1_col)     rgb_out_nxt = color_D;          
            // inside color
            else if (vcount_in >= Y_CALIB + 35*sq_1_row && vcount_in < SIZE + Y_CALIB + 35*sq_1_row && hcount_in >= X_CALIB + 35*sq_1_col && hcount_in < SIZE + X_CALIB + 35*sq_1_col) rgb_out_nxt = color_N;                 

              // left and top edge -> bright
            else if (vcount_in >= Y_CALIB + 35*sq_2_row     && vcount_in < SIZE + Y_CALIB + 35*sq_2_row - 1 && hcount_in == X_CALIB + 35*sq_2_col)            rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_2_row     && vcount_in < SIZE + Y_CALIB + 35*sq_2_row - 2 && hcount_in == X_CALIB + 35*sq_2_col + 1)        rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_2_row     && vcount_in < SIZE + Y_CALIB + 35*sq_2_row - 3 && hcount_in == X_CALIB + 35*sq_2_col + 2)        rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_2_row     && hcount_in > X_CALIB + 35*sq_2_col             && hcount_in < SIZE + X_CALIB + 35*sq_2_col - 1) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_2_row + 1 && hcount_in > X_CALIB + 35*sq_2_col             && hcount_in < SIZE + X_CALIB + 35*sq_2_col - 2) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_2_row + 2 && hcount_in > X_CALIB + 35*sq_2_col             && hcount_in < SIZE + X_CALIB + 35*sq_2_col - 3) rgb_out_nxt = color_L;
            // right and bottom edge -> dark
            else if (vcount_in >= Y_CALIB + 35*sq_2_row + 1        && vcount_in < SIZE + Y_CALIB + 35*sq_2_row && hcount_in == X_CALIB + 35*sq_2_col + SIZE - 1) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_2_row + 2        && vcount_in < SIZE + Y_CALIB + 35*sq_2_row && hcount_in == X_CALIB + 35*sq_2_col + SIZE - 2) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_2_row + 3        && vcount_in < SIZE + Y_CALIB + 35*sq_2_row && hcount_in == X_CALIB + 35*sq_2_col + SIZE - 3) rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_2_row + SIZE - 1 && hcount_in > X_CALIB + 35*sq_2_col         && hcount_in < SIZE + X_CALIB + 35*sq_2_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_2_row + SIZE - 2 && hcount_in > X_CALIB + 35*sq_2_col + 1     && hcount_in < SIZE + X_CALIB + 35*sq_2_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_2_row + SIZE - 3 && hcount_in > X_CALIB + 35*sq_2_col + 2     && hcount_in < SIZE + X_CALIB + 35*sq_2_col)     rgb_out_nxt = color_D;          
            // inside color
            else if (vcount_in >= Y_CALIB + 35*sq_2_row && vcount_in < SIZE + Y_CALIB + 35*sq_2_row && hcount_in >= X_CALIB + 35*sq_2_col && hcount_in < SIZE + X_CALIB + 35*sq_2_col) rgb_out_nxt = color_N;
            
            // left and top edge -> bright
            else if (vcount_in >= Y_CALIB + 35*sq_3_row     && vcount_in < SIZE + Y_CALIB + 35*sq_3_row - 1 && hcount_in == X_CALIB + 35*sq_3_col)            rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_3_row     && vcount_in < SIZE + Y_CALIB + 35*sq_3_row - 2 && hcount_in == X_CALIB + 35*sq_3_col + 1)        rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_3_row     && vcount_in < SIZE + Y_CALIB + 35*sq_3_row - 3 && hcount_in == X_CALIB + 35*sq_3_col + 2)        rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_3_row     && hcount_in > X_CALIB + 35*sq_3_col             && hcount_in < SIZE + X_CALIB + 35*sq_3_col - 1) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_3_row + 1 && hcount_in > X_CALIB + 35*sq_3_col             && hcount_in < SIZE + X_CALIB + 35*sq_3_col - 2) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_3_row + 2 && hcount_in > X_CALIB + 35*sq_3_col             && hcount_in < SIZE + X_CALIB + 35*sq_3_col - 3) rgb_out_nxt = color_L;
            // right and bottom edge -> dark
            else if (vcount_in >= Y_CALIB + 35*sq_3_row + 1        && vcount_in < SIZE + Y_CALIB + 35*sq_3_row && hcount_in == X_CALIB + 35*sq_3_col + SIZE - 1) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_3_row + 2        && vcount_in < SIZE + Y_CALIB + 35*sq_3_row && hcount_in == X_CALIB + 35*sq_3_col + SIZE - 2) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_3_row + 3        && vcount_in < SIZE + Y_CALIB + 35*sq_3_row && hcount_in == X_CALIB + 35*sq_3_col + SIZE - 3) rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_3_row + SIZE - 1 && hcount_in > X_CALIB + 35*sq_3_col         && hcount_in < SIZE + X_CALIB + 35*sq_3_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_3_row + SIZE - 2 && hcount_in > X_CALIB + 35*sq_3_col + 1     && hcount_in < SIZE + X_CALIB + 35*sq_3_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_3_row + SIZE - 3 && hcount_in > X_CALIB + 35*sq_3_col + 2     && hcount_in < SIZE + X_CALIB + 35*sq_3_col)     rgb_out_nxt = color_D;          
            // inside color
            else if (vcount_in >= Y_CALIB + 35*sq_3_row && vcount_in < SIZE + Y_CALIB + 35*sq_3_row && hcount_in >= X_CALIB + 35*sq_3_col && hcount_in < SIZE + X_CALIB + 35*sq_3_col) rgb_out_nxt = color_N;                             
            
            // left and top edge -> bright
            else if (vcount_in >= Y_CALIB + 35*sq_4_row     && vcount_in < SIZE + Y_CALIB + 35*sq_4_row - 1 && hcount_in == X_CALIB + 35*sq_4_col)            rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_4_row     && vcount_in < SIZE + Y_CALIB + 35*sq_4_row - 2 && hcount_in == X_CALIB + 35*sq_4_col + 1)        rgb_out_nxt = color_L; 
            else if (vcount_in >= Y_CALIB + 35*sq_4_row     && vcount_in < SIZE + Y_CALIB + 35*sq_4_row - 3 && hcount_in == X_CALIB + 35*sq_4_col + 2)        rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_4_row     && hcount_in > X_CALIB + 35*sq_4_col             && hcount_in < SIZE + X_CALIB + 35*sq_4_col - 1) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_4_row + 1 && hcount_in > X_CALIB + 35*sq_4_col             && hcount_in < SIZE + X_CALIB + 35*sq_4_col - 2) rgb_out_nxt = color_L;
            else if (vcount_in == Y_CALIB + 35*sq_4_row + 2 && hcount_in > X_CALIB + 35*sq_4_col             && hcount_in < SIZE + X_CALIB + 35*sq_4_col - 3) rgb_out_nxt = color_L;
            // right and bottom edge -> dark
            else if (vcount_in >= Y_CALIB + 35*sq_4_row + 1        && vcount_in < SIZE + Y_CALIB + 35*sq_4_row && hcount_in == X_CALIB + 35*sq_4_col + SIZE - 1) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_4_row + 2        && vcount_in < SIZE + Y_CALIB + 35*sq_4_row && hcount_in == X_CALIB + 35*sq_4_col + SIZE - 2) rgb_out_nxt = color_D; 
            else if (vcount_in >= Y_CALIB + 35*sq_4_row + 3        && vcount_in < SIZE + Y_CALIB + 35*sq_4_row && hcount_in == X_CALIB + 35*sq_4_col + SIZE - 3) rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_4_row + SIZE - 1 && hcount_in > X_CALIB + 35*sq_4_col         && hcount_in < SIZE + X_CALIB + 35*sq_4_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_4_row + SIZE - 2 && hcount_in > X_CALIB + 35*sq_4_col + 1     && hcount_in < SIZE + X_CALIB + 35*sq_4_col)     rgb_out_nxt = color_D;
            else if (vcount_in == Y_CALIB + 35*sq_4_row + SIZE - 3 && hcount_in > X_CALIB + 35*sq_4_col + 2     && hcount_in < SIZE + X_CALIB + 35*sq_4_col)     rgb_out_nxt = color_D;          
            // inside color
            else if (vcount_in >= Y_CALIB + 35*sq_4_row && vcount_in < SIZE + Y_CALIB + 35*sq_4_row && hcount_in >= X_CALIB + 35*sq_4_col && hcount_in < SIZE + X_CALIB + 35*sq_4_col) rgb_out_nxt = color_N;                 
        
            else rgb_out_nxt = rgb_in;
          end
      end
        
endmodule