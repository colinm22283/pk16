#include "/arch/rules.asm"

#bank rom
#addr 0

main:
    imc a, 0
    imc b, 1
    iml c, .loop
    imu c, .loop >> 8

    .loop:
        add a, b

        jmp c