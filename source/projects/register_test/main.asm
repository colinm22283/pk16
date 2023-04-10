#once

#bank ram
ram_func: #res 16

#bank rom
rom_func: ; f: return
    imc a, 20
    cmb a

    imc c, 0
    imm d, .loop - rom_func + ram_func
    cma c
    .loop:
        adi c, 1

        jlt d

    jmp f

main:
    imm a, rom_func + 22
    cmb a

    imm a, rom_func
    imm b, ram_func
    imm d, .loop
    cma a

    .loop:
        ldl c, a
        wrl b, c

        adi a, 1
        adi b, 1

        jlt d

    imm a, ram_func
    imm f, $ + 6
    jmp a

    imm a, interrupt
    jmp a
