module CIM_Core_eDRAM_mem_addr_demux #(
    parameter MEM_ADDR_WIDTH	= -1,
	parameter MEM_DATA_WIDTH	= -1
    // parameter type  addr_t      = logic
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
    // eDRAM output ctrl interface //////////eDRAM_0/////////////
    output  logic                         	eDRAM_0_mem_req_o,
    output  logic                         	eDRAM_0_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_0_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_0_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_0_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_0_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_1/////////////
    output  logic                         	eDRAM_1_mem_req_o,
    output  logic                         	eDRAM_1_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_1_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_1_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_1_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_1_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_2/////////////
    output  logic                         	eDRAM_2_mem_req_o,
    output  logic                         	eDRAM_2_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_2_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_2_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_2_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_2_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_3/////////////
    output  logic                         	eDRAM_3_mem_req_o,
    output  logic                         	eDRAM_3_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_3_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_3_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_3_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_3_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_4/////////////
    output  logic                         	eDRAM_4_mem_req_o,
    output  logic                         	eDRAM_4_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_4_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_4_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_4_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_4_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_5/////////////
    output  logic                         	eDRAM_5_mem_req_o,
    output  logic                         	eDRAM_5_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_5_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_5_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_5_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_5_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_6/////////////
    output  logic                         	eDRAM_6_mem_req_o,
    output  logic                         	eDRAM_6_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_6_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_6_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_6_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_6_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_7/////////////
    output  logic                         	eDRAM_7_mem_req_o,
    output  logic                         	eDRAM_7_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_7_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_7_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_7_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_7_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_8/////////////
    output  logic                         	eDRAM_8_mem_req_o,
    output  logic                         	eDRAM_8_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_8_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_8_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_8_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_8_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_9/////////////
    output  logic                         	eDRAM_9_mem_req_o,
    output  logic                         	eDRAM_9_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_9_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_9_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_9_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_9_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_10/////////////
    output  logic                         	eDRAM_10_mem_req_o,
    output  logic                         	eDRAM_10_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_10_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_10_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_10_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_10_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_11/////////////
    output  logic                         	eDRAM_11_mem_req_o,
    output  logic                         	eDRAM_11_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_11_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_11_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_11_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_11_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_12/////////////
    output  logic                         	eDRAM_12_mem_req_o,
    output  logic                         	eDRAM_12_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_12_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_12_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_12_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_12_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_13/////////////
    output  logic                         	eDRAM_13_mem_req_o,
    output  logic                         	eDRAM_13_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_13_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_13_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_13_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_13_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_14/////////////
    output  logic                         	eDRAM_14_mem_req_o,
    output  logic                         	eDRAM_14_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_14_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_14_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_14_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_14_mem_data_i,
    // eDRAM output ctrl interface //////////eDRAM_15/////////////
    output  logic                         	eDRAM_15_mem_req_o,
    output  logic                         	eDRAM_15_mem_we_o,
    output  logic  [MEM_ADDR_WIDTH-1:0]   	eDRAM_15_mem_addr_o,
    output  logic  [MEM_DATA_WIDTH/8-1:0] 	eDRAM_15_mem_be_o,
    output  logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_15_mem_data_o,
    input   logic  [MEM_DATA_WIDTH-1:0]   	eDRAM_15_mem_data_i
);

// axi_pkg::xbar_rule_64_t [CIM_Core_eDRAM_addr_map::NB_eDRAMS-1:0] CIM_Core_eDRAM_addr_map_i;

typedef struct packed {
    int unsigned idx;
    logic [63:0] start_addr;
    logic [63:0] end_addr;
} eDRAM_rule_64_t;

eDRAM_rule_64_t [CIM_Core_eDRAM_addr_map::NB_eDRAMS-1:0] CIM_Core_eDRAM_addr_map_i;

