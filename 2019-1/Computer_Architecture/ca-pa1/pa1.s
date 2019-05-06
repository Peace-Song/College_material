	.file	"pa1.c"
	.text
	.globl	fix2double
	.type	fix2double, @function
fix2double:
.LFB23:
	.cfi_startproc
	testl	%edi, %edi
	js	.L10
	pxor	%xmm0, %xmm0
.L2:
	movl	$20, %edx
	jmp	.L4
.L5:
	leal	10(%rdx), %ecx
	movl	$1, %eax
	sall	%cl, %eax
	andl	%edi, %eax
	sarl	$10, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sd	%eax, %xmm1
	addsd	%xmm1, %xmm0
	subl	$1, %edx
.L4:
	testl	%edx, %edx
	jns	.L5
	movl	$1, %esi
	jmp	.L6
.L10:
	movsd	.LC0(%rip), %xmm0
	jmp	.L2
.L7:
	movl	$10, %ecx
	subl	%esi, %ecx
	movl	$1, %edx
	movl	%edx, %eax
	sall	%cl, %eax
	andl	%edi, %eax
	sarl	%cl, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sd	%eax, %xmm1
	movl	%esi, %ecx
	sall	%cl, %edx
	pxor	%xmm2, %xmm2
	cvtsi2sd	%edx, %xmm2
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
	addl	$1, %esi
.L6:
	cmpl	$10, %esi
	jle	.L7
	rep ret
	.cfi_endproc
.LFE23:
	.size	fix2double, .-fix2double
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	-1052770304
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
