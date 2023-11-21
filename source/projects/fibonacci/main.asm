#once

#bank rom
main:
    imc a, 1
    mov b, a

    iml d, .loop`8
    imu d, .loop >> 8

    ; iml e, port.a`8
    ; imu e, port.a >> 8

    cma a
    imm c, 10000
    cmb c

    .loop:
        mov c, a
        mov a, b
        add b, c

        ; output number through porta
        ; wrl e, a

        jlt d