#once

#bank rom
m_abs: ; [ value, ret ]
    pop c
    pop a

    imm b, 0x7FFF
    and a, b
    psh a

    jmp c