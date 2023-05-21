#once

#include "/lib/gpu/clear.asm"
#include "/lib/gpu/image.asm"

#include "/lib/gpu/font.asm"
#include "/lib/gpu/fonts/default.asm"

#bank rom
test_str: #d "HELLO WORLD\0"

main:
    imm a, test_str
    imm b, 0
    imm c, gpu_print_str
    cal c

    pop a
    jmp a