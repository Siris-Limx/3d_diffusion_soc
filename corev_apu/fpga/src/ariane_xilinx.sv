// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Description: Xilinx FPGA top-level
// Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>

module ariane_xilinx (
// WARNING: Do not define input parameters. This causes the FPGA build to fail.
  input  logic         sys_clk     ,  // 外接时钟
  input  logic         cpu_resetn  ,  // cpu  复位信号
  input  logic         trst_n      ,  // JTAG 复位信号
    // LED for FPGA observer
    output logic        led         ,
    output logic        tck_led     ,
    // JTAG IO interface
  input  logic        tck         ,
  input  logic        tms         ,
  input  logic        tdi         ,
  output wire         tdo         ,
    // UART interface
  input  logic        rx          ,
  output logic        tx
  //AXI
  
);

// CVA6 config
localparam bit IsRVFI = bit'(0);
// CVA6 Xilinx configuration
localparam config_pkg::cva6_cfg_t CVA6Cfg = '{
  NrCommitPorts:         cva6_config_pkg::CVA6ConfigNrCommitPorts,
  AxiAddrWidth:          cva6_config_pkg::CVA6ConfigAxiAddrWidth,
  AxiDataWidth:          cva6_config_pkg::CVA6ConfigAxiDataWidth,
  AxiIdWidth:            cva6_config_pkg::CVA6ConfigAxiIdWidth,
  AxiUserWidth:          cva6_config_pkg::CVA6ConfigDataUserWidth,
  NrLoadBufEntries:      cva6_config_pkg::CVA6ConfigNrLoadBufEntries,
  RASDepth:              cva6_config_pkg::CVA6ConfigRASDepth,
  BTBEntries:            cva6_config_pkg::CVA6ConfigBTBEntries,
  BHTEntries:            cva6_config_pkg::CVA6ConfigBHTEntries,
  FpuEn:                 bit'(cva6_config_pkg::CVA6ConfigFpuEn),
  XF16:                  bit'(cva6_config_pkg::CVA6ConfigF16En),
  XF16ALT:               bit'(cva6_config_pkg::CVA6ConfigF16AltEn),
  XF8:                   bit'(cva6_config_pkg::CVA6ConfigF8En),
  RVA:                   bit'(cva6_config_pkg::CVA6ConfigAExtEn),
  RVV:                   bit'(cva6_config_pkg::CVA6ConfigVExtEn),
  RVC:                   bit'(cva6_config_pkg::CVA6ConfigCExtEn),
  RVZCB:                 bit'(cva6_config_pkg::CVA6ConfigZcbExtEn),
  XFVec:                 bit'(cva6_config_pkg::CVA6ConfigFVecEn),
  CvxifEn:               bit'(cva6_config_pkg::CVA6ConfigCvxifEn),
  ZiCondExtEn:           bit'(0),
  RVF:                   bit'(0),
  RVD:                   bit'(0),
  FpPresent:             bit'(0),
  NSX:                   bit'(0),
  FLen:                  unsigned'(0),
  RVFVec:                bit'(0),
  XF16Vec:               bit'(0),
  XF16ALTVec:            bit'(0),
  XF8Vec:                bit'(0),
  NrRgprPorts:           unsigned'(0),
  NrWbPorts:             unsigned'(0),
  EnableAccelerator:     bit'(0),
  RVS:                   bit'(1),
  RVU:                   bit'(1),
  HaltAddress:           dm::HaltAddress,
  ExceptionAddress:      dm::ExceptionAddress,
  DmBaseAddress:         ariane_soc::DebugBase,
  NrPMPEntries:          unsigned'(cva6_config_pkg::CVA6ConfigNrPMPEntries),
  NOCType:               config_pkg::NOC_TYPE_AXI4_ATOP,
  // idempotent region
  NrNonIdempotentRules:  unsigned'(1),
  NonIdempotentAddrBase: 1024'({64'b0}),
  NonIdempotentLength:   1024'({64'b0}),
  NrExecuteRegionRules:  unsigned'(3),
  ExecuteRegionAddrBase: 1024'({ariane_soc::Main_MemBase,   ariane_soc::ROMBase,   ariane_soc::DebugBase}),
  ExecuteRegionLength:   1024'({ariane_soc::Main_MemLength, ariane_soc::ROMLength, ariane_soc::DebugLength}),
  // cached region
  NrCachedRegionRules:   unsigned'(6),
  CachedRegionAddrBase:  1024'({ariane_soc::Main_MemBase,   ariane_soc::CIM_Core_regbusBase,   ariane_soc::CIM_Core_sramBase,   ariane_soc::CIM_Core_macroBase,   ariane_soc::CIM_Core_eDRAMBase,   ariane_soc::Top_CtrlBase }),
  CachedRegionLength:    1024'({ariane_soc::Main_MemLength, ariane_soc::CIM_Core_regbusLength, ariane_soc::CIM_Core_sramLength, ariane_soc::CIM_Core_macroLength, ariane_soc::CIM_Core_eDRAMLength, ariane_soc::Top_CtrlLength }),
  MaxOutstandingStores:  unsigned'(7),
  DebugEn: bit'(1),
  NonIdemPotenceEn: bit'(0),
  AxiBurstWriteEn: bit'(0)
};

