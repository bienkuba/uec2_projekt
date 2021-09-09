`timescale 1 ns / 1 ps

module debouncer
   (
    input wire pclk, rst,
<<<<<<< Updated upstream
    input wire sw_S, sw_R, sw_L, sw_D, 
    output wire pad_Sd, pad_Rd, pad_Ld, pad_Dd
   ); 
   
   wire pad_Sdd, pad_Rdd, pad_Ldd, pad_Ddd;
=======
    input wire sw_S, sw_R, sw_L, sw_D, bttn_D, 
    output wire pad_Sd, pad_Rd, pad_Ld, pad_Dd, bttn_Dd
   ); 
   
   wire pad_Sdd, pad_Rdd, pad_Ldd, pad_Ddd, bttn_Ddd;
	
    board_debouncer D_board (
	.clk(pclk),
    .reset(rst),
    .sw(bttn_D),
    .db_level(),
    .db_tick(bttn_Ddd)
	);
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
=======
  assign bttn_Dd = bttn_Ddd;
>>>>>>> Stashed changes

endmodule