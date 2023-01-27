#once

main:
    imm rf, .loop

    imm ra, 100
    cmb ra

    imm ra, 0
    imm rb, 1

    cma ra

    .loop:
        add ra, rb
        mov ro, ra

        jlt rf

    ret