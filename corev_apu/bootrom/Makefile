bootrom_img = bootrom.img bootrom.sv bootrom.d

RISCV_GCC?=riscv64-unknown-elf-gcc
RISCV_OBJCOPY?=riscv64-unknown-elf-objcopy
RISCV_OBJDUMP?=riscv64-unknown-elf-objdump
PYTHON=python

all: $(bootrom_img)

%.d: %.elf
	$(RISCV_OBJDUMP) -d $< > $@

%.img: %.bin
	dd if=$< of=$@ bs=128

%.bin: %.elf
	$(RISCV_OBJCOPY) -O binary $< $@

%.elf: %.S linker.ld
	$(RISCV_GCC) -Tlinker.ld -Os -ggdb -march=rv64im -mabi=lp64 -Wall -mcmodel=medany -mexplicit-relocs $< -nostdlib -static -Wl,--no-gc-sections -o $@
# $(RISCV_GCC) -Tlinker.ld -march=rv32i -mabi=ilp32 $< -nostdlib -static -Wl,--no-gc-sections -o $@

%.sv: %.img
	$(PYTHON) ./gen_rom.py $<

clean:
	rm -f $(bootrom_img)
