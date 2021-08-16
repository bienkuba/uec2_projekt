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
 input wire [11:0] xpos,
 input wire [11:0] ypos,
 input wire [2:0] block, 
 input wire [2:0] rot,
  
 output reg [10:0] vcount_out,
 output reg vsync_out,
 output reg vblnk_out,
 output reg [10:0] hcount_out,
 output reg hsync_out,
 output reg hblnk_out,
 output reg [11:0] rgb_out
 );
  

  localparam X_CALIB = 201;
  localparam Y_CALIB = 10;
  localparam SIZE  = 35;
 
  localparam I_BLOCK = 'b000;
  localparam O_BLOCK = 'b001;
  localparam T_BLOCK = 'b010;
  localparam S_BLOCK = 'b011;
  localparam Z_BLOCK = 'b100;
  localparam J_BLOCK = 'b101;
  localparam L_BLOCK = 'b110;

  reg [4:0] sq_1_col, sq_2_col, sq_3_col, sq_4_col, sq_1_row, sq_2_row, sq_3_row, sq_4_row;
  reg [11:0] rgb_out_nxt;
           
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
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 2;
            sq_3_row = ypos + 0;            
            sq_4_col = xpos + 3;
            sq_4_row = ypos + 0;       
        end
        O_BLOCK: begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;          
        end
        T_BLOCK: begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;         
        end        
        S_BLOCK: begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;        
        end        
        Z_BLOCK: begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;        
        end
        J_BLOCK: begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;     
        end
        L_BLOCK: begin
            sq_1_col = xpos + 0;
            sq_1_row = ypos + 0;
            sq_2_col = xpos + 1;
            sq_2_row = ypos + 0;            
            sq_3_col = xpos + 0;
            sq_3_row = ypos + 1;            
            sq_4_col = xpos + 1;
            sq_4_row = ypos + 1;        
        end        
      endcase
    end
                 
  always @*
    begin
      if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
        else begin
                 if (vcount_in >= Y_CALIB + 35*sq_1_row && vcount_in < SIZE + Y_CALIB + 35*sq_1_row && hcount_in >= X_CALIB + 35*sq_1_col && hcount_in < SIZE + X_CALIB + 35*sq_1_col) rgb_out_nxt = 12'hf_0_0;
            else if (vcount_in >= Y_CALIB + 35*sq_2_row && vcount_in < SIZE + Y_CALIB + 35*sq_2_row && hcount_in >= X_CALIB + 35*sq_2_col && hcount_in < SIZE + X_CALIB + 35*sq_2_col) rgb_out_nxt = 12'hf_0_0;
            else if (vcount_in >= Y_CALIB + 35*sq_3_row && vcount_in < SIZE + Y_CALIB + 35*sq_3_row && hcount_in >= X_CALIB + 35*sq_3_col && hcount_in < SIZE + X_CALIB + 35*sq_3_col) rgb_out_nxt = 12'hf_0_0;
            else if (vcount_in >= Y_CALIB + 35*sq_4_row && vcount_in < SIZE + Y_CALIB + 35*sq_4_row && hcount_in >= X_CALIB + 35*sq_4_col && hcount_in < SIZE + X_CALIB + 35*sq_4_col) rgb_out_nxt = 12'hf_0_0;
            else rgb_out_nxt = rgb_in;
          end
      end
        
endmodule