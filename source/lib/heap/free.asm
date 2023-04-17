#once

free: ; [ ptr, ret ]
    sbi stack, 2
    pop f

    ldu a, f
    adi f, 1
    ldl a, f
    ; a contains the block tag

    imm b, 0x7FFF
    and b, a
    ; b contains the size of the block to be freed

    wrl f, b
    sbi f, 1
    wru f, b

    ; the tag is now considered frees

    ; join with the next blocks

    ; return