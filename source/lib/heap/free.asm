#once

; a: alloc loc
free: ; [ ret ]
    psh a
    sbi a, 2
    ld  e, a
    imm f, 0x7FFF
    and f, e
    ; f: the size of the new block
    ; a is at starting place - 1

    ; join forwards
    add a, f
    adi a, 3
    ; a contains next pointer + 2
    ld  b, a
    imm c, 0x8000
    and c, b
    cma c
    imm d, 0
    cmb d
    imm e, .next_skip
    jne e
        ; if next is free
        imm c, 0x7FFF
        and c, b
        add f, c
        adi f, 4
    .next_skip:

    pop a
    psh a

    ; join backwards
    sbi a, 4
    ld  b, a
    ; b contains prev pointer
    adi b, 2
    ld  c, b
    ; c contains prev tag
    imm d, 0x8000
    and d, c
    cmb d
    imm d, 0
    cma d
    imm e, .prev_not_free
    jne e
        ; prev tag is free
        sbi stp, 2 ; discard a

        imm d, 0x7FFF
        and d, c
        add f, d
        adi f, 4

        wrl b, f
        sbi b, 1
        wru b, f

        pop a
        jmp a
    .prev_not_free:
        ; prev tag is not free
        pop a
        ; a is the original ptr
        sbi a, 2
        ;adi f, 8
        wr  a, f

        pop a
        jmp a