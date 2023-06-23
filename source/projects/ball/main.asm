#once

#include "/lib/gpu/config.asm"

#include "/lib/math/mult.asm"

#bank rom
main:
    .right_wall = 20
    .left_wall = 2
    .top_wall = 2
    .bottom_wall = 20

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