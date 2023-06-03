#once

#include "/lib/heap/alloc.asm"
#include "/lib/heap/free.asm"

#bank rom
free_handler:
    pop a
    psh f
    imm b, free
    cal b
    pop f

    irt

main:
    imm a, pic.a.address
    imm b, free_handler
    wr  a, b
    adi a, 1
    imm b, pic.config_enable | pic.config_ext_int
    wrl a, b

    imm a, 2
    imm b, alloc
    cal b
    psh a
    imm a, 2
    imm b, alloc
    cal b
    psh a
    imm a, 2
    imm b, alloc
    cal b
    psh a
    imm a, 2
    imm b, alloc
    cal b
    psh a
    imm a, 2
    imm b, alloc
    cal b
    psh a

    pop a
    pop b
    pop c
    pop d
    pop e

    psh b
    psh d
    psh e
    psh a
    psh d

    imm f, .loop
    .loop:
        jmp f

    ; return
    pop f
    jmp f