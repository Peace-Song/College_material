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

    #point imgptr to leftuppermost pixel    
    movq %rsi, %r8
    imulq $0x3, %r8
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %r8
    decq %rdx
    imulq %rdx, %r8
    incq %rdx

    addq %r8, %rdi
    
    callq LU_to_RL

    ret

LU_to_RL:
    movq $0x0, %r8

    #temporarily assign current imgptr to %rdx
    pushq %rdx
    movq %rdi, %rdx

    #save original imgptr
    pushq %rdi

    #r8 will incr at the end, considered as pointer not scalar
.paint_next:
    pushq %rdx
    
    #temporarily assign actual length of width to %rdx 
    movq %rsi, %rdx
    imulq $0x3, %rdx
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %rdx
    movq %rdx, %rax
  
    popq %rdx # now %rdx has address of one row above


    movq %rdx, %rdi
    subq %rax, %rdx

    popq %rax
    cmpq %rax, %rdi # compare ptr of this row : original imgptr
    jl .finalize_LU_to_RL
    pushq %rax

    movq $0x0, %rax

    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rax 
    
.paint_row:
    movb $0x00, (%rdi)
    movb $0x00, 1(%rdi)
    movb $0xff, 2(%rdi)

    addq (, %rcx, 2), %rdi
    addq %rcx, %rdi
    inc %rax

    #compare current width : width
    cmpq %rsi, %rax
    jl .paint_row
    
    #compare current initial gap : gap
    cmpq %rcx, %r8
    jl .initial_gap_rising
    movq $0x0, %r8
    jmp .paint_next

    
.initial_gap_rising:
    incq %r8
    jmp .paint_row

.finalize_LU_to_RL:
    popq %rdx
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






   	# Example: Initially, the %rdi register points to the first 
	# pixel in the last row of the image.  The following three 
	# instructions change its color to red.

	# movb 	$0x00, (%rdi)			# blue
	# movb	$0x00, 1(%rdi)			# green
	# movb	$0xff, 2(%rdi)			# red




	#------------------------------------------------------------

	
