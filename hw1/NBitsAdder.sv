`include "FA.sv"

module NBitsAdder #(
    parameter N = 16 // 
) (
    // Input
    input [N - 1:0] x, // 
    input [N - 1:0] y, // 
    input c0, // 
    
    // Output
    output [N - 1:0] sum, // 
    output cn // 
);
    
    wire [N - 1:0] carry;
    FA fa (
        .x(x[0]),
        .y(y[0]),
        .carry_in(c0),
        .sum(sum[0]),
        .carry_out(carry[0])
    );
    generate
        for (genvar i = 1; i < N; i = i + 1) begin
            FA fa (
                .x(x[i]),
                .y(y[i]),
                .carry_in(carry[i - 1]),
                .sum(sum[i]),
                .carry_out(carry[i])
            );
        end
    endgenerate
    assign cn = carry[N - 1];

endmodule