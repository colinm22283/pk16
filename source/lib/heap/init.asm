#once

#bank rom
heap_init: ; [ ret ]
    imm a, 0
    imm b, heap_offset
    wru b, a
    adi b, 1
    wrl b, a

    imm a, heap_size - 4
    adi b, 1
    wru b, a
    adi b, 1
    wrl b, a

    pop a
    jmp a