localparam type rvfi_instr_t = logic;


// 24 MByte in 8 byte words
localparam NumWords = (1024) / 8;
localparam NBSlave = 2; // debug, ariane
localparam AxiAddrWidth = 64;
localparam AxiDataWidth = 64;
localparam AxiIdWidthMaster = 4;
localparam AxiIdWidthSlaves = AxiIdWidthMaster + $clog2(NBSlave); // 5
localparam AxiUserWidth = ariane_pkg::AXI_USER_WIDTH;

// localparam AxiIdWidthMaster_cim_core = 64;
// localparam AxiIdWidthSlaves_cim_core = 64;
localparam RegBusAddrWidth           = 64;
localparam RegBusDataWidth           = 32;
localparam SramMemAddrWidth          = 64;
localparam SramMemDataWidth          = 32;
localparam MacroMemAddrWidth         = 64;
localparam MacroMemDataWidth         = 32;
localparam MacroCalAddrWidth         = 64;
localparam MacroCalDataWidth         = 32;
localparam eDRAMMemAddrWidth         = 64;
localparam eDRAMMemDataWidth         = 32;

`AXI_TYPEDEF_ALL(axi_slave,
                 logic [    AxiAddrWidth-1:0],
                 logic [AxiIdWidthSlaves-1:0],
                 logic [    AxiDataWidth-1:0],
                 logic [(AxiDataWidth/8)-1:0],
                 logic [    AxiUserWidth-1:0])

(* DONT_TOUCH = "TRUE" *) AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_ID_WIDTH   ( AxiIdWidthMaster ),
    .AXI_USER_WIDTH ( AxiUserWidth     )
) slave[NBSlave-1:0]();

(* DONT_TOUCH = "TRUE" *) AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .AXI_USER_WIDTH ( AxiUserWidth     )
) master[ariane_soc::NB_PERIPHERALS-1:0]();


// disable test-enable
logic test_en;
logic ndmreset;
logic ndmreset_n;
logic debug_req_irq;
logic timer_irq;
logic ipi;
/////////////////////////////////////////////////////////////////////////////
///////////////////////// Clock and Reset////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// clk source form DCO, which is the sys_clk in this module
// the original clk in this model is converted by sys_clk to "ddr_clk_out"
// the ddr_clk_out is used to generate clk by the xlnx_clk_gen module
// the generated clk is used to drive the ariane_soc module
/////////////////////////////////////////////////////////////////////////////
// rst source form IO, which is the sys_rst in this module
// the original rst_n in this model is converted by sys_rst to "ddr_sync_reset"
// the rst_n is used to generate ndmreset by the dm_top
// the generated ndmreset is used to drive the ariane_soc module
/////////////////////////////////////////////////////////////////////////////

logic clk;
// logic eth_clk;
// logic spi_clk_i;
// logic phy_tx_clk;
// logic sd_clk_sys;

// logic ddr_sync_reset;
// logic ddr_clock_out;

logic cpu_reset;
assign cpu_reset  = ~cpu_resetn;

logic rst_n, rst;
logic rtc;


logic pll_locked;

// ROM
logic                    rom_req;
logic [AxiAddrWidth-1:0] rom_addr;
logic [AxiDataWidth-1:0] rom_rdata;

// Debug
logic          debug_req_valid;
logic          debug_req_ready;
dm::dmi_req_t  debug_req;
logic          debug_resp_valid;
logic          debug_resp_ready;
dm::dmi_resp_t debug_resp;

logic dmactive;

// IRQ
logic [1:0] irq;
assign test_en    = 1'b0;

logic [NBSlave-1:0] pc_asserted;

rstgen i_rstgen_main (
    .clk_i        ( clk                      ),
    .rst_ni       ( pll_locked & (~ndmreset) ),
    .test_mode_i  ( test_en                  ),
    .rst_no       ( ndmreset_n               ),
    .init_no      (                          ) // keep open
);

assign rst_n = cpu_resetn;
assign rst   = ~cpu_resetn;

// ---------------
// AXI Xbar
// ---------------

axi_pkg::xbar_rule_64_t [ariane_soc::NB_PERIPHERALS-1:0] addr_map;


assign addr_map = '{
  '{ idx: ariane_soc::Debug,    start_addr: ariane_soc::DebugBase,    end_addr: ariane_soc::DebugBase    + ariane_soc::DebugLength       },
  '{ idx: ariane_soc::ROM,      start_addr: ariane_soc::ROMBase,      end_addr: ariane_soc::ROMBase      + ariane_soc::ROMLength         },
  '{ idx: ariane_soc::CLINT,    start_addr: ariane_soc::CLINTBase,    end_addr: ariane_soc::CLINTBase    + ariane_soc::CLINTLength       },
  '{ idx: ariane_soc::PLIC,     start_addr: ariane_soc::PLICBase,     end_addr: ariane_soc::PLICBase     + ariane_soc::PLICLength        },
  '{ idx: ariane_soc::UART,     start_addr: ariane_soc::UARTBase,     end_addr: ariane_soc::UARTBase     + ariane_soc::UARTLength        },
  '{ idx: ariane_soc::Timer,    start_addr: ariane_soc::TimerBase,    end_addr: ariane_soc::TimerBase    + ariane_soc::TimerLength       },
  '{ idx: ariane_soc::CIM_Core_regbus, start_addr: ariane_soc::CIM_Core_regbusBase, end_addr: ariane_soc::CIM_Core_regbusBase + ariane_soc::CIM_Core_regbusLength  },
  '{ idx: ariane_soc::CIM_Core_sram,   start_addr: ariane_soc::CIM_Core_sramBase  , end_addr: ariane_soc::CIM_Core_sramBase   + ariane_soc::CIM_Core_sramLength    },
  '{ idx: ariane_soc::CIM_Core_macro,  start_addr: ariane_soc::CIM_Core_macroBase , end_addr: ariane_soc::CIM_Core_macroBase  + ariane_soc::CIM_Core_macroLength   },
  '{ idx: ariane_soc::CIM_Core_eDRAM,  start_addr: ariane_soc::CIM_Core_eDRAMBase , end_addr: ariane_soc::CIM_Core_eDRAMBase  + ariane_soc::CIM_Core_eDRAMLength   },
  '{ idx: ariane_soc::Top_Ctrl, start_addr: ariane_soc::Top_CtrlBase, end_addr: ariane_soc::Top_CtrlBase + ariane_soc::Top_CtrlLength    },
  '{ idx: ariane_soc::Main_Mem, start_addr: ariane_soc::Main_MemBase, end_addr: ariane_soc::Main_MemBase + ariane_soc::Main_MemLength    }
};


localparam axi_pkg::xbar_cfg_t AXI_XBAR_CFG = '{
  NoSlvPorts:         ariane_soc::NrSlaves,
  NoMstPorts:         ariane_soc::NB_PERIPHERALS,
  MaxMstTrans:        1, // Probably requires update
  MaxSlvTrans:        1, // Probably requires update
  FallThrough:        1'b0,
  LatencyMode:        axi_pkg::CUT_ALL_PORTS,
  AxiIdWidthSlvPorts: AxiIdWidthMaster,
  AxiIdUsedSlvPorts:  AxiIdWidthMaster,
  UniqueIds:          1'b0,
  AxiAddrWidth:       AxiAddrWidth,
  AxiDataWidth:       AxiDataWidth,
  NoAddrRules:        ariane_soc::NB_PERIPHERALS
};

(* DONT_TOUCH = "TRUE" *)  axi_xbar_intf #(
  .AXI_USER_WIDTH ( AxiUserWidth            ),
  .Cfg            ( AXI_XBAR_CFG            ),
  .rule_t         ( axi_pkg::xbar_rule_64_t )
) i_axi_xbar (
  .clk_i                 ( clk        ),
  .rst_ni                ( ndmreset_n ),
  .test_i                ( test_en    ),
  .slv_ports             ( slave      ),
  .mst_ports             ( master     ),
  .addr_map_i            ( addr_map   ),
  .en_default_mst_port_i ( '0         ),
  .default_mst_port_i    ( '0         )
);

// ---------------
// Debug Module
// ---------------
dmi_jtag i_dmi_jtag (
    .clk_i                ( clk                  ),
    .rst_ni               ( rst_n                ),
    .dmi_rst_no           (                      ), // keep open
    .testmode_i           ( test_en              ),
    .dmi_req_valid_o      ( debug_req_valid      ),
    .dmi_req_ready_i      ( debug_req_ready      ),
    .dmi_req_o            ( debug_req            ),
    .dmi_resp_valid_i     ( debug_resp_valid     ),
    .dmi_resp_ready_o     ( debug_resp_ready     ),
    .dmi_resp_i           ( debug_resp           ),
    .tck_i                ( tck    ),
    .tms_i                ( tms    ),
    .trst_ni              ( trst_n ),
    .td_i                 ( tdi    ),
    .td_o                 ( tdo    ),
    .tdo_oe_o             (        )
);

ariane_axi::req_t    dm_axi_m_req;
ariane_axi::resp_t   dm_axi_m_resp;


logic                      dm_slave_req;
logic                      dm_slave_we;
logic [riscv::XLEN-1:0]    dm_slave_addr;
logic [riscv::XLEN/8-1:0]  dm_slave_be;
logic [riscv::XLEN-1:0]    dm_slave_wdata;
logic [riscv::XLEN-1:0]    dm_slave_rdata;

logic                      dm_master_req;
logic [riscv::XLEN-1:0]    dm_master_add;
logic                      dm_master_we;
logic [riscv::XLEN-1:0]    dm_master_wdata;
logic [riscv::XLEN/8-1:0]  dm_master_be;
logic                      dm_master_gnt;
logic                      dm_master_r_valid;
logic [riscv::XLEN-1:0]    dm_master_r_rdata;

// debug module
dm_top #(
    .NrHarts          ( 1                 ),
    .BusWidth         ( riscv::XLEN      ),
    .SelectableHarts  ( 1'b1              )
) i_dm_top (
    .clk_i            ( clk               ),
    .rst_ni           ( rst_n             ), // PoR
    .testmode_i       ( test_en           ),
    .ndmreset_o       ( ndmreset          ),
    .dmactive_o       ( dmactive          ), // active debug session
    .debug_req_o      ( debug_req_irq     ),
    .unavailable_i    ( '0                ),
    .hartinfo_i       ( {ariane_pkg::DebugHartInfo} ),
    .slave_req_i      ( dm_slave_req      ),
    .slave_we_i       ( dm_slave_we       ),
    .slave_addr_i     ( dm_slave_addr     ),
    .slave_be_i       ( dm_slave_be       ),
    .slave_wdata_i    ( dm_slave_wdata    ),
    .slave_rdata_o    ( dm_slave_rdata    ),
    .master_req_o     ( dm_master_req     ),
    .master_add_o     ( dm_master_add     ),
    .master_we_o      ( dm_master_we      ),
    .master_wdata_o   ( dm_master_wdata   ),
    .master_be_o      ( dm_master_be      ),
    .master_gnt_i     ( dm_master_gnt     ),
    .master_r_valid_i ( dm_master_r_valid ),
    .master_r_rdata_i ( dm_master_r_rdata ),
    .dmi_rst_ni       ( rst_n             ),
    .dmi_req_valid_i  ( debug_req_valid   ),
    .dmi_req_ready_o  ( debug_req_ready   ),
    .dmi_req_i        ( debug_req         ),
    .dmi_resp_valid_o ( debug_resp_valid  ),
    .dmi_resp_ready_i ( debug_resp_ready  ),
    .dmi_resp_o       ( debug_resp        )
);

axi2mem #(
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves    ),
    .AXI_ADDR_WIDTH ( riscv::XLEN        ),
    .AXI_DATA_WIDTH ( riscv::XLEN        ),
    .AXI_USER_WIDTH ( AxiUserWidth        )
) i_dm_axi2mem (
    .clk_i      ( clk                       ),
    .rst_ni     ( rst_n                     ),
    .slave      ( master[ariane_soc::Debug]           ),
    .req_o      ( dm_slave_req              ),
    .we_o       ( dm_slave_we               ),
    .addr_o     ( dm_slave_addr             ),
    .be_o       ( dm_slave_be               ),
    .data_o     ( dm_slave_wdata            ),
    .data_i     ( dm_slave_rdata            )
);

logic [1:0]    axi_adapter_size;

assign axi_adapter_size = (riscv::XLEN == 64) ? 2'b11 : 2'b10;

axi_adapter #(
    .CVA6Cfg               ( CVA6Cfg                  ),
    .DATA_WIDTH            ( riscv::XLEN              ),
    .axi_req_t             ( ariane_axi::req_t        ),
    .axi_rsp_t             ( ariane_axi::resp_t       )
) i_dm_axi_master (
    .clk_i                 ( clk                       ),
    .rst_ni                ( rst_n                     ),
    .req_i                 ( dm_master_req             ),
    .type_i                ( ariane_pkg::SINGLE_REQ    ),
    .amo_i                 ( ariane_pkg::AMO_NONE      ),
    .gnt_o                 ( dm_master_gnt             ),
    .addr_i                ( dm_master_add             ),
    .we_i                  ( dm_master_we              ),
    .wdata_i               ( dm_master_wdata           ),
    .be_i                  ( dm_master_be              ),
    .size_i                ( axi_adapter_size          ),
    .id_i                  ( '0                        ),
    .valid_o               ( dm_master_r_valid         ),
    .rdata_o               ( dm_master_r_rdata         ),
    .id_o                  (                           ),
    .critical_word_o       (                           ),
    .critical_word_valid_o (                           ),
    .axi_req_o             ( dm_axi_m_req              ),
    .axi_resp_i            ( dm_axi_m_resp             )
);

    // 64 bit AXI Slave Debug (Slave[1])
    `AXI_ASSIGN_FROM_REQ(slave[1], dm_axi_m_req)
    `AXI_ASSIGN_TO_RESP(dm_axi_m_resp, slave[1])



// ---------------
// Core
// ---------------
ariane_axi::req_t    axi_ariane_req;
ariane_axi::resp_t   axi_ariane_resp;

ariane #(
    .CVA6Cfg ( CVA6Cfg ),
    .IsRVFI ( IsRVFI ),
    .rvfi_instr_t ( rvfi_instr_t )
) i_ariane (
    .clk_i        ( clk                 ),
    .rst_ni       ( ndmreset_n          ),
    .boot_addr_i  ( ariane_soc::ROMBase ), // start fetching from ROM
    .hart_id_i    ( '0                  ),
    .irq_i        ( irq                 ),
    .ipi_i        ( ipi                 ),
    .time_irq_i   ( timer_irq           ),
    .rvfi_o       ( /* open */          ),
    .debug_req_i  ( debug_req_irq       ),
    .noc_req_o    ( axi_ariane_req      ),
    .noc_resp_i   ( axi_ariane_resp     )
);

`AXI_ASSIGN_FROM_REQ(slave[0], axi_ariane_req)
`AXI_ASSIGN_TO_RESP(axi_ariane_resp, slave[0])

// ---------------
// CLINT
// ---------------
// divide clock by two
always_ff @(posedge clk or negedge ndmreset_n) begin
  if (~ndmreset_n) begin
    rtc <= 0;
  end else begin
    rtc <= rtc ^ 1'b1;
  end
end

axi_slave_req_t  axi_clint_req;
axi_slave_resp_t axi_clint_resp;

clint #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .NR_CORES       ( 1                ),
    .axi_req_t      ( axi_slave_req_t  ),
    .axi_resp_t     ( axi_slave_resp_t )
) i_clint (
    .clk_i       ( clk            ),
    .rst_ni      ( ndmreset_n     ),
    .testmode_i  ( test_en        ),
    .axi_req_i   ( axi_clint_req  ),
    .axi_resp_o  ( axi_clint_resp ),
    .rtc_i       ( rtc            ),
    .timer_irq_o ( timer_irq      ),
    .ipi_o       ( ipi            )
);

`AXI_ASSIGN_TO_REQ(axi_clint_req, master[ariane_soc::CLINT])
`AXI_ASSIGN_FROM_RESP(master[ariane_soc::CLINT], axi_clint_resp)

// ---------------
// ROM
// ---------------
axi2mem #(
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_USER_WIDTH ( AxiUserWidth     )
) i_axi2rom (
    .clk_i  ( clk                     ),
    .rst_ni ( ndmreset_n              ),
    .slave  ( master[ariane_soc::ROM] ),
    .req_o  ( rom_req                 ),
    .we_o   (                         ),
    .addr_o ( rom_addr                ),
    .be_o   (                         ),
    .data_o (                         ),
    .data_i ( rom_rdata               )
);


bootrom i_bootrom (
    .clk_i   ( clk       ),
    .req_i   ( rom_req   ),
    .addr_i  ( rom_addr  ),
    .rdata_o ( rom_rdata )
);
// end


ariane_peripherals #(
    .AxiAddrWidth ( AxiAddrWidth     ),
    .AxiDataWidth ( AxiDataWidth     ),
    .AxiIdWidth   ( AxiIdWidthSlaves ),
    .AxiUserWidth ( AxiUserWidth     ),
    .InclUART     ( 1'b1             )
) i_ariane_peripherals (
    .clk_i        ( clk                          ),
    .rst_ni       ( ndmreset_n                   ),
    .plic         ( master[ariane_soc::PLIC]     ),
    .uart         ( master[ariane_soc::UART]     ),
    .timer        ( master[ariane_soc::Timer]    ),
    .irq_o        ( irq                          ),
    .rx_i         ( rx                           ),
    .tx_o         ( tx                           )
);

AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .AXI_USER_WIDTH ( AxiUserWidth     )
) mainmem();

(* DONT_TOUCH = "TRUE" *)  axi_riscv_atomics_wrap #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .AXI_USER_WIDTH ( AxiUserWidth     ),
    .AXI_MAX_WRITE_TXNS ( 1  ),
    .RISCV_WORD_WIDTH   ( 64 )
) i_axi_riscv_atomics (
    .clk_i  ( clk                      ),
    .rst_ni ( ndmreset_n               ),
    .slv    ( master[ariane_soc::Main_Mem] ),
    .mst    ( mainmem                  )
);
// Add Main_Memory to the list of slaves
// Main_Mem
logic                    Main_Mem_req;
logic                    Main_Mem_wr;
logic [AxiAddrWidth/8-1:0] Main_Mem_be;

logic [AxiAddrWidth-1:0] Main_Mem_addr;
logic [AxiDataWidth-1:0] Main_Mem_rdata;
logic [AxiDataWidth-1:0] Main_Mem_wdata;

(* DONT_TOUCH = "TRUE" *)  axi2mem #(
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_USER_WIDTH ( AxiUserWidth     )
) i_axi2Main_Mem (
    .clk_i  ( clk                     ),
    .rst_ni ( ndmreset_n              ),
    .slave  ( mainmem                 ),
    .req_o  ( Main_Mem_req                 ),
    .we_o   ( Main_Mem_wr             ),
    .addr_o ( Main_Mem_addr           ),
    .be_o   ( Main_Mem_be             ),
    .data_o ( Main_Mem_wdata          ),
    .data_i ( Main_Mem_rdata          )
);

xlnx_bram_128x64 i_main_mem_sram(
    .clka  (clk         ),
    .ena   (Main_Mem_req         ),
    .wea   ({8{Main_Mem_wr}} & Main_Mem_be),
    .addra (Main_Mem_addr[$clog2(NumWords)-1+$clog2(AxiDataWidth/8):$clog2(AxiDataWidth/8)]),
    .dina  (Main_Mem_wdata       ),
    .douta (Main_Mem_rdata       )
);

// sram_sp_4096x32 #(
//     .ADDR_WIDTH ( 12 ),
//     .DATA_WIDTH ( 32 )
// ) i_sram_sp_4096x32 (
//     .Q          (   Main_Mem_rdata  ),
//     .CLK        (   clk             ),
//     .CEN        (   Main_Mem_req    ),
//     .GWEN       (   Main_Mem_wr     ),
//     .A          (   Main_Mem_addr   ),
//     .D          (   Main_Mem_wdata  ),
//     .STOV       (   1'b0        ), 
//     .EMA        (   3'b111      ),
//     .EMAW       (   2'b11       ),
//     .EMAS       (   1'b1        ),
//     .RET1N      (   1'b1        ),
//     .RAWL       (   1'b0        ),
//     .RAWLM      (   2'b0        ),
//     .WABL       (   1'b1        ),
//     .WABLM      (   3'b111      )
// );

// Add eDRAM to the list of slaves
// eDRAM
// logic                    eDRAM_req;
// logic                    eDRAM_wr;
// logic                    eDRAM_be;

// logic [AxiAddrWidth-1:0] eDRAM_addr;
// logic [AxiDataWidth-1:0] eDRAM_rdata;
// logic [AxiDataWidth-1:0] eDRAM_wdata;

// axi2mem #(
//     .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
//     .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
//     .AXI_DATA_WIDTH ( AxiDataWidth     ),
//     .AXI_USER_WIDTH ( AxiUserWidth     )
// ) i_axi2main_mem (
//     .clk_i  ( clk                     ),
//     .rst_ni ( ndmreset_n              ),
//     .slave  ( master[ariane_soc::eDRAM] ),
//     .req_o  ( eDRAM_req                 ),
//     .we_o   ( eDRAM_wr             ),
//     .addr_o ( eDRAM_addr           ),
//     .be_o   ( eDRAM_be             ),
//     .data_o ( eDRAM_wdata          ),
//     .data_i ( eDRAM_rdata          )
// );

// xlnx_bram_128x64 i_main_sram(
//     .clka  (clk         ),
//     .ena   (eDRAM_req         ),
//     .wea   ({8{eDRAM_wr}} & eDRAM_be),
//     .addra (eDRAM_addr[$clog2(NumWords)-1+$clog2(AxiDataWidth/8):$clog2(AxiDataWidth/8)]),
//     .dina  (eDRAM_wdata       ),
//     .douta (eDRAM_rdata       )
// );


// edram_sp_4096x32 #(
//     .ADDR_WIDTH ( 12 ),
//     .DATA_WIDTH ( 32 )
// ) i_edram_sp_4096x32 (
//     .Q          (   eDRAM_rdata  ),
//     .CLK        (   clk             ),
//     .CEN        (   eDRAM_req    ),
//     .GWEN       (   eDRAM_wr     ),
//     .A          (   eDRAM_addr   ),
//     .D          (   eDRAM_wdata  )
//     // .STOV       (   1'b0        ), 
//     // .EMA        (   3'b111      ),
//     // .EMAW       (   2'b11       ),
//     // .EMAS       (   1'b1        ),
//     // .RET1N      (   1'b1        ),
//     // .RAWL       (   1'b0        ),
//     // .RAWLM      (   2'b0        ),
//     // .WABL       (   1'b1        ),
//     // .WABLM      (   3'b111      )
// );

// Add CIM_Core to the list of slaves

// CIM_Core #(
//     .AxiAddrWidth ( AxiAddrWidth     ),
//     .AxiDataWidth ( AxiDataWidth     ),
//     .AxiIdWidth   ( AxiIdWidthSlaves ),
//     .AxiUserWidth ( AxiUserWidth     )
//     // .InclUART     ( 1'b1             )
// ) i_CIM_Core (
//     .clk_i           ( clk                          ),
//     .rst_ni          ( ndmreset_n                   ),
//     .cim_core_slave  ( master[ariane_soc::CIM_Core] )
//     // .cim_core_master ( slave[2]                     ),                       
// );


// axi_slave_req_t  axi_CIM_Core_req;
// axi_slave_resp_t axi_CIM_Core_resp;

// CIM_Core #(
//     .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
//     .AXI_DATA_WIDTH ( AxiDataWidth     ),
//     .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
//     .NR_CORES       ( 1                ),
//     .axi_req_t      ( axi_slave_req_t  ),
//     .axi_resp_t     ( axi_slave_resp_t )
// ) i_CIM_Core (
//     .clk_i       ( clk            ),
//     .rst_ni      ( ndmreset_n     ),
//     .testmode_i  ( test_en        ),
//     .axi_req_i   ( axi_CIM_Core_req  ),
//     .axi_resp_o  ( axi_CIM_Core_resp )
// );

// `AXI_ASSIGN_TO_REQ(axi_CIM_Core_req, master[ariane_soc::CIM_Core])
// `AXI_ASSIGN_FROM_RESP(master[ariane_soc::CIM_Core], axi_CIM_Core_resp)