assign CIM_Core_eDRAM_addr_map_i = '{
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_0, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_0Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_0Base + CIM_Core_eDRAM_addr_map::eDRAM_0Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_1, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_1Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_1Base + CIM_Core_eDRAM_addr_map::eDRAM_1Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_2, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_2Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_2Base + CIM_Core_eDRAM_addr_map::eDRAM_2Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_3, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_3Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_3Base + CIM_Core_eDRAM_addr_map::eDRAM_3Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_4, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_4Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_4Base + CIM_Core_eDRAM_addr_map::eDRAM_4Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_5, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_5Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_5Base + CIM_Core_eDRAM_addr_map::eDRAM_5Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_6, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_6Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_6Base + CIM_Core_eDRAM_addr_map::eDRAM_6Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_7, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_7Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_7Base + CIM_Core_eDRAM_addr_map::eDRAM_7Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_8, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_8Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_8Base + CIM_Core_eDRAM_addr_map::eDRAM_8Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_9, start_addr: CIM_Core_eDRAM_addr_map::eDRAM_9Base, end_addr: CIM_Core_eDRAM_addr_map::eDRAM_9Base + CIM_Core_eDRAM_addr_map::eDRAM_9Length    },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_10,start_addr: CIM_Core_eDRAM_addr_map::eDRAM_10Base,end_addr: CIM_Core_eDRAM_addr_map::eDRAM_10Base +CIM_Core_eDRAM_addr_map::eDRAM_10Length   },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_11,start_addr: CIM_Core_eDRAM_addr_map::eDRAM_11Base,end_addr: CIM_Core_eDRAM_addr_map::eDRAM_11Base +CIM_Core_eDRAM_addr_map::eDRAM_11Length   },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_12,start_addr: CIM_Core_eDRAM_addr_map::eDRAM_12Base,end_addr: CIM_Core_eDRAM_addr_map::eDRAM_12Base +CIM_Core_eDRAM_addr_map::eDRAM_12Length   },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_13,start_addr: CIM_Core_eDRAM_addr_map::eDRAM_13Base,end_addr: CIM_Core_eDRAM_addr_map::eDRAM_13Base +CIM_Core_eDRAM_addr_map::eDRAM_13Length   },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_14,start_addr: CIM_Core_eDRAM_addr_map::eDRAM_14Base,end_addr: CIM_Core_eDRAM_addr_map::eDRAM_14Base +CIM_Core_eDRAM_addr_map::eDRAM_14Length   },
    '{ idx: CIM_Core_eDRAM_addr_map::eDRAM_15,start_addr: CIM_Core_eDRAM_addr_map::eDRAM_15Base,end_addr: CIM_Core_eDRAM_addr_map::eDRAM_15Base +CIM_Core_eDRAM_addr_map::eDRAM_15Length   }
};
localparam IdxWdith = 5;
logic   [IdxWdith-1:0]              idx_o;
logic                               dec_valid_o;
// CIM_Core_addr_decode #(
//     .NoRules                (32'd9                ),
//     .AXI_ADDR_WIDTH         (MEM_ADDR_WIDTH       ),
//     .rule_t                 (rule_t               ),
//     .IdxWidth               (IdxWdith             )
// ) i_CIM_Core_addr_decode (
//     .addr_i         (CIM_CORE_mem_addr_i    ),
//     .addr_map_i     (CIM_Core_eDRAM_addr_map_i      ),
//     .idx_o          (idx_o                  ),
//     .dec_valid_o    (dec_valid_o            )
// );
    (* DONT_TOUCH = "TRUE" *)      addr_decode #(
      .NoIndices  ( 32'd16  ),
      .addr_t     ( logic   [63:0]          ),
      .NoRules    ( 32'd16 ),
      .rule_t     ( eDRAM_rule_64_t          )
    ) i_mem_addr_decode (
      .addr_i           ( CIM_CORE_mem_addr_i ),
      .addr_map_i       ( CIM_Core_eDRAM_addr_map_i                 ),
      .idx_o            ( idx_o                     ),
      .dec_valid_o      ( dec_valid_o               ),
      .dec_error_o      (                 ),
      .en_default_idx_i (   1'b0     ),
      .default_idx_i    (   1'b0     )
    );

logic   eDRAM_0_mem_req;
assign  eDRAM_0_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_0);

assign  eDRAM_0_mem_req_o  = eDRAM_0_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_0_mem_we_o   = eDRAM_0_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_0_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_0_mem_be_o   = eDRAM_0_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_0_mem_data_o = eDRAM_0_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_1_mem_req;
assign  eDRAM_1_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_1);

assign  eDRAM_1_mem_req_o  = eDRAM_1_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_1_mem_we_o   = eDRAM_1_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_1_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_1_mem_be_o   = eDRAM_1_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_1_mem_data_o = eDRAM_1_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_2_mem_req;
assign  eDRAM_2_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_2);

assign  eDRAM_2_mem_req_o  = eDRAM_2_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_2_mem_we_o   = eDRAM_2_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_2_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_2_mem_be_o   = eDRAM_2_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_2_mem_data_o = eDRAM_2_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_3_mem_req;
assign  eDRAM_3_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_3);

assign  eDRAM_3_mem_req_o  = eDRAM_3_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_3_mem_we_o   = eDRAM_3_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_3_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_3_mem_be_o   = eDRAM_3_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_3_mem_data_o = eDRAM_3_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_4_mem_req;
assign  eDRAM_4_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_4);

