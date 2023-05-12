#once

#bank rom
heap_init: ; [ ret ]
    imm a, 0
    imm b, heap_offset
    wr  b, a

    imm a, heap_size - 8
    adi b, 1
    wr  b, a

    imm b, heap_offset + heap_size - 4
    imm a, 0
    wr  b, a
    adi b, 1
    imm a, 0x8000
    wr  b, a

    pop a
    jmp a