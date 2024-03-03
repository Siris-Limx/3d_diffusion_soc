module CIM_Core_wrapper #(
    parameter int   AxiAddrWidth            = -1,
    parameter int   AxiDataWidth            = -1,
    parameter int   AxiMusterIdWidth        = -1,
    parameter int   AxiSlaverIdWidth        = -1,
    parameter int   AxiUserWidth            = -1,
    parameter int   RegBusAddrWidth         = -1,
    parameter int   RegBusDataWidth         = -1,
    parameter int   SramMemAddrWidth        = -1,
    parameter int   SramMemDataWidth        = -1,
    parameter int   MacroMemAddrWidth       = -1,
    parameter int   MacroMemDataWidth       = -1,
    parameter int   MacroCalAddrWidth       = -1,
    parameter int   MacroCalDataWidth       = -1,
    parameter int   eDRAMMemAddrWidth       = -1,
    parameter int   eDRAMMemDataWidth       = -1,

    parameter   int unsigned    NoRules             = 32'd0,
    parameter   int unsigned    IdxWidth            = 4,
    parameter type  rule_t                  = logic,
    parameter type  axi_req_t               = logic,
    parameter type  axi_rsp_t               = logic
    // parameter type  CIM_Core_reg_req_t      = logic,
    // parameter type  CIM_Core_reg_rsp_t      = logic
)   (
    input   logic                           clk_i,
    input   logic                           rst_ni,
    input   logic                           testmode_i,
    AXI_BUS.Slave                           CIM_Core_regbus,
    AXI_BUS.Slave                           CIM_Core_sram,
    AXI_BUS.Slave                           CIM_Core_macro,
    AXI_BUS.Slave                           CIM_Core_eDRAM
);

logic                                   csr_CIM_Core_mem_mux;
logic   [15:0]                          test_2_q;
logic   [3:0]                           test_3_q;
logic   [23:0]                          test_4_q;

REG_BUS #(
        .ADDR_WIDTH     (RegBusAddrWidth),
        .DATA_WIDTH     (RegBusDataWidth)
    )   reg_bus_CIM_Core ( clk_i );
// CIM_Core_reg_req_t                      CIM_Core_reg_req;
// CIM_Core_reg_rsp_t                      CIM_Core_reg_resp;

logic                         	        CIM_Core_ctrl_SRAM_mem_req;
logic                         	        CIM_Core_ctrl_SRAM_mem_we;
logic  [SramMemAddrWidth-1:0]           CIM_Core_ctrl_SRAM_mem_addr;
logic  [SramMemDataWidth/8-1:0]         CIM_Core_ctrl_SRAM_mem_be;
logic  [SramMemDataWidth-1:0]           CIM_Core_ctrl_SRAM_mem_wdata;
logic  [SramMemDataWidth-1:0]           CIM_Core_ctrl_SRAM_mem_rdata;

logic                         	        CIM_Core_ctrl_macro_mem_req;
logic                         	        CIM_Core_ctrl_macro_mem_we;
logic  [MacroMemAddrWidth-1:0]   	    CIM_Core_ctrl_macro_mem_addr;
logic  [MacroMemDataWidth/8-1:0] 	    CIM_Core_ctrl_macro_mem_be;
logic  [MacroMemDataWidth-1:0]   	    CIM_Core_ctrl_macro_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    CIM_Core_ctrl_macro_mem_rdata;

logic                                   CIM_Core_ctrl_macro_cal_req;        // Floating now without the CIM Behavior Model
logic  [MacroCalAddrWidth-1:0]          CIM_Core_ctrl_macro_cal_data;       // Floating now without the CIM Behavior Model
logic  [MacroCalDataWidth-1:0]          CIM_Core_ctrl_macro_cal_result;     // Floating now without the CIM Behavior Model

logic                         	        CIM_Core_ctrl_eDRAM_mem_req   ;
logic                         	        CIM_Core_ctrl_eDRAM_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    CIM_Core_ctrl_eDRAM_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    CIM_Core_ctrl_eDRAM_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    CIM_Core_ctrl_eDRAM_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    CIM_Core_ctrl_eDRAM_mem_rdata ;

logic                         	        sram_mem_req   ;
logic                         	        sram_mem_we    ;
logic  [SramMemAddrWidth-1:0]           sram_mem_addr  ;
logic  [SramMemDataWidth/8-1:0]         sram_mem_be    ;
logic  [SramMemDataWidth-1:0]           sram_mem_wdata ;
logic  [SramMemDataWidth-1:0]           sram_mem_rdata ;

