	.file	"encode.c"
	.text
	.p2align 4
	.type	filename_bmp_validate, @function
filename_bmp_validate:
.LFB22:
	.cfi_startproc
	cmpb	$0, (%rdi)
	je	.L8
	movq	%rdi, %rax
	.p2align 4,,10
	.p2align 3
.L3:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L3
	.p2align 4,,10
	.p2align 3
.L18:
	cmpq	%rax, %rdi
	je	.L8
	subq	$1, %rax
	cmpb	$46, (%rax)
	jne	.L18
	cmpq	%rax, %rdi
	je	.L8
	cmpb	$98, 1(%rax)
	movl	$1, %edx
	jne	.L1
	cmpb	$109, 2(%rax)
	jne	.L1
	cmpb	$112, 3(%rax)
	je	.L20
.L1:
	movl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L20:
	cmpb	$0, 4(%rax)
	setne	%dl
	movl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	movl	$1, %edx
	movl	%edx, %eax
	ret
	.cfi_endproc
.LFE22:
	.size	filename_bmp_validate, .-filename_bmp_validate
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"src/encode.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"%s: File pointers closed; Resource Leak Averted\n"
	.text
	.p2align 4
	.type	cleanup_fp, @function
cleanup_fp:
.LFB24:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L22
	call	fclose@PLT
	movq	$0, 8(%rbx)
