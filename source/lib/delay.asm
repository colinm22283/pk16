#once

#bank rom
delay:
    imm a, 0
    cma a

    pop b
    cmb b

    imm b, .loop

    .loop:
        adi a, 2

        jlt b

    ret