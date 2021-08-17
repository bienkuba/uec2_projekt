module debounce (
    input pb_d, pb_u, pb_l, pb_r,
    input  clk_in,
    output rect_down,
    output rect_up,
    output rect_right,
    output rect_left
);
    wire clk_out;
    wire Q1, Q2, Q3, Q4;
    wire Q1_n, Q2_n, Q3_n, Q4_n;
    wire Q1_bar, Q2_bar, Q3_bar, Q4_bar;
    
    slowe_clock_4Hz my_slowe_clock(clk_in, clk_out);
    d_ff d1(clk_out, pb_d, pb_u, pb_l, pb_r, Q1, Q2, Q3, Q4);
    d_ff d2(clk_out, Q1, Q2, Q3, Q4, Q1_n, Q2_n, Q3_n, Q4_n);

    assign Q1_bar = ~Q1_n;
    assign rect_down = Q1 & ~Q1_bar;

    assign Q2_bar = ~Q2_n;
    assign rect_up = Q2 & ~Q2_bar;

    assign Q3_bar = ~Q3_n;
    assign rect_right = Q3 & ~Q3_bar;

    assign Q4_bar = ~Q4_n;
    assign rect_left = Q4 & ~Q4_bar;

endmodule