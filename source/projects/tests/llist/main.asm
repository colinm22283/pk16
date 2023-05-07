#once


#include "/lib/llist/llist.asm"

#bank rom
main:
    imm a, 8
    imm b, malloc
    cal b



    mov a, stp
    adi stp, 2

    psh a

    imm b, llist_init
    cal b

    pop a
    imm b, llist_delete
    cal b

    sbi stp, 2

    pop a
    jmp a