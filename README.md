# PK16

## Requirements
Must have [customasm](https://github.com/hlorenzi/customasm) installed and in your path

## Opcodes
### Format
```
0<OSLCT>-<SS><DD>
1<DD><O>-<IMMVAL>

OSLCT/O: operation select
SS:      source register
DD:      destination register
IMMVAL:  immediate value
```

### List
| Instruction | Description                        | Opcode              |
|-------------|------------------------------------|---------------------|
| `mov`       | DD = SS                            | `00000000-<SS><DD>` |
| `add.r`     | DD = DD + SS                       | `00000001-<SS><DD>` |
| `sub.r`     | DD = DD - SS                       | `00000010-<SS><DD>` |
| `and`       | DD = DD & SS                       | `00000011-<SS><DD>` |
| `or`        | DD = DD \| SS                      | `00000100-<SS><DD>` |
| `xor`       | DD = DD ^ SS                       | `00000101-<SS><DD>` |
| `shl`       | DD = DD << SS                      | `00000110-<SS><DD>` |
| `shr`       | DD = DD >> SS                      | `00000111-<SS><DD>` |
| `jmp.l`     | Jump to DD                         | `00010000-<SS><DD>` |
| `br.l`      | Jump if true to DD                 | `00010001-<SS><DD>` |
| `jmp.r`     | Relative jump by DD * 2            | `00010010-<SS><DD>` |
| `br.r`      | Relative jump if true by DD * 2    | `00010011-<SS><DD>` |
| `ce`        | Compare equal                      | `00010100-<SS><DD>` |
| `cl`        | Compare less than                  | `00010111-<SS><DD>` |
| `cle`       | Compare less than or equal         | `00011000-<SS><DD>` |
| `ld.l`      | DD lower = mem[SS]                 | `00100000-<SS><DD>` |
| `ld.u`      | DD upper = mem[SS]                 | `00100010-<SS><DD>` |
| `st.l`      | mem[DD] = SS lower                 | `00100011-<SS><DD>` |
| `st.u`      | mem[DD] = SS upper                 | `00100100-<SS><DD>` |
| `pop.l`     | DD lower = stack[stp]              | `00100101-<SS><DD>` |
| `pop.u`     | DD upper = stack[stp]              | `00100110-<SS><DD>` |
| `psh.l`     | stack[stp] = SS lower              | `00100111-<SS><DD>` |
| `psh.u`     | stack[stp] = SS upper              | `00101000-<SS><DD>` |
| `swi`       | Software interrupt                 | `00110000-<SS><DD>` |
| `irt`       | Interrupt return                   | `00110001-<SS><DD>` |
| `imm.l`     | DD lower = IMMVAL                  | `1<DD>000-<IMMVAL>` |
| `imm.u`     | DD upper = IMMVAL                  | `1<DD>001-<IMMVAL>` |
| `add.i`     | DD += IMMVAL                       | `1<DD>010-<IMMVAL>` |
| `sub.i`     | DD -= IMMVAL                       | `1<DD>011-<IMMVAL>` |
| `psh.i`     | stack[stp] = IMMVAL                | `1<DD>100-<IMMVAL>` |
| `jmp.ri`    | Relative jump by IMMVAL*2          | `1<DD>101-<IMMVAL>` |
| `br.ri`     | Relative jump if true by IMMVAL*2  | `1<DD>110-<IMMVAL>` |


