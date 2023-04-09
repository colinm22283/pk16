#bank rom

main:
    iml a, 0b10101010
    imu a, 0b10101010

    nop
    nop
    nop

    xor a, a
    not a
    add a, a
    not a
    ; a contains 1

    mov b, a
    add b, a

    mov c, b
    add c, b

    mov d, c
    add d, c

    mov e, d
    add e, d

    mov f, e
    add f, e

    imm a, interrupt
    jmp a

interrupt:
    imm a, .loop
    .loop:
        jmp a