logic                         	        macro_0_mem_req  ;
logic                         	        macro_0_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_0_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_0_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_0_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_0_mem_rdata;
logic                         	        macro_1_mem_req  ;
logic                         	        macro_1_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_1_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_1_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_1_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_1_mem_rdata;
logic                         	        macro_2_mem_req  ;
logic                         	        macro_2_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_2_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_2_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_2_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_2_mem_rdata;
logic                         	        macro_3_mem_req  ;
logic                         	        macro_3_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_3_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_3_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_3_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_3_mem_rdata;
logic                         	        macro_4_mem_req  ;
logic                         	        macro_4_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_4_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_4_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_4_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_4_mem_rdata;
logic                         	        macro_5_mem_req  ;
logic                         	        macro_5_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_5_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_5_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_5_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_5_mem_rdata;
logic                         	        macro_6_mem_req  ;
logic                         	        macro_6_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_6_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_6_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_6_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_6_mem_rdata;
logic                         	        macro_7_mem_req  ;
logic                         	        macro_7_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_7_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_7_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_7_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_7_mem_rdata;
logic                         	        macro_8_mem_req  ;
logic                         	        macro_8_mem_we   ;
logic  [MacroMemAddrWidth-1:0]   	    macro_8_mem_addr ;
logic  [MacroMemDataWidth/8-1:0] 	    macro_8_mem_be   ;
logic  [MacroMemDataWidth-1:0]   	    macro_8_mem_wdata;
logic  [MacroMemDataWidth-1:0]   	    macro_8_mem_rdata;

logic                         	        eDRAM_0_mem_req    ;
logic                         	        eDRAM_0_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_0_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_0_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_0_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_0_mem_rdata  ;
logic                         	        eDRAM_1_mem_req    ;
logic                         	        eDRAM_1_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_1_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_1_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_1_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_1_mem_rdata  ;
logic                         	        eDRAM_2_mem_req    ;
logic                         	        eDRAM_2_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_2_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_2_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_2_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_2_mem_rdata  ;
logic                         	        eDRAM_3_mem_req    ;
logic                         	        eDRAM_3_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_3_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_3_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_3_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_3_mem_rdata  ;
logic                         	        eDRAM_4_mem_req    ;
logic                         	        eDRAM_4_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_4_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_4_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_4_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_4_mem_rdata  ;
logic                         	        eDRAM_5_mem_req    ;
logic                         	        eDRAM_5_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_5_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_5_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_5_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_5_mem_rdata  ;
logic                         	        eDRAM_6_mem_req    ;
logic                         	        eDRAM_6_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_6_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_6_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_6_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_6_mem_rdata  ;
logic                         	        eDRAM_7_mem_req    ;
logic                         	        eDRAM_7_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_7_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_7_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_7_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_7_mem_rdata  ;
logic                         	        eDRAM_8_mem_req    ;
logic                         	        eDRAM_8_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_8_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_8_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_8_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_8_mem_rdata  ;
logic                         	        eDRAM_9_mem_req    ;
logic                         	        eDRAM_9_mem_we     ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_9_mem_addr   ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_9_mem_be     ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_9_mem_wdata  ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_9_mem_rdata  ;
logic                         	        eDRAM_10_mem_req   ;
logic                         	        eDRAM_10_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_10_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_10_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_10_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_10_mem_rdata ;
logic                         	        eDRAM_11_mem_req   ;
logic                         	        eDRAM_11_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_11_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_11_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_11_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_11_mem_rdata ;
logic                         	        eDRAM_12_mem_req   ;
logic                         	        eDRAM_12_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_12_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_12_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_12_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_12_mem_rdata ;
logic                         	        eDRAM_13_mem_req   ;
logic                         	        eDRAM_13_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_13_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_13_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_13_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_13_mem_rdata ;
logic                         	        eDRAM_14_mem_req   ;
logic                         	        eDRAM_14_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_14_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_14_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_14_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_14_mem_rdata ;
logic                         	        eDRAM_15_mem_req   ;
logic                         	        eDRAM_15_mem_we    ;
logic  [eDRAMMemAddrWidth-1:0]   	    eDRAM_15_mem_addr  ;
logic  [eDRAMMemDataWidth/8-1:0] 	    eDRAM_15_mem_be    ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_15_mem_wdata ;
logic  [eDRAMMemDataWidth-1:0]   	    eDRAM_15_mem_rdata ;


