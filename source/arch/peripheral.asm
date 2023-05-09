#once

#bank pic_stack
#res pic_stack_size

#bank peripheral
flags: #res 1
    .carry         = 0b00000001
    .carry_disable = 0b00000010
    .shutdown      = 0b00000100
    .reserved      = 0b11111000

pbus:
    .internal:
        ..a: #res 3
        ..b: #res 3
    .ps2:
        ..a: #res 1
        ..b: #res 1

timer:
    .a:
        ..period:  #res 1
        ..config:  #res 1
    .b:
        ..period:  #res 1
        ..config:  #res 1

    .config_enable      = 0b00000001
    .config_div         = 0b00011110
    .config_div_1       = 0b00000000
    .config_div_2       = 0b00000010
    .config_div_8       = 0b00000100
    .config_div_32      = 0b00000110
    .config_div_128     = 0b00001000
    .config_div_256     = 0b00001010
    .config_div_512     = 0b00001100
    .config_div_1024    = 0b00001110
    .config_div_2048    = 0b00010000
    .config_div_4096    = 0b00010000
    .config_div_8192    = 0b00010010
    .config_div_16384   = 0b00010100
    .config_div_32768   = 0b00010110
    .config_div_65536   = 0b00011000
    .config_div_131072  = 0b00011010
    .config_div_262144  = 0b00011100
    .config_div_524288  = 0b00011110
    .config_reserved    = 0b11100000


pic:
    .a:
        ..address: #res 2
        ..config:  #res 1
    .b:
        ..address: #res 2
        ..config:  #res 1
    .c:
        ..address: #res 2
        ..config:  #res 1

    .config_enable     = 0b00000001
    .config_ext_int    = 0b00000010
    .config_inta_int   = 0b00000100
    .config_intb_int   = 0b00001000
    .config_ps2a_rec   = 0b00010000
    .config_ps2b_rec   = 0b00100000
    .config_timera_ovf = 0b01000000
    .config_timerb_ovf = 0b10000000
    .config_reserved   = 0b00000000