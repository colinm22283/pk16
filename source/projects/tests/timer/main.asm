#once

#bank rom
timer_handler:
    adi f, 1

    irt

main:
    ; set up timer
    imm a, timer.a.period
    wr  a, 0xFF
    imm a, timer.a.config
    wr  a, timer.config_enable | timer.config_div_1

    ; set up pic
    imm a, pic.a.address
    wr  a, timer_handler
    imm a, pic.a.config
    wr  a,  pic.config_enable | pic.config_timer_ovf

    imm f, 5

    imm a, .loop
    .loop:
        jmp a

    pop a
    jmp a