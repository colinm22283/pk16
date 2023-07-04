#once

#include "config.asm"

#bank rom
; a: color
gpu_clear:
    mov c, a
    imm a, pbus.internal.a
    imm b, 0
    wr  a, b
    adi a, 1
    imm b, gpu_width ; * gpu_height
    cmb b
    mov b, c
    imm c, 0
    cma c

    imm d, .loop
    .loop:
        wrl a, b

        adi c, 1

        jlt d

    pop a
    jmp a