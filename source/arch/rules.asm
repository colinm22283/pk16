#once

#subruledef register
{
    a    => 0b000
    b    => 0b001
    c    => 0b010
    d    => 0b011
    e    => 0b100
    f    => 0b101
    stp  => 0b110 ; points to next position in stack
    pc   => 0b111 ; points to the next instruction (read only)
}

#subruledef boolean
{
    true => 0x1
    false => 0x0
}

#ruledef
{
    ; simple instructions
    nop => 0b00000000 @ 0b00000000
    hlt => 0b00000000 @ 0b00000001
    irt => 0b00000000 @ 0b00000010
    cms => 0b00000000 @ 0b00000011
    cml => 0b00000000 @ 0b00000100

    ; single register instructions
    jmp {r: register} => 0b01000 @ r @ 0b01000000
    je  {r: register} => 0b01000 @ r @ 0b01000001
    jne {r: register} => 0b01000 @ r @ 0b01000010
    jgt {r: register} => 0b01000 @ r @ 0b01000011
    jlt {r: register} => 0b01000 @ r @ 0b01000100
    jof {r: register} => 0b01000 @ r @ 0b01000101
    jno {r: register} => 0b01000 @ r @ 0b01000110

    not {r: register} => 0b01000 @ r @ 0b10011110
    rlr {r: register} => 0b01000 @ r @ 0b10011111

    psl {r: register} => 0b01000 @ r @ 0b00100000
    psu {r: register} => 0b01000 @ r @ 0b00100001
    ppl {r: register} => 0b01000 @ r @ 0b00110010
    ppu {r: register} => 0b01000 @ r @ 0b00101011

    cma {r: register} => 0b01001 @ r @ 0b00000000
    cmb {r: register} => 0b01001 @ r @ 0b00000001

    ; 2 register instructions
    mov {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011000
    add {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011001
    sub {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011010
    and {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011011
    or  {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011100
    xor {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011101

    wrl {ptr: register}, {reg: register} => 0b10 @ ptr @ reg @ 0b00100000
    wru {ptr: register}, {reg: register} => 0b10 @ ptr @ reg @ 0b00100001
    ldl {reg: register}, {ptr: register} => 0b10 @ ptr @ reg @ 0b00110010
    ldu {reg: register}, {ptr: register} => 0b10 @ ptr @ reg @ 0b00101011

    ; immediate instructions
    iml {r: register}, {value: u8} => 0b11000 @ r @ value
    imu {r: register}, {value: u8} => 0b11001 @ r @ value
    imc {r: register}, {value: u8} => 0b11010 @ r @ value
    adi {r: register}, {value: u8} => 0b11011 @ r @ value
    sbi {r: register}, {value: u8} => 0b11100 @ r @ value
    wri {r: register}, {value: u8} => 0b11101 @ r @ value
    psi {value: u8}                => 0b11110000 @ value

    imm {r: register}, {value: u8} => asm {
        imc {r}, value
    }
    imm {r: register}, {value: u16} => asm {
        imu {r}, (value >> 8)`8
        iml {r}, value`8
    }

    psh {r: register} => asm {
        psu {r}
        psl {r}
    }
    psh {value: u16} => asm {
        psi (value >> 8)`8
        psi value`8
    }

    pop {r: register} => asm {
        ppl {r}
        ppu {r}
    }
    ppc {r: register} => asm {
        ppl r
        imu r, 0
    }

    cal {r: register} => asm {
        psh ($ + 6)`16

        jmp {r}
    }

    wr  {addr: register}, {r: register} => asm {
        wru {addr}, {r}
        adi {addr}, 1
        wrl {addr}, {r}
    }
    ;wr  {addr: register}, {val: i16} => asm {
    ;    wri {addr}, (val >> 8)`8
    ;    adi {addr}, 1
    ;    wri {addr}, val`8
    ;}

    ld  {val: register}, {addr: register} => asm {
        ldu {val}, {addr}
        adi {addr}, 1
        ldl {val}, {addr}
    }

    store_all => asm {
        psh a
        psh b
        psh c
        psh d
        psh e
        psh f
        cms
    }
    load_all => asm {
        cml
        pop f
        pop e
        pop d
        pop c
        pop b
        pop a
    }
}