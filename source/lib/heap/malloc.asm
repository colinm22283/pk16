#once

#bank rom

; format
; [ ptr to previous block size ] [ block size tag ] [ block ]

; size tag: first bit is free status of block 0 = free

; a: size MUST BE ALIGNED TO 4 BITS
; returns a: ptr to alloced region
malloc: ; [ ret ]
    ; first find a block

    mov f, a
    imm e, heap_offset
    ; f contains size
    ; e contains the current heap ptr

    imm a, .locate_loop
    jmp a

    .locate_loop_start:
        imm b, 0x7FFF
        and b, a ; b: size of block
        add a, b
        adi a, 1
    .locate_loop:
        adi e, 2
        ld  a, e

        ; check if block is free
        imm b, 0x8000
        and b, a
        cma b
        imm c, 0
        cmb c
        imm d, .locate_loop_start
        jgt d ; jump if not free

        ; check if block is large enough
        imm b, 0x7FFF
        and b, a ; b: size of block
        sbi b, 4
        cma b
        cmb f
        jlt d ; D MUST REMAIN

    ; a valid is found!
    ; e will point to the end of the block tag

    adi e, 1
    psh e
    sbi e, 1

    ; split the block
    ldl a, e
    sbi e, 1
    ldu a, e
    ; a contains size of the old block
    mov b, f
    imm c, 0x8000
    or  b, c
    wru e, b
    adi e, 1
    wrl e, b

    ; go to where the new tag will be
    add e, f
    adi e, 1

    ; write the new tag
    pop b
    wr  e, b
    adi e, 1
    sub a, f
    sbi a, 2
    wr  e, a

    mov a, b
    pop b
    jmp b