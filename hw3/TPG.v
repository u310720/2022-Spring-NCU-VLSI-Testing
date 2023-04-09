module TPG (
    // Input
    input clk,
    input rst,
    
    // Output
    output reg [3:0] pttn
);
    
    always @( posedge clk ) begin
        if (rst) begin
            pttn <= 4'b1000;
        end
        else begin 
            pttn <= {pttn[2:1], pttn[0] ^ pttn[3], pttn[3]};
        end
    end
endmodule