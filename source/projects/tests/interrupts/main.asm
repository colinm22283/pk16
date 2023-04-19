#once

#bank rom
pica_handler:
    int_enter

    imm a, 0xFFFF
    imm b, 0xFFFF
    imm c, 0xFFFF
    imm d, 0xFFFF
    imm e, 0xFFFF

    imm f, .loop
    .loop:
        jmp f

    int_return

main: ; [ ret ]
    ; configure interrupt controller
    imm a, pic.a.address
    wr  a, pica_handler
    imm a, pic.a.config
    wri a, pic.config_ps2a_rec | pic.config_enable

    ; infinite loop
    imm a, .loop
    .loop:
        jmp a

    ; return
    pop a
    jmp a