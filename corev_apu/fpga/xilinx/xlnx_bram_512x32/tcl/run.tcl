set partNumber $::env(XILINX_PART)
# set boardName  $::env(XILINX_BOARD)

set ipName xlnx_bram_512x32

create_project $ipName . -force -part $partNumber
# set_property board_part $boardName [current_project]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name $ipName

set_property -dict [list CONFIG.Write_Width_A {32} \
                        CONFIG.Write_Depth_A {512} \
                        CONFIG.Read_Width_A {32} \
                        CONFIG.Write_Width_B {32} \
                        CONFIG.Read_Width_B {32} \
                        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
                        CONFIG.Use_RSTA_Pin {false} \
                        CONFIG.Reset_Memory_Latch_A {false} \
                        CONFIG.EN_SAFETY_CKT {false} \
                        CONFIG.Register_PortA_Output_of_Memory_Primitives {false}] [get_ips $ipName]

generate_target {instantiation_template} [get_files ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 24 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1
