#once

#bank rom
#addr 0

main:
    imc a, 1
    mov b, a

    iml d, .loop
    imu d, .loop >> 8

    .loop:
        mov c, a
        mov a, b
        add b, c

        jmp d