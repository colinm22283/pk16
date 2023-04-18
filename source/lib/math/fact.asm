#once

#include "mult.asm"

m_fact: ; [ number, ret ] doesn't work
    pop f ; ret
    pop e
    psh f
    psh 1
    psh e

    .loop: ; [ accum, number ]
        pop a ; number

        imm d, 1
        cmb d
        cma a
        imm d, ..exit
        je  d

        pop b
        psh a
        psh b
        psh a
        imm d, m_mult
        cal d
        ; [ number, new accum ]

        pop a
        pop b

        sbi a, 1

        psh a
        psh b
        ; [ new number, new accum ]

        imm c, .loop
        jmp c
    ..exit:
    ; result will be in stack

    pop a
    pop b
    psh a
    jmp b