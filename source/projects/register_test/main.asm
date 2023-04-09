#bank rom

imc a, 0
imc b, 1
imm c, loop
loop:
    add a, b

    jmp c

main:
    imm a, 0xAAAA
    imm b, 0xBBBB

    mov c, a

    imc a, 3
    imc b, 4
    add a, b

    nop
    nop
    nop
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
