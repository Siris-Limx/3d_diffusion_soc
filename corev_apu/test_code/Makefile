RISCV_GCC?=riscv64-unknown-elf-gcc
RISCV_OBJCOPY?=riscv64-unknown-elf-objcopy
RISCV_OBJDUMP?=riscv64-unknown-elf-objdump

all:
	rm -f test_code.d test_code.o
	$(RISCV_GCC) -mcmodel=medany -Wall -mexplicit-relocs -march=rv64im -mabi=lp64 -nostdlib -static -Tlinker.ld -ggdb -Wl,--no-gc-sections test_code.c -o test_code.o
	$(RISCV_OBJDUMP) -d test_code.o > test_code.d

# %.d: %.elf
# 	$(RISCV_OBJDUMP) -D $< > $@

# %.elf: %.c
# 	$(RISCV_GCC) -Os -ggdb -march=rv64im -mabi=lp64 -Wall -mcmodel=medany  -mexplicit-relocs $< -nostdlib -static -Wl,--no-gc-sections -o $@

clean:
	rm -f $(test_code)
