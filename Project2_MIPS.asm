.data
#read file
	obuffer : .space 22
	buffer: .space 32
	Time: .space 11

	TIME_1: .space 11
	TIME_2:	.space 11
	
	fin : .asciiz "input.txt"
	errorInput: .asciiz "Loi File Input.\n"
#Can---------------------------
	Giap: .asciiz " Giap"
	At: .asciiz " At"
 	Binh: .asciiz " Binh"
	Dinh: .asciiz  " Dinh"
	Mau: .asciiz " Mau"
	Ky: .asciiz " Ky"
	Canh: .asciiz " Canh"
	Tan: .asciiz " Tan"
	Nham: .asciiz " Nham"
	Quy: .asciiz " Quy"
	Can: .word Giap,At,Binh,Dinh,Mau,Ky,Canh,Tan,Nham,Quy
#Chi---------------------------
	Ty: .asciiz " Ty"
	Suu: .asciiz " Suu"
	Dan: .asciiz " Dan"
	Meo: .asciiz " Meo"
	Thin:.asciiz " Thin"
	Ngo: .asciiz " Ngo"
	Mui: .asciiz " Mui"
	Than: .asciiz " Than"
	Dau: .asciiz " Dau" 
	Tuat: .asciiz " Tuat"
	Hoi: .asciiz " Hoi"
	Chi: .word Ty,Suu,Dan,Meo,Thin,Ty,Ngo,Mui,Than,Dau,Tuat,Hoi

	CanChi.Result: .space 20

# menu
	MENU: .asciiz 	"\n----------Ban hay chon 1 trong cac thao tac duoi day----------\n"
	option1: .asciiz	"1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
	option2: .asciiz	"2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n"
	option2a: .asciiz			"\tA. MM/DD/YYYY\n"
	option2b: .asciiz			"\tB. Month DD, YYYY\n"
	option2c: .asciiz			"\tC. DD Month, YYYY\n"
	option3: .asciiz	"3. Kiem tra nam vua nhap co phai la nam nhuan hay khong: \n"
	option4: .asciiz	"4. Ngay vua nhap la ngay thu may trong tuan\n"
	option5: .asciiz	"5. Cho biet ngay vua nhap la ngay thu may ke tu 01/01/0001\n"
	option6: .asciiz	"6. Cho biet Can Chi cua nam vua nhap\n"
	option7: .asciiz 	"7. Cho biet khoang thoi gian tu chuoi Time_1 va Time_2\n"
	option8: .asciiz	"8. Cho biet 2 nam nhuan gan nhat voi TIME\n"
	option9: .asciiz	"9. nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt\n"
	stuff: .asciiz	"---------------------------------------------------------------\n"
	option: .asciiz	"Lua chon: "
	type: .asciiz "Loai (A/B/C): "
	result: .asciiz "\nKet qua: "
	m_continue: .asciiz "\nChon (1) de tiep tuc, (0) de thoat:  "
	newline: .asciiz "\n"

	ArrayOption: .word do1,do2,do3,do4,do5,do6,do7,do8,do9

.text

main:
Running:
	jal	Menu

	la	$a0, m_continue
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall	
	beq	$v0, $0, Exit
	j	Running

Exit:
	li $v0,10
	syscall


#Ham----------------------------
Menu:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	#####################NHAP TIME################################ Them vao day
	
	li	$v0, 4
	la	$a0, MENU
	syscall
	
	la	$a0, option1
	syscall 
	
	la	$a0, option2
	syscall 

	la	$a0, option2a
	syscall 

	la	$a0, option2b
	syscall 

	la	$a0, option2c
	syscall 

	la	$a0, option3
	syscall 

	la	$a0, option4
	syscall 

	la	$a0, option5
	syscall 

	la	$a0, option6
	syscall 

	la	$a0, option7
	syscall 

	la	$a0, option8
	syscall 

	la	$a0, option9
	syscall 

	la	$a0, stuff
	syscall 

	la	$a0, option
	syscall

	la	$v0, 5
	syscall
	
	addi	$v0, $v0, -1
	sll	$v0, $v0, 2
	la	$t0, ArrayOption
	add	$t0, $t0, $v0
	lw	$t0, ($t0)
	jr	$t0


do1:
	li $a0,1
	li $v0,1
	syscall
	j Menu.End

do2:
	li $a0,2
	li $v0,1
	syscall
	j Menu.End

do3:
	li $a0,3
	li $v0,1
	syscall
	j Menu.End

do4:
	li $a0,4
	li $v0,1
	syscall
	j Menu.End

