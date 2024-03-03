module CIM_Core_mem_ctrl_demux #(
    parameter MEM_ADDR_WIDTH	= -1,
	  parameter MEM_DATA_WIDTH	= -1
)  (
    input   logic                           clk_i,
    input   logic                           rst_ni,
  // MUX ctrl reg
    input  logic 							              csr_CIM_Core_mem_mux_i,	
  // AXI to mem interface
    input  logic 							              CIM_Core_axi_mem_req_i,
    input  logic 							              CIM_Core_axi_mem_we_i,
    input  logic 	[MEM_ADDR_WIDTH-1:0]	    CIM_Core_axi_mem_addr_i,
    input  logic 	[MEM_DATA_WIDTH/8-1:0]	  CIM_Core_axi_mem_be_i,
    input  logic 	[MEM_DATA_WIDTH-1:0]	    CIM_Core_axi_mem_wdata_i,
    output logic 	[MEM_DATA_WIDTH-1:0]	    CIM_Core_axi_mem_rdata_o,
    // CIM ctrl to  mem interface
    input  logic 							              CIM_Core_ctrl_mem_req_i,
    input  logic 							              CIM_Core_ctrl_mem_we_i,
    input  logic 	[MEM_ADDR_WIDTH-1:0]	    CIM_Core_ctrl_mem_addr_i,
    input  logic 	[MEM_DATA_WIDTH/8-1:0]	  CIM_Core_ctrl_mem_be_i,
    input  logic 	[MEM_DATA_WIDTH-1:0]	    CIM_Core_ctrl_mem_wdata_i,
    output logic 	[MEM_DATA_WIDTH-1:0]	    CIM_Core_ctrl_mem_rdata_o,
    // mem output ctrl interface
    output logic                         	  CIM_CORE_mem_req_o,
    output logic                         	  CIM_CORE_mem_we_o,
    output logic  [MEM_ADDR_WIDTH-1:0]   	  CIM_CORE_mem_addr_o,
    output logic  [MEM_DATA_WIDTH/8-1:0] 	  CIM_CORE_mem_be_o,
    output logic  [MEM_DATA_WIDTH-1:0]   	  CIM_CORE_mem_data_o,
    input  logic  [MEM_DATA_WIDTH-1:0]   	  CIM_CORE_mem_data_i
);

// write direction selection
assign CIM_CORE_mem_req_o = csr_CIM_Core_mem_mux_i ? CIM_Core_axi_mem_req_i   : CIM_Core_ctrl_mem_req_i;
assign CIM_CORE_mem_we_o  = csr_CIM_Core_mem_mux_i ? CIM_Core_axi_mem_we_i    : CIM_Core_ctrl_mem_we_i;
assign CIM_CORE_mem_addr_o= csr_CIM_Core_mem_mux_i ? CIM_Core_axi_mem_addr_i  : CIM_Core_ctrl_mem_addr_i;
assign CIM_CORE_mem_be_o  = csr_CIM_Core_mem_mux_i ? CIM_Core_axi_mem_be_i    : CIM_Core_ctrl_mem_be_i;
assign CIM_CORE_mem_data_o= csr_CIM_Core_mem_mux_i ? CIM_Core_axi_mem_wdata_i : CIM_Core_ctrl_mem_wdata_i;
// read direction selection
//     always_ff @(posedge clk_i or negedge rst_ni) begin
// 	if(~rst_ni) begin
// 		CIM_Core_axi_mem_rdata_o <= 0;
// 		CIM_Core_ctrl_mem_rdata_o <= 0;
// 	end
// 	else if(csr_CIM_Core_mem_mux_i) begin
// 		CIM_Core_axi_mem_rdata_o <= CIM_CORE_mem_data_i;
// 	end
// 	else begin
// 		CIM_Core_ctrl_mem_rdata_o <= CIM_CORE_mem_data_i;
// 	end
// end

assign CIM_Core_axi_mem_rdata_o = csr_CIM_Core_mem_mux_i ? CIM_CORE_mem_data_i : 0;
assign CIM_Core_ctrl_mem_rdata_o = csr_CIM_Core_mem_mux_i ? 0 : CIM_CORE_mem_data_i;

endmodule
