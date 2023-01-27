# Opcodes

| name | opcode            | arguments             |
|------|-------------------|-----------------------|
| nop  | 00000000-00000000 |                       |
| ret  | 00000000-00000001 |                       |
| mov  | 01000xxx-00000000 | x: source, y: dest    |
| flp  | 01000yyy-00000001 | y: register           |
| cal  | 01000xxx-00000011 | x: register           |
| jmp  | 01000xxx-00000100 | x: register           |
| je   | 01000xxx-00000101 | x: register           |
| jne  | 01000xxx-00000110 | x: register           |
| jgt  | 01000xxx-00000111 | x: register           |
| jlt  | 01000xxx-00001000 | x: register           |
| jof  | 01000xxx-00001001 | x: register           |
| jno  | 01000xxx-00001010 | x: register           |
| not  | 01000yyy-00001011 | y: register           |
| psh  | 01000xxx-00001100 | x: register           |
| pop  | 01000yyy-00001101 | y: register           |
| mov  | 10yyyxxx-00000000 | x: source, y: dest    |
| add  | 10yyyxxx-00000001 | x: source, y: dest    |
| sub  | 10yyyxxx-00000010 | x: source, y: dest    |
| and  | 10yyyxxx-00000011 | x: source, y: dest    |
| or   | 10yyyxxx-00000100 | x: source, y: dest    |
| xor  | 10yyyxxx-00000101 | x: source, y: dest    |
| shr  | 10yyyxxx-00000110 | x: source, y: dest    |
| shl  | 10yyyxxx-00000111 | x: source, y: dest    |
| iml  | 11000xxx-yyyyyyyy | x: register, y: value |
| imu  | 11001xxx-yyyyyyyy | x: register, y: value |
| adi  | 11010yyy-xxxxxxxx | y: register, x: value |
| sbi  | 11011yyy-xxxxxxxx | y: register, x: value |