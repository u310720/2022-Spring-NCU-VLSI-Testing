module ORA (
    // INPUT
    input clk,
    input rst,
    input in,

    // OUTPUT
    output reg [3:0] signature
);
    always @( posedge clk ) begin
        if (rst)
            signature <= 4'b0;
        else begin 
            signature[2:0] <= signature[3:1];
            signature[3] <= signature[0] ^ in;
        end
    end

endmodule