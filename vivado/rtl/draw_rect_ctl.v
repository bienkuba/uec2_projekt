`timescale 1ns / 1ps

module draw_rect_ctl(
    input pclk,
    input rst,
    input btnL,
    input btnR,
    input btnD,
    input btnU,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos,
    output reg [2:0] block,
    output reg [2:0] rot
    );
    
    localparam LEVEL = 1; //_______________________ make it input later
    localparam FALL_DELAY = 1000 - 100*LEVEL;
    
    localparam TRIGGER    = 'b000;
    localparam IDLE       = 'b001;
    localparam MOVE_DOWN  = 'b010;
    localparam MOVE_LEFT  = 'b011;
    localparam MOVE_RIGHT = 'b100;
    localparam FOLD_BTN   = 'b101;
    localparam STOP       = 'b110;
    localparam MOVE_UP    = 'b111; //______________________________ make it ROT - ratation alter
             
    reg [2:0]  state_nxt, state, block_nxt;
    reg [19:0] row_nxt;
    reg [9:0] column_nxt;
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
        end
    
    always@*begin
      case(state)
        TRIGGER:   state_nxt = (btnD) ? IDLE : TRIGGER;
        IDLE:      state_nxt = (counter > FALL_DELAY) ? MOVE_DOWN : (btnD && (counter > FALL_DELAY/2)) ? MOVE_DOWN :(btnR && xpos < 9) ? MOVE_RIGHT : (btnL && xpos > 0) ? MOVE_LEFT : (btnU && ypos > 0) ? MOVE_UP : IDLE; 
        MOVE_DOWN: state_nxt = (ypos >= 19) ? STOP : IDLE;
        MOVE_LEFT: state_nxt = FOLD_BTN;
        MOVE_RIGHT:state_nxt = FOLD_BTN;
        FOLD_BTN:  state_nxt = (counter > FALL_DELAY) ? MOVE_DOWN : (!btnR && !btnL && !btnU) ? IDLE : FOLD_BTN;
        STOP:      state_nxt = btnU ? MOVE_UP : STOP;
        MOVE_UP:   state_nxt = FOLD_BTN;                     
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
          block_nxt = 'b000;
          end         
        IDLE: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;           
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;   
          end 
        MOVE_DOWN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos + 1;          
          iterator_nxt = 0;
          counter_nxt = 0;           
          end
        MOVE_LEFT: begin
          xpos_nxt = xpos - 1;
          ypos_nxt = ypos;         
          iterator_nxt = iterator;
          counter_nxt = counter;        
          end
        MOVE_RIGHT: begin
          xpos_nxt = xpos + 1;
          ypos_nxt = ypos;           
          iterator_nxt = iterator;
          counter_nxt = counter;         
          end
        FOLD_BTN: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;  
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;        
          end
        STOP: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          counter_nxt = 0;   
          iterator_nxt = 0;       
          end
        MOVE_UP: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos - 1;                
          iterator_nxt = 0;
          counter_nxt = 0;          
          end
        default: begin
          xpos_nxt = xpos;
          ypos_nxt = ypos;          
          iterator_nxt = 0;
          counter_nxt = 0;          
          end
      endcase
    end      
endmodule

  
