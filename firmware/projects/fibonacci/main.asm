main:
    imm r0, 1
    mov r1, r0

    .loop:
        mov r2, r0
        add r0, r1
        mov r1, r2

        jmp .loop

    ret