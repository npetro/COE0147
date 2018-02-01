# Nick Petro
.text
# Get first number
li $v0, 4
la $a0, first
syscall
li $v0, 5
syscall
move $t0, $v0
# Get second number
li $v0, 4
la $a0, second
syscall
li $v0, 5
syscall
move $t1, $v0
# Sum and Difference
add $t2, $t0, $t1
sub $t3, $t0, $t1
# Print output
li $v0, 4
la $a0, last
syscall
li $v0, 1
add $a0, $t0, $0
syscall
li $v0, 4
la $a0, and
syscall
li $v0, 1
add $a0, $t1, $0
syscall
li $v0, 4
la $a0, is
syscall
li $v0, 1
add $a0, $t2, $0
syscall
li $v0, 4
la $a0, difference
syscall
li $v0, 1
add $a0, $t3, $0
syscall

.data
first: .asciiz "What is the first value?\n"
second: .asciiz "What is the second value?\n"
last: .asciiz "The sum of "
and: .asciiz " and "
is: .asciiz " is "
difference: .asciiz " and their difference is "