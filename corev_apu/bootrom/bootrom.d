
bootrom.elf:     file format elf64-littleriscv


Disassembly of section .text.start:

0000000000010000 <_start>:
   10000:	0010011b          	addw	sp,zero,1
   10004:	01f11113          	sll	sp,sp,0x1f
   10008:	20010113          	add	sp,sp,512
   1000c:	00100413          	li	s0,1
   10010:	01f41413          	sll	s0,s0,0x1f
   10014:	00040067          	jr	s0

Disassembly of section .text.hang:

0000000000010040 <_hang>:
   10040:	fc1ff06f          	j	10000 <ROM_BASE>