do5:
	li $a0,5
	li $v0,1
	syscall
	j Menu.End

do6:
	li $a0,6
	li $v0,1
	syscall
	j Menu.End

do7:
	li $a0,7
	li $v0,1
	syscall
	j Menu.End

do8:
	li $a0,8
	li $v0,1
	syscall
	j Menu.End

do9:

#Read File --> obuffer 
	jal File.Read

	la $a0,obuffer
	li $v0,4
	syscall


#Tach obuffer -> TIME_1 , TIME_2
	la $a0,obuffer
	la $a1,TIME_1
	la $a2,TIME_2

	jal Time.Split

	la $a0,TIME_1
	li $v0,4
	syscall

	la $a0,newline
	li $v0,4
	syscall

	la $a0,TIME_2
	li $v0,4
	syscall

	j Menu.End



Menu.End:
	lw	$ra, 0($sp)

	addi	$sp, $sp, 4
	jr 	$ra




#$a0 = fileName
#KQ = obuffer
File.Read:
#open file
	subi $sp,$sp,12
	sw $ra,0($sp)
	sw $s6,4($sp)
	sw $v0,8($sp)
#open file
	li $v0,13
	la $a0,fin
	li $a1,0
	li $a2,0
	syscall
	move $s6,$v0
#read file
	li $v0,14
	move $a0,$s6
	la $a1,obuffer
	li $a2,22
	syscall
#lose file
	li $v0,16
	move $a0,$s6
	syscall

	lw $ra,0($sp)
	lw $s6,4($sp)
	lw $v0,8($sp)
	addi $sp,$sp,12
	jr $ra

#$a0 = obuffer
#$a1 = TIME_1
#$a2 = TIME_2

Time.Split:
	subi $sp,$sp,16
	sw $ra,0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)

#Lay TIME_1
	li $t0,10
loopTime_1:
	beq $t0,$0,loopTime_1.Out
	lb $t2,0($a0)
	sb $t2,0($a1)
	addi $a0,$a0,1
	addi $a1,$a1,1
	subi $t0,$t0,1
	
	j loopTime_1
loopTime_1.Out:


	
#lay TIME_2
	li $t0,10
	addi $a0,$a0,2
loopTime_2:
	beq $t0,$0,loopTime_2.Out
	lb $t2,0($a0)
	sb $t2,0($a2)
	addi $a0,$a0,1
	addi $a2,$a2,1
	subi $t0,$t0,1
	
	j loopTime_2
loopTime_2.Out:


	lw $ra,0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	addi $sp,$sp,16
	jr $ra

	


#$a0 = source1, $a2 = source2 ,$a1 = Destination
Str.Concatenate:
	subi $sp,$sp,4
	sw $ra,0($sp)
# Copy first string to result buffer
	jal Str.Copier
	nop
# Concatenate second string on result buffer
	la $a0, ($a2)
	or $a1, $v0, $zero
	jal Str.Copier
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra


#$a0 = source1 $a1 = Destination
Str.Copier:
	subi $sp,$sp,4
	sw $ra,0($sp)
	or $t0, $a0, $zero # Source
	or $t1, $a1, $zero # Destination

loopCopier:
	lb $t2, 0($t0)
	beq $t2, $zero, loopCopier.out
	addiu $t0, $t0, 1
	sb $t2, 0($t1)
	addiu $t1, $t1, 1
	b loopCopier
loopCopier.out:
	lw $ra,0($sp)
	or $v0, $t1, $zero # Return last position on result buffer
	addi $sp,$sp,4
	jr $ra

#dang update
CanChi:
	subi $sp,$sp,8
	sw $ra,0($sp)
	
	li $a3,2019

#tinh toan can = (nam + 6 )%10
	move $t0,$a3
	addi $t0,$t0,6
	li $t3,10
	div $t0,$t3
	mfhi $t0

#tinh toan chi = (nam + 8) %12
	move $t1,$a3
	addi $t1,$t1,8
	li $t3,12
	div $t1,$t3
	mfhi $t1

#Nhan can * 4 , Chi * 4

	li $t3,4
	mult $t3,$t1
	mflo $t1

	mult $t3,$t0
	mflo $t0

#Point address arry Can,Chi
	la $t3,Can
	la $t4,Chi

#lay vi tri tuong ung
	add $t3,$t3,$t0
	add $t4,$t4,$t1

	la $a0,($t3)
	lw $a2, ($t4)
	la $a1, CanChi.Result

	jal Str.Concatenate

	la $a0,CanChi.Result
	li $v0,4
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,8
	jr $ra

