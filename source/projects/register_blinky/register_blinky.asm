#once

#include "/arch/rules.asm"

#bank rom
#addr 0x0000
main:
    iml a, 0xFF
    imu a, 0xFF

    iml b, .loop
    imu b, .loop >> 8

    iml c, interrupt
    imu c, interrupt >> 8
    jmp c

    .loop:
        not a

        jmp b

interrupt:
    iml c, .loop
    imu c, .loop >> 8
    .loop:
        jmp a