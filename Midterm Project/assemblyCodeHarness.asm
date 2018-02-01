#University of Pittsburgh
#COE-147 Project Euler 150
#Instructor: Samuel J. Dickerson
#Teaching Assistants: Shivam Swami (shs173) and Bonan Yan (boy12)
#-------------------------------------------------------------------------------------------------


#Submitted by: Nick Petro
#Partner: Kevin Gilboy

.include "Test1.asm"   #Change the name of the test_file to try different test cases

# In the test_file data is arranged as follows:
# 1) Data is at a location with label 'test'
# 2) The first word pointed by the 'test' variable is the depth of the triangle
# 3) The words following the 'depth' are the elements of the triangle
# 4) The array carries depth*(depth+1)*0.5 number of elements
# 5) Each element is stored as a word (refer Test1.asm).
# 6) Save your final answer in register $a0
# Good Luck!

.data
pass_msg: .asciiz "PASS"
fail_msg: .asciiz "FAIL"
#-------------------------------------------------------------------------------------------------

runSum: .word 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0

.text
#Initialize variables
la $t0, test
addi $t0, $t0, 4 	#$t0 is start of triangle
la $t1, runSum 		#$t1 is start of runSum
lw $s0, test 		#$s0 = numRows
lw $a0, 0($t0)		#initialize minSum as first element	
li $t3, 0 		#$t3 row counter

ROW_SUM:	
	li $t5, 0 	#$t5 sum = 0
	li $t4, -1	#$t4 col counter
	COL_SUM:
		addi $t4, $t4, 1 #increment col
		add $v0, $t3, 0
		add $v1, $t4, 0
		jal GET_INDEX #returns index in $a3
		
		add $t0, $t0, $a3 #increment triangle address to index of interest
		lw $t7,0($t0) #$t7 = element at index of interest
		add $t5, $t5, $t7 #add to running sum
		sw $t5, 0($t1)  #store running sum
		addi $t1, $t1, 4 #increment running sum index
		
		la $t0, test		#reset $t0 to start of the triangle
		addi $t0, $t0, 4 	#$t0 is start of triangle
		blt $t4, $t3, COL_SUM
		addi $t3, $t3, 1	
		blt $t3, $s0, ROW_SUM
		li $v0, -1 #$v0 = rows
ROW:
	addi $v0, $v0, 1
	li $v1, -1 #$v1 = cols
	COL:	
		addi $v1, $v1, 1
		jal CALCULATE #returns tempSum as $a1
		slt $t7, $a1, $a0
		beq $t7, 0, CONTINUE
		addi $a0, $a1, 0 #If tempSum<minSum then minSum = tempSum
		
		CONTINUE:	
		blt $v1, $v0, COL
		blt $v0, $s0, ROW
j FINISH #found answer

CALCULATE:
	#store to stack
	addi $sp, $sp, -12
	sw   $ra, ($sp)	
	sw   $v0, 4($sp)	
	sw   $v1, 8($sp)	
	jal GET_INDEX #returns index in $a3
	
	#initialize variables
	la $s1, test
	addi $s1, $s1, 4 #shift to avoid number of rows
	add $a1, $a3, $s1 #$a1 tempSum = test[$a3]
	lw $a1, 0($a1)
	addi $t3, $v0, 0
	addi $t4, $v1, 0
	addi $s2, $t4, 1 #$s2 = tempCol = col+1
	li $s3, 1 #$s3 = count = 1
	li $s4, 0 #$s4 = sum = 0
	addi $s5, $t3, 1 #botRow = row +1
	
	#for loop
	FOR:
		la $s7, runSum 
		bge $s5, $s0, DONE
		add $v0, $s5, 0 #pass row to GET_INDEX
		add $v1, $s2, 0 #pass tempCol to GET_INDEX
		jal GET_INDEX #returns index in $a3
		addi $s6, $a3, 0 # toAdd = index
		bgt $t4, 0, HIGH_COL #if (col > 0)
		ble $t4, 0, LOW_COL #else
	
	HIGH_COL: #yields sum += (runSum[toAdd]-runSum[toAdd-count])
		add $s7, $s7, $s6 #$s7 = address of runSum[toAdd] 
		lw $t8, 0($s7) #$t8 = runSum[toAdd]
		add $s4, $s4, $t8 #sum += runSum[toAdd]
		sll $t9, $s3, 2
		sub $s7, $s7, $t9 #$s7 = address of runSum[toAdd-count]
		lw $t8, 0($s7) #$t8 = runSum[toAdd-count]
		sub $s4, $s4, $t8 #sum -= runSum[toAdd-count]
		j SMALLER
	LOW_COL: #yields sum += runSum[toAdd]
		add $s7, $s7, $s6 # $s7 = address of runSum[toAdd] 
		lw $t8, 0($s7) #$t8 = runSum[toAdd]
		add $s4, $s4, $t8 #sum += runSum[toAdd]
		j SMALLER
	SMALLER: #compares tempSum and sum
		bge $s4, $a1, INCREMENT#if (sum >= tempSum do nothing)
		addi $a1, $s4, 0
	INCREMENT:
		#increment for loop
		addi $s2, $s2, 1 #tempcol++
		addi $s3, $s3, 1 #count++
		addi $s5, $s5, 1 # botRow +1
		j FOR
	DONE:
		#restore from stack
		lw $v1, 8($sp)	
		lw $v0, 4($sp)
		lw $ra, ($sp)
		addi $sp, $sp, 12
		jr $ra
	
GET_INDEX:
	#store to stack
	addi $sp, $sp, -8
	sw   $ra, ($sp)
	sw   $s0, 4($sp)
	mul $s0, $v0, $v0 #row*row
	add $s0, $s0, $v0 #row*row+row
	div $s0, $s0, 2 #(row*row+row)/2
	add $s0, $s0, $v1 #(row*row+row)/2 + col
	sll $a3, $s0, 2 #multiply index by 4 to navigate to the right word
	#restore from stack
	lw $ra, ($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
 
FINISH:
		
#---------Do NOT modify anything below this line---------------
lw $s0, sol
beq $a0, $s0 pass
fail:
la $a0, fail_msg
li $v0, 4
syscall
j end
pass:
la $a0, pass_msg
li $v0, 4
syscall
end:
#-----END---------------------------------------------------------
