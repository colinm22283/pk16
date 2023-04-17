#once

#include "/lib/math/mult.asm"

main: ; [ ret ]
    imc a, 2

    .loop:
        mov pptr, a

        psh a
        psh a
        imm a, m_mult
        cal a
        pop a

        cma a
        imm b, 10000
        cmb b
        imm b, .loop
        jlt b

    ; return from main
    pop a
    jmp a