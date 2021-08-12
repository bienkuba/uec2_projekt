`timescale 1ns / 1ps

module draw_rect_ctl(
    input pclk,
    input rst,
    input btnL,
    input btnR,
    input btnD,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos
    );
    
    
    localparam TRIGGER    = 'b000;
    localparam IDLE       = 'b001;
    localparam MOVE_DOWN  = 'b010;
    localparam MOVE_LEFT  = 'b011;
    localparam MOVE_RIGHT = 'b100;
    localparam FOLD_BTN   = 'b101;
    localparam STOP       = 'b110; 
             
    reg [2:0]  state_nxt, state;
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
        end
    
    always@*begin
      case(state)
        TRIGGER:   state_nxt = (btnD) ? IDLE : TRIGGER;
        IDLE:      state_nxt = (counter > 1000) ? MOVE_DOWN : (btnR && xpos <= 481) ? MOVE_RIGHT : (btnL && xpos > 201) ? MOVE_LEFT : IDLE; 
        MOVE_DOWN: state_nxt = (ypos >= 675) ? STOP : IDLE;
        MOVE_LEFT: state_nxt = FOLD_BTN;
        MOVE_RIGHT:state_nxt = FOLD_BTN;
        FOLD_BTN:  state_nxt = (counter > 1000) ? MOVE_DOWN : !btnR ? IDLE : FOLD_BTN;
        STOP:      state_nxt = STOP;                     
      default:
        state_nxt = STOP;  
      endcase
    end
            
    always@*begin 
      case (state_nxt)  
        TRIGGER: begin
          xpos_nxt  = 236;
          ypos_nxt  = 10;
          counter_nxt = 0;   
          iterator_nxt = 0; 
          end         
        IDLE: begin
          xpos_nxt  = xpos;
          ypos_nxt  = ypos;            
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;    
          end 
        MOVE_DOWN: begin
          xpos_nxt  = xpos;
          ypos_nxt  = ypos + 35;            
          iterator_nxt = 0;
          counter_nxt = 0; 
          end
        MOVE_LEFT: begin
          iterator_nxt = iterator;
          counter_nxt = counter;
          ypos_nxt = ypos;          
          xpos_nxt = xpos - 35;
          end
        MOVE_RIGHT: begin
          iterator_nxt = iterator;
          counter_nxt = counter;
          ypos_nxt = ypos;          
          xpos_nxt = xpos + 35;
          end
        FOLD_BTN: begin
          iterator_nxt = iterator + 1;
          counter_nxt = (iterator)>>16;
          ypos_nxt = ypos;          
          xpos_nxt = xpos;
          end
        STOP: begin
            xpos_nxt  = xpos;
            ypos_nxt  = 10 + 35*19;
            counter_nxt = 0;   
            iterator_nxt = 0; 
        end
        default: begin 
          iterator_nxt = 0;
          counter_nxt = 0;
          xpos_nxt  = 600;
          ypos_nxt  = 600;
        end
      endcase
    end      
endmodule

  
