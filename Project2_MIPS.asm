.data
#read file
	obuffer : .space 22
	buffer: .space 32
	Time: .space 11

	TIME_1: .space 11
	TIME_2:	.space 11

	fin : .asciiz "input.txt"
	fout : .asciiz "output.txt"
	
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
	newline: .asciiz "\r\n"

	ArrayOption: .word do1,do2,do3,do4,do5,do6,do7,do8,do9
# nhaptime va convert
	msgNgay: 	.asciiz "nhap ngay DAY (DD): "
	msgThang: 	.asciiz "nhap thang MONTH (MM): "
	msgNam: 	.asciiz "nhap nam YEAR (YYYY): "
	errMsg: 	.asciiz "Ngay khong hop le !"
	kq_convert:	.space 20

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
	#---
	#uncomment ben duoi de test thay doi ham nhap
	#la $s2, Time <- truyen bien vao cho nay, time1, time2, time3..
	#jal nhapTime
	
	#la $a0, Time
	#li $v0, 4
	#syscall
	#---

Exit:
	li $v0,10
	syscall


#Ham----------------------------
Menu:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	#####################NHAP TIME################################ Them vao day
	jal nhapTime
	
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
	la 	$a0,fin
	jal 	File.Read

#Tach obuffer -> TIME_1 , TIME_2
	la 	$a0,obuffer
	la 	$a1,TIME_1
	la 	$a2,TIME_2

	jal 	Time.Split

	la	$a0,TIME_1
	jal	TIME.Default

	la	$a0,TIME_2
	jal	TIME.Default

	la $a0,fout
	jal File.Write

	la $a0,TIME_1
	jal Month
	move $a0,$v0
	li $v0,1
	syscall


	j 	Menu.End



Menu.End:
	lw	$ra, 0($sp)

	addi	$sp, $sp, 4
	jr 	$ra



#$a0 = Time(dd mm yyyy)
#return $a0 = Time (dd/mm/yyyy)
TIME.Default:
	addi	$sp,$sp,-12
	sw	$ra,0($sp)
	sw	$a0,4($sp)
	sw	$t0,8($sp)

	li $t0,'\\'
	
	sb $t0,2($a0)
	sb $t0,5($a0)

	lw	$ra,0($sp)
	lw	$a0,4($sp)
	lw	$t0,8($sp)
	addi	$sp,$sp,12
	jr	$ra


#$a0 = file name output
File.Write:
#open file for wirte
	addi	$sp,$sp,-16
	sw	$ra,0($sp)
	sw	$a0,4($sp)
	sw	$s6,8($sp)
	sw	$v0,12($sp)
	
	li      $v0,13                  
	li      $a1,1                   
	li      $a2,0                   
	syscall
	bltz	$v0,ERROR            
	move   	$s6,$v0                 
#write file
	la	$a1,TIME_1
	jal	fputs

	la	$a1,newline
	jal	fputs

	la	$a1,TIME_2
	jal	fputs

#close file
	li	$v0,16
	move	$a0,$s6
	syscall

	lw	$ra,0($sp)
	lw	$a0,4($sp)
	lw	$s6,8($sp)
	lw	$v0,12($sp)
	addi	$sp,$sp,16
	jr $ra

#$a0 = fileName Input
#KQ = obuffer
File.Read:
	subi	$sp,$sp,24
	sw	$ra,0($sp)
	sw 	$s6,4($sp)
	sw 	$v0,8($sp)
	sw  	$a0,12($sp)
	sw	$a1,16($sp)
	sw	$a2,20($sp)
#open file
	li 	$v0,13
	li 	$a1,0
	li 	$a2,0
	syscall

	bltz 	$v0,ERROR
	move 	$s6,$v0
#read file
	li 	$v0,14
	move 	$a0,$s6
	la 	$a1,obuffer
	li 	$a2,22
	syscall
#lose file
	li 	$v0,16
	move 	$a0,$s6
	syscall

	lw 	$ra,0($sp)
	lw 	$s6,4($sp)
	lw 	$v0,8($sp)
	lw  	$a0,12($sp)
	lw 	$a1,16($sp)
	lw 	$a2,20($sp)
	addi 	$sp,$sp,24
	jr 	$ra
ERROR:
	li 	$v0,4
	la 	$a0,errorInput

	li 	$v0,10
	syscall

