#once

main:
    imm a, 0xF00F
    psu a
    psl a

    imm a, interrupt
    jmp a
