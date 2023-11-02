#once

#include "/lib/math/mult.asm"

#bank rom
syscall_table:
    #d16 m_mult

#ruledef
{
    ; execute a syscall
    ; e: syscall offset
    ; a, b, c, d syscall args
    syscall => asm {
        adi a, syscall_table
        ld  f, a
        cal f
    }
}