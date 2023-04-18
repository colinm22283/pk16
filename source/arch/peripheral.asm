#once

#bank peripheral
pbus:
    .internal:
        ..a: #res 3
    .ps2:
        ..a: #res 1
        ..b: #res 1

flags: #res 1
    .carry_out   = 0b00000001
    .carry_in    = 0b00000010
    .reserved    = 0b11111100