#once

#bank rom
main:
    imm a, flags
    nop
    nop
    nop
    nop
    wr  a, flags.carry_out

    ; return
    pop a
    jmp a