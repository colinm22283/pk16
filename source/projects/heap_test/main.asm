#once

#include "/lib/heap/heap.asm"
#include "/lib/memory/memset.asm"

main: ; [ ret ]
    psh 10
    imm a, malloc
    cal a
    ; [ 1 ]

    pop a
    psh a
    psh a
    ; [ 1, 1 ]

    ; write 5's to alloc 1
    psi 5
    psh 10
    imm a, memset
    cal a

    ; [ 1 ]

    ; free alloc 1
    imm a, free
    cal a

    pop a
    jmp a