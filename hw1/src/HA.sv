module HA (
    // Input
    input x, // 
    input y, // 

    // Output
    output sum, // 
    output carry //
);

    assign sum = x ^ y;
    assign carry = x & y;
    
endmodule