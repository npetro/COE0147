# Nick Petro
.data
msg: .asciiz "Please enter your string:\n"
out: .asciiz "Here is the output: "
string: .space 64
 
.text
#Get String
la $a0, msg
li $v0, 4
syscall
la $a0, string
li $a1, 64
li $v0, 8
syscall

#Load and hold compare values
la $t0, string
li $s0, 0x61 #Start of lowercase (a)
li $s1, 0x7a #End of lowercase (z)
li $s2, 0x41 #Start of uppercase (A)
li $s3, 0x5a #End of uppercase (Z)
li $s4, 0x00 #End of string

LOOP:
lb $t1, 0($t0)
beq $t1, $s4, END
blt $t1, $s0, TEST2
bgt $t1, $s1, TEST2
subi $t1, $t1, 32
sb $t1, 0($t0)
j NEXT
 
TEST2:
blt $t1, $s2, NEXT
bgt $t1, $s3, NEXT
addi $t1, $t1, 32
sb $t1, 0($t0)
 
NEXT:
addi $t0, $t0, 1
j LOOP
 
END:
la $a0, out
li $v0, 4
syscall
la $a0, string
syscall