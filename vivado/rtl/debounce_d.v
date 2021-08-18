module debounce_d (
    input pb_d,
    input  clk_in,
    output rect_down
);
    wire clk_out;
    wire Q;
    wire Q_n;
    wire Q_bar;
    
    slowe_clock_4Hz my_slowe_clock(clk_in, clk_out);
    d_ff d1(clk_out, pb_d, Q);
    d_ff d2(clk_out, Q, Q_n);

    assign Q_bar = ~Q_n;
    assign rect_down = Q & ~Q_bar;

endmodule