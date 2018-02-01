# Nick Petro
.data
msg: .asciiz "Please enter your string:\n"
out: .asciiz "Here is the output: "
buf1: .space 64
buf2: .space 64
 
.text
#Get String
la $a0, msg
li $v0, 4
syscall
la $a0, buf1
li $a1, 64
li $v0, 8
syscall

#Load addresses
la $t0, buf1
addi $t4, $t0, 0
la $s0, buf2
 
LOOP1:
lb $t1, 0($t0)
beq $t1, 0x00, END
beq $t1, 0x20, SPACE
addi $t0, $t0, 1
j LOOP1
 
END:
addi $t3, $t0, 0
subi $t0, $t0, 1
 
SPACE:
addi $t3, $t0, 0
subi $t0, $t0, 1
 
LOOP2:
lb $t2, 0($t0)
sb $t2, 0($s0)
addi $s0, $s0, 1
beq $t0, $t4, DONE
subi $t0, $t0, 1
j LOOP2
 
DONE:
addi $t4, $t3, 1
addi $t0, $t3, 1
beq $t1, 0x20, LOOP1
li $t2, 0x00
sb $t2, 0($s0)

#Print Output
la $a0, out
li $v0, 4
syscall
la $a0, buf2
syscall