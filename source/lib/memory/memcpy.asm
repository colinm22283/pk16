#once

; a: dest
; b: source
; c: size
memcpy: ; [ ret ]
    add c, b
    cmb c
    cma b

    imm d, .loop.break
    imm e, .loop
    .loop:
        je  d

        ldl c, b
        wrl a, c

        adi b, 1
        adi a, 1

        jmp e
    ..break:

    pop b
    jmp b