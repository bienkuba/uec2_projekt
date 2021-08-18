module debounce_u (
    input pb_u,
    input  clk_in,
    output rect_up
);
    wire clk_out;
    wire Q;
    wire Q_n;
    wire Q_bar;
    
    slowe_clock_4Hz my_slowe_clock(clk_in, clk_out);
    d_ff d1(clk_out, pb_u, Q);
    d_ff d2(clk_out, Q, Q_n);

    assign Q_bar = ~Q_n;
    assign rect_up = Q & ~Q_bar;

endmodule