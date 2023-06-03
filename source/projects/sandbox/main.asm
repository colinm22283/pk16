#once

#include "/lib/heap/heap.asm"
#include "/lib/memory/memset.asm"

#bank rom
ext_int_handler:


    irt

main:
    imm a, pic.a.address
    imm b, ext_int_handler
    wr  a, b
    adi a, 1
    imm b, pic.config_enable | pic.config_ext_int
    wrl a, b

    .width = 5
    .height = 5

    imm a, .width * 2
    imm b, alloc
    cal b
    psh a
    mov f, a
    imm a, .width * 2
    add a, f
    psh a
    .alloc_loop:
        psh f

        imm a, .height
        imm b, alloc
        cal b

        cma f

        pop f

        pop c
        cmb c
        psh c

        wr  f, a
        adi f, 1
        imm e, .alloc_loop
        jlt e

    pop f
    psh f
    sbi f, .width * 2
    .free_loop:
        ld  a, f
        adi f, 1
        psh f

        imm b, free
        cal b

        pop f
        cma f

        pop c
        cmb c
        psh c

        imm e, .free_loop
        jlt e

    pop a
    pop a
    imm b, free
    cal b

    imm a, 30
    imm b, alloc
    cal b

    imm b, 0xFF
    imm c, 30
    imm d, memset
    cal d

    pop a
    jmp a