.L22:
	movq	40(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L23
	call	fclose@PLT
	movq	$0, 40(%rbx)
.L23:
	movq	80(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L24
	call	fclose@PLT
	movq	$0, 80(%rbx)
.L24:
	movq	stdout(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	leaq	.LC0(%rip), %rcx
	leaq	.LC1(%rip), %rdx
	jmp	__fprintf_chk@PLT
	.cfi_endproc
.LFE24:
	.size	cleanup_fp, .-cleanup_fp
	.section	.rodata.str1.1
.LC2:
	.string	"%s: Error reading width"
.LC3:
	.string	"%s: width = %lu\n"
.LC4:
	.string	"%s: Error reading height"
.LC5:
	.string	"%s: height = %lu\n"
	.text
	.p2align 4
	.globl	get_image_size_for_bmp
	.type	get_image_size_for_bmp, @function
get_image_size_for_bmp:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xorl	%edx, %edx
	movl	$18, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	fseek@PLT
	leaq	8(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	cmpq	$1, %rax
	je	.L36
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC2(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
.L37:
	xorl	%eax, %eax
.L35:
	movq	24(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L42
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L36:
	.cfi_restore_state
	movq	stdout(%rip), %rdi
	movq	8(%rsp), %r8
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rbp
	movq	%rbp, %rcx
	leaq	.LC3(%rip), %rdx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	leaq	16(%rsp), %rdi
	movq	%rbx, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	cmpq	$1, %rax
	je	.L38
	movq	stdout(%rip), %rdi
	movq	%rbp, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	call	__fprintf_chk@PLT
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L38:
	movq	16(%rsp), %r8
	movq	%rbp, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stdout(%rip), %rdi
	leaq	.LC5(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	8(%rsp), %rax
	imulq	16(%rsp), %rax
	leaq	(%rax,%rax,2), %rax
	jmp	.L35
.L42:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE19:
	.size	get_image_size_for_bmp, .-get_image_size_for_bmp
	.p2align 4
	.globl	check_operation_type
	.type	check_operation_type, @function
check_operation_type:
.LFB21:
	.cfi_startproc
	endbr64
	movq	8(%rdi), %rax
	movl	$2, %edx
	testq	%rax, %rax
	je	.L43
	cmpb	$45, (%rax)
	jne	.L43
	cmpb	$0, 2(%rax)
	jne	.L43
	movzbl	1(%rax), %eax
	xorl	%edx, %edx
	cmpb	$101, %al
	je	.L43
	xorl	%edx, %edx
	cmpb	$100, %al
	setne	%dl
	addl	$1, %edx
.L43:
	movl	%edx, %eax
	ret
	.cfi_endproc
.LFE21:
	.size	check_operation_type, .-check_operation_type
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"target_files/default_veiledWords.bmp"
	.text
	.p2align 4
	.globl	read_and_validate_encode_args
	.type	read_and_validate_encode_args, @function
read_and_validate_encode_args:
.LFB23:
	.cfi_startproc
	endbr64
	movq	%rdi, %rcx
	movq	16(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L54
	call	filename_bmp_validate
	testb	%al, %al
	jne	.L54
	movq	%rdi, (%rsi)
	movq	24(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L54
	movq	%rdx, 32(%rsi)
	cmpb	$0, (%rdx)
	je	.L54
	movq	%rdx, %rax
	.p2align 4,,10
	.p2align 3
.L55:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L55
	.p2align 4,,10
	.p2align 3
.L73:
	cmpq	%rax, %rdx
	je	.L54
	subq	$1, %rax
	cmpb	$46, (%rax)
	jne	.L73
	cmpq	%rax, %rdx
	je	.L54
	movzbl	(%rax), %edi
	xorl	%edx, %edx
	testb	%dil, %dil
	je	.L58
.L59:
	movb	%dil, 48(%rsi,%rdx)
	addq	$1, %rdx
	movzbl	(%rax,%rdx), %edi
	testb	%dil, %dil
	jne	.L59
.L58:
	movb	$0, 48(%rsi,%rdx)
	movq	32(%rcx), %rcx
	movq	%rdx, 64(%rsi)
	testq	%rcx, %rcx
	je	.L74
	movq	%rcx, %rdi
	call	filename_bmp_validate
	testb	%al, %al
	jne	.L54
.L61:
	movq	%rcx, 72(%rsi)
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L54:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L74:
	leaq	.LC6(%rip), %rcx
	jmp	.L61
	.cfi_endproc
.LFE23:
	.size	read_and_validate_encode_args, .-read_and_validate_encode_args
	.p2align 4
	.globl	copy_remaining_img_data
	.type	copy_remaining_img_data, @function
copy_remaining_img_data:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbp
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L78:
	movq	%r13, %rcx
	movq	%rbx, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	cmpq	%rbx, %rax
	jne	.L80
.L76:
	movq	%r12, %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fread@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jne	.L78
	xorl	%eax, %eax
.L75:
	movq	24(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L82
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L80:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L75
.L82:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE26:
	.size	copy_remaining_img_data, .-copy_remaining_img_data
	.p2align 4
	.globl	encode_secret_file_size
	.type	encode_secret_file_size, @function
encode_secret_file_size:
.LFB28:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$64, %edx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$104, %rsp
	.cfi_def_cfa_offset 128
	movq	8(%rsi), %rcx
	movq	80(%rsi), %rbx
	movl	$1, %esi
	movq	%rdi, 8(%rsp)
	leaq	16(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	call	fread@PLT
	movq	%rax, %rdx
	movl	$1, %eax
	cmpq	$64, %rdx
	jne	.L83
	leaq	8(%rsp), %r10
	movq	%rbp, %r9
	leaq	24(%rsp), %rsi
	leaq	80(%rsp), %r11
	.p2align 4,,10
	.p2align 3
.L86:
	movzbl	(%r10), %r8d
	movq	%r9, %rax
	leal	7(%r9), %edi
	.p2align 4,,10
	.p2align 3
.L85:
	movl	%edi, %edx
	movzbl	(%rax), %ecx
	subl	%eax, %edx
	btl	%edx, %r8d
	setc	%dl
	andl	$-2, %ecx
	addq	$1, %rax
	orl	%ecx, %edx
	movb	%dl, -1(%rax)
	cmpq	%rax, %rsi
	jne	.L85
	addq	$8, %r9
	addq	$1, %r10
	addq	$8, %rsi
	cmpq	%r9, %r11
	jne	.L86
	movq	%rbx, %rcx
	movl	$64, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	cmpq	$64, %rax
	setne	%al
	movzbl	%al, %eax
.L83:
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L93
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L93:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE28:
	.size	encode_secret_file_size, .-encode_secret_file_size
	.p2align 4
	.globl	encode_secret_file_extn_size
	.type	encode_secret_file_extn_size, @function
encode_secret_file_extn_size:
.LFB30:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$32, %edx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	movq	8(%rsi), %rcx
	movq	80(%rsi), %rbx
	movl	$1, %esi
	movq	%rdi, 8(%rsp)
	leaq	16(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	call	fread@PLT
	movq	%rax, %rdx
	movl	$1, %eax
	cmpq	$32, %rdx
	jne	.L94
	leaq	8(%rsp), %r10
	movq	%rbp, %r9
	leaq	24(%rsp), %rsi
	leaq	48(%rsp), %r11
.L97:
	movzbl	(%r10), %r8d
	movq	%r9, %rax
	leal	7(%r9), %edi
	.p2align 4,,10
	.p2align 3
.L96:
	movl	%edi, %edx
	movzbl	(%rax), %ecx
	subl	%eax, %edx
	btl	%edx, %r8d
	setc	%dl
	andl	$-2, %ecx
	addq	$1, %rax
	orl	%ecx, %edx
	movb	%dl, -1(%rax)
	cmpq	%rax, %rsi
	jne	.L96
	addq	$8, %r9
	addq	$1, %r10
	addq	$8, %rsi
	cmpq	%r9, %r11
	jne	.L97
	movq	%rbx, %rcx
	movl	$32, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	cmpq	$32, %rax
	setne	%al
	movzbl	%al, %eax
.L94:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L104
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L104:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE30:
	.size	encode_secret_file_extn_size, .-encode_secret_file_extn_size
	.p2align 4
	.globl	encode_magic_string
	.type	encode_magic_string, @function
encode_magic_string:
.LFB31:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	80(%rsi), %r14
	movq	8(%rsi), %r13
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbx
	leaq	8(%rsp), %r15
	.p2align 4,,10
	.p2align 3
.L110:
	movq	%r13, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L109
	movzbl	(%r12,%rbp), %edi
	movq	%rbx, %rax
	leal	7(%rbx), %esi
	.p2align 4,,10
	.p2align 3
.L108:
	movl	%esi, %edx
	movzbl	(%rax), %ecx
	subl	%eax, %edx
	btl	%edx, %edi
	setc	%dl
	andl	$-2, %ecx
	addq	$1, %rax
	orl	%ecx, %edx
	movb	%dl, -1(%rax)
	cmpq	%r15, %rax
	jne	.L108
	movq	%r14, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fwrite@PLT
	cmpq	$8, %rax
	jne	.L109
	testq	%rbp, %rbp
	jne	.L115
	movl	$1, %ebp
	jmp	.L110
.L109:
	movl	$1, %eax
.L105:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L116
	addq	$24, %rsp
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
.L115:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L105
.L116:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE31:
	.size	encode_magic_string, .-encode_magic_string
	.p2align 4
	.globl	encode_data_to_image
	.type	encode_data_to_image, @function
encode_data_to_image:
.LFB32:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	(%rdi,%rsi), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	testq	%rsi, %rsi
	je	.L124
	movq	%rdx, %r12
	movq	%rcx, %r13
	movq	%rdi, %rbx
	movq	%rsp, %rbp
	leaq	8(%rsp), %r15
	.p2align 4,,10
	.p2align 3
.L123:
	movq	%r12, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L122
	movzbl	(%rbx), %edi
	movq	%rbp, %rax
	leal	7(%rbp), %esi
	.p2align 4,,10
	.p2align 3
.L121:
	movl	%esi, %edx
	movzbl	(%rax), %ecx
	subl	%eax, %edx
	btl	%edx, %edi
	setc	%dl
	andl	$-2, %ecx
	addq	$1, %rax
	orl	%ecx, %edx
	movb	%dl, -1(%rax)
	cmpq	%r15, %rax
	jne	.L121
	movq	%r13, %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fwrite@PLT
	cmpq	$8, %rax
	jne	.L122
	addq	$1, %rbx
	cmpq	%r14, %rbx
	jne	.L123
.L124:
	xorl	%eax, %eax
.L117:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L131
	addq	$24, %rsp
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
.L122:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L117
.L131:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE32:
	.size	encode_data_to_image, .-encode_data_to_image
	.p2align 4
	.globl	encode_secret_file_data
	.type	encode_secret_file_data, @function
encode_secret_file_data:
.LFB27:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xorl	%edx, %edx
	xorl	%esi, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	movq	40(%rdi), %rdi
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbp
	call	fseek@PLT
	jmp	.L133
	.p2align 4,,10
	.p2align 3
.L135:
	movq	80(%rbx), %rcx
	movq	8(%rbx), %rdx
	movq	%rbp, %rdi
	call	encode_data_to_image
	cmpl	$1, %eax
	je	.L132
.L133:
	movq	40(%rbx), %rcx
	movl	$1, %esi
	movl	$16, %edx
	movq	%rbp, %rdi
	call	fread@PLT
	movq	%rax, %rsi
	testq	%rax, %rax
	jne	.L135
	xorl	%eax, %eax
.L132:
	movq	24(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L141
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L141:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE27:
	.size	encode_secret_file_data, .-encode_secret_file_data
	.p2align 4
	.globl	encode_secret_file_extn
	.type	encode_secret_file_extn, @function
encode_secret_file_extn:
.LFB29:
	.cfi_startproc
	endbr64
	movq	80(%rsi), %rcx
	movq	8(%rsi), %rdx
	movq	64(%rsi), %rsi
	jmp	encode_data_to_image
	.cfi_endproc
.LFE29:
	.size	encode_secret_file_extn, .-encode_secret_file_extn
	.p2align 4
	.globl	encode_byte_to_lsb
	.type	encode_byte_to_lsb, @function
encode_byte_to_lsb:
.LFB33:
	.cfi_startproc
	endbr64
	movzbl	%dil, %edi
	leaq	8(%rsi), %r8
	leal	7(%rsi), %ecx
	.p2align 4,,10
	.p2align 3
.L144:
	movl	%ecx, %eax
	movzbl	(%rsi), %edx
	subl	%esi, %eax
	btl	%eax, %edi
	setc	%al
	andl	$-2, %edx
	addq	$1, %rsi
	orl	%edx, %eax
	movb	%al, -1(%rsi)
	cmpq	%rsi, %r8
	jne	.L144
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE33:
	.size	encode_byte_to_lsb, .-encode_byte_to_lsb
	.p2align 4
	.globl	copy_bmp_header
	.type	copy_bmp_header, @function
copy_bmp_header:
.LFB34:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	xorl	%edx, %edx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	xorl	%esi, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %r12
	call	fseek@PLT
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	call	fseek@PLT
	movl	$54, %edx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movl	$1, %esi
	call	fread@PLT
	movq	%rax, %rdx
	movl	$1, %eax
	cmpq	$54, %rdx
	je	.L152
.L146:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L153
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L152:
	.cfi_restore_state
	movq	%rbp, %rcx
	movl	$1, %esi
	movq	%r12, %rdi
	call	fwrite@PLT
	cmpq	$54, %rax
	setne	%al
	movzbl	%al, %eax
	jmp	.L146
.L153:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE34:
	.size	copy_bmp_header, .-copy_bmp_header
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"%s: Unable to determine size.\n"
	.text
	.p2align 4
	.globl	check_capacity
	.type	check_capacity, @function
check_capacity:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdi
	call	get_image_size_for_bmp
	movq	40(%rbx), %rbp
	xorl	%esi, %esi
	movl	$2, %edx
	movq	%rax, 16(%rbx)
	movq	%rbp, %rdi
	call	fseek@PLT
	movq	%rbp, %rdi
	call	ftell@PLT
	cmpq	$-1, %rax
	je	.L158
.L156:
	movq	64(%rbx), %rdx
	movq	%rax, 56(%rbx)
	leaq	14(%rax,%rdx), %rax
	salq	$3, %rax
	cmpq	%rax, 16(%rbx)
	setb	%al
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movzbl	%al, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L158:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	jmp	.L156
	.cfi_endproc
.LFE35:
	.size	check_capacity, .-check_capacity
	.section	.rodata.str1.1
.LC8:
	.string	"rb"
.LC9:
	.string	"fopen"
.LC10:
	.string	"%s: Unable to open file %s\n"
.LC11:
	.string	"wb"
.LC12:
	.string	"%s: File opens success\n"
.LC13:
	.string	"%s: File open failed\n"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"%s: File not suitable for encoding.\n"
	.align 8
.LC15:
	.string	"%s: File suitable for encoding.\n"
	.align 8
.LC16:
	.string	"%s: Failed to copy bmp header.\n"
	.align 8
.LC17:
	.string	"%s: BMP header duplication successful.\n"
	.section	.rodata.str1.1
.LC18:
	.string	"#*"
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"%s: Failed to encode magic string.\n"
	.align 8
.LC20:
	.string	"%s: Magic string encoding successful.\n"
	.align 8
.LC21:
	.string	"%s: Failed to encode file extension size.\n"
	.align 8
.LC22:
	.string	"%s: File extension size encoding successful.\n"
	.align 8
.LC23:
	.string	"%s: Failed to encode file extension.\n"
	.align 8
.LC24:
	.string	"%s: File extension encoding successful.\n"
	.align 8
.LC25:
	.string	"%s: Failed to encode file size.\n"
	.align 8
.LC26:
	.string	"%s: File size encoding successful.\n"
	.align 8
.LC27:
	.string	"%s: Failed to encode file data.\n"
	.align 8
.LC28:
	.string	"%s: File data encoding successful.\n"
	.align 8
.LC29:
	.string	"%s: Failed to duplicate remainder file data.\n"
	.align 8
.LC30:
	.string	"%s: Remainder file data duplication successful.\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB31:
	.text
.LHOTB31:
	.p2align 4
	.globl	do_encoding
	.type	do_encoding, @function
do_encoding:
.LFB25:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	leaq	.LC8(%rip), %rbx
	movq	%rbx, %rsi
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	(%rdi), %rdi
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	movq	%rax, 8(%r12)
	testq	%rax, %rax
	je	.L184
	movq	32(%r12), %rdi
	movq	%rbx, %rsi
	call	fopen@PLT
	movq	%rax, 40(%r12)
	testq	%rax, %rax
	je	.L185
	movq	72(%r12), %rdi
	leaq	.LC11(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 80(%r12)
	testq	%rax, %rax
	je	.L163
	movq	stdout(%rip), %rdi
	leaq	.LC0(%rip), %r13
	xorl	%eax, %eax
	leaq	.LC12(%rip), %rdx
	movq	%r13, %rcx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	check_capacity
	cmpl	$1, %eax
	je	.L190
	movq	stdout(%rip), %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC15(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	80(%r12), %rsi
	movq	8(%r12), %rdi
	call	copy_bmp_header
	movq	%r13, %rcx
	cmpl	$1, %eax
	je	.L191
	movq	stdout(%rip), %rdi
	leaq	.LC17(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC18(%rip), %rbp
	leaq	16(%rsp), %rbx
	call	__fprintf_chk@PLT
	movq	80(%r12), %rax
	leaq	2(%rbp), %r15
	leaq	24(%rsp), %r14
	movq	%rax, 8(%rsp)
	movq	8(%r12), %rax
	movq	%rax, (%rsp)
	.p2align 4,,10
	.p2align 3
.L172:
	movq	(%rsp), %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fread@PLT
	cmpq	$8, %rax
	jne	.L171
	movzbl	0(%rbp), %edi
	movq	%rbx, %rax
	leal	7(%rbx), %esi
	.p2align 4,,10
	.p2align 3
.L170:
	movl	%esi, %edx
	movzbl	(%rax), %ecx
	subl	%eax, %edx
	btl	%edx, %edi
	setc	%dl
	andl	$-2, %ecx
	addq	$1, %rax
	orl	%ecx, %edx
	movb	%dl, -1(%rax)
	cmpq	%r14, %rax
	jne	.L170
	movq	8(%rsp), %rcx
	movl	$8, %edx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fwrite@PLT
	cmpq	$8, %rax
	jne	.L171
	addq	$1, %rbp
	cmpq	%r15, %rbp
	jne	.L172
	movq	stdout(%rip), %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC20(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	64(%r12), %rdi
	movq	%r12, %rsi
	call	encode_secret_file_extn_size
	movq	%r13, %rcx
	cmpl	$1, %eax
	je	.L192
	movq	stdout(%rip), %rdi
	leaq	.LC22(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	80(%r12), %rcx
	movq	8(%r12), %rdx
	leaq	48(%r12), %rdi
	movq	64(%r12), %rsi
	call	encode_data_to_image
	movq	%r13, %rcx
	cmpl	$1, %eax
	je	.L193
	movq	stdout(%rip), %rdi
	leaq	.LC24(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	56(%r12), %rdi
	movq	%r12, %rsi
	call	encode_secret_file_size
	movq	%r13, %rcx
	cmpl	$1, %eax
	je	.L194
	movq	stdout(%rip), %rdi
	leaq	.LC26(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	encode_secret_file_data
	movq	%r13, %rcx
	cmpl	$1, %eax
	je	.L195
	movq	stdout(%rip), %rdi
	leaq	.LC28(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	80(%r12), %r15
	movq	8(%r12), %r14
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L179:
	movq	%r15, %rcx
	movq	%rbp, %rdx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fwrite@PLT
	cmpq	%rax, %rbp
	jne	.L178
.L177:
	movq	%r14, %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rbx, %rdi
	call	fread@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jne	.L179
	movq	stdout(%rip), %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC30(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	xorl	%eax, %eax
.L159:
	movq	40(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L196
	addq	$56, %rsp
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
.L171:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC19(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
.L166:
	movl	$1, %eax
	jmp	.L159
.L191:
	movq	stderr(%rip), %rdi
	leaq	.LC16(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L194:
	movq	stderr(%rip), %rdi
	leaq	.LC25(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L190:
	movq	stderr(%rip), %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC14(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L192:
	movq	stderr(%rip), %rdi
	leaq	.LC21(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L193:
	movq	stderr(%rip), %rdi
	leaq	.LC23(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L195:
	movq	stderr(%rip), %rdi
	leaq	.LC27(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L178:
	movq	stderr(%rip), %rdi
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L196:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	do_encoding.cold, @function
do_encoding.cold:
.LFSB25:
.L163:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	leaq	.LC9(%rip), %rdi
	call	perror@PLT
	movq	72(%r12), %r8
.L189:
	leaq	.LC0(%rip), %r13
	movq	stderr(%rip), %rdi
	leaq	.LC10(%rip), %rdx
	xorl	%eax, %eax
	movq	%r13, %rcx
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	%r13, %rcx
	movl	$2, %esi
	xorl	%eax, %eax
	movq	stderr(%rip), %rdi
	leaq	.LC13(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	cleanup_fp
	jmp	.L166
.L185:
	leaq	.LC9(%rip), %rdi
	call	perror@PLT
	movq	32(%r12), %r8
	jmp	.L189
.L184:
	leaq	.LC9(%rip), %rdi
	call	perror@PLT
	movq	(%r12), %r8
	jmp	.L189
	.cfi_endproc
.LFE25:
	.text
	.size	do_encoding, .-do_encoding
	.section	.text.unlikely
	.size	do_encoding.cold, .-do_encoding.cold
.LCOLDE31:
	.text
.LHOTE31:
	.p2align 4
	.globl	get_file_size
	.type	get_file_size, @function
get_file_size:
.LFB36:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xorl	%esi, %esi
	movq	%rdi, %rbx
	movl	$2, %edx
	call	fseek@PLT
	movq	%rbx, %rdi
	call	ftell@PLT
	cmpq	$-1, %rax
	je	.L201
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L201:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	leaq	.LC0(%rip), %rcx
	leaq	.LC7(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE36:
	.size	get_file_size, .-get_file_size
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
