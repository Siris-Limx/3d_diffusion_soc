`include "register_interface/assign.svh"
`include "register_interface/typedef.svh"
`include "axi/assign.svh"
`include "axi/typedef.svh"

module CIM_Core_AXI_intf #(
    parameter int   AXI_ADDR_WIDTH          = -1,
    parameter int   AXI_DATA_WIDTH          = -1,
    parameter int   AXI_MST_ID_WIDTH        = -1,
    parameter int   AXI_SLV_ID_WIDTH        = -1,
    parameter int   AXI_USER_WIDTH          = -1,
    parameter int   REG_BUS_ADDR_WIDTH          = -1,
    parameter int   REG_BUS_DATA_WIDTH          = -1,
    parameter int   SRAM_MEM_ADDR_WIDTH	            = -1,
	parameter int   SRAM_MEM_DATA_WIDTH	            = -1,
    parameter int   MACRO_MEM_ADDR_WIDTH	        = -1,
	parameter int   MACRO_MEM_DATA_WIDTH	        = -1,
    parameter int   eDRAM_MEM_ADDR_WIDTH	        = -1,
    parameter int   eDRAM_MEM_DATA_WIDTH	        = -1,

    parameter   int unsigned    NoRules             = 32'd0,
    parameter   int unsigned    IdxWidth            = 4,

    parameter   type  rule_t                  = axi_pkg::xbar_rule_64_t,
    parameter   type  axi_req_t               = logic,
    parameter   type  axi_rsp_t               = logic
    // parameter   type  CIM_Core_reg_req_t      = logic,
    // parameter   type  CIM_Core_reg_rsp_t      = logic
    
)  (
    input   logic                           clk_i,
    input   logic                           rst_ni,
    // AXI bus interface
    AXI_BUS.Slave                           CIM_Core_regbus,
    AXI_BUS.Slave                           CIM_Core_sram,
    AXI_BUS.Slave                           CIM_Core_macro,
    AXI_BUS.Slave                           CIM_Core_eDRAM,
    // csr interface
    input  logic 							csr_CIM_Core_mem_mux_i,
    // reg_bus interface //////////REG_BUS/////////////
    REG_BUS.out                             reg_bus_CIM_Core_o,
    // output  CIM_Core_reg_req_t              CIM_Core_reg_req_o,
    // input   CIM_Core_reg_rsp_t              CIM_Core_reg_rsp_i,
    // macro input ctrl interface //////////SRAM/////////////
    input  logic 	                       	    CIM_Core_ctrl_SRAM_mem_req_i,
    input  logic 	                       	    CIM_Core_ctrl_SRAM_mem_we_i,
    input  logic 	[SRAM_MEM_ADDR_WIDTH-1:0]   CIM_Core_ctrl_SRAM_mem_addr_i,
    input  logic 	[SRAM_MEM_DATA_WIDTH/8-1:0] CIM_Core_ctrl_SRAM_mem_be_i,
    input  logic 	[SRAM_MEM_DATA_WIDTH-1:0]   CIM_Core_ctrl_SRAM_mem_wdata_i,
    output logic 	[SRAM_MEM_DATA_WIDTH-1:0]   CIM_Core_ctrl_SRAM_mem_rdata_o,
    // macro output ctrl interface //////////SRAM/////////////
    output  logic                         	    sram_mem_req_o,
    output  logic                         	    sram_mem_we_o,
    output  logic  [SRAM_MEM_ADDR_WIDTH-1:0]   	sram_mem_addr_o,
    output  logic  [SRAM_MEM_DATA_WIDTH/8-1:0] 	sram_mem_be_o,
    output  logic  [SRAM_MEM_DATA_WIDTH-1:0]   	sram_mem_data_o,
    input   logic  [SRAM_MEM_DATA_WIDTH-1:0]   	sram_mem_data_i,

    // macro input ctrl interface //////////macro/////////////
    input  logic 							        CIM_Core_ctrl_macro_mem_req_i,
    input  logic 							        CIM_Core_ctrl_macro_mem_we_i,
    input  logic 	[MACRO_MEM_ADDR_WIDTH-1:0]	    CIM_Core_ctrl_macro_mem_addr_i,
    input  logic 	[MACRO_MEM_DATA_WIDTH/8-1:0]	CIM_Core_ctrl_macro_mem_be_i,
    input  logic 	[MACRO_MEM_DATA_WIDTH-1:0]	    CIM_Core_ctrl_macro_mem_wdata_i,
    output logic 	[MACRO_MEM_DATA_WIDTH-1:0]	    CIM_Core_ctrl_macro_mem_rdata_o,
    // macro output ctrl interface //////////macro_0/////////////
    output  logic                         	        macro_0_mem_req_o,
    output  logic                         	        macro_0_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]   	macro_0_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0] 	macro_0_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]   	macro_0_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]   	macro_0_mem_data_i,
    // macro output ctrl interface //////////macro_1/////////////
    output  logic                         	    	macro_1_mem_req_o,
    output  logic                         	    	macro_1_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]   	macro_1_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0] 	macro_1_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]   	macro_1_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]   	macro_1_mem_data_i,
    // macro output ctrl interface //////////macro_2/////////////
    output  logic                         	    	macro_2_mem_req_o,
    output  logic                         	    	macro_2_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]   	macro_2_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0] 	macro_2_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]   	macro_2_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]   	macro_2_mem_data_i,
    // macro output ctrl interface //////////macro_3/////////////
    output  logic                         	        macro_3_mem_req_o,
    output  logic                         	        macro_3_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]       macro_3_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0]     macro_3_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_3_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_3_mem_data_i,
    // macro output ctrl interface //////////macro_4/////////////
    output  logic                         	        macro_4_mem_req_o,
    output  logic                         	        macro_4_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]       macro_4_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0]     macro_4_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_4_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_4_mem_data_i,
    // macro output ctrl interface //////////macro_5/////////////
    output  logic                         	        macro_5_mem_req_o,
    output  logic                         	        macro_5_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]       macro_5_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0]     macro_5_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_5_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_5_mem_data_i,
    // macro output ctrl interface //////////macro_6/////////////
    output  logic                         	        macro_6_mem_req_o,
    output  logic                         	        macro_6_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]       macro_6_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0]     macro_6_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_6_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_6_mem_data_i,
    // macro output ctrl interface //////////macro_7/////////////
    output  logic                         	        macro_7_mem_req_o,
    output  logic                         	        macro_7_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]       macro_7_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0]     macro_7_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_7_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_7_mem_data_i,
    // macro output ctrl interface //////////macro_8/////////////
    output  logic                         	        macro_8_mem_req_o,
    output  logic                         	        macro_8_mem_we_o,
    output  logic  [MACRO_MEM_ADDR_WIDTH-1:0]       macro_8_mem_addr_o,
    output  logic  [MACRO_MEM_DATA_WIDTH/8-1:0]     macro_8_mem_be_o,
    output  logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_8_mem_data_o,
    input   logic  [MACRO_MEM_DATA_WIDTH-1:0]       macro_8_mem_data_i,
        // eDRAM input ctrl interface //////////eDRAM/////////////
    input  logic 							        CIM_Core_ctrl_eDRAM_mem_req_i,
    input  logic 							        CIM_Core_ctrl_eDRAM_mem_we_i,
    input  logic 	[eDRAM_MEM_ADDR_WIDTH-1:0]	    CIM_Core_ctrl_eDRAM_mem_addr_i,
    input  logic 	[eDRAM_MEM_DATA_WIDTH/8-1:0]	CIM_Core_ctrl_eDRAM_mem_be_i,
    input  logic 	[eDRAM_MEM_DATA_WIDTH-1:0]	    CIM_Core_ctrl_eDRAM_mem_wdata_i,
    output logic 	[eDRAM_MEM_DATA_WIDTH-1:0]	    CIM_Core_ctrl_eDRAM_mem_rdata_o,
    // eDRAM output ctrl interface //////////eDRAM_0/////////////
    output  logic                         	        eDRAM_0_mem_req_o,
    output  logic                         	        eDRAM_0_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	eDRAM_0_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	eDRAM_0_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_0_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_0_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_1/////////////
    output  logic                         	    	eDRAM_1_mem_req_o,
    output  logic                         	    	eDRAM_1_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	eDRAM_1_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	eDRAM_1_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_1_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_1_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_2/////////////
    output  logic                         	    	eDRAM_2_mem_req_o,
    output  logic                         	    	eDRAM_2_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	eDRAM_2_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	eDRAM_2_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_2_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_2_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_3/////////////
    output  logic                         	        eDRAM_3_mem_req_o,
    output  logic                         	        eDRAM_3_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_3_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_3_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_3_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_3_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_4/////////////
    output  logic                         	        eDRAM_4_mem_req_o,
    output  logic                         	        eDRAM_4_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_4_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_4_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_4_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_4_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_5/////////////
    output  logic                         	        eDRAM_5_mem_req_o,
    output  logic                         	        eDRAM_5_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_5_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_5_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_5_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_5_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_6/////////////
    output  logic                         	        eDRAM_6_mem_req_o,
    output  logic                         	        eDRAM_6_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_6_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_6_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_6_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_6_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_7/////////////
    output  logic                         	        eDRAM_7_mem_req_o,
    output  logic                         	        eDRAM_7_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_7_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_7_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_7_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_7_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_8/////////////
    output  logic                         	        eDRAM_8_mem_req_o,
    output  logic                         	        eDRAM_8_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_8_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_8_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_8_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_8_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_9/////////////
    output  logic                         	        eDRAM_9_mem_req_o,
    output  logic                         	        eDRAM_9_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_9_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_9_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_9_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_9_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_10/////////////
    output  logic                         	        eDRAM_10_mem_req_o,
    output  logic                         	        eDRAM_10_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	eDRAM_10_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	eDRAM_10_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_10_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_10_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_11/////////////
    output  logic                         	    	eDRAM_11_mem_req_o,
    output  logic                         	    	eDRAM_11_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	eDRAM_11_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	eDRAM_11_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_11_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_11_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_12/////////////
    output  logic                         	    	eDRAM_12_mem_req_o,
    output  logic                         	    	eDRAM_12_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]   	eDRAM_12_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0] 	eDRAM_12_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_12_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]   	eDRAM_12_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_13/////////////
    output  logic                         	        eDRAM_13_mem_req_o,
    output  logic                         	        eDRAM_13_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_13_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_13_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_13_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_13_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_14/////////////
    output  logic                         	        eDRAM_14_mem_req_o,
    output  logic                         	        eDRAM_14_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_14_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_14_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_14_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_14_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_15/////////////
    output  logic                         	        eDRAM_15_mem_req_o,
    output  logic                         	        eDRAM_15_mem_we_o,
    output  logic  [eDRAM_MEM_ADDR_WIDTH-1:0]       eDRAM_15_mem_addr_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH/8-1:0]     eDRAM_15_mem_be_o,
    output  logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_15_mem_data_o,
    input   logic  [eDRAM_MEM_DATA_WIDTH-1:0]       eDRAM_15_mem_data_i
);

