#----------------------------------------------------------------
#
#  4190.308 Computer Architecture (Fall 2020)
#
#  Project #3: RISC-V Assembly Programming
#
#  October 26, 2020
#
#  Injae Kang (abcinje@snu.ac.kr)
#  Sunmin Jeong (sunnyday0208@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#----------------------------------------------------------------


	.text
	.align	2

#---------------------------------------------------------------------
#  int decode(const char *inp, int inbytes, char *outp, int outbytes)
#---------------------------------------------------------------------
# a0 = 0x80010034 : pointer to inp[0] 
# a1 = 0x00000007 : value of inbytes
# a2 = 0x8001fef0 : pointer to outp[0]
# a3 = 0x00000100 : maximum of outbytes
# a4
# a5
# sp = 0x8001fef0
# x0, ra, sp, a1 ~ a5 
	.globl	decode
decode:
	# TODO
	addi sp, sp, -20		# need stack to store ra, a0, a1, a2, a3
	sw ra, 0(sp)			# 0x8001fedc storing ra
	sw a0, 4(sp)			# 0x8001fee0 storing input pointer
	sw a1, 8(sp)			# 0x8001fee4 storing cnt
	sw a2, 12(sp)			# 0x8001fee8 storing output pointer
	sw a3, 16(sp)			# 0x8001feec storing outbytes
	sw zero, 0(a2)			# initiate 0x8001fef0
	beq a1, zero, Ret0		# if inbytes is 0, then goto Ret0
# STEP 1. RANK

	lw a0, 0(a0)			# Rank1
	jal ra, bigEnd
	addi sp, sp, -8			# need stack to store rank
	sw a0, 0(sp)			# 0x8001fed4 storing rank1
					# Rank2	
	addi a1, zero, -1		# i = -1	
	addi a3, zero, 28		# k = 32
	addi a4, zero, 0		# R2 = 0
Rfor1:
	addi a1, a1, 1			# i++
	addi a5, zero, 16		# tmp = 16
	bge a1, a5, Exit1		# if i >= 16, goto Exit1 			
	addi a2, zero, -4		# j = -4
Rfor2:
	addi a2, a2, 4			# j+=4
	addi a5, zero, 32		# tmp = 32
	bge a2, a5, Exit2		# if j >= 32, goto Exit2
	srl a5, a0, a2			# a5 = R1>>j
	andi a5, a5, 0xf		# a5 = 0xf & R1>>j
	bne a1, a5, Rfor2		# if i != (f & R1>>j), goto Rfor2	
Exit2:
	addi a5, zero, 32		# tmp = 32
	blt a2, a5, Rfor1		# if j < 32, goto Rfor1 
	sll a5, a1, a3			# tmp = i<<k
	add a4, a4, a5			# R2 += tmp
	addi a3, a3, -4			# k -= 4
	beq zero, zero, Rfor1		# goto Rfor1 in any case
Exit1:
	sw a4, 4(sp)			# 0x8001fed8 storing rank2
# a0 has the first rank
# a1 has i
# a2 has j
# a3 has k
# a4 has the second rank
# a5 has temp
# sp = 0x8001fed4
# x0, ra, sp, a1 ~ a5 

#STEP 2. DECODE

	lw a0, 12(sp)			# load the input pointer to a0
	addi a0, a0, 4			# second data
	lw a0, 0(a0)			# load the second data to a0
	jal ra, bigEnd			# change endianness of a0
	srli a2, a0, 28			# pad
	lw a1, 16(sp)			# load the cnt
	addi a1, a1, -4			# cnt = inp - 4
	slli a1, a1, 3			# cnt = cnt*8
	addi a1, a1, -4			# subtract 1st 4-bits from cnt
	sub a1, a1, a2			# subtract pad from cnt
	slli a0, a0, 4			# erase padding bits from data
	addi a2, zero, 4		# s = 4		
	addi a3, zero, 0		# i = 0
	
