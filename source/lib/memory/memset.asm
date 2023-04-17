#once

memset: ; [ dest, value : 1, size, ret ]
    sbi stack, 2
    pop c ; size
    ppl b
    pop a

    add c, a
    cmb c
    cma a

    imm c, .loop
    imm d, .loop.break
    .loop:
        je  d

        wrl a, b

        adi a, 1

        jmp c
    ..break:

    mov a, stack
    adi a, 5
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b