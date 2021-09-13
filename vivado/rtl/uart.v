`timescale 1ns / 1ps

module uart
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      parameter DBIT = 8,     // # data bits
                SB_TICK = 16, // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
                DVSR = 163,   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
                DVSR_BIT = 8, // # bits of DVSR
                FIFO_W = 2,    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W
                tx_start = 1'b1 
   )
   (
    input wire clk, reset,
    input wire rx,
    input wire [7:0] data_in,
    output wire tx,
    output wire [7:0] data_out
   );

   // signal declaration
   wire tick;
   wire [7:0] rx_data_out;
   

   //body
   mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
      (.clk(clk), .reset(reset),  .max_tick(tick));

   uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit
      (.clk(clk), .reset(reset), .rx(rx), .s_tick(tick),
       .dout(data_out));

   uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_tx_unit
      (.clk(clk), .reset(reset), .tx_start(tx_start),
       .s_tick(tick), .din(data_in), .tx(tx));

//   assign data_out = rx_data_out;

endmodule