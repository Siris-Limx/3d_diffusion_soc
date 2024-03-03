## LED
set_property -dict {PACKAGE_PIN AM13 IOSTANDARD LVCMOS33} [get_ports led]
set_property -dict {PACKAGE_PIN AP12 IOSTANDARD LVCMOS33} [get_ports tck_led]

## Buttons
set_property -dict {PACKAGE_PIN AN12 IOSTANDARD LVCMOS33} [get_ports cpu_resetn]

## reset
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports trst_n]

## To use FTDI FT2232 JTAG
# set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { trst_n }];
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVCMOS33} [get_ports tck]
set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVCMOS33} [get_ports tdi]
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS33} [get_ports tdo]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports tms]

## UART
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports tx]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports rx]


## Fan Control
#set_property -dict { PACKAGE_PIN V21   IOSTANDARD LVCMOS33 } [get_ports { FAN_TACH }]; #IO_L22P_T3_A05_D21_14 Sch=fan_tac

# set_property -dict {PACKAGE_PIN AK15  IOSTANDARD LVCMOS18} [get_ports { eth_pme_b }]; #IO_L1N_T0_32 Sch=eth_pmeb
# set_property -dict {PACKAGE_PIN AK16  IOSTANDARD LVCMOS18} [get_ports { eth_int_b }]; #IO_L1P_T0_32 Sch=eth_intb

#############################################
# Ethernet Constraints for 1Gb/s
#############################################
# Modified for 125MHz receive clock
# create_clock -period 8.000 -name eth_rxck [get_ports eth_rxck]

# set_clock_groups -asynchronous -group [get_clocks eth_rxck -include_generated_clocks]
# set_clock_groups -asynchronous -group [get_clocks clk_out2_xlnx_clk_gen]

# Genesys 2 has a quad SPI flash
# set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

## JTAG
# minimize routing delay

set_max_delay -to [get_ports tdo] 20.000
set_max_delay -from [get_ports tms] 20.000
set_max_delay -from [get_ports tdi] 20.000
# set_max_delay -from [get_ports { trst_n } ] 20

# reset signal
# set_false_path -from [get_ports { trst_n } ]
# set_false_path -from [get_pins i_ddr/u_xlnx_mig_7_ddr3_mig/u_ddr3_infrastructure/rstdiv0_sync_r1_reg_rep/C]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets tck_IBUF_inst/O]



## Common Ariane XDCs

create_clock -period 100.000 -name tck -waveform {0.000 50.000} [get_ports tck]
set_input_jitter tck 1.000

# minimize routing delay
set_input_delay -clock tck -clock_fall 5.000 [get_ports tdi]
set_input_delay -clock tck -clock_fall 5.000 [get_ports tms]
set_output_delay -clock tck 5.000 [get_ports tdo]
#set_false_path   -from                    [get_ports trst_n ]


set_max_delay -datapath_only -from [get_pins i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_src/data_src_q_reg*/C] -to [get_pins i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_dst/data_dst_q_reg*/D] 20.000
set_max_delay -datapath_only -from [get_pins i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_src/req_src_q_reg/C] -to [get_pins i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_dst/req_dst_q_reg/D] 20.000
set_max_delay -datapath_only -from [get_pins i_dmi_jtag/i_dmi_cdc/i_cdc_req/i_dst/ack_dst_q_reg/C] -to [get_pins i_dmi_jtag/i_dmi_cdc/i_cdc_req/i_src/ack_src_q_reg/D] 20.000

# set multicycle path on reset, on the FPGA we do not care about the reset anyway
set_multicycle_path -from [get_pins {i_rstgen_main/i_rstgen_bypass/synch_regs_q_reg[3]/C}] 4
set_multicycle_path -hold -from [get_pins {i_rstgen_main/i_rstgen_bypass/synch_regs_q_reg[3]/C}] 3

set_property -dict {PACKAGE_PIN AL8 IOSTANDARD LVCMOS18} [get_ports sys_clk]
# create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]

