#Nick Petro

.data
input: .asciiz "Enter the sequence index: "

.text
la $a0, input
li $v0, 4
syscall
li $v0, 5
syscall
add $a0, $v0, 0

jal FIB

add $s0, $v0, 0
add $a0, $s0, 0
li $v0, 1
syscall
li $v0, 10
syscall

FIB:
bgt $a0,2,NOT_BASE
#base case
addi $v0, $0, 1
jr $ra

NOT_BASE:
addi $sp,$sp,-12
sw $ra,8($sp)
sw $s0,4($sp)
sw $s1,0($sp)

move $s0,$a0

subi $a0,$s0,1
jal FIB
move $s1,$v0
subi $a0,$s0,2

jal FIB
add $v0,$v0,$s1
move $a0,$s0

lw $ra,8($sp)
lw $s0,4($sp)
lw $s1,0($sp)
addi $sp, $sp, 12

jr   $ra