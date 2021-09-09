`timescale 1ns / 1ps

module mux(  
    input wire [7:0] mux_in_1,
    input wire [7:0] mux_in_2,
    input wire clk,
    input wire rst,
    
    output reg [31:0] ext_data_1,
    output reg [31:0] ext_data_2
);

reg [7:0] data_1_1, data_1_2, data_1_3, data_1_4;
reg [7:0] data_2_1, data_2_2, data_2_3, data_2_4;

reg [7:0] data_1_1_nxt, data_1_2_nxt, data_1_3_nxt, data_1_4_nxt;
reg [7:0] data_2_1_nxt, data_2_2_nxt, data_2_3_nxt, data_2_4_nxt;

reg [31:0] ext_data_1_nxt, ext_data_2_nxt;
    
always@(posedge clk) begin
    if(rst) begin
        ext_data_1 <= 0;
        data_1_1 <= 0;
        data_1_2 <= 0;
        data_1_3 <= 0;
        data_1_4 <= 0;
        
        ext_data_2 <= 0;
        data_2_1 <= 0;
        data_2_2 <= 0;
        data_2_3 <= 0;
        data_2_4 <= 0;
    end
    else begin
        ext_data_1 <= ext_data_1_nxt;
        data_1_1 <= data_1_1_nxt;
        data_1_2 <= data_1_2_nxt;
        data_1_3 <= data_1_3_nxt;
        data_1_4 <= data_1_4_nxt;
        
        ext_data_1 <= ext_data_1_nxt;
        data_1_1 <= data_2_1_nxt;
        data_1_2 <= data_2_2_nxt;
        data_1_3 <= data_2_3_nxt;
        data_1_4 <= data_2_4_nxt;
    end

end
    
always@*begin
    if(data_1_1 == 0) data_1_1_nxt = mux_in_1;
    else if( data_1_2 == 0) data_1_2_nxt = mux_in_1;
    else if( data_1_3 == 0) data_1_3_nxt = mux_in_1;
    else data_1_4_nxt = mux_in_1;
    
    if(data_1_1 == 0) data_2_1_nxt = mux_in_2;
    else if( data_1_2 == 0) data_2_2_nxt = mux_in_2;
    else if( data_1_3 == 0) data_2_3_nxt = mux_in_2;
    else data_2_4_nxt = mux_in_2;
    
    if(data_1_4 != 0) begin
        ext_data_1_nxt = {data_1_1, data_1_2, data_1_3, data_1_4};
        data_1_1 = 0;
        data_1_2 = 0;
        data_1_3 = 0;
        data_1_4 = 0;
    end
        else ext_data_1_nxt = ext_data_1;
    
    if(data_2_4 != 0) begin
        ext_data_2_nxt = {data_2_1, data_2_2, data_2_3, data_2_4};
        data_2_1 = 0;
        data_2_2 = 0;
        data_2_3 = 0;
        data_2_4 = 0;
    end
        else ext_data_2_nxt = ext_data_1;
    end

endmodule