#once


#include "/lib/llist/llist.asm"
#include "/lib/heap/alloc.asm"

#bank rom
main:
    imm a, llist_t.size
    imm b, alloc
    cal b

    psh a

    imm b, llist_init
    cal b

    pop a
    psh a
    imm b, 10
    imm c, llist_add
    cal c

    pop a
    jmp a