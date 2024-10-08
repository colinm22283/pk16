#once

#bank rom

; takes two 16 bit integers and returns the product
; a: arg0
; b: arg1
m_mult: ; [ ret ]
    imm c, 0
    cmb c

    mov c, a
    cma b

    imm a, 0
    imm d, .skip
    je  d

    sbi b, 1

    mov a, c
    imm d, .skip
    je  d

    imm d, .loop
    .loop:
        add a, c
        sbi b, 1

        jgt d
    .skip:

    pop b
    jmp b