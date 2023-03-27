#include "/arch/rules.asm"
#include "/arch/arch.asm"
#include "/arch/peripheral.asm"

#bank rom
#addr 0
;imm a, main
;cal a
;interrupt:
;    imm a, .loop
;    .loop:
;        jmp a

#include "/projects/register_counter/main.asm"