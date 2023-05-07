#once

#include "/lib/heap/malloc.asm"
#include "/lib/heap/free.asm"

#bank rom
llist_t:
    .size         = 2
    .head_offset  = 0

llist_node_t:
    .size         = 4
    .next_offset  = 0
    .value_offset = 2

#bank rom
; a: llist ptr
llist_init: ; [ ret ]
    imm b, 0
    wrl a, b
    adi a, 1
    wrl a, b

    pop a
    jmp a

; a: llist ptr
llist_delete: ; [ ret ]
    ldu b, a
    adi a, 1
    ldl b, a

    mov a, b
    imm c, .llist_delete_recur
    cal c

    pop a
    jmp a

    ; a: node ptr
    .llist_delete_recur: ; [ ret ]
        pop f

        cma a
        imm b, 0
        cmb b
        je  f

        mov b, a

        ldu a, b
        adi b, 1
        ldl a, b
        imm c, .llist_delete_recur
        cal c

        mov a, b
        imm c, free
        cal c

        jmp f

llist_add:


    pop a
    jmp a