// only one master port in this subsystem —— the CIM_Core
// AXI_BUS #(
//     .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
//     .AXI_DATA_WIDTH ( AxiDataWidth     ),
//     .AXI_ID_WIDTH   ( AxiIdWidthMaster ),
//     .AXI_USER_WIDTH ( AxiUserWidth     )
// ) slave[NBSlave-1:0]();

// RegFile, SRAM, Macro
// (* DONT_TOUCH = "TRUE" *)  AXI_BUS #(
//     .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
//     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH     ),
//     .AXI_ID_WIDTH   ( AXI_MST_ID_WIDTH       ),
//     .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
// ) cim_master[CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS-1:0]();

// axi_pkg::xbar_rule_64_t [CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS-1:0] CIM_Core_addr_map_i;

// assign CIM_Core_addr_map_i = '{
//     '{ idx: CIM_Core_addr_map::Reg_file, start_addr: CIM_Core_addr_map::Reg_fileBase, end_addr: CIM_Core_addr_map::Reg_fileBase + CIM_Core_addr_map::Reg_fileLength },
//     '{ idx: CIM_Core_addr_map::SRAM,     start_addr: CIM_Core_addr_map::SRAMBase,     end_addr: CIM_Core_addr_map::SRAMBase     + CIM_Core_addr_map::SRAMLength     },
//     '{ idx: CIM_Core_addr_map::Macro,    start_addr: CIM_Core_addr_map::MacroBase,    end_addr: CIM_Core_addr_map::MacroBase    + CIM_Core_addr_map::MacroLength    },
//     '{ idx: CIM_Core_addr_map::eDRAM,    start_addr: CIM_Core_addr_map::eDRAMBase,    end_addr: CIM_Core_addr_map::eDRAMBase    + CIM_Core_addr_map::eDRAMLength    }
// };