set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
set_property IS_ENABLED 0 [get_drc_checks {CSCL-1}]
# write_bitstream -force /home/sirisli/cva6/ariane.bit

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 4 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[version][0]} {i_dm_top/i_dm_csrs/dmstatus[version][1]} {i_dm_top/i_dm_csrs/dmstatus[version][2]} {i_dm_top/i_dm_csrs/dmstatus[version][3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {i_dm_top/i_dm_csrs/haltreq_o[0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 9 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[zero1][23]} {i_dm_top/i_dm_csrs/dmstatus[zero1][24]} {i_dm_top/i_dm_csrs/dmstatus[zero1][25]} {i_dm_top/i_dm_csrs/dmstatus[zero1][26]} {i_dm_top/i_dm_csrs/dmstatus[zero1][27]} {i_dm_top/i_dm_csrs/dmstatus[zero1][28]} {i_dm_top/i_dm_csrs/dmstatus[zero1][29]} {i_dm_top/i_dm_csrs/dmstatus[zero1][30]} {i_dm_top/i_dm_csrs/dmstatus[zero1][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 2 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[zero0][20]} {i_dm_top/i_dm_csrs/dmstatus[zero0][21]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 2 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {i_dm_top/i_dm_csrs/dmi_req_i[op][0]} {i_dm_top/i_dm_csrs/dmi_req_i[op][1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {i_dm_top/i_dm_csrs/dmi_req_i[data][0]} {i_dm_top/i_dm_csrs/dmi_req_i[data][1]} {i_dm_top/i_dm_csrs/dmi_req_i[data][2]} {i_dm_top/i_dm_csrs/dmi_req_i[data][3]} {i_dm_top/i_dm_csrs/dmi_req_i[data][4]} {i_dm_top/i_dm_csrs/dmi_req_i[data][5]} {i_dm_top/i_dm_csrs/dmi_req_i[data][6]} {i_dm_top/i_dm_csrs/dmi_req_i[data][7]} {i_dm_top/i_dm_csrs/dmi_req_i[data][8]} {i_dm_top/i_dm_csrs/dmi_req_i[data][9]} {i_dm_top/i_dm_csrs/dmi_req_i[data][10]} {i_dm_top/i_dm_csrs/dmi_req_i[data][11]} {i_dm_top/i_dm_csrs/dmi_req_i[data][12]} {i_dm_top/i_dm_csrs/dmi_req_i[data][13]} {i_dm_top/i_dm_csrs/dmi_req_i[data][14]} {i_dm_top/i_dm_csrs/dmi_req_i[data][15]} {i_dm_top/i_dm_csrs/dmi_req_i[data][16]} {i_dm_top/i_dm_csrs/dmi_req_i[data][17]} {i_dm_top/i_dm_csrs/dmi_req_i[data][18]} {i_dm_top/i_dm_csrs/dmi_req_i[data][19]} {i_dm_top/i_dm_csrs/dmi_req_i[data][20]} {i_dm_top/i_dm_csrs/dmi_req_i[data][21]} {i_dm_top/i_dm_csrs/dmi_req_i[data][22]} {i_dm_top/i_dm_csrs/dmi_req_i[data][23]} {i_dm_top/i_dm_csrs/dmi_req_i[data][24]} {i_dm_top/i_dm_csrs/dmi_req_i[data][25]} {i_dm_top/i_dm_csrs/dmi_req_i[data][26]} {i_dm_top/i_dm_csrs/dmi_req_i[data][27]} {i_dm_top/i_dm_csrs/dmi_req_i[data][28]} {i_dm_top/i_dm_csrs/dmi_req_i[data][29]} {i_dm_top/i_dm_csrs/dmi_req_i[data][30]} {i_dm_top/i_dm_csrs/dmi_req_i[data][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 7 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {i_dm_top/i_dm_csrs/dmi_req_i[addr][0]} {i_dm_top/i_dm_csrs/dmi_req_i[addr][1]} {i_dm_top/i_dm_csrs/dmi_req_i[addr][2]} {i_dm_top/i_dm_csrs/dmi_req_i[addr][3]} {i_dm_top/i_dm_csrs/dmi_req_i[addr][4]} {i_dm_top/i_dm_csrs/dmi_req_i[addr][5]} {i_dm_top/i_dm_csrs/dmi_req_i[addr][6]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {timer_cnt_tck[0]} {timer_cnt_tck[1]} {timer_cnt_tck[2]} {timer_cnt_tck[3]} {timer_cnt_tck[4]} {timer_cnt_tck[5]} {timer_cnt_tck[6]} {timer_cnt_tck[7]} {timer_cnt_tck[8]} {timer_cnt_tck[9]} {timer_cnt_tck[10]} {timer_cnt_tck[11]} {timer_cnt_tck[12]} {timer_cnt_tck[13]} {timer_cnt_tck[14]} {timer_cnt_tck[15]} {timer_cnt_tck[16]} {timer_cnt_tck[17]} {timer_cnt_tck[18]} {timer_cnt_tck[19]} {timer_cnt_tck[20]} {timer_cnt_tck[21]} {timer_cnt_tck[22]} {timer_cnt_tck[23]} {timer_cnt_tck[24]} {timer_cnt_tck[25]} {timer_cnt_tck[26]} {timer_cnt_tck[27]} {timer_cnt_tck[28]} {timer_cnt_tck[29]} {timer_cnt_tck[30]} {timer_cnt_tck[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {timer_cnt[0]} {timer_cnt[1]} {timer_cnt[2]} {timer_cnt[3]} {timer_cnt[4]} {timer_cnt[5]} {timer_cnt[6]} {timer_cnt[7]} {timer_cnt[8]} {timer_cnt[9]} {timer_cnt[10]} {timer_cnt[11]} {timer_cnt[12]} {timer_cnt[13]} {timer_cnt[14]} {timer_cnt[15]} {timer_cnt[16]} {timer_cnt[17]} {timer_cnt[18]} {timer_cnt[19]} {timer_cnt[20]} {timer_cnt[21]} {timer_cnt[22]} {timer_cnt[23]} {timer_cnt[24]} {timer_cnt[25]} {timer_cnt[26]} {timer_cnt[27]} {timer_cnt[28]} {timer_cnt[29]} {timer_cnt[30]} {timer_cnt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[address][0]} {i_ariane/i_cva6/fetch_entry_if_id[address][1]} {i_ariane/i_cva6/fetch_entry_if_id[address][2]} {i_ariane/i_cva6/fetch_entry_if_id[address][3]} {i_ariane/i_cva6/fetch_entry_if_id[address][4]} {i_ariane/i_cva6/fetch_entry_if_id[address][5]} {i_ariane/i_cva6/fetch_entry_if_id[address][6]} {i_ariane/i_cva6/fetch_entry_if_id[address][7]} {i_ariane/i_cva6/fetch_entry_if_id[address][8]} {i_ariane/i_cva6/fetch_entry_if_id[address][9]} {i_ariane/i_cva6/fetch_entry_if_id[address][10]} {i_ariane/i_cva6/fetch_entry_if_id[address][11]} {i_ariane/i_cva6/fetch_entry_if_id[address][12]} {i_ariane/i_cva6/fetch_entry_if_id[address][13]} {i_ariane/i_cva6/fetch_entry_if_id[address][14]} {i_ariane/i_cva6/fetch_entry_if_id[address][15]} {i_ariane/i_cva6/fetch_entry_if_id[address][16]} {i_ariane/i_cva6/fetch_entry_if_id[address][17]} {i_ariane/i_cva6/fetch_entry_if_id[address][18]} {i_ariane/i_cva6/fetch_entry_if_id[address][19]} {i_ariane/i_cva6/fetch_entry_if_id[address][20]} {i_ariane/i_cva6/fetch_entry_if_id[address][21]} {i_ariane/i_cva6/fetch_entry_if_id[address][22]} {i_ariane/i_cva6/fetch_entry_if_id[address][23]} {i_ariane/i_cva6/fetch_entry_if_id[address][24]} {i_ariane/i_cva6/fetch_entry_if_id[address][25]} {i_ariane/i_cva6/fetch_entry_if_id[address][26]} {i_ariane/i_cva6/fetch_entry_if_id[address][27]} {i_ariane/i_cva6/fetch_entry_if_id[address][28]} {i_ariane/i_cva6/fetch_entry_if_id[address][29]} {i_ariane/i_cva6/fetch_entry_if_id[address][30]} {i_ariane/i_cva6/fetch_entry_if_id[address][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][0]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][1]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][2]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][3]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][4]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][5]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][6]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][7]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][8]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][9]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][10]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][11]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][12]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][13]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][14]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][15]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][16]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][17]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][18]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][19]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][20]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][21]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][22]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][23]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][24]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][25]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][26]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][27]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][28]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][29]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][30]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][predict_address][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 3 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][cf][0]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][cf][1]} {i_ariane/i_cva6/fetch_entry_if_id[branch_predict][cf][2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 32 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][0]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][1]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][2]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][3]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][4]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][5]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][6]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][7]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][8]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][9]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][10]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][11]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][12]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][13]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][14]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][15]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][16]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][17]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][18]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][19]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][20]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][21]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][22]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][23]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][24]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][25]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][26]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][27]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][28]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][29]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][30]} {i_ariane/i_cva6/fetch_entry_if_id[ex][cause][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[instruction][0]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][1]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][2]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][3]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][4]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][5]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][6]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][7]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][8]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][9]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][10]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][11]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][12]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][13]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][14]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][15]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][16]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][17]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][18]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][19]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][20]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][21]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][22]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][23]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][24]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][25]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][26]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][27]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][28]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][29]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][30]} {i_ariane/i_cva6/fetch_entry_if_id[instruction][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 32 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][0]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][1]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][2]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][3]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][4]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][5]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][6]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][7]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][8]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][9]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][10]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][11]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][12]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][13]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][14]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][15]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][16]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][17]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][18]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][19]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][20]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][21]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][22]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][23]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][24]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][25]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][26]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][27]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][28]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][29]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][30]} {i_ariane/i_cva6/fetch_entry_if_id[ex][tval][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list clk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list debug_req_irq]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list i_dm_top/i_dm_csrs/dmi_req_ready_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list i_dm_top/i_dm_csrs/dmi_req_valid_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[allhalted]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[allhavereset]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[allnonexistent]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[allresumeack]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[allrunning]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[allunavail]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[anyhalted]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[anyhavereset]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[anynonexistent]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[anyresumeack]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[anyrunning]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[anyunavail]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[authbusy]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[authenticated]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[devtreevalid]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[hasresethaltreq]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list {i_dm_top/i_dm_csrs/dmstatus[impebreak]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list {i_ariane/i_cva6/fetch_entry_if_id[ex][valid]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list i_ariane/i_cva6/fetch_valid_if_id]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list i_dm_top/i_dm_mem/halted_d]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list i_dm_top/i_dm_mem/halted_q]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
