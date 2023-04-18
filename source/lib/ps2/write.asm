#once

#bank rom
ps2_write: ; [ bus addr, data buf, size, ret ]
    pop f ; ret
    pop c ; size
    pop b ; data buf
    pop a ; bus addr

    add c, d
    ; c contains the end index uninclusive
    cmb c
    cma b

    imm e, .loop
    .loop:
        rdl d, b
        wrl b, d

        adi b, 1

        jlt e

    jmp f