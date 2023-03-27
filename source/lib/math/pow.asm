#once

#include "mult.asm"

m_pow: ; [ base, exponent, ret ]
    sbi 2
    pop b
    pop a
    cma b

    imc c, 0
    cmb c

    mov c, a

    .loop:
        psh b
        psh c

        psh a
        psh b
        imm a, m_mult
        cal a
        pop a

        pop c
        pop b

        sbi b, 1

        imm d, .loop
        jgt d

    mov a, stack
    adi a, 4
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b