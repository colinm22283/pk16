#once

#subruledef register
{
    ra => 0b000
    rb => 0b001
    rc => 0b010
    rd => 0b011
    re => 0b100
    rf => 0b101
    rs => 0b110
    ro => 0b111
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
    clr {r: register} => 0b01000 @ r @ 0b00000010

    cal {r: register} => 0b01000 @ r @ 0b00000011
    jmp {r: register} => 0b01000 @ r @ 0b00000100

    je  {r: register} => 0b01000 @ r @ 0b00000101
    jne {r: register} => 0b01000 @ r @ 0b00000110
    jgt {r: register} => 0b01000 @ r @ 0b00000111
    jlt {r: register} => 0b01000 @ r @ 0b00001000
    jof {r: register} => 0b01000 @ r @ 0b00001001
    jno {r: register} => 0b01000 @ r @ 0b00001010

    not {r: register} => 0b01000 @ r @ 0b00001011

    psh {r: register} => 0b01000 @ r @ 0b00001100
    pop {r: register} => 0b01000 @ r @ 0b00001101

    cma {r: register} => 0b01000 @ r @ 0b00001001
    cmb {r: register} => 0b01000 @ r @ 0b00001010

    mov {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000000

    add {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000001
    sub {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000010

    and {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000011
    or  {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000100
    xor {rd: register}, {rs: register} => 0b10 @ rs @ rd @ 0b00000101
}

#ruledef
{
    imm {r: register}, {value: u16} => 0b11000 @ r @ value`8 @ 0b11001 @ r @ (value >> 8)`8
}