#once

#include "/arch/rules.asm"

#bank rom
#addr 0x0000
main:
    iml a, 0x00
    imu a, 0x00

    iml b, 0xFF
    imu b, 0xFF

    iml c, .loop
    imu c, .loop >> 8

    .loop:
        xor a, b

        jmp c