// localparam  IdxWdith = (CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS > 32'd1) ? $clog2(CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS) : 32'd1;
// logic   [IdxWdith-1:0]              idx_aw;
// logic                               dec_valid_aw;

// CIM_Core_addr_decode #(
//     .NoRules                (32'd9                ),
//     .AXI_ADDR_WIDTH         (AXI_ADDR_WIDTH       ),
//     .rule_t                 (rule_t               ),
//     .IdxWidth               (IdxWdith             )
// ) i_CIM_Core_addr_decode_aw (
//     .addr_i         (CIM_Core.aw_addr    ),
//     .addr_map_i     (CIM_Core_addr_map      ),
//     .idx_o          (idx_aw                  ),
//     .dec_valid_o    (dec_valid_aw            )
// );

// (* DONT_TOUCH = "TRUE" *)      addr_decode #(
//       .NoIndices  ( 32'd3  ),
//       .addr_t     ( logic [63:0]          ),
//       .NoRules    ( 32'd3 ),
//       .rule_t     ( axi_pkg::xbar_rule_64_t          )
//     ) i_CIM_Core_addr_decode_aw (
//       .addr_i           ( CIM_Core.aw_addr ),
//       .addr_map_i       ( CIM_Core_addr_map_i                 ),
//       .idx_o            ( idx_aw                     ),
//       .dec_valid_o      ( dec_valid_aw               ),
//       .dec_error_o      (                 ),
//       .en_default_idx_i (    1'b0    ),
//       .default_idx_i    (    1'b0    )
//     );

// logic   [IdxWdith-1:0]              idx_ar;
// logic                               dec_valid_ar;

// // CIM_Core_addr_decode #(
// //     .NoRules                (32'd9                ),
// //     .AXI_ADDR_WIDTH         (AXI_ADDR_WIDTH       ),
// //     .rule_t                 (rule_t               ),
// //     .IdxWidth               (IdxWdith             )
// // ) i_CIM_Core_addr_decode_ar (
// //     .addr_i         (CIM_Core.ar_addr    ),
// //     .addr_map_i     (CIM_Core_addr_map      ),
// //     .idx_o          (idx_ar                  ),
// //     .dec_valid_o    (dec_valid_ar            )
// // );

// (* DONT_TOUCH = "TRUE" *)      addr_decode #(
//       .NoIndices  ( 32'd3  ),
//       .addr_t     ( logic [31:0]          ),
//       .NoRules    ( 32'd3 ),
//       .rule_t     ( axi_pkg::xbar_rule_64_t          )
//     ) i_CIM_Core_addr_decode_ar (
//       .addr_i           ( CIM_Core.ar_addr ),
//       .addr_map_i       ( CIM_Core_addr_map_i                 ),
//       .idx_o            ( idx_ar                     ),
//       .dec_valid_o      ( dec_valid_ar               ),
//       .dec_error_o      (                 ),
//       .en_default_idx_i (   1'b0   ),
//       .default_idx_i    (   1'b0   )
//     );
// ////////////////////Need to Update/////////////////////
// localparam axi_pkg::xbar_cfg_t AXI_XBAR_CFG = '{
//   NoSlvPorts:         1,
//   NoMstPorts:         CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS,
//   MaxMstTrans:        1, // Probably requires update
//   MaxSlvTrans:        1, // Probably requires update
//   FallThrough:        1'b0,
//   LatencyMode:        axi_pkg::CUT_ALL_PORTS,
//   AxiIdWidthSlvPorts: AXI_MST_ID_WIDTH,
//   AxiIdUsedSlvPorts:  AXI_SLV_ID_WIDTH,
//   UniqueIds:          1'b0,
//   AxiAddrWidth:       AXI_ADDR_WIDTH,
//   AxiDataWidth:       AXI_DATA_WIDTH,
//   NoAddrRules:        CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS
// };

// axi_xbar_intf #(
//   .AXI_USER_WIDTH ( AXI_USER_WIDTH            ),
//   .Cfg            ( AXI_XBAR_CFG            ),
//   .rule_t         ( axi_pkg::xbar_rule_64_t )
// ) i_axi_xbar (
//   .clk_i                 ( clk_i        ),
//   .rst_ni                ( rst_ni       ),
//   .test_i                ( test_en    ),
//   .slv_ports             ( CIM_Core   ),
//   .mst_ports             ( cim_master     ),
//   .addr_map_i            ( CIM_Core_addr_map   ),
//   .en_default_mst_port_i ( '0         ),
//   .default_mst_port_i    ( '0         )
// );

    // `REG_BUS_TYPEDEF_ALL(CIM_Core_reg, logic[31:0], logic[31:0], logic[3:0])
    // CIM_Core_reg_req_t CIM_Core_reg_req;
    // CIM_Core_reg_rsp_t CIM_Core_reg_rsp;

///////////////////////////////////////////////////////////
// interface wrapper

