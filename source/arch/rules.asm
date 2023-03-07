#once

#subruledef register
{
    a => 0b000
    b => 0b001
    c => 0b010
    d => 0b011
    e => 0b100
    f => 0b101
    stack => 0b110
    flags => 0b111
}

#subruledef boolean
{
    true => 0x1
    false => 0x0
}

#ruledef
{
    nop => 0b00000000 @ 0b00000000
    ret => 0b00000000 @ 0b00000001

    iml {r: register}, {value: u8} => 0b11000 @ r @ value
    imu {r: register}, {value: u8} => 0b11001 @ r @ value
    adi {r: register}, {value: u8} => 0b11010 @ r @ value
    sbi {r: register}, {value: u8} => 0b11011 @ r @ value
    wrc {r: register}, {value: u8} => 0b11100 @ r @ value

    cal {r: register} => 0b01000 @ r @ 0b00000011
    jmp {r: register} => 0b01000 @ r @ 0b00000100

    je  {r: register} => 0b01000 @ r @ 0b00000101
    jne {r: register} => 0b01000 @ r @ 0b00000110
    jgt {r: register} => 0b01000 @ r @ 0b00000111
    jlt {r: register} => 0b01000 @ r @ 0b00001000
    jof {r: register} => 0b01000 @ r @ 0b00001001
    jno {r: register} => 0b01000 @ r @ 0b00001010

    not {r: register} => 0b01000 @ r @ 0b00001011

    psl {r: register} => 0b01000 @ r @ 0b00001100
    psu {r: register} => 0b01000 @ r @ 0b00001101
    ppl {r: register} => 0b01000 @ r @ 0b00001110
    ppu {r: register} => 0b01000 @ r @ 0b00001111

    cma {r: register} => 0b01000 @ r @ 0b00001001
    cmb {r: register} => 0b01000 @ r @ 0b00001010

    mov {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000000

    add {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000001
    sub {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000010

    and {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000011
    or  {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000100
    xor {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000101

    shr {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000110
    shl {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000111

    wpl {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00001000
    wpu {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00001001
    lpl {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00001010
    lpu {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00001011
}

#ruledef
{
    imm {r: register}, {value: u16} => 0b11000 @ r @ value`8 @ 0b11001 @ r @ (value >> 8)`8

    psh {r: register} => 0b01000 @ r @ 0b00001100 @ 0b01000 @ r @ 0b00001101
    pop {r: register} => 0b01000 @ r @ 0b00001110 @ 0b01000 @ r @ 0b00001111
}