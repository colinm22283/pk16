#once

memcpy: ; [ dest, source, size, ret ]
    sbi stack, 2
    pop a ; size
    pop b ; source
    pop c ; dest

    add a, b
    cmb a
    cma b

    imm d, .loop.break
    imm e, .loop
    .loop:
        je  d

        ldl a, b
        wrl c, a

        adi b, 1
        adi c, 1

        jmp e
    ..break:

    mov a, stack
    adi a, 6
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b