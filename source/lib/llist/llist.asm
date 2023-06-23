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
; returns a: llist ptr
llist_init: ; [ ret ]
    imm b, 0
    wr  a, b
    sbi a, 1

    pop b
    jmp b

; a: llist ptr
llist_destroy:
    ld b, a

; a: llist ptr
; b: value
; returns a: llist ptr, b: value pointer
llist_push: ; [ ret ]
    psh a
    psh b
    imm a, llist_node_t.size
    imm b, alloc
    cal b
    pop c
    pop b

    ; a: alloc ptr
    ; b: llist ptr
    ; c: value

    ld  d, b
    ; d old alloc
    sbi b, 1
    wr  b, a
    sbi b, 1

    wr  a, d
    adi a, 1
    mov d, a
    wr  a, c

    mov a, b
    mov b, d

    pop c
    jmp c

; a: llist ptr
; returns a: llist ptr, b: value
llist_pop: ; [ ret ]
    ld  b, a

    ; a: llist ptr + 1
    ; b: root ptr

    ld  c, b
    ; b: root ptr + 1
    ; c: next.next
    wrl a, c
    sbi a, 1
    wru a, c

    ; a: llist ptr

    mov d, b
    mov c, b
    adi c, 1
    ; c: root value pointer
    ld  b, c

    ; d: root ptr + 1

    psh a
    psh b

    sbi d, 1
    mov a, d
    imm b, free
    cal b

    pop b
    pop a

    pop c
    jmp c