#$a0 = obuffer
#$a1 = TIME_1
#$a2 = TIME_2

Time.Split:
	subi 	$sp,$sp,24
	sw 	$ra,0($sp)
	sw 	$a0, 4($sp)
	sw 	$a1, 8($sp)
	sw 	$a2, 12($sp)
	sw 	$t0,16($sp)
	sw 	$t2,20($sp)

#Lay TIME_1
	li 	$t0,10
loopTime_1:
	beq 	$t0,$0,loopTime_1.Out
	lb 	$t2,0($a0)
	sb 	$t2,0($a1)
	addi 	$a0,$a0,1
	addi 	$a1,$a1,1
	subi 	$t0,$t0,1
	
	j 	loopTime_1
loopTime_1.Out:


	
#lay TIME_2
	li 	$t0,10
	addi 	$a0,$a0,2
loopTime_2:
	beq 	$t0,$0,loopTime_2.Out
	lb 	$t2,0($a0)
	sb 	$t2,0($a2)
	addi 	$a0,$a0,1
	addi 	$a2,$a2,1
	subi 	$t0,$t0,1
	
	j 	loopTime_2
loopTime_2.Out:

	lw 	$ra,0($sp)
	lw 	$a0, 4($sp)
	lw 	$a1, 8($sp)
	lw 	$a2, 12($sp)
	lw 	$t0,16($sp)
	lw 	$t2,20($sp)
	addi 	$sp,$sp,24
	jr 	$ra

	
#$a1 = string 
fputs:
	subi 	$sp,$sp,12
	sw 	$ra,0($sp)
	sw 	$v0,4($sp)
	sw 	$a2,8($sp)
	move    $a2,$a1                 # get buffer address

fputs_loop:
	lb      $t0,0($a2)              # get next character -- is it EOS?
	addiu   $a2,$a2,1               # pre-increment pointer
	bnez    $t0,fputs_loop          # no, loop

	subu    $a2,$a2,$a1             # get strlen + 1
	subiu   $a2,$a2,1               # compensate for pre-increment

	move    $a0,$s6                 # get file descriptor
	li      $v0,15                  # syscall for write to file
	syscall

	lw $ra,0($sp)
	lw $v0,4($sp)
	lw $a2,8($sp)
	addi $sp,$sp,12
	jr      $ra                     # return


#$a0 = source1, $a2 = source2 ,$a1 = Destination
Str.Concatenate:
	subi 	$sp,$sp,4
	sw 	$ra,0($sp)
# Copy first string to result buffer
	jal 	Str.Copier
	nop
# Concatenate second string on result buffer
	la 	$a0, ($a2)
	or 	$a1, $v0, $zero
	jal 	Str.Copier
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra


#$a0 = source1 $a1 = Destination
#$v0 = result
Str.Copier:
	subi 	$sp,$sp,4
	sw 	$ra,0($sp)
	sw 	$t0,4($sp)
	sw 	$t1,8($sp)

	or 	$t0, $a0, $zero # Source
	or 	$t1, $a1, $zero # Destination

loopCopier:
	lb 	$t2, 0($t0)
	beq 	$t2, $zero, loopCopier.out
	addiu 	$t0, $t0, 1
	sb 	$t2, 0($t1)
	addiu 	$t1, $t1, 1
	b 	loopCopier
loopCopier.out:
	or 	$v0, $t1, $zero # Return last position on result buffer
	lw 	$ra,0($sp)
	lw 	$t0,4($sp)
	lw 	$t1,8($sp)
	addi 	$sp,$sp,12
	jr 	$ra

CanChi:
	subi	$sp,$sp,8
	sw 	$ra,0($sp)
	
	li 	$a3,2019

#tinh toan can = (nam + 6 )%10
	move 	$t0,$a3
	addi 	$t0,$t0,6
	li 	$t3,10
	div 	$t0,$t3
	mfhi 	$t0

#tinh toan chi = (nam + 8) %12
	move 	$t1,$a3
	addi 	$t1,$t1,8
	li 	$t3,12
	div 	$t1,$t3
	mfhi 	$t1

#Nhan can * 4 , Chi * 4

	li 	$t3,4
	mult 	$t3,$t1
	mflo 	$t1

	mult 	$t3,$t0
	mflo 	$t0

#Point address arry Can,Chi
	la 	$t3,Can
	la 	$t4,Chi

