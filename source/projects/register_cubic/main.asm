#once

#bank rom

#include "/lib/math/mult.asm"

main: ; [ ret ]
    ; write to console
    imm a, console.data
    wrc a, "H"
    wrc a, "e"
    wrc a, "l"
    wrc a, "l"
    wrc a, "o"

    imc a, 1

    .loop:
        imc b, 2

        psh a
        psh b
        imm c, m_mult
        cal c

        pop a

        imm c, .loop
        jno c

    ; return
    pop a
    jmp a