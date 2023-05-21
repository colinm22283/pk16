#once

#include "config.asm"

#bank rom
; a: image data
; b: width
; c: height
; d: pbuf offset
gpu_image: ; [ ret ]
    mov f, b


    imm e, pbus.internal.a
    wr  e, d

    psh d

    imm d, 0
    cmb d

    .y_loop:
        mov b, f
        cma b

        adi e, 1

        ..x_loop:
            ldl d, a
            wrl e, d

            sbi b, 1
            adi a, 1

            imm d, ..x_loop
            jgt d

        sbi c, 1

        pop d
        adi d, gpu_width
        sbi e, 2
        wr  e, d
        psh d

        cma c
        imm d, .y_loop
        jgt d

    pop a

    pop a
    jmp a