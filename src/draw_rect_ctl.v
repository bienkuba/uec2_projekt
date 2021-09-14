`timescale 1ns / 1ps

/*
Autor: Jakub Bien
*/

module draw_rect_ctl(
    input wire       pclk,
    input wire       rst,
    input wire       pad_R,
    input wire       pad_L,
    input wire       pad_D,
    input wire       pad_S,
    input wire       btnL,
    input wire       btnR,
    input wire       btnD,
    input wire       btnU,
    input wire [3:0] sq_1_col,
    input wire [3:0] sq_2_col,
    input wire [3:0] sq_3_col,          
    input wire [3:0] sq_4_col,
    input wire       collision,
    input wire [4:0] random,
    
    output reg [3:0] xpos,
    output reg [4:0] ypos,
    output reg [4:0] block,
    output reg [4:0] buf_block,
    output reg [1:0] rot,
    output reg       lock_en,
    output reg [19:0]points
    );
    
    localparam WAIT_FOR_BTN= 'b0000;
    localparam INIT        = 'b0001;
    localparam IDLE        = 'b0010;
    localparam MOVE_DOWN   = 'b0011;
    localparam MOVE_LEFT   = 'b0100;
    localparam MOVE_RIGHT  = 'b0101;
    localparam HOLD_BTN    = 'b0110;
    localparam STOP        = 'b0111;
    localparam ROT         = 'b1000;
    localparam ROT_OFFSET  = 'b1001;
    localparam CHECK       = 'b1010;
    localparam NEW_BLOCK   = 'b1011;
    
    localparam I_BLOCK = 'b10000;
    localparam O_BLOCK = 'b10001;
    localparam T_BLOCK = 'b10010;
    localparam S_BLOCK = 'b10011;
    localparam Z_BLOCK = 'b10100;
    localparam J_BLOCK = 'b10101;
    localparam L_BLOCK = 'b10110;
    
    reg [1:0]  rot_nxt;
    reg [3:0]  state_nxt, state, level, level_nxt;
    reg [4:0]  block_nxt, xpos_nxt, ypos_nxt, buf_block_nxt;         
    reg [10:0] counter, counter_nxt, lvl_param, lvl_param_nxt;
    reg [19:0] points_nxt;
    reg [26:0] iterator, iterator_nxt;
    
    always@(posedge pclk)
        if (rst) begin
            state <= WAIT_FOR_BTN;
            ypos       <= 0;
            xpos       <= 0;
            counter    <= 0;
            iterator   <= 0;
            block      <= 0;
            rot        <= 0;
            buf_block  <= 0;
            points     <= 0;
            lvl_param  <= 0;
        end
        else begin
            state     <= state_nxt;
            ypos      <= ypos_nxt;
            xpos      <= xpos_nxt;
            counter   <= counter_nxt;
            iterator  <= iterator_nxt;
            block     <= block_nxt;
            rot       <= rot_nxt;
            buf_block <= buf_block_nxt;
            points    <= points_nxt;
            lvl_param <= lvl_param_nxt;
        end
    
    always@* begin
      if(lvl_param == 20) begin
        level_nxt = level + 1;
      end
    end
    
    always@*begin
      case(state)
        WAIT_FOR_BTN:state_nxt = (btnU||btnD||btnL||btnR||!pad_L||!pad_R||!pad_D||!pad_S) ? INIT : WAIT_FOR_BTN;
        INIT:        state_nxt = IDLE;
        IDLE:        state_nxt = (counter > 775-(50*level)) ? CHECK : (btnD||!pad_D) && (counter > (775-(50*level))/10) ? CHECK : (btnR||!pad_R) ? MOVE_RIGHT : (btnL||!pad_L) ? MOVE_LEFT : (btnU||!pad_S) ? ROT : IDLE; 
        MOVE_DOWN:   state_nxt = IDLE;
        CHECK:       state_nxt = collision ? STOP : MOVE_DOWN;
        MOVE_LEFT:   state_nxt = IDLE;
        MOVE_RIGHT:  state_nxt = IDLE;
        STOP:        state_nxt = NEW_BLOCK;
        ROT:         state_nxt = ROT_OFFSET;
        ROT_OFFSET:  state_nxt = IDLE;
        NEW_BLOCK :  state_nxt = IDLE;
      default:
        state_nxt = IDLE;  
      endcase
    end
            
    always@*begin 
      case (state_nxt)  
        WAIT_FOR_BTN: begin
          xpos_nxt = 30;
          ypos_nxt = 21;          
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = random;
          if(random + 1 == 'b10111) buf_block_nxt = 'b10000;
          else buf_block_nxt = random + 1;
          rot_nxt = 0;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
        end  
        INIT: begin
          lock_en = 0;
          xpos_nxt = 5;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          block_nxt = random;
          if(random + 1 == 'b10111) buf_block_nxt = 'b10000;
          else buf_block_nxt = random + 1;
          rot_nxt = 0;
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end         
        IDLE: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;           
          iterator_nxt = iterator + 2;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end 
        MOVE_DOWN: begin
          if((btnD||!pad_D)&& counter>0) points_nxt = points + 1;
          xpos_nxt = xpos;
          ypos_nxt = ypos + 1;          
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
        CHECK: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end          
        MOVE_LEFT: begin
          if((sq_1_col == 0) || (sq_2_col == 0) || (sq_3_col == 0) || (sq_4_col == 0)) xpos_nxt = xpos;
          else xpos_nxt = xpos - 1;
          ypos_nxt = ypos;         
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot; 
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
        MOVE_RIGHT: begin
          if((sq_1_col == 9) || (sq_2_col == 9) || (sq_3_col == 9) || (sq_4_col == 9)) xpos_nxt = xpos;
          else xpos_nxt = xpos + 1;
          ypos_nxt = ypos;           
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
        HOLD_BTN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;  
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>15;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
        STOP: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          rot_nxt = 0;
          block_nxt = block;
          buf_block_nxt = buf_block;
          lock_en = 1;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
        ROT: begin
            if (rot == 3) rot_nxt = 0;
            else rot_nxt = rot + 1;
            xpos_nxt = xpos;
            ypos_nxt = ypos;                
            iterator_nxt = iterator;
            counter_nxt = counter;
            block_nxt = block;
            buf_block_nxt = buf_block;
            lock_en = 0;          
            points_nxt = points;
            lvl_param_nxt = lvl_param;
          end
        ROT_OFFSET: begin
            if(block==I_BLOCK && xpos==9 && (rot == 0 || rot == 2)) xpos_nxt = xpos - 2;
            else if(block==I_BLOCK && xpos==8 && (rot == 0 || rot == 2)) xpos_nxt = xpos - 1;
            else if(block==I_BLOCK && xpos==0 && (rot == 0 || rot == 2)) xpos_nxt = xpos + 1;
            else if(block==T_BLOCK && xpos==9 && rot == 2) xpos_nxt = xpos - 1;
            else if(block==T_BLOCK && xpos==0 && rot == 0) xpos_nxt = xpos + 1;
            else if(block==S_BLOCK && xpos==0 && (rot == 0 || rot == 2)) xpos_nxt = xpos + 1;
            else if(block==Z_BLOCK && xpos==9 && (rot == 0 || rot == 2)) xpos_nxt = xpos - 1;
            else if(block==J_BLOCK && xpos==0 && rot == 2) xpos_nxt = xpos + 1;
            else if(block==J_BLOCK && xpos==9 && rot == 0) xpos_nxt = xpos - 1;
            else if(block==L_BLOCK && xpos==0 && rot == 2) xpos_nxt = xpos + 1;
            else if(block==L_BLOCK && xpos==9 && rot == 0) xpos_nxt = xpos - 1;
            else xpos_nxt = xpos;
          rot_nxt = rot;
          ypos_nxt = ypos;                
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
        NEW_BLOCK: begin
          xpos_nxt = 5;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          block_nxt = buf_block;
          buf_block_nxt = random;
          rot_nxt = 0;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param + 1;
          end          
        default: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          lock_en = 0;          
          points_nxt = points;
          lvl_param_nxt = lvl_param;
          end
      endcase
    end      
endmodule

  
