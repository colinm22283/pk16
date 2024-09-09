#include "arch/rules.asm"

#addr 0
entry:
    imm r0, 0
    imm r1, 10

    cal.l callable


#addr 120
callable:
    imm r3, 1023

    ret
