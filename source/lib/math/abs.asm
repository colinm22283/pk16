#once

#bank rom
; a: value
m_abs: ; [ ret ]
    imm b, 0x7FFF
    and a, b

    pop b
    jmp b