#include "/arch/rules.asm"
#include "/arch/arch.asm"

#bank rom
;imm a, main
;cal a
;interrupt:
;    imm a, .interrupt_loop
;    .interrupt_loop:
;        jmp a

#include "/projects/register_blinky/register_blinky.asm"