# a0 has a 
# a1 has cnt
# a2 has s
# a3 is for i
# a4 is for x
# a5 is for bit
# sp = 0x8001fed4
# x0, ra, sp, a1 ~ a5
while:
	addi a3, a3, 1			# count loop i(count digit (= 0.5 byte))
	lw a5, 24(sp)			# output maximum
	addi a4, a3, 1			# a4 = i+1
	srli a4, a4, 1			# a4 = (i+1)>>1
	blt a5, a4, Overflow		# if length > outbytes, then goto Overflow 
	andi a4, a3, 7			# a4 = i & 7
	addi a5, zero, 1		# a5 = 1
	bne a4, a5, isThree		# if i & 7 ! = 1, goto four(otherwise, i is multiple of 8+1)
	beq a3, a5, isThree		#if i == 1, goto four
	lw a5, 20(sp)			# a5 = output pointer
	addi a5, a5, 4			# goto next output pointer
	sw a5, 20(sp)			# store	the next pointer
	sw zero, 0(a5)			# initiate the value		
isThree:
	srli a4, a0, 31			# a>>30
	bne a4, zero, four
	srli a4, a0, 29			# x = a >> 29
	addi a5, zero, 3		# bit = 3
	beq zero, zero, ExitSw
four:
	srli a4, a0, 30			# a>>30
	addi a5, zero, 2		# 10xx
	bne a4, a5, isFive		# if a>>30 != 2 then goto isFive
	addi a5, zero, 31		# a5 = 31
	beq a2, a5, checkEdge		# if s == 31 then check the edge case
isFourEdge:
	addi a5, zero, 4		# bit = 4
	srli a4, a0, 28			# x = a >> 28
	addi a4, a4, -4			# x -= 4 (to make 1011 be 111)
	beq zero, zero, ExitSw
checkEdge:
	lw a5, 12(sp)			# load the input pointer to a5
	addi a5, a5, 4			# go to the next pointer
	lw a5, 4(a5)			# a5 has next a
	srli a5, a5, 7			# first bit of a checking
	andi a5, a5, 1			# a5 & 1
	bne a5, zero, isFive		# if a5 == 1, goto isFiveEdge
	beq x0, x0, isFourEdge		# if a5 == 0. goto isFourEdge		
isFive:
	addi a5, zero, 5		# bit = 5
	srli a4, a0, 27			# x = a >> 27
	addi a4, a4, -16		# x -= 16 (to make 11011 be 1011)
	beq zero, zero, ExitSw		
ExitSw:
	sub a1, a1, a5			# cnt -= bit
	add a2, a2, a5			# s += bit
	addi a2, a2, -32		# s = s-32 		
	bge a2, zero, lwNext		# if s>=32 then goto lwNext
	sll a0, a0, a5			# a = a << bit
	addi a2,a2, 32			# s = s+32
	beq zero, zero, ProcessX	# goto ProcessX
lwNext: 
	lw a0, 12(sp)			# load the input pointer to a0
	addi a0, a0, 4			# go to the next pointer
	sw a0, 12(sp)			# store the next pointer
	lw a0, 4(a0)			# a0 has next a
	jal ra, bigEnd			# change the endianness of a
	beq a2, zero, ProcessX		# if a2 is zero(s = 32), then goto ProcessX
	addi a5, zero, 32		# 32
	sub a5, a5, a2			# 32-s
	srl a5, a0, a5			# a >> 32-s
	add a4, a4, a5			# x += a >> 32-s
	sll a0, a0, a2			# a = a << s
ProcessX:
# a0 has a 
# a1 has cnt
# a2 has s
# a3 is for i
# a4 is for x
# a5 is for bit
# sp = 0x8001fed4
# x0, ra, sp, a1 ~ a5 
	addi a5, zero, 8		# 8 
	bge a4, a5, PRank2		# if x >= 8, then goto PRank2
	slli a5, a4, 2			# a5 = 4x
	sub a5, zero, a5		# a5 = -4x
	addi a5, a5, 28			# a5 = 28 - 4x
	lw a4, 0(sp)			# load Rank1 to a4
	srl a5, a4, a5			# a5 = R1 >> (28 - 4x)
	andi a5, a5, 0xf		# a5 = f & (R1 >> (28 - 4x))
	beq zero, zero, ExitPR		# goto EPR
