module CIM_Core_mem_addr_demux #(
    parameter MEM_ADDR_WIDTH	= -1,
	parameter MEM_DATA_WIDTH	= -1,
    parameter type  addr_t      = logic
    // parameter type  rule_t      = logic
)  (
    // input   logic                           clk_i,
    // input   logic                           rst_ni,

    // mem input ctrl interface
    input   logic                         	CIM_CORE_mem_req_i,
    input   logic                         	CIM_CORE_mem_we_i,
    input   logic  [MEM_ADDR_WIDTH-1:0]   	CIM_CORE_mem_addr_i,
    input   logic  [MEM_DATA_WIDTH/8-1:0] 	CIM_CORE_mem_be_i,
    input   logic  [MEM_DATA_WIDTH-1:0]   	CIM_CORE_mem_data_i,
    output  logic  [MEM_DATA_WIDTH-1:0]   	CIM_CORE_mem_data_o,
    // macro output ctrl interface //////////macro_0/////////////
    output  logic                         	macro_0_mem_req_o,
    output  logic                         	macro_0_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_0_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_0_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_0_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_0_mem_data_i,
    // macro output ctrl interface //////////macro_1/////////////
    output  logic                         	macro_1_mem_req_o,
    output  logic                         	macro_1_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_1_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_1_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_1_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_1_mem_data_i,
    // macro output ctrl interface //////////macro_2/////////////
    output  logic                         	macro_2_mem_req_o,
    output  logic                         	macro_2_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_2_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_2_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_2_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_2_mem_data_i,
    // macro output ctrl interface //////////macro_3/////////////
    output  logic                         	macro_3_mem_req_o,
    output  logic                         	macro_3_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_3_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_3_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_3_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_3_mem_data_i,
    // macro output ctrl interface //////////macro_4/////////////
    output  logic                         	macro_4_mem_req_o,
    output  logic                         	macro_4_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_4_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_4_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_4_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_4_mem_data_i,
    // macro output ctrl interface //////////macro_5/////////////
    output  logic                         	macro_5_mem_req_o,
    output  logic                         	macro_5_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_5_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_5_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_5_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_5_mem_data_i,
    // macro output ctrl interface //////////macro_6/////////////
    output  logic                         	macro_6_mem_req_o,
    output  logic                         	macro_6_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_6_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_6_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_6_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_6_mem_data_i,
    // macro output ctrl interface //////////macro_7/////////////
    output  logic                         	macro_7_mem_req_o,
    output  logic                         	macro_7_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_7_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_7_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_7_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_7_mem_data_i,
    // macro output ctrl interface //////////macro_8/////////////
    output  logic                         	macro_8_mem_req_o,
    output  logic                         	macro_8_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	macro_8_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	macro_8_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	macro_8_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	macro_8_mem_data_i
);

// axi_pkg::xbar_rule_64_t [CIM_Core_macro_addr_map::NB_MACROS-1:0] CIM_Core_macro_addr_map_i;

typedef struct packed {
    int unsigned idx;
    logic [63:0] start_addr;
    logic [63:0] end_addr;
} macro_rule_64_t;

macro_rule_64_t [CIM_Core_macro_addr_map::NB_MACROS-1:0] CIM_Core_macro_addr_map_i;

assign CIM_Core_macro_addr_map_i = '{
    '{ idx: CIM_Core_macro_addr_map::macro_0, start_addr: CIM_Core_macro_addr_map::macro_0Base, end_addr: CIM_Core_macro_addr_map::macro_0Base + CIM_Core_macro_addr_map::macro_0Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_1, start_addr: CIM_Core_macro_addr_map::macro_1Base, end_addr: CIM_Core_macro_addr_map::macro_1Base + CIM_Core_macro_addr_map::macro_1Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_2, start_addr: CIM_Core_macro_addr_map::macro_2Base, end_addr: CIM_Core_macro_addr_map::macro_2Base + CIM_Core_macro_addr_map::macro_2Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_3, start_addr: CIM_Core_macro_addr_map::macro_3Base, end_addr: CIM_Core_macro_addr_map::macro_3Base + CIM_Core_macro_addr_map::macro_3Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_4, start_addr: CIM_Core_macro_addr_map::macro_4Base, end_addr: CIM_Core_macro_addr_map::macro_4Base + CIM_Core_macro_addr_map::macro_4Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_5, start_addr: CIM_Core_macro_addr_map::macro_5Base, end_addr: CIM_Core_macro_addr_map::macro_5Base + CIM_Core_macro_addr_map::macro_5Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_6, start_addr: CIM_Core_macro_addr_map::macro_6Base, end_addr: CIM_Core_macro_addr_map::macro_6Base + CIM_Core_macro_addr_map::macro_6Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_7, start_addr: CIM_Core_macro_addr_map::macro_7Base, end_addr: CIM_Core_macro_addr_map::macro_7Base + CIM_Core_macro_addr_map::macro_7Length    },
    '{ idx: CIM_Core_macro_addr_map::macro_8, start_addr: CIM_Core_macro_addr_map::macro_8Base, end_addr: CIM_Core_macro_addr_map::macro_8Base + CIM_Core_macro_addr_map::macro_8Length    }
};
localparam IdxWdith = 4;
logic   [IdxWdith-1:0]              idx_o;
logic                               dec_valid_o;
// CIM_Core_addr_decode #(
//     .NoRules                (32'd9                ),
//     .AXI_ADDR_WIDTH         (MEM_ADDR_WIDTH       ),
//     .rule_t                 (rule_t               ),
//     .IdxWidth               (IdxWdith             )
// ) i_CIM_Core_addr_decode (
//     .addr_i         (CIM_CORE_mem_addr_i    ),
//     .addr_map_i     (CIM_Core_macro_addr_map_i      ),
//     .idx_o          (idx_o                  ),
//     .dec_valid_o    (dec_valid_o            )
// );
    addr_decode #(
      .NoIndices  ( 32'd9  ),
      .addr_t     ( addr_t          ),
      .NoRules    ( 32'd9 ),
      .rule_t     ( macro_rule_64_t          )
    ) i_mem_addr_decode (
      .addr_i           ( CIM_CORE_mem_addr_i ),
      .addr_map_i       ( CIM_Core_macro_addr_map_i                 ),
      .idx_o            ( idx_o                     ),
      .dec_valid_o      ( dec_valid_o               ),
      .dec_error_o      (                 ),
      .en_default_idx_i (        ),
      .default_idx_i    (        )
    );

logic   macro_0_mem_req;
assign  macro_0_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_0);

