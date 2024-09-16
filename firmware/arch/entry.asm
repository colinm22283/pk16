#once

stack_top = 0x8000

#bank rom
#addr 0
entry:
    imm rsp, stack_top

    cal main

    .loop:
        jmp .loop

    nop
    nop
    nop