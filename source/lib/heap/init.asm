#once

#bank rom
heap_init: ; [ ret ]
    imm a, heap_size - 2
    imm b, heap_offset
    wru b, a
    adi b, 1
    wrl b, a

    pop a
    jmp a