#once

#include "/lib/heap/heap.asm"
#include "/lib/memory/memset.asm"

main: ; [ ret ]
    psh 50
    imm a, malloc
    cal a
    ; [ 2 ]

    psh 10
    imm a, malloc
    cal a
    ; [ 2, 1 ]

    pop a
    pop b
    psh a
    psh b
    psh b
    ; [ 1, 2, 2 ]

    ; write 5's to alloc 2
    psi 0xaa
    psh 50
    imm a, memset
    cal a

    ; [ 1, 2 ]

    ; free allocs
    imm a, free
    cal a
    imm a, free
    cal a

    pop a
    jmp a