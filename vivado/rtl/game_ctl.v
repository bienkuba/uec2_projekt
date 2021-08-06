`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2021 13:15:24
// Design Name: 
// Module Name: draw_rect_ctl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game_ctl(
    input pclk,
    input rst,
    input button_left,
    input button_right,
    input button_down,
    input button_rotate,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos
    );
    
    localparam IDLE             = 4'b0000;
    localparam ROTATE           = 4'b0001;
    localparam MOVE_LEFT        = 4'b0010;
    localparam MOVE_RIGHT       = 4'b0011;
    localparam MOVE_DOWN        = 4'b0100;
    localparam ADD_NEW_BLOCK    = 4'b0101;
    localparam GAME_OVER        = 4'b0110;
    localparam ADD_POINTS       = 4'b0111;
    localparam SPAWN_NEW_BLOCK  = 4'b1000;
    localparam REMOVE_HEART     = 4'b1001;
    localparam DELETE_LINE      = 4'b1011;
    //punkty daj? za skasowanie linij 1,2,3,4 i za spadni?ty klocek
    
              
    reg [9:0]  state_nxt, state;
    reg [11:0] ypos_nxt, xpos_nxt, ydraw, ydraw_nxt;
    reg [31:0] time_curr, time_nxt, position, position_nxt;
    reg [1:0] grid [0:9][0:19];
    
    always@(posedge pclk)
      if (rst)
        state      <= IDLE;
      else begin
        state      <= state_nxt;
        ypos       <= ypos_nxt;
        xpos       <= xpos_nxt;
        position   <= position_nxt;
        ydraw      <= ydraw_nxt;
        time_curr  <= time_nxt;         
      end
        
            
    always@*begin 
      case(state)  
        IDLE: begin
          if(button_left)
            state_nxt = MOVE_LEFT;
          else if(button_right)
            state_nxt = MOVE_RIGHT;
          else if(button_down)
            state_nxt = MOVE_DOWN;
          else if(button_rotate)
            state_nxt = ROTATE;
          else
            state_nxt = IDLE;       
//          if(timer){
//            state_nxt = MOVE_DOWN;
//          } 
          xpos_nxt = xpos;
          ypos_nxt = ypos;            
        end  
        MOVE_LEFT: begin
          ypos_nxt = ydraw;
          xpos_nxt = xpos - 35;
        end
        MOVE_RIGHT: begin
          ypos_nxt = ydraw;
          xpos_nxt = xpos + 35;      
        end
        MOVE_DOWN: begin
          time_nxt = time_curr + 1;
          position_nxt = (time_curr)>>14;
          ydraw_nxt = ydraw;
          ypos_nxt = ydraw + position;
          xpos_nxt = xpos;
//          if(grid){
            
//          }     
        end
        ROTATE: begin//-----------------------------------------?
          xpos_nxt  = ypos;
          ypos_nxt  = xpos;       
        end
        ADD_NEW_BLOCK: begin//----------------------------------?
          xpos_nxt  = xpos;
          ypos_nxt  = ypos;       
        end
        ADD_POINTS: begin
          time_nxt = 0;
          position_nxt = position;
          ydraw_nxt = ydraw;
          xpos_nxt  = xpos;
          ypos_nxt  = ypos;       
        end
        GAME_OVER: begin
          time_nxt = 0;
          position_nxt = position;
          ydraw_nxt = ydraw;
          xpos_nxt  = xpos;
          ypos_nxt  = ypos;       
        end
        REMOVE_HEART: begin
          time_nxt = 0;
          position_nxt = position;
          ydraw_nxt = ydraw;
          xpos_nxt  = xpos;
          ypos_nxt  = ypos;       
        end
        DELETE_LINE: begin
//          if(delete){
          
//          }      
        end
        default: begin 
          time_nxt = 0;
          position_nxt = 0;
        end
      endcase
    end      
endmodule

  
