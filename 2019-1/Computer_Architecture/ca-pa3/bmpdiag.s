#--------------------------------------------------------------
# 
#  4190.308 Computer Architecture (Spring 2019)
#
#  Project #3: Drawing diagonal lines in an image
#
#  April 24, 2019.
#
#  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#--------------------------------------------------------------

.text
	.align 4
.globl bmp_diag
	.type bmp_diag,@function

bmp_diag:
	#------------------------------------------------------------
	# Use %rax, %rcx, %rdx, %rsi, %rdi, and %r8 registers only
	#	imgptr is in %rdi, address of memory
	#	width  is in %rsi, scalar
	#	height is in %rdx, scalar
	#	gap    is in %rcx, scalar
    #   pad    is in %rax, scalar
    #   row_index is in %rax inside paint_row
    #   row_start_index is in %r8
    #   initial gap is in %r8 inside paint_row
	#------------------------------------------------------------

	# --> FILL HERE <--
    pushq %rsi
    callq get_padding
    popq %rsi

    movq %rcx, %r8

.row_iter:
    pushq %rdi
    pushq %rax
    callq paint_row
    popq %rax
    popq %rdi
    # index calculation
    
    addq (%rax, %rsi, 2), %rdi
    addq %rsi, %rdi
    #addq (%rax, %rsi, 3), %rdi

    decq %rdx
    cmpq $0x00, %rdx
    jle .row_iter

    ret

get_padding:
.gp_0:
    cmpq $0x04, %rsi
    jl   .gp_1
    subq $0x04, %rsi
    jmp  .gp_0

.gp_1:
    negq %rsi
    addq $0x04, %rsi
    movq %rsi, %rax
    ret

.nuliffy:
    movq $0x00, %r8
    jmp .nullified

paint_row:
    # initialize for the row
    addq $0x03, %r8
    cmpq %rcx, %r8
    jge .nuliffy
.nullified:

    movq $0x00, %rax

    addq %r8, %rdi

.paint_px:
    # turn to red
    movb $0x00, (%rdi)
    movb $0x00, 1(%rdi)
    movb $0xff, 2(%rdi)

    addq (, %rcx, 2), %rdi
    addq %rcx, %rdi
    #addq (,%rcx,3), %rdi
    incq %rax

    # if %rax < %rsi, that is, current width < width
    cmpq %rsi, %rax
    jl .paint_px
    
    ret

	# Example: Initially, the %rdi register points to the first 
	# pixel in the last row of the image.  The following three 
	# instructions change its color to red.

	# movb 	$0x00, (%rdi)			# blue
	# movb	$0x00, 1(%rdi)			# green
	# movb	$0xff, 2(%rdi)			# red




	#------------------------------------------------------------

	
