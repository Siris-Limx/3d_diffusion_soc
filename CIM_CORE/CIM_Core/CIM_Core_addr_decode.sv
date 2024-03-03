module CIM_Core_addr_decode #(
    parameter   int unsigned    NoRules             = 32'd0,
    parameter   int             AXI_ADDR_WIDTH      = -1,
    parameter   type            rule_t              = logic,
    parameter   int unsigned    IdxWidth            = 4
)  (
    input   logic   [AXI_ADDR_WIDTH-1:0]    addr_i,
    input   rule_t  [NoRules-1:0]           addr_map_i,
    output  logic   [IdxWidth-1:0]          idx_o,
    output  logic                           dec_valid_o
);

    // logic [NoRules-1:0] matched_rules; // purely for address map debugging

    always_comb begin
        // default assignments
        // matched_rules = '0;
        dec_valid_o   = 1'b0;
        idx_o         = '0;

        // match the rules
        for (int unsigned i = 0; i < NoRules; i++) begin
            if ((addr_i >= addr_map_i[i].start_addr) && (addr_i < addr_map_i[i].end_addr)) begin
                // matched_rules[i] = 1'b1;
                dec_valid_o      = 1'b1;
                // dec_error_o      = 1'b0;
                idx_o            = addr_map_i[i].idx;
            end
        end
    end

endmodule