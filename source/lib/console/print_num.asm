#once

#include "/lib/math/pow.asm"

#include "config.asm"

console_print_num: ; [ number, digits, ret ]
    sbi 2
    pop b
    psh b

    imm c, 10
    psh 10
    psh b
    imm b, m_pow
    cal b

    imc b, 0
    cmb b

    pop c ; div
    pop b ; digits
    pop a ; number

    cma b

    .loop:
        psh a
        psh b
        psh c

        psh a
        psh c
        cal m_div
        psh 10
        cal m_mod
        pop c
        adi c, 48
        imm b, console_port
        wrl b, c

        pop c
        pop b
        pop a

        sbi b, 1

        imm d, .loop
        jgt d

    mov a, stack
    adi a, 4
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b