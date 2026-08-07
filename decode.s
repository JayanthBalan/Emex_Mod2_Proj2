	.file	"decode.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"wb"
.LC1:
	.string	"fopen"
.LC2:
	.string	"src/decode.c"
.LC3:
	.string	"%s: Unable to open file %s\n"
.LC4:
	.string	"rb"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4
	.type	open_files, @function
open_files:
.LFB28:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	cmpb	$1, %sil
	je	.L11
	movq	88(%rdi), %rdi
	leaq	.LC4(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 96(%rbx)
	testq	%rax, %rax
	je	.L7
.L6:
	xorl	%eax, %eax
.L1:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	leaq	.LC0(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 64(%rbx)
	testq	%rax, %rax
	je	.L3
	jmp	.L6
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	open_files.cold, @function
open_files.cold:
.LFSB28:
.L3:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
	movq	%rbx, %r8
.L9:
	movq	stderr(%rip), %rdi
	leaq	.LC2(%rip), %rcx
	leaq	.LC3(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movl	$1, %eax
	jmp	.L1
.L7:
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
	movq	88(%rbx), %r8
	jmp	.L9
	.cfi_endproc
.LFE28:
	.text
	.size	open_files, .-open_files
	.section	.text.unlikely
	.size	open_files.cold, .-open_files.cold
.LCOLDE5:
	.text
.LHOTE5:
	.p2align 4
	.globl	decode_secret_file_size
	.type	decode_secret_file_size, @function
decode_secret_file_size:
.LFB21:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	leaq	8(%rdi), %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %r14
	leaq	8(%rsp), %rbp
	.p2align 4,,10
	.p2align 3
.L16:
	movq	96(%r13), %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L21
	movq	%r14, %rdx
	xorl	%esi, %esi
	leal	7(%r14), %edi
	.p2align 4,,10
	.p2align 3
.L15:
	movzbl	(%rdx), %eax
	movl	%edi, %ecx
	subl	%edx, %ecx
	addq	$1, %rdx
	andl	$1, %eax
	sall	%cl, %eax
	orl	%eax, %esi
	cmpq	%rdx, %rbp
	jne	.L15
	movb	%sil, (%r12)
	addq	$1, %r12
	cmpq	%rbx, %r12
	jne	.L16
	xorl	%eax, %eax
.L12:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L22
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L21:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L12
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
	.size	decode_secret_file_size, .-decode_secret_file_size
	.p2align 4
	.globl	file_extn_correction
	.type	file_extn_correction, @function
file_extn_correction:
.LFB22:
	.cfi_startproc
	endbr64
	movzbl	(%rsi), %eax
	testq	%rdi, %rdi
	je	.L59
	testb	%al, %al
	je	.L29
	movq	%rsi, %rdx
	.p2align 4,,10
	.p2align 3
.L30:
	addq	$1, %rdx
	cmpb	$0, (%rdx)
	jne	.L30
	cmpq	%rdx, %rsi
	je	.L29
	movq	%rdx, %rax
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L60:
	cmpq	%rax, %rsi
	je	.L39
.L31:
	subq	$1, %rax
	cmpb	$46, (%rax)
	jne	.L60
.L39:
	cmpq	%rax, %rsi
	cmove	%rdx, %rax
.L33:
	cmpq	$0, 80(%rsi)
	je	.L34
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L35:
	movzbl	(%rdi,%rdx), %ecx
	movb	%cl, (%rax,%rdx)
	addq	$1, %rdx
	cmpq	80(%rsi), %rdx
	jb	.L35
	addq	%rdx, %rax
.L34:
	movb	$0, (%rax)
.L44:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L59:
	testb	%al, %al
	je	.L44
	movq	%rsi, %rax
	.p2align 4,,10
	.p2align 3
.L26:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L26
	.p2align 4,,10
	.p2align 3
.L58:
	cmpq	%rax, %rsi
	je	.L44
	subq	$1, %rax
	cmpb	$46, (%rax)
	jne	.L58
	cmpq	%rax, %rsi
	jne	.L34
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L29:
	movq	%rsi, %rax
	jmp	.L33
	.cfi_endproc
.LFE22:
	.size	file_extn_correction, .-file_extn_correction
	.p2align 4
	.globl	decode_secret_file_extn_size
	.type	decode_secret_file_extn_size, @function
decode_secret_file_extn_size:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	leaq	4(%rdi), %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %r14
	leaq	8(%rsp), %rbp
	.p2align 4,,10
	.p2align 3
.L65:
	movq	96(%r13), %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L70
	movq	%r14, %rdx
	xorl	%esi, %esi
	leal	7(%r14), %edi
	.p2align 4,,10
	.p2align 3
.L64:
	movzbl	(%rdx), %eax
	movl	%edi, %ecx
	subl	%edx, %ecx
	addq	$1, %rdx
	andl	$1, %eax
	sall	%cl, %eax
	orl	%eax, %esi
	cmpq	%rdx, %rbp
	jne	.L64
	movb	%sil, (%r12)
	addq	$1, %r12
	cmpq	%rbx, %r12
	jne	.L65
	xorl	%eax, %eax
.L61:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L71
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L70:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L61
.L71:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE24:
	.size	decode_secret_file_extn_size, .-decode_secret_file_extn_size
	.p2align 4
	.globl	validate_magic_string
	.type	validate_magic_string, @function
validate_magic_string:
.LFB25:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorl	%edx, %edx
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rsi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	movq	96(%rsi), %rdi
	movl	$54, %esi
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	14(%rsp), %r13
	leaq	16(%rsp), %r14
	call	fseek@PLT
	movq	96(%rbx), %rbx
	leaq	24(%rsp), %r12
	.p2align 4,,10
	.p2align 3
.L75:
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L77
	movq	%r14, %rdx
	xorl	%esi, %esi
	leal	7(%r14), %edi
	.p2align 4,,10
	.p2align 3
.L74:
	movzbl	(%rdx), %eax
	movl	%edi, %ecx
	subl	%edx, %ecx
	addq	$1, %rdx
	andl	$1, %eax
	sall	%cl, %eax
	orl	%eax, %esi
	cmpq	%rdx, %r12
	jne	.L74
	movb	%sil, 0(%r13)
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L75
	movzbl	14(%rsp), %edx
	movsbl	0(%rbp), %eax
	cmpl	%eax, %edx
	jne	.L77
	movsbl	1(%rbp), %eax
	movzbl	15(%rsp), %edx
	cmpl	%eax, %edx
	setne	%al
	movzbl	%al, %eax
.L72:
	movq	24(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L86
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L77:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L72
.L86:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE25:
	.size	validate_magic_string, .-validate_magic_string
	.p2align 4
	.globl	decode_image_to_data
	.type	decode_image_to_data, @function
decode_image_to_data:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	(%rdx,%rdi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L92
	movq	%rsi, %rbx
	movq	%rdx, %r13
	leaq	8(%rsp), %r12
	movq	%rsp, %r14
	.p2align 4,,10
	.p2align 3
.L91:
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L94
	movq	%r14, %rdx
	xorl	%esi, %esi
	leal	7(%r14), %edi
	.p2align 4,,10
	.p2align 3
.L90:
	movzbl	(%rdx), %eax
	movl	%edi, %ecx
	subl	%edx, %ecx
	addq	$1, %rdx
	andl	$1, %eax
	sall	%cl, %eax
	orl	%eax, %esi
	cmpq	%rdx, %r12
	jne	.L90
	movb	%sil, 0(%r13)
	addq	$1, %r13
	cmpq	%rbp, %r13
	jne	.L91
.L92:
	xorl	%eax, %eax
.L87:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L100
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L94:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L87
.L100:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE26:
	.size	decode_image_to_data, .-decode_image_to_data
	.p2align 4
	.globl	decode_secret_file
	.type	decode_secret_file, @function
decode_secret_file:
.LFB20:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%edx, %edx
	xorl	%esi, %esi
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	64(%rdi), %rdi
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	40(%rsp), %rbx
	call	fseek@PLT
	movq	72(%r12), %rax
	movq	%rbx, 8(%rsp)
	movq	%rax, 24(%rsp)
	shrq	$3, %rax
	movq	%rax, 16(%rsp)
	je	.L109
	xorl	%ebp, %ebp
	leaq	48(%rsp), %r14
	leaq	56(%rsp), %r15
	.p2align 4,,10
	.p2align 3
.L102:
	movq	96(%r12), %rbx
	movq	8(%rsp), %r13
	.p2align 4,,10
	.p2align 3
.L107:
	movq	%rbx, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L111
	movq	%r14, %rdx
	xorl	%esi, %esi
	leal	7(%r14), %edi
	.p2align 4,,10
	.p2align 3
.L106:
	movzbl	(%rdx), %eax
	movl	%edi, %ecx
	subl	%edx, %ecx
	addq	$1, %rdx
	andl	$1, %eax
	sall	%cl, %eax
	orl	%eax, %esi
	cmpq	%rdx, %r15
	jne	.L106
	movb	%sil, 0(%r13)
	addq	$1, %r13
	cmpq	%r14, %r13
	jne	.L107
	movq	64(%r12), %rcx
	movq	8(%rsp), %rdi
	movl	$8, %edx
	movl	$1, %esi
	call	fwrite@PLT
	cmpq	$8, %rax
	jne	.L111
	addq	$1, %rbp
	cmpq	%rbp, 16(%rsp)
	jne	.L102
.L109:
	movq	24(%rsp), %r15
	andl	$7, %r15d
	jne	.L103
	xorl	%eax, %eax
.L101:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L123
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L111:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L101
.L103:
	leaq	40(%rsp), %rbx
	movq	96(%r12), %rsi
	movq	%r15, %rdi
	movq	%rbx, %rdx
	call	decode_image_to_data
	cmpl	$1, %eax
	je	.L111
	movq	64(%r12), %rcx
	movq	%r15, %rdx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fwrite@PLT
	cmpq	%r15, %rax
	setne	%al
	movzbl	%al, %eax
	jmp	.L101
.L123:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE20:
	.size	decode_secret_file, .-decode_secret_file
	.p2align 4
	.globl	decode_secret_file_extn
	.type	decode_secret_file_extn, @function
decode_secret_file_extn:
.LFB23:
	.cfi_startproc
	endbr64
	movq	96(%rsi), %rax
	movq	%rdi, %rdx
	movq	80(%rsi), %rdi
	movq	%rax, %rsi
	jmp	decode_image_to_data
	.cfi_endproc
.LFE23:
	.size	decode_secret_file_extn, .-decode_secret_file_extn
	.section	.rodata.str1.1
.LC6:
	.string	"%s: File open failed\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC7:
	.string	"%s: File pointers closed; Resource Leak Averted\n"
	.section	.rodata.str1.1
.LC8:
	.string	"%s: File opens success\n"
.LC9:
	.string	"#*"
	.section	.rodata.str1.8
	.align 8
.LC10:
	.string	"%s: Failed to validate magic string.\n"
	.align 8
.LC11:
	.string	"%s: Magic string validated successful.\n"
	.align 8
.LC12:
	.string	"%s: Failed to retrieve file extension size.\n"
	.align 8
.LC13:
	.string	"%s: File extension size retrieved successful.\n"
	.align 8
.LC14:
	.string	"%s: Failed to retrieve file extension.\n"
	.align 8
.LC15:
	.string	"%s: File extension retrieved successful.\n"
	.align 8
.LC16:
	.string	"%s: Failed to fix file extension.\n"
	.align 8
.LC17:
	.string	"%s: File extension is correct.\n"
	.align 8
.LC18:
	.string	"%s: Failed to retrieve file size.\n"
	.align 8
.LC19:
	.string	"%s: File size retrieved successful.\n"
	.section	.rodata.str1.1
.LC20:
	.string	"%s: Failed to retrieve file.\n"
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"%s: File retrieved successful.\n"
	.text
	.p2align 4
	.globl	do_decoding
	.type	do_decoding, @function
do_decoding:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xorl	%esi, %esi
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$40, %rsp
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	call	open_files
	cmpl	$1, %eax
	leaq	.LC2(%rip), %rax
	movq	%rax, -72(%rbp)
	movq	%rax, %rcx
	je	.L251
	movq	stdout(%rip), %rdi
	leaq	.LC8(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rsi
	leaq	.LC9(%rip), %rdi
	call	validate_magic_string
	movq	-72(%rbp), %rcx
	cmpl	$1, %eax
	je	.L252
	movl	$2, %esi
	leaq	80(%rbx), %r14
	leaq	84(%rbx), %r12
	xorl	%eax, %eax
	movq	stdout(%rip), %rdi
	leaq	.LC11(%rip), %rdx
	leaq	-64(%rbp), %r15
	leaq	-56(%rbp), %r13
	call	__fprintf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L138:
	movq	96(%rbx), %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L253
	movq	%r15, %rax
	xorl	%esi, %esi
	leal	7(%r15), %r9d
	.p2align 4,,10
	.p2align 3
.L137:
	movzbl	(%rax), %edx
	movl	%r9d, %ecx
	subl	%eax, %ecx
	addq	$1, %rax
	andl	$1, %edx
	sall	%cl, %edx
	orl	%edx, %esi
	cmpq	%r13, %rax
	jne	.L137
	movb	%sil, (%r14)
	addq	$1, %r14
	cmpq	%r14, %r12
	jne	.L138
	movq	stdout(%rip), %rdi
	movq	-72(%rbp), %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC13(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	80(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L254
	leaq	16(%rdi), %rdx
	movq	%rsp, %rcx
	movq	%rsp, %r12
	movq	%rdx, %rax
	andq	$-4096, %rdx
	andq	$-16, %rax
	subq	%rdx, %rcx
.L142:
	cmpq	%rcx, %rsp
	je	.L143
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L142
.L253:
	movq	-72(%rbp), %rcx
	leaq	.LC12(%rip), %rdx
.L245:
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	64(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L131
	call	fclose@PLT
	movq	$0, 64(%rbx)
.L131:
	movq	96(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L132
	call	fclose@PLT
	movq	$0, 96(%rbx)
.L132:
	movq	-72(%rbp), %rcx
	movq	stdout(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L129:
	movl	$1, %eax
.L125:
	movq	-56(%rbp), %rdx
	subq	%fs:40, %rdx
	jne	.L255
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L251:
	.cfi_restore_state
	leaq	.LC6(%rip), %rdx
	jmp	.L245
.L254:
	cmpb	$0, (%rbx)
	je	.L153
	movq	%rbx, %rax
	.p2align 4,,10
	.p2align 3
.L154:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L154
	.p2align 4,,10
	.p2align 3
.L233:
	cmpq	%rax, %rbx
	je	.L153
	subq	$1, %rax
	cmpb	$46, (%rax)
	jne	.L233
	cmpq	%rax, %rbx
	je	.L153
	movb	$0, (%rax)
.L153:
	movq	-72(%rbp), %rcx
	movq	stdout(%rip), %rdi
	leaq	.LC17(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L152:
	movl	$1, %esi
	movq	%rbx, %rdi
	call	open_files
	movq	-72(%rbp), %rcx
	cmpl	$1, %eax
	je	.L251
	movq	stdout(%rip), %rdi
	leaq	.LC8(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	leaq	72(%rbx), %rdi
	movq	%rbx, %rsi
	call	decode_secret_file_size
	movq	-72(%rbp), %rcx
	leaq	.LC18(%rip), %rdx
	cmpl	$1, %eax
	je	.L245
	movq	stdout(%rip), %rdi
	leaq	.LC19(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	decode_secret_file
	movq	-72(%rbp), %rcx
	leaq	.LC20(%rip), %rdx
	cmpl	$1, %eax
	je	.L245
	movq	stdout(%rip), %rdi
	leaq	.LC21(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	64(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L166
	call	fclose@PLT
	movq	$0, 64(%rbx)
.L166:
	movq	96(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L167
	call	fclose@PLT
	movq	$0, 96(%rbx)
.L167:
	movq	-72(%rbp), %rcx
	movq	stdout(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	jmp	.L125
.L143:
	andl	$4095, %eax
	subq	%rax, %rsp
	testq	%rax, %rax
	jne	.L256
.L144:
	movq	96(%rbx), %rsi
	movq	%rsp, %rdx
	call	decode_image_to_data
	movq	-72(%rbp), %rcx
	leaq	.LC14(%rip), %rdx
	cmpl	$1, %eax
	je	.L250
	movq	stdout(%rip), %rdi
	leaq	.LC15(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	80(%rbx), %rax
	movq	%rbx, %rsi
	movq	%rsp, %rdi
	movb	$0, (%rsp,%rax)
	call	file_extn_correction
	movq	-72(%rbp), %rcx
	cmpl	$1, %eax
	je	.L257
	movq	stdout(%rip), %rdi
	leaq	.LC17(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rsp
	jmp	.L152
.L252:
	leaq	.LC10(%rip), %rdx
	jmp	.L245
.L257:
	leaq	.LC16(%rip), %rdx
.L250:
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	64(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L150
	call	fclose@PLT
	movq	$0, 64(%rbx)
.L150:
	movq	96(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L151
	call	fclose@PLT
	movq	$0, 96(%rbx)
.L151:
	movq	-72(%rbp), %rcx
	movq	stdout(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%r12, %rsp
	jmp	.L129
.L256:
	orq	$0, -8(%rsp,%rax)
	jmp	.L144
.L255:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE19:
	.size	do_decoding, .-do_decoding
	.p2align 4
	.globl	decode_lsb_to_byte
	.type	decode_lsb_to_byte, @function
decode_lsb_to_byte:
.LFB27:
	.cfi_startproc
	endbr64
	movb	$0, (%rsi)
	leaq	8(%rdi), %r9
	xorl	%edx, %edx
	leal	7(%rdi), %r8d
	.p2align 4,,10
	.p2align 3
.L259:
	movzbl	(%rdi), %eax
	movl	%r8d, %ecx
	subl	%edi, %ecx
	addq	$1, %rdi
	andl	$1, %eax
	sall	%cl, %eax
	orl	%eax, %edx
	movb	%dl, (%rsi)
	cmpq	%rdi, %r9
	jne	.L259
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE27:
	.size	decode_lsb_to_byte, .-decode_lsb_to_byte
	.p2align 4
	.globl	read_and_validate_decode_args
	.type	read_and_validate_decode_args, @function
read_and_validate_decode_args:
.LFB30:
	.cfi_startproc
	endbr64
	movq	%rdi, %rcx
	movq	%rsi, %rdi
	movl	$1, %esi
	movq	16(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L284
	cmpb	$0, (%rdx)
	je	.L284
	movq	%rdx, %rax
	.p2align 4,,10
	.p2align 3
.L263:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L263
	.p2align 4,,10
	.p2align 3
.L288:
	cmpq	%rax, %rdx
	je	.L271
	subq	$1, %rax
	cmpb	$46, (%rax)
	jne	.L288
	cmpq	%rax, %rdx
	je	.L271
	cmpb	$98, 1(%rax)
	movl	$1, %esi
	je	.L289
.L284:
	movl	%esi, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L289:
	cmpb	$109, 2(%rax)
	jne	.L284
	cmpb	$112, 3(%rax)
	jne	.L284
	cmpb	$0, 4(%rax)
	jne	.L284
	movq	%rdx, 88(%rdi)
	movq	24(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L287
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$64, %edx
	call	__strcpy_chk@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L287:
	movdqa	.LC22(%rip), %xmm0
	xorl	%esi, %esi
	movups	%xmm0, (%rdi)
	jmp	.L284
	.p2align 4,,10
	.p2align 3
.L271:
	movl	$1, %esi
	jmp	.L284
	.cfi_endproc
.LFE30:
	.size	read_and_validate_decode_args, .-read_and_validate_decode_args
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC22:
	.quad	6873730413314139492
	.quad	32783537688507245
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
