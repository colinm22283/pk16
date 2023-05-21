#once

#include "/lib/math/mult.asm"
#include "/lib/gpu/image.asm"

#bank rom
; a: char
; b: x pos
; c: y pos
gpu_print_char_loc: ; [ ret ]
    mov f, a

    mov e, b

    mov b, c
    imm a, gpu_width
    imm c, m_mult
    cal c

    add a, e
    imm b, pbus.internal.a
    wr  b, a

    mov a, f
    sbi a, 65
    mov b, a
    imm a, 36
    imm c, m_mult
    cal c

    imm b, font
    add a, b
    imm b, 6
    imm c, 6
    imm d, gpu_image
    cal d

    pop a
    jmp a

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

    pop a
    jmp a