(* DONT_TOUCH = "TRUE" *)  CIM_Core_AXI_intf #(
    .AXI_ADDR_WIDTH         (   AxiAddrWidth       ),
    .AXI_DATA_WIDTH         (   AxiDataWidth       ),
    .AXI_MST_ID_WIDTH       (   AxiMusterIdWidth   ),
    .AXI_SLV_ID_WIDTH       (   AxiSlaverIdWidth   ),
    .AXI_USER_WIDTH         (   AxiUserWidth       ),
    .REG_BUS_ADDR_WIDTH     (   RegBusAddrWidth    ),
    .REG_BUS_DATA_WIDTH     (   RegBusDataWidth    ),
    .SRAM_MEM_ADDR_WIDTH    (   SramMemAddrWidth   ),
    .SRAM_MEM_DATA_WIDTH    (   SramMemDataWidth   ),
    .MACRO_MEM_ADDR_WIDTH   (   MacroMemAddrWidth  ),
    .MACRO_MEM_DATA_WIDTH   (   MacroMemDataWidth  ),
    // .MACRO_CAL_ADDR_WIDTH   (   MacroCalAddrWidth  ),
    // .MACRO_CAL_DATA_WIDTH   (   MacroCalDataWidth  ),
    .eDRAM_MEM_ADDR_WIDTH   (   eDRAMMemAddrWidth  ),
    .eDRAM_MEM_DATA_WIDTH   (   eDRAMMemDataWidth  ),
    .NoRules                (   NoRules            ),
    .IdxWidth               (   IdxWidth           ),
    .rule_t                 (   rule_t             ),
    .axi_req_t              (   axi_req_t          ),
    .axi_rsp_t              (   axi_rsp_t          )
    // .CIM_Core_reg_req_t     (   CIM_Core_reg_req_t ),
    // .CIM_Core_reg_rsp_t     (   CIM_Core_reg_rsp_t )
) i_CIM_Core_AXI_intf (
    .clk_i                          (clk_i),
    .rst_ni                         (rst_ni),
    .CIM_Core_regbus                (CIM_Core_regbus),
    .CIM_Core_sram                  (CIM_Core_sram  ),
    .CIM_Core_macro                 (CIM_Core_macro ),
    .CIM_Core_eDRAM                 (CIM_Core_eDRAM ),
    .csr_CIM_Core_mem_mux_i         (csr_CIM_Core_mem_mux),
    .reg_bus_CIM_Core_o             (reg_bus_CIM_Core),
    // .CIM_Core_reg_req_o             (CIM_Core_reg_req),
    // .CIM_Core_reg_rsp_i             (CIM_Core_reg_resp),  
    .CIM_Core_ctrl_SRAM_mem_req_i       (CIM_Core_ctrl_SRAM_mem_req  ),
    .CIM_Core_ctrl_SRAM_mem_we_i        (CIM_Core_ctrl_SRAM_mem_we   ),
    .CIM_Core_ctrl_SRAM_mem_addr_i      (CIM_Core_ctrl_SRAM_mem_addr ),
    .CIM_Core_ctrl_SRAM_mem_be_i        (CIM_Core_ctrl_SRAM_mem_be   ),
    .CIM_Core_ctrl_SRAM_mem_wdata_i     (CIM_Core_ctrl_SRAM_mem_wdata),
    .CIM_Core_ctrl_SRAM_mem_rdata_o     (CIM_Core_ctrl_SRAM_mem_rdata),
    .sram_mem_req_o                 (sram_mem_req               ),
    .sram_mem_we_o                  (sram_mem_we                ),
    .sram_mem_addr_o                (sram_mem_addr              ),
    .sram_mem_be_o                  (sram_mem_be                ),
    .sram_mem_data_o                (sram_mem_wdata              ),
    .sram_mem_data_i                (sram_mem_rdata              ),
    .CIM_Core_ctrl_macro_mem_req_i      (CIM_Core_ctrl_macro_mem_req    ),
    .CIM_Core_ctrl_macro_mem_we_i       (CIM_Core_ctrl_macro_mem_we     ),
    .CIM_Core_ctrl_macro_mem_addr_i     (CIM_Core_ctrl_macro_mem_addr   ),
    .CIM_Core_ctrl_macro_mem_be_i       (CIM_Core_ctrl_macro_mem_be     ),
    .CIM_Core_ctrl_macro_mem_wdata_i    (CIM_Core_ctrl_macro_mem_wdata  ),
    .CIM_Core_ctrl_macro_mem_rdata_o    (CIM_Core_ctrl_macro_mem_rdata  ),
    .macro_0_mem_req_o              (macro_0_mem_req        ),
    .macro_0_mem_we_o               (macro_0_mem_we         ),
    .macro_0_mem_addr_o             (macro_0_mem_addr       ),
    .macro_0_mem_be_o               (macro_0_mem_be         ),
    .macro_0_mem_data_o             (macro_0_mem_wdata       ),
    .macro_0_mem_data_i             (macro_0_mem_rdata       ),
    .macro_1_mem_req_o              (macro_1_mem_req        ),
    .macro_1_mem_we_o               (macro_1_mem_we         ),
    .macro_1_mem_addr_o             (macro_1_mem_addr       ),
    .macro_1_mem_be_o               (macro_1_mem_be         ),
    .macro_1_mem_data_o             (macro_1_mem_wdata       ),
    .macro_1_mem_data_i             (macro_1_mem_rdata       ),
    .macro_2_mem_req_o              (macro_2_mem_req        ),
    .macro_2_mem_we_o               (macro_2_mem_we         ),
    .macro_2_mem_addr_o             (macro_2_mem_addr       ),
    .macro_2_mem_be_o               (macro_2_mem_be         ),
    .macro_2_mem_data_o             (macro_2_mem_wdata       ),
    .macro_2_mem_data_i             (macro_2_mem_rdata       ),
    .macro_3_mem_req_o              (macro_3_mem_req        ),
    .macro_3_mem_we_o               (macro_3_mem_we         ),
    .macro_3_mem_addr_o             (macro_3_mem_addr       ),
    .macro_3_mem_be_o               (macro_3_mem_be         ),
    .macro_3_mem_data_o             (macro_3_mem_wdata       ),
    .macro_3_mem_data_i             (macro_3_mem_rdata       ),
    .macro_4_mem_req_o              (macro_4_mem_req        ),
    .macro_4_mem_we_o               (macro_4_mem_we         ),
    .macro_4_mem_addr_o             (macro_4_mem_addr       ),
    .macro_4_mem_be_o               (macro_4_mem_be         ),
    .macro_4_mem_data_o             (macro_4_mem_wdata       ),
    .macro_4_mem_data_i             (macro_4_mem_rdata       ),
    .macro_5_mem_req_o              (macro_5_mem_req        ),
    .macro_5_mem_we_o               (macro_5_mem_we         ),
    .macro_5_mem_addr_o             (macro_5_mem_addr       ),
    .macro_5_mem_be_o               (macro_5_mem_be         ),
    .macro_5_mem_data_o             (macro_5_mem_wdata       ),
    .macro_5_mem_data_i             (macro_5_mem_rdata       ),
    .macro_6_mem_req_o              (macro_6_mem_req        ),
    .macro_6_mem_we_o               (macro_6_mem_we         ),
    .macro_6_mem_addr_o             (macro_6_mem_addr       ),
    .macro_6_mem_be_o               (macro_6_mem_be         ),
    .macro_6_mem_data_o             (macro_6_mem_wdata       ),
    .macro_6_mem_data_i             (macro_6_mem_rdata       ),
    .macro_7_mem_req_o              (macro_7_mem_req        ),
    .macro_7_mem_we_o               (macro_7_mem_we         ),
    .macro_7_mem_addr_o             (macro_7_mem_addr       ),
    .macro_7_mem_be_o               (macro_7_mem_be         ),
    .macro_7_mem_data_o             (macro_7_mem_wdata       ),
    .macro_7_mem_data_i             (macro_7_mem_rdata       ),
    .macro_8_mem_req_o              (macro_8_mem_req        ),
    .macro_8_mem_we_o               (macro_8_mem_we         ),
    .macro_8_mem_addr_o             (macro_8_mem_addr       ),
    .macro_8_mem_be_o               (macro_8_mem_be         ),
    .macro_8_mem_data_o             (macro_8_mem_wdata       ),
    .macro_8_mem_data_i             (macro_8_mem_rdata       ),
    .CIM_Core_ctrl_eDRAM_mem_req_i      (CIM_Core_ctrl_eDRAM_mem_req    ),
    .CIM_Core_ctrl_eDRAM_mem_we_i       (CIM_Core_ctrl_eDRAM_mem_we     ),
    .CIM_Core_ctrl_eDRAM_mem_addr_i     (CIM_Core_ctrl_eDRAM_mem_addr   ),
    .CIM_Core_ctrl_eDRAM_mem_be_i       (CIM_Core_ctrl_eDRAM_mem_be     ),
    .CIM_Core_ctrl_eDRAM_mem_wdata_i    (CIM_Core_ctrl_eDRAM_mem_wdata  ),
    .CIM_Core_ctrl_eDRAM_mem_rdata_o    (CIM_Core_ctrl_eDRAM_mem_rdata  ),
    .eDRAM_0_mem_req_o                  (eDRAM_0_mem_req        ),
    .eDRAM_0_mem_we_o                   (eDRAM_0_mem_we         ),
    .eDRAM_0_mem_addr_o                 (eDRAM_0_mem_addr       ),
    .eDRAM_0_mem_be_o                   (eDRAM_0_mem_be         ),
    .eDRAM_0_mem_data_o                 (eDRAM_0_mem_wdata       ),
    .eDRAM_0_mem_data_i                 (eDRAM_0_mem_rdata       ),
    .eDRAM_1_mem_req_o                  (eDRAM_1_mem_req        ),
    .eDRAM_1_mem_we_o                   (eDRAM_1_mem_we         ),
    .eDRAM_1_mem_addr_o                 (eDRAM_1_mem_addr       ),
    .eDRAM_1_mem_be_o                   (eDRAM_1_mem_be         ),
    .eDRAM_1_mem_data_o                 (eDRAM_1_mem_wdata       ),
    .eDRAM_1_mem_data_i                 (eDRAM_1_mem_rdata       ),
    .eDRAM_2_mem_req_o                  (eDRAM_2_mem_req        ),
    .eDRAM_2_mem_we_o                   (eDRAM_2_mem_we         ),
    .eDRAM_2_mem_addr_o                 (eDRAM_2_mem_addr       ),
    .eDRAM_2_mem_be_o                   (eDRAM_2_mem_be         ),
    .eDRAM_2_mem_data_o                 (eDRAM_2_mem_wdata       ),
    .eDRAM_2_mem_data_i                 (eDRAM_2_mem_rdata       ),
    .eDRAM_3_mem_req_o                  (eDRAM_3_mem_req        ),
    .eDRAM_3_mem_we_o                   (eDRAM_3_mem_we         ),
    .eDRAM_3_mem_addr_o                 (eDRAM_3_mem_addr       ),
    .eDRAM_3_mem_be_o                   (eDRAM_3_mem_be         ),
    .eDRAM_3_mem_data_o                 (eDRAM_3_mem_wdata       ),
    .eDRAM_3_mem_data_i                 (eDRAM_3_mem_rdata       ),
    .eDRAM_4_mem_req_o                  (eDRAM_4_mem_req        ),
    .eDRAM_4_mem_we_o                   (eDRAM_4_mem_we         ),
    .eDRAM_4_mem_addr_o                 (eDRAM_4_mem_addr       ),
    .eDRAM_4_mem_be_o                   (eDRAM_4_mem_be         ),
    .eDRAM_4_mem_data_o                 (eDRAM_4_mem_wdata       ),
    .eDRAM_4_mem_data_i                 (eDRAM_4_mem_rdata       ),
    .eDRAM_5_mem_req_o                  (eDRAM_5_mem_req        ),
    .eDRAM_5_mem_we_o                   (eDRAM_5_mem_we         ),
    .eDRAM_5_mem_addr_o                 (eDRAM_5_mem_addr       ),
    .eDRAM_5_mem_be_o                   (eDRAM_5_mem_be         ),
    .eDRAM_5_mem_data_o                 (eDRAM_5_mem_wdata       ),
    .eDRAM_5_mem_data_i                 (eDRAM_5_mem_rdata       ),
    .eDRAM_6_mem_req_o                  (eDRAM_6_mem_req        ),
    .eDRAM_6_mem_we_o                   (eDRAM_6_mem_we         ),
    .eDRAM_6_mem_addr_o                 (eDRAM_6_mem_addr       ),
    .eDRAM_6_mem_be_o                   (eDRAM_6_mem_be         ),
    .eDRAM_6_mem_data_o                 (eDRAM_6_mem_wdata       ),
    .eDRAM_6_mem_data_i                 (eDRAM_6_mem_rdata       ),
    .eDRAM_7_mem_req_o                  (eDRAM_7_mem_req        ),
    .eDRAM_7_mem_we_o                   (eDRAM_7_mem_we         ),
    .eDRAM_7_mem_addr_o                 (eDRAM_7_mem_addr       ),
    .eDRAM_7_mem_be_o                   (eDRAM_7_mem_be         ),
    .eDRAM_7_mem_data_o                 (eDRAM_7_mem_wdata       ),
    .eDRAM_7_mem_data_i                 (eDRAM_7_mem_rdata       ),
    .eDRAM_8_mem_req_o                  (eDRAM_8_mem_req        ),
    .eDRAM_8_mem_we_o                   (eDRAM_8_mem_we         ),
    .eDRAM_8_mem_addr_o                 (eDRAM_8_mem_addr       ),
    .eDRAM_8_mem_be_o                   (eDRAM_8_mem_be         ),
    .eDRAM_8_mem_data_o                 (eDRAM_8_mem_wdata       ),
    .eDRAM_8_mem_data_i                 (eDRAM_8_mem_rdata       ),
    .eDRAM_9_mem_req_o                  (eDRAM_9_mem_req        ),
    .eDRAM_9_mem_we_o                   (eDRAM_9_mem_we         ),
    .eDRAM_9_mem_addr_o                 (eDRAM_9_mem_addr       ),
    .eDRAM_9_mem_be_o                   (eDRAM_9_mem_be         ),
    .eDRAM_9_mem_data_o                 (eDRAM_9_mem_wdata       ),
    .eDRAM_9_mem_data_i                 (eDRAM_9_mem_rdata       ),
    .eDRAM_10_mem_req_o                 (eDRAM_10_mem_req        ),
    .eDRAM_10_mem_we_o                  (eDRAM_10_mem_we         ),
    .eDRAM_10_mem_addr_o                (eDRAM_10_mem_addr       ),
    .eDRAM_10_mem_be_o                  (eDRAM_10_mem_be         ),
    .eDRAM_10_mem_data_o                (eDRAM_10_mem_wdata       ),
    .eDRAM_10_mem_data_i                (eDRAM_10_mem_rdata       ),
    .eDRAM_11_mem_req_o                 (eDRAM_11_mem_req        ),
    .eDRAM_11_mem_we_o                  (eDRAM_11_mem_we         ),
    .eDRAM_11_mem_addr_o                (eDRAM_11_mem_addr       ),
    .eDRAM_11_mem_be_o                  (eDRAM_11_mem_be         ),
    .eDRAM_11_mem_data_o                (eDRAM_11_mem_wdata       ),
    .eDRAM_11_mem_data_i                (eDRAM_11_mem_rdata       ),
    .eDRAM_12_mem_req_o                 (eDRAM_12_mem_req        ),
    .eDRAM_12_mem_we_o                  (eDRAM_12_mem_we         ),
    .eDRAM_12_mem_addr_o                (eDRAM_12_mem_addr       ),
    .eDRAM_12_mem_be_o                  (eDRAM_12_mem_be         ),
    .eDRAM_12_mem_data_o                (eDRAM_12_mem_wdata       ),
    .eDRAM_12_mem_data_i                (eDRAM_12_mem_rdata       ),
    .eDRAM_13_mem_req_o                 (eDRAM_13_mem_req        ),
    .eDRAM_13_mem_we_o                  (eDRAM_13_mem_we         ),
    .eDRAM_13_mem_addr_o                (eDRAM_13_mem_addr       ),
    .eDRAM_13_mem_be_o                  (eDRAM_13_mem_be         ),
    .eDRAM_13_mem_data_o                (eDRAM_13_mem_wdata       ),
    .eDRAM_13_mem_data_i                (eDRAM_13_mem_rdata       ),
    .eDRAM_14_mem_req_o                 (eDRAM_14_mem_req        ),
    .eDRAM_14_mem_we_o                  (eDRAM_14_mem_we         ),
    .eDRAM_14_mem_addr_o                (eDRAM_14_mem_addr       ),
    .eDRAM_14_mem_be_o                  (eDRAM_14_mem_be         ),
    .eDRAM_14_mem_data_o                (eDRAM_14_mem_wdata       ),
    .eDRAM_14_mem_data_i                (eDRAM_14_mem_rdata       ),
    .eDRAM_15_mem_req_o                 (eDRAM_15_mem_req        ),
    .eDRAM_15_mem_we_o                  (eDRAM_15_mem_we         ),
    .eDRAM_15_mem_addr_o                (eDRAM_15_mem_addr       ),
    .eDRAM_15_mem_be_o                  (eDRAM_15_mem_be         ),
    .eDRAM_15_mem_data_o                (eDRAM_15_mem_wdata       ),
    .eDRAM_15_mem_data_i                (eDRAM_15_mem_rdata       )
);




