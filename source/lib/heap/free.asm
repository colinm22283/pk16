#once

free: ; [ ptr, ret ]
    sbi stack, 2
    pop f
    sbi f, 2
    ; f contains the address of the tag

    nop
    nop
    nop

    ldu a, f
    adi f, 1
    ldl a, f
    ; a contains the block tag

    imm b, 0x7FFF
    and b, a
    ; b contains the size of the block to be freed

    ; wrl f, b
    ; sbi f, 1
    ; wru f, b
    ; the tag is now considered freed

    mov a, f
    ; a contains the initial address + 1

    add f, b
    adi f, 1
    ldu c, f
    adi f, 1
    ldl c, f
    ; c contains the next tag
    ; f contains the address of the next tag + 1

    adi b, 2
    ; b contains what the tag should be if next is not free/

    imm d, 0x8000
    and d, c
    cma d
    imm e, 0
    cmb e
    imm e, .skip_1
    jne e
        ; if next tag is free
        ; c contians the size of the next tag

        add b, c
        ; b contains the size of the new tag

        wrl a, b
        sbi a, 1
        wru a, b

        imm a, .skip_2
        jmp a
    .skip_1:
        ; if next tag is not free
        wrl a, b
        sbi a, 1
        wru a, b
    .skip_2:

    ; return
    adi stack, 4
    pop a
    sbi stack, 2
    jmp a