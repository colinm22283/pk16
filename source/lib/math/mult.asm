#once

#bank rom

; takes two 16 bit integers and returns the product
m_mult: ; [ arg0, arg1, ret ]
    sbi stack, 2
    pop b
    pop a

    imc c, 0
    cmb c

    mov c, b
    cma c

    imm d, .loop

    .loop:
        add a, b

        sbi c, 1

        jgt d

    psh a

    mov a, stack
    adi a, 2
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b