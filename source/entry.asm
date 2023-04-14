#include "/arch/rules.asm"
#include "/arch/arch.asm"
#include "/arch/peripheral.asm"

#bank rom
#addr 0
imm stack, stack_offset
;imm a, heap_init
;cal a
imm a, main
cal a
interrupt:
    imm a, .loop
    .loop:
        jmp a

;#include "/lib/heap/init.asm"

#include "/projects/array_test/main.asm"