Date:# Tra ve thoi gian dinh dang mac dinh DD/MM/YY: $a0 = time
	move $v0, $a0
	jr $ra

Day:   # Ngay cua time: $a0 = time
	addi $sp, $sp, -12
	sw $t0, ($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)

	li $t0, '0'
	li $t1, 10

	lb $t2, ($a0)
	sub $t2, $t2, $t0
	mult $t1, $t2
	mflo $v0

	lb $t2, 1($a0)
	sub $t2, $t2, $t0
	add $v0, $v0, $t2
	
	lw $t0, ($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addi $sp, $sp, 12

	jr $ra

Month: # Thang cua time: $a0 = time
	addi $sp, $sp, -12
	sw $t0, ($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)

	li $t0, '0'
	li $t1, 10

	lb $t2, 3($a0)
	sub $t2, $t2, $t0
	mult $t1, $t2
	mflo $v0

	lb $t2, 4($a0)
	sub $t2, $t2, $t0
	add $v0, $v0, $t2
	
	lw $t0, ($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra

Year: # Nam cua time: $a0 = time
	addi $sp, $sp, -12
	sw $t0, ($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)

	li $t0, '0'

	lb $t1, 6($a0) 
	sub $t1, $t1, $t0
	li $t2, 1000
	mult $t2, $t1
	mflo $v0
	
	lb $t1, 7($a0)
	sub $t1, $t1, $t0
	li $t2, 100
	mult $t2, $t1
	mflo $t1
	add $v0, $v0, $t1

	lb $t1, 8($a0)
	sub $t1, $t1, $t0
	li $t2, 10
	mult $t2, $t1
	mflo $t1
	add $v0, $v0, $t1

	lb $t1, 9($a0)
	sub $t1, $t1, $t0
	add $v0, $v0, $t1

	lw $t0, ($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addi $sp, $sp, 12

	jr $ra