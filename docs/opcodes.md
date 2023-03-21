# Opcodes

| name | opcode            | arguments             | description                                                                            |
|------|-------------------|-----------------------|----------------------------------------------------------------------------------------|
| nop  | 00000000-00000000 |                       | no operation                                                                           |
| hlt  | 00000000-10000000 |                       | return from function and pop from call stack                                           |
| ret  | 00000000-01000000 |                       | return from function and pop from call stack                                           |
| cal  | 01000xxx-00000010 | x: register           | calls an address inside a register                                                     |
| jmp  | 01000xxx-10000000 | x: register           | jumps to an address inside a register                                                  |
| je   | 01000xxx-10000001 | x: register           | jumps if equal                                                                         |
| jne  | 01000xxx-10000010 | x: register           | jumps if not equal                                                                     |
| jgt  | 01000xxx-10000011 | x: register           | jumps if greater than                                                                  |
| jlt  | 01000xxx-10000100 | x: register           | jumps if less than                                                                     |
| jof  | 01000xxx-10000101 | x: register           | jumps if overflow flag is set                                                          |
| jno  | 01000xxx-10000110 | x: register           | jumps if overflow flag not set                                                         |
| not  | 01000yyy-01011000 | y: register           | bitwise invert a register                                                              |
| shr  | 01000yyy-01011001 | y: register           | bitwise invert a register                                                              |
| shl  | 01000yyy-01011010 | y: register           | bitwise invert a register                                                              |
| psl  | 01000xxx-00100000 | x: register           | push the lower values of a register to the stack                                       |
| psu  | 01000xxx-00100001 | x: register           | push the upper values of a register to the stack                                       |
| ppl  | 01000yyy-00110010 | y: register           | pop the lower value from the stack into a register                                     |
| ppu  | 01000yyy-00101011 | y: register           | pop the lower value from the stack into a register                                     |
| mov  | 10xxxyyy-01011000 | x: source, y: dest    | move one register to another                                                           |
| add  | 10xxxyyy-10011000 | x: source, y: dest    | adds two registers and places into y                                                   |
| sub  | 10xxxyyy-10011001 | x: source, y: dest    | subtracts two registers and places into y                                              |
| and  | 10xxxyyy-01011000 | x: source, y: dest    | ands two registers and places into y                                                   |
| or   | 10xxxyyy-01011001 | x: source, y: dest    | ors two registers and places into y                                                    |
| xor  | 10xxxyyy-01011010 | x: source, y: dest    | xors two registers and places into y                                                   |
| wrl  | 10xxxyyy-00100000 | x: ptr, y: val        | write the lower byte of a register to a pointer                                        |
| wru  | 10xxxyyy-00100001 | x: ptr, y: val        | write the upper byte of a register to a pointer                                        |
| rdl  | 10xxxyyy-00110010 | x: ptr, y: dest       | read a pointer to the lower byte of a register                                         |
| rdu  | 10xxxyyy-00101011 | x: ptr, y: dest       | read a pointer to the upper byte of a register                                         |
| iml  | 11000yyy-xxxxxxxx | y: register, x: value | writes an immediate value to the lower byte of a register                              |
| imu  | 11001yyy-xxxxxxxx | y: register, x: value | writes an immediate value to the upper byte of a register                              |
| imc  | 11010yyy-xxxxxxxx | y: register, x: value | writes an immediate value to the lower byte of a register and zeros out the upper byte |
| adi  | 11011yyy-xxxxxxxx | y: register, x: value | add an immediate value to a register                                                   |
| sbi  | 11100yyy-xxxxxxxx | y: register, x: value | subtract an immediate value to a register                                              |
| wri? | 11101yyy-xxxxxxxx | y: ptr, x: value      | write an immediate value to a pointer                                                  |
| psi  | 11110000-yyyyyyyy | y: value              | push an immediate value to the stack                                                   |

# Opcode Formats

## Mode 0 [ 00 ] Simple Operation
    [ format : 2 ]
    [ reserved : 6 ]
    [ halt : 1 ]
    [ return : 1 ]
    [ reserved : 6 ]

## Mode 1 [ 01 ] Single Register Operation
    [ format : 2 ]
    [ reserved : 3 ]
    [ register select : 3 ]
    [ jump instruction : 1 ]
    [ logical instruction : 1 ]
    [ stack instruction : 1 ]
    [ write lower : 1 ]
    [ write upper : 1 ]
    [ operation select : 3 ]

## Mode 2 [ 10 ] Dual Register Operation
    [ format : 2 ]
    [ source register select : 3 ]
    [ destination register select : 3 ]
    [ arithmatic instruction : 1 ]
    [ logical instruction : 1 ]
    [ memory instruction : 1 ]
    [ write lower : 1 ]
    [ write upper : 1 ]
    [ operation select : 3 ]

## Mode 3 [ 11 ] Immediate Value Operation
    [ format : 2 ]
    [ operation select : 3 ]
    [ register select : 3 ]
    [ immediate value : 8 ]