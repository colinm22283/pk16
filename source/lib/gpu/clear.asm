#once

#include "config.asm"

#bank rom
gpu_clear:
    imm a, pbus.internal.a
    imm b, 0
    wr  a, b
    adi a, 1
    imm b, gpu_width * gpu_height
    cmb b
    imm b, 0
    imm c, 0
    cma c

    imm d, .loop
    .loop:
        wrl a, b

        adi c, 1

        jlt d

    pop a
    jmp a