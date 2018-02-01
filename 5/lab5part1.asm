#Nick Petro

.data
str: .space 64
input: .asciiz "Please enter your string: "
Output: .asciiz "Here is the out: "

.text
la $a0, input
li $v0, 4
syscall

la $a0, str 
li $a1, 64
li $v0, 8 
syscall

la $t0, str
li $t1, -1
la $t7, str

CALC_LENGTH:
lb $t2, 0($t0)
beq $t2, 0x0, LENGTH
addi $t1, $t1, 1
addi $t0, $t0, 1
j CALC_LENGTH

LENGTH:
li $t3, 0
sub $t2, $t1, 1
add $a1, $t2, 0
li $v0, 42
LOOP:
jal REPLACE
addi $t3, $t3, 1
bne $t3, 4, LOOP

#exit
la $a0,Output
li $v0,4
syscall

la $a0,str
li $v0,4
syscall

li $v0, 10
syscall

REPLACE:
syscall

add $t4,$t7,$a0 
lb $t5,0($t4)
beq $t5,0x2A,REPLACE
li $t6, 0x2A

sb $t6, 0($t4)

jr $ra