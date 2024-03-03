# board name for bitstream generation. This name is fake, the fpga chip we use is xczu15eg
BOARD          ?= genesys2
# root path
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
root-dir := $(dir $(mkfile_path))

# setting additional xilinx board parameters for the selected board
ifeq ($(BOARD), genesys2)
	XILINX_PART              := xczu15eg-ffvb1156-2-e
	XILINX_BOARD             := 
	CLK_PERIOD_NS            := 20
endif

ifndef CVA6_REPO_DIR
$(warning must set CVA6_REPO_DIR to point at the root of CVA6 sources -- doing it for you...)
export CVA6_REPO_DIR = $(abspath $(root-dir))
endif

# HPDcache directory
HPDCACHE_DIR ?= $(CVA6_REPO_DIR)/core/cache_subsystem/hpdcache
export HPDCACHE_DIR

# Target HPDcache configuration package.
#   The HPDCACHE_TARGET_CFG variable contains the path (relative or absolute)
#   to your target configuration package
HPDCACHE_TARGET_CFG ?= ${CVA6_REPO_DIR}/core/include/cva6_hpdcache_default_config_pkg.sv
export HPDCACHE_TARGET_CFG


# target takes one of the following cva6 hardware configuration:
# cv64a6_imafdc_sv39, cv32a6_imac_sv0, cv32a6_imac_sv32, cv32a6_imafc_sv32, cv32a6_ima_sv32_fpga
# Changing the default target to cv32a60x for Step1 verification
# target     ?= cv32a60x
target     ?= cv64a6_imafdc_sv39
ifndef TARGET_CFG
	export TARGET_CFG = $(target)
endif

# Sources
# Package files -> compile first
ariane_pkg := \
              corev_apu/tb/ariane_axi_pkg.sv                         \
              corev_apu/tb/axi_intf.sv                               \
              corev_apu/register_interface/src/reg_intf.sv           \
              corev_apu/tb/ariane_soc_pkg.sv                         \
              corev_apu/riscv-dbg/src/dm_pkg.sv                      \
              corev_apu/tb/ariane_axi_soc_pkg.sv
ariane_pkg := $(addprefix $(root-dir), $(ariane_pkg))

# Test packages
test_pkg := $(wildcard tb/test/*/*sequence_pkg.sv*) \
			$(wildcard tb/test/*/*_pkg.sv*)


