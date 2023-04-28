#once

#bank rom

; format
; [ ptr to previous block size ] [ block size tag ] [ block ]

malloc: ; [ size, ret ]
    sbi stack, 2
    pop f

    ; f: size of section to reserve

    imm d, heap_offset + 2

    ; d is going to be the pointer, needs to be ad a block size tag on start
    .locate_loop:
        ldu a, d
        adi d, 1
        ldl a, d
        ; a contains the block tag size

        imm b, 0b10000000
        and b, a
        ; b > 0 if reserved
        cma b
        imm c, 0
        cmb c
        imm c, ..skip_reserved
        je  c
            ; if reserved
            imm b, 0b01111111
            and b, a
            add d, b
            adi d, 1

            imm c, .locate_loop
            jmp c ; go to next block
        ..skip_reserved:

        imm b, 0b01111111
        and b, a
        cmb f
        imm c, ..skip_small
        jgt c
            ; if too small
            add d, a
            adi d, 1

            imm c, .locate_loop
            jmp c ; go to next block
        ..skip_small:

        ; block is ready!

        ; push the return
        mov e, d
        adi e, 1
        psh e

        ; a contains the block size

        ; write in the new size specifier
        wrl d, f
        sbi d, 1
        wru d, f

        ; go to next tag
        mov c, d
        add d, f
        adi d, 2
        ; c contains the prev tag

        ; write the next prev pointer
        wru d, c
        adi d, 1
        wrl d, c
        adi d, 1

        ; write the next block size
        sub a, f
        sbi a, 4
        wru d, a
        adi d, 1
        wrl d, a

        adi stack, 2
        pop f
        jmp f