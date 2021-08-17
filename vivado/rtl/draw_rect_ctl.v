`timescale 1ns / 1ps

module draw_rect_ctl(
    input pclk,
    input rst,
    input btnL,
    input btnR,
    input btnD,
    input btnU,
    input [1:0] height,
    input [1:0] lenght,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos,
    output reg [3:0] block,
    output reg [3:0] rot
    );
    
    localparam LEVEL = 1; //_______________________ make it input later
    localparam FALL_DELAY = 2000 - 100*LEVEL;
    
    localparam TRIGGER    = 'b000;
    localparam IDLE       = 'b001;
    localparam MOVE_DOWN  = 'b010;
    localparam MOVE_LEFT  = 'b011;
    localparam MOVE_RIGHT = 'b100;
    localparam FOLD_BTN   = 'b101;
    localparam STOP       = 'b110;
    localparam ROT        = 'b111;
    
    localparam I_BLOCK = 'b1000;
    localparam O_BLOCK = 'b1001;
    localparam T_BLOCK = 'b1010;
    localparam S_BLOCK = 'b1011;
    localparam Z_BLOCK = 'b1100;
    localparam J_BLOCK = 'b1101;
    localparam L_BLOCK = 'b1110;
             
    reg [3:0]  state_nxt, state, block_nxt, rot_nxt;
    reg [19:0] row_nxt;
    reg [9:0]  column_nxt;
    reg [11:0] ypos_nxt, xpos_nxt;
    reg [31:0] iterator, iterator_nxt, counter, counter_nxt;
    
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
        end
    
    always@*begin
      case(state)
        TRIGGER:   state_nxt = (btnD) ? IDLE : TRIGGER;
        IDLE:      state_nxt = (counter > FALL_DELAY) ? MOVE_DOWN : (btnD && (counter > FALL_DELAY/4)) ? MOVE_DOWN :(btnR && xpos < 9) ? MOVE_RIGHT : (btnL && xpos > 0) ? MOVE_LEFT : (btnU) ? ROT : IDLE; 
        MOVE_DOWN: state_nxt = (ypos >= 19) ? STOP : IDLE;
        MOVE_LEFT: state_nxt = FOLD_BTN;
        MOVE_RIGHT:state_nxt = FOLD_BTN;
        FOLD_BTN:  state_nxt = (counter > FALL_DELAY) ? MOVE_DOWN : (!btnR && !btnL && !btnU) ? IDLE : FOLD_BTN;
        STOP:      state_nxt = TRIGGER;
        ROT:       state_nxt = FOLD_BTN;
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
          block_nxt = I_BLOCK;
          rot_nxt = 0;
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
          end
        MOVE_LEFT: begin
          xpos_nxt = xpos - 1;
          ypos_nxt = ypos;         
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block + 1;
          rot_nxt = rot;        
          end
        MOVE_RIGHT: begin
          xpos_nxt = xpos + 1;
          ypos_nxt = ypos;           
          iterator_nxt = iterator;
          counter_nxt = counter;
          block_nxt = block;
          rot_nxt = rot;         
          end
        FOLD_BTN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;  
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          block_nxt = block;
          rot_nxt = rot;        
          end
        STOP: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          counter_nxt = 0;   
          iterator_nxt = 0;
          rot_nxt = 0;
            if (block == 7)begin
              rot_nxt = I_BLOCK;
            end
            else begin
              block_nxt = block + 1;
            end          
          end
        ROT: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;                
          iterator_nxt = 0;
          counter_nxt = 0;
          block_nxt = block;
            if (rot == 3)begin
              rot_nxt = 0;
            end
            else begin
              rot_nxt = rot + 1;
            end
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

  
