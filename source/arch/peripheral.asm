#once

#bank pic_stack
#res pic_stack_size

#bank peripheral
flags: #res 1
    .carry_out   = 0b00000001
    .carry_in    = 0b00000010
    .reserved    = 0b11111100

pbus:
    .internal:
        ..a: #res 3
    .ps2:
        ..a: #res 1
        ..b: #res 1

pic:
    .a:
        ..address: #res 2
        ..config:  #res 1
    .b:
        ..address: #res 2
        ..config:  #res 1

    .return: #res 2

    .config_enable    = 0b00000001
    .config_inta_int  = 0b00000010
    .config_ps2a_rec  = 0b00000100
    .config_ps2b_rec  = 0b00001000
    .config_reserved  = 0b11110000

#ruledef
{
    int_enter => asm {
        psh a
        psh b
        psh c
        psh d
        psh e
        psh f
        mov a, stack
        imm stack, pic_stack_offset
        psh a
    }
    int_return => asm {
        pop a ; old stack pointer
        mov stack, a

        pop f
        pop e
        pop d
        pop c
        pop b
        pop a

        irt
    }
}