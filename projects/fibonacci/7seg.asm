#once

#include "delay.asm"

SEG_LUT: #d8 0b11111100

seg_send_number:
    pop rb
    imm ra, SEG_LUT

    add ra, rb

    lpl ro, ra

    ret

seg_send_sequence:
    pop rd
    pop rc
    add rd, rc
    adi rd, 1
    cmb rd
    cma rc

    imm re, seg_send_number
    imm rf, .loop
    .loop:
        lpl rd, rc
        psh rd
        cal re

        jlt rf
        je rf

    ret