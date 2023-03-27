#once

#bank rom

; takes two 16 bit integers and returns the dividend and modulo
; returns [ div, mod ]
m_divmod: ; [ arg0, arg1, ret ]
    sbi stack, 2
    pop b
    pop a
    imc c, 0

    imm d, .loop

    .loop:
        adi c, 1
        sub a, b

        jno d

    sbi b, 1
    psh b

    add a, b
    psh a

    ; return
    mov a, stack
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b

; takes two 16 bit integers and returns the dividend
; returns [ div ]
m_div: ; [ arg0, arg1, ret ]
    sbi stack, 2
    pop b
    pop a
    imc c, 0

    imm d, .loop

    .loop:
        adi c, 1
        sub a, b

        jno d

    sbi b, 1
    psh b

    ; return
    mov a, stack
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b

; takes two 16 bit integers and returns the modulo
; returns [ mod ]
m_mod: ; [ arg0, arg1, ret ]
    sbi stack, 2
    pop b
    pop a

    imm d, .loop

    .loop:
        sub a, b

        jno d

    add a, b
    psh a

    ; return
    mov a, stack
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b