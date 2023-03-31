 #once

#bank rom
#addr 0

#include "/lib/keyboard.asm"

main:
    imc a, 1
    mov b, a

    iml d, .loop`8
    imu d, .loop >> 8

    iml e, port.a`8
    imu e, port.a >> 8

    .loop:
        mov c, a
        mov a, b
        add b, c

        ; output number through porta
        wrl e, a

        jno d