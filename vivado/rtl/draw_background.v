`timescale 1ns / 1ps

  module draw_background(
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire pclk,
    input wire rst,
 
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out
    );
    
  reg [11:0] rgb_out_nxt = 0;
    
    //T
    localparam Y_T1 = 40;
    localparam X_T1 = 600;
    localparam Y_T2 = 40;
    localparam X_T2 = 600 + 35;
    localparam Y_T3 = 40;
    localparam X_T3 = 600 + 35*2;
    localparam Y_T4 = 40 + 35;
    localparam X_T4 = 600 + 35;    
    localparam Y_T5 = 40 + 35*2;
    localparam X_T5 = 600 + 35;    
    localparam Y_T6 = 40 + 35*3;
    localparam X_T6 = 600 + 35;    
    localparam Y_T7 = 40 + 35*4;
    localparam X_T7 = 600 + 35;          
    //E
    localparam Y_E1 = 40;
    localparam X_E1 = 600 + 35*3;
    localparam Y_E2 = 40 + 35;
    localparam X_E2 = 600 + 35*3;
    localparam Y_E3 = 40 + 35*2;
    localparam X_E3 = 600 + 35*3;
    localparam Y_E4 = 40 + 35*3;
    localparam X_E4 = 600 + 35*3;
    localparam Y_E5 = 40 + 35*4;
    localparam X_E5 = 600 + 35*3;
    localparam Y_E6 = 40;
    localparam X_E6 = 600 + 35*4;
    localparam Y_E7 = 40;
    localparam X_E7 = 600 + 35*5;
    localparam Y_E8 = 40 + 35*2;
    localparam X_E8 = 600 + 35*4;
    localparam Y_E9 = 40 + 35*4;
    localparam X_E9 = 600 + 35*4;
    localparam Y_E10 = 40 + 35*4;
    localparam X_E10 = 600 + 35*5; 
    //T
    localparam Y_T11 = 40;
    localparam X_T11 = 600 + 35*6;
    localparam Y_T12 = 40;
    localparam X_T12 = 600 + 35*7;
    localparam Y_T13 = 40;
    localparam X_T13 = 600 + 35*8;
    localparam Y_T14 = 40 + 35;
    localparam X_T14 = 600 + 35*7;    
    localparam Y_T15 = 40 + 35*2;
    localparam X_T15 = 600 + 35*7;    
    localparam Y_T16 = 40 + 35*3;
    localparam X_T16 = 600 + 35*7;    
    localparam Y_T17 = 40 + 35*4;
    localparam X_T17 = 600 + 35*7;       
    //R
    localparam Y_R1 = 40;
    localparam X_R1 = 600 + 35*9;
    localparam Y_R2 = 40 + 35;
    localparam X_R2 = 600 + 35*9;
    localparam Y_R3 = 40 + 35*2;
    localparam X_R3 = 600 + 35*9;
    localparam Y_R4 = 40 + 35*3;
    localparam X_R4 = 600 + 35*9;
    localparam Y_R5 = 40 + 35*4;
    localparam X_R5 = 600 + 35*9;
    localparam Y_R6 = 40;
    localparam X_R6 = 600 + 35*10;
    localparam Y_R7 = 40 + 35;
    localparam X_R7 = 600 + 35*11;
    localparam Y_R8 = 40 + 35*2;
    localparam X_R8 = 600 + 35*10;
    localparam Y_R9 = 40 + 35*3;
    localparam X_R9 = 600 + 35*11;
    localparam Y_R10 = 40 + 35*4;
    localparam X_R10 = 600 + 35*11;
    //I
    localparam Y_I1 = 40;
    localparam X_I1 = 600 + 35*13;
    localparam Y_I2 = 40 + 35;
    localparam X_I2 = 600 + 35*13;
    localparam Y_I3 = 40 + 35*2;
    localparam X_I3 = 600 + 35*13;
    localparam Y_I4 = 40 + 35*3;
    localparam X_I4 = 600 + 35*13;
    localparam Y_I5 = 40 + 35*4;
    localparam X_I5 = 600 + 35*13;
    localparam Y_I6 = 40;
    localparam X_I6 = 600 + 35*12;
    localparam Y_I7 = 40;
    localparam X_I7 = 600 + 35*14;
    localparam Y_I8 = 40 + 35*4;
    localparam X_I8 = 600 + 35*12;
    localparam Y_I9 = 40 + 35*4;
    localparam X_I9 = 600 + 35*14;
    //S
    localparam Y_S1 = 40;
    localparam X_S1 = 600 + 35*15;
    localparam Y_S2 = 40;
    localparam X_S2 = 600 + 35*16;
    localparam Y_S3 = 40;
    localparam X_S3 = 600 + 35*17;
    localparam Y_S4 = 40 + 35;
    localparam X_S4 = 600 + 35*15;
    localparam Y_S5 = 40 + 35*2;
    localparam X_S5 = 600 + 35*15;
    localparam Y_S6 = 40 + 35*2;
    localparam X_S6 = 600 + 35*16;
    localparam Y_S7 = 40 + 35*2;
    localparam X_S7 = 600 + 35*17;
    localparam Y_S8 = 40 + 35*3;
    localparam X_S8 = 600 + 35*17;
    localparam Y_S9 = 40 + 35*4;
    localparam X_S9 = 600 + 35*17;
    localparam Y_S10 = 40 + 35*4;
    localparam X_S10 = 600 + 35*16;    
    localparam Y_S11 = 40 + 35*4;
    localparam X_S11 = 600 + 35*15; 



    
    localparam SIZE = 35;
    
  always@(posedge pclk or posedge rst)begin
    if(rst)begin
      rgb_out    <= 0;
      hsync_out  <= 0;
      vsync_out  <= 0;
      hblnk_out  <= 0;
      vblnk_out  <= 0;
      hcount_out <= 0;
      vcount_out <= 0;
      end
      else begin
      rgb_out    <= rgb_out_nxt;
      hsync_out  <= hsync_in;
      vsync_out  <= vsync_in;
      hblnk_out  <= hblnk_in;
      vblnk_out  <= vblnk_in;
      vcount_out <= vcount_in;
      hcount_out <= hcount_in;
    end
  end
 
  always @(posedge pclk)begin
    // During blanking, make it black.
    if (vblnk_in || hblnk_in) rgb_out_nxt <= 12'h0_0_0; 
    else begin
//      // guide net      
//           if (hcount_in == 235) rgb_out_nxt <= 12'h0_f_0;
//      else if (hcount_in == 270) rgb_out_nxt <= 12'h0_f_0;
//      else if (hcount_in == 200+315) rgb_out_nxt <= 12'h0_f_0;
//      else if (vcount_in == 45) rgb_out_nxt <= 12'hf_f_0;
//      else if (vcount_in == 80) rgb_out_nxt <= 12'hf_f_0;
//      else if (vcount_in == 10+665) rgb_out_nxt <= 12'hf_f_0;
      // frame bright part
      if (hcount_in >= 190 && hcount_in <= 191) rgb_out_nxt <= 12'ha_a_a;
      else if ((hcount_in >= 550 && hcount_in <= 551) && (vcount_in >= 10 && vcount_in <= 710)) rgb_out_nxt <= 12'ha_a_a;      
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 0 && vcount_in <= 1)) rgb_out_nxt <= 12'ha_a_a;
      else if ((hcount_in >= 200 && hcount_in <= 551) && (vcount_in >= 710 && vcount_in <= 711)) rgb_out_nxt <= 12'ha_a_a;
      // frame dark part
      else if ((hcount_in >= 198 && hcount_in <= 199) && (vcount_in >= 10 && vcount_in <= 710)) rgb_out_nxt <= 12'h6_6_6;
      else if (hcount_in >= 559 && hcount_in <= 560) rgb_out_nxt <= 12'h6_6_6;      
      else if ((hcount_in >= 199 && hcount_in <= 550) && (vcount_in >= 8 && vcount_in <= 9)) rgb_out_nxt <= 12'h6_6_6;
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 718 && vcount_in <= 719)) rgb_out_nxt <= 12'h6_6_6;
      // basic frame of game area
      else if (hcount_in >= 190 && hcount_in <= 199) rgb_out_nxt <= 12'h8_8_8; 
      else if (hcount_in >= 550 && hcount_in <= 560) rgb_out_nxt <= 12'h8_8_8;
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 0 && vcount_in <= 9)) rgb_out_nxt <= 12'h8_8_8;
      else if ((hcount_in >= 190 && hcount_in <= 560) && (vcount_in >= 710 && vcount_in <= 719)) rgb_out_nxt <= 12'h8_8_8;
      // game area background
      else if ((hcount_in >= 200 && hcount_in <= 549) && (vcount_in >= 10 && vcount_in <= 710)) rgb_out_nxt <= 12'h0_0_0;   

    // T1 of TETRIS sigh 
    else if (vcount_in >= Y_T1     && vcount_in < SIZE + Y_T1 - 1  && hcount_in == X_T1)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T1     && vcount_in < SIZE + Y_T1 - 2  && hcount_in == X_T1 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T1     && vcount_in < SIZE + Y_T1 - 3  && hcount_in == X_T1 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T1     && hcount_in > X_T1             && hcount_in < SIZE + X_T1 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T1 + 1 && hcount_in > X_T1             && hcount_in < SIZE + X_T1 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T1 + 2 && hcount_in > X_T1             && hcount_in < SIZE + X_T1 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T1 + 1        && vcount_in < SIZE + Y_T1 && hcount_in == X_T1 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T1 + 2        && vcount_in < SIZE + Y_T1 && hcount_in == X_T1 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T1 + 3        && vcount_in < SIZE + Y_T1 && hcount_in == X_T1 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T1 + SIZE - 1 && hcount_in > X_T1         && hcount_in < SIZE + X_T1)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T1 + SIZE - 2 && hcount_in > X_T1 + 1     && hcount_in < SIZE + X_T1)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T1 + SIZE - 3 && hcount_in > X_T1 + 2     && hcount_in < SIZE + X_T1)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T1 && vcount_in < SIZE + Y_T1 && hcount_in >= X_T1 && hcount_in < SIZE + X_T1) rgb_out_nxt = 12'hf_0_0;
          
    else if (vcount_in >= Y_T2     && vcount_in < SIZE + Y_T2 - 1  && hcount_in == X_T2)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T2     && vcount_in < SIZE + Y_T2 - 2  && hcount_in == X_T2 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T2     && vcount_in < SIZE + Y_T2 - 3  && hcount_in == X_T2 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T2     && hcount_in > X_T2             && hcount_in < SIZE + X_T2 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T2 + 1 && hcount_in > X_T2             && hcount_in < SIZE + X_T2 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T2 + 2 && hcount_in > X_T2             && hcount_in < SIZE + X_T2 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T2 + 1        && vcount_in < SIZE + Y_T2 && hcount_in == X_T2 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T2 + 2        && vcount_in < SIZE + Y_T2 && hcount_in == X_T2 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T2 + 3        && vcount_in < SIZE + Y_T2 && hcount_in == X_T2 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T2 + SIZE - 1 && hcount_in > X_T2         && hcount_in < SIZE + X_T2)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T2 + SIZE - 2 && hcount_in > X_T2 + 1     && hcount_in < SIZE + X_T2)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T2 + SIZE - 3 && hcount_in > X_T2 + 2     && hcount_in < SIZE + X_T2)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T2 && vcount_in < SIZE + Y_T2 && hcount_in >= X_T2 && hcount_in < SIZE + X_T2) rgb_out_nxt = 12'hf_0_0;
          
          else if (vcount_in >= Y_T3     && vcount_in < SIZE + Y_T3 - 1  && hcount_in == X_T3)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T3     && vcount_in < SIZE + Y_T3 - 2  && hcount_in == X_T3 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T3     && vcount_in < SIZE + Y_T3 - 3  && hcount_in == X_T3 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T3     && hcount_in > X_T3             && hcount_in < SIZE + X_T3 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T3 + 1 && hcount_in > X_T3             && hcount_in < SIZE + X_T3 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T3 + 2 && hcount_in > X_T3             && hcount_in < SIZE + X_T3 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T3 + 1        && vcount_in < SIZE + Y_T3 && hcount_in == X_T3 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T3 + 2        && vcount_in < SIZE + Y_T3 && hcount_in == X_T3 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T3 + 3        && vcount_in < SIZE + Y_T3 && hcount_in == X_T3 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T3 + SIZE - 1 && hcount_in > X_T3         && hcount_in < SIZE + X_T3)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T3 + SIZE - 2 && hcount_in > X_T3 + 1     && hcount_in < SIZE + X_T3)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T3 + SIZE - 3 && hcount_in > X_T3 + 2     && hcount_in < SIZE + X_T3)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T3 && vcount_in < SIZE + Y_T3 && hcount_in >= X_T3 && hcount_in < SIZE + X_T3) rgb_out_nxt = 12'hf_0_0;
    
    else if (vcount_in >= Y_T4     && vcount_in < SIZE + Y_T4 - 1  && hcount_in == X_T4)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T4     && vcount_in < SIZE + Y_T4 - 2  && hcount_in == X_T4 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T4     && vcount_in < SIZE + Y_T4 - 3  && hcount_in == X_T4 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T4     && hcount_in > X_T4             && hcount_in < SIZE + X_T4 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T4 + 1 && hcount_in > X_T4             && hcount_in < SIZE + X_T4 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T4 + 2 && hcount_in > X_T4             && hcount_in < SIZE + X_T4 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T4 + 1        && vcount_in < SIZE + Y_T4 && hcount_in == X_T4 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T4 + 2        && vcount_in < SIZE + Y_T4 && hcount_in == X_T4 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T4 + 3        && vcount_in < SIZE + Y_T4 && hcount_in == X_T4 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T4 + SIZE - 1 && hcount_in > X_T4         && hcount_in < SIZE + X_T4)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T4 + SIZE - 2 && hcount_in > X_T4 + 1     && hcount_in < SIZE + X_T4)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T4 + SIZE - 3 && hcount_in > X_T4 + 2     && hcount_in < SIZE + X_T4)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T4 && vcount_in < SIZE + Y_T4 && hcount_in >= X_T4 && hcount_in < SIZE + X_T4) rgb_out_nxt = 12'hf_0_0;
    
    else if (vcount_in >= Y_T5     && vcount_in < SIZE + Y_T5 - 1  && hcount_in == X_T5)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T5     && vcount_in < SIZE + Y_T5 - 2  && hcount_in == X_T5 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T5     && vcount_in < SIZE + Y_T5 - 3  && hcount_in == X_T5 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T5     && hcount_in > X_T5             && hcount_in < SIZE + X_T5 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T5 + 1 && hcount_in > X_T5             && hcount_in < SIZE + X_T5 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T5 + 2 && hcount_in > X_T5             && hcount_in < SIZE + X_T5 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T5 + 1        && vcount_in < SIZE + Y_T5 && hcount_in == X_T5 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T5 + 2        && vcount_in < SIZE + Y_T5 && hcount_in == X_T5 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T5 + 3        && vcount_in < SIZE + Y_T5 && hcount_in == X_T5 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T5 + SIZE - 1 && hcount_in > X_T5         && hcount_in < SIZE + X_T5)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T5 + SIZE - 2 && hcount_in > X_T5 + 1     && hcount_in < SIZE + X_T5)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T5 + SIZE - 3 && hcount_in > X_T5 + 2     && hcount_in < SIZE + X_T5)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T5 && vcount_in < SIZE + Y_T5 && hcount_in >= X_T5 && hcount_in < SIZE + X_T5) rgb_out_nxt = 12'hf_0_0;
    
    else if (vcount_in >= Y_T6     && vcount_in < SIZE + Y_T6 - 1  && hcount_in == X_T6)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T6     && vcount_in < SIZE + Y_T6 - 2  && hcount_in == X_T6 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T6     && vcount_in < SIZE + Y_T6 - 3  && hcount_in == X_T6 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T6     && hcount_in > X_T6             && hcount_in < SIZE + X_T6 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T6 + 1 && hcount_in > X_T6             && hcount_in < SIZE + X_T6 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T6 + 2 && hcount_in > X_T6             && hcount_in < SIZE + X_T6 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T6 + 1        && vcount_in < SIZE + Y_T6 && hcount_in == X_T6 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T6 + 2        && vcount_in < SIZE + Y_T6 && hcount_in == X_T6 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T6 + 3        && vcount_in < SIZE + Y_T6 && hcount_in == X_T6 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T6 + SIZE - 1 && hcount_in > X_T6         && hcount_in < SIZE + X_T6)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T6 + SIZE - 2 && hcount_in > X_T6 + 1     && hcount_in < SIZE + X_T6)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T6 + SIZE - 3 && hcount_in > X_T6 + 2     && hcount_in < SIZE + X_T6)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T6 && vcount_in < SIZE + Y_T6 && hcount_in >= X_T6 && hcount_in < SIZE + X_T6) rgb_out_nxt = 12'hf_0_0;
    
    else if (vcount_in >= Y_T7     && vcount_in < SIZE + Y_T7 - 1  && hcount_in == X_T7)            rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T7     && vcount_in < SIZE + Y_T7 - 2  && hcount_in == X_T7 + 1)        rgb_out_nxt = 12'hf_a_b; 
    else if (vcount_in >= Y_T7     && vcount_in < SIZE + Y_T7 - 3  && hcount_in == X_T7 + 2)        rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T7     && hcount_in > X_T7             && hcount_in < SIZE + X_T7 - 1) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T7 + 1 && hcount_in > X_T7             && hcount_in < SIZE + X_T7 - 2) rgb_out_nxt = 12'hf_a_b;
    else if (vcount_in == Y_T7 + 2 && hcount_in > X_T7             && hcount_in < SIZE + X_T7 - 3) rgb_out_nxt = 12'hf_a_b;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T7 + 1        && vcount_in < SIZE + Y_T7 && hcount_in == X_T7 + SIZE - 1) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T7 + 2        && vcount_in < SIZE + Y_T7 && hcount_in == X_T7 + SIZE - 2) rgb_out_nxt = 12'h8_0_0; 
    else if (vcount_in >= Y_T7 + 3        && vcount_in < SIZE + Y_T7 && hcount_in == X_T7 + SIZE - 3) rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T7 + SIZE - 1 && hcount_in > X_T7         && hcount_in < SIZE + X_T7)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T7 + SIZE - 2 && hcount_in > X_T7 + 1     && hcount_in < SIZE + X_T7)     rgb_out_nxt = 12'h8_0_0;
    else if (vcount_in == Y_T7 + SIZE - 3 && hcount_in > X_T7 + 2     && hcount_in < SIZE + X_T7)     rgb_out_nxt = 12'h8_0_0;          
    // inside color
    else if (vcount_in >= Y_T7 && vcount_in < SIZE + Y_T7 && hcount_in >= X_T7 && hcount_in < SIZE + X_T7) rgb_out_nxt = 12'hf_0_0; 
    
    // E of TETRIS
    else if (vcount_in >= Y_E1     && vcount_in < SIZE + Y_E1 - 1  && hcount_in == X_E1)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E1     && vcount_in < SIZE + Y_E1 - 2  && hcount_in == X_E1 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E1     && vcount_in < SIZE + Y_E1 - 3  && hcount_in == X_E1 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E1     && hcount_in > X_E1             && hcount_in < SIZE + X_E1 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E1 + 1 && hcount_in > X_E1             && hcount_in < SIZE + X_E1 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E1 + 2 && hcount_in > X_E1             && hcount_in < SIZE + X_E1 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E1 + 1        && vcount_in < SIZE + Y_E1 && hcount_in == X_E1 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E1 + 2        && vcount_in < SIZE + Y_E1 && hcount_in == X_E1 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E1 + 3        && vcount_in < SIZE + Y_E1 && hcount_in == X_E1 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E1 + SIZE - 1 && hcount_in > X_E1         && hcount_in < SIZE + X_E1)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E1 + SIZE - 2 && hcount_in > X_E1 + 1     && hcount_in < SIZE + X_E1)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E1 + SIZE - 3 && hcount_in > X_E1 + 2     && hcount_in < SIZE + X_E1)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E1 && vcount_in < SIZE + Y_E1 && hcount_in >= X_E1 && hcount_in < SIZE + X_E1) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E2     && vcount_in < SIZE + Y_E2 - 1  && hcount_in == X_E2)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E2     && vcount_in < SIZE + Y_E2 - 2  && hcount_in == X_E2 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E2     && vcount_in < SIZE + Y_E2 - 3  && hcount_in == X_E2 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E2     && hcount_in > X_E2             && hcount_in < SIZE + X_E2 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E2 + 1 && hcount_in > X_E2             && hcount_in < SIZE + X_E2 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E2 + 2 && hcount_in > X_E2             && hcount_in < SIZE + X_E2 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E2 + 1        && vcount_in < SIZE + Y_E2 && hcount_in == X_E2 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E2 + 2        && vcount_in < SIZE + Y_E2 && hcount_in == X_E2 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E2 + 3        && vcount_in < SIZE + Y_E2 && hcount_in == X_E2 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E2 + SIZE - 1 && hcount_in > X_E2         && hcount_in < SIZE + X_E2)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E2 + SIZE - 2 && hcount_in > X_E2 + 1     && hcount_in < SIZE + X_E2)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E2 + SIZE - 3 && hcount_in > X_E2 + 2     && hcount_in < SIZE + X_E2)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E2 && vcount_in < SIZE + Y_E2 && hcount_in >= X_E2 && hcount_in < SIZE + X_E2) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E3     && vcount_in < SIZE + Y_E3 - 1  && hcount_in == X_E3)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E3     && vcount_in < SIZE + Y_E3 - 2  && hcount_in == X_E3 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E3     && vcount_in < SIZE + Y_E3 - 3  && hcount_in == X_E3 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E3     && hcount_in > X_E3             && hcount_in < SIZE + X_E3 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E3 + 1 && hcount_in > X_E3             && hcount_in < SIZE + X_E3 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E3 + 2 && hcount_in > X_E3             && hcount_in < SIZE + X_E3 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E3 + 1        && vcount_in < SIZE + Y_E3 && hcount_in == X_E3 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E3 + 2        && vcount_in < SIZE + Y_E3 && hcount_in == X_E3 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E3 + 3        && vcount_in < SIZE + Y_E3 && hcount_in == X_E3 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E3 + SIZE - 1 && hcount_in > X_E3         && hcount_in < SIZE + X_E3)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E3 + SIZE - 2 && hcount_in > X_E3 + 1     && hcount_in < SIZE + X_E3)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E3 + SIZE - 3 && hcount_in > X_E3 + 2     && hcount_in < SIZE + X_E3)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E3 && vcount_in < SIZE + Y_E3 && hcount_in >= X_E3 && hcount_in < SIZE + X_E3) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E4     && vcount_in < SIZE + Y_E4 - 1  && hcount_in == X_E4)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E4     && vcount_in < SIZE + Y_E4 - 2  && hcount_in == X_E4 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E4     && vcount_in < SIZE + Y_E4 - 3  && hcount_in == X_E4 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E4     && hcount_in > X_E4             && hcount_in < SIZE + X_E4 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E4 + 1 && hcount_in > X_E4             && hcount_in < SIZE + X_E4 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E4 + 2 && hcount_in > X_E4             && hcount_in < SIZE + X_E4 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E4 + 1        && vcount_in < SIZE + Y_E4 && hcount_in == X_E4 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E4 + 2        && vcount_in < SIZE + Y_E4 && hcount_in == X_E4 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E4 + 3        && vcount_in < SIZE + Y_E4 && hcount_in == X_E4 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E4 + SIZE - 1 && hcount_in > X_E4         && hcount_in < SIZE + X_E4)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E4 + SIZE - 2 && hcount_in > X_E4 + 1     && hcount_in < SIZE + X_E4)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E4 + SIZE - 3 && hcount_in > X_E4 + 2     && hcount_in < SIZE + X_E4)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E4 && vcount_in < SIZE + Y_E4 && hcount_in >= X_E4 && hcount_in < SIZE + X_E4) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E5     && vcount_in < SIZE + Y_E5 - 1  && hcount_in == X_E5)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E5     && vcount_in < SIZE + Y_E5 - 2  && hcount_in == X_E5 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E5     && vcount_in < SIZE + Y_E5 - 3  && hcount_in == X_E5 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E5     && hcount_in > X_E5             && hcount_in < SIZE + X_E5 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E5 + 1 && hcount_in > X_E5             && hcount_in < SIZE + X_E5 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E5 + 2 && hcount_in > X_E5             && hcount_in < SIZE + X_E5 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E5 + 1        && vcount_in < SIZE + Y_E5 && hcount_in == X_E5 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E5 + 2        && vcount_in < SIZE + Y_E5 && hcount_in == X_E5 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E5 + 3        && vcount_in < SIZE + Y_E5 && hcount_in == X_E5 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E5 + SIZE - 1 && hcount_in > X_E5         && hcount_in < SIZE + X_E5)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E5 + SIZE - 2 && hcount_in > X_E5 + 1     && hcount_in < SIZE + X_E5)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E5 + SIZE - 3 && hcount_in > X_E5 + 2     && hcount_in < SIZE + X_E5)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E5 && vcount_in < SIZE + Y_E5 && hcount_in >= X_E5 && hcount_in < SIZE + X_E5) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E6     && vcount_in < SIZE + Y_E6 - 1  && hcount_in == X_E6)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E6     && vcount_in < SIZE + Y_E6 - 2  && hcount_in == X_E6 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E6     && vcount_in < SIZE + Y_E6 - 3  && hcount_in == X_E6 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E6     && hcount_in > X_E6             && hcount_in < SIZE + X_E6 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E6 + 1 && hcount_in > X_E6             && hcount_in < SIZE + X_E6 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E6 + 2 && hcount_in > X_E6             && hcount_in < SIZE + X_E6 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E6 + 1        && vcount_in < SIZE + Y_E6 && hcount_in == X_E6 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E6 + 2        && vcount_in < SIZE + Y_E6 && hcount_in == X_E6 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E6 + 3        && vcount_in < SIZE + Y_E6 && hcount_in == X_E6 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E6 + SIZE - 1 && hcount_in > X_E6         && hcount_in < SIZE + X_E6)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E6 + SIZE - 2 && hcount_in > X_E6 + 1     && hcount_in < SIZE + X_E6)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E6 + SIZE - 3 && hcount_in > X_E6 + 2     && hcount_in < SIZE + X_E6)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E6 && vcount_in < SIZE + Y_E6 && hcount_in >= X_E6 && hcount_in < SIZE + X_E6) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E7     && vcount_in < SIZE + Y_E7 - 1  && hcount_in == X_E7)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E7     && vcount_in < SIZE + Y_E7 - 2  && hcount_in == X_E7 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E7     && vcount_in < SIZE + Y_E7 - 3  && hcount_in == X_E7 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E7     && hcount_in > X_E7             && hcount_in < SIZE + X_E7 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E7 + 1 && hcount_in > X_E7             && hcount_in < SIZE + X_E7 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E7 + 2 && hcount_in > X_E7             && hcount_in < SIZE + X_E7 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E7 + 1        && vcount_in < SIZE + Y_E7 && hcount_in == X_E7 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E7 + 2        && vcount_in < SIZE + Y_E7 && hcount_in == X_E7 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E7 + 3        && vcount_in < SIZE + Y_E7 && hcount_in == X_E7 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E7 + SIZE - 1 && hcount_in > X_E7         && hcount_in < SIZE + X_E7)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E7 + SIZE - 2 && hcount_in > X_E7 + 1     && hcount_in < SIZE + X_E7)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E7 + SIZE - 3 && hcount_in > X_E7 + 2     && hcount_in < SIZE + X_E7)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E7 && vcount_in < SIZE + Y_E7 && hcount_in >= X_E7 && hcount_in < SIZE + X_E7) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E8     && vcount_in < SIZE + Y_E8 - 1  && hcount_in == X_E8)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E8     && vcount_in < SIZE + Y_E8 - 2  && hcount_in == X_E8 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E8     && vcount_in < SIZE + Y_E8 - 3  && hcount_in == X_E8 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E8     && hcount_in > X_E8             && hcount_in < SIZE + X_E8 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E8 + 1 && hcount_in > X_E8             && hcount_in < SIZE + X_E8 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E8 + 2 && hcount_in > X_E8             && hcount_in < SIZE + X_E8 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E8 + 1        && vcount_in < SIZE + Y_E8 && hcount_in == X_E8 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E8 + 2        && vcount_in < SIZE + Y_E8 && hcount_in == X_E8 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E8 + 3        && vcount_in < SIZE + Y_E8 && hcount_in == X_E8 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E8 + SIZE - 1 && hcount_in > X_E8         && hcount_in < SIZE + X_E8)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E8 + SIZE - 2 && hcount_in > X_E8 + 1     && hcount_in < SIZE + X_E8)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E8 + SIZE - 3 && hcount_in > X_E8 + 2     && hcount_in < SIZE + X_E8)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E8 && vcount_in < SIZE + Y_E8 && hcount_in >= X_E8 && hcount_in < SIZE + X_E8) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E9     && vcount_in < SIZE + Y_E9 - 1  && hcount_in == X_E9)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E9     && vcount_in < SIZE + Y_E9 - 2  && hcount_in == X_E9 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E9     && vcount_in < SIZE + Y_E9 - 3  && hcount_in == X_E9 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E9     && hcount_in > X_E9             && hcount_in < SIZE + X_E9 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E9 + 1 && hcount_in > X_E9             && hcount_in < SIZE + X_E9 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E9 + 2 && hcount_in > X_E9             && hcount_in < SIZE + X_E9 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E9 + 1        && vcount_in < SIZE + Y_E9 && hcount_in == X_E9 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E9 + 2        && vcount_in < SIZE + Y_E9 && hcount_in == X_E9 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E9 + 3        && vcount_in < SIZE + Y_E9 && hcount_in == X_E9 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E9 + SIZE - 1 && hcount_in > X_E9         && hcount_in < SIZE + X_E9)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E9 + SIZE - 2 && hcount_in > X_E9 + 1     && hcount_in < SIZE + X_E9)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E9 + SIZE - 3 && hcount_in > X_E9 + 2     && hcount_in < SIZE + X_E9)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E9 && vcount_in < SIZE + Y_E9 && hcount_in >= X_E9 && hcount_in < SIZE + X_E9) rgb_out_nxt = 12'hf_f_0;
    
    else if (vcount_in >= Y_E10     && vcount_in < SIZE + Y_E10 - 1  && hcount_in == X_E10)            rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E10     && vcount_in < SIZE + Y_E10 - 2  && hcount_in == X_E10 + 1)        rgb_out_nxt = 12'hf_f_8; 
    else if (vcount_in >= Y_E10     && vcount_in < SIZE + Y_E10 - 3  && hcount_in == X_E10 + 2)        rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E10     && hcount_in > X_E10             && hcount_in < SIZE + X_E10 - 1) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E10 + 1 && hcount_in > X_E10             && hcount_in < SIZE + X_E10 - 2) rgb_out_nxt = 12'hf_f_8;
    else if (vcount_in == Y_E10 + 2 && hcount_in > X_E10             && hcount_in < SIZE + X_E10 - 3) rgb_out_nxt = 12'hf_f_8;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_E10 + 1        && vcount_in < SIZE + Y_E10 && hcount_in == X_E10 + SIZE - 1) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E10 + 2        && vcount_in < SIZE + Y_E10 && hcount_in == X_E10 + SIZE - 2) rgb_out_nxt = 12'hb_b_6; 
    else if (vcount_in >= Y_E10 + 3        && vcount_in < SIZE + Y_E10 && hcount_in == X_E10 + SIZE - 3) rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E10 + SIZE - 1 && hcount_in > X_E10         && hcount_in < SIZE + X_E10)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E10 + SIZE - 2 && hcount_in > X_E10 + 1     && hcount_in < SIZE + X_E10)     rgb_out_nxt = 12'hb_b_6;
    else if (vcount_in == Y_E10 + SIZE - 3 && hcount_in > X_E10 + 2     && hcount_in < SIZE + X_E10)     rgb_out_nxt = 12'hb_b_6;          
    // inside color
    else if (vcount_in >= Y_E10 && vcount_in < SIZE + Y_E10 && hcount_in >= X_E10 && hcount_in < SIZE + X_E10) rgb_out_nxt = 12'hf_f_0;
    //T2 of TETRIS
    else if (vcount_in >= Y_T11     && vcount_in < SIZE + Y_T11 - 1  && hcount_in == X_T11)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T11     && vcount_in < SIZE + Y_T11 - 2  && hcount_in == X_T11 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T11     && vcount_in < SIZE + Y_T11 - 3  && hcount_in == X_T11 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T11     && hcount_in > X_T11             && hcount_in < SIZE + X_T11 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T11 + 1 && hcount_in > X_T11             && hcount_in < SIZE + X_T11 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T11 + 2 && hcount_in > X_T11             && hcount_in < SIZE + X_T11 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T11 + 1        && vcount_in < SIZE + Y_T11 && hcount_in == X_T11 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T11 + 2        && vcount_in < SIZE + Y_T11 && hcount_in == X_T11 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T11 + 3        && vcount_in < SIZE + Y_T11 && hcount_in == X_T11 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T11 + SIZE - 1 && hcount_in > X_T11         && hcount_in < SIZE + X_T11)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T11 + SIZE - 2 && hcount_in > X_T11 + 1     && hcount_in < SIZE + X_T11)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T11 + SIZE - 3 && hcount_in > X_T11 + 2     && hcount_in < SIZE + X_T11)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T11 && vcount_in < SIZE + Y_T11 && hcount_in >= X_T11 && hcount_in < SIZE + X_T11) rgb_out_nxt = 12'hf_0_f;
          
    else if (vcount_in >= Y_T12     && vcount_in < SIZE + Y_T12 - 1  && hcount_in == X_T12)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T12     && vcount_in < SIZE + Y_T12 - 2  && hcount_in == X_T12 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T12     && vcount_in < SIZE + Y_T12 - 3  && hcount_in == X_T12 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T12     && hcount_in > X_T12             && hcount_in < SIZE + X_T12 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T12 + 1 && hcount_in > X_T12             && hcount_in < SIZE + X_T12 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T12 + 2 && hcount_in > X_T12             && hcount_in < SIZE + X_T12 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T12 + 1        && vcount_in < SIZE + Y_T12 && hcount_in == X_T12 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T12 + 2        && vcount_in < SIZE + Y_T12 && hcount_in == X_T12 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T12 + 3        && vcount_in < SIZE + Y_T12 && hcount_in == X_T12 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T12 + SIZE - 1 && hcount_in > X_T12         && hcount_in < SIZE + X_T12)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T12 + SIZE - 2 && hcount_in > X_T12 + 1     && hcount_in < SIZE + X_T12)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T12 + SIZE - 3 && hcount_in > X_T12 + 2     && hcount_in < SIZE + X_T12)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T12 && vcount_in < SIZE + Y_T12 && hcount_in >= X_T12 && hcount_in < SIZE + X_T12) rgb_out_nxt = 12'hf_0_f;
          
          else if (vcount_in >= Y_T13     && vcount_in < SIZE + Y_T13 - 1  && hcount_in == X_T13)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T13     && vcount_in < SIZE + Y_T13 - 2  && hcount_in == X_T13 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T13     && vcount_in < SIZE + Y_T13 - 3  && hcount_in == X_T13 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T13     && hcount_in > X_T13             && hcount_in < SIZE + X_T13 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T13 + 1 && hcount_in > X_T13             && hcount_in < SIZE + X_T13 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T13 + 2 && hcount_in > X_T13             && hcount_in < SIZE + X_T13 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T13 + 1        && vcount_in < SIZE + Y_T13 && hcount_in == X_T13 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T13 + 2        && vcount_in < SIZE + Y_T13 && hcount_in == X_T13 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T13 + 3        && vcount_in < SIZE + Y_T13 && hcount_in == X_T13 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T13 + SIZE - 1 && hcount_in > X_T13         && hcount_in < SIZE + X_T13)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T13 + SIZE - 2 && hcount_in > X_T13 + 1     && hcount_in < SIZE + X_T13)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T13 + SIZE - 3 && hcount_in > X_T13 + 2     && hcount_in < SIZE + X_T13)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T13 && vcount_in < SIZE + Y_T13 && hcount_in >= X_T13 && hcount_in < SIZE + X_T13) rgb_out_nxt = 12'hf_0_f;
    
    else if (vcount_in >= Y_T14     && vcount_in < SIZE + Y_T14 - 1  && hcount_in == X_T14)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T14     && vcount_in < SIZE + Y_T14 - 2  && hcount_in == X_T14 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T14     && vcount_in < SIZE + Y_T14 - 3  && hcount_in == X_T14 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T14     && hcount_in > X_T14             && hcount_in < SIZE + X_T14 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T14 + 1 && hcount_in > X_T14             && hcount_in < SIZE + X_T14 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T14 + 2 && hcount_in > X_T14             && hcount_in < SIZE + X_T14 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T14 + 1        && vcount_in < SIZE + Y_T14 && hcount_in == X_T14 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T14 + 2        && vcount_in < SIZE + Y_T14 && hcount_in == X_T14 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T14 + 3        && vcount_in < SIZE + Y_T14 && hcount_in == X_T14 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T14 + SIZE - 1 && hcount_in > X_T14         && hcount_in < SIZE + X_T14)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T14 + SIZE - 2 && hcount_in > X_T14 + 1     && hcount_in < SIZE + X_T14)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T14 + SIZE - 3 && hcount_in > X_T14 + 2     && hcount_in < SIZE + X_T14)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T14 && vcount_in < SIZE + Y_T14 && hcount_in >= X_T14 && hcount_in < SIZE + X_T14) rgb_out_nxt = 12'hf_0_f;
    
    else if (vcount_in >= Y_T15     && vcount_in < SIZE + Y_T15 - 1  && hcount_in == X_T15)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T15     && vcount_in < SIZE + Y_T15 - 2  && hcount_in == X_T15 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T15     && vcount_in < SIZE + Y_T15 - 3  && hcount_in == X_T15 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T15     && hcount_in > X_T15             && hcount_in < SIZE + X_T15 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T15 + 1 && hcount_in > X_T15             && hcount_in < SIZE + X_T15 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T15 + 2 && hcount_in > X_T15             && hcount_in < SIZE + X_T15 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T15 + 1        && vcount_in < SIZE + Y_T15 && hcount_in == X_T15 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T15 + 2        && vcount_in < SIZE + Y_T15 && hcount_in == X_T15 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T15 + 3        && vcount_in < SIZE + Y_T15 && hcount_in == X_T15 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T15 + SIZE - 1 && hcount_in > X_T15         && hcount_in < SIZE + X_T15)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T15 + SIZE - 2 && hcount_in > X_T15 + 1     && hcount_in < SIZE + X_T15)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T15 + SIZE - 3 && hcount_in > X_T15 + 2     && hcount_in < SIZE + X_T15)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T15 && vcount_in < SIZE + Y_T15 && hcount_in >= X_T15 && hcount_in < SIZE + X_T15) rgb_out_nxt = 12'hf_0_f;
    
    else if (vcount_in >= Y_T16     && vcount_in < SIZE + Y_T16 - 1  && hcount_in == X_T16)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T16     && vcount_in < SIZE + Y_T16 - 2  && hcount_in == X_T16 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T16     && vcount_in < SIZE + Y_T16 - 3  && hcount_in == X_T16 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T16     && hcount_in > X_T16             && hcount_in < SIZE + X_T16 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T16 + 1 && hcount_in > X_T16             && hcount_in < SIZE + X_T16 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T16 + 2 && hcount_in > X_T16             && hcount_in < SIZE + X_T16 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T16 + 1        && vcount_in < SIZE + Y_T16 && hcount_in == X_T16 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T16 + 2        && vcount_in < SIZE + Y_T16 && hcount_in == X_T16 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T16 + 3        && vcount_in < SIZE + Y_T16 && hcount_in == X_T16 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T16 + SIZE - 1 && hcount_in > X_T16         && hcount_in < SIZE + X_T16)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T16 + SIZE - 2 && hcount_in > X_T16 + 1     && hcount_in < SIZE + X_T16)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T16 + SIZE - 3 && hcount_in > X_T16 + 2     && hcount_in < SIZE + X_T16)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T16 && vcount_in < SIZE + Y_T16 && hcount_in >= X_T16 && hcount_in < SIZE + X_T16) rgb_out_nxt = 12'hf_0_f;
    
    else if (vcount_in >= Y_T17     && vcount_in < SIZE + Y_T17 - 1  && hcount_in == X_T17)            rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T17     && vcount_in < SIZE + Y_T17 - 2  && hcount_in == X_T17 + 1)        rgb_out_nxt = 12'he_8_e; 
    else if (vcount_in >= Y_T17     && vcount_in < SIZE + Y_T17 - 3  && hcount_in == X_T17 + 2)        rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T17     && hcount_in > X_T17             && hcount_in < SIZE + X_T17 - 1) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T17 + 1 && hcount_in > X_T17             && hcount_in < SIZE + X_T17 - 2) rgb_out_nxt = 12'he_8_e;
    else if (vcount_in == Y_T17 + 2 && hcount_in > X_T17             && hcount_in < SIZE + X_T17 - 3) rgb_out_nxt = 12'he_8_e;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_T17 + 1        && vcount_in < SIZE + Y_T17 && hcount_in == X_T17 + SIZE - 1) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T17 + 2        && vcount_in < SIZE + Y_T17 && hcount_in == X_T17 + SIZE - 2) rgb_out_nxt = 12'h8_0_8; 
    else if (vcount_in >= Y_T17 + 3        && vcount_in < SIZE + Y_T17 && hcount_in == X_T17 + SIZE - 3) rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T17 + SIZE - 1 && hcount_in > X_T17         && hcount_in < SIZE + X_T17)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T17 + SIZE - 2 && hcount_in > X_T17 + 1     && hcount_in < SIZE + X_T17)     rgb_out_nxt = 12'h8_0_8;
    else if (vcount_in == Y_T17 + SIZE - 3 && hcount_in > X_T17 + 2     && hcount_in < SIZE + X_T17)     rgb_out_nxt = 12'h8_0_8;          
    // inside color
    else if (vcount_in >= Y_T17 && vcount_in < SIZE + Y_T17 && hcount_in >= X_T17 && hcount_in < SIZE + X_T17) rgb_out_nxt = 12'hf_0_f; 
    // R of TETRIS
    else if (vcount_in >= Y_R1     && vcount_in < SIZE + Y_R1 - 1  && hcount_in == X_R1)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R1     && vcount_in < SIZE + Y_R1 - 2  && hcount_in == X_R1 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R1     && vcount_in < SIZE + Y_R1 - 3  && hcount_in == X_R1 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R1     && hcount_in > X_R1             && hcount_in < SIZE + X_R1 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R1 + 1 && hcount_in > X_R1             && hcount_in < SIZE + X_R1 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R1 + 2 && hcount_in > X_R1             && hcount_in < SIZE + X_R1 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R1 + 1        && vcount_in < SIZE + Y_R1 && hcount_in == X_R1 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R1 + 2        && vcount_in < SIZE + Y_R1 && hcount_in == X_R1 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R1 + 3        && vcount_in < SIZE + Y_R1 && hcount_in == X_R1 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R1 + SIZE - 1 && hcount_in > X_R1         && hcount_in < SIZE + X_R1)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R1 + SIZE - 2 && hcount_in > X_R1 + 1     && hcount_in < SIZE + X_R1)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R1 + SIZE - 3 && hcount_in > X_R1 + 2     && hcount_in < SIZE + X_R1)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R1 && vcount_in < SIZE + Y_R1 && hcount_in >= X_R1 && hcount_in < SIZE + X_R1) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R2     && vcount_in < SIZE + Y_R2 - 1  && hcount_in == X_R2)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R2     && vcount_in < SIZE + Y_R2 - 2  && hcount_in == X_R2 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R2     && vcount_in < SIZE + Y_R2 - 3  && hcount_in == X_R2 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R2     && hcount_in > X_R2             && hcount_in < SIZE + X_R2 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R2 + 1 && hcount_in > X_R2             && hcount_in < SIZE + X_R2 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R2 + 2 && hcount_in > X_R2             && hcount_in < SIZE + X_R2 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R2 + 1        && vcount_in < SIZE + Y_R2 && hcount_in == X_R2 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R2 + 2        && vcount_in < SIZE + Y_R2 && hcount_in == X_R2 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R2 + 3        && vcount_in < SIZE + Y_R2 && hcount_in == X_R2 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R2 + SIZE - 1 && hcount_in > X_R2         && hcount_in < SIZE + X_R2)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R2 + SIZE - 2 && hcount_in > X_R2 + 1     && hcount_in < SIZE + X_R2)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R2 + SIZE - 3 && hcount_in > X_R2 + 2     && hcount_in < SIZE + X_R2)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R2 && vcount_in < SIZE + Y_R2 && hcount_in >= X_R2 && hcount_in < SIZE + X_R2) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R3     && vcount_in < SIZE + Y_R3 - 1  && hcount_in == X_R3)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R3     && vcount_in < SIZE + Y_R3 - 2  && hcount_in == X_R3 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R3     && vcount_in < SIZE + Y_R3 - 3  && hcount_in == X_R3 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R3     && hcount_in > X_R3             && hcount_in < SIZE + X_R3 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R3 + 1 && hcount_in > X_R3             && hcount_in < SIZE + X_R3 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R3 + 2 && hcount_in > X_R3             && hcount_in < SIZE + X_R3 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R3 + 1        && vcount_in < SIZE + Y_R3 && hcount_in == X_R3 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R3 + 2        && vcount_in < SIZE + Y_R3 && hcount_in == X_R3 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R3 + 3        && vcount_in < SIZE + Y_R3 && hcount_in == X_R3 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R3 + SIZE - 1 && hcount_in > X_R3         && hcount_in < SIZE + X_R3)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R3 + SIZE - 2 && hcount_in > X_R3 + 1     && hcount_in < SIZE + X_R3)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R3 + SIZE - 3 && hcount_in > X_R3 + 2     && hcount_in < SIZE + X_R3)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R3 && vcount_in < SIZE + Y_R3 && hcount_in >= X_R3 && hcount_in < SIZE + X_R3) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R4     && vcount_in < SIZE + Y_R4 - 1  && hcount_in == X_R4)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R4     && vcount_in < SIZE + Y_R4 - 2  && hcount_in == X_R4 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R4     && vcount_in < SIZE + Y_R4 - 3  && hcount_in == X_R4 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R4     && hcount_in > X_R4             && hcount_in < SIZE + X_R4 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R4 + 1 && hcount_in > X_R4             && hcount_in < SIZE + X_R4 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R4 + 2 && hcount_in > X_R4             && hcount_in < SIZE + X_R4 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R4 + 1        && vcount_in < SIZE + Y_R4 && hcount_in == X_R4 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R4 + 2        && vcount_in < SIZE + Y_R4 && hcount_in == X_R4 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R4 + 3        && vcount_in < SIZE + Y_R4 && hcount_in == X_R4 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R4 + SIZE - 1 && hcount_in > X_R4         && hcount_in < SIZE + X_R4)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R4 + SIZE - 2 && hcount_in > X_R4 + 1     && hcount_in < SIZE + X_R4)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R4 + SIZE - 3 && hcount_in > X_R4 + 2     && hcount_in < SIZE + X_R4)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R4 && vcount_in < SIZE + Y_R4 && hcount_in >= X_R4 && hcount_in < SIZE + X_R4) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R5     && vcount_in < SIZE + Y_R5 - 1  && hcount_in == X_R5)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R5     && vcount_in < SIZE + Y_R5 - 2  && hcount_in == X_R5 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R5     && vcount_in < SIZE + Y_R5 - 3  && hcount_in == X_R5 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R5     && hcount_in > X_R5             && hcount_in < SIZE + X_R5 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R5 + 1 && hcount_in > X_R5             && hcount_in < SIZE + X_R5 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R5 + 2 && hcount_in > X_R5             && hcount_in < SIZE + X_R5 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R5 + 1        && vcount_in < SIZE + Y_R5 && hcount_in == X_R5 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R5 + 2        && vcount_in < SIZE + Y_R5 && hcount_in == X_R5 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R5 + 3        && vcount_in < SIZE + Y_R5 && hcount_in == X_R5 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R5 + SIZE - 1 && hcount_in > X_R5         && hcount_in < SIZE + X_R5)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R5 + SIZE - 2 && hcount_in > X_R5 + 1     && hcount_in < SIZE + X_R5)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R5 + SIZE - 3 && hcount_in > X_R5 + 2     && hcount_in < SIZE + X_R5)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R5 && vcount_in < SIZE + Y_R5 && hcount_in >= X_R5 && hcount_in < SIZE + X_R5) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R6     && vcount_in < SIZE + Y_R6 - 1  && hcount_in == X_R6)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R6     && vcount_in < SIZE + Y_R6 - 2  && hcount_in == X_R6 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R6     && vcount_in < SIZE + Y_R6 - 3  && hcount_in == X_R6 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R6     && hcount_in > X_R6             && hcount_in < SIZE + X_R6 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R6 + 1 && hcount_in > X_R6             && hcount_in < SIZE + X_R6 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R6 + 2 && hcount_in > X_R6             && hcount_in < SIZE + X_R6 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R6 + 1        && vcount_in < SIZE + Y_R6 && hcount_in == X_R6 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R6 + 2        && vcount_in < SIZE + Y_R6 && hcount_in == X_R6 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R6 + 3        && vcount_in < SIZE + Y_R6 && hcount_in == X_R6 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R6 + SIZE - 1 && hcount_in > X_R6         && hcount_in < SIZE + X_R6)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R6 + SIZE - 2 && hcount_in > X_R6 + 1     && hcount_in < SIZE + X_R6)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R6 + SIZE - 3 && hcount_in > X_R6 + 2     && hcount_in < SIZE + X_R6)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R6 && vcount_in < SIZE + Y_R6 && hcount_in >= X_R6 && hcount_in < SIZE + X_R6) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R7     && vcount_in < SIZE + Y_R7 - 1  && hcount_in == X_R7)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R7     && vcount_in < SIZE + Y_R7 - 2  && hcount_in == X_R7 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R7     && vcount_in < SIZE + Y_R7 - 3  && hcount_in == X_R7 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R7     && hcount_in > X_R7             && hcount_in < SIZE + X_R7 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R7 + 1 && hcount_in > X_R7             && hcount_in < SIZE + X_R7 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R7 + 2 && hcount_in > X_R7             && hcount_in < SIZE + X_R7 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R7 + 1        && vcount_in < SIZE + Y_R7 && hcount_in == X_R7 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R7 + 2        && vcount_in < SIZE + Y_R7 && hcount_in == X_R7 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R7 + 3        && vcount_in < SIZE + Y_R7 && hcount_in == X_R7 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R7 + SIZE - 1 && hcount_in > X_R7         && hcount_in < SIZE + X_R7)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R7 + SIZE - 2 && hcount_in > X_R7 + 1     && hcount_in < SIZE + X_R7)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R7 + SIZE - 3 && hcount_in > X_R7 + 2     && hcount_in < SIZE + X_R7)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R7 && vcount_in < SIZE + Y_R7 && hcount_in >= X_R7 && hcount_in < SIZE + X_R7) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R8     && vcount_in < SIZE + Y_R8 - 1  && hcount_in == X_R8)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R8     && vcount_in < SIZE + Y_R8 - 2  && hcount_in == X_R8 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R8     && vcount_in < SIZE + Y_R8 - 3  && hcount_in == X_R8 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R8     && hcount_in > X_R8             && hcount_in < SIZE + X_R8 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R8 + 1 && hcount_in > X_R8             && hcount_in < SIZE + X_R8 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R8 + 2 && hcount_in > X_R8             && hcount_in < SIZE + X_R8 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R8 + 1        && vcount_in < SIZE + Y_R8 && hcount_in == X_R8 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R8 + 2        && vcount_in < SIZE + Y_R8 && hcount_in == X_R8 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R8 + 3        && vcount_in < SIZE + Y_R8 && hcount_in == X_R8 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R8 + SIZE - 1 && hcount_in > X_R8         && hcount_in < SIZE + X_R8)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R8 + SIZE - 2 && hcount_in > X_R8 + 1     && hcount_in < SIZE + X_R8)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R8 + SIZE - 3 && hcount_in > X_R8 + 2     && hcount_in < SIZE + X_R8)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R8 && vcount_in < SIZE + Y_R8 && hcount_in >= X_R8 && hcount_in < SIZE + X_R8) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R9     && vcount_in < SIZE + Y_R9 - 1  && hcount_in == X_R9)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R9     && vcount_in < SIZE + Y_R9 - 2  && hcount_in == X_R9 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R9     && vcount_in < SIZE + Y_R9 - 3  && hcount_in == X_R9 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R9     && hcount_in > X_R9             && hcount_in < SIZE + X_R9 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R9 + 1 && hcount_in > X_R9             && hcount_in < SIZE + X_R9 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R9 + 2 && hcount_in > X_R9             && hcount_in < SIZE + X_R9 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R9 + 1        && vcount_in < SIZE + Y_R9 && hcount_in == X_R9 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R9 + 2        && vcount_in < SIZE + Y_R9 && hcount_in == X_R9 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R9 + 3        && vcount_in < SIZE + Y_R9 && hcount_in == X_R9 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R9 + SIZE - 1 && hcount_in > X_R9         && hcount_in < SIZE + X_R9)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R9 + SIZE - 2 && hcount_in > X_R9 + 1     && hcount_in < SIZE + X_R9)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R9 + SIZE - 3 && hcount_in > X_R9 + 2     && hcount_in < SIZE + X_R9)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R9 && vcount_in < SIZE + Y_R9 && hcount_in >= X_R9 && hcount_in < SIZE + X_R9) rgb_out_nxt = 12'h0_0_f;
    
    else if (vcount_in >= Y_R10     && vcount_in < SIZE + Y_R10 - 1  && hcount_in == X_R10)            rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R10     && vcount_in < SIZE + Y_R10 - 2  && hcount_in == X_R10 + 1)        rgb_out_nxt = 12'h0_b_f; 
    else if (vcount_in >= Y_R10     && vcount_in < SIZE + Y_R10 - 3  && hcount_in == X_R10 + 2)        rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R10     && hcount_in > X_R10             && hcount_in < SIZE + X_R10 - 1) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R10 + 1 && hcount_in > X_R10             && hcount_in < SIZE + X_R10 - 2) rgb_out_nxt = 12'h0_b_f;
    else if (vcount_in == Y_R10 + 2 && hcount_in > X_R10             && hcount_in < SIZE + X_R10 - 3) rgb_out_nxt = 12'h0_b_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_R10 + 1        && vcount_in < SIZE + Y_R10 && hcount_in == X_R10 + SIZE - 1) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R10 + 2        && vcount_in < SIZE + Y_R10 && hcount_in == X_R10 + SIZE - 2) rgb_out_nxt = 12'h0_0_8; 
    else if (vcount_in >= Y_R10 + 3        && vcount_in < SIZE + Y_R10 && hcount_in == X_R10 + SIZE - 3) rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R10 + SIZE - 1 && hcount_in > X_R10         && hcount_in < SIZE + X_R10)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R10 + SIZE - 2 && hcount_in > X_R10 + 1     && hcount_in < SIZE + X_R10)     rgb_out_nxt = 12'h0_0_8;
    else if (vcount_in == Y_R10 + SIZE - 3 && hcount_in > X_R10 + 2     && hcount_in < SIZE + X_R10)     rgb_out_nxt = 12'h0_0_8;          
    // inside color
    else if (vcount_in >= Y_R10 && vcount_in < SIZE + Y_R10 && hcount_in >= X_R10 && hcount_in < SIZE + X_R10) rgb_out_nxt = 12'h0_0_f;  
    // I of TETRIS
    else if (vcount_in >= Y_I1     && vcount_in < SIZE + Y_I1 - 1  && hcount_in == X_I1)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I1     && vcount_in < SIZE + Y_I1 - 2  && hcount_in == X_I1 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I1     && vcount_in < SIZE + Y_I1 - 3  && hcount_in == X_I1 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I1     && hcount_in > X_I1             && hcount_in < SIZE + X_I1 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I1 + 1 && hcount_in > X_I1             && hcount_in < SIZE + X_I1 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I1 + 2 && hcount_in > X_I1             && hcount_in < SIZE + X_I1 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I1 + 1        && vcount_in < SIZE + Y_I1 && hcount_in == X_I1 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I1 + 2        && vcount_in < SIZE + Y_I1 && hcount_in == X_I1 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I1 + 3        && vcount_in < SIZE + Y_I1 && hcount_in == X_I1 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I1 + SIZE - 1 && hcount_in > X_I1         && hcount_in < SIZE + X_I1)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I1 + SIZE - 2 && hcount_in > X_I1 + 1     && hcount_in < SIZE + X_I1)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I1 + SIZE - 3 && hcount_in > X_I1 + 2     && hcount_in < SIZE + X_I1)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I1 && vcount_in < SIZE + Y_I1 && hcount_in >= X_I1 && hcount_in < SIZE + X_I1) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I2     && vcount_in < SIZE + Y_I2 - 1  && hcount_in == X_I2)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I2     && vcount_in < SIZE + Y_I2 - 2  && hcount_in == X_I2 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I2     && vcount_in < SIZE + Y_I2 - 3  && hcount_in == X_I2 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I2     && hcount_in > X_I2             && hcount_in < SIZE + X_I2 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I2 + 1 && hcount_in > X_I2             && hcount_in < SIZE + X_I2 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I2 + 2 && hcount_in > X_I2             && hcount_in < SIZE + X_I2 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I2 + 1        && vcount_in < SIZE + Y_I2 && hcount_in == X_I2 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I2 + 2        && vcount_in < SIZE + Y_I2 && hcount_in == X_I2 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I2 + 3        && vcount_in < SIZE + Y_I2 && hcount_in == X_I2 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I2 + SIZE - 1 && hcount_in > X_I2         && hcount_in < SIZE + X_I2)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I2 + SIZE - 2 && hcount_in > X_I2 + 1     && hcount_in < SIZE + X_I2)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I2 + SIZE - 3 && hcount_in > X_I2 + 2     && hcount_in < SIZE + X_I2)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I2 && vcount_in < SIZE + Y_I2 && hcount_in >= X_I2 && hcount_in < SIZE + X_I2) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I3     && vcount_in < SIZE + Y_I3 - 1  && hcount_in == X_I3)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I3     && vcount_in < SIZE + Y_I3 - 2  && hcount_in == X_I3 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I3     && vcount_in < SIZE + Y_I3 - 3  && hcount_in == X_I3 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I3     && hcount_in > X_I3             && hcount_in < SIZE + X_I3 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I3 + 1 && hcount_in > X_I3             && hcount_in < SIZE + X_I3 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I3 + 2 && hcount_in > X_I3             && hcount_in < SIZE + X_I3 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I3 + 1        && vcount_in < SIZE + Y_I3 && hcount_in == X_I3 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I3 + 2        && vcount_in < SIZE + Y_I3 && hcount_in == X_I3 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I3 + 3        && vcount_in < SIZE + Y_I3 && hcount_in == X_I3 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I3 + SIZE - 1 && hcount_in > X_I3         && hcount_in < SIZE + X_I3)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I3 + SIZE - 2 && hcount_in > X_I3 + 1     && hcount_in < SIZE + X_I3)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I3 + SIZE - 3 && hcount_in > X_I3 + 2     && hcount_in < SIZE + X_I3)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I3 && vcount_in < SIZE + Y_I3 && hcount_in >= X_I3 && hcount_in < SIZE + X_I3) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I4     && vcount_in < SIZE + Y_I4 - 1  && hcount_in == X_I4)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I4     && vcount_in < SIZE + Y_I4 - 2  && hcount_in == X_I4 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I4     && vcount_in < SIZE + Y_I4 - 3  && hcount_in == X_I4 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I4     && hcount_in > X_I4             && hcount_in < SIZE + X_I4 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I4 + 1 && hcount_in > X_I4             && hcount_in < SIZE + X_I4 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I4 + 2 && hcount_in > X_I4             && hcount_in < SIZE + X_I4 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I4 + 1        && vcount_in < SIZE + Y_I4 && hcount_in == X_I4 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I4 + 2        && vcount_in < SIZE + Y_I4 && hcount_in == X_I4 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I4 + 3        && vcount_in < SIZE + Y_I4 && hcount_in == X_I4 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I4 + SIZE - 1 && hcount_in > X_I4         && hcount_in < SIZE + X_I4)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I4 + SIZE - 2 && hcount_in > X_I4 + 1     && hcount_in < SIZE + X_I4)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I4 + SIZE - 3 && hcount_in > X_I4 + 2     && hcount_in < SIZE + X_I4)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I4 && vcount_in < SIZE + Y_I4 && hcount_in >= X_I4 && hcount_in < SIZE + X_I4) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I5     && vcount_in < SIZE + Y_I5 - 1  && hcount_in == X_I5)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I5     && vcount_in < SIZE + Y_I5 - 2  && hcount_in == X_I5 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I5     && vcount_in < SIZE + Y_I5 - 3  && hcount_in == X_I5 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I5     && hcount_in > X_I5             && hcount_in < SIZE + X_I5 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I5 + 1 && hcount_in > X_I5             && hcount_in < SIZE + X_I5 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I5 + 2 && hcount_in > X_I5             && hcount_in < SIZE + X_I5 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I5 + 1        && vcount_in < SIZE + Y_I5 && hcount_in == X_I5 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I5 + 2        && vcount_in < SIZE + Y_I5 && hcount_in == X_I5 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I5 + 3        && vcount_in < SIZE + Y_I5 && hcount_in == X_I5 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I5 + SIZE - 1 && hcount_in > X_I5         && hcount_in < SIZE + X_I5)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I5 + SIZE - 2 && hcount_in > X_I5 + 1     && hcount_in < SIZE + X_I5)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I5 + SIZE - 3 && hcount_in > X_I5 + 2     && hcount_in < SIZE + X_I5)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I5 && vcount_in < SIZE + Y_I5 && hcount_in >= X_I5 && hcount_in < SIZE + X_I5) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I6     && vcount_in < SIZE + Y_I6 - 1  && hcount_in == X_I6)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I6     && vcount_in < SIZE + Y_I6 - 2  && hcount_in == X_I6 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I6     && vcount_in < SIZE + Y_I6 - 3  && hcount_in == X_I6 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I6     && hcount_in > X_I6             && hcount_in < SIZE + X_I6 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I6 + 1 && hcount_in > X_I6             && hcount_in < SIZE + X_I6 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I6 + 2 && hcount_in > X_I6             && hcount_in < SIZE + X_I6 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I6 + 1        && vcount_in < SIZE + Y_I6 && hcount_in == X_I6 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I6 + 2        && vcount_in < SIZE + Y_I6 && hcount_in == X_I6 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I6 + 3        && vcount_in < SIZE + Y_I6 && hcount_in == X_I6 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I6 + SIZE - 1 && hcount_in > X_I6         && hcount_in < SIZE + X_I6)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I6 + SIZE - 2 && hcount_in > X_I6 + 1     && hcount_in < SIZE + X_I6)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I6 + SIZE - 3 && hcount_in > X_I6 + 2     && hcount_in < SIZE + X_I6)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I6 && vcount_in < SIZE + Y_I6 && hcount_in >= X_I6 && hcount_in < SIZE + X_I6) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I7     && vcount_in < SIZE + Y_I7 - 1  && hcount_in == X_I7)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I7     && vcount_in < SIZE + Y_I7 - 2  && hcount_in == X_I7 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I7     && vcount_in < SIZE + Y_I7 - 3  && hcount_in == X_I7 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I7     && hcount_in > X_I7             && hcount_in < SIZE + X_I7 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I7 + 1 && hcount_in > X_I7             && hcount_in < SIZE + X_I7 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I7 + 2 && hcount_in > X_I7             && hcount_in < SIZE + X_I7 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I7 + 1        && vcount_in < SIZE + Y_I7 && hcount_in == X_I7 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I7 + 2        && vcount_in < SIZE + Y_I7 && hcount_in == X_I7 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I7 + 3        && vcount_in < SIZE + Y_I7 && hcount_in == X_I7 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I7 + SIZE - 1 && hcount_in > X_I7         && hcount_in < SIZE + X_I7)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I7 + SIZE - 2 && hcount_in > X_I7 + 1     && hcount_in < SIZE + X_I7)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I7 + SIZE - 3 && hcount_in > X_I7 + 2     && hcount_in < SIZE + X_I7)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I7 && vcount_in < SIZE + Y_I7 && hcount_in >= X_I7 && hcount_in < SIZE + X_I7) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I8     && vcount_in < SIZE + Y_I8 - 1  && hcount_in == X_I8)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I8     && vcount_in < SIZE + Y_I8 - 2  && hcount_in == X_I8 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I8     && vcount_in < SIZE + Y_I8 - 3  && hcount_in == X_I8 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I8     && hcount_in > X_I8             && hcount_in < SIZE + X_I8 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I8 + 1 && hcount_in > X_I8             && hcount_in < SIZE + X_I8 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I8 + 2 && hcount_in > X_I8             && hcount_in < SIZE + X_I8 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I8 + 1        && vcount_in < SIZE + Y_I8 && hcount_in == X_I8 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I8 + 2        && vcount_in < SIZE + Y_I8 && hcount_in == X_I8 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I8 + 3        && vcount_in < SIZE + Y_I8 && hcount_in == X_I8 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I8 + SIZE - 1 && hcount_in > X_I8         && hcount_in < SIZE + X_I8)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I8 + SIZE - 2 && hcount_in > X_I8 + 1     && hcount_in < SIZE + X_I8)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I8 + SIZE - 3 && hcount_in > X_I8 + 2     && hcount_in < SIZE + X_I8)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I8 && vcount_in < SIZE + Y_I8 && hcount_in >= X_I8 && hcount_in < SIZE + X_I8) rgb_out_nxt = 12'h0_f_0;
    
    else if (vcount_in >= Y_I9     && vcount_in < SIZE + Y_I9 - 1  && hcount_in == X_I9)            rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I9     && vcount_in < SIZE + Y_I9 - 2  && hcount_in == X_I9 + 1)        rgb_out_nxt = 12'h9_f_9; 
    else if (vcount_in >= Y_I9     && vcount_in < SIZE + Y_I9 - 3  && hcount_in == X_I9 + 2)        rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I9     && hcount_in > X_I9             && hcount_in < SIZE + X_I9 - 1) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I9 + 1 && hcount_in > X_I9             && hcount_in < SIZE + X_I9 - 2) rgb_out_nxt = 12'h9_f_9;
    else if (vcount_in == Y_I9 + 2 && hcount_in > X_I9             && hcount_in < SIZE + X_I9 - 3) rgb_out_nxt = 12'h9_f_9;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_I9 + 1        && vcount_in < SIZE + Y_I9 && hcount_in == X_I9 + SIZE - 1) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I9 + 2        && vcount_in < SIZE + Y_I9 && hcount_in == X_I9 + SIZE - 2) rgb_out_nxt = 12'h0_8_0; 
    else if (vcount_in >= Y_I9 + 3        && vcount_in < SIZE + Y_I9 && hcount_in == X_I9 + SIZE - 3) rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I9 + SIZE - 1 && hcount_in > X_I9         && hcount_in < SIZE + X_I9)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I9 + SIZE - 2 && hcount_in > X_I9 + 1     && hcount_in < SIZE + X_I9)     rgb_out_nxt = 12'h0_8_0;
    else if (vcount_in == Y_I9 + SIZE - 3 && hcount_in > X_I9 + 2     && hcount_in < SIZE + X_I9)     rgb_out_nxt = 12'h0_8_0;          
    // inside color
    else if (vcount_in >= Y_I9 && vcount_in < SIZE + Y_I9 && hcount_in >= X_I9 && hcount_in < SIZE + X_I9) rgb_out_nxt = 12'h0_f_0;
    
    // S of TETRIS
    else if (vcount_in >= Y_S1     && vcount_in < SIZE + Y_S1 - 1  && hcount_in == X_S1)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S1     && vcount_in < SIZE + Y_S1 - 2  && hcount_in == X_S1 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S1     && vcount_in < SIZE + Y_S1 - 3  && hcount_in == X_S1 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S1     && hcount_in > X_S1             && hcount_in < SIZE + X_S1 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S1 + 1 && hcount_in > X_S1             && hcount_in < SIZE + X_S1 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S1 + 2 && hcount_in > X_S1             && hcount_in < SIZE + X_S1 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S1 + 1        && vcount_in < SIZE + Y_S1 && hcount_in == X_S1 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S1 + 2        && vcount_in < SIZE + Y_S1 && hcount_in == X_S1 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S1 + 3        && vcount_in < SIZE + Y_S1 && hcount_in == X_S1 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S1 + SIZE - 1 && hcount_in > X_S1         && hcount_in < SIZE + X_S1)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S1 + SIZE - 2 && hcount_in > X_S1 + 1     && hcount_in < SIZE + X_S1)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S1 + SIZE - 3 && hcount_in > X_S1 + 2     && hcount_in < SIZE + X_S1)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S1 && vcount_in < SIZE + Y_S1 && hcount_in >= X_S1 && hcount_in < SIZE + X_S1) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S2     && vcount_in < SIZE + Y_S2 - 1  && hcount_in == X_S2)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S2     && vcount_in < SIZE + Y_S2 - 2  && hcount_in == X_S2 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S2     && vcount_in < SIZE + Y_S2 - 3  && hcount_in == X_S2 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S2     && hcount_in > X_S2             && hcount_in < SIZE + X_S2 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S2 + 1 && hcount_in > X_S2             && hcount_in < SIZE + X_S2 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S2 + 2 && hcount_in > X_S2             && hcount_in < SIZE + X_S2 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S2 + 1        && vcount_in < SIZE + Y_S2 && hcount_in == X_S2 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S2 + 2        && vcount_in < SIZE + Y_S2 && hcount_in == X_S2 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S2 + 3        && vcount_in < SIZE + Y_S2 && hcount_in == X_S2 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S2 + SIZE - 1 && hcount_in > X_S2         && hcount_in < SIZE + X_S2)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S2 + SIZE - 2 && hcount_in > X_S2 + 1     && hcount_in < SIZE + X_S2)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S2 + SIZE - 3 && hcount_in > X_S2 + 2     && hcount_in < SIZE + X_S2)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S2 && vcount_in < SIZE + Y_S2 && hcount_in >= X_S2 && hcount_in < SIZE + X_S2) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S3     && vcount_in < SIZE + Y_S3 - 1  && hcount_in == X_S3)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S3     && vcount_in < SIZE + Y_S3 - 2  && hcount_in == X_S3 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S3     && vcount_in < SIZE + Y_S3 - 3  && hcount_in == X_S3 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S3     && hcount_in > X_S3             && hcount_in < SIZE + X_S3 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S3 + 1 && hcount_in > X_S3             && hcount_in < SIZE + X_S3 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S3 + 2 && hcount_in > X_S3             && hcount_in < SIZE + X_S3 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S3 + 1        && vcount_in < SIZE + Y_S3 && hcount_in == X_S3 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S3 + 2        && vcount_in < SIZE + Y_S3 && hcount_in == X_S3 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S3 + 3        && vcount_in < SIZE + Y_S3 && hcount_in == X_S3 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S3 + SIZE - 1 && hcount_in > X_S3         && hcount_in < SIZE + X_S3)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S3 + SIZE - 2 && hcount_in > X_S3 + 1     && hcount_in < SIZE + X_S3)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S3 + SIZE - 3 && hcount_in > X_S3 + 2     && hcount_in < SIZE + X_S3)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S3 && vcount_in < SIZE + Y_S3 && hcount_in >= X_S3 && hcount_in < SIZE + X_S3) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S4     && vcount_in < SIZE + Y_S4 - 1  && hcount_in == X_S4)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S4     && vcount_in < SIZE + Y_S4 - 2  && hcount_in == X_S4 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S4     && vcount_in < SIZE + Y_S4 - 3  && hcount_in == X_S4 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S4     && hcount_in > X_S4             && hcount_in < SIZE + X_S4 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S4 + 1 && hcount_in > X_S4             && hcount_in < SIZE + X_S4 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S4 + 2 && hcount_in > X_S4             && hcount_in < SIZE + X_S4 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S4 + 1        && vcount_in < SIZE + Y_S4 && hcount_in == X_S4 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S4 + 2        && vcount_in < SIZE + Y_S4 && hcount_in == X_S4 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S4 + 3        && vcount_in < SIZE + Y_S4 && hcount_in == X_S4 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S4 + SIZE - 1 && hcount_in > X_S4         && hcount_in < SIZE + X_S4)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S4 + SIZE - 2 && hcount_in > X_S4 + 1     && hcount_in < SIZE + X_S4)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S4 + SIZE - 3 && hcount_in > X_S4 + 2     && hcount_in < SIZE + X_S4)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S4 && vcount_in < SIZE + Y_S4 && hcount_in >= X_S4 && hcount_in < SIZE + X_S4) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S5     && vcount_in < SIZE + Y_S5 - 1  && hcount_in == X_S5)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S5     && vcount_in < SIZE + Y_S5 - 2  && hcount_in == X_S5 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S5     && vcount_in < SIZE + Y_S5 - 3  && hcount_in == X_S5 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S5     && hcount_in > X_S5             && hcount_in < SIZE + X_S5 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S5 + 1 && hcount_in > X_S5             && hcount_in < SIZE + X_S5 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S5 + 2 && hcount_in > X_S5             && hcount_in < SIZE + X_S5 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S5 + 1        && vcount_in < SIZE + Y_S5 && hcount_in == X_S5 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S5 + 2        && vcount_in < SIZE + Y_S5 && hcount_in == X_S5 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S5 + 3        && vcount_in < SIZE + Y_S5 && hcount_in == X_S5 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S5 + SIZE - 1 && hcount_in > X_S5         && hcount_in < SIZE + X_S5)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S5 + SIZE - 2 && hcount_in > X_S5 + 1     && hcount_in < SIZE + X_S5)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S5 + SIZE - 3 && hcount_in > X_S5 + 2     && hcount_in < SIZE + X_S5)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S5 && vcount_in < SIZE + Y_S5 && hcount_in >= X_S5 && hcount_in < SIZE + X_S5) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S6     && vcount_in < SIZE + Y_S6 - 1  && hcount_in == X_S6)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S6     && vcount_in < SIZE + Y_S6 - 2  && hcount_in == X_S6 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S6     && vcount_in < SIZE + Y_S6 - 3  && hcount_in == X_S6 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S6     && hcount_in > X_S6             && hcount_in < SIZE + X_S6 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S6 + 1 && hcount_in > X_S6             && hcount_in < SIZE + X_S6 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S6 + 2 && hcount_in > X_S6             && hcount_in < SIZE + X_S6 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S6 + 1        && vcount_in < SIZE + Y_S6 && hcount_in == X_S6 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S6 + 2        && vcount_in < SIZE + Y_S6 && hcount_in == X_S6 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S6 + 3        && vcount_in < SIZE + Y_S6 && hcount_in == X_S6 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S6 + SIZE - 1 && hcount_in > X_S6         && hcount_in < SIZE + X_S6)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S6 + SIZE - 2 && hcount_in > X_S6 + 1     && hcount_in < SIZE + X_S6)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S6 + SIZE - 3 && hcount_in > X_S6 + 2     && hcount_in < SIZE + X_S6)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S6 && vcount_in < SIZE + Y_S6 && hcount_in >= X_S6 && hcount_in < SIZE + X_S6) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S7     && vcount_in < SIZE + Y_S7 - 1  && hcount_in == X_S7)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S7     && vcount_in < SIZE + Y_S7 - 2  && hcount_in == X_S7 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S7     && vcount_in < SIZE + Y_S7 - 3  && hcount_in == X_S7 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S7     && hcount_in > X_S7             && hcount_in < SIZE + X_S7 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S7 + 1 && hcount_in > X_S7             && hcount_in < SIZE + X_S7 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S7 + 2 && hcount_in > X_S7             && hcount_in < SIZE + X_S7 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S7 + 1        && vcount_in < SIZE + Y_S7 && hcount_in == X_S7 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S7 + 2        && vcount_in < SIZE + Y_S7 && hcount_in == X_S7 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S7 + 3        && vcount_in < SIZE + Y_S7 && hcount_in == X_S7 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S7 + SIZE - 1 && hcount_in > X_S7         && hcount_in < SIZE + X_S7)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S7 + SIZE - 2 && hcount_in > X_S7 + 1     && hcount_in < SIZE + X_S7)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S7 + SIZE - 3 && hcount_in > X_S7 + 2     && hcount_in < SIZE + X_S7)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S7 && vcount_in < SIZE + Y_S7 && hcount_in >= X_S7 && hcount_in < SIZE + X_S7) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S8     && vcount_in < SIZE + Y_S8 - 1  && hcount_in == X_S8)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S8     && vcount_in < SIZE + Y_S8 - 2  && hcount_in == X_S8 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S8     && vcount_in < SIZE + Y_S8 - 3  && hcount_in == X_S8 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S8     && hcount_in > X_S8             && hcount_in < SIZE + X_S8 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S8 + 1 && hcount_in > X_S8             && hcount_in < SIZE + X_S8 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S8 + 2 && hcount_in > X_S8             && hcount_in < SIZE + X_S8 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S8 + 1        && vcount_in < SIZE + Y_S8 && hcount_in == X_S8 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S8 + 2        && vcount_in < SIZE + Y_S8 && hcount_in == X_S8 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S8 + 3        && vcount_in < SIZE + Y_S8 && hcount_in == X_S8 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S8 + SIZE - 1 && hcount_in > X_S8         && hcount_in < SIZE + X_S8)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S8 + SIZE - 2 && hcount_in > X_S8 + 1     && hcount_in < SIZE + X_S8)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S8 + SIZE - 3 && hcount_in > X_S8 + 2     && hcount_in < SIZE + X_S8)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S8 && vcount_in < SIZE + Y_S8 && hcount_in >= X_S8 && hcount_in < SIZE + X_S8) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S9     && vcount_in < SIZE + Y_S9 - 1  && hcount_in == X_S9)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S9     && vcount_in < SIZE + Y_S9 - 2  && hcount_in == X_S9 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S9     && vcount_in < SIZE + Y_S9 - 3  && hcount_in == X_S9 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S9     && hcount_in > X_S9             && hcount_in < SIZE + X_S9 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S9 + 1 && hcount_in > X_S9             && hcount_in < SIZE + X_S9 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S9 + 2 && hcount_in > X_S9             && hcount_in < SIZE + X_S9 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S9 + 1        && vcount_in < SIZE + Y_S9 && hcount_in == X_S9 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S9 + 2        && vcount_in < SIZE + Y_S9 && hcount_in == X_S9 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S9 + 3        && vcount_in < SIZE + Y_S9 && hcount_in == X_S9 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S9 + SIZE - 1 && hcount_in > X_S9         && hcount_in < SIZE + X_S9)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S9 + SIZE - 2 && hcount_in > X_S9 + 1     && hcount_in < SIZE + X_S9)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S9 + SIZE - 3 && hcount_in > X_S9 + 2     && hcount_in < SIZE + X_S9)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S9 && vcount_in < SIZE + Y_S9 && hcount_in >= X_S9 && hcount_in < SIZE + X_S9) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S10     && vcount_in < SIZE + Y_S10 - 1  && hcount_in == X_S10)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S10     && vcount_in < SIZE + Y_S10 - 2  && hcount_in == X_S10 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S10     && vcount_in < SIZE + Y_S10 - 3  && hcount_in == X_S10 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S10     && hcount_in > X_S10             && hcount_in < SIZE + X_S10 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S10 + 1 && hcount_in > X_S10             && hcount_in < SIZE + X_S10 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S10 + 2 && hcount_in > X_S10             && hcount_in < SIZE + X_S10 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S10 + 1        && vcount_in < SIZE + Y_S10 && hcount_in == X_S10 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S10 + 2        && vcount_in < SIZE + Y_S10 && hcount_in == X_S10 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S10 + 3        && vcount_in < SIZE + Y_S10 && hcount_in == X_S10 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S10 + SIZE - 1 && hcount_in > X_S10         && hcount_in < SIZE + X_S10)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S10 + SIZE - 2 && hcount_in > X_S10 + 1     && hcount_in < SIZE + X_S10)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S10 + SIZE - 3 && hcount_in > X_S10 + 2     && hcount_in < SIZE + X_S10)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S10 && vcount_in < SIZE + Y_S10 && hcount_in >= X_S10 && hcount_in < SIZE + X_S10) rgb_out_nxt = 12'h0_f_f;
    
    else if (vcount_in >= Y_S11     && vcount_in < SIZE + Y_S11 - 1  && hcount_in == X_S11)            rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S11     && vcount_in < SIZE + Y_S11 - 2  && hcount_in == X_S11 + 1)        rgb_out_nxt = 12'hc_f_f; 
    else if (vcount_in >= Y_S11     && vcount_in < SIZE + Y_S11 - 3  && hcount_in == X_S11 + 2)        rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S11     && hcount_in > X_S11             && hcount_in < SIZE + X_S11 - 1) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S11 + 1 && hcount_in > X_S11             && hcount_in < SIZE + X_S11 - 2) rgb_out_nxt = 12'hc_f_f;
    else if (vcount_in == Y_S11 + 2 && hcount_in > X_S11             && hcount_in < SIZE + X_S11 - 3) rgb_out_nxt = 12'hc_f_f;
    // right and bottom edge -> dark
    else if (vcount_in >= Y_S11 + 1        && vcount_in < SIZE + Y_S11 && hcount_in == X_S11 + SIZE - 1) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S11 + 2        && vcount_in < SIZE + Y_S11 && hcount_in == X_S11 + SIZE - 2) rgb_out_nxt = 12'h0_c_f; 
    else if (vcount_in >= Y_S11 + 3        && vcount_in < SIZE + Y_S11 && hcount_in == X_S11 + SIZE - 3) rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S11 + SIZE - 1 && hcount_in > X_S11         && hcount_in < SIZE + X_S11)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S11 + SIZE - 2 && hcount_in > X_S11 + 1     && hcount_in < SIZE + X_S11)     rgb_out_nxt = 12'h0_c_f;
    else if (vcount_in == Y_S11 + SIZE - 3 && hcount_in > X_S11 + 2     && hcount_in < SIZE + X_S11)     rgb_out_nxt = 12'h0_c_f;          
    // inside color
    else if (vcount_in >= Y_S11 && vcount_in < SIZE + Y_S11 && hcount_in >= X_S11 && hcount_in < SIZE + X_S11) rgb_out_nxt = 12'h0_f_f;       
      
      
      
      
      // light blue background
      else if (hcount_in >= vcount_in) rgb_out_nxt <= 12'h8_c_e;
      // dark blue background
      else rgb_out_nxt <= 12'h1_9_f;  
    end
  end
            
            
endmodule