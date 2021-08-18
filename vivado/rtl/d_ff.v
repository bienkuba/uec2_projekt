module d_ff (
    input clk, //input slow clock
    input D1, D2, D3, D4, //buttons
    output reg Q1, Q2, Q3, Q4,
    output reg Qbar1, Qbar2, Qbar3, Qbar4
);
    
    always @(posedge clk) begin
        Q1 <= D1;
        Q2 <= D2;
        Q3 <= D3;
        Q4 <= D4;
        Qbar1 <= !Q1;
        Qbar2 <= !Q2;
        Qbar3 <= !Q3;
        Qbar4 <= !Q4;
    end

endmodule