#once

#include "config.asm"

console_print_str: ; [ str_ptr, ret ]
    sbi stack, 2

    pop a

    imc b, 0
    cma b
    cmb b

    imm c, .loop..exit
    imm d, console_port

    .loop:
        ldl b, a

        adi a, 1

        jeq c

        wrl d, b

        jmp .loop

    ..exit:

    adi stack, 4
    pop a
    sbi stack, 2
    jmp a