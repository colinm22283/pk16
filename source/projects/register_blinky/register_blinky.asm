#once

#include "/arch/rules.asm"

#bank rom
#addr 0x0000
main:
    iml a, 0x00
    imu a, 0x00

    iml b, 0xFF
    imu b, 0xFF

    xor a, b
    xor a, b
    xor a, b
    xor a, b
    xor a, b
    xor a, b
    xor a, b

    nop
    nop
    nop
    nop
    nop
    nop
    nop

    iml b, .loop
    imu b, .loop >> 8

    iml c, interrupt
    imu c, interrupt >> 8
    jmp c

    .loop:
        flp a

        jmp b

interrupt:
    iml c, .loop
    imu c, .loop >> 8
    .loop:
        jmp a