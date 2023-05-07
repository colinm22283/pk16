#once

#bank rom
heap_init: ; [ ret ]
    imm a, 0
    imm b, heap_offset
    wru b, a
    adi b, 1
    wrl b, a

    imm a, heap_size - 8
    adi b, 1
    wru b, a
    adi b, 1
    wrl b, a

    imm a, heap_offset + heap_size - 4
    imm b, heap_offset
    wr  a, b
    adi a, 1
    imm b, 0x8000
    wr  a, b

    pop a
    jmp a