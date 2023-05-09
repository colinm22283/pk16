#once

#bank rom
syscall_table:


#ruledef
{
    ; execute a syscall
    ; a: syscall offset
    ; b, c, d, e syscall args
    syscall => asm {
        adi a, syscall_table
        ldl
    }
}