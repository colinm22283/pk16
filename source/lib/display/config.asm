#once

#include "/arch/peripheral.asm"

display:
    .width        = 100
    .height       = 75

    .bus          = (ipbus.a)

    .reg:
        ..color   = (.bus + 0)
        ..address = (.bus + 1)