#once

#include "/lib/math/fact.asm"

#bank rom
main:
    psh 4
    imm a, m_fact
    cal a

    pop b

    pop f
    jmp f