module CIM_Core_reg_intf #(
    parameter int   AXI_ADDR_WIDTH    = -1,
    parameter int   AXI_DATA_WIDTH    = -1,
    parameter int   AXI_ID_WIDTH      = -1,
    parameter int   AXI_USER_WIDTH    = -1,
    parameter int   REG_BUS_ADDR_WIDTH  = -1,
    parameter int   REG_BUS_DATA_WIDTH  = -1
    // parameter type  reg_req_t           = logic,
    // parameter type  reg_rsp_t           = logic
)  (
    // clk and reset
    input   logic                           clk_i,
    input   logic                           rst_ni,
    // AXI bus interface
    AXI_BUS.Slave                           CIM_Core_Reg,
    // reg interface
    REG_BUS.out                             reg_bus_CIM_Core
    // output  reg_req_t                       reg_req_o,
    // input   reg_rsp_t                       reg_rsp_i
);

    

    logic         CIM_Core_penable;
    logic         CIM_Core_pwrite;
    logic [31:0]  CIM_Core_paddr;
    logic         CIM_Core_psel;
    logic [31:0]  CIM_Core_pwdata;
    logic [31:0]  CIM_Core_prdata;
    logic         CIM_Core_pready;
    logic         CIM_Core_pslverr;

(* DONT_TOUCH = "TRUE" *)      axi2apb_64_32 #(
        .AXI4_ADDRESS_WIDTH ( AXI_ADDR_WIDTH  ),
        .AXI4_RDATA_WIDTH   ( AXI_DATA_WIDTH  ),
        .AXI4_WDATA_WIDTH   ( AXI_DATA_WIDTH  ),
        .AXI4_ID_WIDTH      ( AXI_ID_WIDTH    ),
        .AXI4_USER_WIDTH    ( AXI_USER_WIDTH  ),
        .BUFF_DEPTH_SLAVE   ( 2             ),
        .APB_ADDR_WIDTH     ( 32            )
) i_axi2apb_64_32_cim_core_reg (
        .ACLK      ( clk_i          ),
        .ARESETn   ( rst_ni         ),
        .test_en_i ( 1'b0           ),
        .AWID_i    ( CIM_Core_Reg.aw_id     ),
        .AWADDR_i  ( CIM_Core_Reg.aw_addr   ),
        .AWLEN_i   ( CIM_Core_Reg.aw_len    ),
        .AWSIZE_i  ( CIM_Core_Reg.aw_size   ),
        .AWBURST_i ( CIM_Core_Reg.aw_burst  ),
        .AWLOCK_i  ( CIM_Core_Reg.aw_lock   ),
        .AWCACHE_i ( CIM_Core_Reg.aw_cache  ),
        .AWPROT_i  ( CIM_Core_Reg.aw_prot   ),
        .AWREGION_i( CIM_Core_Reg.aw_region ),
        .AWUSER_i  ( CIM_Core_Reg.aw_user   ),
        .AWQOS_i   ( CIM_Core_Reg.aw_qos    ),
        .AWVALID_i ( CIM_Core_Reg.aw_valid  ),
        .AWREADY_o ( CIM_Core_Reg.aw_ready  ),
        .WDATA_i   ( CIM_Core_Reg.w_data    ),
        .WSTRB_i   ( CIM_Core_Reg.w_strb    ),
        .WLAST_i   ( CIM_Core_Reg.w_last    ),
        .WUSER_i   ( CIM_Core_Reg.w_user    ),
        .WVALID_i  ( CIM_Core_Reg.w_valid   ),
        .WREADY_o  ( CIM_Core_Reg.w_ready   ),
        .BID_o     ( CIM_Core_Reg.b_id      ),
        .BRESP_o   ( CIM_Core_Reg.b_resp    ),
        .BVALID_o  ( CIM_Core_Reg.b_valid   ),
        .BUSER_o   ( CIM_Core_Reg.b_user    ),
        .BREADY_i  ( CIM_Core_Reg.b_ready   ),
        .ARID_i    ( CIM_Core_Reg.ar_id     ),
        .ARADDR_i  ( CIM_Core_Reg.ar_addr   ),
        .ARLEN_i   ( CIM_Core_Reg.ar_len    ),
        .ARSIZE_i  ( CIM_Core_Reg.ar_size   ),
        .ARBURST_i ( CIM_Core_Reg.ar_burst  ),
        .ARLOCK_i  ( CIM_Core_Reg.ar_lock   ),
        .ARCACHE_i ( CIM_Core_Reg.ar_cache  ),
        .ARPROT_i  ( CIM_Core_Reg.ar_prot   ),
        .ARREGION_i( CIM_Core_Reg.ar_region ),
        .ARUSER_i  ( CIM_Core_Reg.ar_user   ),
        .ARQOS_i   ( CIM_Core_Reg.ar_qos    ),
        .ARVALID_i ( CIM_Core_Reg.ar_valid  ),
        .ARREADY_o ( CIM_Core_Reg.ar_ready  ),
        .RID_o     ( CIM_Core_Reg.r_id      ),
        .RDATA_o   ( CIM_Core_Reg.r_data    ),
        .RRESP_o   ( CIM_Core_Reg.r_resp    ),
        .RLAST_o   ( CIM_Core_Reg.r_last    ),
        .RUSER_o   ( CIM_Core_Reg.r_user    ),
        .RVALID_o  ( CIM_Core_Reg.r_valid   ),
        .RREADY_i  ( CIM_Core_Reg.r_ready   ),
        .PENABLE   ( CIM_Core_penable   ),
        .PWRITE    ( CIM_Core_pwrite    ),
        .PADDR     ( CIM_Core_paddr     ),
        .PSEL      ( CIM_Core_psel      ),
        .PWDATA    ( CIM_Core_pwdata    ),
        .PRDATA    ( CIM_Core_prdata    ),
        .PREADY    ( CIM_Core_pready    ),
        .PSLVERR   ( CIM_Core_pslverr   )
    );

(* DONT_TOUCH = "TRUE" *)  apb_to_reg i_apb_to_reg (
        .clk_i     ( clk_i        ),
        .rst_ni    ( rst_ni       ),
        .penable_i ( CIM_Core_penable ),
        .pwrite_i  ( CIM_Core_pwrite  ),
        .paddr_i   ( CIM_Core_paddr   ),
        .psel_i    ( CIM_Core_psel    ),
        .pwdata_i  ( CIM_Core_pwdata  ),
        .prdata_o  ( CIM_Core_prdata  ),
        .pready_o  ( CIM_Core_pready  ),
        .pslverr_o ( CIM_Core_pslverr ),
        .reg_o     ( reg_bus_CIM_Core      )
    );

    // `REG_BUS_ASSIGN_TO_REQ(reg_req_o, reg_bus_CIM_Core)
    // `REG_BUS_ASSIGN_FROM_RSP(reg_bus_CIM_Core, reg_rsp_i)


endmodule