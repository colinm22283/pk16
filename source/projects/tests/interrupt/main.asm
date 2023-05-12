#once

#include "/lib/math/mult.asm"

#bank ram
counter: #res 4

#bank rom
int_ext:
    imm a, counter
    ld  d, a
    adi a, 1
    ld  c, a

    add c, c
    add d, d

    imm a, counter
    wr  a, d
    adi a, 1
    wr  a, c

    irt

main:
    imm a, int_ext
    imm b, pic.b.address
    wr  b, a
    imm a, pic.config_ext_int | pic.config_enable
    imm b, pic.b.config
    wrl b, a

    imm a, flags
    imm b, 0
    wr b, a

    imm a, 0
    imm b, counter
    wr  b, a
    imm a, 1
    adi b, 1
    wr  b, a

    imm f, .loop
    .loop:
        jmp f

    pop a
    jmp a