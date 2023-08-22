#include "/arch/rules.asm"
#include "/arch/arch.asm"
#include "/arch/peripheral.asm"

#bank rom
#addr 0
imm stp, stack_offset
imm a, flags.carry_disable
imm b, flags
wrl b, a

imm a, heap_init
cal a

imm a, main
cal a

imm a, flags.shutdown
imm b, flags
wrl b, a

interrupt:
    imm a, .loop
    .loop:
        jmp a

#include "/lib/heap/init.asm"

#include "/projects/counter/main.asm"

imm a, interrupt
jmp a