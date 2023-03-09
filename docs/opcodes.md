# Opcodes

| name | opcode            | arguments             | description                                                                            |
|------|-------------------|-----------------------|----------------------------------------------------------------------------------------|
| nop  | 00000000-00000000 |                       | no operation                                                                           |
| ret  | 00000000-00000001 |                       | return from function and pop from call stack                                           |
| flp  | 01000yyy-00000001 | y: register           | swaps the upper and lower bits of a register                                           |
| cal  | 01000xxx-00000010 | x: register           | calls an address inside a register                                                     |
| jmp  | 01000xxx-00000000 | x: register           | jumps to an address inside a register                                                  |
| je   | 01000xxx-00000101 | x: register           | jumps if equal                                                                         |
| jne  | 01000xxx-00000110 | x: register           | jumps if not equal                                                                     |
| jgt  | 01000xxx-00000111 | x: register           | jumps if greater than                                                                  |
| jlt  | 01000xxx-00001000 | x: register           | jumps if less than                                                                     |
| jof? | 01000xxx-00001001 | x: register           | jumps if overflow flag is set                                                          |
| jno? | 01000xxx-00001010 | x: register           | jumps if overflow flag not set                                                         |
| not  | 01000yyy-00001011 | y: register           | bitwise invert a register                                                              |
| psl  | 01000xxx-00001100 | x: register           | push the lower values of a register to the stack                                       |
| psu  | 01000xxx-00001101 | x: register           | push the upper values of a register to the stack                                       |
| ppl  | 01000yyy-00001110 | y: register           | pop the lower value from the stack into a register                                     |
| ppu  | 01000yyy-00001111 | y: register           | pop the lower value from the stack into a register                                     |
| mov  | 10xxxyyy-00000000 | x: source, y: dest    | move one register to another                                                           |
| add  | 10xxxyyy-00000001 | x: source, y: dest    | adds two registers and places into y                                                   |
| sub  | 10xxxyyy-00000010 | x: source, y: dest    | subtracts two registers and places into y                                              |
| and  | 10xxxyyy-00000011 | x: source, y: dest    | ands two registers and places into y                                                   |
| or   | 10xxxyyy-00000100 | x: source, y: dest    | ors two registers and places into y                                                    |
| xor  | 10xxxyyy-00000101 | x: source, y: dest    | xors two registers and places into y                                                   |
| shr? | 10xxxyyy-00000110 | x: source, y: dest    | shifts y right by x                                                                    |
| shl? | 10xxxyyy-00000111 | x: source, y: dest    | shifts y left by x                                                                     |
| wrl  | 10xxxyyy-00001000 | x: ptr, y: val        | write the lower byte of a register to a pointer                                        |
| wru  | 10xxxyyy-00001001 | x: ptr, y: val        | write the upper byte of a register to a pointer                                        |
| rdl  | 10xxxyyy-00001010 | x: ptr, y: dest       | read a pointer to the lower byte of a register                                         |
| rdu  | 10xxxyyy-00001011 | x: ptr, y: dest       | read a pointer to the upper byte of a register                                         |
| iml  | 11000xxx-yyyyyyyy | x: register, y: value | writes an immediate value to the lower byte of a register                              |
| imu  | 11001xxx-yyyyyyyy | x: register, y: value | writes an immediate value to the upper byte of a register                              |
| imc? | 11010xxx-yyyyyyyy | x: register, y: value | writes an immediate value to the lower byte of a register and zeros out the upper byte |
| adi  | 11011yyy-xxxxxxxx | y: register, x: value | add an immediate value to a register                                                   |
| sbi  | 11100yyy-xxxxxxxx | y: register, x: value | subtract an immediate value to a register                                              |
| wri? | 11101xxx-yyyyyyyy | x: register, y: value | write an immediate value to a pointer                                                  |
| psi  | 11110xxx-yyyyyyyy | x: register, y: value | push an immediate value to the stack                                                   |