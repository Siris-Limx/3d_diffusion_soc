module CIM_ctrl_logic_wrapper #(
    parameter int   REG_BUS_ADDR_WIDTH              = -1,
    parameter int   REG_BUS_DATA_WIDTH              = -1,
    parameter int   SRAM_MEM_ADDR_WIDTH	            = -1,
	parameter int   SRAM_MEM_DATA_WIDTH	            = -1,
    parameter int   MACRO_MEM_ADDR_WIDTH	        = -1,
	parameter int   MACRO_MEM_DATA_WIDTH	        = -1,
    parameter int   MACRO_CAL_ADDR_WIDTH	        = -1,
	parameter int   MACRO_CAL_DATA_WIDTH	        = -1,
    parameter int   eDRAM_MEM_ADDR_WIDTH	        = -1,
	parameter int   eDRAM_MEM_DATA_WIDTH	        = -1

    // parameter type  axi_req_t               = logic,
    // parameter type  axi_rsp_t               = logic,
    // parameter type  CIM_Core_reg_req_t      = logic,
    // parameter type  CIM_Core_reg_rsp_t      = logic
    
)   (
    input   logic                           clk_i,
    input   logic                           rst_ni,
    input   logic                           testmode_i,
    // Bus Interface
    REG_BUS.in                              reg_bus_i,
    // input   CIM_Core_reg_req_t              req_i,
    // output  CIM_Core_reg_rsp_t              resp_o,
    // reg interface
    output  logic                           csr_CIM_Core_mem_mux_q,
    output  logic      [15:0]               test_2_q,
    output  logic      [3:0]                test_3_q,
    output  logic      [23:0]               test_4_q,
    // macro output ctrl interface //////////SRAM/////////////
    output  logic                         	    CIM_Core_ctrl_SRAM_mem_req_o,
    output  logic                         	    CIM_Core_ctrl_SRAM_mem_we_o,
    output  logic  [SRAM_MEM_ADDR_WIDTH-1:0]   	CIM_Core_ctrl_SRAM_mem_addr_o,
    output  logic  [SRAM_MEM_DATA_WIDTH/8-1:0] 	CIM_Core_ctrl_SRAM_mem_be_o,
    output  logic  [SRAM_MEM_DATA_WIDTH-1:0]   	CIM_Core_ctrl_SRAM_mem_wdata_o,
    input   logic  [SRAM_MEM_DATA_WIDTH-1:0]   	CIM_Core_ctrl_SRAM_mem_rdata_i,

    // macro output ctrl interface //////////macro/////////////
    output  logic                         	        CIM_Core_ctrl_macro_mem_req_o,
    output  logic                         	        CIM_Core_ctrl_macro_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]   	CIM_Core_ctrl_macro_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0] 	CIM_Core_ctrl_macro_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]   	CIM_Core_ctrl_macro_mem_wdata_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]   	CIM_Core_ctrl_macro_mem_rdata_i,

    output  logic                                   CIM_Core_ctrl_macro_cal_req_o,
    output  logic  [MACRO_CAL_ADDR_WIDTH-1:0]       CIM_Core_ctrl_macro_cal_data_o,
    input   logic  [MACRO_CAL_DATA_WIDTH-1:0]       CIM_Core_ctrl_macro_cal_result_i,

    // macro output ctrl interface //////////eDRAM/////////////
    output  logic                         	        CIM_Core_ctrl_eDRAM_mem_req_o,
    output  logic                         	        CIM_Core_ctrl_eDRAM_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	CIM_Core_ctrl_eDRAM_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	CIM_Core_ctrl_eDRAM_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	CIM_Core_ctrl_eDRAM_mem_wdata_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	CIM_Core_ctrl_eDRAM_mem_rdata_i
);

