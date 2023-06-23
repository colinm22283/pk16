#once


#include "/lib/llist/llist.asm"
#include "/lib/heap/alloc.asm"

#bank rom
main:
    imm a, llist_t.size
    imm b, alloc
    cal b

    imm b, llist_init
    cal b

    imm b, 1
    imm c, llist_push
    cal c
    imm b, 2
    imm c, llist_push
    cal c
    imm b, 3
    imm c, llist_push
    cal c

    psh a
    imm a, 10
    imm b, alloc
    cal b
    mov f, a
    pop a
    psh f
    psh f

    imm b, llist_pop
    cal b
    pop f
    wr  f, b
    adi f, 1
    psh f

    imm b, llist_pop
    cal b
    pop f
    wr  f, b
    adi f, 1
    psh f

    imm b, llist_pop
    cal b
    pop f
    wr  f, b
    adi f, 1

    imm b, free
    cal b

    pop a
    imm b, free
    cal b

    pop a
    jmp a
