#once

#bank rom
main: ; [ ret ]
    imm a, 0xFFFF
    add a, a

    ; read the carry flag
    imm f, flags
    ldl b, f
    imc c, flags.carry
    and b, c

    nop
    nop

    ; write the carry flag
    imm f, flags
    imc b, flags.carry
    wrl f, b

    imm a, 1
    add a, a

    pop a
    jmp a