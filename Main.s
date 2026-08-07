	.file	"Main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"src/Main.c"
.LC1:
	.string	"%s: Decode arguments invalid\n"
.LC2:
	.string	"%s: Decode arguments valid\n"
.LC3:
	.string	"%s: Decoding failed\n"
.LC4:
	.string	"%s: Decoding successful\n"
	.text
	.p2align 4
	.globl	decodeOperation
	.type	decodeOperation, @function
decodeOperation:
.LFB20:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rdx
	movl	$13, %ecx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$120, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 104(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdi
	movq	%rsp, %rbx
	movq	%rbx, %rsi
	rep stosq
	movq	%rdx, %rdi
	call	read_and_validate_decode_args@PLT
	cmpl	$1, %eax
	je	.L9
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %rbp
	leaq	.LC2(%rip), %rdx
	xorl	%eax, %eax
	movq	%rbp, %rcx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	do_decoding@PLT
	movq	%rbp, %rcx
	cmpl	$1, %eax
	je	.L10
	movq	stdout(%rip), %rdi
	leaq	.LC4(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
.L1:
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L11
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC1(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L3:
	movl	$-1, %eax
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L10:
	movq	stderr(%rip), %rdi
	leaq	.LC3(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L3
.L11:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE20:
	.size	decodeOperation, .-decodeOperation
	.section	.rodata.str1.1
.LC5:
	.string	"%s: Encode arguments invalid\n"
.LC6:
	.string	"%s: Encode arguments valid\n"
.LC7:
	.string	"%s: Encoding failed\n"
.LC8:
	.string	"%s: Encoding successful\n"
	.text
	.p2align 4
	.globl	encodeOperation
	.type	encodeOperation, @function
encodeOperation:
.LFB21:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rdx
	movl	$11, %ecx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$104, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdi
	movq	%rsp, %rbx
	movq	%rbx, %rsi
	rep stosq
	movq	%rdx, %rdi
	call	read_and_validate_encode_args@PLT
	cmpl	$1, %eax
	je	.L19
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %rbp
	leaq	.LC6(%rip), %rdx
	xorl	%eax, %eax
	movq	%rbp, %rcx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	do_encoding@PLT
	movq	%rbp, %rcx
	cmpl	$1, %eax
	je	.L20
	movq	stdout(%rip), %rdi
	leaq	.LC8(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
.L12:
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L21
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L19:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC5(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L14:
	movl	$-1, %eax
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L20:
	movq	stderr(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L14
.L21:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
	.size	encodeOperation, .-encodeOperation
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"%s: Invalid Command Line Argument"
	.section	.rodata.str1.1
.LC10:
	.string	"%s: Operation type is Encode\n"
.LC11:
	.string	"%s: Operation type is Decode\n"
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"%s: Operation type is Unsupported\nInvalid Command Line Argument\n"
	.align 8
.LC13:
	.string	"%s: Encode Command Syntax: ./a.out -e beautiful.bmp secret [stego_img.bmp]\n"
	.align 8
.LC14:
	.string	"%s: Decode Command Syntax: ./a.out -d stego_img.bmp [output_secret_file]\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	cmpl	$1, %edi
	jle	.L28
	movq	%rsi, %rdi
	movq	%rsi, %rbx
	call	check_operation_type@PLT
	testl	%eax, %eax
	je	.L29
	cmpl	$1, %eax
	je	.L30
	leaq	.LC0(%rip), %rbx
	movq	stderr(%rip), %rdi
	leaq	.LC12(%rip), %rdx
	xorl	%eax, %eax
	movq	%rbx, %rcx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	leaq	.LC13(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%rbx, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	leaq	.LC14(%rip), %rdx
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L29:
	.cfi_restore_state
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	movl	$2, %esi
	leaq	.LC10(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	encodeOperation
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movzbl	%al, %eax
	ret
.L30:
	.cfi_restore_state
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC11(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	decodeOperation
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movzbl	%al, %eax
	ret
.L28:
	.cfi_restore_state
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC9(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	orl	$-1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE19:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