assign  eDRAM_4_mem_req_o  = eDRAM_4_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_4_mem_we_o   = eDRAM_4_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_4_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_4_mem_be_o   = eDRAM_4_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_4_mem_data_o = eDRAM_4_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_5_mem_req;
assign  eDRAM_5_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_5);

assign  eDRAM_5_mem_req_o  = eDRAM_5_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_5_mem_we_o   = eDRAM_5_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_5_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_5_mem_be_o   = eDRAM_5_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_5_mem_data_o = eDRAM_5_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_6_mem_req;
assign  eDRAM_6_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_6);

assign  eDRAM_6_mem_req_o  = eDRAM_6_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_6_mem_we_o   = eDRAM_6_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_6_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_6_mem_be_o   = eDRAM_6_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_6_mem_data_o = eDRAM_6_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_7_mem_req;
assign  eDRAM_7_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_7);

assign  eDRAM_7_mem_req_o  = eDRAM_7_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_7_mem_we_o   = eDRAM_7_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_7_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_7_mem_be_o   = eDRAM_7_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_7_mem_data_o = eDRAM_7_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_8_mem_req;
assign  eDRAM_8_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_8);

assign  eDRAM_8_mem_req_o  = eDRAM_8_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_8_mem_we_o   = eDRAM_8_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_8_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_8_mem_be_o   = eDRAM_8_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_8_mem_data_o = eDRAM_8_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_9_mem_req;
assign  eDRAM_9_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_9);

assign  eDRAM_9_mem_req_o  = eDRAM_9_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_9_mem_we_o   = eDRAM_9_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_9_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_9_mem_be_o   = eDRAM_9_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_9_mem_data_o = eDRAM_9_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_10_mem_req;
assign  eDRAM_10_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_10);

assign  eDRAM_10_mem_req_o  = eDRAM_10_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_10_mem_we_o   = eDRAM_10_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_10_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_10_mem_be_o   = eDRAM_10_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_10_mem_data_o = eDRAM_10_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_11_mem_req;
assign  eDRAM_11_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_11);

assign  eDRAM_11_mem_req_o  = eDRAM_11_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_11_mem_we_o   = eDRAM_11_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_11_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_11_mem_be_o   = eDRAM_11_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_11_mem_data_o = eDRAM_11_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_12_mem_req;
assign  eDRAM_12_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_12);

assign  eDRAM_12_mem_req_o  = eDRAM_12_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_12_mem_we_o   = eDRAM_12_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_12_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_12_mem_be_o   = eDRAM_12_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_12_mem_data_o = eDRAM_12_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_13_mem_req;
assign  eDRAM_13_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_13);

assign  eDRAM_13_mem_req_o  = eDRAM_13_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_13_mem_we_o   = eDRAM_13_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_13_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_13_mem_be_o   = eDRAM_13_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_13_mem_data_o = eDRAM_13_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_14_mem_req;
assign  eDRAM_14_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_14);

assign  eDRAM_14_mem_req_o  = eDRAM_14_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_14_mem_we_o   = eDRAM_14_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_14_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_14_mem_be_o   = eDRAM_14_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_14_mem_data_o = eDRAM_14_mem_req ? CIM_CORE_mem_data_i : '0;

logic   eDRAM_15_mem_req;
assign  eDRAM_15_mem_req  = dec_valid_o && (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_15);

assign  eDRAM_15_mem_req_o  = eDRAM_15_mem_req && CIM_CORE_mem_req_i;
assign  eDRAM_15_mem_we_o   = eDRAM_15_mem_req && CIM_CORE_mem_we_i;
// we need to add the offset to the address
assign  eDRAM_15_mem_addr_o = CIM_CORE_mem_addr_i;
assign  eDRAM_15_mem_be_o   = eDRAM_15_mem_req && CIM_CORE_mem_be_i;
assign  eDRAM_15_mem_data_o = eDRAM_15_mem_req ? CIM_CORE_mem_data_i : '0;

// read direction selection
assign  CIM_CORE_mem_data_o = dec_valid_o ? (
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_0) ? eDRAM_0_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_1) ? eDRAM_1_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_2) ? eDRAM_2_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_3) ? eDRAM_3_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_4) ? eDRAM_4_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_5) ? eDRAM_5_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_6) ? eDRAM_6_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_7) ? eDRAM_7_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_8) ? eDRAM_8_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_9) ? eDRAM_9_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_10) ? eDRAM_10_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_11) ? eDRAM_11_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_12) ? eDRAM_12_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_13) ? eDRAM_13_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_14) ? eDRAM_14_mem_data_i :
    (idx_o == CIM_Core_eDRAM_addr_map::eDRAM_15) ? eDRAM_15_mem_data_i :
    '0
) : '0;


endmodule
