#bank rom
str:
#d "ABCD\0"

#bank rom
main:
mov f, stp
adi stp, 4
imm e, str
ldl d, e
imu d, 0
adi e, 1
imm c, 0
cma d
cmb c
.L0:
wrl f, d
adi f, 1
ldl d, e
imu d, 0
adi e, 1
imm b, .L0
jne b
.L1:
pop f
jmp f