assign  macro_0_mem_req_o  = macro_0_mem_req && CIM_CORE_mem_req_i;
assign  macro_0_mem_we_o   = macro_0_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_0_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_0Base;
assign  macro_0_mem_be_o   = macro_0_mem_req && CIM_CORE_mem_be_i;
assign  macro_0_mem_data_o = macro_0_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_1_mem_req;
assign  macro_1_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_1);

assign  macro_1_mem_req_o  = macro_1_mem_req && CIM_CORE_mem_req_i;
assign  macro_1_mem_we_o   = macro_1_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_1_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_1Base;
assign  macro_1_mem_be_o   = macro_1_mem_req && CIM_CORE_mem_be_i;
assign  macro_1_mem_data_o = macro_1_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_2_mem_req;
assign  macro_2_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_2);

assign  macro_2_mem_req_o  = macro_2_mem_req && CIM_CORE_mem_req_i;
assign  macro_2_mem_we_o   = macro_2_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_2_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_2Base;
assign  macro_2_mem_be_o   = macro_2_mem_req && CIM_CORE_mem_be_i;
assign  macro_2_mem_data_o = macro_2_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_3_mem_req;
assign  macro_3_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_3);

assign  macro_3_mem_req_o  = macro_3_mem_req && CIM_CORE_mem_req_i;
assign  macro_3_mem_we_o   = macro_3_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_3_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_3Base;
assign  macro_3_mem_be_o   = macro_3_mem_req && CIM_CORE_mem_be_i;
assign  macro_3_mem_data_o = macro_3_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_4_mem_req;
assign  macro_4_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_4);

assign  macro_4_mem_req_o  = macro_4_mem_req && CIM_CORE_mem_req_i;
assign  macro_4_mem_we_o   = macro_4_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_4_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_4Base;
assign  macro_4_mem_be_o   = macro_4_mem_req && CIM_CORE_mem_be_i;
assign  macro_4_mem_data_o = macro_4_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_5_mem_req;
assign  macro_5_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_5);

assign  macro_5_mem_req_o  = macro_5_mem_req && CIM_CORE_mem_req_i;
assign  macro_5_mem_we_o   = macro_5_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_5_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_5Base;
assign  macro_5_mem_be_o   = macro_5_mem_req && CIM_CORE_mem_be_i;
assign  macro_5_mem_data_o = macro_5_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_6_mem_req;
assign  macro_6_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_6);

assign  macro_6_mem_req_o  = macro_6_mem_req && CIM_CORE_mem_req_i;
assign  macro_6_mem_we_o   = macro_6_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_6_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_6Base;
assign  macro_6_mem_be_o   = macro_6_mem_req && CIM_CORE_mem_be_i;
assign  macro_6_mem_data_o = macro_6_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_7_mem_req;
assign  macro_7_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_7);

assign  macro_7_mem_req_o  = macro_7_mem_req && CIM_CORE_mem_req_i;
assign  macro_7_mem_we_o   = macro_7_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_7_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_7Base;
assign  macro_7_mem_be_o   = macro_7_mem_req && CIM_CORE_mem_be_i;
assign  macro_7_mem_data_o = macro_7_mem_req ? CIM_CORE_mem_data_i : '0;

logic   macro_8_mem_req;
assign  macro_8_mem_req  = dec_valid_o && (idx_o == CIM_Core_macro_addr_map::macro_8);

assign  macro_8_mem_req_o  = macro_8_mem_req && CIM_CORE_mem_req_i;
assign  macro_8_mem_we_o   = macro_8_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  macro_8_mem_addr_o = CIM_CORE_mem_addr_i - CIM_Core_macro_addr_map::macro_8Base;
assign  macro_8_mem_be_o   = macro_8_mem_req && CIM_CORE_mem_be_i;
assign  macro_8_mem_data_o = macro_8_mem_req ? CIM_CORE_mem_data_i : '0;

// read direction selection
assign  CIM_CORE_mem_data_o = dec_valid_o ? (
    (idx_o == CIM_Core_macro_addr_map::macro_0) ? macro_0_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_1) ? macro_1_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_2) ? macro_2_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_3) ? macro_3_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_4) ? macro_4_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_5) ? macro_5_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_6) ? macro_6_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_7) ? macro_7_mem_data_i :
    (idx_o == CIM_Core_macro_addr_map::macro_8) ? macro_8_mem_data_i :
    '0
) : '0;


endmodule
