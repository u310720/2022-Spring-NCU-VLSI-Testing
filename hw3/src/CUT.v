module CUT (
    // Input
    input faultInject,
    input [3:0] in,
    
    // Output
    output wire F
);
    wire [5:0] andOut;
    wire [3:0] notIn;
    wire [1:0] orOut;
    wire a;

    assign notIn = ~in;
    assign andOut[0] = in[0] & notIn[1] & notIn[2] & notIn[3];
    assign andOut[1] = notIn[0] & notIn[1] & in[2] & notIn[3];
    assign andOut[2] = in[0] & in[1] & notIn[2] & in[3];
    assign andOut[3] = notIn[0] & in[1] & notIn[2] & notIn[3];
    assign andOut[4] = notIn[0] & in[1] & in[2] & in[3];
    assign andOut[5] = in[0] & in[1] & notIn[2] & in[3];
    assign orOut[0] = andOut[0] | andOut[1];
    assign orOut[1] = andOut[2] | andOut[3] | andOut[4] | andOut[5];
    assign a= faultInject ? 1'b0 : orOut[1];
    assign F = orOut[0] | a;
endmodule