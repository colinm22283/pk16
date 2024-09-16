#once

#subruledef reg {
    r0  => 0x0
    r1  => 0x1
    r2  => 0x2
    r3  => 0x3
    r4  => 0x4
    r5  => 0x5
    r6  => 0x6
    r7  => 0x7
    r8  => 0x8
    r9  => 0x9
    r10 => 0xA
    r11 => 0xB
    r12 => 0xC
    rpp => 0xD
    rsp => 0xE
    ras => 0xF
}



#ruledef {
    mov { d: reg }, { s: reg } => 0b00000000 @ s @ d
    add.r { d: reg }, { s: reg } => 0b00000001 @ s @ d
    sub.r { d: reg }, { s: reg } => 0b00000010 @ s @ d
    and   { d: reg }, { s: reg } => 0b00000011 @ s @ d
    or    { d: reg }, { s: reg } => 0b00000100 @ s @ d
    xor   { d: reg }, { s: reg } => 0b00000101 @ s @ d
    shl   { d: reg }, { s: reg } => 0b00000110 @ s @ d
    shr   { d: reg }, { s: reg } => 0b00000111 @ s @ d

    jmp.l { d: reg } => 0b00010000 @ 0b0000 @ d
    br.l { d: reg } => 0b00010001 @ 0b0000 @ d
    jmp.r { d: reg } => 0b00010010 @ 0b0000 @ d
    br.r { d: reg } => 0b00010011 @ 0b0000 @ d

    ce { d: reg }, { s: reg } => 0b00010100 @ s @ d
    cl { d: reg }, { s: reg } => 0b00010101 @ s @ d
    cle { d: reg }, { s: reg } => 0b00010110 @ s @ d

    ld.l { d: reg }, { s: reg } => 0b00100000 @ s @ d
    ld.u { d: reg }, { s: reg } => 0b00100001 @ s @ d
    st.l { d: reg }, { s: reg } => 0b00100010 @ s @ d
    st.u { d: reg }, { s: reg } => 0b00100011 @ s @ d

    pop.l { d: reg } => 0b00100101 @ 0b0000 @ d
    pop.u { d: reg } => 0b00100110 @ 0b0000 @ d
    psh.l { s: reg } => 0b00100111 @ s @ 0b0000
    psh.u { s: reg } => 0b00101000 @ s @ 0b0000

    swi => 0b00110000 @ 0b0000 @ 0b0000
    irt => 0b00110001 @ 0b0000 @ 0b0000

    imm.l { d: reg }, { i: i8 } => 0b1 @ d @ 0b000 @ i
    imm.u { d: reg }, { i: i8 } => 0b1 @ d @ 0b001 @ i
    add.i { d: reg }, { i: u8 } => 0b1 @ d @ 0b010 @ i
    sub.i { d: reg }, { i: u8 } => 0b1 @ d @ 0b011 @ i
    psh.i { i: i8 } => 0b1 @ 0b0000 @ 0b100 @ i
    jmp.ri { i: s8 } => 0b1 @ 0b0000 @ 0b101 @ i
    br.ri  { i: s8 } => 0b1 @ 0b0000 @ 0b110 @ i
}

#ruledef {
    nop => asm { mov r0, r0 }

    add { d: reg }, { s: reg } => asm { add.r { d }, { s } }
    add { d: reg }, { i: u8 } => asm { add.i { d }, { i } }
    sub { d: reg }, { s: reg } => asm { sub.r { d }, { s } }
    sub { d: reg }, { i: u8 } => asm { sub.i { d }, { i } }

    pop { d: reg } => asm {
        pop.l { d }
        pop.u { d }
    }
    psh { s: reg } => asm {
        psh.u { s }
        psh.l { s }
    }
    psh { s: i16 } => asm {
        psh.i ({ s } >> 8)`8
        psh.i ({ s })`8
    }

    imm { d: reg }, { i: i16 } => asm {
        imm.u { d }, ({ i } >> 8)`8
        imm.l { d }, ({ i })`8
    }

    jmp { addr: u16 } => {
        reladdr = ({ addr }) - ($ + 2)
        assert(reladdr >= -128 * 2)
        assert(reladdr <= 127 * 2)
        assert(reladdr % 2 != 1)
        asm { jmp.ri ({ reladdr }) / 2 }
    }
    jmp { addr: u16 } => {
        reladdr = ({ addr }) - ($ + 6)

        assert(({ addr }) - ($ + 2) < -128 * 2 || ({ addr }) - ($ + 2) > 127 * 2)
        assert(reladdr % 2 != 1)

        asm {
            imm ras, ({ reladdr }) / 2
            jmp.r ras
        }
    }

    br { addr: u16 } => {
        reladdr = ({ addr }) - ($ + 2)
        assert(reladdr >= -128 * 2)
        assert(reladdr <= 127 * 2)
        assert(reladdr % 2 != 1)
        asm { br.ri ({ reladdr }) / 2 }
    }
    br { addr: u16 } => {
        reladdr = ({ addr }) - ($ + 6)

        assert(({ addr }) - ($ + 2) < -128 * 2 || ({ addr }) - ($ + 2) > 127 * 2)
        assert(reladdr % 2 != 1)

        asm {
            imm ras, ({ reladdr }) / 2)
            br.r ras
        }
    }

    cal { addr: u16 } => {
        reladdr = ({ addr }) - ($ + 10)

        assert(reladdr >= -128 * 2)
        assert(reladdr <= 127 * 2)
        assert(reladdr % 2 != 1)

        asm {
            mov ras, rpp
            add ras, 10
            psh ras

            jmp.ri ({ reladdr }) / 2
        }
    }
    cal { addr: u16 } => {
        reladdr = ({ addr }) - ($ + 14)
        assert((({ addr }) - ($ + 10)) < -128 * 2 || (({ addr }) - ($ + 10)) > 127 * 2)

        assert(reladdr % 2 != 1)

        asm {
            mov ras, rpp
            add ras, 10
            psh ras

            imm ras, (({ addr }) - ($ + 14)) / 2
            br.r ras
        }
    }

    jmp.l { addr: u16 } => asm {
        imm ras, ({ addr })
        jmp.l ras
    }

    cal.l { addr: u16 } => asm {
        psh ($ + 10)
        jmp.l ({ addr })
    }

    ret => asm {
        pop ras
        jmp.l ras
    }

    sti { d: reg }, { s: reg } => asm {
        st.l { d }, { s }
        add  { d }, 1
        st.u { d }, { s }
    }
}