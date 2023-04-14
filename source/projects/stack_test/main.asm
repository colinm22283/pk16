#once

#include "/lib/math/mult.asm"

main:
    imc a, 0xAA
    psl a

    nop

    imm a, 0xF00F
    psu a
    psl a

    nop

    imm a, 10
    psh a
    imm 1, 5
    psh 1
    imm a, m_mult
    nop
    cal a

    pop b

    imm a, interrupt
    jmp a