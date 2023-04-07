#once

#include "/lib/kbd/getch.asm"
#include "/lib/memory/memset.asm"
#include "/lib/math/mult.asm"

width = 10
height = 10

main:
    ; allocate board to stack
    mov f, stack
    adi stack, width * height
    ; zero out board
    psh f
    psh f
    psi 0x00
    psh width * height
    imm a, memset
    cal a
    pop f

    .loop:
        ; get inputs
        imm a, kbd_getch
        cal a
        cal a

        ; [ x, y ]

        psh f
        pop b
        pop a
        psh b
        psh a
        psh width
        imm a, m_mult
        cal a

        ; [ board, y, x * 10 ]

        pop a
        pop b
        add a, b
        pop f
        add a, f

        imc b, 1
        wrl a, b

        imm a, .loop
        jmp a

    ; free board
    sbi stack, width * height

    pop a
    jmp a