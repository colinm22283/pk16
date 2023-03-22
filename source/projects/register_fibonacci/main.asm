#once

#bank rom
#addr 0

main:
    imc a, 1
    mov b, a

    iml d, .loop
    imu d, .loop >> 8

    ; call function with args 1 and 2
    psi 1 >> 8
    psi 1
    psi 2 >> 8
    psi 2
    psi .return >> 8
    psi .return
    iml e, function
    imu e, function >> 8
    cal e
    .return:

    .loop:
        mov c, a
        mov a, b
        add b, c

        jno d

function: ; [ arg0, arg1, ret ]


    ret