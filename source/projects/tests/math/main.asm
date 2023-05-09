#once

#include "/lib/math/mult.asm"

#bank rom
main:
    imm a, 5
    imm b, 7
    imm c, m_mult
    cal c

    imm c, .loop
    .loop: jmp c

    pop a
    jmp a