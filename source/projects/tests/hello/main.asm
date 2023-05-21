#once

#include "/lib/gpu/fonts/default.asm"
#include "/lib/gpu/font.asm"

#bank rom
hello_str: #d "HELLO\0"

ext_int:
    psh a
    psh b
    psh c
    psh d
    psh e
    psh f
    stc

    imm a, hello_str
    imm b, 0
    imm c, gpu_print_str
    cal c

    ldc
    pop f
    pop e
    pop d
    pop c
    pop b
    pop a

    irt

test_str: #d "TEST\0"

main:
    imm a, pic.a.address
    imm b, ext_int
    wr  a, b
    adi a, 1
    imm b, pic.config_enable | pic.config_ext_int
    wrl a, b

    imm a, test_str
    imm b, gpu_width * 6
    imm c, gpu_print_str
    cal c

    pop a
    jmp a