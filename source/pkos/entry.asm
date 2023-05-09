#once

#include "/arch/rules.asm"
#include "/arch/arch.asm"
#include "/arch/peripheral.asm"

#bank rom
#addr 0
imm stp, stack_offset
imm a, 0
imm b, flags
wrl b, a

;imm a, heap_init
;cal a

imm a, main
cal a

#include "syscall/table.asm"

#include "main.asm"