#lay vi tri tuong ung
	add 	$t3,$t3,$t0
	add 	$t4,$t4,$t1

	la 	$a0,($t3)
	lw 	$a2, ($t4)
	la 	$a1, CanChi.Result

	jal 	Str.Concatenate

	la 	$a0,CanChi.Result
	li 	$v0,4
	syscall
	
	lw 	$ra,0($sp)
	addi 	$sp,$sp,8
	jr 	$ra

#----------------BHUY
.globl nhapTime
	#ngay nhap se luu vao $15, dang int
	#thang nhap se luu vao $14, dang int
	#nam nhap se luu vao $10, dang int
	#void nhapTime
	nhapTime:
	move 	$sp, $ra
	li 	$2, 4
	la 	$4, msgNgay
	syscall
	li 	$2, 5
	syscall
	move 	$15, $2
	
	
	li 	$2, 4
	la 	$4, msgThang
	syscall
	li 	$2, 5
	syscall
	move 	$14, $2
	
	
	li 	$2, 4
	la 	$4, msgNam
	syscall
	li 	$2, 5
	syscall
	move 	$10, $2
	
	jal 	check
	
	move 	$ra, $sp
	jr 	$ra
	
.globl is_leap_year
	#bool is_leap_year(int year)
	#a0 = year
	is_leap_year:
	move 	$k0, $a0
        li      $v0, 0                  # mac dinh k nhuan

        li      $t0, 4                  # t0 = 4
        divu    $a0, $t0                # year/4
        mfhi    $t1                     # tim so du
        bne     $t1, $zero, exit        # khong chia het cho 4
	
        li      $t0, 100                # $t0 = 100
        div    	$a0, $t0                # year/100
        mfhi    $t1                     
        bne     $t1, $zero, set_true    # k chia het cho 100 (year < 100)

        # chia het cho 100
        # va chia het cho 400 thi ok
        li      $t0, 400                # $t0 = 400
        divu    $a0, $t0                # year/400
        mfhi    $t1                     
        bne     $t1, $zero, exit        # k chia het cho 400
set_true:
        addi    $v0, $v0, 1             # true
exit:
	move 	$a0, $k0
        jr      $ra			#return

.globl slNgay
	#int slNgay(int thang, int nam)
	#thang = $14
	#nam = $10
	
	slNgay:
	move 	$s1, $ra
	beq 	$14, 1, slngay31
	beq 	$14, 3, slngay31
	beq 	$14, 5, slngay31
	beq 	$14, 7, slngay31
	beq 	$14, 8, slngay31
	beq 	$14, 10, slngay31
	beq 	$14, 12, slngay31
	
	beq 	$14, 4, slngay30
	beq 	$14, 6, slngay30
	beq 	$14, 9, slngay30
	beq 	$14, 11, slngay30
	
	slngaythang2:
	move 	$a0, $10
	jal 	is_leap_year
	beq 	$v0, 0, thang2khongnhuan
	
	beq 	$v0, 1, thang2nhuan
	
	thang2nhuan:
	li 	$a0, 29
	move 	$ra, $s1
	jr 	$ra
	
	thang2khongnhuan:
	li 	$a0, 28
	move 	$ra, $s1
	jr 	$ra
	
	slngay31:
	li 	$a0, 31
	jr 	$ra
	
	slngay30:
	li 	$a0, 30
	jr 	$ra
	

