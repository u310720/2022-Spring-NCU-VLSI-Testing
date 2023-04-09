`timescale 10ns/10ps

module DUT_tb ();
    // Input
    logic clk;
    logic rst;
    logic A;
    logic B;
    logic C;
    logic D;
    logic E;

    // Output
    reg F;

    initial begin
        clk <= 0;
        rst <= 1;
        #2 rst <= 0;
    end

    always #1 clk = ~clk;

    initial begin
        $fsdbDumpfile("DUT.fsdb");
        $fsdbDumpvars(0, dut_tb);
    end

    initial begin
        #0   {A, B, C, D, E} <= 5'b00000;
        #2   {A, B, C, D, E} <= 5'b10101;
        #56  {A, B, C, D, E} <= 5'b10010;
        #56  {A, B, C, D, E} <= 5'b00010;
        #56  {A, B, C, D, E} <= 5'b10100;
        #56  $finish;
    end

    DUT dut_tb (.*);

endmodule