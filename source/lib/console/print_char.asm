#once

#include "config.asm"

console_print_char: ; [ char, ret ]
    pop b
    pop a
    imm c, console_port
    wrl c, a
    jmp b