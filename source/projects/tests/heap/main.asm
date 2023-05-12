#once

#include "/lib/heap/alloc.asm"
#include "/lib/heap/free.asm"

#bank rom
main:
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
    imm b, free
    cal b

    pop b
    pop a
    psh b
    imm b, free
    cal b

    pop a
    imm b, free
    cal b

    ; return
    pop f
    jmp f