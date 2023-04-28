#once

#include "/lib/heap/malloc.asm"

main:
    psh 10
    imm f, malloc
    cal f

    nop
    nop
    nop
    nop
    nop

    psh 10
    imm f, malloc
    cal f

    nop
    nop
    nop
    nop
    nop

    ; return
    pop f
    jmp f