PRank2:
	slli a5, a4, 2			# a5 = 4x
	sub a5, zero, a5		# a5 = -4x
	addi a5, a5, 60			# a5 = 60 - 4x
	lw a4, 4(sp)			# load Rank2 to a4
	srl a5, a4, a5			# a5 = R2 >> (60 - 4x)
	andi a5, a5, 0xf		# a5 = f & (R2 >> (60 - 4x))
ExitPR:
	slli a5, a5, 28			# 0xX0000000
	addi a4, a3, -1			# a4 = i - 1
	andi a4, a4, 7			# a4 = (i - 1) & 7, we denote this as k
	
	srli a4, a4, 1			# a4 = k >> 1
	slli a4, a4, 3			# a4 = 8(k >> 1)
	sub a4, zero, a4		# a4 = -8(k >> 1)
	addi a4, a4, 28			# a4 = 28 - 8(k >> 1)
	srl a5, a5, a4			# a5 = a5 >> (24 - 8(k >> 1))
	andi a4, a3, 1			# a4 = i & 1
	slli a4, a4, 2			# a4 = 4(i & 1)
	sll a5, a5, a4			# a5 = a5 << 4(i & 1)
	lw a4, 20(sp)			# load output pointer to a4 = 0x8001fef0
	lw a4, 0(a4)			# load output value of the pointer to a4
	add a4, a4, a5			# update output
	lw a5, 20(sp)			# load output pointer to a5 = 0x8001fef0
	sw a4, 0(a5)			# store the output
	bge zero, a1, ExitW		# if 0 >= cnt-pad then goto ExitW
	beq x0, x0, while		# loop
ExitW:
	addi sp, sp, 8			# free the stack which stores the rank
	lw ra, 0(sp)			# load initial ra
	addi sp, sp, 20			# free the stack which stores ra, inp,inbytes, outp, outbytes
	addi a3, a3, 1
	srli a3, a3, 1
	addi a0, a3, 0			# a0 = (i+1)>>1 (, which is the output byte length)
	ret
Overflow:
	addi sp, sp, 8			# free the stack which stores the rank
	lw ra, 0(sp)			# load initial ra
	addi sp, sp, 20			# free the stack which stores ra, inp,inbytes, outp, outbytes
	addi a0, zero, -1		# a0 = -1
	ret
Ret0:
	addi sp, sp, 20			# free the stack which stores ra, inp,inbytes, outp, outbytes
	addi a0, zero, 0		# a0 = 0
	ret

bigEnd:
	addi sp, sp, -8			# need stack to store a4, a5
	sw a4, 0(sp)
	sw a5, 4(sp)
	#now every register available, and we change a0
	slli a4, a0, 24			# a4 = 0x26000000
	srli a0, a0, 8			# a0 = 0x00002088
	slli a5, a0, 24			# a5 = 0x88000000
	srli a5, a5, 8			# a5 = 0x00880000
	add a4, a4, a5			# a4 = 0x26880000
	srli a0, a0, 8			# a0 = 0x00000020
	slli a5, a0, 24			# a5 = 0x20000000
	srli a5, a5, 16			# a5 = 0x00002000
	add a4, a4, a5			# a4 = 0x26882000
	srli a0, a0, 8			# a0= 0x00000000
	add a0, a0, a4			# a0 = 0x26882000
	lw a4, 0(sp)			# load the original value of a4
	lw a5, 4(sp)			# load the original value of a5
	addi sp, sp, 8			# free the stack 
	jalr x0, 0(ra)			# go to original point		
