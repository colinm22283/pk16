#once

#include "7seg.asm"
#include "delay.asm"

main:
    imm ra, 1
    mov rb, ra

    cma rb
    cmb ra

    imm rf, .loop
    .loop:
        ; write to 7 segment display
        psh ra
        psh rb
        psh ra
        imm ra, seg_send_number
        cal ra
        pop rb
        pop ra

        mov rc, rb
        add rb, ra
        mov ra, rc

        ; call delay while preserving ra and rb
        psh ra
        psh rb
        imm ra, delay
        cal ra
        pop rb
        pop ra

        jno rf

    ret