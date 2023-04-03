#include "/arch/rules.asm"
#include "/arch/arch.asm"
#include "/arch/peripheral.asm"

#bank rom
#addr 0
imm stack, stack_offset
imm a, main
cal a
interrupt:
    imm a, .loop
    .loop:
        jmp a

#include "/projects/fibonacci/main.asm"