
module debounce (
    input pb_d, pb_u, pb_l, pb_r,
    input  clk_in,
    output rect_down,
    output rect_up,
    output rect_right,
    output rect_left
);
    debounce_d my_d(
        .pb_d(pb_d),
        .clk_in(clk_in),
        .rect_down(rect_down)
    );

    debounce_l my_l(
        .pb_l(pb_l),
        .clk_in(clk_in),
        .rect_left(rect_left)
    );

    debounce_r my_r(
        .pb_r(pb_r),
        .clk_in(clk_in),
        .rect_right(rect_right)
    );

    debounce_u my_u(
        .pb_u(pb_u),
        .clk_in(clk_in),
        .rect_up(rect_up)
    );

endmodule