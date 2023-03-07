#once

#bank rom
seg_dig_lut: #d8 0b11111100

seg_send_number:
    pop b
    imm a, seg_dig_lut

    add a, b

    ; lpl out, a

    ret

seg_send_sequence:
    pop d
    pop c
    add d, c
    adi d, 1
    cmb d
    cma c

    imm e, seg_send_number
    imm f, .loop
    .loop:
        lpl d, c
        psh d
        cal e

        imm d, 1000
        psh d
        imm a, delay
        cal a

        jlt f
        je f

    ret