(* DONT_TOUCH = "TRUE" *)  CIM_ctrl_logic_wrapper #(
    .REG_BUS_ADDR_WIDTH         (   RegBusAddrWidth     ),
    .REG_BUS_DATA_WIDTH         (   RegBusDataWidth     ),
    .SRAM_MEM_ADDR_WIDTH	    (   SramMemAddrWidth    ),
    .SRAM_MEM_DATA_WIDTH	    (   SramMemDataWidth    ),
    .MACRO_MEM_ADDR_WIDTH       (   MacroMemAddrWidth   ),
    .MACRO_MEM_DATA_WIDTH       (   MacroMemDataWidth   ),
    .MACRO_CAL_ADDR_WIDTH       (   MacroCalAddrWidth   ),
    .MACRO_CAL_DATA_WIDTH       (   MacroCalDataWidth   ),
    .eDRAM_MEM_ADDR_WIDTH       (   eDRAMMemAddrWidth  ),
    .eDRAM_MEM_DATA_WIDTH       (   eDRAMMemDataWidth  )
    // .CIM_Core_reg_req_t         (   CIM_Core_reg_req_t  ),
    // .CIM_Core_reg_rsp_t         (   CIM_Core_reg_rsp_t  )
) i_CIM_ctrl_logic_wrapper (
    .clk_i                              (   clk_i           ),
    .rst_ni                             (   rst_ni          ),
    .testmode_i                         (   testmode_i      ),
    .reg_bus_i                          (reg_bus_CIM_Core),

    .csr_CIM_Core_mem_mux_q             (csr_CIM_Core_mem_mux ),
    .test_2_q                           (test_2_q               ),
    .test_3_q                           (test_3_q               ),
    .test_4_q                           (test_4_q               ),
    // .req_i                              (   CIM_Core_reg_req            ),
    // .resp_o                             (   CIM_Core_reg_resp           ),
    // .csr_CIM_Core_mem_mux_o             (   csr_CIM_Core_mem_mux        ),
    .CIM_Core_ctrl_SRAM_mem_req_o       (   CIM_Core_ctrl_SRAM_mem_req      ),
    .CIM_Core_ctrl_SRAM_mem_we_o        (   CIM_Core_ctrl_SRAM_mem_we       ),
    .CIM_Core_ctrl_SRAM_mem_addr_o      (   CIM_Core_ctrl_SRAM_mem_addr     ),
    .CIM_Core_ctrl_SRAM_mem_be_o        (   CIM_Core_ctrl_SRAM_mem_be       ),
    .CIM_Core_ctrl_SRAM_mem_wdata_o     (   CIM_Core_ctrl_SRAM_mem_wdata    ),
    .CIM_Core_ctrl_SRAM_mem_rdata_i     (   CIM_Core_ctrl_SRAM_mem_rdata    ),
    .CIM_Core_ctrl_macro_mem_req_o      (   CIM_Core_ctrl_macro_mem_req     ),
    .CIM_Core_ctrl_macro_mem_we_o       (   CIM_Core_ctrl_macro_mem_we      ),
    .CIM_Core_ctrl_macro_mem_addr_o     (   CIM_Core_ctrl_macro_mem_addr    ),
    .CIM_Core_ctrl_macro_mem_be_o       (   CIM_Core_ctrl_macro_mem_be      ),
    .CIM_Core_ctrl_macro_mem_wdata_o    (   CIM_Core_ctrl_macro_mem_wdata   ),
    .CIM_Core_ctrl_macro_mem_rdata_i    (   CIM_Core_ctrl_macro_mem_rdata   ),
    .CIM_Core_ctrl_macro_cal_req_o      (   CIM_Core_ctrl_macro_cal_req     ),
    .CIM_Core_ctrl_macro_cal_data_o     (   CIM_Core_ctrl_macro_cal_data    ),
    .CIM_Core_ctrl_macro_cal_result_i   (   CIM_Core_ctrl_macro_cal_result  ),
    .CIM_Core_ctrl_eDRAM_mem_req_o      (   CIM_Core_ctrl_eDRAM_mem_req     ),
    .CIM_Core_ctrl_eDRAM_mem_we_o       (   CIM_Core_ctrl_eDRAM_mem_we      ),
    .CIM_Core_ctrl_eDRAM_mem_addr_o     (   CIM_Core_ctrl_eDRAM_mem_addr    ),
    .CIM_Core_ctrl_eDRAM_mem_be_o       (   CIM_Core_ctrl_eDRAM_mem_be      ),
    .CIM_Core_ctrl_eDRAM_mem_wdata_o    (   CIM_Core_ctrl_eDRAM_mem_wdata   ),
    .CIM_Core_ctrl_eDRAM_mem_rdata_i    (   CIM_Core_ctrl_eDRAM_mem_rdata   )
);