.globl check
	# check(int ngay, int thang, int nam)
	# false thi exit program
	# true thi vi tri $s2 se mang gia tri cua ngay vua nhap
	check:
	move 	$t9, $ra
	#kiem tra nam 0k
	sgt 	$t1, $10, $zero
	beqz 	$t1, false 
	
	#kiem tra thang 0k
	li 	$t5, 0 #thang > 0
	sgt 	$t1, $14, $t5
	beqz 	$t1, false
	
	li 	$t5, 13 #thang < 13
	slt 	$t1, $14, $t5
	beqz 	$t1, false
	
	#kiem tra ngay
	li 	$t5, 0
	sgt 	$t1, $15, $t5 #if ngay > 0 -> t1 = 1
	beqz 	$t1, false #if t1 = 0 -> ngay < 1 -> false
	
	jal 	slNgay
	#a0 = slngay
	#neu ngay > a0 return false
	
	
	ble 	$15, $a0, true
	
	false:
	la 	$a0, errMsg
	li 	$v0, 4
	syscall
	
	li 	$v0, 10
	syscall
	
	true:
	# neu true thi bat dau luu vao time
	la 	$s1, ($s2) #load s2 vao s1 (s2 co the = time1, time2, time3, vv)
      	
      	move $a0, $15
      	jal itoa
      	
      	lb 	$t4, 0($s0)
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
 
      	lb 	$t4, 1($s0)
      	beq	$t4, '\0', nex1
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
      	nex1:
      	li 	$t4, '/'
      	sb	$t4, ($s1)
      	add	$s1, $s1, 1
      	
      	move $a0, $14
      	jal itoa
      	
      	lb 	$t4, 0($s0)
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o

      	lb 	$t4, 1($s0)
      	beq	$t4, '\0', nex2		# neu gap null thi nex
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
      	nex2:
      	li 	$t4, '/'
      	sb	$t4, ($s1)
      	add	$s1, $s1, 1
      	
      	move $a0, $10
 	jal itoa
 	
 	lb 	$t4, 0($s0)
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
      	
      	lb 	$t4, 1($s0)
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
 	
 	lb 	$t4, 2($s0)
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
      	
      	lb 	$t4, 3($s0)
      	sb   	$t4, ($s1)     		# luu vao time
      	add  	$s1, $s1, 1    		# len 1 o
      	
 	addi 	$s1, $s1, 1
 	li 	$t4, '\0' 		#null terminator
 	sb 	$t4, ($s1)
	
	move 	$ra, $t9
	jr 	$ra
	
.globl itoa
# a0 = num
# s0 = addr cua return value
# char* itoa(int n)
itoa:
	move 	$s5, $ra
      	la   	$t0, buffer    		# load buf
      	add  	$t0, $t0, 30   		# seek the end
      	sb   	$0, 1($t0)     		# null-terminated str
      	sb   	$t1, ($t0)     		# init. with ascii 0
      	li   	$t3, 10        		# t3 = 10
      	beq  	$a0, $0, end_itoa 	# =0 thi end
	
	loop_itoa:
      	div  	$a0, $t3       		# a /= 10
      	mflo 	$a0
      	mfhi 	$t4            		# lay mod =
      	add  	$t4, $t4, '0'  		# int -> char
      	sb   	$t4, ($t0)     		# luu vao buf
      	sub  	$t0, $t0, 1    		# lui buf ve 1 o
      	bne  	$a0, $0, loop_itoa  	# neu chua = 0 thi tiep tuc
      	addi 	$t0, $t0, 1    		# len buf 1 o de ve dung' vi tri
	
	end_itoa:
      	move 	$s0, $t0      		# tra dia chi str ve s0
      	move 	$ra, $s5
      	jr   	$ra      

.globl convert

