#once

#include "/lib/math/mult.asm"

#include "/lib/heap/alloc.asm"
#include "/lib/heap/free.asm"

#include "/lib/gpu/font.asm"
#include "/lib/gpu/fonts/default.asm"

#bank rom
int_ext:
    cms
    pop a

    psh f

    imm b, free
    cal b

    pop f

    cml
    irt

main:
    imm a, int_ext
    imm b, pic.b.address
    wr  b, a
    imm a, pic.config_ext_int | pic.config_enable
    imm b, pic.b.config
    wrl b, a

    imm a, 4
    imm b, alloc
    cal b
    psh a
    imm a, 4
    imm b, alloc
    cal b
    psh a
    imm a, 4
    imm b, alloc
    cal b
    psh a
    imm a, 4
    imm b, alloc
    cal b
    psh a
    imm a, 4
    imm b, alloc
    cal b
    psh a

    pop a
    pop b
    pop c
    pop d
    pop e

    psh e
    psh c
    psh d
    psh b
    psh a

    imm f, .loop
    .loop:
        jmp f

    pop a
    jmp a