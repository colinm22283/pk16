#include "opcodes.asm"

imm ra, main
cal ra
interrupt:
    imm ra, .interrupt_loop
    .interrupt_loop:
        jmp ra

#include "fibonacci/main.asm"