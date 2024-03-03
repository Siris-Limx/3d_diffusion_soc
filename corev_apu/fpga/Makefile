VIVADO ?= vivado
VIVADOFLAGS ?= -nojournal -mode batch -source scripts/prologue.tcl

work-dir := work-fpga
bit := $(work-dir)/ariane_xilinx.bit
mcs := $(work-dir)/ariane_xilinx.mcs
ip-dir := xilinx
ips := xlnx_clk_gen.xci \
	xlnx_bram_128x64.xci \
	xlnx_bram_1024x32.xci \
	xlnx_bram_512x32.xci \
	xlnx_bram_48x32.xci

ips := $(addprefix $(work-dir)/, $(ips))
ips-target := $(join $(addsuffix /ip/, $(addprefix $(ip-dir)/, $(basename $(ips)))), $(ips))

all: $(bit)

$(bit): $(ips)
	mkdir -p $(work-dir)
	$(VIVADO) $(VIVADOFLAGS) -source scripts/run.tcl
	cp ariane.runs/impl_1/ariane_xilinx* ./$(work-dir)

$(ips): %.xci :
	mkdir -p $(work-dir)
	@echo Generating $(@F)
	@cd $(ip-dir)/$(basename $(@F)) && make clean && make
	@cp $(ip-dir)/$(basename $(@F))/$(basename $(@F)).srcs/sources_1/ip/$(basename $(@F))/$(@F) $@

mcs: $(mcs)

program:
	$(VIVADO) $(VIVADOFLAGS) -source scripts/program.tcl

clean:
	rm -rf *.log *.jou *.str *.mif *.xpr $(work-dir) ariane.cache ariane.hw ariane.ip_user_files scripts/vivado*

.PHONY:
	clean
