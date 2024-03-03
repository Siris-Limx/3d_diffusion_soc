#include <stdint.h>

void func()
{
    __asm__ volatile(
    "li a1, 0x111;"
    "li a2, 0x222;"
    "li a3, 0x333;"
    "li a4, 0x444;"
    "li a5, 0x555;"
    "li a6, 0x666;"
    "li a7, 0x777;"
    "li a0, 1;"
    "sll a0, a0, 0x1f;"
    "add a0, a0, 256;"
    "sw a1, 0(a0);"
    "sw a2, 4(a0);"
    "sw a3, 8(a0);"
    "lw t0, 0(a0);"
    "lw t1, 4(a0);"
    "lw t2, 8(a0);"
    "lui a0, 0x20000;"
    "sw a1, 0(a0);"
    "sw a2, 80(a0);"
    "sw a3, 84(a0);"
    "sw a4, 88(a0);"
    "lw s2, 0(a0);"
    "lui a0, 0x28000;"
    "sw a1, 0(a0);"
    "sw a2, 32(a0);"
    "sw a3, 8(a0);"
    "lw s3, 8(a0);"
    "lw s4, 32(a0);"
    "lui a0, 0x50000;"
    "sw a1, 0(a0);"
    "sw a2, 32(a0);"
    "sw a3, 8(a0);"
    "lw s5, 8(a0);"
    "lw s6, 32(a0);"
    "lui a0, 0x56000;"
    "sw a1, 0(a0);"
    "sw a2, 32(a0);"
    "sw a3, 128(a0);"
    "lw s7, 128(a0);"
    "lw s8, 0(a0);"
    "lui a0, 0x32800;"
    "sw a7, 64(a0);"
    "lw s9, 64(a0);"
    // "lui a0, 0x40004;"
    // "sw a3, 0(a0);"
    // "sw a4, 4(a0);"
    // "lw s4, 0(a0);"
    // "lw s5, 4(a0);"
    // "lui a0, 0x4000c;"
    // "sw a5, 0(a0);"
    // "sw a6, 4(a0);"
    // "lw s6, 0(a0);"
    // "lw s7, 4(a0);"
    // "lui a0, 0x40010;"
    // "sw a7, 0(a0);"
    // "sw a6, 4(a0);"
    // "lw s8, 0(a0);"
    // "lw s9, 4(a0);"
    // "lui a0, 0x40040;"
    // "add a0, a0, -4;"
    // "sw a0, 0(a0);"
    // "lw s10, 0(a0);"

    // "lui a0, 0x40100;"
    // "sw a3, 0(a0);"
    // "sw a4, 4(a0);"
    // "lui a0, 0x40200;"
    // "sw a5, 0(a0);"
    // "sw a6, 4(a0);"
    // "lui a0, 0x41000;"
    // "addi a0, a0, -256;"
    // "sw a7, 0(a0);"
    // "lui a0,0x8010;"
    );

    // // 假设我们要读写的地址是0x1000
    // uint32_t* ptr = (uint32_t*)(0x30000000);
    // uint32_t* ptr1 = (uint32_t*)0x30000000;
    // uint32_t* ptr2 = (uint32_t*)0x40100000;
    // uint32_t* ptr3 = (uint32_t*)0x40100004;
    // uint32_t* ptr4 = (uint32_t*)0x40200000;
    // uint32_t* ptr5 = (uint32_t*)0x40200004;
    // uint32_t* ptr6 = (uint32_t*)0x40400000;
    // uint32_t* ptr7 = (uint32_t*)0x40ffff00;

    // // 写入一个值
    // *ptr = 0xfc1ff06f;

    // // 读取值
    // uint32_t value = *ptr;
}