`include "HA.sv"

module FA (
    input		x,			// 
    input		y,			// 
    input		carry_in,		// 
    output		sum,		// 
    output		carry_out		// 
);
    wire ws, wc1, wc2;

    HA ha1 (
        .x(x),
        .y(y),
        .sum(ws),
        .carry(wc1)
    );
    HA ha2 (
        .x(ws),
        .y(carry_in),
        .sum(sum),
        .carry(wc2)
    );
    assign carry_out = wc1 | wc2;
    
endmodule