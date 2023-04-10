#once

#bank rom

main:
    imc b, 1
    .loop:
        mov stack, b
        imc a, 3
        imm c, reg_mult
        imm f, ($ + 6)`16
        jmp c

        imm c, .loop
        jmp c

reg_mult: ; a: value 1, b: value 2 & result, c: volatile, d: volatile, f: return address
    mov c, b
    imc d, 0
    cmb d

    .loop:
        ; imm d, 0xFFFF
        ; add a, d
        sbi a, 1

        imm d, ..break
        je d

        add b, c

        imm d, .loop
        jmp d
    ..break:

    jmp f