convert:
	move $s6, $ra
	# ngay $15
	# thang $14
	# nam $10
	# type $13
	li $13, 'B'
	
	la 	$a1, kq_convert
	
	beq 	$13, 'A', A
	beq 	$13, 'B', B
	beq 	$13, 'C', C
	A:
	move $a0, $14
      	jal itoa
      	
      	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
 
      	lb 	$t4, 1($s0)
      	beq	$t4, '\0', cnex1
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	cnex1:
      	li 	$t4, '/'
      	sb	$t4, ($a1)
      	add	$a1, $a1, 1
      	
      	move $a0, $15
      	jal itoa
      	
      	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o

      	lb 	$t4, 1($s0)
      	beq	$t4, '\0', cnex2		# neu gap null thi nex
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	cnex2:
      	li 	$t4, '/'
      	sb	$t4, ($a1)
      	add	$a1, $a1, 1
      	
      	move $a0, $10
 	jal itoa
 	
 	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
      	lb 	$t4, 1($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
 	
 	lb 	$t4, 2($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
      	lb 	$t4, 3($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
 	addi 	$a1, $a1, 1
 	li 	$t4, '\0' 		#null terminator
 	sb 	$t4, ($a1)
 	
      	move 	$ra, $s6
      	jr 	$ra
	B:#s3s4s7t7 free
	beq 	$14, 1, thang1
	beq 	$14, 2, thang2
	beq 	$14, 3, thang3
	beq 	$14, 4, thang4
	beq 	$14, 5, thang5
	beq 	$14, 6, thang6
	beq 	$14, 7, thang7
	beq 	$14, 8, thang8
	beq 	$14, 9, thang9
	beq 	$14, 10, thang10
	beq 	$14, 11, thang11
	beq 	$14, 12, thang12
	
	thang1:#kq=a1
	li 	$t4, 'J'
	sb 	$t4, ($a1)
	add	$a1, $a1, 1
	
	li 	$t4, 'a'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'n'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang2:
	li 	$t4, 'F'
	sb 	$t4, ($a1)
	add	$a1, $a1, 1
	
	li 	$t4, 'e'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'b'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang3:
	li 	$t4, 'M'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'a'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'r'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang4:
	li 	$t4, 'A'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'p'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'r'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang5:
	li 	$t4, 'M'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'a'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'y'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1 
	j 	next
	thang6:
	li 	$t4, 'J'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'u'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'n'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang7:
	li 	$t4, 'J'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'u'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'l'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang8:
	li 	$t4, 'A'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'u'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'g'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang9:
	li 	$t4, 'S'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'e'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'p'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang10:
	li 	$t4, 'O'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'c'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 't'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang11:
	li 	$t4, 'N'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'o'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'v'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	next
	thang12:
	li 	$t4, 'D'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'e'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'c'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	next:
	
	li 	$t4, ' '
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	move 	$a0, $15
      	jal 	itoa
      	
      	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
 
      	lb 	$t4, 1($s0)
      	beq	$t4, '\0', Bnex
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
	Bnex:
	
	li 	$t4, ','
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, ' '
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	move 	$a0, $10
 	jal 	itoa
 	
 	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
      	lb 	$t4, 1($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
 	
 	lb 	$t4, 2($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
      	lb 	$t4, 3($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
 	addi 	$a1, $a1, 1
 	li 	$t4, '\0' 		#null terminator
 	sb 	$t4, ($a1)
	
	move 	$ra, $s6
	jr 	$ra
	C:
	move 	$a0, $15
      	jal 	itoa
      	
      	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
 
      	lb 	$t4, 1($s0)
      	beq	$t4, '\0', Cnex
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
	Cnex:
	li 	$t4, ' '
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	beq 	$14, 1, thang1C
	beq 	$14, 2, thang2C
	beq 	$14, 3, thang3C
	beq 	$14, 4, thang4C
	beq	$14, 5, thang5C
	beq 	$14, 6, thang6C
	beq 	$14, 7, thang7C
	beq 	$14, 8, thang8C
	beq 	$14, 9, thang9C
	beq 	$14, 10, thang10C
	beq 	$14, 11, thang11C
	beq 	$14, 12, thang12C
	
	thang1C:#kq=a1
	li 	$t4, 'J'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'a'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'n'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang2C:
	li 	$t4, 'F'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'e'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'b'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang3C:
	li 	$t4, 'M'
	sb 	$t4, ($a1)
	add	$a1, $a1, 1
	
	li 	$t4, 'a'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, 'r'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang4C:
	li 	$t4, 'A'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'p'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'r'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang5C:
	li 	$t4, 'M'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'a'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'y'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1 
	j 	nextC
	thang6C:
	li 	$t4, 'J'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'u'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'n'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang7C:
	li 	$t4, 'J'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'u'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'l'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang8C:
	li 	$t4, 'A'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'u'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'g'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang9C:
	li 	$t4, 'S'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'e'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'p'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang10C:
	li 	$t4, 'O'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'c'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 't'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang11C:
	li 	$t4, 'N'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'o'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'v'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	j 	nextC
	thang12C:
	li 	$t4, 'D'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'e'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	li 	$t4, 'c'
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	nextC:
	li 	$t4, ','
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	li 	$t4, ' '
	sb 	$t4, ($a1)
	add 	$a1, $a1, 1
	
	
	
	move 	$a0, $10
 	jal 	itoa
 	
 	lb 	$t4, 0($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
      	lb 	$t4, 1($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
 	
 	lb 	$t4, 2($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
      	lb 	$t4, 3($s0)
      	sb   	$t4, ($a1)     		# luu vao time
      	add  	$a1, $a1, 1    		# len 1 o
      	
 	addi 	$a1, $a1, 1
 	li 	$t4, '\0' 		#null terminator
 	sb 	$t4, ($a1)
	
      	move 	$ra, $s6	
	jr 	$ra
#---------------------------------
#---------------------------------Anh huy
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



