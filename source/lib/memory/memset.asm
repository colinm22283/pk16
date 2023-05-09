#once

; a: dest
; b: value
; c: size
memset: ; [ ret ]
    add c, a
    cmb c
    cma a

    imm c, .loop
    imm d, .loop.break
    .loop:
        je  d

        wrl a, b

        adi a, 1

        jmp c
    ..break:

    pop b
    jmp b