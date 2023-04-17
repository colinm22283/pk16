#once

#bank rom

malloc: ; [ size, ret ]
    sbi stack, 2
    pop f

    imm d, heap_offset
    imm e, .locate_loop
    jmp e

    .next_block: ; a must be the tag
        adi d, 1
        imm b, 0b0111111111111111
        and a, b
        add d, a

        imm pptr, 0xFF

    .locate_loop:
        ldu a, d
        adi d, 1
        ldl a, d

        ; a contains the heap tag

        imm b, 0x8000
        and b, a

        ; if block reserved keep looping
        imc c, 0
        cmb c
        cma b
        imm e, .next_block
        jne e

        ; check if block is big enough
        imm b, 0b0111111111111111
        and b, a
        cmb f
        cma b
        jlt e ; e must be .next_block

    ; allocate!
    wrl d, f
    sbi d, 1
    imm c, 0x8000
    or  c, f
    wru d, c
    adi d, 2

    ; push return reserved pointer
    psh d

    ; b contains the size of the block just absorbed
    ; d contains pointer to the start of reserved memory
    ; e is the pointer to .locate_loop
    ; f is the size of reserved memory

    ; move empty block
    add d, f ; d is the next header pos
    mov a, b
    sub a, f ; a is the size of the new block
    sbi a, 2
    ; write next block section
    wru d, a
    adi d, 1
    wrl d, a

    ; return
    mov a, stack
    ldu b, a
    adi a, 1
    ldl b, a
    jmp b