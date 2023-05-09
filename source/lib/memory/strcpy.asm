#once

; a: dest
; b: source
strcpy: ; [ ret ]
    imm c, 0
    cmb c
    cma c

    imm d, .break
    imm e, .loop
    .loop:
        ldl c, b

        je  d

        wrl a, c

        adi a, 1
        adi b, 1

        jmp e
    .break:

    pop b
    jmp b