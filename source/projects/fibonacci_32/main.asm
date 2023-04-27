#once

main:
    imm a, 1
    imm b, 0
    imm c, 1
    imm d, 0

    .loop:
        mov e, a
        mov f, b
        add a, c
        add b, d
        mov c, e
        mov d, f

        imm f, .loop
        jno f

    ; return
    pop f
    jmp f