(* DONT_TOUCH = "TRUE" *)  CIM_Core_wrapper #(
    .AxiAddrWidth           (   AxiAddrWidth        ),
    .AxiDataWidth           (   AxiDataWidth        ),
    .AxiMusterIdWidth       (   AxiIdWidthMaster    ),
    .AxiSlaverIdWidth       (   AxiIdWidthSlaves    ),
    .AxiUserWidth           (   AxiUserWidth        ),
    .RegBusAddrWidth        (   RegBusAddrWidth     ),
    .RegBusDataWidth        (   RegBusDataWidth     ),
    .SramMemAddrWidth       (   SramMemAddrWidth    ),
    .SramMemDataWidth       (   SramMemDataWidth    ),
    .MacroMemAddrWidth      (   MacroMemAddrWidth   ),
    .MacroMemDataWidth      (   MacroMemDataWidth   ),
    .MacroCalAddrWidth      (   MacroCalAddrWidth   ),
    .MacroCalDataWidth      (   MacroCalDataWidth   ),
    .eDRAMMemAddrWidth      (   eDRAMMemAddrWidth   ),
    .eDRAMMemDataWidth      (   eDRAMMemDataWidth   ),
    .NoRules                (   32'd0               ),
    .IdxWidth               (   4                   ),
    .rule_t                 (   axi_pkg::xbar_rule_64_t     ), 
    .axi_req_t              (   axi_slave_req_t     ), 
    .axi_rsp_t              (   axi_slave_resp_t    )
    
    // .CIM_Core_reg_req_t     ( CIM_Core_reg_req_t ),
    // .CIM_Core_reg_rsp_t     ( CIM_Core_reg_rsp_t )
) i_CIM_Core (
    .clk_i       ( clk            ),
    .rst_ni      ( ndmreset_n     ),
    .testmode_i  ( test_en        ),
    .CIM_Core_regbus    ( master[ariane_soc::CIM_Core_regbus]  ),
    .CIM_Core_sram      ( master[ariane_soc::CIM_Core_sram]    ),
    .CIM_Core_macro     ( master[ariane_soc::CIM_Core_macro]   ),
    .CIM_Core_eDRAM     ( master[ariane_soc::CIM_Core_eDRAM]   )
);


