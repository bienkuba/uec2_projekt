`timescale 1ns / 1ps

module draw_rect_ctl(
    input pclk,
    input rst,
    input btnL,
    input btnR,
    input btnD,
    input btnU,
    input [4:0] sq_1_col,
    input [4:0] sq_1_row,
    input [4:0] sq_2_col,
    input [4:0] sq_2_row,
    input [4:0] sq_3_col,
    input [4:0] sq_3_row,          
    input [4:0] sq_4_col,
    input [4:0] sq_4_row,
    input [1:0] offset_L,
    input [1:0] offset_R,
    
    output reg [4:0] xpos,
    output reg [4:0] ypos,
    output reg [4:0] block,
    output reg [1:0] rot
    );
    
    localparam LEVEL = 1; //_______________________ make it input later
    localparam FALL_DELAY = 1000 - 100*LEVEL;
    
    localparam TRIGGER    = 'b0000;
    localparam IDLE       = 'b0001;
    localparam MOVE_DOWN  = 'b0010;
    localparam MOVE_LEFT  = 'b0011;
    localparam MOVE_RIGHT = 'b0100;
    localparam HOLD_BTN   = 'b0101;
    localparam STOP       = 'b0110;
    localparam ROT        = 'b0111;
    localparam ROT_OFFSET = 'b1000;
    
    
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
            state <= TRIGGER;
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
        TRIGGER:   state_nxt = (btnD) ? IDLE : TRIGGER;
        IDLE:      state_nxt = (counter > FALL_DELAY) ? MOVE_DOWN : (btnD && (counter > FALL_DELAY/4)) ? MOVE_DOWN : btnR ? MOVE_RIGHT : btnL ? MOVE_LEFT : btnU ? ROT : IDLE; 
        MOVE_DOWN: state_nxt = (ypos >= 19) ? STOP : IDLE;
        MOVE_LEFT: state_nxt = HOLD_BTN;
        MOVE_RIGHT:state_nxt = HOLD_BTN;
        HOLD_BTN:  state_nxt = (debounce2 > 400) ? IDLE : HOLD_BTN;//(counter > FALL_DELAY) ? MOVE_DOWN : (!btnR && !btnL && !btnU) ? IDLE : FOLD_BTN;
        STOP:      state_nxt = TRIGGER;
        ROT:       state_nxt = ROT_OFFSET;
        ROT_OFFSET:state_nxt = HOLD_BTN;
      default:
        state_nxt = STOP;  
      endcase
    end
            
    always@*begin 
      case (state_nxt)  
        TRIGGER: begin
          xpos_nxt = 4;
          ypos_nxt = 0;          
          counter_nxt = 0;   
          iterator_nxt = 0;
            if(block !== I_BLOCK || block !== O_BLOCK || block !== T_BLOCK || block !== S_BLOCK || block !== Z_BLOCK || block !== J_BLOCK || block !== L_BLOCK)begin;
              block_nxt = I_BLOCK;
              end
            else begin
              block_nxt = block + 1;
              end
          rot_nxt = 0;
          debounce1_nxt = 0;
          end         
        IDLE: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;           
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          rot_nxt = rot;   
          end 
        MOVE_DOWN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos + 1;          
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = 0; 
          end
        MOVE_LEFT: begin
            if((sq_1_col <= 0) || (sq_2_col <= 0) || (sq_3_col <= 0) || (sq_4_col <= 0))begin
              xpos_nxt = xpos;
              end
            else begin
              xpos_nxt = xpos - 1;
              end
          ypos_nxt = ypos;         
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          rot_nxt = rot; 
          debounce1_nxt = 0;       
          end
        MOVE_RIGHT: begin
            if((sq_1_col >= 9) || (sq_2_col >= 9) || (sq_3_col >= 9) || (sq_4_col >= 9))begin
              xpos_nxt = xpos;
              end
            else if((sq_1_col < 9) || (sq_2_col < 9) || (sq_3_col < 9) || (sq_4_col < 9))begin
              xpos_nxt = xpos + 1;
              end
          ypos_nxt = ypos;           
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          rot_nxt = rot;
          debounce1_nxt = 0;         
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
          block_nxt = block;         
          end
        ROT: begin
            if (rot == 3)begin
              rot_nxt = 0;
              end
            else begin
              rot_nxt = rot + 1;
              end
          xpos_nxt = xpos;
          ypos_nxt = ypos;                
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          debounce1_nxt = 0;
          end
        ROT_OFFSET: begin
            if(block==I_BLOCK && xpos==9 && (rot == 0 || rot == 2))begin 
              xpos_nxt = xpos - 2;
              end
            else if(block==I_BLOCK && xpos==8 && (rot == 0 || rot == 2))begin 
              xpos_nxt = xpos - 1;
              end  
            else if(block==I_BLOCK && xpos==0 && (rot == 0 || rot == 2))begin 
              xpos_nxt = xpos + 1;
              end  
            else if(block==T_BLOCK && xpos==9 && rot == 2)begin
              xpos_nxt = xpos - 1;
              end
            else if(block==T_BLOCK && xpos==0 && rot == 0)begin
              xpos_nxt = xpos + 1;
              end 
            else if(block==S_BLOCK && xpos==0 && (rot == 0 || rot == 2))begin
              xpos_nxt = xpos + 1;
              end
            else if(block==Z_BLOCK && xpos==9 && (rot == 0 || rot == 2))begin
              xpos_nxt = xpos - 1;
              end
            else if(block==J_BLOCK && xpos==0 && rot == 2)begin
              xpos_nxt = xpos + 1;
              end
            else if(block==J_BLOCK && xpos==9 && rot == 0)begin
              xpos_nxt = xpos - 1;
              end
            else if(block==L_BLOCK && xpos==0 && rot == 2)begin
              xpos_nxt = xpos + 1;
              end
            else if(block==L_BLOCK && xpos==9 && rot == 0)begin
              xpos_nxt = xpos - 1;
              end
            else begin
              xpos_nxt = xpos;
              end
          rot_nxt = rot;
          ypos_nxt = ypos;                
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          end
        
        default: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = block;
          rot_nxt = rot;          
          end
      endcase
    end      
endmodule

  
