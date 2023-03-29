# Microcode Bus

| name        | width | description |
|-------------|-------|-------------|
| value_1     | 16    |             |
| value_2     | 16    |             |
| operation   |       |             |
| destination |       |             |

# Microcode Operations
| name        | description                                         |
|-------------|-----------------------------------------------------|
| mov         | returns the value_1 line                            |
| add         | returns the sum of the value lines                  |
| and         | returns the bitwise and of the value lines          |
| or          | returns the bitwise or of the value lines           |
| xor         | returns the bitwise exclusive or of the value lines |
| not         | returns the bitwise not of the value_1 line         |
| pop         | returns the value at the stack head                 |
| write lower | enables lower register writing              |
| write upper | enables upper register writing              |

# Microcode Modifiers
| name        | description                                 |
|-------------|---------------------------------------------|
| negate      | negates value 2                             |
| push        | pushes final result                         |
