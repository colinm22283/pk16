#once

#include "/lib/heap/heap.asm"

main: ; [ ret ]
    psh 100
    imm a, malloc
    cal a
    ; [ 1 ]

    psh 100
    imm a, malloc
    cal a
    ; [ 1, 2 ]

    pop f
    pop e
    psh f

    psh e
    imm a, free
    cal a
    ; [ 2 ]

    psh 50
    imm a, malloc
    cal a
    ; [ 2, 3 ]

    imm a, free
    cal a
    imm a, free
    cal a

    pop a
    jmp a