#once

strcpy: ; [ dest, source, ret ]
    sbi stack, 2
    pop b ; source
    pop c ; dest

    imc a, 0x00
    cmb a
    cma a

    imm d, .loop
    .loop:
        ldl a, b
        wrl c, a

        adi b, 1
        adi c, 1

        jne d

    mov a, stack
    adi a, 4
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b