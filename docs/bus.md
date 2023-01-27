# Bus Spec

| name                        | width | description                            |
|-----------------------------|-------|----------------------------------------|
| opcode format               | 4     | determines opcode format               |
| source register select      | 3     | determines the source register         |
| destination register select | 3     | determines the destination register    |
| source value                | 16    | carries the source register value      |
| destination value           | 16    | carries the destination register value |
| write value                 | 16    | carries the write register value       |
