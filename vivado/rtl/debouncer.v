`timescale 1 ns / 1 ps

module debouncer
   (
    input wire pclk, rst,
    input wire sw_S, sw_R, sw_L, sw_D, bttn_D, bttn_R, bttn_L, bttn_U,
    output wire pad_Sd, pad_Rd, pad_Ld, pad_Dd, bttn_Dd, bttn_Rd, bttn_Ld, bttn_Ud
   ); 

   wire pad_Sdd, pad_Rdd, pad_Ldd, pad_Ddd, bttn_Ddd, bttn_Rdd, bttn_Ldd, bttn_Udd;

board_debounce D_board (
    .clk(pclk),
    .reset(rst),
    .sw(bttn_D),
    .db_level(),
    .db_tick(bttn_Ddd)
);
board_debounce L_board (
    .clk(pclk),
    .reset(rst),
    .sw(bttn_L),
    .db_level(),
    .db_tick(bttn_Ldd)
);
board_debounce U_board (
    .clk(pclk),
    .reset(rst),
    .sw(bttn_U),
    .db_level(),
    .db_tick(bttn_Udd)
);

    board_debounce R_board (
        .clk(pclk),
        .reset(rst),
        .sw(bttn_R),
        .db_level(),
        .db_tick(bttn_Rdd)
    );

     debounce S_debounce(
    .clk(pclk),
    .reset(rst),
    .sw(sw_S),
    .db_level(),
    .db_tick(pad_Sdd)
  );

     debounce R_debounce(
    .clk(pclk),
    .reset(rst),
    .sw(sw_R),
    .db_level(),
    .db_tick(pad_Rdd)
  );
     debounce L_debounce(
    .clk(pclk),
    .reset(rst),
    .sw(sw_L),
    .db_level(),
    .db_tick(pad_Ldd)
  );
     debounce D_debounce(
    .clk(pclk),
    .reset(rst),
    .sw(sw_D),
    .db_level(),
    .db_tick(pad_Ddd)
  );

  assign pad_Sd = pad_Sdd;
  assign pad_Rd = pad_Rdd;
  assign pad_Ld = pad_Ldd;
  assign pad_Dd = pad_Ddd;
  
  assign bttn_Dd = bttn_Ddd;
  assign bttn_Rd = bttn_Rdd;
  assign bttn_Ld = bttn_Ldd;
  assign bttn_Ud = bttn_Udd;
  
endmodule