#once

#bank rom
ps2_read: ; [ bus addr, ret ]
    pop f ; ret
    pop e ; bus addr

    imc a, 0
    cmb a
    cma a
    imm d, .loop

    .loop:
        ldl a, e

        je  d

    psl a

    jmp f