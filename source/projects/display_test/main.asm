#once

#include "/lib/display/draw_image.asm"

#bank rom
test_image:
    #d 0x00FFFFFF00
    #d 0xFF000000FF
    #d 0xFF00FF00FF
    #d 0xFF000000FF
    #d 0x00FFFFFF00

main:
    psh test_image
    psh 5
    psh 5
    psh 5
    psh 5
    imm a, draw_image
    cal a

    pop a
    jmp a