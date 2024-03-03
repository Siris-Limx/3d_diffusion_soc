set partNumber $::env(XILINX_PART)
# set boardName  $::env(XILINX_BOARD)

set ipName xlnx_bram_128x64

create_project $ipName . -force -part $partNumber
# set_property board_part $boardName [current_project]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name $ipName

set_property -dict [list CONFIG.Use_Byte_Write_Enable {true} \
                        CONFIG.Byte_Size {8} \
                        CONFIG.Write_Width_A {64} \
                        CONFIG.Write_Depth_A {128} \
                        CONFIG.Read_Width_A {64} \
                        CONFIG.Write_Width_B {64} \
                        CONFIG.Read_Width_B {64} \
                        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
                        CONFIG.Use_RSTA_Pin {false} \
                        CONFIG.Reset_Memory_Latch_A {false} \
                        CONFIG.EN_SAFETY_CKT {false} \
                        CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
                        CONFIG.Load_Init_File {true} \
                        CONFIG.Coe_File {/home/sirisli/soc_code_yqjing/corev_apu/fpga/xilinx/xlnx_bram_128x64/init/bram_128x64_init.coe} \
                        CONFIG.Fill_Remaining_Memory_Locations {true}] [get_ips $ipName]

generate_target {instantiation_template} [get_files ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 24 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1
