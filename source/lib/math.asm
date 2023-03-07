#once

#bank rom
math_multiply:
    imm a, 0
    cmb a

    pop a
    pop b
    mov c, b
    cma b

    imm f, .loop

    .loop:
        add a, c
        sbi b, 1

        jgt f

    psh a

    ret

math_divide:
    pop b
    pop a
    imm c, 0

    imm f, .loop
    .loop:
        sub a, b

        adi c, 1

        jno f

    sbi c, 1

    psh c

    ret

math_modulo:
    pop b
    pop a
    imm c, 0

    imm f, .loop
    .loop:
        sub a, b

        adi c, 1

        jno f

    sub a, b

    psh a

    ret