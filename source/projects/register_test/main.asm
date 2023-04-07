#bank rom

main:
    not a
    not b
    not c
    not d
    not e
    not f
    not stack
    not flags

interrupt:
    imm a, .loop
    .loop:
        jmp a