// Add Top_ctrl to the list of slaves
// Top_Ctrl #(
//     .AxiAddrWidth ( AxiAddrWidth     ),
//     .AxiDataWidth ( AxiDataWidth     ),
//     .AxiIdWidth   ( AxiIdWidthSlaves ),
//     .AxiUserWidth ( AxiUserWidth     )
//     // .InclUART     ( 1'b1             )
// ) i_Top_Ctrl (
//     .clk_i           ( clk                          ),
//     .rst_ni          ( ndmreset_n                   ),
//     .cim_core_slave  ( master[ariane_soc::Top_Ctrl] )
//     // .cim_core_master ( slave[2]                     ),                       
// );

////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
// Top_Ctrl is added here
////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////

// axi_slave_req_t  axi_Top_Ctrl_req;
// axi_slave_resp_t axi_Top_Ctrl_resp;

// Top_Ctrl #(
//     .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
//     .AXI_DATA_WIDTH ( AxiDataWidth     ),
//     .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
//     .NR_CORES       ( 1                ),
//     .axi_req_t      ( axi_slave_req_t  ),
//     .axi_resp_t     ( axi_slave_resp_t )
// ) i_Top_Ctrl (
//     .clk_i       ( clk            ),
//     .rst_ni      ( ndmreset_n     ),
//     .testmode_i  ( test_en        ),
//     .axi_req_i   ( axi_Top_Ctrl_req  ),
//     .axi_resp_o  ( axi_Top_Ctrl_resp )
// );

