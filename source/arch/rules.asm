#once

#subruledef register
{
    a => 0b000
    b => 0b001
    c => 0b010
    d => 0b011
    e => 0b100
    f => 0b101
    stack => 0b110 ; points to next position in stack
    flags => 0b111
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
    hlt => 0b00000000 @ 0b10000000

    ; single register instructions
    jmp {r: register} => 0b01000 @ r @ 0b10000000
    je  {r: register} => 0b01000 @ r @ 0b10000001
    jne {r: register} => 0b01000 @ r @ 0b10000010
    jgt {r: register} => 0b01000 @ r @ 0b10000011
    jlt {r: register} => 0b01000 @ r @ 0b10000100
    jof {r: register} => 0b01000 @ r @ 0b10000101
    jno {r: register} => 0b01000 @ r @ 0b10000110

    not {r: register} => 0b01000 @ r @ 0b01011000

    rlr {r: register} => 0b01000 @ r @ 0b01011001
    rll {r: register} => 0b01000 @ r @ 0b01011010

    psl {r: register} => 0b01000 @ r @ 0b00100000
    psu {r: register} => 0b01000 @ r @ 0b00100001
    ppl {r: register} => 0b01000 @ r @ 0b00110010
    ppu {r: register} => 0b01000 @ r @ 0b00101011

    cma {r: register} => 0b01001 @ r @ 0b00000000
    cmb {r: register} => 0b01001 @ r @ 0b00000001

    ; 2 register instructions
    mov {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b01011000
    add {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011000
    sub {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10011001
    and {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10110000
    or  {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10110001
    xor {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b10110010
    wrl {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00100000
    wru {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00100001
    ldl {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00100010
    ldu {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00100011

    ; immediate instructions
    iml {r: register}, {value: u8} => 0b11000 @ r @ value
    imu {r: register}, {value: u8} => 0b11001 @ r @ value
    imc {r: register}, {value: u8} => 0b11010 @ r @ value
    adi {r: register}, {value: u8} => 0b11011 @ r @ value
    sbi {r: register}, {value: u8} => 0b11100 @ r @ value
    wrc {r: register}, {value: u8} => 0b11101 @ r @ value
    psi {value: u8} => 0b11110000 @ value

    imm {r: register}, {value: u16} => 0b11000 @ r @ value`8 @ 0b11001 @ r @ (value >> 8)`8

    psh {r: register} => asm {
        psu {r}
        psl {r}
    }
    psh {value: u16} => asm {
        psi value >> 8
        psi value
    }

    pop {r: register} => asm {
        ppl {r}
        ppu {r}
    }

    cal {r: register} => asm {
        psh ($ + 6)`16

        jmp {r}
    }
}