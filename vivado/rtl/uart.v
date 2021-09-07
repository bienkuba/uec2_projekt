//https://github.com/jamieiles/uart/blob/master/uart.v

module uart(
        input wire [7:0] din,
	    input wire pclk,
	    input wire rx,
	    input wire rdy_clr,
	    output wire tx,
	    output wire tx_busy,
	    output wire rdy,
	    output wire [7:0] dout
);

wire rxclk_en, txclk_en;
reg wr_en;
reg [7:0] din_nxt;

baud_rate_gen uart_baud(.pclk(pclk),
			.rxclk_en(rxclk_en),
			.txclk_en(txclk_en));

always@* begin
    if(din) 
       wr_en = 1;
    else
       wr_en = 0;
end

uart_tx my_uart_tx(
    .din(din),
    .wr_en(wr_en),
    .pclk(pclk),
    .clken(txclk_en),
    .tx(tx),
    .tx_busy(tx_busy)
);
	    
uart_rx my_uart_rx(
     .rx(rx),
     .rdy(rdy),
     .rdy_clr(rdy_clr),
     .pclk(pclk),
     .clken(rxclk_en),
     .data(dout)
);

endmodule