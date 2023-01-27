#once

main:
    imm ra, 1
    mov rb, ra

    cma rb
    cmb ra

    imm rf, .loop
    .loop:
        mov ro, ra

        mov rc, rb
        add rb, ra
        mov ra, rc

        ; call delay while preserving ra and rb
        psh ra
        psh rb
        imm ra, delay
        cal ra
        pop rb
        pop ra

        jno rf

    ret

delay:
    imm ra, 0
    cma ra

    pop rb
    cmb rb

    imm rb, .loop

    .loop:
        adi ra, 2

        jlt rb

    ret