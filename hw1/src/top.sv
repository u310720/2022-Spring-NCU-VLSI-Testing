`include "NBitsAdder.sv"
`include "BIST.sv"
`include "FaultInjection.sv"

module top #(
    parameter WORDLEN = 16 // wordlength of adder
) (
    // Input
    input [WORDLEN - 1:0] X, // 
    input [WORDLEN - 1:0] Y, // 
    input C0, // 
    input Rst, // reset
    input Clk, // clock
    input En, // used to assert the embedded pattern generator
    input Test, // used to switch the circuit between normal mode(0) and test mode(1)
    
    // Output
    output logic [WORDLEN - 1:0] S, // 
    output logic CN, // carry out
    output logic P_F // Pass or Fail
);
    logic c0_mux;
    logic [WORDLEN - 1:0] x_mux, y_mux, s_mux;
    logic c0_pat, cn_mux;
    logic [WORDLEN - 1:0] x_pat, y_pat;
    logic sa0;
    
    always_comb begin : test_mux
        if (Test) begin
            x_mux = x_pat;
            y_mux = y_pat;
            c0_mux = c0_pat;
        end
        else begin
            x_mux = X;
            y_mux = Y;
            c0_mux = C0;
        end
        
    end

    always_comb begin : enable_mux
        if (En) begin
            S = s_mux;
            CN = cn_mux;
        end
        else begin
            S = {WORDLEN{1'b0}};
            CN = 1'b0;
        end
    end
    

    BIST #(.N(WORDLEN)) bist(
        // Ctrl
        .rst(Rst),
        .clk(Clk),
        .test(Test),

        // DUT output
        .sum_fbk(S),
        .cn_fbk(CN),

        // BIST pattern
        .c0_pat(c0_pat),
        .x_pat(x_pat),
        .y_pat(y_pat),

        // Result
        .p_f(P_F)
    );

    // NBitsAdder #(.N(WORDLEN)) DUT_PASS(
    //     .x(x_mux),
    //     .y(y_mux),
    //     .c0(c0_mux),
    //     .sum(s_mux),
    //     .cn(cn_mux)
    // );

    SA0 _sa0 (
        .in(X[0]),
        .out(sa0)
    );

    NBitsAdder #(.N(WORDLEN)) DUT_FAIL(
        .x({x_mux[WORDLEN - 1:1], sa0}),
        .y(y_mux),
        .c0(c0_mux),
        .sum(s_mux),
        .cn(cn_mux)
    );
    
endmodule