// Do not edit - auto-generated
module CIM_Core_regs #(
  parameter type reg_req_t  = logic,
  parameter type reg_rsp_t  = logic
)(
  input logic [0:0][0:0] csr_CIM_Core_mem_mux_i,
  output logic [0:0][0:0] csr_CIM_Core_mem_mux_o,
  output logic [0:0] csr_CIM_Core_mem_mux_we_o,
  output logic [0:0] csr_CIM_Core_mem_mux_re_o,
  input logic [0:0][15:0] test_2_i,
  output logic [0:0][15:0] test_2_o,
  output logic [0:0] test_2_we_o,
  output logic [0:0] test_2_re_o,
  input logic [0:0][3:0] test_3_i,
  output logic [0:0][3:0] test_3_o,
  output logic [0:0] test_3_we_o,
  output logic [0:0] test_3_re_o,
  input logic [0:0][23:0] test_4_i,
  output logic [0:0][23:0] test_4_o,
  output logic [0:0] test_4_we_o,
  output logic [0:0] test_4_re_o,
  // Bus Interface
  input  reg_req_t req_i,
  output reg_rsp_t resp_o
);
always_comb begin
  resp_o.ready = 1'b1;
  resp_o.rdata = '0;
  resp_o.error = '0;
  csr_CIM_Core_mem_mux_o = '0;
  csr_CIM_Core_mem_mux_we_o = '0;
  csr_CIM_Core_mem_mux_re_o = '0;
  test_2_o = '0;
  test_2_we_o = '0;
  test_2_re_o = '0;
  test_3_o = '0;
  test_3_we_o = '0;
  test_3_re_o = '0;
  test_4_o = '0;
  test_4_we_o = '0;
  test_4_re_o = '0;
  if (req_i.valid) begin
    if (req_i.write) begin
      unique case(req_i.addr)
        32'h20000000: begin
          csr_CIM_Core_mem_mux_o[0][0:0] = req_i.wdata[0:0];
          csr_CIM_Core_mem_mux_we_o[0] = 1'b1;
        end
        32'h20000050: begin
          test_2_o[0][15:0] = req_i.wdata[15:0];
          test_2_we_o[0] = 1'b1;
        end
        32'h20000054: begin
          test_3_o[0][3:0] = req_i.wdata[3:0];
          test_3_we_o[0] = 1'b1;
        end
        32'h20000058: begin
          test_4_o[0][23:0] = req_i.wdata[23:0];
          test_4_we_o[0] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end else begin
      unique case(req_i.addr)
        32'h20000000: begin
          resp_o.rdata[0:0] = csr_CIM_Core_mem_mux_i[0][0:0];
          csr_CIM_Core_mem_mux_re_o[0] = 1'b1;
        end
        32'h20000050: begin
          resp_o.rdata[15:0] = test_2_i[0][15:0];
          test_2_re_o[0] = 1'b1;
        end
        32'h20000054: begin
          resp_o.rdata[3:0] = test_3_i[0][3:0];
          test_3_re_o[0] = 1'b1;
        end
        32'h20000058: begin
          resp_o.rdata[23:0] = test_4_i[0][23:0];
          test_4_re_o[0] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end
  end
end
endmodule