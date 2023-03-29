

| name                        | width | description                            |
|-----------------------------|-------|----------------------------------------|
| opcode format               | 4     | determines opcode format               |
| source register select      | 3     | determines the source register         |
| destination register select | 3     | determines the destination register    |
| source value                | 16    | carries the source register value      |
| destination value           | 16    | carries the destination register value |
| write value                 | 16    | carries the write register value       |

# Bus Spec
#### Width: ```60 bits```
| name              | width | description                                                                                                                                       |
|-------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| value 1           | 16    | value 1 available for register write                                                                                                              |
| value 2           | 16    | value 2                                                                                                                                           |
| write value       | 16    | value to write to register 1                                                                                                                      |
| instruction stage | 3     | shifts up on every clock cycle after instruction has been read, instruction must be completed before stage is 0                                   |
| write register    | 1     | writes the write value to the register selected by value 1                                                                                        |
| write mem         | 1     | writes value value 1 to address specified by value 2                                                                                              |
| read mem          | 1     | reads address specified by value 2 to value 1                                                                                                     |
| stack             | 1     | signifies a stack operation 0: push lower, 1: push upper, 2: pop lower, 3: pop upper                                                              |
| compare           | 1     | activates cma and cmb for value 2 and write value respectively 0: equal, 1: not equal, 2: greater than, 3: less than, 4: overflow, 5: no overflow |
| logical           | 1     | operates on value 1 and value 2 and sends it down write value 0: none, 1: add, 2: sub, 3: and, 4: or, 5: xor, 6: not, 7: rlr                      |
| operation select  | 3     | binary sub operation select                                                                                                                       |