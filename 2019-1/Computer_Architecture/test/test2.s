	.file	"test2.c"
	.text
	.globl	swap
	.type	swap, @function
swap:
.LFB23:
	.cfi_startproc
	movq	(%rdi), %rax
	movq	(%rsi), %rdx
	movq	%rdx, (%rdi)
	movq	%rax, (%rsi)
	ret
	.cfi_endproc
.LFE23:
	.size	swap, .-swap
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	$0, 8(%rsp)
	movq	$1, 16(%rsp)
	leaq	16(%rsp), %rsi
	leaq	8(%rsp), %rdi
	call	swap
	movq	24(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L5
	movl	$0, %eax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
