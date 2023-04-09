`timescale 10ns/10ps
`define CYCLE 2

module top_tb ();
    // Input
    reg clk;
    reg rst;
    reg tm;
    reg fi;
    reg [3:0] X;

    // Output
    reg F;
    reg [3:0] signature;

    always #(`CYCLE / 2) clk = ~clk;

    initial begin
        rst <= 1; 
        clk <= 0;
        
        /* (a) BIST */
        // tm <= 1; fi <= 0;
        // #(`CYCLE * 1) rst <= 0;

        /* (b) 1, 2, ..., 15 */
        tm <= 0; fi <= 1;
        // X <= 1;
        // #(`CYCLE * 1) rst <= 0;
        // #(`CYCLE * 1) X <= 2;
        // #(`CYCLE * 1) X <= 3;
        // #(`CYCLE * 1) X <= 4;
        // #(`CYCLE * 1) X <= 5;
        // #(`CYCLE * 1) X <= 6;
        // #(`CYCLE * 1) X <= 7;
        // #(`CYCLE * 1) X <= 8;
        // #(`CYCLE * 1) X <= 9;
        // #(`CYCLE * 1) X <= 10;
        // #(`CYCLE * 1) X <= 11;
        // #(`CYCLE * 1) X <= 12;
        // #(`CYCLE * 1) X <= 13;
        // #(`CYCLE * 1) X <= 14;
        // #(`CYCLE * 1) X <= 15;
        
        /* (c) 15, 14, ..., 1 */
        // tm <= 0; fi <= 1;
        X <= 15;
        #(`CYCLE * 1) rst <= 0;
        #(`CYCLE * 1) X <= 14;
        #(`CYCLE * 1) X <= 13;
        #(`CYCLE * 1) X <= 12;
        #(`CYCLE * 1) X <= 11;
        #(`CYCLE * 1) X <= 10;
        #(`CYCLE * 1) X <= 9;
        #(`CYCLE * 1) X <= 8;
        #(`CYCLE * 1) X <= 7;
        #(`CYCLE * 1) X <= 6;
        #(`CYCLE * 1) X <= 5;
        #(`CYCLE * 1) X <= 4;
        #(`CYCLE * 1) X <= 3;
        #(`CYCLE * 1) X <= 2;
        #(`CYCLE * 1) X <= 1;

        #(`CYCLE * 1) $finish;
    end

    initial begin
        $fsdbDumpfile("top.fsdb");
        $fsdbDumpvars(0, top_tb);
    end

    top top_tb (
        .clk(clk),
        .rst(rst),
        .tm(tm),
        .fi(fi),
        .X(X),
        .F(F),
        .signature(signature)
    );

endmodule
