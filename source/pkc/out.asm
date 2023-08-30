#include "/arch/rules.asm"
#include "/arch/arch.asm"
#include "/arch/peripheral.asm"
#bank rom
#addr 0
imm stp, stack_offset
imm a, flags.carry_disable
imm b, flags
wrl b, a
_startup:
imm a, _copys_start
imm b, _copys_start + _copys_size
cma a
cmb b
imm stp, _copyd_start
imm b, .loop
.loop:
ldl c, a
psl c
adi a, 1
jlt b
imm stp, stack_offset
imm a, main
cal a
#bank rom
_copys_start:
_copys_size = 1
test_src: #d8 20
test_funct:
psh a
imm b, 20
imm f, m_mult
cal f
pop a
pop a
jmp a
main:
imm a, 10
imm f, test_funct
cal f
pop a
jmp a
#bank ram
_copyd_start:
_copyd_size = 1
test: #res 1
#bank rom
imm a, flags.shutdown
imm b, flags
wrl b, a
