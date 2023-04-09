module top (
    // Input
    input clk,
    input rst,
    input tm, // test mode
    input fi, // fault injection
    input [3:0] X,
    
    // Output
    output wire F,
    output reg [3:0] signature
);
    reg [3:0] bist;
    reg [3:0] in;

    CUT cut(.faultInject(fi), .in(in), .F(F));
    TPG tpg(.clk(clk), .rst(rst), .pttn(bist));
    ORA ora(.clk(clk), .rst(rst), .in(F), .signature(signature));
    always @(*) begin
        if (tm) begin
            in = bist;
        end
        else begin
            in = X;
        end
    end

    
endmodule