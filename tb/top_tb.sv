module top_tb;

    logic sys_clk_p, rst_n;

    initial begin
        sys_clk_p = 1;
        rst_n = 0;

        #20
        rst_n = 1;
    end

    always #5 sys_clk_p = ~sys_clk_p;

    ariane_xilinx u_ariane_xilinx
    (
        .sys_clk(sys_clk_p),
        .cpu_resetn(rst_n),
        .trst_n(1'b1)
    );

endmodule