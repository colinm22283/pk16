#bank rom
str:
#d "ABCD\0"

#bank rom
main:
mov f, stp
adi stp, 10
imm e, str
ldl d, e
imu d, 0
adi e, 1
mov b, f
imm c, 0
cma d
cmb c
.L0:
wrl b, d
adi b, 1
ldl d, e
imu d, 0
adi e, 1
imm a, .L0
jne a
.L1:
mov a, f
imm b, 0
imm f, gpu_print_str
cal f
pop f
jmp f

