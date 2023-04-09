// fault injection
module FI (
    input logic vdd, // 
    input logic gnd, // 
    input logic data, // 
    output logic out
);
    always_comb begin : mux
        case ({vdd, gnd})
            2'b00: out = data;
            2'b01: out = 1'b0;
            2'b10: out = 1'b1;
            2'b11: out = 1'bx;
        endcase
    end
endmodule