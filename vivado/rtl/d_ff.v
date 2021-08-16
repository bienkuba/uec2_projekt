module d_ff (
    input clk, //input slow clock
    input D, //button
    output reg Q,
    output reg Qbar
);
    
    always @(posedge clk) begin
        Q <= D;
        Qbar <= !Q;
    end

endmodule