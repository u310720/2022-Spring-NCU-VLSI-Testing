module BIST #(
    parameter N = 16 // 
) (
    // Ctrl
    input rst, // reset
    input clk, // clock
    input test, // 
    
    // Output from DUT
    input [N - 1 :0] sum_fbk, // feedback from DUT
    input cn_fbk, // feedback from DUT
    
    // BIST Pattern
    output logic c0_pat, // test pattern
    output logic [N - 1:0] x_pat, // test pattern
    output logic [N - 1:0] y_pat,  // test pattern

    // Result
    output logic p_f // pass=0, fail=1
);

    logic [2:0] state; // size of FA truth table
    logic en;

    always_ff @( posedge clk ) begin : set_en
        if (state == 3'd7 | rst | !test) begin
            en <= 1'b0;
        end
        else begin
            en <= 1'b1;
        end
    end

    always_ff @( posedge clk ) begin : rst_test_ctrl_count_up
        if (rst) begin 
            state <= 3'd0;
        end
        else begin 
            state <= (test & en) ? state + 3'd1 : state; 
        end   
    end
    
    always_ff @( posedge clk ) begin : gen_c0_pat
        parameter [7:0] cin_odd = 8'b0001_0111;
        case (state)
            3'd0: c0_pat <= cin_odd[0];
            3'd1: c0_pat <= cin_odd[1];
            3'd2: c0_pat <= cin_odd[2];
            3'd3: c0_pat <= cin_odd[3];
            3'd4: c0_pat <= cin_odd[4];
            3'd5: c0_pat <= cin_odd[5];
            3'd6: c0_pat <= cin_odd[6];
            3'd7: c0_pat <= cin_odd[7];
        endcase
    end

    genvar i;
    generate // generate x_pat, y_pat
        parameter [7:0] x_odd   = 8'b0010_1011;
        parameter [7:0] x_even  = 8'b0011_0011;
        parameter [7:0] y_odd   = 8'b0100_1101;
        parameter [7:0] y_even  = 8'b0101_0101;
        for (i = 0; i + 1 < N; i = i + 2) begin
            always_ff @( posedge clk ) begin : pat_gen
                case (state)
                    3'd0: begin
                        x_pat[i] <= x_even[0];
                        y_pat[i] <= y_even[0];
                        x_pat[i + 1] <= x_odd[0];
                        y_pat[i + 1] <= y_odd[0];
                    end
                    3'd1: begin
                        x_pat[i] <= x_even[1];
                        y_pat[i] <= y_even[1];
                        x_pat[i + 1] <= x_odd[1];
                        y_pat[i + 1] <= y_odd[1];
                    end
                    3'd2: begin
                        x_pat[i] <= x_even[2];
                        y_pat[i] <= y_even[2];
                        x_pat[i + 1] <= x_odd[2];
                        y_pat[i + 1] <= y_odd[2];
                    end
                    3'd3: begin
                        x_pat[i] <= x_even[3];
                        y_pat[i] <= y_even[3];
                        x_pat[i + 1] <= x_odd[3];
                        y_pat[i + 1] <= y_odd[3];
                    end
                    3'd4: begin
                        x_pat[i] <= x_even[4];
                        y_pat[i] <= y_even[4];
                        x_pat[i + 1] <= x_odd[4];
                        y_pat[i + 1] <= y_odd[4];
                    end
                    3'd5: begin
                        x_pat[i] <= x_even[5];
                        y_pat[i] <= y_even[5];
                        x_pat[i + 1] <= x_odd[5];
                        y_pat[i + 1] <= y_odd[5];
                    end
                    3'd6: begin
                        x_pat[i] <= x_even[6];
                        y_pat[i] <= y_even[6];
                        x_pat[i + 1] <= x_odd[6];
                        y_pat[i + 1] <= y_odd[6];
                    end
                    3'd7: begin
                        x_pat[i] <= x_even[7];
                        y_pat[i] <= y_even[7];
                        x_pat[i + 1] <= x_odd[7];
                        y_pat[i + 1] <= y_odd[7];
                    end
                endcase
            end
        end
        for (i = 0; i < N % 2; i = i + 1) begin
            always_ff @( posedge clk ) begin : pat_gen_res
                case (state)
                    3'd0: begin
                        x_pat[i + 1] <= x_odd[0];
                        y_pat[i + 1] <= y_odd[0];
                    end
                    3'd1: begin
                        x_pat[i + 1] <= x_odd[1];
                        y_pat[i + 1] <= y_odd[1];
                    end
                    3'd2: begin
                        x_pat[i + 1] <= x_odd[2];
                        y_pat[i + 1] <= y_odd[2];
                    end
                    3'd3: begin
                        x_pat[i + 1] <= x_odd[3];
                        y_pat[i + 1] <= y_odd[3];
                    end
                    3'd4: begin
                        x_pat[i + 1] <= x_odd[4];
                        y_pat[i + 1] <= y_odd[4];
                    end
                    3'd5: begin
                        x_pat[i + 1] <= x_odd[5];
                        y_pat[i + 1] <= y_odd[5];
                    end
                    3'd6: begin
                        x_pat[i + 1] <= x_odd[6];
                        y_pat[i + 1] <= y_odd[6];
                    end
                    3'd7: begin
                        x_pat[i + 1] <= x_odd[7];
                        y_pat[i + 1] <= y_odd[7];
                    end
                endcase
            end
        end
    endgenerate


    always_ff @( posedge clk ) begin : detect
        if (rst) begin
            p_f <= 1'b0;
        end
        else if (!(en & test & ({cn_fbk, sum_fbk} != x_pat + y_pat + c0_pat))) begin
            p_f <= (p_f == 1'b1) ? 1'b1 : 1'b0;
        end
        else begin
            p_f <= 1'b1;
        end
    end

endmodule