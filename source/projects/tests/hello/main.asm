#once

#include "/lib/gpu/fonts/default.asm"
#include "/lib/gpu/font.asm"

#bank ram
is_complete: #res 1

#bank rom
ext_int:
    psh a
    psh b
    ; cms

    imm a, is_complete
    imm b, 1
    wrl a, b

    ; cml
    pop b
    pop a

    ;imm a, interrupt
    ;jmp a

    irt

test_str: #d "TEST\0"

main:
    imm a, pic.a.address
    imm b, ext_int
    wr  a, b
    adi a, 1
    imm b, pic.config_enable | pic.config_ext_int
    wrl a, b

    imm a, is_complete
    imm b, 0
    wrl a, b

    imm b, .loop
    .loop:
        imm c, 0
        cmb c
        ldl c, a
        cma c
        je  b

    imm a, test_str
    imm b, 0
    imm c, gpu_print_str
    cal c

    pop a
    jmp a