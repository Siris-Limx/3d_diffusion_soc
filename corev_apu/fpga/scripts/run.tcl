# Copyright 2018 ETH Zurich and University of Bologna.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>

# hard-coded to Genesys 2 for the moment

read_ip { \
      "xilinx/xlnx_clk_gen/xlnx_clk_gen.srcs/sources_1/ip/xlnx_clk_gen/xlnx_clk_gen.xci" \
      "xilinx/xlnx_bram_128x64/xlnx_bram_128x64.srcs/sources_1/ip/xlnx_bram_128x64/xlnx_bram_128x64.xci" \
      "xilinx/xlnx_bram_1024x32/xlnx_bram_1024x32.srcs/sources_1/ip/xlnx_bram_1024x32/xlnx_bram_1024x32.xci" \
      "xilinx/xlnx_bram_512x32/xlnx_bram_512x32.srcs/sources_1/ip/xlnx_bram_512x32/xlnx_bram_512x32.xci" \
      "xilinx/xlnx_bram_48x32/xlnx_bram_48x32.srcs/sources_1/ip/xlnx_bram_48x32/xlnx_bram_48x32.xci" \
}

set_property include_dirs { \
	"src/axi_sd_bridge/include" \
	"../../vendor/pulp-platform/common_cells/include" \
	"../../vendor/pulp-platform/axi/include" \
	"../../core/cache_subsystem/hpdcache/rtl/include" \
	"../register_interface/include" \
} [current_fileset]

source scripts/add_sources.tcl

set_property top ${project}_xilinx [current_fileset]

if {$::env(BOARD) eq "genesys2"} {
    read_verilog -sv {src/genesysii.svh ../../vendor/pulp-platform/common_cells/include/common_cells/registers.svh}
    set file "src/genesysii.svh"
    set registers "../../vendor/pulp-platform/common_cells/include/common_cells/registers.svh"
} elseif {$::env(BOARD) eq "kc705"} {
      read_verilog -sv {src/kc705.svh ../../vendor/pulp-platform/common_cells/include/common_cells/registers.svh}
      set file "src/kc705.svh"
      set registers "../../vendor/pulp-platform/common_cells/include/common_cells/registers.svh"
} elseif {$::env(BOARD) eq "vc707"} {
      read_verilog -sv {src/vc707.svh ../../vendor/pulp-platform/common_cells/include/common_cells/registers.svh}
      set file "src/vc707.svh"
      set registers "../../vendor/pulp-platform/common_cells/include/common_cells/registers.svh"
} else {
    exit 1
}

set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file" "$registers"]]
set_property -dict { file_type {Verilog Header} is_global_include 1} -objects $file_obj
# set_property IS_GLOBAL_INCLUDE 1 [get_files /home/sirisli/cva6/NPU_Code/1-rtl/COMMON/common.v]

update_compile_order -fileset sources_1

add_files -fileset constrs_1 -norecurse constraints/$project.xdc

synth_design -rtl -name rtl_1

set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING true [get_runs synth_1]

launch_runs -jobs 24 synth_1
wait_on_run synth_1
open_run synth_1

exec mkdir -p reports/
exec rm -rf reports/*

check_timing -verbose                                                   -file reports/$project.check_timing.rpt
report_timing -max_paths 100 -nworst 100 -delay_type max -sort_by slack -file reports/$project.timing_WORST_100.rpt
report_timing -nworst 1 -delay_type max -sort_by group                  -file reports/$project.timing.rpt
report_utilization -hierarchical                                        -file reports/$project.utilization.rpt
report_cdc                                                              -file reports/$project.cdc.rpt
report_clock_interaction                                                -file reports/$project.clock_interaction.rpt

# set for RuntimeOptimized implementation
set_property "steps.place_design.args.directive" "RuntimeOptimized" [get_runs impl_1]
set_property "steps.route_design.args.directive" "RuntimeOptimized" [get_runs impl_1]

launch_runs -jobs 24 impl_1
wait_on_run impl_1

open_run impl_1
set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
set_property IS_ENABLED 0 [get_drc_checks {CSCL-1}]
write_bitstream -force work-fpga/${project}.bit
write_debug_probes -force work-fpga/${project}.ltx

# launch_runs -jobs 24 impl_1 -to_step write_bitstream
# wait_on_run impl_1
# open_run impl_1

# output Verilog netlist + SDC for timing simulation
write_verilog -force -mode funcsim work-fpga/${project}_funcsim.v
write_verilog -force -mode timesim work-fpga/${project}_timesim.v
write_sdf     -force work-fpga/${project}_timesim.sdf

# reports
exec mkdir -p reports/
exec rm -rf reports/*
check_timing                                                              -file reports/${project}.check_timing.rpt
report_timing -max_paths 100 -nworst 100 -delay_type max -sort_by slack   -file reports/${project}.timing_WORST_100.rpt
report_timing -nworst 1 -delay_type max -sort_by group                    -file reports/${project}.timing.rpt
report_utilization -hierarchical                                          -file reports/${project}.utilization.rpt