// (* DONT_TOUCH = "TRUE" *)  axi_demux_intf #(        
//   .AXI_ID_WIDTH            (     AXI_SLV_ID_WIDTH    ),
//   .AXI_ADDR_WIDTH          (     AXI_ADDR_WIDTH      ),
//   .AXI_DATA_WIDTH          (     AXI_DATA_WIDTH      ),
//   .AXI_USER_WIDTH          (     AXI_USER_WIDTH      ),
//   .NO_MST_PORTS            (     CIM_Core_addr_map::NB_CIM_CORE_COMPONENTS      ),
//   .MAX_TRANS               (     32'd8      ),
//   .AXI_LOOK_BITS           (     32'd3      ),
//   .UNIQUE_IDS              (     1'b0       ),
//   .FALL_THROUGH            (     1'b0       ),
//   .SPILL_AW                (     1'b1       ),
//   .SPILL_W                 (     1'b0       ),
//   .SPILL_B                 (     1'b0       ),
//   .SPILL_AR                (     1'b1       ),
//   .SPILL_R                 (     1'b0       )
// //   // Dependent parameters, DO NOT OVERRIDE!
// //   parameter int unsigned SELECT_WIDTH   = (NO_MST_PORTS > 32'd1) ? $clog2(NO_MST_PORTS) : 32'd1,
// //   parameter type         select_t       = logic [SELECT_WIDTH-1:0] // MST port select type
// ) axi_demux_intf_inst(
//   .clk_i                           (    clk_i               ),
//   .rst_ni                          (    rst_ni              ),
//   .test_i                          (    test_i              ),
//   .slv_aw_select_i                 (    idx_aw     ),
//   .slv_ar_select_i                 (    idx_ar     ),
//   .slv                             (    CIM_Core       ),
//   .mst                             (    cim_master        )
// );
///////////////////////////////////////////////////////////

// (* DONT_TOUCH = "TRUE" *)  CIM_Core_reg_intf #(
//     .AXI_ADDR_WIDTH     (  AXI_ADDR_WIDTH       ),
//     .AXI_DATA_WIDTH     (  AXI_DATA_WIDTH       ),
//     .AXI_ID_WIDTH       (  AXI_SLV_ID_WIDTH     ),
//     .AXI_USER_WIDTH     (  AXI_USER_WIDTH       ),
//     .REG_BUS_ADDR_WIDTH (  REG_BUS_ADDR_WIDTH ),
//     .REG_BUS_DATA_WIDTH (  REG_BUS_DATA_WIDTH )
//     // .reg_req_t       (  CIM_Core_reg_req_t  ),
//     // .reg_rsp_t       (  CIM_Core_reg_rsp_t  )
// )  i_CIM_Core_Reg_intf(
//     // clk and reset
//     .clk_i,
//     .rst_ni,
//     // AXI bus interface
//     .CIM_Core_Reg       (CIM_Core_regbus),
//     // reg interface
//     .reg_bus_CIM_Core   (reg_bus_CIM_Core_o)
//     // .reg_req_o          (CIM_Core_reg_req_o),
//     // .reg_rsp_i          (CIM_Core_reg_rsp_i)
// );
  
  

  

axi_to_reg_intf #(
  .ADDR_WIDTH          (AXI_ADDR_WIDTH     ),
  .DATA_WIDTH          (AXI_DATA_WIDTH     ),
  .ID_WIDTH            (AXI_SLV_ID_WIDTH   ),
  .USER_WIDTH          (AXI_USER_WIDTH     )
