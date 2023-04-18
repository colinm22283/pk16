#once

#include "/lib/ps2/read.asm"

main:
    psh pbus.ps2.a
    imm a, ps2_read
    cal a
    ppl b
    imu b, 0

    ; return
    pop a
    jmp a