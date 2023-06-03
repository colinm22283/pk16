#once

#include "/lib/math/mult.asm"
#include "/lib/gpu/image.asm"

#bank rom
; a: char
; b: pbuf offset
gpu_print_char: ; [ ret ]
    psh b

    sbi a, 65
    mov b, a
    imm a, 36
    imm c, m_mult
    cal c

    imm b, font
    add a, b
    imm b, 6
    imm c, 6
    pop d
    imm e, gpu_image
    cal e

    pop a
    jmp a

; a: str
; b: pbuf offset
gpu_print_str: ; [ ret ]
    mov f, a
    mov e, b

    .loop:
        psh f
        psh e
        imm a, 0
        ldl a, f
        psh a

        imm b, 0
        cmb b
        cma a
        imm b, ..break
        je  b

        mov b, e
        imm c, gpu_print_char
        cal c

        pop a
        pop e
        adi e, 6
        imm f, pbus.internal.a
        wr  f, e

        pop f
        adi f, 1

        imm b, .loop
        jmp b
    ..break:
    sbi stp, 6

    pop a
    jmp a