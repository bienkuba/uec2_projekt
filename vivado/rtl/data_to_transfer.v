`timescale 1ns / 1ps

module data_to_transfer(
    input wire clk,
    input wire rst,
    input wire [23:0] points,
    input wire tx_done_tick1, tx_done_tick2,
    
    output reg [7:0] tx_data1, tx_data2 
);
        reg [7:0] tx_data1_n, tx_data2_n, tx_data3_n;
        reg [7:0] tx_data1_d, tx_data2_d, tx_data3_d;
        reg [7:0] tx_data_nxt1, tx_data_nxt2;
        reg [1:0] UART1_pack_nr, UART2_pack_nr;
    
    always@(posedge clk)begin
        if(rst)begin
            tx_data1_n <= 0;
            tx_data2_n <= 0;
            tx_data3_n <= 0;
            
            tx_data1_d <= 0;
            tx_data2_d <= 0;
            tx_data3_d <= 0;
            
            tx_data1 <= 0;
            tx_data2 <= 0;
        end
        else begin
            tx_data3_n <= points[23:16];
            tx_data2_n <= points[15:8];
            tx_data1_n <= points[7:0];
            
            tx_data3_d <= points[23:16];
            tx_data2_d <= points[15:8];
            tx_data1_d <= points[7:0];
                        
            tx_data1 <= tx_data_nxt1;
            tx_data2 <= tx_data_nxt2;
        end
    end
    
     always@* begin
        if(tx_done_tick1) begin
            case(UART1_pack_nr)
                2'b01: begin
                    tx_data_nxt1 = tx_data1_n;
                    UART1_pack_nr = 2;
                    end
                2'b10: begin 
                    tx_data_nxt1 = tx_data2_n; 
                    UART1_pack_nr = 3;
                    end
                2'b11: begin 
                    tx_data_nxt1 = tx_data3_n;
                    UART1_pack_nr = 0;
                    end
                default:
                    UART1_pack_nr = 1;
            endcase
        end
          
        if(tx_done_tick2)begin
            case(UART2_pack_nr)
                  2'b01: begin
                      tx_data_nxt2 = tx_data1_d;
                      UART2_pack_nr = 2;
                      end
                  2'b10: begin 
                      tx_data_nxt2 = tx_data2_d; 
                      UART2_pack_nr = 3;
                      end
                  2'b11: begin 
                      tx_data_nxt2 = tx_data3_d;
                      UART2_pack_nr = 0;
                      end
                  default:
                      UART2_pack_nr = 1;
              endcase       
          end   
    end
endmodule