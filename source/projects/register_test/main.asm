#bank rom

#bank rom

main:
    imc a, 1
    rlr a
    rlr a
    rlr a
    rlr a
    rlr a
    rlr a

    not a

    imm a, interrupt
    jmp a

interrupt:
    imm a, .loop
    .loop:
        jmp a
