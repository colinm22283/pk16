swi_handler:
    imm r0, 0xFFFF

    irt

main:
    cal config_interrupts

    swi

    ret

config_interrupts:
    imm   r0, ic0.config
    imm.l r1, ic_config_enable | ic_config_inten_software
    st.l  r0, r1

    imm r0, ic0.address
    imm r1, swi_handler
    sti r0, r1

    ret