#once

#include "/lib/math/mult.asm"

#include "config.asm"

#bank rom
draw_image: ; [ byte buffer, x, y, width, height, ret ]
    sbi stack, 4
    pop a ; width
    pop b ; y
    adi stack, 8

    ; calculate the start address
    psh a
    psh b
    imm a, m_mult
    cal a
    ; [ byte buffer, x, y, width, height, ret, mult return ]
    ;                                                         ^
    sbi stack, 8
    pop b ; y
    adi stack, 10
    pop a
    add a, b
    ; [ byte buffer, x, y, width, height, ret, mult return ]
    ;                                           ^

    ; a contians the starting address

    ; write the vram pointer to accessory
    imm b, display.reg.address
    wru b, a
    adi b, 1
    wrl b, a

    sbi stack, 2
    pop f ; height
    pop e ; width
    sbi stack, 4
    pop d ; buffer
    ; [ byte buffer, x, y, width, height, ret, mult return ]
    ;    ^

    imm a, 0 ; outer loop iterator

    .loop:
        psh a
        imm b, 0
        cmb b
        mov b, e
        cma b ; inner loop iterator

        ..loop:
            ldl c, d
            imm a, display.reg.color
            wrl a, c

            adi d, 1
            sbi b, 1
            imm c, ..loop
            jgt c

        imm a, 0
        cmb a
        cma a
        pop a

        sbi a, 1

        imm c, .loop
        jgt c


    adi stack, 12
    pop a
    sbi stack, 10
    jmp a