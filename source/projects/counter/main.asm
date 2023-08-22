#once

#include "/lib/gpu/fonts/default.asm"
#include "/lib/gpu/font.asm"

#bank ram
counter: #res 2

#bank rom
ext_int_handler:
    store_all

    imm a, counter
    ld  b, a
    adi b, 1
    sbi a, 1
    wr  a, b
    adi b, 64
    mov a, b
    imm b, 0
    imm f, gpu_print_char
    cal f

    load_all
    irt

main:
    imm a, counter
    imm b, 0
    wr  a, b

    imm a, pic.a.address
    imm b, ext_int_handler
    wr  a, b
    imm a, pic.a.config
    imm b, pic.config_enable | pic.config_ext_int
    wrl a, b

    imm a, .loop
    .loop:
        jmp a