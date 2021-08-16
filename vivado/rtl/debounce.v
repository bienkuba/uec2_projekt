module debounce (
    input pb, clk_in,
    output led
);
    wire clk_out;
    wire Q1, Q2, Q2_bar;
    
    slowe_clock_4Hz my_slowe_clock(clk_in, clk_out);
    d_ff d1(clk_out, pb, Q1);
    d_ff d2(clk_out, Q1, Q2);

    assign Q2_bar = ~Q2;
    assign led = Q1 & ~Q2_bar;

endmodule