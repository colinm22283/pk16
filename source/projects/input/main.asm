#once

#bank rom
ps2a_handler:
    psh a

    imm a, pbus.ps2.a
    ldl b, a

    pop a

    irt

main:
    imm a, pic.a.address
    imm b, ps2a_handler
    wr  a, b

    imm a, pic.a.config
    imc b, pic.config_enable | pic.config_ps2a_rec
    wrl a, b

    imm a, .loop
    .loop:
        jmp a

    pop f
    jmp f