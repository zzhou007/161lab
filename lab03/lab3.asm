# Simple Program that reads in an integer, and casts it to a 
# floating point value. For example the floating point number
# 1.5 has a hex value of 0x3FC00000. This hex number has an
# integer value of 1,069,547,520.
#
# Sample Input : 1069547520
# Sample Output: 1.50000000

.text
#SETUP:
#	subu $sp, $sp, 32
#	sw $ra, 20($sp)
#	sw $fp, 16($sp)
#	addiu $fp, $sp, 28

MAIN:
	#clear after every run
	move $t0, $0
	move $t1, $0
	move $t2, $0
	move $t3, $0
	move $t4, $0
	move $t5, $0
	move $t6, $0
	move $t7, $0

	move $s0, $0
	move $s1, $0
	move $s2, $0
	move $s3, $0
	move $s4, $0
	move $s5, $0
	move $s6, $0
	move $s7, $0
	
	#print newline
	la $a0, NEWLINE
	li $v0, 4
	syscall
	
	#ask user what type of conversion
	#and print the string
	la $a0, MAIN_ASK_TYPE 
	li $v0, 4
	syscall
	
	#gets input
	li $v0, 5
	syscall
	
	#goto the conversion type
	bnez  $v0, FLOAT_TO_FIXED		#type 0
	beq $v0, $0, FIXED_TO_FLOAT		#type 1
	
	#loop back
	j MAIN




#################################################################################################
#converts float to fixed PART 2
#################################################################################################
FLOAT_TO_FIXED:

#print test string
#	la $a0, FLOAT_TO_FIXED_TEST_STR
#	li $v0, 4
#	syscall

	#ask user for dec point
	#and print the string
	la $a0, GET_DEC_POINT
	li $v0, 4
	syscall
	#get dec point
	li $v0, 5
	syscall
	
	#store dec point to s0
	move $s0, $v0
	
	#ask for float
	la $a0, GET_FLOAT
	li $v0, 4
	syscall
	
	#get float
	li $v0, 6
	syscall
	
	#store float
	#move $s1, $v0
	
	#move int to 
	mfc1 $t1, $f0
	add $t2, $0, $t1
	#move mantisa to the rightmost
	rol $t3, $t2, 9
	
	#do weird shit
	andi $t3, $t3, 0x000000FF
	andi $t2, $t2, 0x007FFFFF
	ori $t2, $t2, 0x00800000
	subi $t3, $t3, 127
	add $t3, $t3, $s0
	not $t3, $t3
	addi $t3, $t3, 1
	addi $t3, $t3, 23
	
	FLOAT_TO_FIXED_LOOP:
		beqz $t3, FLOAT_TO_FIXED_LOOP_END
		srl $t2, $t2, 1
		subi $t3, $t3, 1
		j FLOAT_TO_FIXED_LOOP
		
	FLOAT_TO_FIXED_LOOP_END:
	bgez $t1, FLOAT_TO_FIXED_IS_POS_OR_NEG
	#is negative
	not $t2, $t2
	addi $t2, $t2, 1
	
	FLOAT_TO_FIXED_IS_POS_OR_NEG:
	move $a0, $t2
	li $v0, 1
	syscall
	j MAIN
j MAIN




#################################################################################################
#converts fixed to float PART 1
#################################################################################################
FIXED_TO_FLOAT:

#print test string
#	la $a0, FIXED_TO_FLOAT_TEST_STR
#	li $v0, 4
#	syscall
	#ask user for dec point
	#and print the string
	la $a0, GET_DEC_POINT
	li $v0, 4
	syscall
	
	#get dec point
	li $v0, 5
	syscall
	
	#store dec point to s0
	move $s0, $v0
	
	#ask for int
	la $a0, GET_INT
	li $v0, 4
	syscall
	
	#get int
	li $v0, 5
	syscall

	#store int
	move $s1, $v0
	move $t4, $v0

	#goes to positiove or neg no change 
	bgez $s1, FIXED_TO_FLOAT_POS_OR_NEG
	#goes to positive or neg with not
	not $s1, $s1
	addi $s1, $s1, 1
	j FIXED_TO_FLOAT_POS_OR_NEG
	
j MAIN


#checks if zero and prints number if not zero if zero just prints
FIXED_TO_FLOAT_POS_OR_NEG:
	beqz $s1, FIXED_TO_FLOAT_IS_ZERO 
	
	#set exponent 
	addi $t3, $0, 31
	#set temp variable for int
	move $t5, $s1
	#do loop that shifts int until the leftmost is a one
	FIXED_TO_FLOAT_POS_OR_NEG_LOOP:	
		andi $t7, $t5, 0x80000000
		#branch when leftmost bit is a 1
		beq $t7, 0x80000000, FIXED_TO_FLOAT_POS_OR_NEG_END
		#shift int over 1
		sll $t5, $t5, 1
		#subtract one from exponent
		subi $t3, $t3, 1
		j FIXED_TO_FLOAT_POS_OR_NEG_LOOP
	
	#sets up float for printing
	FIXED_TO_FLOAT_POS_OR_NEG_END:
	#removes leftmost bit
	andi $t5, $t5, 0x7FFFFFFF
	#shifts mantisa into place
	srl $t5, $t5, 8
	#set up our exponent
	#subtract for currnt exp with input exponent
	sub $t3, $t3, $s0
	#add bias
	addi $t3, $t3, 127
	#shift into place
	sll $t3, $t3, 23
	#add to answer
	add $t5, $t5, $t3
	#checks if pos or negative
	move $t7, $0
	andi $t7, $t4, 0x80000000
	beq $t7, $0, FIXED_TO_FLOAT_IS_POS
	
	#not positive setup add leftmost bit
	ori $t5, $t5, 0x80000000
	
	FIXED_TO_FLOAT_IS_POS:
	#prints
	mtc1 $t5, $f12
	li $v0, 2
	syscall
	
	j MAIN

#Is zero just print int 
FIXED_TO_FLOAT_IS_ZERO:
	move $a0, $s1
	li $v0, 1
	syscall
j MAIN

DONE:



.data
GET_DEC_POINT:
	.asciiz "ENTER DEC POINT: \n"
GET_FLOAT:
	.asciiz "ENTER FLOAT NUMBER: \n"
GET_INT:
	.asciiz "ENTER INT NUMBER: \n"
FIXED_TO_FLOAT_TEST_STR:
	.asciiz "FIXED_TO_FLOAT"
MAIN_ASK_TYPE:
	.asciiz "ENTER 0 for FIXED to FLOAT 1 for FLOAT to FIXED: \n"
FLOAT_TO_FIXED_TEST_STR:
	.asciiz "FLOAT_TO_FIXED"
NEWLINE:
	.asciiz "\n"
ANSWER:
	.asciiz "The output is: "
