#include "kbd.asm"

#bank rom
kbd_getch: ; [ ret ]
    imm a, kbd_port
    imm b, .loop_1

    imc c, 0
    cmb c
    cma c

    .loop_1:
        ldl c, a

        je b

    mov d, c
    imm b, .loop_2
    .loop_2:
        ldl c, a

        jne b

    pop b
    sbi stack, 2
    psh d
    jmp b