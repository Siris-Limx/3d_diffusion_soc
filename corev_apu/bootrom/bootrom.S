.section .text.start, "ax", @progbits
.globl _start
_start:
# bootrom.sv need to be functional in 64 and 32 bits,
# li s0, DRAM_BASE creates instructions not compatible with both
# versions. That's why we have replaced it by li and slli instructions
# to generates code compatible with both versions.
  li sp, 0x80000200
  li s0, 1
  slli s0, s0, 31
  jr s0

.section .text.hang, "ax", @progbits
.globl _hang
_hang:
  j _start
