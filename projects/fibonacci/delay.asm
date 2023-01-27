#once

delay:
    imm ra, 0
    cma ra

    pop rb
    cmb rb

    imm rb, .loop

    .loop:
        adi ra, 2

        jlt rb

    ret