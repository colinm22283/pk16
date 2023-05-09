#once

#include "/lib/math/mult.asm"

#bank rom
int_ext:
    adi f, 1

    irt

main:
    imm a, pic.config_ext_int | pic.config_enable
    imm b, pic.a.config
    wrl b, a
    imm a, int_ext
    imm b, pic.a.address
    wr  b, a

    imm f, 5

    .loop:
        imm a, 10
        imm b, 70
        imm c, m_mult
        cal c

        imm c, .loop
        jmp c

    pop a
    jmp a