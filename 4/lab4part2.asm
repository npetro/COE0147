#Nick Petro

.data:
    msg:  .asciiz "The program has finished."

.text
li $a0, 0xFFFF0008
li $a1, 0x55555555
jal drawShape

la $a0, msg
li $v0, 4
syscall
li $v0, 10
syscall

drawShape:
	li $t0, 0
	sw $ra, 0($sp)
	
	drawFirst:
		jal drawPattern
		addi $t0, $t0, 1
		addi $a0, $a0, 32
	bne $t0, 4, drawFirst
	addi $a0, $a0, 4
	li $a1, 0xaaaaaaaa
	
	drawSecond:
		jal drawPattern
		addi $t0, $t0, 1
		addi $a0, $a0, 32
	bne $t0, 8, drawSecond
	lw $ra, 0($sp)
	jr $ra
	
drawPattern:
    sw $a1, ($a0)
	jr $ra  
