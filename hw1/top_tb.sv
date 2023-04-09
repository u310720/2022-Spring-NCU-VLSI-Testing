`timescale 10ns/100ps
`include "top.sv"

module top_tb();
    // Input
    logic [16 - 1:0] X; // 
    logic [16 - 1:0] Y; // 
    logic C0; // 
    logic Rst; // reset
    logic Clk; // clock
    logic En; // used to assert the embedded pattern generator
    logic Test; // used to switch the circuit between normal mode(0) and test mode(1)
    
    // Output
    logic [16 - 1:0] S; // 
    logic CN; // carry out
    logic P_F; // Pass or Fail

    initial begin
        Clk <= 0;
        Rst <= 1;
        En <= 0;
        Test <= 0;
        #10 Rst <= 0;
    end

    always #5 Clk = ~Clk;

    initial begin
        $dumpfile("top.fsdb");
        $dumpvars(0, top_tb);
        // $dumpDMA();
    end

    initial begin
        #1  X <= 16'h00;   Y <= 16'h00; C0 <= 0; En <= 1;
        #12 X <= 16'h00;   Y <= 16'h00; C0 <= 1;
        #10  X <= 16'h00;   Y <= 16'h00; C0 <= 0;
        #10  X <= 16'h01;   Y <= 16'h76;
        #10  X <= 16'h12;   Y <= 16'h65;
        #10  X <= 16'h23;   Y <= 16'h54;
        #10  X <= 16'h34;   Y <= 16'h43;
        #10  X <= 16'h45;   Y <= 16'h32;
        #10  X <= 16'h56;   Y <= 16'h21;
        #10  X <= 16'h67;   Y <= 16'h10;
        #10  X <= 16'h01;   Y <= 16'h76; Test <= 1;
        #10  X <= 16'h12;   Y <= 16'h65;
        #10  X <= 16'h23;   Y <= 16'h54;
        #10  X <= 16'h34;   Y <= 16'h43;
        #10  X <= 16'h45;   Y <= 16'h32;
        #10  X <= 16'h56;   Y <= 16'h21;
        #10  X <= 16'h67;   Y <= 16'h10;
        #20  $finish;
    end

    top #(.WORDLEN(16)) top_tb (.*);

endmodule