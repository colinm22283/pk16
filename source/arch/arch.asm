#once

rom_size     = 0x8000
stack_size   = 0x0400
heap_size    = 0x0400

stack_offset = rom_size
heap_offset  = stack_offset + stack_size
ram_offset   = heap_offset + heap_size

peripheral_offset = 0xE000

#bankdef rom
{
    #addr     0x0000
    #size     rom_size
    #outp     0x0000
}
#bankdef stack
{
    #addr     stack_offset
    #size     stack_size
}
#bankdef heap
{
    #addr     heap_offset
    #size     heap_size
}
#bankdef ram
{
    #addr     ram_offset
    #addr_end peripheral_offset
}
#bankdef peripheral
{
    #addr peripheral_offset
    #addr_end 0xFFFF
}