//   parameter int unsigned AXI_MAX_WRITE_TXNS = 32'd2,
//   parameter int unsigned AXI_MAX_READ_TXNS  = 32'd2,
//   /// Whether the AXI-Lite W channel should be decoupled with a register. This
//   /// can help break long paths at the expense of registers.
//   parameter bit DECOUPLE_W = 1
)    i_CIM_Core_Reg_intf(
    .clk_i     ,
    .rst_ni    ,
    .testmode_i       (      1'b0        ),
    .in               (CIM_Core_regbus   ),
    .reg_o            (reg_bus_CIM_Core_o)
);

(* DONT_TOUCH = "TRUE" *)  AXI_BUS #(
    .AXI_ADDR_WIDTH ( SRAM_MEM_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( SRAM_MEM_DATA_WIDTH  ),
    .AXI_ID_WIDTH   ( AXI_SLV_ID_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
) cim_sram_master();

(* DONT_TOUCH = "TRUE" *) axi_dw_converter_intf #(
    .AXI_ID_WIDTH               (   AXI_SLV_ID_WIDTH          ),
    .AXI_ADDR_WIDTH             (   AXI_ADDR_WIDTH            ),
    .AXI_SLV_PORT_DATA_WIDTH    (   AXI_DATA_WIDTH   ),
    .AXI_MST_PORT_DATA_WIDTH    (   SRAM_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH             (   AXI_USER_WIDTH          )
    // .AXI_MAX_READS              (       )
) i_sram_axi_dw_converter_intf(
    .clk_i,
    .rst_ni,
    .slv               (CIM_Core_sram),
    .mst               (cim_sram_master)
);

logic 							        axi_sram_mem_req_o;
logic 							        axi_sram_mem_we_o;
logic 	[SRAM_MEM_ADDR_WIDTH-1:0]	    axi_sram_mem_addr_o;
logic 	[SRAM_MEM_DATA_WIDTH/8-1:0]	    axi_sram_mem_be_o;
logic 	[SRAM_MEM_DATA_WIDTH-1:0]	    axi_sram_mem_data_o;
logic 	[SRAM_MEM_DATA_WIDTH-1:0]	    axi_sram_mem_data_i;

(* DONT_TOUCH = "TRUE" *)  axi2mem #(
    .AXI_ID_WIDTH      ( AXI_SLV_ID_WIDTH     ),   
    .AXI_ADDR_WIDTH    ( SRAM_MEM_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH    ( SRAM_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH    ( AXI_USER_WIDTH  )
) i_sram_axi2mem(
    .clk_i,    // Clock
    .rst_ni,  // Asynchronous reset active low
    .slave              (cim_sram_master),
    .req_o              (axi_sram_mem_req_o         ),
    .we_o               (axi_sram_mem_we_o          ),
    .addr_o             (axi_sram_mem_addr_o        ),
    .be_o               (axi_sram_mem_be_o          ),
    .user_o             (       ),
    .data_o             (axi_sram_mem_data_o        ),
    .user_i             (       ),
    .data_i             (axi_sram_mem_data_i        )
);

// logic   CIM_Core_mem_mux;
////////////////////Need to Update/////////////////////
// assign  CIM_Core_mem_mux = 1'b0;

(* DONT_TOUCH = "TRUE" *)  CIM_Core_mem_ctrl_demux #(
////////////////////Need to Update/////////////////////
    .MEM_ADDR_WIDTH	    (   SRAM_MEM_ADDR_WIDTH   ),
	.MEM_DATA_WIDTH	    (   SRAM_MEM_DATA_WIDTH    )
////////////////////Need to Update/////////////////////
)  i_sram_ctrl_demux(
    .clk_i,
    .rst_ni,
  // MUX ctrl reg
    .csr_CIM_Core_mem_mux_i             (   csr_CIM_Core_mem_mux_i   ),	
  // AXI to mem interface
    .CIM_Core_axi_mem_req_i         (   axi_sram_mem_req_o   ),
    .CIM_Core_axi_mem_we_i          (   axi_sram_mem_we_o    ),
    .CIM_Core_axi_mem_addr_i        (   axi_sram_mem_addr_o  ),
    .CIM_Core_axi_mem_be_i          (   axi_sram_mem_be_o    ),
    .CIM_Core_axi_mem_wdata_i       (   axi_sram_mem_data_o  ),
    .CIM_Core_axi_mem_rdata_o       (   axi_sram_mem_data_i  ),
    // CIM ctrl to  mem interface
    .CIM_Core_ctrl_mem_req_i        (   CIM_Core_ctrl_SRAM_mem_req_i    ),
    .CIM_Core_ctrl_mem_we_i         (   CIM_Core_ctrl_SRAM_mem_we_i     ),
    .CIM_Core_ctrl_mem_addr_i       (   CIM_Core_ctrl_SRAM_mem_addr_i   ),
    .CIM_Core_ctrl_mem_be_i         (   CIM_Core_ctrl_SRAM_mem_be_i     ),
    .CIM_Core_ctrl_mem_wdata_i      (   CIM_Core_ctrl_SRAM_mem_wdata_i  ),
    .CIM_Core_ctrl_mem_rdata_o      (   CIM_Core_ctrl_SRAM_mem_rdata_o  ),
    // mem output ctrl interface
    .CIM_CORE_mem_req_o             (   sram_mem_req_o      ),
    .CIM_CORE_mem_we_o              (   sram_mem_we_o       ),
    .CIM_CORE_mem_addr_o            (   sram_mem_addr_o     ),
    .CIM_CORE_mem_be_o              (   sram_mem_be_o       ),
    .CIM_CORE_mem_data_o            (   sram_mem_data_o     ),
    .CIM_CORE_mem_data_i            (   sram_mem_data_i     )
);

(* DONT_TOUCH = "TRUE" *)  AXI_BUS #(
    .AXI_ID_WIDTH      ( AXI_SLV_ID_WIDTH     ),   
    .AXI_ADDR_WIDTH    ( MACRO_MEM_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH    ( MACRO_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH    ( AXI_USER_WIDTH  )
) cim_macro_master();

(* DONT_TOUCH = "TRUE" *) axi_dw_converter_intf #(
    .AXI_ID_WIDTH               (   AXI_SLV_ID_WIDTH      ),
    .AXI_ADDR_WIDTH             (   MACRO_MEM_ADDR_WIDTH    ),
    .AXI_SLV_PORT_DATA_WIDTH    (   AXI_DATA_WIDTH    ),
    .AXI_MST_PORT_DATA_WIDTH    (   MACRO_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH             (   AXI_USER_WIDTH    )
    // .AXI_MAX_READS              (       )
) i_macro_axi_dw_converter_intf(
    .clk_i,
    .rst_ni,
    .slv               (CIM_Core_macro),
    .mst               (cim_macro_master)
);

logic 							                axi_macro_mem_req_o;
logic 							                axi_macro_mem_we_o;
logic 	[MACRO_MEM_ADDR_WIDTH-1:0]	            axi_macro_mem_addr_o;
logic 	[MACRO_MEM_DATA_WIDTH/8-1:0]	        axi_macro_mem_be_o;
logic 	[MACRO_MEM_DATA_WIDTH-1:0]	            axi_macro_mem_data_o;
logic 	[MACRO_MEM_DATA_WIDTH-1:0]	            axi_macro_mem_data_i;

(* DONT_TOUCH = "TRUE" *)  axi2mem #(
    .AXI_ID_WIDTH      ( AXI_SLV_ID_WIDTH      ),   
    .AXI_ADDR_WIDTH    ( MACRO_MEM_ADDR_WIDTH   ),
    .AXI_DATA_WIDTH    ( MACRO_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH    ( AXI_USER_WIDTH   )
) i_macro_axi2mem(
    .clk_i,    // Clock
    .rst_ni,  // Asynchronous reset active low
    .slave              (cim_macro_master),
    .req_o              (axi_macro_mem_req_o         ),
    .we_o               (axi_macro_mem_we_o          ),
    .addr_o             (axi_macro_mem_addr_o        ),
    .be_o               (axi_macro_mem_be_o          ),
    .user_o             (       ),
    .data_o             (axi_macro_mem_data_o        ),
    .user_i             (       ),
    .data_i             (axi_macro_mem_data_i        )
);

    // macro input ctrl interface //////////macro/////////////
    logic 							        CIM_Core_macro_mem_req_o;
    logic 							        CIM_Core_macro_mem_we_o;
    logic 	[MACRO_MEM_ADDR_WIDTH-1:0]	    CIM_Core_macro_mem_addr_o;
    logic 	[MACRO_MEM_DATA_WIDTH/8-1:0]	CIM_Core_macro_mem_be_o;
    logic 	[MACRO_MEM_DATA_WIDTH-1:0]	    CIM_Core_macro_mem_data_o;
    logic 	[MACRO_MEM_DATA_WIDTH-1:0]	    CIM_Core_macro_mem_data_i;

(* DONT_TOUCH = "TRUE" *)  CIM_Core_mem_ctrl_demux #(
    .MEM_ADDR_WIDTH	    (   MACRO_MEM_ADDR_WIDTH    ),
	.MEM_DATA_WIDTH	    (   MACRO_MEM_DATA_WIDTH    )
)  i_macro_ctrl_demux_macro(
    .clk_i,
    .rst_ni,
  // MUX ctrl reg
    .csr_CIM_Core_mem_mux_i             (   csr_CIM_Core_mem_mux_i   ),	
  // AXI to mem interface
    .CIM_Core_axi_mem_req_i         (   axi_macro_mem_req_o   ),
    .CIM_Core_axi_mem_we_i          (   axi_macro_mem_we_o    ),
    .CIM_Core_axi_mem_addr_i        (   axi_macro_mem_addr_o  ),
    .CIM_Core_axi_mem_be_i          (   axi_macro_mem_be_o    ),
    .CIM_Core_axi_mem_wdata_i       (   axi_macro_mem_data_o  ),
    .CIM_Core_axi_mem_rdata_o       (   axi_macro_mem_data_i  ),
    // CIM ctrl to  mem interface
    .CIM_Core_ctrl_mem_req_i        (   CIM_Core_ctrl_macro_mem_req_i    ),
    .CIM_Core_ctrl_mem_we_i         (   CIM_Core_ctrl_macro_mem_we_i     ),
    .CIM_Core_ctrl_mem_addr_i       (   CIM_Core_ctrl_macro_mem_addr_i   ),
    .CIM_Core_ctrl_mem_be_i         (   CIM_Core_ctrl_macro_mem_be_i     ),
    .CIM_Core_ctrl_mem_wdata_i      (   CIM_Core_ctrl_macro_mem_wdata_i  ),
    .CIM_Core_ctrl_mem_rdata_o      (   CIM_Core_ctrl_macro_mem_rdata_o  ),
    // mem output ctrl interface
    .CIM_CORE_mem_req_o             (   CIM_Core_macro_mem_req_o      ),
    .CIM_CORE_mem_we_o              (   CIM_Core_macro_mem_we_o       ),
    .CIM_CORE_mem_addr_o            (   CIM_Core_macro_mem_addr_o     ),
    .CIM_CORE_mem_be_o              (   CIM_Core_macro_mem_be_o       ),
    .CIM_CORE_mem_data_o            (   CIM_Core_macro_mem_data_o     ),
    .CIM_CORE_mem_data_i            (   CIM_Core_macro_mem_data_i     )
);

(* DONT_TOUCH = "TRUE" *)  CIM_Core_macro_mem_addr_demux #(
    .MEM_ADDR_WIDTH	        (   MACRO_MEM_ADDR_WIDTH    ),
	.MEM_DATA_WIDTH	        (   MACRO_MEM_DATA_WIDTH  )
)  i_CIM_Core_macro_mem_addr_demux(
    .CIM_CORE_mem_req_i             (   CIM_Core_macro_mem_req_o      ),
    .CIM_CORE_mem_we_i              (   CIM_Core_macro_mem_we_o       ),
    .CIM_CORE_mem_addr_i            (   CIM_Core_macro_mem_addr_o     ),
    .CIM_CORE_mem_be_i              (   CIM_Core_macro_mem_be_o       ),
    .CIM_CORE_mem_data_i            (   CIM_Core_macro_mem_data_o     ),
    .CIM_CORE_mem_data_o            (   CIM_Core_macro_mem_data_i     ),
    // macro output ctrl interface //////////macro_0/////////////
    .macro_0_mem_req_o,
    .macro_0_mem_we_o,
    .macro_0_mem_addr_o,
    .macro_0_mem_be_o,
    .macro_0_mem_data_o,
    .macro_0_mem_data_i,
    // macro output ctrl interface //////////macro_1/////////////
    .macro_1_mem_req_o,
    .macro_1_mem_we_o,
    .macro_1_mem_addr_o,
    .macro_1_mem_be_o,
    .macro_1_mem_data_o,
    .macro_1_mem_data_i,
    // macro output ctrl interface //////////macro_2/////////////
    .macro_2_mem_req_o,
    .macro_2_mem_we_o,
    .macro_2_mem_addr_o,
    .macro_2_mem_be_o,
    .macro_2_mem_data_o,
    .macro_2_mem_data_i,
    // macro output ctrl interface //////////macro_3/////////////
    .macro_3_mem_req_o,
    .macro_3_mem_we_o,
    .macro_3_mem_addr_o,
    .macro_3_mem_be_o,
    .macro_3_mem_data_o,
    .macro_3_mem_data_i,
    // macro output ctrl interface //////////macro_4/////////////
    .macro_4_mem_req_o,
    .macro_4_mem_we_o,
    .macro_4_mem_addr_o,
    .macro_4_mem_be_o,
    .macro_4_mem_data_o,
    .macro_4_mem_data_i,
    // macro output ctrl interface //////////macro_5/////////////
    .macro_5_mem_req_o,
    .macro_5_mem_we_o,
    .macro_5_mem_addr_o,
    .macro_5_mem_be_o,
    .macro_5_mem_data_o,
    .macro_5_mem_data_i,
    // macro output ctrl interface //////////macro_6/////////////
    .macro_6_mem_req_o,
    .macro_6_mem_we_o,
    .macro_6_mem_addr_o,
    .macro_6_mem_be_o,
    .macro_6_mem_data_o,
    .macro_6_mem_data_i,
    // macro output ctrl interface //////////macro_7/////////////
    .macro_7_mem_req_o,
    .macro_7_mem_we_o,
    .macro_7_mem_addr_o,
    .macro_7_mem_be_o,
    .macro_7_mem_data_o,
    .macro_7_mem_data_i,
    // macro output ctrl interface //////////macro_8/////////////
    .macro_8_mem_req_o,
    .macro_8_mem_we_o,
    .macro_8_mem_addr_o,
    .macro_8_mem_be_o,
    .macro_8_mem_data_o,
    .macro_8_mem_data_i
);

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
(* DONT_TOUCH = "TRUE" *)  AXI_BUS #(
    .AXI_ID_WIDTH      ( AXI_SLV_ID_WIDTH     ),   
    .AXI_ADDR_WIDTH    ( MACRO_MEM_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH    ( MACRO_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH    ( AXI_USER_WIDTH  )
) cim_eDRAM_master();

(* DONT_TOUCH = "TRUE" *)  axi_dw_converter_intf #(
    .AXI_ID_WIDTH               (   AXI_SLV_ID_WIDTH      ),
    .AXI_ADDR_WIDTH             (   eDRAM_MEM_ADDR_WIDTH    ),
    .AXI_SLV_PORT_DATA_WIDTH    (   AXI_DATA_WIDTH    ),
    .AXI_MST_PORT_DATA_WIDTH    (   eDRAM_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH             (   AXI_USER_WIDTH    )
    // .AXI_MAX_READS              (       )
) i_eDRAM_axi_dw_converter_intf(
    .clk_i,
    .rst_ni,
    .slv               (CIM_Core_eDRAM),
    .mst               (cim_eDRAM_master)
);

logic 							                axi_eDRAM_mem_req_o;
logic 							                axi_eDRAM_mem_we_o;
logic 	[eDRAM_MEM_ADDR_WIDTH-1:0]	            axi_eDRAM_mem_addr_o;
logic 	[eDRAM_MEM_DATA_WIDTH/8-1:0]	        axi_eDRAM_mem_be_o;
logic 	[eDRAM_MEM_DATA_WIDTH-1:0]	            axi_eDRAM_mem_data_o;
logic 	[eDRAM_MEM_DATA_WIDTH-1:0]	            axi_eDRAM_mem_data_i;

(* DONT_TOUCH = "TRUE" *)  axi2mem #(
    .AXI_ID_WIDTH      ( AXI_SLV_ID_WIDTH      ),   
    .AXI_ADDR_WIDTH    ( eDRAM_MEM_ADDR_WIDTH   ),
    .AXI_DATA_WIDTH    ( eDRAM_MEM_DATA_WIDTH   ),
    .AXI_USER_WIDTH    ( AXI_USER_WIDTH   )
) i_eDRAM_axi2mem(
    .clk_i,    // Clock
    .rst_ni,  // Asynchronous reset active low
    .slave              (cim_eDRAM_master),
    .req_o              (axi_eDRAM_mem_req_o         ),
    .we_o               (axi_eDRAM_mem_we_o          ),
    .addr_o             (axi_eDRAM_mem_addr_o        ),
    .be_o               (axi_eDRAM_mem_be_o          ),
    .user_o             (       ),
    .data_o             (axi_eDRAM_mem_data_o        ),
    .user_i             (       ),
    .data_i             (axi_eDRAM_mem_data_i        )
);

    // macro input ctrl interface //////////macro/////////////
    logic 							        CIM_Core_eDRAM_mem_req_o;
    logic 							        CIM_Core_eDRAM_mem_we_o;
    logic 	[eDRAM_MEM_ADDR_WIDTH-1:0]	    CIM_Core_eDRAM_mem_addr_o;
    logic 	[eDRAM_MEM_DATA_WIDTH/8-1:0]	CIM_Core_eDRAM_mem_be_o;
    logic 	[eDRAM_MEM_DATA_WIDTH-1:0]	    CIM_Core_eDRAM_mem_data_o;
    logic 	[eDRAM_MEM_DATA_WIDTH-1:0]	    CIM_Core_eDRAM_mem_data_i;

(* DONT_TOUCH = "TRUE" *)  CIM_Core_mem_ctrl_demux #(
    .MEM_ADDR_WIDTH	    (   eDRAM_MEM_ADDR_WIDTH    ),
	.MEM_DATA_WIDTH	    (   eDRAM_MEM_DATA_WIDTH    )
)  i_eDRAM_ctrl_demux_macro(
    .clk_i,
    .rst_ni,
  // MUX ctrl reg
    .csr_CIM_Core_mem_mux_i             (   csr_CIM_Core_mem_mux_i   ),	
  // AXI to mem interface
    .CIM_Core_axi_mem_req_i         (   axi_eDRAM_mem_req_o   ),
    .CIM_Core_axi_mem_we_i          (   axi_eDRAM_mem_we_o    ),
    .CIM_Core_axi_mem_addr_i        (   axi_eDRAM_mem_addr_o  ),
    .CIM_Core_axi_mem_be_i          (   axi_eDRAM_mem_be_o    ),
    .CIM_Core_axi_mem_wdata_i       (   axi_eDRAM_mem_data_o  ),
    .CIM_Core_axi_mem_rdata_o       (   axi_eDRAM_mem_data_i  ),
    // CIM ctrl to  mem interface
    .CIM_Core_ctrl_mem_req_i        (   CIM_Core_ctrl_eDRAM_mem_req_i    ),
    .CIM_Core_ctrl_mem_we_i         (   CIM_Core_ctrl_eDRAM_mem_we_i     ),
    .CIM_Core_ctrl_mem_addr_i       (   CIM_Core_ctrl_eDRAM_mem_addr_i   ),
    .CIM_Core_ctrl_mem_be_i         (   CIM_Core_ctrl_eDRAM_mem_be_i     ),
    .CIM_Core_ctrl_mem_wdata_i      (   CIM_Core_ctrl_eDRAM_mem_wdata_i  ),
    .CIM_Core_ctrl_mem_rdata_o      (   CIM_Core_ctrl_eDRAM_mem_rdata_o  ),
    // mem output ctrl interface
    .CIM_CORE_mem_req_o             (   CIM_Core_eDRAM_mem_req_o      ),
    .CIM_CORE_mem_we_o              (   CIM_Core_eDRAM_mem_we_o       ),
    .CIM_CORE_mem_addr_o            (   CIM_Core_eDRAM_mem_addr_o     ),
    .CIM_CORE_mem_be_o              (   CIM_Core_eDRAM_mem_be_o       ),
    .CIM_CORE_mem_data_o            (   CIM_Core_eDRAM_mem_data_o     ),
    .CIM_CORE_mem_data_i            (   CIM_Core_eDRAM_mem_data_i     )
);

