`timescale 1ns / 1ps

module draw_rect_ctl(
    input wire       pclk,
    input wire       rst,
    input wire       pad_R,
    input wire       pad_L,
    input wire       pad_U,
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
    input wire [3:0] level,
    input wire       ID_1_occupied,
    input wire       ID_2_occupied,
    
    output reg [3:0] xpos,
    output reg [4:0] ypos,
    output reg [4:0] block,
    output reg [4:0] buf_block,
    output reg [1:0] rot,
    output reg       lock_en,
    output reg [19:0]points,
    output reg       lock_ID_en
    );
    
    //localparam LEVEL = 5; //_______________________ make it input later
    localparam FALL_DELAY = 775; //- 100*level
    
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
    reg [3:0]  state_nxt, state;
    reg [4:0]  block_nxt, xpos_nxt, ypos_nxt, buf_block_nxt;         
    reg [10:0] counter, counter_nxt, debounce2_nxt, debounce2;
    reg [19:0] points_nxt;
    reg [26:0] iterator, iterator_nxt, debounce1, debounce1_nxt;
    
    always@(posedge pclk)
        if (rst) begin
            state <= WAIT_FOR_BTN;
            ypos       <= 0;
            xpos       <= 0;
            counter    <= 0;
            iterator   <= 0;
            block      <= 0;
            rot        <= 0;
            debounce1  <= 0;
            debounce2  <= 0;
            buf_block  <= 0;
            points     <= 0;
        end
        else begin
            state     <= state_nxt;
            ypos      <= ypos_nxt;
            xpos      <= xpos_nxt;
            counter   <= counter_nxt;
            iterator  <= iterator_nxt;
            block     <= block_nxt;
            rot       <= rot_nxt;
            debounce1 <= debounce1_nxt;
            debounce2 <= debounce2_nxt;
            buf_block <= buf_block_nxt;
            points    <= points_nxt;
            
        end
    
    always@*begin
      case(state)
        WAIT_FOR_BTN:state_nxt = (btnD||btnL||btnR||!pad_L||!pad_R||!pad_D||!pad_S) ? INIT : WAIT_FOR_BTN;
        INIT:        state_nxt = (ID_1_occupied) ? IDLE : INIT;
        IDLE:        state_nxt = (counter > FALL_DELAY-(50*level)) ? CHECK : btnD||!pad_D && (counter > (FALL_DELAY-(50*level))/10) ? CHECK : btnR||!pad_R ? MOVE_RIGHT : btnL||!pad_L ? MOVE_LEFT : (btnU||!pad_S) ? ROT : IDLE; 
        MOVE_DOWN:   state_nxt = IDLE;
        CHECK:       state_nxt = collision ? STOP : MOVE_DOWN;
        MOVE_LEFT:   state_nxt = HOLD_BTN;
        MOVE_RIGHT:  state_nxt = HOLD_BTN;
        HOLD_BTN:    state_nxt = (counter > FALL_DELAY) ? CHECK : (debounce2 > 300) ? IDLE : HOLD_BTN;
        STOP:        state_nxt = NEW_BLOCK;
        ROT:         state_nxt = ROT_OFFSET;
        ROT_OFFSET:  state_nxt = HOLD_BTN;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
        end  
        INIT: begin
          lock_en = 0;
          xpos_nxt = 5;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = 0;
          debounce1_nxt = 0;
          debounce2_nxt = 0;  
          lock_ID_en = 1;
          points_nxt = points;
          end         
        IDLE: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;           
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          debounce1_nxt = 0;
          debounce2_nxt = 0;   
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
          end
        CHECK: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          debounce1_nxt = debounce1;
          debounce2_nxt = debounce2;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;       
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;         
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
          end
        HOLD_BTN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;  
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          debounce1_nxt = debounce1 + 1;
          debounce2_nxt = (debounce1)>>16;  
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
          end
        STOP: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          rot_nxt = 0;
          block_nxt = block;
          buf_block_nxt = buf_block;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          lock_en = 1;
          lock_ID_en = 0;
          points_nxt = points;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
          end
        NEW_BLOCK: begin
          xpos_nxt = 5;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          block_nxt = buf_block;
          buf_block_nxt = random;
          rot_nxt = 0;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
          end          
        default: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          buf_block_nxt = buf_block;
          rot_nxt = rot;
          debounce1_nxt = debounce1;
          debounce2_nxt = debounce2;
          lock_en = 0;
          lock_ID_en = 0;
          points_nxt = points;
          end
      endcase
    end      
endmodule

  
