#once

#bank rom
main:
    imm f, .loop

    imm a, 1
    imm b, 0

    .loop:
        add a, a
        add b, b

        jno f


    ; return
    pop a
    jmp a