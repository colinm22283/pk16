# README

## Opcodes
### Format
```
0<OSLCT>-<SS><DD>
1<DD><O>-<IMMVAL>

OSLCT/O: select
SS:      source register
DD:      destination register
IMMVAL:  immediate value
```

### List
| Instruction | Description                | Opcode              |
|-------------|----------------------------|---------------------|
| `add`       | DD = DD + SS               | `00000001-<SS><DD>` |
| `sub`       | DD = DD - SS               | `00000011-<SS><DD>` |
| `and`       | DD = DD & SS               | `00000101-<SS><DD>` |
| `or`        | DD = DD \| SS              | `00000111-<SS><DD>` |
| `xor`       | DD = DD ^ SS               | `00001001-<SS><DD>` |
| `shl`       | DD = DD << SS              | `00001011-<SS><DD>` |
| `shr`       | DD = DD >> SS              | `00001101-<SS><DD>` |
| `mov`       | DD = DD ^ SS               | `00001111-<SS><DD>` |
| `jmp`       | Jump                       | `00010001-<SS><DD>` |
| `je`        | Jump equal                 | `00010011-<SS><DD>` |
| `jne`       | Jump not equal             | `00010101-<SS><DD>` |
| `jl`        | Jump less than             | `00010111-<SS><DD>` |
| `jle`       | Jump less than or equal    | `00011001-<SS><DD>` |
| `jg`        | Jump greater than          | `00011011-<SS><DD>` |
| `jge`       | Jump greater than or equal | `00011101-<SS><DD>` |
| `cmp`       | Compare DD to SS           | `00011111-<SS><DD>` |
| `ldl`       | DD lower = mem[SS]         | `00100001-<SS><DD>` |
| `ldu`       | DD upper = mem[SS]         | `00100011-<SS><DD>` |
| `stl`       | mem[DD] = SS lower         | `00100101-<SS><DD>` |
| `stu`       | mem[DD] = SS upper         | `00100111-<SS><DD>` |
| `ppl`       | DD lower = stack[stp]      | `00100001-<SS><DD>` |
| `ppu`       | DD upper = stack[stp]      | `00100011-<SS><DD>` |
| `psl`       | stack[stp] = SS lower      | `00100101-<SS><DD>` |
| `psu`       | stack[stp] = SS upper      | `00100111-<SS><DD>` |
| `iml`       | DD lower = IMMVAL          | `1<DD>000-<IMMVAL>` |
| `imu`       | DD upper = IMMVAL          | `1<DD>001-<IMMVAL>` |
| `adi`       | DD += IMMVAL               | `1<DD>010-<IMMVAL>` |
| `sbi`       | DD -= IMMVAL               | `1<DD>011-<IMMVAL>` |
| `psi`       | DD -= IMMVAL               | `1<DD>100-<IMMVAL>` |
| `int`       | DD -= IMMVAL               | `1<DD>101-<IMMVAL>` |

