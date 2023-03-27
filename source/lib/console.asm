#once

#include "/lib/math/pow.asm"

console_print_str: ; [ str_ptr, ret ]
    sbi stack, 2

    pop a

    imc b, 0
    cma b
    cmb b

    imm c, .loop..exit
    imm d, console.data

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

console_print_char: ; [ char, ret ]
    pop b
    pop a
    imm c, console.data
    wrl c, a
    jmp b

console_print_number: ; [ number, digits, ret ]
    sbi 2
    pop b
    psh b

    imm c, 10
    psh 10
    psh b
    imm b, m_pow
    cal b

    imc b, 0
    cmb b

    pop c ; div
    pop b ; digits
    pop a ; number

    cma b

    .loop:
        psh a
        psh b
        psh c

        psh a
        psh c
        cal m_div
        psh 10
        cal m_mod
        pop c
        adi c, 48
        imm b, console.data
        wrl b, c

        pop c
        pop b
        pop a

        sbi b, 1

        imm d, .loop
        jgt d

    mov a, stack
    adi a, 4
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b