// `AXI_ASSIGN_TO_REQ(axi_Top_Ctrl_req, master[ariane_soc::Top_Ctrl])
// `AXI_ASSIGN_FROM_RESP(master[ariane_soc::Top_Ctrl], axi_Top_Ctrl_resp)


xlnx_clk_gen i_xlnx_clk_gen (
  .clk_out1 ( clk           ), // 50 MHz
  .reset    ( cpu_reset     ),
  .locked   ( pll_locked    ),
  .clk_in1  ( sys_clk )
);

// if we not use FPGA, we need to connect the clock to the DCO
// assign clk = sys_clk;
// assign pll_locked = cpu_reset;


logic [31:0] timer_cnt;
always @(posedge clk or negedge ndmreset_n)
begin
    if (!ndmreset_n)
    begin
        led <= 1'b0;
        timer_cnt <= 32'd0;
    end
    else if (timer_cnt == 32'd49_999_999)
    begin
        led <= ~led;
        timer_cnt <= 32'd0;
    end
    else
    begin
        led <= led;
        timer_cnt <= timer_cnt + 32'd1;
    end
end

logic [31:0] timer_cnt_tck;
always @(posedge tck or negedge ndmreset_n)
begin
    if (!ndmreset_n)
    begin
        tck_led <= 1'b0;
        timer_cnt_tck <= 32'd0;
    end
    else if (timer_cnt_tck == 32'd49_999_999)
    begin
        tck_led <= ~tck_led;
        timer_cnt_tck <= 32'd0;
    end
    else
    begin
        tck_led <= tck_led;
        timer_cnt_tck <= timer_cnt_tck + 32'd1;
    end
end

endmodule
