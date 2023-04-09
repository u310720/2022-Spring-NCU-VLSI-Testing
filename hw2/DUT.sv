`include "FI.sv"
`include "FSM.sv"
`include "enum.sv"

module DUT (
    // Input
    input clk,
    input rst,
    input A,
    input B,
    input C,
    input D,
    input E,

    // Output
    output logic F,
    output logic Detect
);
    logic w_al;
    logic w_bi;
    logic w_cg;
    logic w_dg;
    logic w_eh;
    logic [1:0]w_gi;
    logic [1:0]w_hm;
    logic [1:0]w_i_stem;
    logic w_jl;
    logic w_km;
    logic [1:0]w_lf;
    logic [1:0]w_mf;
    logic w_fout;
    logic [27:0]sel;
    logic ans;
    
    FSM fsm(
        .clk(clk),
        .rst(rst),
        .sel(sel)
    );

    // detect fault
    always_ff @( posedge clk ) begin : detect
        if (rst || sel[FaultFree]) begin
            ans <= F;
        end
        else begin
            ans <= ans;
        end
        if (ans != F) begin
            Detect <= 1'b1;
        end
        else begin
            Detect <= 1'b0;
        end
    end

    // circuit
    nor cdg(w_gi[0], w_cg, w_dg);
    not eh(w_hm[0], w_eh);
    and bgi(w_i_stem[0], w_bi, w_gi[1]);
    nor ajl(w_lf[0], w_al, w_jl);
    and khm(w_mf[0], w_km, w_hm[1]);
    or lmf(w_fout, w_lf[1], w_mf[1]);


    // fault injection    
    FI AL(.vdd(sel[A_1]), .gnd(sel[A_0]), .data(A), .out(w_al));
    FI BI(.vdd(sel[B_1]), .gnd(sel[B_0]), .data(B), .out(w_bi));
    FI CG(.vdd(sel[C_1]), .gnd(sel[C_0]), .data(C), .out(w_cg));
    FI DG(.vdd(sel[D_1]), .gnd(sel[D_0]), .data(D), .out(w_dg));
    FI EH(.vdd(sel[E_1]), .gnd(sel[E_0]), .data(E), .out(w_eh));
    FI GI(.vdd(sel[G_1]), .gnd(sel[G_0]), .data(w_gi[0]), .out(w_gi[1]));
    FI HM(.vdd(sel[H_1]), .gnd(sel[H_0]), .data(w_hm[0]), .out(w_hm[1]));
    FI I_STEM(.vdd(sel[I_1]), .gnd(sel[I_0]), .data(w_i_stem[0]), .out(w_i_stem[1]));
    FI JL(.vdd(sel[J_1]), .gnd(sel[J_0]), .data(w_i_stem[1]), .out(w_jl));
    FI KM(.vdd(sel[K_1]), .gnd(sel[K_0]), .data(w_i_stem[1]), .out(w_km));
    FI LF(.vdd(sel[L_1]), .gnd(sel[L_0]), .data(w_lf[0]), .out(w_lf[1]));
    FI MF(.vdd(sel[M_1]), .gnd(sel[M_0]), .data(w_mf[0]), .out(w_mf[1]));
    FI FOUT(.vdd(sel[F_1]), .gnd(sel[F_0]), .data(w_fout), .out(F));
    
endmodule
