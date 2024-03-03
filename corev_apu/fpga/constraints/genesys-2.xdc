## Buttons
set_property -dict {PACKAGE_PIN AN12 IOSTANDARD LVCMOS33} [get_ports cpu_resetn]

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
set_property -dict {PACKAGE_PIN J10 IOSTANDARD LVCMOS33} [get_ports fan_pwm]
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
set_max_delay -from [get_ports { trst_n } ] 20

# reset signal
set_false_path -from [get_ports { trst_n } ]
# set_false_path -from [get_pins i_ddr/u_xlnx_mig_7_ddr3_mig/u_ddr3_infrastructure/rstdiv0_sync_r1_reg_rep/C]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets tck_IBUF]

