#once

#include "config.asm"

#bank rom
display_clear: ; [ color, ret ]
    pop f ; ret
    pop a ; color

    imm e, display.width * display.height
    cmb e
    imm e, display.reg.color

    imm b, 0
    cma b

    ; b must be 0
    imm d, display.reg.address
    wru d, b
    adi d, 1
    wrl d, b

    imm c, .loop

    .loop:
        wrl e, a

        adi b, 1

        jlt c

    jmp f