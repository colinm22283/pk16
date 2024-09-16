#once

ic_config_enable         = 0b10000000

ic_config_inten_software = 0b00000001

#bank periph
#addr 0xFC00
ic0:
    .config:
        #res 1
    .address:
        #res 2

ic1:
    .config:
        #res 1
    .address:
        #res 2

ic2:
    .config:
        #res 1
    .address:
        #res 2