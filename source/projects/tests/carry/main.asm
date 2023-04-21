#once

#bank rom
main:
    imm a, 0xFFFF
    imm b, 0xFF
    imm c, 1
    imm d, 0
    add a, c
    add b, d
    imm d, flags
    ldl c, d
    imm d, 1
    and c, d

    ; return
    pop a
    jmp a