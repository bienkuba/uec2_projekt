`timescale 1ns / 1ps

module debounce_r (
    input pb_r,
    input  clk_in,
    output rect_right
);
    wire clk_out;
    wire Q, Q_n, Q_bar;
    
    slowe_clock_4Hz my_slowe_clock(clk_in, clk_out);
    d_ff d1(clk_out, pb_r, Q);
    d_ff d2(clk_out, Q, Q_n);

    assign Q_bar = ~Q_n;
    assign rect_right = Q & Q_bar;

endmodule