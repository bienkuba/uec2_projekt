`timescale 1ns / 1ps

module draw_rect_ctl(
    input pclk,
    input rst,
    input btnL,
    input btnR,
    input btnD,
    input btnU,
    input [4:0] sq_1_col,
    input [4:0] sq_2_col,
    input [4:0] sq_3_col,          
    input [4:0] sq_4_col,
    input collision,
    
    output reg [4:0] xpos,
    output reg [4:0] ypos,
    output reg [4:0] block,
    output reg [1:0] rot
    );
    
    localparam LEVEL = 1; //_______________________ make it input later
    localparam FALL_DELAY = 2100 - 100*LEVEL;
    
    localparam INIT       = 'b0000;
    localparam IDLE       = 'b0001;
    localparam MOVE_DOWN  = 'b0010;
    localparam MOVE_LEFT  = 'b0011;
    localparam MOVE_RIGHT = 'b0100;
    localparam HOLD_BTN   = 'b0101;
    localparam STOP       = 'b0110;
    localparam ROT        = 'b0111;
    localparam ROT_OFFSET = 'b1000;
    localparam CHECK      = 'b1001;
    localparam NEW_BLOCK  = 'b1010;
    
    localparam I_BLOCK = 'b10000;
    localparam O_BLOCK = 'b10001;
    localparam T_BLOCK = 'b10010;
    localparam S_BLOCK = 'b10011;
    localparam Z_BLOCK = 'b10100;
    localparam J_BLOCK = 'b10101;
    localparam L_BLOCK = 'b10110;
    
    reg [1:0]  rot_nxt;
    reg [3:0]  state_nxt, state;
    reg [4:0]  block_nxt, xpos_nxt, ypos_nxt;         
    reg [10:0] counter, counter_nxt, debounce2_nxt, debounce2;
    reg [31:0] iterator, iterator_nxt, debounce1, debounce1_nxt;
    
    always@(posedge pclk)
        if (rst)
            state <= INIT;
        else begin
            state    <= state_nxt;
            ypos     <= ypos_nxt;
            xpos     <= xpos_nxt;
            counter  <= counter_nxt;
            iterator <= iterator_nxt;
            block    <= block_nxt;
            rot      <= rot_nxt;
            debounce1<= debounce1_nxt;
            debounce2<= debounce2_nxt;
        end
    
    always@*begin
      case(state)
        INIT:      state_nxt = (btnD) ? IDLE : INIT;
        IDLE:      state_nxt = (counter > FALL_DELAY) ? CHECK : (btnD && (counter > FALL_DELAY/8)) ? CHECK : btnR ? MOVE_RIGHT : btnL ? MOVE_LEFT : btnU ? ROT : IDLE; 
        MOVE_DOWN: state_nxt = IDLE;
        CHECK:     state_nxt = collision ? STOP : MOVE_DOWN;
        MOVE_LEFT: state_nxt = HOLD_BTN;
        MOVE_RIGHT:state_nxt = HOLD_BTN;
        HOLD_BTN:  state_nxt = (counter > FALL_DELAY) ? CHECK : (debounce2 > 400) ? IDLE : HOLD_BTN;//(counter > FALL_DELAY) ? MOVE_DOWN : (!btnR && !btnL && !btnU) ? IDLE : FOLD_BTN;
        STOP:      state_nxt = NEW_BLOCK;
        ROT:       state_nxt = ROT_OFFSET;
        ROT_OFFSET:state_nxt = HOLD_BTN;
        NEW_BLOCK :state_nxt = IDLE;
      default:
        state_nxt = STOP;  
      endcase
    end
            
    always@*begin 
      case (state_nxt)  
        INIT: begin
          xpos_nxt = 4;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          block_nxt = I_BLOCK;
          rot_nxt = 0;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          end         
        IDLE: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;           
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = 0;
          debounce2_nxt = 0;   
          end 
        MOVE_DOWN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos + 1;          
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          end
        CHECK: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = debounce1;
          debounce2_nxt = debounce2;
          end          
        MOVE_LEFT: begin
            if((sq_1_col == 0) || (sq_2_col == 0) || (sq_3_col == 0) || (sq_4_col == 0)) xpos_nxt = xpos;
            else xpos_nxt = xpos - 1;
          ypos_nxt = ypos;         
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          rot_nxt = rot; 
          debounce1_nxt = 0;
          debounce2_nxt = 0;       
          end
        MOVE_RIGHT: begin
            if((sq_1_col < 9) || (sq_2_col < 9) || (sq_3_col < 9) || (sq_4_col < 9)) xpos_nxt = xpos + 1;
            else xpos_nxt = xpos;
          ypos_nxt = ypos;           
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = 0;
          debounce2_nxt = 0;         
          end
        HOLD_BTN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;  
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = debounce1 + 1;
          debounce2_nxt = (debounce1)>>16;  
          end
        STOP: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          rot_nxt = 0;
          block_nxt = block + 1;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          end
        ROT: begin
            if (rot == 3) rot_nxt = 0;
            else rot_nxt = rot + 1;
          xpos_nxt = xpos;
          ypos_nxt = ypos;                
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
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
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          end
        NEW_BLOCK: begin
          xpos_nxt = 6;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
            if(block != I_BLOCK || block != O_BLOCK || block != T_BLOCK || block != S_BLOCK || block != Z_BLOCK || block != J_BLOCK || block != L_BLOCK)begin;
              block_nxt = I_BLOCK;
            end
            else block_nxt = block + 1;            
          rot_nxt = 0;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          end          
        default: begin
          xpos_nxt = 11;
          ypos_nxt = 2;          
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = 0;
          debounce2_nxt = 0;
          end
      endcase
    end      
endmodule

  
