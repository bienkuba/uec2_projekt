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
                FIFO_W = 2    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W 
   )
   (
    input wire clk,
    input wire rx, tx_start,
    input wire [7:0] data_in,
    output wire tx, tx_busy,
    output wire [7:0] data_out
   );

   // signal declaration
   wire rx_busy, rx_done, tx_busy_nxt;
   wire [7:0] rx_data_out;
   wire tx_do_sample = 1'b1;
   

   //body
//   mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
//      (.clk(clk), .reset(reset),  .max_tick(tick));

//    reg [7:0] tx_sample_cntr = 0;
//    always @ (posedge clk) begin
//        if (tx_sample_cntr[7:0] == 0) begin
//            tx_sample_cntr[7:0] <= (173-1);
//        end else begin
//            tx_sample_cntr[7:0] <= tx_sample_cntr[7:0] - 1;
//        end
//    end
//    wire tx_do_sample = (tx_sample_cntr[7:0] == 0);

    uart_tx my_uart_tx (
        .clk(clk),
        .tx_do_sample(tx_do_sample),
        .tx_data(data_in),
        .tx_start(tx_start),
        .tx_busy(tx_busy_nxt),
        .txd(tx)
    );
    
        uart_rx my_uart_rx (
        .clk(clk),
        .rx_data(rx_data_out),
        .rx_busy(rx_busy),
        .rx_done(rx_done),
        .rxd(rx)
    );

   assign data_out = rx_data_out;
   assign tx_busy = tx_busy_nxt;

endmodule