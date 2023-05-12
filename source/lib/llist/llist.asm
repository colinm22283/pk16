#once

#include "/lib/heap/alloc.asm"
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
    wr  a, b

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

; a: llist ptr
; b: value
llist_add: ; [ ret ]
    psh b

    ld  b, a
    ; b head ptr
    cma b
    imm c, 0
    cmb c
    imm c, .is_empty
    jne c


    .is_empty:
        psh a
        imm a, llist_node_t.size
        imm b, alloc
        cal b
        pop b
        wr  b, a

        imm c, 0
        wr  a, c
        adi a, 1
        pop c
        wr  a, c

        pop a
        jmp a

    .recur:
