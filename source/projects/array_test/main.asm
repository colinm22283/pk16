#once

#bank rom

main: ; [ ret ]
    ; allocate 10 bytes to stack
    imc a, 0
    cmb a
    imc a, 10
    cma a
    imm b, .alloc_loop
    mov f, stack
    .alloc_loop:
        psl a

        sbi a, 1

        jgt b

    ; f contains the stack allocated array pointer

    element_to_locate = 5
    imm a, element_to_locate
    add a, f
    ldl flags, a

    ; dealloc the array
    mov stack, f

    ;return
    pop a
    jmp a