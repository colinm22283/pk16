#once

#include "/lib/gpu/config.asm"
#include "/lib/gpu/clear.asm"
#include "/lib/gpu/colors.asm"
#include "/lib/gpu/font.asm"
#include "/lib/gpu/fonts/default.asm"

#include "/lib/math/mult.asm"

#include "/lib/memory/strcpy.asm"

#bank rom
abc_str: #d "ABC\0"

ext_int_handler:
    store_all

    imm a, color.RED
    imm f, gpu_clear
    cal f

    adi stp, 4
    mov a, stp
    sbi a, 4
    imm b, abc_str
    imm f, strcpy
    cal f

    mov a, stp
    sbi a, 4
    imm b, 0
    imm f, gpu_print_str
    cal f

    sbi stp, 4

    load_all
    irt

main:
    .right_wall = 20
    .left_wall = 2
    .top_wall = 2
    .bottom_wall = 20

    imm a, pic.a.address
    imm b, ext_int_handler
    wr  a, b
    imm a, pic.a.config
    imm b, pic.config_enable | pic.config_ext_int
    wrl a, b

    imm c, 5
    imm d, 5
    imm e, 2
    imm f, 1

    .loop:
        psh c
        psh d
        psh e
        psh f
        psh c

        imm a, gpu_width
        mov b, d
        imm c, m_mult
        cal c

        pop b
        add a, b

        imm b, pbus.internal.a
        wr  b, a
        adi b, 1
        imm a, 0x00
        wrl b, a

        pop f
        pop e
        pop d
        pop c

        add c, e
        add d, f

        cma a

        cmb c
        imm b, .invert_x
        imm a, .right_wall
        jlt b
        imm a, .left_wall
        jgt b

        cmb d
        imm b, .invert_y
        imm a, .bottom_wall
        jlt b
        imm a, .top_wall
        jgt b

        imm b, .skip_invert
        jmp b
        .invert_x:
            ; invert x
            imm b, 0
            sub b, e
            mov e, b

            imm b, .skip_invert
            jmp b
        .invert_y:
            ; invert y
            imm b, 0
            sub b, f
            mov f, b
        .skip_invert:

        imm a, .loop
        jmp a

    pop a
    jmp a