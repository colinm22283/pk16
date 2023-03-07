#once

#include "/arch/rules.asm"
#include "/arch/arch.asm"

#include "/lib/7seg.asm"
; #include "/lib/math.asm"
#include "/lib/delay.asm"

#bank rom
main:
    imm a, 1
    mov b, a

    cma b
    cmb a

    imm f, .loop
    .loop:
        ; write to 7 segment display
        psh a
        psh b
        psh a
        imm a, seg_send_number
        cal a
        pop b
        pop a

        mov c, b
        add b, a
        mov a, c

        ; call delay while preserving ra and rb
        psh a
        psh b
        imm a, 100
        psh a
        imm a, delay
        cal a
        pop b
        pop a

        jno f

    ret