(* DONT_TOUCH = "TRUE" *)  CIM_Core_eDRAM_mem_addr_demux #(
    .MEM_ADDR_WIDTH	        (   eDRAM_MEM_ADDR_WIDTH    ),
	.MEM_DATA_WIDTH	        (   eDRAM_MEM_DATA_WIDTH  )
)  i_CIM_Core_eDRAM_mem_addr_demux(
    .CIM_CORE_mem_req_i             (   CIM_Core_eDRAM_mem_req_o      ),
    .CIM_CORE_mem_we_i              (   CIM_Core_eDRAM_mem_we_o       ),
    .CIM_CORE_mem_addr_i            (   CIM_Core_eDRAM_mem_addr_o     ),
    .CIM_CORE_mem_be_i              (   CIM_Core_eDRAM_mem_be_o       ),
    .CIM_CORE_mem_data_i            (   CIM_Core_eDRAM_mem_data_o     ),
    .CIM_CORE_mem_data_o            (   CIM_Core_eDRAM_mem_data_i     ),
    // eDRAM output ctrl interface //////////eDRAM_0/////////////
    .eDRAM_0_mem_req_o,
    .eDRAM_0_mem_we_o,
    .eDRAM_0_mem_addr_o,
    .eDRAM_0_mem_be_o,
    .eDRAM_0_mem_data_o,
    .eDRAM_0_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_1/////////////
    .eDRAM_1_mem_req_o,
    .eDRAM_1_mem_we_o,
    .eDRAM_1_mem_addr_o,
    .eDRAM_1_mem_be_o,
    .eDRAM_1_mem_data_o,
    .eDRAM_1_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_2/////////////
    .eDRAM_2_mem_req_o,
    .eDRAM_2_mem_we_o,
    .eDRAM_2_mem_addr_o,
    .eDRAM_2_mem_be_o,
    .eDRAM_2_mem_data_o,
    .eDRAM_2_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_3/////////////
    .eDRAM_3_mem_req_o,
    .eDRAM_3_mem_we_o,
    .eDRAM_3_mem_addr_o,
    .eDRAM_3_mem_be_o,
    .eDRAM_3_mem_data_o,
    .eDRAM_3_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_4/////////////
    .eDRAM_4_mem_req_o,
    .eDRAM_4_mem_we_o,
    .eDRAM_4_mem_addr_o,
    .eDRAM_4_mem_be_o,
    .eDRAM_4_mem_data_o,
    .eDRAM_4_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_5/////////////
    .eDRAM_5_mem_req_o,
    .eDRAM_5_mem_we_o,
    .eDRAM_5_mem_addr_o,
    .eDRAM_5_mem_be_o,
    .eDRAM_5_mem_data_o,
    .eDRAM_5_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_6/////////////
    .eDRAM_6_mem_req_o,
    .eDRAM_6_mem_we_o,
    .eDRAM_6_mem_addr_o,
    .eDRAM_6_mem_be_o,
    .eDRAM_6_mem_data_o,
    .eDRAM_6_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_7/////////////
    .eDRAM_7_mem_req_o,
    .eDRAM_7_mem_we_o,
    .eDRAM_7_mem_addr_o,
    .eDRAM_7_mem_be_o,
    .eDRAM_7_mem_data_o,
    .eDRAM_7_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_8/////////////
    .eDRAM_8_mem_req_o,
    .eDRAM_8_mem_we_o,
    .eDRAM_8_mem_addr_o,
    .eDRAM_8_mem_be_o,
    .eDRAM_8_mem_data_o,
    .eDRAM_8_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_9/////////////
    .eDRAM_9_mem_req_o,
    .eDRAM_9_mem_we_o,
    .eDRAM_9_mem_addr_o,
    .eDRAM_9_mem_be_o,
    .eDRAM_9_mem_data_o,
    .eDRAM_9_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_10/////////////
    .eDRAM_10_mem_req_o,
    .eDRAM_10_mem_we_o,
    .eDRAM_10_mem_addr_o,
    .eDRAM_10_mem_be_o,
    .eDRAM_10_mem_data_o,
    .eDRAM_10_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_11/////////////
    .eDRAM_11_mem_req_o,
    .eDRAM_11_mem_we_o,
    .eDRAM_11_mem_addr_o,
    .eDRAM_11_mem_be_o,
    .eDRAM_11_mem_data_o,
    .eDRAM_11_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_12/////////////
    .eDRAM_12_mem_req_o,
    .eDRAM_12_mem_we_o,
    .eDRAM_12_mem_addr_o,
    .eDRAM_12_mem_be_o,
    .eDRAM_12_mem_data_o,
    .eDRAM_12_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_13/////////////
    .eDRAM_13_mem_req_o,
    .eDRAM_13_mem_we_o,
    .eDRAM_13_mem_addr_o,
    .eDRAM_13_mem_be_o,
    .eDRAM_13_mem_data_o,
    .eDRAM_13_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_14/////////////
    .eDRAM_14_mem_req_o,
    .eDRAM_14_mem_we_o,
    .eDRAM_14_mem_addr_o,
    .eDRAM_14_mem_be_o,
    .eDRAM_14_mem_data_o,
    .eDRAM_14_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_15/////////////
    .eDRAM_15_mem_req_o,
    .eDRAM_15_mem_we_o,
    .eDRAM_15_mem_addr_o,
    .eDRAM_15_mem_be_o,
    .eDRAM_15_mem_data_o,
    .eDRAM_15_mem_data_i
);
endmodule