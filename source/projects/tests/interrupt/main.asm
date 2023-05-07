#once

#bank ram
counter: #res 4

#bank rom
int_power:
    imm a, flags.shutdown
    imm b, flags
    wrl b, a

int_timer:
    psh a
    psh b
    psh c

    imm c, counter
    ld  b, c
    adi c, 1
    ld  a, c

    add a, a
    add b, b

    imm c, counter
    wr  c, b
    adi c, 1
    wr  c, a

    pop c
    pop b
    pop a

    irt

main:
    imm a, 0
    imm b, counter
    wr  b, a
    adi b, 1
    wr  b, a

    imm a, pic.config_ext_int
    imm b, pic.a.config
    wrl b, a
    imm a, int_power
    imm b, pic.a.address
    wr  b, a

    imm a, pic.config_timera_ovf
    imm b, pic.b.config
    wrl b, a
    imm a, int_timer
    imm b, pic.b.address
    wr  b, a

    imm a, 0xFF
    imm b, timer.a.period
    wrl b, a
    imm a, timer.config_enable | timer.config_div_4096
    imm b, timer.a.config
    wrl b, a

    imm a, .loop
    .loop:
        jmp a

    pop a
    jmp a