# this list contains the standalone components
src :=  core/include/$(target)_config_pkg.sv                                         \
        corev_apu/src/ariane.sv                                                      \
        $(wildcard corev_apu/bootrom/*.sv)                                           \
        $(wildcard corev_apu/clint/*.sv)                                             \
        $(wildcard corev_apu/fpga/src/axi2apb/src/*.sv)                              \
        $(wildcard corev_apu/fpga/src/apb_timer/*.sv)                                \
        $(wildcard corev_apu/fpga/src/axi_slice/src/*.sv)                            \
        $(wildcard corev_apu/src/axi_riscv_atomics/src/*.sv)                         \
        $(wildcard corev_apu/axi_mem_if/src/*.sv)                                    \
        corev_apu/rv_plic/rtl/rv_plic_target.sv                                      \
        corev_apu/rv_plic/rtl/rv_plic_gateway.sv                                     \
        corev_apu/rv_plic/rtl/plic_regmap.sv                                         \
        corev_apu/rv_plic/rtl/plic_top.sv                                            \
        corev_apu/riscv-dbg/src/dmi_cdc.sv                                           \
        corev_apu/riscv-dbg/src/dmi_jtag.sv                                          \
        corev_apu/riscv-dbg/src/dmi_jtag_tap.sv                                      \
        corev_apu/riscv-dbg/src/dm_csrs.sv                                           \
        corev_apu/riscv-dbg/src/dm_mem.sv                                            \
        corev_apu/riscv-dbg/src/dm_sba.sv                                            \
        corev_apu/riscv-dbg/src/dm_top.sv                                            \
        corev_apu/riscv-dbg/debug_rom/debug_rom.sv                                   \
        corev_apu/register_interface/src/apb_to_reg.sv                               \
        corev_apu/register_interface/src/axi_to_reg.sv                               \
        corev_apu/register_interface/src/axi_lite_to_reg.sv                          \
        vendor/pulp-platform/axi/src/axi_multicut.sv                                 \
        vendor/pulp-platform/common_cells/src/rstgen_bypass.sv                       \
        vendor/pulp-platform/common_cells/src/rstgen.sv                              \
        vendor/pulp-platform/common_cells/src/addr_decode.sv                         \
		vendor/pulp-platform/common_cells/src/stream_register.sv                     \
        vendor/pulp-platform/axi/src/axi_cut.sv                                      \
        vendor/pulp-platform/axi/src/axi_join.sv                                     \
        vendor/pulp-platform/axi/src/axi_delayer.sv                                  \
        vendor/pulp-platform/axi/src/axi_to_axi_lite.sv                              \
        vendor/pulp-platform/axi/src/axi_id_prepend.sv                               \
        vendor/pulp-platform/axi/src/axi_atop_filter.sv                              \
        vendor/pulp-platform/axi/src/axi_err_slv.sv                                  \
        vendor/pulp-platform/axi/src/axi_mux.sv                                      \
        vendor/pulp-platform/axi/src/axi_demux.sv                                    \
        vendor/pulp-platform/axi/src/axi_xbar.sv                                     \
        vendor/pulp-platform/common_cells/src/cdc_2phase.sv                          \
        vendor/pulp-platform/common_cells/src/spill_register_flushable.sv            \
        vendor/pulp-platform/common_cells/src/spill_register.sv                      \
        vendor/pulp-platform/common_cells/src/deprecated/fifo_v1.sv                  \
        vendor/pulp-platform/common_cells/src/deprecated/fifo_v2.sv                  \
        vendor/pulp-platform/common_cells/src/stream_delay.sv                        \
        vendor/pulp-platform/common_cells/src/lfsr_16bit.sv                          \
        vendor/pulp-platform/tech_cells_generic/src/deprecated/cluster_clk_cells.sv  \
        vendor/pulp-platform/tech_cells_generic/src/deprecated/pulp_clk_cells.sv     \
        vendor/pulp-platform/tech_cells_generic/src/rtl/tc_clk.sv                    \
        corev_apu/tb/ariane_testharness.sv                                           \
        corev_apu/tb/ariane_peripherals.sv                                           \
        corev_apu/tb/rvfi_tracer.sv                                                  \
        corev_apu/tb/common/uart.sv                                                  \
        corev_apu/tb/common/SimDTM.sv                                                \
        corev_apu/tb/common/SimJTAG.sv
src := $(addprefix $(root-dir), $(src))

copro_src := core/cvxif_example/include/cvxif_instr_pkg.sv \
             $(wildcard core/cvxif_example/*.sv)
copro_src := $(addprefix $(root-dir), $(copro_src))

uart_src := $(wildcard corev_apu/fpga/src/apb_uart/src/*.vhd)
uart_src := $(addprefix $(root-dir), $(uart_src))

common_util_src := $(wildcard vendor/pulp-platform/common_cells/src/*.sv)
common_util_src := $(addprefix $(root-dir), $(common_util_src))

axi_src := $(wildcard vendor/pulp-platform/axi/src/*.sv)
axi_src := $(addprefix $(root-dir), $(axi_src))

fpga_src :=  $(wildcard corev_apu/bootrom/*.sv) $(wildcard corev_apu/fpga/src/*.sv) $(wildcard corev_apu/fpga/src/bootrom/*.sv) $(wildcard corev_apu/fpga/src/ariane-ethernet/*.sv) common/local/util/tc_sram_fpga_wrapper.sv vendor/pulp-platform/fpga-support/rtl/SyncSpRamBeNx64.sv
fpga_src := $(addprefix $(root-dir), $(fpga_src))

# npu_src := NPU_Code/1-rtl/COMMON/common.v NPU_Code/1-rtl/COMMON/sync_fifo.v $(wildcard NPU_Code/1-rtl/SYS/*.v) $(wildcard NPU_Code/1-rtl/CTRL/SYS/*.v) $(wildcard NPU_Code/1-rtl/CTRL/PE/*.v) $(wildcard NPU_Code/1-rtl/CTRL/MA/*.v) $(wildcard NPU_Code/1-rtl/PE/*.v) $(wildcard NPU_Code/1-rtl/MEM/*.v) $(wildcard NPU_Code/1-rtl/CIM_Model/*.v)
# npu_src := $(addprefix $(root-dir), $(npu_src))

cimcore_src :=  $(wildcard CIM_CORE/CIM_Core/*.sv)                                          \
                $(wildcard CIM_CORE/CIM_ctrl_logic/*.sv)                                    \
                $(wildcard CIM_CORE/CIM_ctrl_logic/CIM_ctrl_logic_multi_view_attn/*.sv)     \
                $(wildcard CIM_CORE/MEM/*.sv)                                               \
                $(wildcard CIM_CORE/CIM_Model/*.v)                                          \
                $(wildcard CIM_CORE/*.sv)                                          
cimcore_src := $(addprefix $(root-dir), $(cimcore_src))

topctrl_src :=  $(wildcard TOP_CTRL/Top_ctrl/*.sv)              \
                $(wildcard TOP_CTRL/ctrl_logic/*.sv)            \
                $(wildcard TOP_CTRL/MEM/*.sv)                   
topctrl_src := $(addprefix $(root-dir), $(topctrl_src))


src_flist = $(shell \
	    CVA6_REPO_DIR=$(CVA6_REPO_DIR) \
	    TARGET_CFG=$(TARGET_CFG) \
	    HPDCACHE_TARGET_CFG=$(HPDCACHE_TARGET_CFG) \
	    HPDCACHE_DIR=$(HPDCACHE_DIR) \
	    python3 util/flist_flattener.py core/Flist.cva6)
fpga_filter := $(addprefix $(root-dir), corev_apu/bootrom/bootrom.sv)
fpga_filter += $(addprefix $(root-dir), core/include/instr_tracer_pkg.sv)
fpga_filter += $(addprefix $(root-dir), src/util/ex_trace_item.sv)
fpga_filter += $(addprefix $(root-dir), src/util/instr_trace_item.sv)
fpga_filter += $(addprefix $(root-dir), common/local/util/instr_tracer_if.sv)
fpga_filter += $(addprefix $(root-dir), common/local/util/instr_tracer.sv)
fpga_filter += $(addprefix $(root-dir), vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv)
fpga_filter += $(addprefix $(root-dir), common/local/util/tc_sram_wrapper.sv)

fpga: $(ariane_pkg) $(src) $(fpga_src) $(uart_src) $(src_flist)
	@echo "[FPGA] Generate sources"
	@echo read_vhdl        {$(uart_src)}    > corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(ariane_pkg)} >> corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(filter-out $(fpga_filter), $(src_flist))}		>> corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(filter-out $(fpga_filter), $(src))} 	   >> corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(fpga_src)}   >> corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(cimcore_src)}   >> corev_apu/fpga/scripts/add_sources.tcl
	# @echo read_verilog -sv {$(topctrl_src)}   >> corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(common_util_src)}   >> corev_apu/fpga/scripts/add_sources.tcl
	@echo read_verilog -sv {$(axi_src)}   >> corev_apu/fpga/scripts/add_sources.tcl
	@echo "[FPGA] Generate Bitstream"
	cd corev_apu/fpga && make BOARD=$(BOARD) XILINX_PART=$(XILINX_PART) XILINX_BOARD=$(XILINX_BOARD) CLK_PERIOD_NS=$(CLK_PERIOD_NS)

.PHONY: fpga

clean:
	cd corev_apu/fpga && make clean && cd ../..

.PHONY:
	 clean
