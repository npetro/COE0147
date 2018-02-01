# Nick Petro
.data
msg: .asciiz "Please enter your number:\n"
out: .asciiz "Here is the output: "

.text
li $v0, 4
la $a0, msg
syscall
li $v0, 5
syscall
move $t0, $v0

srl $t1, $t0, 19
addi $t2, $t2, 7
and $t1, $t1, $t2

li $v0, 4
la $a0, out
syscall
li $v0, 1
add $a0, $t1, $0
syscall