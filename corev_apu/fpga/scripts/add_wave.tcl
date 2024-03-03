# launch_runs synth_1 -jobs 24

set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse /home/sirisli/soc_code_yqjing/tb/top_tb.sv
set_property top top_tb [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -mode post-synthesis -type functional

add_wave {{/top_tb/u_ariane_xilinx/i_ariane/i_cva6/i_frontend/\fetch_entry_o[address] }} 
add_wave {{/top_tb/u_ariane_xilinx/i_ariane/i_cva6/i_frontend/\fetch_entry_o[instruction] }} 
add_wave {{/top_tb/u_ariane_xilinx/i_ariane/i_cva6/i_frontend/fetch_entry_valid_o}} 
# add slv[0] -- the cva6 axi_xbar intf
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.ar_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.ar_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.ar_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.aw_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.aw_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.aw_valid }} 

add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.b_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.b_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.r_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.r_resp }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.r_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.w_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.w_last }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.w_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\slv_ports[0]\.w_valid }} 


# add mst[0] -- the Main_Mem axi_xbar intf
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[0]\.ar_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[0]\.ar_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[0]\.ar_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[0]\.aw_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[0]\.aw_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[0]\.aw_valid }} 

# add mst[1-4] -- the CIM_Core axi_xbar intf
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.ar_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.ar_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.ar_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.aw_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.aw_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.aw_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.b_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.b_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.r_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.r_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.r_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.w_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.w_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[1]\.w_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.ar_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.ar_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.ar_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.aw_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.aw_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.aw_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.b_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.b_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.r_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.r_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.r_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.w_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.w_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[2]\.w_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.ar_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.ar_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.ar_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.aw_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.aw_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.aw_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.b_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.b_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.r_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.r_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.r_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.w_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.w_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[3]\.w_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.ar_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.ar_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.ar_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.aw_addr }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.aw_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.aw_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.b_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.b_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.r_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.r_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.r_valid }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.w_data }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.w_ready }} 
add_wave {{/top_tb/u_ariane_xilinx/i_axi_xbar/\mst_ports[4]\.w_valid }} 



# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[aw][id] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[aw][addr] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[aw_valid] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[aw_ready] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[w][data] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[w][strb] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[w_valid] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[w_ready] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[b][id] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[b_valid] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[b_ready] }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.aw_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.aw_addr }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.aw_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.aw_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.w_data }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.w_strb }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.w_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.w_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.b_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.b_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.b_ready }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.aw_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.aw_addr }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.aw_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.aw_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.w_data }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.w_strb }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.w_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.w_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.b_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.b_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.b_ready }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.aw_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.aw_addr }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.aw_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.aw_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.w_data }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.w_strb }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.w_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.w_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.b_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.b_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.b_ready }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[ar][id] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[ar][addr] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[ar][len] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[ar_valid] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[ar_ready] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[r][id] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[r][data] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[r][last] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_resp_i[r_valid] }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_ariane/\noc_req_o[r_ready] }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.ar_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.ar_addr }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.ar_len }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.ar_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.ar_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.r_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.r_data }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.r_last }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.r_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_riscv_atomics/\slv\.r_ready }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.ar_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.ar_addr }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.ar_len }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.ar_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.ar_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.r_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.r_data }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.r_last }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.r_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi_dw_converter_npu/\slv\.r_ready }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/clk_i}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.ar_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.ar_addr }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.ar_len }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.ar_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.ar_ready }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.r_id }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.r_data }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.r_last }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.r_valid }} 
# add_wave {{/top_tb/u_ariane_xilinx/i_axi2mem_npu/\slave\.r_ready }} 

# add_wave {{/top_tb/u_ariane_xilinx/i_sram/clka}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_sram/ena}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_sram/wea}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_sram/addra}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_sram/dina}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_sram/douta}} 

# add_wave {{/top_tb/u_ariane_xilinx/i_npu/clk}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/ahb_load_en}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/ahb_store_en}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/ahb_ldst_addr}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/ahb_store_data}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/ahb_load_data}} 

# add_wave {{/top_tb/u_ariane_xilinx/i_npu/ACLK}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_AWADDR}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_AWVALID}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_AWREADY}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_WDATA}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_WVALID}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_WREADY}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_BVALID}} 
# add_wave {{/top_tb/u_ariane_xilinx/i_npu/S_AXI_BREADY}} 

restart
run 30 us