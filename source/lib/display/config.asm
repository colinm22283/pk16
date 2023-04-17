#once

#include "/arch/peripheral.asm"

display:
    .width        = 100
    .height       = 75

    .bus          = (peripheral_bus.a)

    .reg:
        ..color   = (.bus + 0)
        ..address = (.bus + 1)