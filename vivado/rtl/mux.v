`timescale 1ns / 1ps

module mux(  
    input wire [7:0] mux_in_1,
    input wire [7:0] mux_in_2,
    input wire clk,
    input wire rst,
    input wire rx_done_tick1, rx_done_tick2,
    
    output reg [24:0] ext_data_1,
    output reg [24:0] ext_data_2
);

reg [7:0] data_1_1, data_1_2, data_1_3;
reg [7:0] data_2_1, data_2_2, data_2_3;

reg [7:0] data_1_1_nxt, data_1_2_nxt, data_1_3_nxt;
reg [7:0] data_2_1_nxt, data_2_2_nxt, data_2_3_nxt;

reg [24:0] ext_data_1_nxt, ext_data_2_nxt;
    
always@(posedge clk) begin
    if(rst) begin
        ext_data_1 <= 0;
        data_1_1 <= 0;
        data_1_2 <= 0;
        data_1_3 <= 0;
        
        ext_data_2 <= 0;
        data_2_1 <= 0;
        data_2_2 <= 0;
        data_2_3 <= 0;
    end
    else begin
        ext_data_1 <= ext_data_1_nxt;
        data_1_1 <= data_1_1_nxt;
        data_1_2 <= data_1_2_nxt;
        data_1_3 <= data_1_3_nxt;
        
        ext_data_2 <= ext_data_2_nxt;
        data_2_1 <= data_2_1_nxt;
        data_2_2 <= data_2_2_nxt;
        data_2_3 <= data_2_3_nxt;
    end

end
    
always@*begin

    if(rx_done_tick1) begin
        if(data_1_1 == 0) data_1_1_nxt = mux_in_1;
        else if( data_1_2 == 0) data_1_2_nxt = mux_in_1;
        else data_1_3_nxt = mux_in_1;
        
        if(data_1_3 != 0) begin
            ext_data_1_nxt = {data_1_1, data_1_2, data_1_3};
            data_1_1_nxt = 0;
            data_1_2_nxt = 0;
            data_1_3_nxt = 0;
        end
            else ext_data_1_nxt = ext_data_1;
    end
        if(rx_done_tick2) begin
            if(data_2_1 == 0) data_2_1_nxt = mux_in_2;
            else if( data_2_2 == 0) data_2_2_nxt = mux_in_2;
            else data_2_3_nxt = mux_in_2;
            
            if(data_2_3 != 0) begin
                ext_data_2_nxt = {data_2_1, data_2_2, data_2_3};
                data_2_1_nxt = 0;
                data_2_2_nxt = 0;
                data_2_3_nxt = 0;
            end
                else ext_data_2_nxt = ext_data_2;
        end
    end
endmodule