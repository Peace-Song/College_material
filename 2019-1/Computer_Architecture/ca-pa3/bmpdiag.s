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

    /*movq %rsi, %r8
    imulq $3, %r8
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %r8
    decq %rdx
    imulq %rdx, %r8
    incq %rdx

    movq %rdi, %rax # %rax holds original imgptr
    addq %r8, %rdi*/

    call initiate_draw

    call LU2RL


    /*movq %rsi, %r8
    imulq $3, %r8
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %r8
    decq %rdx
    imulq %rdx, %r8
    incq %rdx

    movq %rdi, %rax # %rax holds original imgptr
    addq %r8, %rdi*/

    call initiate_draw

    call RU2LL

    ret

initiate_draw:
    movq %rsi, %r8
    imulq $3, %r8
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %r8
    decq %rdx
    imulq %rdx, %r8
    incq %rdx

    movq %rdi, %rax
    addq %r8, %rdi

    ret


RU2LL:
    movq %rcx, %r8

    #temporarily assign current imgptr to %rdx
    pushq %rdx
    movq %rdi, %rdx

    #save original imgptr
    pushq %rax

    movq $0, %rax # now %rax will work as width indicator
    
    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rdi
    
    addq %r8, %rax

.RU2LL_paint_row:
    movb $0x00, (%rdi)
    movb $0x00, 1(%rdi)
    movb $0xff, 2(%rdi)

    addq %rcx, %rdi
    addq %rcx, %rdi
    addq %rcx, %rdi

    addq %rcx, %rax

    cmpq %rsi, %rax
    jl .RU2LL_paint_row

    decq %r8
    cmpq $0, %r8
    jge .RU2LL_paint_next
    movq %rcx, %r8
    decq %r8
    jmp .RU2LL_paint_next

.RU2LL_paint_next:
    pushq %rdx # save current address

    movq %rsi, %rdx
    imulq $3, %rdx
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %rdx
    movq %rdx, %rax
    #at this moment, %rax has actual memory length of width

    popq %rdx
    #at this moment, %rdx restored to current start address.

    subq %rax, %rdx #move to the next address to be started from
    movq %rdx, %rdi

    popq %rax # pop original imgptr
    cmpq %rax, %rdi
    jl .finalize_RU2LL
    pushq %rax

    movq $0, %rax
    
    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rax

    jmp .RU2LL_paint_row

.finalize_RU2LL:
    popq %rdx
    movq %rax, %rdi

    ret


LU2RL:
    movq $0, %r8

    #temporarily assign current imgptr to %rdx
    pushq %rdx
    movq %rdi, %rdx

    #save original imgptr
    pushq %rax

    movq $0, %rax

.LU2RL_paint_row:
    movb $0x00, (%rdi)
    movb $0x00, 1(%rdi)
    movb $0xff, 2(%rdi)

    addq %rcx, %rdi
    addq %rcx, %rdi
    addq %rcx, %rdi
    
    addq %rcx, %rax
    
    cmpq %rsi, %rax
    jl .LU2RL_paint_row

    incq %r8
    cmpq %rcx, %r8 #compare current initial gap : gap
    jl .LU2RL_paint_next
    movq $0, %r8
    jmp .LU2RL_paint_next

.LU2RL_paint_next:
    pushq %rdx #save current address

    movq %rsi, %rdx
    imulq $3, %rdx
    pushq %rsi
    callq get_padding
    popq %rsi
    addq %rax, %rdx
    movq %rdx, %rax
    #at this moment, %rax has actual memory length of width

    popq %rdx
    #at this moment, %rdx restored to current start address.

    subq %rax, %rdx #move to the next address to be started from 
    movq %rdx, %rdi

    popq %rax #pop original imgptr
    cmpq %rax, %rdi #compare ptr of this row: original imgptr
    jl .finalize_LU2RL
    pushq %rax

    movq $0, %rax

    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rdi
    addq %r8, %rax

    jmp .LU2RL_paint_row

.finalize_LU2RL:
    popq %rdx
    movq %rax, %rdi
    
    # test if %rdi is back to the original imgptr
    # movq $0xff, (%rdi)
    # movq $0x00, 1(%rdi)
    # movq $0x00, 2(%rdi)

    ret


get_padding:
    imulq $3, %rsi
.gp_0:
    cmpq $4, %rsi
    jle .gp_1
    subq $4, %rsi
    jmp .gp_0
.gp_1:
    negq %rsi
    addq $4, %rsi
    movq %rsi, %rax
    ret




   	# Example: Initially, the %rdi register points to the first 
	# pixel in the last row of the image.  The following three 
	# instructions change its color to red.

	# movb 	$0x00, (%rdi)			# blue
	# movb	$0x00, 1(%rdi)			# green
	# movb	$0xff, 2(%rdi)			# red




	#------------------------------------------------------------

	
