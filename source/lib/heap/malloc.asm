#once

#bank rom

malloc: ; [ size, ret ]
    sbi stack, 2
    pop f

    imm a, heap_offset
    imm d, .loop
    imm e, .loop.break

    imc c, 0
    cmb c
    cma c

    .loop:
        ldu b, a
        adi a, 1
        ldl b, a

        imm c, 0x8000
        and c, b

        je  e
        add a, b
        sbi a, 1

        jmp d
        ..break:

    wrl a, f
    sbi a, 1
    wru a, f
    adi a, 2

    psh a

    mov a, stack
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b