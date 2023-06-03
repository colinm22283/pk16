#once

#include "/lib/gpu/fonts/default.asm"
#include "/lib/gpu/font.asm"

#include "/lib/heap/heap.asm"

#bank ram
kbd_buf_ptr: #res 2
kbd_buf_pos: #res 1

#bank rom
kbd_handler:
    psh a
    psh b
    psh c

    imm a, pbus.ps2.a
    ldl a, a

    imm b, kbd_buf_ptr
    ld  c, b
    imm b, kbd_buf_pos
    ldl b, b
    imu b, 0
    add c, b
    wrl c, a
    imm c, kbd_buf_pos
    adi b, 1
    wrl c, b

    imm b, 0
    imm c, gpu_print_char
    cal c

    pop c
    pop b
    pop a

    irt

main:
    imm a, 100
    imm b, alloc
    cal b
    imm b, kbd_buf_ptr
    wr  b, a

    imm b, kbd_buf_pos
    imm a, 0
    wrl b, a

    imm a, pic.a.address
    imm b, kbd_handler
    wr  a, b
    adi a, 1
    imm b, pic.config_enable | pic.config_ps2a_rec
    wrl a, b

    imm a, .loop
    .loop:
        jmp a

    imm b, kbd_buf_ptr
    ld  a, b
    imm b, free
    cal b

    pop a
    jmp a