//////////////////////////////////////////////
// Need to update by the REG_BUS intf
// assign csr_CIM_Core_mem_mux_o = 1'b1;
//////////////////////////////////////////////

    // define reg type according to REG_BUS above
    `REG_BUS_TYPEDEF_ALL(CIM_Core_reg, logic[31:0], logic[31:0], logic[3:0])
    CIM_Core_reg_req_t CIM_Core_reg_req;
    CIM_Core_reg_rsp_t CIM_Core_reg_resp;

    // assign REG_BUS.out to (req_t, rsp_t) pair
    `REG_BUS_ASSIGN_TO_REQ(CIM_Core_reg_req, reg_bus_i)
    `REG_BUS_ASSIGN_FROM_RSP(reg_bus_i, CIM_Core_reg_resp)

logic               csr_CIM_Core_mem_mux_i;
logic               csr_CIM_Core_mem_mux_o;
logic               csr_CIM_Core_mem_mux_we_o;
logic  [15:0]       test_2_i;
logic  [15:0]       test_2_o;
logic               test_2_we_o;
logic  [3:0]        test_3_i;
logic  [3:0]        test_3_o;
logic               test_3_we_o;
logic  [23:0]       test_4_i;
logic  [23:0]       test_4_o;
logic               test_4_we_o;

(* DONT_TOUCH = "TRUE" *)  CIM_Core_regs #(
    .reg_req_t     (CIM_Core_reg_req_t),
    .reg_rsp_t     (CIM_Core_reg_rsp_t)
) cim_core_logic_regs_inst (
    // .clk_i                  (clk_i),
    // .rst_ni                 (rst_ni),
    // .testmode_i             (testmode_i),
    // .req_i                  (req_i),
    // .resp_o                 (resp_o),
    // .csr_                   (csr_)
    .csr_CIM_Core_mem_mux_i                   (csr_CIM_Core_mem_mux_i       ),
    .csr_CIM_Core_mem_mux_o                   (csr_CIM_Core_mem_mux_o       ),
    .csr_CIM_Core_mem_mux_we_o                (csr_CIM_Core_mem_mux_we_o    ),
    .csr_CIM_Core_mem_mux_re_o                (     ),
    .test_2_i                   (test_2_i       ),
    .test_2_o                   (test_2_o       ),
    .test_2_we_o                (test_2_we_o    ),
    .test_2_re_o                (     ),
    .test_3_i                   (test_3_i       ),
    .test_3_o                   (test_3_o       ),
    .test_3_we_o                (test_3_we_o    ),
    .test_3_re_o                (     ),
    .test_4_i                   (test_4_i       ),
    .test_4_o                   (test_4_o       ),
    .test_4_we_o                (test_4_we_o    ),
    .test_4_re_o                (     ),
    .req_i                      (CIM_Core_reg_req          ),
    .resp_o                     (CIM_Core_reg_resp         )
);


    // for (genvar i = 0; i < N_TARGET; i++) begin
    //     assign ie_i[i] = {ie_q[i][N_SOURCE-1:0], 1'b0};
    // end

    // for (genvar i = 1; i < N_SOURCE + 1; i++) begin
    //     assign prio_i[i] = prio_q[i - 1];
    // end
    assign csr_CIM_Core_mem_mux_i = csr_CIM_Core_mem_mux_q;
    assign test_2_i = test_2_q;
    assign test_3_i = test_3_q;
    assign test_4_i = test_4_q;

    // registers
    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            csr_CIM_Core_mem_mux_q          <= '0;
            test_2_q                        <= '0;
            test_3_q                        <= '0;
            test_4_q                        <= '0;
        end else begin
        // source zero is 0
            csr_CIM_Core_mem_mux_q   <= csr_CIM_Core_mem_mux_we_o   ?    csr_CIM_Core_mem_mux_o     :    csr_CIM_Core_mem_mux_q     ;
            test_2_q                 <= test_2_we_o                 ?    test_2_o                   :    test_2_q                   ; 
            test_3_q                 <= test_3_we_o                 ?    test_3_o                   :    test_3_q                   ;
            test_4_q                 <= test_4_we_o                 ?    test_4_o                   :    test_4_q                   ;
        end
    end


// attn_wrapper #(
//     .REG_BUS_ADDR_WIDTH     (REG_BUS_ADDR_WIDTH),
//     .REG_BUS_DATA_WIDTH     (REG_BUS_DATA_WIDTH),
//     .SRAM_MEM_ADDR_WIDTH    (SRAM_MEM_ADDR_WIDTH),
//     .SRAM_MEM_DATA_WIDTH    (SRAM_MEM_DATA_WIDTH),
//     .MACRO_MEM_ADDR_WIDTH   (MACRO_MEM_ADDR_WIDTH),
//     .MACRO_MEM_DATA_WIDTH   (MACRO_MEM_DATA_WIDTH),
//     .MACRO_CAL_ADDR_WIDTH   (MACRO_CAL_ADDR_WIDTH),
//     .MACRO_CAL_DATA_WIDTH   (MACRO_CAL_DATA_WIDTH)
// ) attn_wrapper_inst (
//     .clk_i                  (clk_i),
//     .rst_ni                 (rst_ni),
//     .testmode_i             (testmode_i),
//     .req_i                  (req_i),
//     .resp_o                 (resp_o),
//     .csr_                   (csr_),
//     .CIM_Core_ctrl_SRAM_mem_req_o    (CIM_Core_ctrl_SRAM_mem_req_o),
//     .CIM_Core_ctrl_SRAM_mem_we_o     (CIM_Core_ctrl_SRAM_mem_we_o),
//     .CIM_Core_ctrl_SRAM_mem_addr_o   (CIM_Core_ctrl_SRAM_mem_addr_o),
//     .CIM_Core_ctrl_SRAM_mem_be_o     (CIM_Core_ctrl_SRAM_mem_be_o),
//     .CIM_Core_ctrl_SRAM_mem_wdata_o  (CIM_Core_ctrl_SRAM_mem_wdata_o),
//     .CIM_Core_ctrl_SRAM_mem_rdata_i  (CIM_Core_ctrl_SRAM_mem_rdata_i),
//     .CIM_Core_ctrl_macro_mem_req_o   (CIM_Core_ctrl_macro_mem_req_o),
//     .CIM_Core_ctrl_macro_mem_we_o    (CIM_Core_ctrl_macro_mem_we_o),
//     .CIM_Core_ctrl_macro_mem_addr_o  (CIM_Core_ctrl_macro_mem_addr_o),
//     .CIM_Core_ctrl_macro_mem_be_o    (CIM_Core_ctrl_macro_mem_be_o),
//     .CIM_Core_ctrl_macro_mem_wdata_o (CIM_Core_ctrl_macro_mem_wdata_o),
//     .CIM_Core_ctrl_macro_mem_rdata_i (CIM_Core_ctrl_macro_mem_rdata_i),
//     .CIM_Core_ctrl_macro_cal_req_o   (CIM_Core_ctrl_macro_cal_req_o),
//     .CIM_Core_ctrl_macro_cal_data_o  (CIM_Core_ctrl_macro_cal_data_o),
//     .CIM_Core_ctrl_macro_cal_result_i(CIM_Core_ctrl_macro_cal_result_i)
// );

// operator_wrapper #(
//     .REG_BUS_ADDR_WIDTH     (REG_BUS_ADDR_WIDTH),
//     .REG_BUS_DATA_WIDTH     (REG_BUS_DATA_WIDTH),
//     .SRAM_MEM_ADDR_WIDTH    (SRAM_MEM_ADDR_WIDTH),
//     .SRAM_MEM_DATA_WIDTH    (SRAM_MEM_DATA_WIDTH),
//     .MACRO_MEM_ADDR_WIDTH   (MACRO_MEM_ADDR_WIDTH),
//     .MACRO_MEM_DATA_WIDTH   (MACRO_MEM_DATA_WIDTH),
//     .MACRO_CAL_ADDR_WIDTH   (MACRO_CAL_ADDR_WIDTH),
//     .MACRO_CAL_DATA_WIDTH   (MACRO_CAL_DATA_WIDTH),
//     .CIM_Core_reg_req_t     (CIM_Core_reg_req_t),
//     .CIM_Core_reg_rsp_t     (CIM_Core_reg_rsp_t)
// ) operator_wrapper_inst (
//     .clk_i                  (clk_i),
//     .rst_ni                 (rst_ni),
//     .testmode_i             (testmode_i),
//     .req_i                  (req_i),
//     .resp_o                 (resp_o),
//     .csr_                   (csr_),
//     .CIM_Core_ctrl_SRAM_mem_req_o    (CIM_Core_ctrl_SRAM_mem_req_o),
//     .CIM_Core_ctrl_SRAM_mem_we_o     (CIM_Core_ctrl_SRAM_mem_we_o),
//     .CIM_Core_ctrl_SRAM_mem_addr_o   (CIM_Core_ctrl_SRAM_mem_addr_o),
//     .CIM_Core_ctrl_SRAM_mem_be_o     (CIM_Core_ctrl_SRAM_mem_be_o),
//     .CIM_Core_ctrl_SRAM_mem_wdata_o  (CIM_Core_ctrl_SRAM_mem_wdata_o),
//     .CIM_Core_ctrl_SRAM_mem_rdata_i  (CIM_Core_ctrl_SRAM_mem_rdata_i),
//     .CIM_Core_ctrl_macro_mem_req_o   (CIM_Core_ctrl_macro_mem_req_o),
//     .CIM_Core_ctrl_macro_mem_we_o    (CIM_Core_ctrl_macro_mem_we_o),
//     .CIM_Core_ctrl_macro_mem_addr_o  (CIM_Core_ctrl_macro_mem_addr_o),
//     .CIM_Core_ctrl_macro_mem_be_o    (CIM_Core_ctrl_macro_mem_be_o),
//     .CIM_Core_ctrl_macro_mem_wdata_o (CIM_Core_ctrl_macro_mem_wdata_o),
//     .CIM_Core_ctrl_macro_mem_rdata_i (CIM_Core_ctrl_macro_mem_rdata_i),
//     .CIM_Core_ctrl_macro_cal_req_o   (CIM_Core_ctrl_macro_cal_req_o),   
// );

endmodule