////////////////////////////////////
// the address need to be rewrit
////////////////////////////////////

// used as a wrapper for the CIM_Core_SRAM
xlnx_bram_1024x32 i_CIM_Core_SRAM(
                .clka       (clk_i          ),
                .ena        (sram_mem_req   ),
                .wea        ({4{sram_mem_we}} & sram_mem_be),
                .addra      (sram_mem_addr[11:2]  ),
                .dina       (sram_mem_wdata ),
                .douta      (sram_mem_rdata )
            );
// used as a wrapper for the CIM_Core_MacroMem
xlnx_bram_512x32 i_CIM_Core_Macro_0(
                .clka       (clk_i          ),
                .ena        (macro_0_mem_req   ),
                .wea        ({4{macro_0_mem_we}} & macro_0_mem_be),
                .addra      (macro_0_mem_addr[10:2]  ),
                .dina       (macro_0_mem_wdata ),
                .douta      (macro_0_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_1(
                .clka       (clk_i          ),
                .ena        (macro_1_mem_req   ),
                .wea        ({4{macro_1_mem_we}} & macro_1_mem_be),
                .addra      (macro_1_mem_addr[10:2]  ),
                .dina       (macro_1_mem_wdata ),
                .douta      (macro_1_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_2(
                .clka       (clk_i          ),
                .ena        (macro_2_mem_req   ),
                .wea        ({4{macro_2_mem_we}} & macro_2_mem_be),
                .addra      (macro_2_mem_addr[10:2]  ),
                .dina       (macro_2_mem_wdata ),
                .douta      (macro_2_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_3(
                .clka       (clk_i          ),
                .ena        (macro_3_mem_req   ),
                .wea        ({4{macro_3_mem_we}} & macro_3_mem_be),
                .addra      (macro_3_mem_addr[10:2]  ),
                .dina       (macro_3_mem_wdata ),
                .douta      (macro_3_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_4(
                .clka       (clk_i          ),
                .ena        (macro_4_mem_req   ),
                .wea        ({4{macro_4_mem_we}} & macro_4_mem_be),
                .addra      (macro_4_mem_addr[10:2]  ),
                .dina       (macro_4_mem_wdata ),
                .douta      (macro_4_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_5(
                .clka       (clk_i          ),
                .ena        (macro_5_mem_req   ),
                .wea        ({4{macro_5_mem_we}} & macro_5_mem_be),
                .addra      (macro_5_mem_addr[10:2]  ),
                .dina       (macro_5_mem_wdata ),
                .douta      (macro_5_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_6(
                .clka       (clk_i          ),
                .ena        (macro_6_mem_req   ),
                .wea        ({4{macro_6_mem_we}} & macro_6_mem_be),
                .addra      (macro_6_mem_addr[10:2]  ),
                .dina       (macro_6_mem_wdata ),
                .douta      (macro_6_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_7(
                .clka       (clk_i          ),
                .ena        (macro_7_mem_req   ),
                .wea        ({4{macro_7_mem_we}} & macro_7_mem_be),
                .addra      (macro_7_mem_addr[10:2]  ),
                .dina       (macro_7_mem_wdata ),
                .douta      (macro_7_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_Macro_8(
                .clka       (clk_i          ),
                .ena        (macro_8_mem_req   ),
                .wea        ({4{macro_8_mem_we}} & macro_8_mem_be),
                .addra      (macro_8_mem_addr[10:2]  ),
                .dina       (macro_8_mem_wdata ),
                .douta      (macro_8_mem_rdata )
            );

// eDRAM
xlnx_bram_512x32 i_CIM_Core_eDRAM_0(
                .clka       (clk_i          ),
                .ena        (eDRAM_0_mem_req   ),
                .wea        ({4{eDRAM_0_mem_we}} & eDRAM_0_mem_be),
                .addra      (eDRAM_0_mem_addr[10:2]  ),
                .dina       (eDRAM_0_mem_wdata ),
                .douta      (eDRAM_0_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_1(
                .clka       (clk_i          ),
                .ena        (eDRAM_1_mem_req   ),
                .wea        ({4{eDRAM_1_mem_we}} & eDRAM_1_mem_be),
                .addra      (eDRAM_1_mem_addr[10:2]  ),
                .dina       (eDRAM_1_mem_wdata ),
                .douta      (eDRAM_1_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_2(
                .clka       (clk_i          ),
                .ena        (eDRAM_2_mem_req   ),
                .wea        ({4{eDRAM_2_mem_we}} & eDRAM_2_mem_be),
                .addra      (eDRAM_2_mem_addr[10:2]  ),
                .dina       (eDRAM_2_mem_wdata ),
                .douta      (eDRAM_2_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_3(
                .clka       (clk_i          ),
                .ena        (eDRAM_3_mem_req   ),
                .wea        ({4{eDRAM_3_mem_we}} & eDRAM_3_mem_be),
                .addra      (eDRAM_3_mem_addr[10:2]  ),
                .dina       (eDRAM_3_mem_wdata ),
                .douta      (eDRAM_3_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_4(
                .clka       (clk_i          ),
                .ena        (eDRAM_4_mem_req   ),
                .wea        ({4{eDRAM_4_mem_we}} & eDRAM_4_mem_be),
                .addra      (eDRAM_4_mem_addr[10:2]  ),
                .dina       (eDRAM_4_mem_wdata ),
                .douta      (eDRAM_4_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_5(
                .clka       (clk_i          ),
                .ena        (eDRAM_5_mem_req   ),
                .wea        ({4{eDRAM_5_mem_we}} & eDRAM_5_mem_be),
                .addra      (eDRAM_5_mem_addr[10:2]  ),
                .dina       (eDRAM_5_mem_wdata ),
                .douta      (eDRAM_5_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_6(
                .clka       (clk_i          ),
                .ena        (eDRAM_6_mem_req   ),
                .wea        ({4{eDRAM_6_mem_we}} & eDRAM_6_mem_be),
                .addra      (eDRAM_6_mem_addr[10:2]  ),
                .dina       (eDRAM_6_mem_wdata ),
                .douta      (eDRAM_6_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_7(
                .clka       (clk_i          ),
                .ena        (eDRAM_7_mem_req   ),
                .wea        ({4{eDRAM_7_mem_we}} & eDRAM_7_mem_be),
                .addra      (eDRAM_7_mem_addr[10:2]  ),
                .dina       (eDRAM_7_mem_wdata ),
                .douta      (eDRAM_7_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_8(
                .clka       (clk_i          ),
                .ena        (eDRAM_8_mem_req   ),
                .wea        ({4{eDRAM_8_mem_we}} & eDRAM_8_mem_be),
                .addra      (eDRAM_8_mem_addr[10:2]  ),
                .dina       (eDRAM_8_mem_wdata ),
                .douta      (eDRAM_8_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_9(
                .clka       (clk_i          ),
                .ena        (eDRAM_9_mem_req   ),
                .wea        ({4{eDRAM_9_mem_we}} & eDRAM_9_mem_be),
                .addra      (eDRAM_9_mem_addr[10:2]  ),
                .dina       (eDRAM_9_mem_wdata ),
                .douta      (eDRAM_9_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_10(
                .clka       (clk_i          ),
                .ena        (eDRAM_10_mem_req   ),
                .wea        ({4{eDRAM_10_mem_we}} & eDRAM_10_mem_be),
                .addra      (eDRAM_10_mem_addr[10:2]  ),
                .dina       (eDRAM_10_mem_wdata ),
                .douta      (eDRAM_10_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_11(
                .clka       (clk_i          ),
                .ena        (eDRAM_11_mem_req   ),
                .wea        ({4{eDRAM_11_mem_we}} & eDRAM_11_mem_be),
                .addra      (eDRAM_11_mem_addr[10:2]  ),
                .dina       (eDRAM_11_mem_wdata ),
                .douta      (eDRAM_11_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_12(
                .clka       (clk_i          ),
                .ena        (eDRAM_12_mem_req   ),
                .wea        ({4{eDRAM_12_mem_we}} & eDRAM_12_mem_be),
                .addra      (eDRAM_12_mem_addr[10:2]  ),
                .dina       (eDRAM_12_mem_wdata ),
                .douta      (eDRAM_12_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_13(
                .clka       (clk_i          ),
                .ena        (eDRAM_13_mem_req   ),
                .wea        ({4{eDRAM_13_mem_we}} & eDRAM_13_mem_be),
                .addra      (eDRAM_13_mem_addr[10:2]  ),
                .dina       (eDRAM_13_mem_wdata ),
                .douta      (eDRAM_13_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_14(
                .clka       (clk_i          ),
                .ena        (eDRAM_14_mem_req   ),
                .wea        ({4{eDRAM_14_mem_we}} & eDRAM_14_mem_be),
                .addra      (eDRAM_14_mem_addr[10:2]  ),
                .dina       (eDRAM_14_mem_wdata ),
                .douta      (eDRAM_14_mem_rdata )
            );
xlnx_bram_512x32 i_CIM_Core_eDRAM_15(
                .clka       (clk_i          ),
                .ena        (eDRAM_15_mem_req   ),
                .wea        ({4{eDRAM_15_mem_we}} & eDRAM_15_mem_be),
                .addra      (eDRAM_15_mem_addr[10:2]  ),
                .dina       (eDRAM_15_mem_wdata ),
                .douta      (eDRAM_15_mem_rdata )
            );
endmodule
