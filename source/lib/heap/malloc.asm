#once

#bank rom
malloc: ; [ size, ret ]
    sbi stack, 2
    pop f
    imm e, .loop

    .loop:


