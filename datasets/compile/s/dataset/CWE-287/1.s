	.text
	.file	"x509_crt.c"
	.globl	mbedtls_x509_crt_parse_der      # -- Begin function mbedtls_x509_crt_parse_der
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_parse_der,@function
mbedtls_x509_crt_parse_der:             # @mbedtls_x509_crt_parse_der
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$0, -56(%rbp)
	cmpq	$0, -48(%rbp)
	je	.LBB0_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB0_3
.LBB0_2:
	movl	$-10240, -4(%rbp)               # imm = 0xD800
	jmp	.LBB0_20
.LBB0_3:
	jmp	.LBB0_4
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rcx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, 48(%rcx)
	movb	%al, -57(%rbp)                  # 1-byte Spill
	je	.LBB0_6
# %bb.5:                                #   in Loop: Header=BB0_4 Depth=1
	movq	-48(%rbp), %rax
	cmpq	$0, 544(%rax)
	setne	%al
	movb	%al, -57(%rbp)                  # 1-byte Spill
.LBB0_6:                                #   in Loop: Header=BB0_4 Depth=1
	movb	-57(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB0_7
	jmp	.LBB0_8
.LBB0_7:                                #   in Loop: Header=BB0_4 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB0_4
.LBB0_8:
	movq	-48(%rbp), %rax
	cmpl	$0, 48(%rax)
	je	.LBB0_13
# %bb.9:
	movq	-48(%rbp), %rax
	cmpq	$0, 544(%rax)
	jne	.LBB0_13
# %bb.10:
	movl	$1, %edi
	movl	$552, %esi                      # imm = 0x228
	callq	calloc@PLT
	movq	%rax, %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, 544(%rax)
	movq	-48(%rbp), %rax
	cmpq	$0, 544(%rax)
	jne	.LBB0_12
# %bb.11:
	movl	$-10368, -4(%rbp)               # imm = 0xD780
	jmp	.LBB0_20
.LBB0_12:
	movq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	544(%rax), %rdi
	callq	mbedtls_x509_crt_init
	movq	-48(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -48(%rbp)
.LBB0_13:
	movq	-48(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	x509_crt_parse_der_core
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB0_19
# %bb.14:
	cmpq	$0, -56(%rbp)
	je	.LBB0_16
# %bb.15:
	movq	-56(%rbp), %rax
	movq	$0, 544(%rax)
.LBB0_16:
	movq	-48(%rbp), %rax
	cmpq	-16(%rbp), %rax
	je	.LBB0_18
# %bb.17:
	movq	-48(%rbp), %rdi
	callq	free@PLT
.LBB0_18:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_20
.LBB0_19:
	movl	$0, -4(%rbp)
.LBB0_20:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	mbedtls_x509_crt_parse_der, .Lfunc_end0-mbedtls_x509_crt_parse_der
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_init           # -- Begin function mbedtls_x509_crt_init
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_init,@function
mbedtls_x509_crt_init:                  # @mbedtls_x509_crt_init
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	xorl	%esi, %esi
	movl	$552, %edx                      # imm = 0x228
	callq	memset@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	mbedtls_x509_crt_init, .Lfunc_end1-mbedtls_x509_crt_init
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_crt_parse_der_core
	.type	x509_crt_parse_der_core,@function
x509_crt_parse_der_core:                # @x509_crt_parse_der_core
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	leaq	-96(%rbp), %rdi
	xorl	%esi, %esi
	movl	$24, %edx
	callq	memset@PLT
	leaq	-120(%rbp), %rdi
	xorl	%esi, %esi
	movl	$24, %edx
	callq	memset@PLT
	leaq	-144(%rbp), %rdi
	xorl	%esi, %esi
	movl	$24, %edx
	callq	memset@PLT
	cmpq	$0, -16(%rbp)
	je	.LBB2_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB2_3
.LBB2_2:
	movl	$-10240, -4(%rbp)               # imm = 0xD800
	jmp	.LBB2_61
.LBB2_3:
	movq	-24(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-56(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rsi
	leaq	-56(%rbp), %rdi
	leaq	-48(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_5
# %bb.4:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	$-8576, -4(%rbp)                # imm = 0xDE80
	jmp	.LBB2_61
.LBB2_5:
	movq	-48(%rbp), %rax
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rdx
	subq	%rdx, %rcx
	cmpq	%rcx, %rax
	jbe	.LBB2_7
# %bb.6:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	$-8678, -4(%rbp)                # imm = 0xDE1A
	jmp	.LBB2_61
.LBB2_7:
	movq	-56(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rcx
	movq	-24(%rbp), %rax
	subq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rsi
	movl	$1, %edi
	callq	calloc@PLT
	movq	%rax, %rcx
	movq	%rcx, -56(%rbp)
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
	cmpq	$0, -56(%rbp)
	jne	.LBB2_9
# %bb.8:
	movl	$-10368, -4(%rbp)               # imm = 0xD780
	jmp	.LBB2_61
.LBB2_9:
	movq	-56(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	callq	memcpy@PLT
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	subq	-48(%rbp), %rax
	addq	-56(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	%rax, -64(%rbp)
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 40(%rax)
	movq	-64(%rbp), %rsi
	leaq	-56(%rbp), %rdi
	leaq	-48(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_11
# %bb.10:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	addl	$4294958720, %eax               # imm = 0xFFFFDE80
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_11:
	movq	-56(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	40(%rax), %rax
	subq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$48, %rdx
	leaq	-56(%rbp), %rdi
	callq	x509_get_version
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	jne	.LBB2_14
# %bb.12:
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$56, %rdx
	leaq	-56(%rbp), %rdi
	callq	mbedtls_x509_get_serial@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	jne	.LBB2_14
# %bb.13:
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$80, %rdx
	leaq	-56(%rbp), %rdi
	leaq	-96(%rbp), %rcx
	callq	mbedtls_x509_get_alg@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_15
.LBB2_14:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_15:
	movq	-16(%rbp), %rax
	movl	48(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, 48(%rax)
	movq	-16(%rbp), %rax
	cmpl	$3, 48(%rax)
	jle	.LBB2_17
# %bb.16:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	$-9600, -4(%rbp)                # imm = 0xDA80
	jmp	.LBB2_61
.LBB2_17:
	movq	-16(%rbp), %rdi
	addq	$80, %rdi
	movq	-16(%rbp), %rdx
	addq	$528, %rdx                      # imm = 0x210
	movq	-16(%rbp), %rcx
	addq	$532, %rcx                      # imm = 0x214
	movq	-16(%rbp), %r8
	addq	$536, %r8                       # imm = 0x218
	leaq	-96(%rbp), %rsi
	callq	mbedtls_x509_get_sig_alg@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_19
# %bb.18:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_19:
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 120(%rax)
	movq	-64(%rbp), %rsi
	leaq	-56(%rbp), %rdi
	leaq	-48(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_21
# %bb.20:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	addl	$4294958720, %eax               # imm = 0xFFFFDE80
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_21:
	movq	-56(%rbp), %rsi
	addq	-48(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$152, %rdx
	leaq	-56(%rbp), %rdi
	callq	mbedtls_x509_get_name@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_23
# %bb.22:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_23:
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	120(%rax), %rax
	subq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 112(%rax)
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$280, %rdx                      # imm = 0x118
	movq	-16(%rbp), %rcx
	addq	$304, %rcx                      # imm = 0x130
	leaq	-56(%rbp), %rdi
	callq	x509_get_dates
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_25
# %bb.24:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_25:
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 144(%rax)
	movq	-64(%rbp), %rsi
	leaq	-56(%rbp), %rdi
	leaq	-48(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_27
# %bb.26:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	addl	$4294958720, %eax               # imm = 0xFFFFDE80
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_27:
	cmpq	$0, -48(%rbp)
	je	.LBB2_30
# %bb.28:
	movq	-56(%rbp), %rsi
	addq	-48(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$216, %rdx
	leaq	-56(%rbp), %rdi
	callq	mbedtls_x509_get_name@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_30
# %bb.29:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_30:
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	144(%rax), %rax
	subq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 136(%rax)
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$328, %rdx                      # imm = 0x148
	leaq	-56(%rbp), %rdi
	callq	mbedtls_pk_parse_subpubkey@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_32
# %bb.31:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_32:
	movq	-16(%rbp), %rax
	cmpl	$2, 48(%rax)
	je	.LBB2_34
# %bb.33:
	movq	-16(%rbp), %rax
	cmpl	$3, 48(%rax)
	jne	.LBB2_37
.LBB2_34:
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$344, %rdx                      # imm = 0x158
	leaq	-56(%rbp), %rdi
	movl	$1, %ecx
	callq	x509_get_uid
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	je	.LBB2_36
# %bb.35:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_36:
	jmp	.LBB2_37
.LBB2_37:
	movq	-16(%rbp), %rax
	cmpl	$2, 48(%rax)
	je	.LBB2_39
# %bb.38:
	movq	-16(%rbp), %rax
	cmpl	$3, 48(%rax)
	jne	.LBB2_42
.LBB2_39:
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$368, %rdx                      # imm = 0x170
	leaq	-56(%rbp), %rdi
	movl	$2, %ecx
	callq	x509_get_uid
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	je	.LBB2_41
# %bb.40:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_41:
	jmp	.LBB2_42
.LBB2_42:
	movq	-16(%rbp), %rax
	cmpl	$3, 48(%rax)
	jne	.LBB2_46
# %bb.43:
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	leaq	-56(%rbp), %rdi
	callq	x509_get_crt_ext
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	je	.LBB2_45
# %bb.44:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_45:
	jmp	.LBB2_46
.LBB2_46:
	movq	-56(%rbp), %rax
	cmpq	-64(%rbp), %rax
	je	.LBB2_48
# %bb.47:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	$-8678, -4(%rbp)                # imm = 0xDE1A
	jmp	.LBB2_61
.LBB2_48:
	movq	-72(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rsi
	leaq	-56(%rbp), %rdi
	leaq	-144(%rbp), %rdx
	leaq	-120(%rbp), %rcx
	callq	mbedtls_x509_get_alg@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_50
# %bb.49:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_50:
	movq	-16(%rbp), %rax
	movq	88(%rax), %rax
	cmpq	-136(%rbp), %rax
	jne	.LBB2_55
# %bb.51:
	movq	-16(%rbp), %rax
	movq	96(%rax), %rdi
	movq	-128(%rbp), %rsi
	movq	-16(%rbp), %rax
	movq	88(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	jne	.LBB2_55
# %bb.52:
	movq	-88(%rbp), %rax
	cmpq	-112(%rbp), %rax
	jne	.LBB2_55
# %bb.53:
	cmpq	$0, -88(%rbp)
	je	.LBB2_56
# %bb.54:
	movq	-80(%rbp), %rdi
	movq	-104(%rbp), %rsi
	movq	-88(%rbp), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	je	.LBB2_56
.LBB2_55:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	$-9856, -4(%rbp)                # imm = 0xD980
	jmp	.LBB2_61
.LBB2_56:
	movq	-64(%rbp), %rsi
	movq	-16(%rbp), %rdx
	addq	$504, %rdx                      # imm = 0x1F8
	leaq	-56(%rbp), %rdi
	callq	mbedtls_x509_get_sig@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB2_58
# %bb.57:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_61
.LBB2_58:
	movq	-56(%rbp), %rax
	cmpq	-64(%rbp), %rax
	je	.LBB2_60
# %bb.59:
	movq	-16(%rbp), %rdi
	callq	mbedtls_x509_crt_free
	movl	$-8678, -4(%rbp)                # imm = 0xDE1A
	jmp	.LBB2_61
.LBB2_60:
	movl	$0, -4(%rbp)
.LBB2_61:
	movl	-4(%rbp), %eax
	addq	$144, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	x509_crt_parse_der_core, .Lfunc_end2-x509_crt_parse_der_core
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_parse          # -- Begin function mbedtls_x509_crt_parse
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_parse,@function
mbedtls_x509_crt_parse:                 # @mbedtls_x509_crt_parse
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -44(%rbp)
	movl	$1, -48(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB3_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB3_3
.LBB3_2:
	movl	$-10240, -4(%rbp)               # imm = 0xD800
	jmp	.LBB3_34
.LBB3_3:
	cmpq	$0, -32(%rbp)
	je	.LBB3_7
# %bb.4:
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rcx
	subq	$1, %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$0, %eax
	jne	.LBB3_7
# %bb.5:
	movq	-24(%rbp), %rdi
	leaq	.L.str(%rip), %rsi
	callq	strstr@PLT
	cmpq	$0, %rax
	je	.LBB3_7
# %bb.6:
	movl	$2, -48(%rbp)
.LBB3_7:
	cmpl	$1, -48(%rbp)
	jne	.LBB3_9
# %bb.8:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	mbedtls_x509_crt_parse_der
	movl	%eax, -4(%rbp)
	jmp	.LBB3_34
.LBB3_9:
	cmpl	$2, -48(%rbp)
	jne	.LBB3_29
# %bb.10:
	jmp	.LBB3_11
.LBB3_11:                               # =>This Inner Loop Header: Depth=1
	cmpq	$1, -32(%rbp)
	jbe	.LBB3_28
# %bb.12:                               #   in Loop: Header=BB3_11 Depth=1
	leaq	-80(%rbp), %rdi
	callq	mbedtls_pem_init@PLT
	movq	-24(%rbp), %rcx
	leaq	-80(%rbp), %rdi
	leaq	.L.str(%rip), %rsi
	leaq	.L.str.1(%rip), %rdx
	xorl	%eax, %eax
	movl	%eax, %r9d
	leaq	-88(%rbp), %rax
	movq	%r9, %r8
	movq	%rax, (%rsp)
	callq	mbedtls_pem_read_buffer@PLT
	movl	%eax, -52(%rbp)
	cmpl	$0, -52(%rbp)
	jne	.LBB3_14
# %bb.13:                               #   in Loop: Header=BB3_11 Depth=1
	movq	-88(%rbp), %rcx
	movq	-32(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-88(%rbp), %rax
	addq	-24(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB3_21
.LBB3_14:                               #   in Loop: Header=BB3_11 Depth=1
	cmpl	$-5248, -52(%rbp)               # imm = 0xEB80
	jne	.LBB3_16
# %bb.15:
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB3_34
.LBB3_16:                               #   in Loop: Header=BB3_11 Depth=1
	cmpl	$-4224, -52(%rbp)               # imm = 0xEF80
	je	.LBB3_20
# %bb.17:                               #   in Loop: Header=BB3_11 Depth=1
	leaq	-80(%rbp), %rdi
	callq	mbedtls_pem_free@PLT
	movq	-88(%rbp), %rcx
	movq	-32(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-88(%rbp), %rax
	addq	-24(%rbp), %rax
	movq	%rax, -24(%rbp)
	cmpl	$0, -40(%rbp)
	jne	.LBB3_19
# %bb.18:                               #   in Loop: Header=BB3_11 Depth=1
	movl	-52(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB3_19:                               #   in Loop: Header=BB3_11 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB3_11
.LBB3_20:
	jmp	.LBB3_28
.LBB3_21:                               #   in Loop: Header=BB3_11 Depth=1
	movq	-16(%rbp), %rdi
	movq	-80(%rbp), %rsi
	movq	-72(%rbp), %rdx
	callq	mbedtls_x509_crt_parse_der
	movl	%eax, -52(%rbp)
	leaq	-80(%rbp), %rdi
	callq	mbedtls_pem_free@PLT
	cmpl	$0, -52(%rbp)
	je	.LBB3_27
# %bb.22:                               #   in Loop: Header=BB3_11 Depth=1
	cmpl	$-10368, -52(%rbp)              # imm = 0xD780
	jne	.LBB3_24
# %bb.23:
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB3_34
.LBB3_24:                               #   in Loop: Header=BB3_11 Depth=1
	cmpl	$0, -40(%rbp)
	jne	.LBB3_26
# %bb.25:                               #   in Loop: Header=BB3_11 Depth=1
	movl	-52(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB3_26:                               #   in Loop: Header=BB3_11 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB3_11
.LBB3_27:                               #   in Loop: Header=BB3_11 Depth=1
	movl	$1, -36(%rbp)
	jmp	.LBB3_11
.LBB3_28:
	jmp	.LBB3_29
.LBB3_29:
	cmpl	$0, -36(%rbp)
	je	.LBB3_31
# %bb.30:
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB3_34
.LBB3_31:
	cmpl	$0, -40(%rbp)
	je	.LBB3_33
# %bb.32:
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB3_34
.LBB3_33:
	movl	$-10112, -4(%rbp)               # imm = 0xD880
.LBB3_34:
	movl	-4(%rbp), %eax
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	mbedtls_x509_crt_parse, .Lfunc_end3-mbedtls_x509_crt_parse
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_parse_file     # -- Begin function mbedtls_x509_crt_parse_file
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_parse_file,@function
mbedtls_x509_crt_parse_file:            # @mbedtls_x509_crt_parse_file
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-24(%rbp), %rdi
	leaq	-48(%rbp), %rsi
	leaq	-40(%rbp), %rdx
	callq	mbedtls_pk_load_file@PLT
	movl	%eax, -28(%rbp)
	cmpl	$0, %eax
	je	.LBB4_2
# %bb.1:
	movl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB4_3
.LBB4_2:
	movq	-16(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movq	-40(%rbp), %rdx
	callq	mbedtls_x509_crt_parse
	movl	%eax, -28(%rbp)
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	mbedtls_zeroize
	movq	-48(%rbp), %rdi
	callq	free@PLT
	movl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB4_3:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	mbedtls_x509_crt_parse_file, .Lfunc_end4-mbedtls_x509_crt_parse_file
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function mbedtls_zeroize
	.type	mbedtls_zeroize,@function
mbedtls_zeroize:                        # @mbedtls_zeroize
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$-1, %rcx
	movq	%rcx, -16(%rbp)
	cmpq	$0, %rax
	je	.LBB5_3
# %bb.2:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -24(%rbp)
	movb	$0, (%rax)
	jmp	.LBB5_1
.LBB5_3:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	mbedtls_zeroize, .Lfunc_end5-mbedtls_zeroize
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_parse_path     # -- Begin function mbedtls_x509_crt_parse_path
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_parse_path,@function
mbedtls_x509_crt_parse_path:            # @mbedtls_x509_crt_parse_path
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$720, %rsp                      # imm = 0x2D0
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movl	$0, -28(%rbp)
	movq	-24(%rbp), %rdi
	callq	opendir@PLT
	movq	%rax, -712(%rbp)
	cmpq	$0, -712(%rbp)
	jne	.LBB6_2
# %bb.1:
	movl	$-10496, -4(%rbp)               # imm = 0xD700
	jmp	.LBB6_18
.LBB6_2:
	jmp	.LBB6_3
.LBB6_3:                                # =>This Inner Loop Header: Depth=1
	movq	-712(%rbp), %rdi
	callq	readdir@PLT
	movq	%rax, -192(%rbp)
	cmpq	$0, %rax
	je	.LBB6_16
# %bb.4:                                #   in Loop: Header=BB6_3 Depth=1
	leaq	-704(%rbp), %rdi
	movq	-24(%rbp), %rcx
	movq	-192(%rbp), %r8
	addq	$19, %r8
	movl	$512, %esi                      # imm = 0x200
	leaq	.L.str.2(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jl	.LBB6_6
# %bb.5:                                #   in Loop: Header=BB6_3 Depth=1
	movslq	-36(%rbp), %rax
	cmpq	$512, %rax                      # imm = 0x200
	jb	.LBB6_7
.LBB6_6:
	movl	$-10624, -28(%rbp)              # imm = 0xD680
	jmp	.LBB6_17
.LBB6_7:                                #   in Loop: Header=BB6_3 Depth=1
	leaq	-704(%rbp), %rdi
	leaq	-184(%rbp), %rsi
	callq	stat@PLT
	cmpl	$-1, %eax
	jne	.LBB6_9
# %bb.8:
	movl	$-10496, -28(%rbp)              # imm = 0xD700
	jmp	.LBB6_17
.LBB6_9:                                #   in Loop: Header=BB6_3 Depth=1
	jmp	.LBB6_10
.LBB6_10:                               #   in Loop: Header=BB6_3 Depth=1
	movl	-160(%rbp), %eax
	andl	$61440, %eax                    # imm = 0xF000
	cmpl	$32768, %eax                    # imm = 0x8000
	je	.LBB6_12
# %bb.11:                               #   in Loop: Header=BB6_3 Depth=1
	jmp	.LBB6_3
.LBB6_12:                               #   in Loop: Header=BB6_3 Depth=1
	movq	-16(%rbp), %rdi
	leaq	-704(%rbp), %rsi
	callq	mbedtls_x509_crt_parse_file
	movl	%eax, -32(%rbp)
	cmpl	$0, -32(%rbp)
	jge	.LBB6_14
# %bb.13:                               #   in Loop: Header=BB6_3 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB6_15
.LBB6_14:                               #   in Loop: Header=BB6_3 Depth=1
	movl	-32(%rbp), %eax
	addl	-28(%rbp), %eax
	movl	%eax, -28(%rbp)
.LBB6_15:                               #   in Loop: Header=BB6_3 Depth=1
	jmp	.LBB6_3
.LBB6_16:
	jmp	.LBB6_17
.LBB6_17:
	movq	-712(%rbp), %rdi
	callq	closedir@PLT
	movl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB6_18:
	movl	-4(%rbp), %eax
	addq	$720, %rsp                      # imm = 0x2D0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	mbedtls_x509_crt_parse_path, .Lfunc_end6-mbedtls_x509_crt_parse_path
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_info           # -- Begin function mbedtls_x509_crt_info
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_info,@function
mbedtls_x509_crt_info:                  # @mbedtls_x509_crt_info
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$168, %rsp
	.cfi_offset %rbx, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -64(%rbp)
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	cmpq	-48(%rbp), %rax
	jne	.LBB7_7
# %bb.1:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	leaq	.L.str.3(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.2:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_4
# %bb.3:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_5
.LBB7_4:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_5:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.6:
	movq	-32(%rbp), %rax
	subq	-64(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_125
.LBB7_7:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movl	48(%rax), %r8d
	leaq	.L.str.4(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.8:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_10
# %bb.9:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_11
.LBB7_10:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_11:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.12:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.5(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.13:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_15
# %bb.14:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_16
.LBB7_15:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_16:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.17:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rdx
	addq	$56, %rdx
	callq	mbedtls_x509_serial_gets@PLT
	movl	%eax, -52(%rbp)
# %bb.18:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_20
# %bb.19:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_21
.LBB7_20:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_21:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.22:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.6(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.23:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_25
# %bb.24:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_26
.LBB7_25:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_26:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.27:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rdx
	addq	$152, %rdx
	callq	mbedtls_x509_dn_gets@PLT
	movl	%eax, -52(%rbp)
# %bb.28:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_30
# %bb.29:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_31
.LBB7_30:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_31:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.32:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.7(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.33:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_35
# %bb.34:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_36
.LBB7_35:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_36:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.37:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rdx
	addq	$216, %rdx
	callq	mbedtls_x509_dn_gets@PLT
	movl	%eax, -52(%rbp)
# %bb.38:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_40
# %bb.39:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_41
.LBB7_40:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_41:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.42:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movl	280(%rax), %r8d
	movq	-48(%rbp), %rax
	movl	284(%rax), %r9d
	movq	-48(%rbp), %rax
	movl	288(%rax), %ebx
	movq	-48(%rbp), %rax
	movl	292(%rax), %r11d
	movq	-48(%rbp), %rax
	movl	296(%rax), %r10d
	movq	-48(%rbp), %rax
	movl	300(%rax), %eax
	leaq	.L.str.8(%rip), %rdx
	movl	%ebx, (%rsp)
	movl	%r11d, 8(%rsp)
	movl	%r10d, 16(%rsp)
	movl	%eax, 24(%rsp)
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.43:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_45
# %bb.44:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_46
.LBB7_45:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_46:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.47:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movl	304(%rax), %r8d
	movq	-48(%rbp), %rax
	movl	308(%rax), %r9d
	movq	-48(%rbp), %rax
	movl	312(%rax), %ebx
	movq	-48(%rbp), %rax
	movl	316(%rax), %r11d
	movq	-48(%rbp), %rax
	movl	320(%rax), %r10d
	movq	-48(%rbp), %rax
	movl	324(%rax), %eax
	leaq	.L.str.9(%rip), %rdx
	movl	%ebx, (%rsp)
	movl	%r11d, 8(%rsp)
	movl	%r10d, 16(%rsp)
	movl	%eax, 24(%rsp)
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.48:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_50
# %bb.49:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_51
.LBB7_50:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_51:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.52:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.10(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.53:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_55
# %bb.54:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_56
.LBB7_55:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_56:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.57:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rdx
	addq	$80, %rdx
	movq	-48(%rbp), %rax
	movl	532(%rax), %ecx
	movq	-48(%rbp), %rax
	movl	528(%rax), %r8d
	movq	-48(%rbp), %rax
	movq	536(%rax), %r9
	callq	mbedtls_x509_sig_alg_gets@PLT
	movl	%eax, -52(%rbp)
# %bb.58:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_60
# %bb.59:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_61
.LBB7_60:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_61:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.62:
	leaq	-96(%rbp), %rax
	movq	%rax, -104(%rbp)                # 8-byte Spill
	movq	-48(%rbp), %rdi
	addq	$328, %rdi                      # imm = 0x148
	callq	mbedtls_pk_get_name@PLT
	movq	-104(%rbp), %rdi                # 8-byte Reload
	movq	%rax, %rdx
	movl	$18, %esi
	callq	mbedtls_x509_key_size_helper@PLT
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB7_64
# %bb.63:
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_125
.LBB7_64:
	movq	-72(%rbp), %rax
	movq	%rax, -136(%rbp)                # 8-byte Spill
	movq	-64(%rbp), %rax
	movq	%rax, -128(%rbp)                # 8-byte Spill
	movq	-40(%rbp), %rax
	movq	%rax, -120(%rbp)                # 8-byte Spill
	leaq	-96(%rbp), %rax
	movq	%rax, -112(%rbp)                # 8-byte Spill
	movq	-48(%rbp), %rdi
	addq	$328, %rdi                      # imm = 0x148
	callq	mbedtls_pk_get_bitlen@PLT
	movq	-136(%rbp), %rdi                # 8-byte Reload
	movq	-128(%rbp), %rsi                # 8-byte Reload
	movq	-120(%rbp), %rcx                # 8-byte Reload
	movq	-112(%rbp), %r8                 # 8-byte Reload
	movl	%eax, %r9d
	leaq	.L.str.11(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.65:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_67
# %bb.66:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_68
.LBB7_67:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_68:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.69:
	movq	-48(%rbp), %rax
	movl	448(%rax), %eax
	andl	$256, %eax                      # imm = 0x100
	cmpl	$0, %eax
	je	.LBB7_83
# %bb.70:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movl	452(%rax), %edx
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.13(%rip), %rax
	cmpl	$0, %edx
	cmovneq	%rax, %r8
	leaq	.L.str.12(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.71:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_73
# %bb.72:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_74
.LBB7_73:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_74:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.75:
	movq	-48(%rbp), %rax
	cmpl	$0, 456(%rax)
	jle	.LBB7_82
# %bb.76:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rax
	movl	456(%rax), %ecx
	subl	$1, %ecx
	leaq	.L.str.15(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.77:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_79
# %bb.78:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_80
.LBB7_79:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_80:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.81:
	jmp	.LBB7_82
.LBB7_82:
	jmp	.LBB7_83
.LBB7_83:
	movq	-48(%rbp), %rax
	movl	448(%rax), %eax
	andl	$32, %eax
	cmpl	$0, %eax
	je	.LBB7_92
# %bb.84:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.16(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.85:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_87
# %bb.86:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_88
.LBB7_87:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_88:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.89:
	movq	-48(%rbp), %rdx
	addq	$416, %rdx                      # imm = 0x1A0
	leaq	-72(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	callq	x509_info_subject_alt_name
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB7_91
# %bb.90:
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_125
.LBB7_91:
	jmp	.LBB7_92
.LBB7_92:
	movq	-48(%rbp), %rax
	movl	448(%rax), %eax
	andl	$65536, %eax                    # imm = 0x10000
	cmpl	$0, %eax
	je	.LBB7_101
# %bb.93:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.17(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.94:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_96
# %bb.95:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_97
.LBB7_96:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_97:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.98:
	movq	-48(%rbp), %rax
	leaq	-72(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	movzbl	496(%rax), %edx
	callq	x509_info_cert_type
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB7_100
# %bb.99:
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_125
.LBB7_100:
	jmp	.LBB7_101
.LBB7_101:
	movq	-48(%rbp), %rax
	movl	448(%rax), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB7_110
# %bb.102:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.18(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.103:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_105
# %bb.104:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_106
.LBB7_105:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_106:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.107:
	movq	-48(%rbp), %rax
	movl	460(%rax), %edx
	leaq	-72(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	callq	x509_info_key_usage
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB7_109
# %bb.108:
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_125
.LBB7_109:
	jmp	.LBB7_110
.LBB7_110:
	movq	-48(%rbp), %rax
	movl	448(%rax), %eax
	andl	$2048, %eax                     # imm = 0x800
	cmpl	$0, %eax
	je	.LBB7_119
# %bb.111:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rcx
	leaq	.L.str.19(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.112:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_114
# %bb.113:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_115
.LBB7_114:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_115:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.116:
	movq	-48(%rbp), %rdx
	addq	$464, %rdx                      # imm = 0x1D0
	leaq	-72(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	callq	x509_info_ext_key_usage
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB7_118
# %bb.117:
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_125
.LBB7_118:
	jmp	.LBB7_119
.LBB7_119:
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	leaq	.L.str.20(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -52(%rbp)
# %bb.120:
	cmpl	$0, -52(%rbp)
	jl	.LBB7_122
# %bb.121:
	movslq	-52(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB7_123
.LBB7_122:
	movl	$-10624, -12(%rbp)              # imm = 0xD680
	jmp	.LBB7_125
.LBB7_123:
	movslq	-52(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-52(%rbp), %rax
	addq	-72(%rbp), %rax
	movq	%rax, -72(%rbp)
# %bb.124:
	movq	-32(%rbp), %rax
	subq	-64(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -12(%rbp)
.LBB7_125:
	movl	-12(%rbp), %eax
	addq	$168, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	mbedtls_x509_crt_info, .Lfunc_end7-mbedtls_x509_crt_info
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_info_subject_alt_name
	.type	x509_info_subject_alt_name,@function
x509_info_subject_alt_name:             # @x509_info_subject_alt_name
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -64(%rbp)
	leaq	.L.str.26(%rip), %rax
	movq	%rax, -72(%rbp)
	movq	$0, -80(%rbp)
.LBB8_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_5 Depth 2
                                        #     Child Loop BB8_9 Depth 2
	cmpq	$0, -64(%rbp)
	je	.LBB8_13
# %bb.2:                                #   in Loop: Header=BB8_1 Depth=1
	movq	-64(%rbp), %rax
	movq	8(%rax), %rax
	addq	-80(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jb	.LBB8_4
# %bb.3:
	movq	-56(%rbp), %rax
	movb	$0, (%rax)
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB8_14
.LBB8_4:                                #   in Loop: Header=BB8_1 Depth=1
	movq	-64(%rbp), %rax
	movq	8(%rax), %rcx
	addq	-80(%rbp), %rcx
	movq	-48(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	$0, -40(%rbp)
.LBB8_5:                                #   Parent Loop BB8_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-40(%rbp), %rax
	cmpq	-80(%rbp), %rax
	jae	.LBB8_8
# %bb.6:                                #   in Loop: Header=BB8_5 Depth=2
	movq	-72(%rbp), %rax
	movq	-40(%rbp), %rcx
	movb	(%rax,%rcx), %cl
	movq	-56(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -56(%rbp)
	movb	%cl, (%rax)
# %bb.7:                                #   in Loop: Header=BB8_5 Depth=2
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB8_5
.LBB8_8:                                #   in Loop: Header=BB8_1 Depth=1
	movq	$0, -40(%rbp)
.LBB8_9:                                #   Parent Loop BB8_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-40(%rbp), %rax
	movq	-64(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB8_12
# %bb.10:                               #   in Loop: Header=BB8_9 Depth=2
	movq	-64(%rbp), %rax
	movq	16(%rax), %rax
	movq	-40(%rbp), %rcx
	movb	(%rax,%rcx), %cl
	movq	-56(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -56(%rbp)
	movb	%cl, (%rax)
# %bb.11:                               #   in Loop: Header=BB8_9 Depth=2
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB8_9
.LBB8_12:                               #   in Loop: Header=BB8_1 Depth=1
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -72(%rbp)
	movq	$2, -80(%rbp)
	movq	-64(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -64(%rbp)
	jmp	.LBB8_1
.LBB8_13:
	movq	-56(%rbp), %rax
	movb	$0, (%rax)
	movq	-48(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movl	$0, -4(%rbp)
.LBB8_14:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	x509_info_subject_alt_name, .Lfunc_end8-x509_info_subject_alt_name
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_info_cert_type
	.type	x509_info_cert_type,@function
x509_info_cert_type:                    # @x509_info_cert_type
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movb	%dl, %al
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movb	%al, -25(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	leaq	.L.str.26(%rip), %rax
	movq	%rax, -56(%rbp)
	movzbl	-25(%rbp), %eax
	andl	$128, %eax
	cmpl	$0, %eax
	je	.LBB9_7
# %bb.1:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.28(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.2:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_4
# %bb.3:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_5
.LBB9_4:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_5:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.6:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_7:
	movzbl	-25(%rbp), %eax
	andl	$64, %eax
	cmpl	$0, %eax
	je	.LBB9_14
# %bb.8:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.29(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.9:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_11
# %bb.10:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_12
.LBB9_11:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_12:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.13:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_14:
	movzbl	-25(%rbp), %eax
	andl	$32, %eax
	cmpl	$0, %eax
	je	.LBB9_21
# %bb.15:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.30(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.16:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_18
# %bb.17:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_19
.LBB9_18:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_19:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.20:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_21:
	movzbl	-25(%rbp), %eax
	andl	$16, %eax
	cmpl	$0, %eax
	je	.LBB9_28
# %bb.22:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.31(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.23:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_25
# %bb.24:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_26
.LBB9_25:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_26:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.27:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_28:
	movzbl	-25(%rbp), %eax
	andl	$8, %eax
	cmpl	$0, %eax
	je	.LBB9_35
# %bb.29:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.32(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.30:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_32
# %bb.31:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_33
.LBB9_32:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_33:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.34:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_35:
	movzbl	-25(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB9_42
# %bb.36:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.33(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.37:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_39
# %bb.38:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_40
.LBB9_39:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_40:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.41:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_42:
	movzbl	-25(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB9_49
# %bb.43:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.34(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.44:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_46
# %bb.45:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_47
.LBB9_46:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_47:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.48:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_49:
	movzbl	-25(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB9_56
# %bb.50:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.35(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.51:
	cmpl	$0, -32(%rbp)
	jl	.LBB9_53
# %bb.52:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB9_54
.LBB9_53:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB9_57
.LBB9_54:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.55:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB9_56:
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-48(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movl	$0, -4(%rbp)
.LBB9_57:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	x509_info_cert_type, .Lfunc_end9-x509_info_cert_type
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_info_key_usage
	.type	x509_info_key_usage,@function
x509_info_key_usage:                    # @x509_info_key_usage
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	leaq	.L.str.26(%rip), %rax
	movq	%rax, -56(%rbp)
	movl	-28(%rbp), %eax
	andl	$128, %eax
	cmpl	$0, %eax
	je	.LBB10_7
# %bb.1:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.36(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.2:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_4
# %bb.3:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_5
.LBB10_4:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_5:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.6:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_7:
	movl	-28(%rbp), %eax
	andl	$64, %eax
	cmpl	$0, %eax
	je	.LBB10_14
# %bb.8:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.37(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.9:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_11
# %bb.10:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_12
.LBB10_11:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_12:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.13:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_14:
	movl	-28(%rbp), %eax
	andl	$32, %eax
	cmpl	$0, %eax
	je	.LBB10_21
# %bb.15:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.38(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.16:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_18
# %bb.17:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_19
.LBB10_18:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_19:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.20:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_21:
	movl	-28(%rbp), %eax
	andl	$16, %eax
	cmpl	$0, %eax
	je	.LBB10_28
# %bb.22:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.39(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.23:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_25
# %bb.24:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_26
.LBB10_25:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_26:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.27:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_28:
	movl	-28(%rbp), %eax
	andl	$8, %eax
	cmpl	$0, %eax
	je	.LBB10_35
# %bb.29:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.40(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.30:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_32
# %bb.31:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_33
.LBB10_32:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_33:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.34:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_35:
	movl	-28(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB10_42
# %bb.36:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.41(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.37:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_39
# %bb.38:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_40
.LBB10_39:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_40:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.41:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_42:
	movl	-28(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB10_49
# %bb.43:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.42(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.44:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_46
# %bb.45:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_47
.LBB10_46:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_47:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.48:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_49:
	movl	-28(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB10_56
# %bb.50:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.43(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.51:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_53
# %bb.52:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_54
.LBB10_53:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_54:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.55:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_56:
	movl	-28(%rbp), %eax
	andl	$32768, %eax                    # imm = 0x8000
	cmpl	$0, %eax
	je	.LBB10_63
# %bb.57:
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-56(%rbp), %rcx
	leaq	.L.str.44(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -32(%rbp)
# %bb.58:
	cmpl	$0, -32(%rbp)
	jl	.LBB10_60
# %bb.59:
	movslq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.LBB10_61
.LBB10_60:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB10_64
.LBB10_61:
	movslq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movslq	-32(%rbp), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.62:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -56(%rbp)
.LBB10_63:
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-48(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movl	$0, -4(%rbp)
.LBB10_64:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	x509_info_key_usage, .Lfunc_end10-x509_info_key_usage
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_info_ext_key_usage
	.type	x509_info_ext_key_usage,@function
x509_info_ext_key_usage:                # @x509_info_ext_key_usage
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -72(%rbp)
	leaq	.L.str.26(%rip), %rax
	movq	%rax, -80(%rbp)
.LBB11_1:                               # =>This Inner Loop Header: Depth=1
	cmpq	$0, -72(%rbp)
	je	.LBB11_10
# %bb.2:                                #   in Loop: Header=BB11_1 Depth=1
	movq	-72(%rbp), %rdi
	leaq	-48(%rbp), %rsi
	callq	mbedtls_oid_get_extended_key_usage@PLT
	cmpl	$0, %eax
	je	.LBB11_4
# %bb.3:                                #   in Loop: Header=BB11_1 Depth=1
	leaq	.L.str.45(%rip), %rax
	movq	%rax, -48(%rbp)
.LBB11_4:                               #   in Loop: Header=BB11_1 Depth=1
	movq	-64(%rbp), %rdi
	movq	-56(%rbp), %rsi
	movq	-80(%rbp), %rcx
	movq	-48(%rbp), %r8
	leaq	.L.str.46(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -36(%rbp)
# %bb.5:                                #   in Loop: Header=BB11_1 Depth=1
	cmpl	$0, -36(%rbp)
	jl	.LBB11_7
# %bb.6:                                #   in Loop: Header=BB11_1 Depth=1
	movslq	-36(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jb	.LBB11_8
.LBB11_7:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB11_11
.LBB11_8:                               #   in Loop: Header=BB11_1 Depth=1
	movslq	-36(%rbp), %rcx
	movq	-56(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movslq	-36(%rbp), %rax
	addq	-64(%rbp), %rax
	movq	%rax, -64(%rbp)
# %bb.9:                                #   in Loop: Header=BB11_1 Depth=1
	leaq	.L.str.27(%rip), %rax
	movq	%rax, -80(%rbp)
	movq	-72(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -72(%rbp)
	jmp	.LBB11_1
.LBB11_10:
	movq	-56(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-64(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movl	$0, -4(%rbp)
.LBB11_11:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	x509_info_ext_key_usage, .Lfunc_end11-x509_info_ext_key_usage
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_verify_info    # -- Begin function mbedtls_x509_crt_verify_info
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_verify_info,@function
mbedtls_x509_crt_verify_info:           # @mbedtls_x509_crt_verify_info
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -64(%rbp)
	leaq	x509_crt_verify_strings(%rip), %rax
	movq	%rax, -48(%rbp)
.LBB12_1:                               # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rax
	cmpq	$0, 8(%rax)
	je	.LBB12_11
# %bb.2:                                #   in Loop: Header=BB12_1 Depth=1
	movl	-36(%rbp), %eax
	movq	-48(%rbp), %rcx
	andl	(%rcx), %eax
	cmpl	$0, %eax
	jne	.LBB12_4
# %bb.3:                                #   in Loop: Header=BB12_1 Depth=1
	jmp	.LBB12_10
.LBB12_4:                               #   in Loop: Header=BB12_1 Depth=1
	movq	-56(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rcx
	movq	-48(%rbp), %rax
	movq	8(%rax), %r8
	leaq	.L.str.21(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -40(%rbp)
# %bb.5:                                #   in Loop: Header=BB12_1 Depth=1
	cmpl	$0, -40(%rbp)
	jl	.LBB12_7
# %bb.6:                                #   in Loop: Header=BB12_1 Depth=1
	movslq	-40(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB12_8
.LBB12_7:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB12_19
.LBB12_8:                               #   in Loop: Header=BB12_1 Depth=1
	movslq	-40(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-40(%rbp), %rax
	addq	-56(%rbp), %rax
	movq	%rax, -56(%rbp)
# %bb.9:                                #   in Loop: Header=BB12_1 Depth=1
	movq	-48(%rbp), %rax
	movl	(%rax), %eax
	xorl	-36(%rbp), %eax
	movl	%eax, -36(%rbp)
.LBB12_10:                              #   in Loop: Header=BB12_1 Depth=1
	movq	-48(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB12_1
.LBB12_11:
	cmpl	$0, -36(%rbp)
	je	.LBB12_18
# %bb.12:
	movq	-56(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rcx
	leaq	.L.str.22(%rip), %rdx
	movb	$0, %al
	callq	snprintf@PLT
	movl	%eax, -40(%rbp)
# %bb.13:
	cmpl	$0, -40(%rbp)
	jl	.LBB12_15
# %bb.14:
	movslq	-40(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.LBB12_16
.LBB12_15:
	movl	$-10624, -4(%rbp)               # imm = 0xD680
	jmp	.LBB12_19
.LBB12_16:
	movslq	-40(%rbp), %rcx
	movq	-64(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movslq	-40(%rbp), %rax
	addq	-56(%rbp), %rax
	movq	%rax, -56(%rbp)
# %bb.17:
	jmp	.LBB12_18
.LBB12_18:
	movq	-24(%rbp), %rax
	subq	-64(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -4(%rbp)
.LBB12_19:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	mbedtls_x509_crt_verify_info, .Lfunc_end12-mbedtls_x509_crt_verify_info
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_check_key_usage # -- Begin function mbedtls_x509_crt_check_key_usage
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_check_key_usage,@function
mbedtls_x509_crt_check_key_usage:       # @mbedtls_x509_crt_check_key_usage
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	$32769, -32(%rbp)               # imm = 0x8001
	movq	-16(%rbp), %rax
	movl	448(%rax), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	jne	.LBB13_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB13_7
.LBB13_2:
	movl	-20(%rbp), %eax
	movl	-32(%rbp), %ecx
	xorl	$-1, %ecx
	andl	%ecx, %eax
	movl	%eax, -24(%rbp)
	movq	-16(%rbp), %rax
	movl	460(%rax), %eax
	movl	-32(%rbp), %ecx
	xorl	$-1, %ecx
	andl	%ecx, %eax
	andl	-24(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB13_4
# %bb.3:
	movl	$-10240, -4(%rbp)               # imm = 0xD800
	jmp	.LBB13_7
.LBB13_4:
	movl	-20(%rbp), %eax
	andl	-32(%rbp), %eax
	movl	%eax, -28(%rbp)
	movq	-16(%rbp), %rax
	movl	460(%rax), %eax
	andl	-32(%rbp), %eax
	orl	-28(%rbp), %eax
	cmpl	-28(%rbp), %eax
	je	.LBB13_6
# %bb.5:
	movl	$-10240, -4(%rbp)               # imm = 0xD800
	jmp	.LBB13_7
.LBB13_6:
	movl	$0, -4(%rbp)
.LBB13_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	mbedtls_x509_crt_check_key_usage, .Lfunc_end13-mbedtls_x509_crt_check_key_usage
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_check_extended_key_usage # -- Begin function mbedtls_x509_crt_check_extended_key_usage
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_check_extended_key_usage,@function
mbedtls_x509_crt_check_extended_key_usage: # @mbedtls_x509_crt_check_extended_key_usage
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rax
	movl	448(%rax), %eax
	andl	$2048, %eax                     # imm = 0x800
	cmpl	$0, %eax
	jne	.LBB14_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB14_14
.LBB14_2:
	movq	-16(%rbp), %rax
	addq	$464, %rax                      # imm = 0x1D0
	movq	%rax, -40(%rbp)
.LBB14_3:                               # =>This Inner Loop Header: Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB14_13
# %bb.4:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.LBB14_7
# %bb.5:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-48(%rbp), %rax
	movq	16(%rax), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	jne	.LBB14_7
# %bb.6:
	movl	$0, -4(%rbp)
	jmp	.LBB14_14
.LBB14_7:                               #   in Loop: Header=BB14_3 Depth=1
	movq	-48(%rbp), %rdx
	movb	$1, %al
	movl	$4, %ecx
	cmpq	8(%rdx), %rcx
	movb	%al, -49(%rbp)                  # 1-byte Spill
	jne	.LBB14_9
# %bb.8:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-48(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-48(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	.L.str.23(%rip), %rdi
	callq	memcmp@PLT
	cmpl	$0, %eax
	setne	%al
	movb	%al, -49(%rbp)                  # 1-byte Spill
.LBB14_9:                               #   in Loop: Header=BB14_3 Depth=1
	movb	-49(%rbp), %al                  # 1-byte Reload
	andb	$1, %al
	movzbl	%al, %eax
	cmpl	$0, %eax
	jne	.LBB14_11
# %bb.10:
	movl	$0, -4(%rbp)
	jmp	.LBB14_14
.LBB14_11:                              #   in Loop: Header=BB14_3 Depth=1
	jmp	.LBB14_12
.LBB14_12:                              #   in Loop: Header=BB14_3 Depth=1
	movq	-40(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB14_3
.LBB14_13:
	movl	$-10240, -4(%rbp)               # imm = 0xD800
.LBB14_14:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end14:
	.size	mbedtls_x509_crt_check_extended_key_usage, .Lfunc_end14-mbedtls_x509_crt_check_extended_key_usage
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_is_revoked     # -- Begin function mbedtls_x509_crt_is_revoked
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_is_revoked,@function
mbedtls_x509_crt_is_revoked:            # @mbedtls_x509_crt_is_revoked
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-24(%rbp), %rax
	addq	$216, %rax
	movq	%rax, -32(%rbp)
.LBB15_1:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -32(%rbp)
	movb	%al, -33(%rbp)                  # 1-byte Spill
	je	.LBB15_3
# %bb.2:                                #   in Loop: Header=BB15_1 Depth=1
	movq	-32(%rbp), %rax
	cmpq	$0, 32(%rax)
	setne	%al
	movb	%al, -33(%rbp)                  # 1-byte Spill
.LBB15_3:                               #   in Loop: Header=BB15_1 Depth=1
	movb	-33(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB15_4
	jmp	.LBB15_10
.LBB15_4:                               #   in Loop: Header=BB15_1 Depth=1
	movq	-16(%rbp), %rax
	movq	64(%rax), %rax
	movq	-32(%rbp), %rcx
	cmpq	32(%rcx), %rax
	jne	.LBB15_9
# %bb.5:                                #   in Loop: Header=BB15_1 Depth=1
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-32(%rbp), %rax
	movq	40(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	64(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	jne	.LBB15_9
# %bb.6:                                #   in Loop: Header=BB15_1 Depth=1
	movq	-32(%rbp), %rdi
	addq	$48, %rdi
	callq	mbedtls_x509_time_is_past@PLT
	cmpl	$0, %eax
	je	.LBB15_8
# %bb.7:
	movl	$1, -4(%rbp)
	jmp	.LBB15_11
.LBB15_8:                               #   in Loop: Header=BB15_1 Depth=1
	jmp	.LBB15_9
.LBB15_9:                               #   in Loop: Header=BB15_1 Depth=1
	movq	-32(%rbp), %rax
	movq	96(%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB15_1
.LBB15_10:
	movl	$0, -4(%rbp)
.LBB15_11:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	mbedtls_x509_crt_is_revoked, .Lfunc_end15-mbedtls_x509_crt_is_revoked
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_verify         # -- Begin function mbedtls_x509_crt_verify
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_verify,@function
mbedtls_x509_crt_verify:                # @mbedtls_x509_crt_verify
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	16(%rbp), %rax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movq	-32(%rbp), %r8
	movq	-40(%rbp), %r9
	movq	-48(%rbp), %r10
	movq	16(%rbp), %rax
	leaq	mbedtls_x509_crt_profile_default(%rip), %rcx
	movq	%r10, (%rsp)
	movq	%rax, 8(%rsp)
	callq	mbedtls_x509_crt_verify_with_profile
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end16:
	.size	mbedtls_x509_crt_verify, .Lfunc_end16-mbedtls_x509_crt_verify
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_verify_with_profile # -- Begin function mbedtls_x509_crt_verify_with_profile
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_verify_with_profile,@function
mbedtls_x509_crt_verify_with_profile:   # @mbedtls_x509_crt_verify_with_profile
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset %rbx, -24
	movq	24(%rbp), %rax
	movq	16(%rbp), %rax
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	%r9, -64(%rbp)
	movl	$0, -80(%rbp)
	movl	$0, -84(%rbp)
	movq	$0, -112(%rbp)
	movq	-64(%rbp), %rax
	movl	$0, (%rax)
	cmpq	$0, -48(%rbp)
	jne	.LBB17_2
# %bb.1:
	movl	$-10240, -76(%rbp)              # imm = 0xD800
	jmp	.LBB17_64
.LBB17_2:
	cmpq	$0, -56(%rbp)
	je	.LBB17_35
# %bb.3:
	movq	-24(%rbp), %rax
	addq	$216, %rax
	movq	%rax, -104(%rbp)
	movq	-56(%rbp), %rdi
	callq	strlen@PLT
	movq	%rax, -72(%rbp)
	movq	-24(%rbp), %rax
	movl	448(%rax), %eax
	andl	$32, %eax
	cmpl	$0, %eax
	je	.LBB17_17
# %bb.4:
	movq	-24(%rbp), %rax
	addq	$416, %rax                      # imm = 0x1A0
	movq	%rax, -112(%rbp)
.LBB17_5:                               # =>This Inner Loop Header: Depth=1
	cmpq	$0, -112(%rbp)
	je	.LBB17_14
# %bb.6:                                #   in Loop: Header=BB17_5 Depth=1
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	cmpq	-72(%rbp), %rax
	jne	.LBB17_9
# %bb.7:                                #   in Loop: Header=BB17_5 Depth=1
	movq	-56(%rbp), %rdi
	movq	-112(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-72(%rbp), %rdx
	callq	x509_memcasecmp
	cmpl	$0, %eax
	jne	.LBB17_9
# %bb.8:
	jmp	.LBB17_14
.LBB17_9:                               #   in Loop: Header=BB17_5 Depth=1
	movq	-112(%rbp), %rax
	cmpq	$2, 8(%rax)
	jbe	.LBB17_13
# %bb.10:                               #   in Loop: Header=BB17_5 Depth=1
	movq	-112(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	(%rax), %eax
	subl	$11818, %eax                    # imm = 0x2E2A
	setne	%al
	movzbl	%al, %eax
	cmpl	$0, %eax
	jne	.LBB17_13
# %bb.11:                               #   in Loop: Header=BB17_5 Depth=1
	movq	-56(%rbp), %rdi
	movq	-112(%rbp), %rsi
	callq	x509_check_wildcard
	cmpl	$0, %eax
	jne	.LBB17_13
# %bb.12:
	jmp	.LBB17_14
.LBB17_13:                              #   in Loop: Header=BB17_5 Depth=1
	movq	-112(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -112(%rbp)
	jmp	.LBB17_5
.LBB17_14:
	cmpq	$0, -112(%rbp)
	jne	.LBB17_16
# %bb.15:
	movq	-64(%rbp), %rax
	movl	(%rax), %ecx
	orl	$4, %ecx
	movl	%ecx, (%rax)
.LBB17_16:
	jmp	.LBB17_34
.LBB17_17:
	jmp	.LBB17_18
.LBB17_18:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -104(%rbp)
	je	.LBB17_31
# %bb.19:                               #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rdx
	movb	$1, %al
	movl	$3, %ecx
	cmpq	8(%rdx), %rcx
	movb	%al, -117(%rbp)                 # 1-byte Spill
	jne	.LBB17_21
# %bb.20:                               #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-104(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	.L.str.25(%rip), %rdi
	callq	memcmp@PLT
	cmpl	$0, %eax
	setne	%al
	movb	%al, -117(%rbp)                 # 1-byte Spill
.LBB17_21:                              #   in Loop: Header=BB17_18 Depth=1
	movb	-117(%rbp), %al                 # 1-byte Reload
	andb	$1, %al
	movzbl	%al, %eax
	cmpl	$0, %eax
	jne	.LBB17_30
# %bb.22:                               #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rax
	movq	32(%rax), %rax
	cmpq	-72(%rbp), %rax
	jne	.LBB17_25
# %bb.23:                               #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rax
	movq	40(%rax), %rdi
	movq	-56(%rbp), %rsi
	movq	-72(%rbp), %rdx
	callq	x509_memcasecmp
	cmpl	$0, %eax
	jne	.LBB17_25
# %bb.24:
	jmp	.LBB17_31
.LBB17_25:                              #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rax
	cmpq	$2, 32(%rax)
	jbe	.LBB17_29
# %bb.26:                               #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rax
	movq	40(%rax), %rax
	movzwl	(%rax), %eax
	subl	$11818, %eax                    # imm = 0x2E2A
	setne	%al
	movzbl	%al, %eax
	cmpl	$0, %eax
	jne	.LBB17_29
# %bb.27:                               #   in Loop: Header=BB17_18 Depth=1
	movq	-56(%rbp), %rdi
	movq	-104(%rbp), %rsi
	addq	$24, %rsi
	callq	x509_check_wildcard
	cmpl	$0, %eax
	jne	.LBB17_29
# %bb.28:
	jmp	.LBB17_31
.LBB17_29:                              #   in Loop: Header=BB17_18 Depth=1
	jmp	.LBB17_30
.LBB17_30:                              #   in Loop: Header=BB17_18 Depth=1
	movq	-104(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -104(%rbp)
	jmp	.LBB17_18
.LBB17_31:
	cmpq	$0, -104(%rbp)
	jne	.LBB17_33
# %bb.32:
	movq	-64(%rbp), %rax
	movl	(%rax), %ecx
	orl	$4, %ecx
	movl	%ecx, (%rax)
.LBB17_33:
	jmp	.LBB17_34
.LBB17_34:
	jmp	.LBB17_35
.LBB17_35:
	movq	-24(%rbp), %rdi
	addq	$328, %rdi                      # imm = 0x148
	callq	mbedtls_pk_get_type@PLT
	movl	%eax, -116(%rbp)
	movq	-48(%rbp), %rdi
	movl	-116(%rbp), %esi
	callq	x509_profile_check_pk_alg
	cmpl	$0, %eax
	je	.LBB17_37
# %bb.36:
	movq	-64(%rbp), %rax
	movl	(%rax), %ecx
	orl	$32768, %ecx                    # imm = 0x8000
	movl	%ecx, (%rax)
.LBB17_37:
	movq	-48(%rbp), %rdi
	movl	-116(%rbp), %esi
	movq	-24(%rbp), %rdx
	addq	$328, %rdx                      # imm = 0x148
	callq	x509_profile_check_key
	cmpl	$0, %eax
	je	.LBB17_39
# %bb.38:
	movq	-64(%rbp), %rax
	movl	(%rax), %ecx
	orl	$65536, %ecx                    # imm = 0x10000
	movl	%ecx, (%rax)
.LBB17_39:
	movq	-32(%rbp), %rax
	movq	%rax, -96(%rbp)
.LBB17_40:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -96(%rbp)
	je	.LBB17_45
# %bb.41:                               #   in Loop: Header=BB17_40 Depth=1
	movq	-24(%rbp), %rdi
	movq	-96(%rbp), %rsi
	cmpl	$0, -80(%rbp)
	sete	%al
	andb	$1, %al
	movzbl	%al, %ecx
	xorl	%edx, %edx
	callq	x509_crt_check_parent
	cmpl	$0, %eax
	jne	.LBB17_43
# %bb.42:
	jmp	.LBB17_45
.LBB17_43:                              #   in Loop: Header=BB17_40 Depth=1
	jmp	.LBB17_44
.LBB17_44:                              #   in Loop: Header=BB17_40 Depth=1
	movq	-96(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -96(%rbp)
	jmp	.LBB17_40
.LBB17_45:
	cmpq	$0, -96(%rbp)
	je	.LBB17_49
# %bb.46:
	movq	-24(%rbp), %rdi
	movq	-96(%rbp), %rsi
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-80(%rbp), %r8d
	movl	-84(%rbp), %r9d
	movq	-64(%rbp), %r11
	movq	16(%rbp), %r10
	movq	24(%rbp), %rax
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	x509_crt_verify_top
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	je	.LBB17_48
# %bb.47:
	jmp	.LBB17_64
.LBB17_48:
	jmp	.LBB17_63
.LBB17_49:
	movq	-24(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -96(%rbp)
.LBB17_50:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -96(%rbp)
	je	.LBB17_55
# %bb.51:                               #   in Loop: Header=BB17_50 Depth=1
	movq	-24(%rbp), %rdi
	movq	-96(%rbp), %rsi
	cmpl	$0, -80(%rbp)
	sete	%al
	andb	$1, %al
	movzbl	%al, %ecx
	xorl	%edx, %edx
	callq	x509_crt_check_parent
	cmpl	$0, %eax
	jne	.LBB17_53
# %bb.52:
	jmp	.LBB17_55
.LBB17_53:                              #   in Loop: Header=BB17_50 Depth=1
	jmp	.LBB17_54
.LBB17_54:                              #   in Loop: Header=BB17_50 Depth=1
	movq	-96(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -96(%rbp)
	jmp	.LBB17_50
.LBB17_55:
	cmpq	$0, -96(%rbp)
	je	.LBB17_59
# %bb.56:
	movq	-24(%rbp), %rdi
	movq	-96(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %r8
	movl	-80(%rbp), %r9d
	movl	-84(%rbp), %ebx
	movq	-64(%rbp), %r11
	movq	16(%rbp), %r10
	movq	24(%rbp), %rax
	movl	%ebx, (%rsp)
	movq	%r11, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%rax, 24(%rsp)
	callq	x509_crt_verify_child
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	je	.LBB17_58
# %bb.57:
	jmp	.LBB17_64
.LBB17_58:
	jmp	.LBB17_62
.LBB17_59:
	movq	-24(%rbp), %rdi
	movq	-32(%rbp), %rsi
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-80(%rbp), %r8d
	movl	-84(%rbp), %r9d
	movq	-64(%rbp), %r11
	movq	16(%rbp), %r10
	movq	24(%rbp), %rax
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	x509_crt_verify_top
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	je	.LBB17_61
# %bb.60:
	jmp	.LBB17_64
.LBB17_61:
	jmp	.LBB17_62
.LBB17_62:
	jmp	.LBB17_63
.LBB17_63:
	jmp	.LBB17_64
.LBB17_64:
	cmpl	$0, -76(%rbp)
	je	.LBB17_66
# %bb.65:
	movq	-64(%rbp), %rax
	movl	$-1, (%rax)
	movl	-76(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB17_69
.LBB17_66:
	movq	-64(%rbp), %rax
	cmpl	$0, (%rax)
	je	.LBB17_68
# %bb.67:
	movl	$-9984, -12(%rbp)               # imm = 0xD900
	jmp	.LBB17_69
.LBB17_68:
	movl	$0, -12(%rbp)
.LBB17_69:
	movl	-12(%rbp), %eax
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	mbedtls_x509_crt_verify_with_profile, .Lfunc_end17-mbedtls_x509_crt_verify_with_profile
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_memcasecmp
	.type	x509_memcasecmp,@function
x509_memcasecmp:                        # @x509_memcasecmp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	$0, -40(%rbp)
.LBB18_1:                               # =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jae	.LBB18_12
# %bb.2:                                #   in Loop: Header=BB18_1 Depth=1
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movq	-64(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movzbl	(%rcx,%rdx), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -41(%rbp)
	movzbl	-41(%rbp), %eax
	cmpl	$0, %eax
	jne	.LBB18_4
# %bb.3:                                #   in Loop: Header=BB18_1 Depth=1
	jmp	.LBB18_11
.LBB18_4:                               #   in Loop: Header=BB18_1 Depth=1
	movzbl	-41(%rbp), %eax
	cmpl	$32, %eax
	jne	.LBB18_10
# %bb.5:                                #   in Loop: Header=BB18_1 Depth=1
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$97, %eax
	jl	.LBB18_7
# %bb.6:                                #   in Loop: Header=BB18_1 Depth=1
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$122, %eax
	jle	.LBB18_9
.LBB18_7:                               #   in Loop: Header=BB18_1 Depth=1
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$65, %eax
	jl	.LBB18_10
# %bb.8:                                #   in Loop: Header=BB18_1 Depth=1
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$90, %eax
	jg	.LBB18_10
.LBB18_9:                               #   in Loop: Header=BB18_1 Depth=1
	jmp	.LBB18_11
.LBB18_10:
	movl	$-1, -4(%rbp)
	jmp	.LBB18_13
.LBB18_11:                              #   in Loop: Header=BB18_1 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB18_1
.LBB18_12:
	movl	$0, -4(%rbp)
.LBB18_13:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end18:
	.size	x509_memcasecmp, .Lfunc_end18-x509_memcasecmp
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_check_wildcard
	.type	x509_check_wildcard,@function
x509_check_wildcard:                    # @x509_check_wildcard
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	$0, -40(%rbp)
	movq	-16(%rbp), %rdi
	callq	strlen@PLT
	movq	%rax, -48(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$3, 8(%rax)
	jb	.LBB19_3
# %bb.1:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzbl	(%rax), %eax
	cmpl	$42, %eax
	jne	.LBB19_3
# %bb.2:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzbl	1(%rax), %eax
	cmpl	$46, %eax
	je	.LBB19_4
.LBB19_3:
	movl	$0, -4(%rbp)
	jmp	.LBB19_16
.LBB19_4:
	movq	$0, -32(%rbp)
.LBB19_5:                               # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jae	.LBB19_10
# %bb.6:                                #   in Loop: Header=BB19_5 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movsbl	(%rax,%rcx), %eax
	cmpl	$46, %eax
	jne	.LBB19_8
# %bb.7:
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB19_10
.LBB19_8:                               #   in Loop: Header=BB19_5 Depth=1
	jmp	.LBB19_9
.LBB19_9:                               #   in Loop: Header=BB19_5 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB19_5
.LBB19_10:
	cmpq	$0, -40(%rbp)
	jne	.LBB19_12
# %bb.11:
	movl	$-1, -4(%rbp)
	jmp	.LBB19_16
.LBB19_12:
	movq	-48(%rbp), %rax
	subq	-40(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	subq	$1, %rcx
	cmpq	%rcx, %rax
	jne	.LBB19_15
# %bb.13:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rdi
	addq	$1, %rdi
	movq	-16(%rbp), %rsi
	addq	-40(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	subq	$1, %rdx
	callq	x509_memcasecmp
	cmpl	$0, %eax
	jne	.LBB19_15
# %bb.14:
	movl	$0, -4(%rbp)
	jmp	.LBB19_16
.LBB19_15:
	movl	$-1, -4(%rbp)
.LBB19_16:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	x509_check_wildcard, .Lfunc_end19-x509_check_wildcard
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_profile_check_pk_alg
	.type	x509_profile_check_pk_alg,@function
x509_profile_check_pk_alg:              # @x509_profile_check_pk_alg
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	-20(%rbp), %ecx
	subl	$1, %ecx
	movl	$1, %edx
                                        # kill: def $cl killed $ecx
	shll	%cl, %edx
	movl	%edx, %ecx
	andl	%ecx, %eax
	cmpl	$0, %eax
	je	.LBB20_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB20_3
.LBB20_2:
	movl	$-1, -4(%rbp)
.LBB20_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end20:
	.size	x509_profile_check_pk_alg, .Lfunc_end20-x509_profile_check_pk_alg
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_profile_check_key
	.type	x509_profile_check_key,@function
x509_profile_check_key:                 # @x509_profile_check_key
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	%rdx, -32(%rbp)
	cmpl	$1, -20(%rbp)
	je	.LBB21_2
# %bb.1:
	cmpl	$6, -20(%rbp)
	jne	.LBB21_5
.LBB21_2:
	movq	-32(%rbp), %rdi
	callq	mbedtls_pk_get_bitlen@PLT
	movq	-16(%rbp), %rcx
	movl	12(%rcx), %ecx
                                        # kill: def $rcx killed $ecx
	cmpq	%rcx, %rax
	jb	.LBB21_4
# %bb.3:
	movl	$0, -4(%rbp)
	jmp	.LBB21_12
.LBB21_4:
	movl	$-1, -4(%rbp)
	jmp	.LBB21_12
.LBB21_5:
	cmpl	$4, -20(%rbp)
	je	.LBB21_8
# %bb.6:
	cmpl	$2, -20(%rbp)
	je	.LBB21_8
# %bb.7:
	cmpl	$3, -20(%rbp)
	jne	.LBB21_11
.LBB21_8:
	movq	-32(%rbp), %rax
	movq	(%rax), %rdi
	movq	8(%rax), %rsi
	callq	mbedtls_pk_ec
	movl	(%rax), %eax
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	movl	-36(%rbp), %ecx
	subl	$1, %ecx
	movl	$1, %edx
                                        # kill: def $cl killed $ecx
	shll	%cl, %edx
	movl	%edx, %ecx
	andl	%ecx, %eax
	cmpl	$0, %eax
	je	.LBB21_10
# %bb.9:
	movl	$0, -4(%rbp)
	jmp	.LBB21_12
.LBB21_10:
	movl	$-1, -4(%rbp)
	jmp	.LBB21_12
.LBB21_11:
	movl	$-1, -4(%rbp)
.LBB21_12:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end21:
	.size	x509_profile_check_key, .Lfunc_end21-x509_profile_check_key
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_crt_check_parent
	.type	x509_crt_check_parent,@function
x509_crt_check_parent:                  # @x509_crt_check_parent
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	%ecx, -32(%rbp)
	movq	-16(%rbp), %rdi
	addq	$152, %rdi
	movq	-24(%rbp), %rsi
	addq	$216, %rsi
	callq	x509_name_cmp
	cmpl	$0, %eax
	je	.LBB22_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB22_17
.LBB22_2:
	movl	$1, -36(%rbp)
	cmpl	$0, -28(%rbp)
	je	.LBB22_5
# %bb.3:
	movq	-24(%rbp), %rax
	cmpl	$3, 48(%rax)
	jge	.LBB22_5
# %bb.4:
	movl	$0, -36(%rbp)
.LBB22_5:
	cmpl	$0, -28(%rbp)
	je	.LBB22_10
# %bb.6:
	cmpl	$0, -32(%rbp)
	je	.LBB22_10
# %bb.7:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jne	.LBB22_10
# %bb.8:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	jne	.LBB22_10
# %bb.9:
	movl	$0, -36(%rbp)
.LBB22_10:
	cmpl	$0, -36(%rbp)
	je	.LBB22_13
# %bb.11:
	movq	-24(%rbp), %rax
	cmpl	$0, 452(%rax)
	jne	.LBB22_13
# %bb.12:
	movl	$-1, -4(%rbp)
	jmp	.LBB22_17
.LBB22_13:
	cmpl	$0, -36(%rbp)
	je	.LBB22_16
# %bb.14:
	movq	-24(%rbp), %rdi
	movl	$4, %esi
	callq	mbedtls_x509_crt_check_key_usage
	cmpl	$0, %eax
	je	.LBB22_16
# %bb.15:
	movl	$-1, -4(%rbp)
	jmp	.LBB22_17
.LBB22_16:
	movl	$0, -4(%rbp)
.LBB22_17:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end22:
	.size	x509_crt_check_parent, .Lfunc_end22-x509_crt_check_parent
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_crt_verify_top
	.type	x509_crt_verify_top,@function
x509_crt_verify_top:                    # @x509_crt_verify_top
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movq	32(%rbp), %rax
	movq	24(%rbp), %rax
	movq	16(%rbp), %rax
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movl	%r9d, -48(%rbp)
	movl	$0, -56(%rbp)
	movq	$0, -144(%rbp)
	movq	-16(%rbp), %rdi
	addq	$304, %rdi                      # imm = 0x130
	callq	mbedtls_x509_time_is_past@PLT
	cmpl	$0, %eax
	je	.LBB23_2
# %bb.1:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	orl	$1, %ecx
	movl	%ecx, (%rax)
.LBB23_2:
	movq	-16(%rbp), %rdi
	addq	$280, %rdi                      # imm = 0x118
	callq	mbedtls_x509_time_is_future@PLT
	cmpl	$0, %eax
	je	.LBB23_4
# %bb.3:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	orl	$512, %ecx                      # imm = 0x200
	movl	%ecx, (%rax)
.LBB23_4:
	movq	-40(%rbp), %rdi
	movq	-16(%rbp), %rax
	movl	528(%rax), %esi
	callq	x509_profile_check_md_alg
	cmpl	$0, %eax
	je	.LBB23_6
# %bb.5:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	orl	$16384, %ecx                    # imm = 0x4000
	movl	%ecx, (%rax)
.LBB23_6:
	movq	-40(%rbp), %rdi
	movq	-16(%rbp), %rax
	movl	532(%rax), %esi
	callq	x509_profile_check_pk_alg
	cmpl	$0, %eax
	je	.LBB23_8
# %bb.7:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	orl	$32768, %ecx                    # imm = 0x8000
	movl	%ecx, (%rax)
.LBB23_8:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	orl	$8, %ecx
	movl	%ecx, (%rax)
	movq	-16(%rbp), %rax
	movl	528(%rax), %edi
	callq	mbedtls_md_info_from_type@PLT
	movq	%rax, -136(%rbp)
	cmpq	$0, -136(%rbp)
	jne	.LBB23_10
# %bb.9:
	movq	$0, -24(%rbp)
	jmp	.LBB23_11
.LBB23_10:
	movq	-136(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	40(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	32(%rax), %rdx
	leaq	-128(%rbp), %rcx
	callq	mbedtls_md@PLT
.LBB23_11:
	jmp	.LBB23_12
.LBB23_12:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -24(%rbp)
	je	.LBB23_30
# %bb.13:                               #   in Loop: Header=BB23_12 Depth=1
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	cmpl	$0, -44(%rbp)
	sete	%al
	andb	$1, %al
	movzbl	%al, %ecx
	movl	$1, %edx
	callq	x509_crt_check_parent
	cmpl	$0, %eax
	je	.LBB23_15
# %bb.14:                               #   in Loop: Header=BB23_12 Depth=1
	jmp	.LBB23_29
.LBB23_15:                              #   in Loop: Header=BB23_12 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	movq	136(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	136(%rcx), %rax
	jne	.LBB23_18
# %bb.16:                               #   in Loop: Header=BB23_12 Depth=1
	movq	-16(%rbp), %rax
	movq	144(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	144(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	112(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	jne	.LBB23_18
# %bb.17:                               #   in Loop: Header=BB23_12 Depth=1
	movl	-60(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -60(%rbp)
.LBB23_18:                              #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rax
	cmpl	$0, 456(%rax)
	jle	.LBB23_21
# %bb.19:                               #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rax
	movl	456(%rax), %eax
	movl	-60(%rbp), %ecx
	subl	-48(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB23_21
# %bb.20:                               #   in Loop: Header=BB23_12 Depth=1
	jmp	.LBB23_29
.LBB23_21:                              #   in Loop: Header=BB23_12 Depth=1
	movq	-16(%rbp), %rax
	movl	532(%rax), %eax
	movl	%eax, -180(%rbp)                # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	536(%rax), %rax
	movq	%rax, -176(%rbp)                # 8-byte Spill
	movq	-24(%rbp), %rax
	addq	$328, %rax                      # imm = 0x148
	movq	%rax, -168(%rbp)                # 8-byte Spill
	movq	-16(%rbp), %rax
	movl	528(%rax), %eax
	movl	%eax, -156(%rbp)                # 4-byte Spill
	leaq	-128(%rbp), %rax
	movq	%rax, -152(%rbp)                # 8-byte Spill
	movq	-136(%rbp), %rdi
	callq	mbedtls_md_get_size@PLT
	movl	-180(%rbp), %edi                # 4-byte Reload
	movq	-176(%rbp), %rsi                # 8-byte Reload
	movq	-168(%rbp), %rdx                # 8-byte Reload
	movl	-156(%rbp), %ecx                # 4-byte Reload
	movq	-152(%rbp), %r8                 # 8-byte Reload
	movzbl	%al, %eax
	movl	%eax, %r9d
	movq	-16(%rbp), %rax
	movq	520(%rax), %r10
	movq	-16(%rbp), %rax
	movq	512(%rax), %rax
	movq	%r10, (%rsp)
	movq	%rax, 8(%rsp)
	callq	mbedtls_pk_verify_ext@PLT
	cmpl	$0, %eax
	je	.LBB23_23
# %bb.22:                               #   in Loop: Header=BB23_12 Depth=1
	jmp	.LBB23_29
.LBB23_23:                              #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rdi
	addq	$304, %rdi                      # imm = 0x130
	callq	mbedtls_x509_time_is_past@PLT
	cmpl	$0, %eax
	jne	.LBB23_25
# %bb.24:                               #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rdi
	addq	$280, %rdi                      # imm = 0x118
	callq	mbedtls_x509_time_is_future@PLT
	cmpl	$0, %eax
	je	.LBB23_28
.LBB23_25:                              #   in Loop: Header=BB23_12 Depth=1
	cmpq	$0, -144(%rbp)
	jne	.LBB23_27
# %bb.26:                               #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rax
	movq	%rax, -144(%rbp)
.LBB23_27:                              #   in Loop: Header=BB23_12 Depth=1
	jmp	.LBB23_29
.LBB23_28:
	jmp	.LBB23_30
.LBB23_29:                              #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB23_12
.LBB23_30:
	cmpq	$0, -24(%rbp)
	jne	.LBB23_32
# %bb.31:
	movq	-144(%rbp), %rax
	movq	%rax, -24(%rbp)
	cmpq	$0, %rax
	je	.LBB23_35
.LBB23_32:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	andl	$-9, %ecx
	movl	%ecx, (%rax)
	movq	-40(%rbp), %rdi
	movq	-16(%rbp), %rax
	movl	532(%rax), %esi
	movq	-24(%rbp), %rdx
	addq	$328, %rdx                      # imm = 0x148
	callq	x509_profile_check_key
	cmpl	$0, %eax
	je	.LBB23_34
# %bb.33:
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	orl	$65536, %ecx                    # imm = 0x10000
	movl	%ecx, (%rax)
.LBB23_34:
	jmp	.LBB23_35
.LBB23_35:
	cmpq	$0, -24(%rbp)
	je	.LBB23_47
# %bb.36:
	movq	-16(%rbp), %rax
	movq	136(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	136(%rcx), %rax
	jne	.LBB23_38
# %bb.37:
	movq	-16(%rbp), %rax
	movq	144(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	144(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	112(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	je	.LBB23_47
.LBB23_38:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rcx
	callq	x509_crt_verifycrl
	movl	%eax, %ecx
	movq	16(%rbp), %rax
	orl	(%rax), %ecx
	movl	%ecx, (%rax)
	movq	-24(%rbp), %rdi
	addq	$304, %rdi                      # imm = 0x130
	callq	mbedtls_x509_time_is_past@PLT
	cmpl	$0, %eax
	je	.LBB23_40
# %bb.39:
	movl	-56(%rbp), %eax
	orl	$1, %eax
	movl	%eax, -56(%rbp)
.LBB23_40:
	movq	-24(%rbp), %rdi
	addq	$280, %rdi                      # imm = 0x118
	callq	mbedtls_x509_time_is_future@PLT
	cmpl	$0, %eax
	je	.LBB23_42
# %bb.41:
	movl	-56(%rbp), %eax
	orl	$512, %eax                      # imm = 0x200
	movl	%eax, -56(%rbp)
.LBB23_42:
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	cmpq	24(%rbp), %rax
	je	.LBB23_46
# %bb.43:
	movq	24(%rbp), %rax
	movq	32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movl	-44(%rbp), %edx
	addl	$1, %edx
	leaq	-56(%rbp), %rcx
	callq	*%rax
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB23_45
# %bb.44:
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB23_52
.LBB23_45:
	jmp	.LBB23_46
.LBB23_46:
	jmp	.LBB23_47
.LBB23_47:
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	cmpq	24(%rbp), %rax
	je	.LBB23_51
# %bb.48:
	movq	24(%rbp), %rax
	movq	32(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-44(%rbp), %edx
	movq	16(%rbp), %rcx
	callq	*%rax
	movl	%eax, -52(%rbp)
	cmpl	$0, %eax
	je	.LBB23_50
# %bb.49:
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB23_52
.LBB23_50:
	jmp	.LBB23_51
.LBB23_51:
	movl	-56(%rbp), %ecx
	movq	16(%rbp), %rax
	orl	(%rax), %ecx
	movl	%ecx, (%rax)
	movl	$0, -4(%rbp)
.LBB23_52:
	movl	-4(%rbp), %eax
	addq	$208, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end23:
	.size	x509_crt_verify_top, .Lfunc_end23-x509_crt_verify_top
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_crt_verify_child
	.type	x509_crt_verify_child,@function
x509_crt_verify_child:                  # @x509_crt_verify_child
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$232, %rsp
	.cfi_offset %rbx, -24
	movq	40(%rbp), %rax
	movq	32(%rbp), %rax
	movq	24(%rbp), %rax
	movl	16(%rbp), %eax
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movl	%r9d, -60(%rbp)
	movl	$0, -68(%rbp)
	cmpl	$0, -60(%rbp)
	je	.LBB24_3
# %bb.1:
	movq	-24(%rbp), %rdi
	addq	$152, %rdi
	movq	-24(%rbp), %rsi
	addq	$216, %rsi
	callq	x509_name_cmp
	cmpl	$0, %eax
	jne	.LBB24_3
# %bb.2:
	movl	16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, 16(%rbp)
.LBB24_3:
	movl	-60(%rbp), %eax
	addl	$1, %eax
	cmpl	$8, %eax
	jle	.LBB24_5
# %bb.4:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$8, %ecx
	movl	%ecx, (%rax)
	movl	$-9984, -12(%rbp)               # imm = 0xD900
	jmp	.LBB24_52
.LBB24_5:
	movq	-24(%rbp), %rdi
	addq	$304, %rdi                      # imm = 0x130
	callq	mbedtls_x509_time_is_past@PLT
	cmpl	$0, %eax
	je	.LBB24_7
# %bb.6:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$1, %ecx
	movl	%ecx, (%rax)
.LBB24_7:
	movq	-24(%rbp), %rdi
	addq	$280, %rdi                      # imm = 0x118
	callq	mbedtls_x509_time_is_future@PLT
	cmpl	$0, %eax
	je	.LBB24_9
# %bb.8:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$512, %ecx                      # imm = 0x200
	movl	%ecx, (%rax)
.LBB24_9:
	movq	-56(%rbp), %rdi
	movq	-24(%rbp), %rax
	movl	528(%rax), %esi
	callq	x509_profile_check_md_alg
	cmpl	$0, %eax
	je	.LBB24_11
# %bb.10:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$16384, %ecx                    # imm = 0x4000
	movl	%ecx, (%rax)
.LBB24_11:
	movq	-56(%rbp), %rdi
	movq	-24(%rbp), %rax
	movl	532(%rax), %esi
	callq	x509_profile_check_pk_alg
	cmpl	$0, %eax
	je	.LBB24_13
# %bb.12:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$32768, %ecx                    # imm = 0x8000
	movl	%ecx, (%rax)
.LBB24_13:
	movq	-24(%rbp), %rax
	movl	528(%rax), %edi
	callq	mbedtls_md_info_from_type@PLT
	movq	%rax, -160(%rbp)
	cmpq	$0, -160(%rbp)
	jne	.LBB24_15
# %bb.14:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$8, %ecx
	movl	%ecx, (%rax)
	jmp	.LBB24_20
.LBB24_15:
	movq	-160(%rbp), %rdi
	movq	-24(%rbp), %rax
	movq	40(%rax), %rsi
	movq	-24(%rbp), %rax
	movq	32(%rax), %rdx
	leaq	-144(%rbp), %rcx
	callq	mbedtls_md@PLT
	movq	-56(%rbp), %rdi
	movq	-24(%rbp), %rax
	movl	532(%rax), %esi
	movq	-32(%rbp), %rdx
	addq	$328, %rdx                      # imm = 0x148
	callq	x509_profile_check_key
	cmpl	$0, %eax
	je	.LBB24_17
# %bb.16:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$65536, %ecx                    # imm = 0x10000
	movl	%ecx, (%rax)
.LBB24_17:
	movq	-24(%rbp), %rax
	movl	532(%rax), %eax
	movl	%eax, -196(%rbp)                # 4-byte Spill
	movq	-24(%rbp), %rax
	movq	536(%rax), %rax
	movq	%rax, -192(%rbp)                # 8-byte Spill
	movq	-32(%rbp), %rax
	addq	$328, %rax                      # imm = 0x148
	movq	%rax, -184(%rbp)                # 8-byte Spill
	movq	-24(%rbp), %rax
	movl	528(%rax), %eax
	movl	%eax, -172(%rbp)                # 4-byte Spill
	leaq	-144(%rbp), %rax
	movq	%rax, -168(%rbp)                # 8-byte Spill
	movq	-160(%rbp), %rdi
	callq	mbedtls_md_get_size@PLT
	movl	-196(%rbp), %edi                # 4-byte Reload
	movq	-192(%rbp), %rsi                # 8-byte Reload
	movq	-184(%rbp), %rdx                # 8-byte Reload
	movl	-172(%rbp), %ecx                # 4-byte Reload
	movq	-168(%rbp), %r8                 # 8-byte Reload
	movzbl	%al, %eax
	movl	%eax, %r9d
	movq	-24(%rbp), %rax
	movq	520(%rax), %r10
	movq	-24(%rbp), %rax
	movq	512(%rax), %rax
	movq	%r10, (%rsp)
	movq	%rax, 8(%rsp)
	callq	mbedtls_pk_verify_ext@PLT
	cmpl	$0, %eax
	je	.LBB24_19
# %bb.18:
	movq	24(%rbp), %rax
	movl	(%rax), %ecx
	orl	$8, %ecx
	movl	%ecx, (%rax)
.LBB24_19:
	jmp	.LBB24_20
.LBB24_20:
	movq	-24(%rbp), %rdi
	movq	-32(%rbp), %rsi
	movq	-48(%rbp), %rdx
	movq	-56(%rbp), %rcx
	callq	x509_crt_verifycrl
	movl	%eax, %ecx
	movq	24(%rbp), %rax
	orl	(%rax), %ecx
	movl	%ecx, (%rax)
	movq	-40(%rbp), %rax
	movq	%rax, -152(%rbp)
.LBB24_21:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -152(%rbp)
	je	.LBB24_26
# %bb.22:                               #   in Loop: Header=BB24_21 Depth=1
	movq	-32(%rbp), %rdi
	movq	-152(%rbp), %rsi
	cmpl	$0, -60(%rbp)
	sete	%al
	andb	$1, %al
	movzbl	%al, %ecx
	xorl	%edx, %edx
	callq	x509_crt_check_parent
	cmpl	$0, %eax
	jne	.LBB24_24
# %bb.23:
	jmp	.LBB24_26
.LBB24_24:                              #   in Loop: Header=BB24_21 Depth=1
	jmp	.LBB24_25
.LBB24_25:                              #   in Loop: Header=BB24_21 Depth=1
	movq	-152(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -152(%rbp)
	jmp	.LBB24_21
.LBB24_26:
	cmpq	$0, -152(%rbp)
	je	.LBB24_30
# %bb.27:
	movq	-32(%rbp), %rdi
	movq	-152(%rbp), %rsi
	movq	-48(%rbp), %rdx
	movq	-56(%rbp), %rcx
	movl	-60(%rbp), %r8d
	addl	$1, %r8d
	movl	16(%rbp), %r9d
	movq	32(%rbp), %r10
	movq	40(%rbp), %rax
	leaq	-68(%rbp), %r11
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	x509_crt_verify_top
	movl	%eax, -64(%rbp)
	cmpl	$0, -64(%rbp)
	je	.LBB24_29
# %bb.28:
	movl	-64(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB24_52
.LBB24_29:
	jmp	.LBB24_47
.LBB24_30:
	movq	-32(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -152(%rbp)
.LBB24_31:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -152(%rbp)
	je	.LBB24_39
# %bb.32:                               #   in Loop: Header=BB24_31 Depth=1
	movq	-152(%rbp), %rax
	cmpl	$0, 456(%rax)
	jle	.LBB24_35
# %bb.33:                               #   in Loop: Header=BB24_31 Depth=1
	movq	-152(%rbp), %rax
	movl	456(%rax), %eax
	movl	-60(%rbp), %ecx
	addl	$2, %ecx
	subl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB24_35
# %bb.34:                               #   in Loop: Header=BB24_31 Depth=1
	jmp	.LBB24_38
.LBB24_35:                              #   in Loop: Header=BB24_31 Depth=1
	movq	-32(%rbp), %rdi
	movq	-152(%rbp), %rsi
	cmpl	$0, -60(%rbp)
	sete	%al
	andb	$1, %al
	movzbl	%al, %ecx
	xorl	%edx, %edx
	callq	x509_crt_check_parent
	cmpl	$0, %eax
	jne	.LBB24_37
# %bb.36:
	jmp	.LBB24_39
.LBB24_37:                              #   in Loop: Header=BB24_31 Depth=1
	jmp	.LBB24_38
.LBB24_38:                              #   in Loop: Header=BB24_31 Depth=1
	movq	-152(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -152(%rbp)
	jmp	.LBB24_31
.LBB24_39:
	cmpq	$0, -152(%rbp)
	je	.LBB24_43
# %bb.40:
	movq	-32(%rbp), %rdi
	movq	-152(%rbp), %rsi
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-56(%rbp), %r8
	movl	-60(%rbp), %r9d
	addl	$1, %r9d
	movl	16(%rbp), %ebx
	movq	32(%rbp), %r10
	movq	40(%rbp), %rax
	leaq	-68(%rbp), %r11
	movl	%ebx, (%rsp)
	movq	%r11, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%rax, 24(%rsp)
	callq	x509_crt_verify_child
	movl	%eax, -64(%rbp)
	cmpl	$0, -64(%rbp)
	je	.LBB24_42
# %bb.41:
	movl	-64(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB24_52
.LBB24_42:
	jmp	.LBB24_46
.LBB24_43:
	movq	-32(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-48(%rbp), %rdx
	movq	-56(%rbp), %rcx
	movl	-60(%rbp), %r8d
	addl	$1, %r8d
	movl	16(%rbp), %r9d
	movq	32(%rbp), %r10
	movq	40(%rbp), %rax
	leaq	-68(%rbp), %r11
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	x509_crt_verify_top
	movl	%eax, -64(%rbp)
	cmpl	$0, -64(%rbp)
	je	.LBB24_45
# %bb.44:
	movl	-64(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB24_52
.LBB24_45:
	jmp	.LBB24_46
.LBB24_46:
	jmp	.LBB24_47
.LBB24_47:
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	cmpq	32(%rbp), %rax
	je	.LBB24_51
# %bb.48:
	movq	32(%rbp), %rax
	movq	40(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movl	-60(%rbp), %edx
	movq	24(%rbp), %rcx
	callq	*%rax
	movl	%eax, -64(%rbp)
	cmpl	$0, %eax
	je	.LBB24_50
# %bb.49:
	movl	-64(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB24_52
.LBB24_50:
	jmp	.LBB24_51
.LBB24_51:
	movl	-68(%rbp), %ecx
	movq	24(%rbp), %rax
	orl	(%rax), %ecx
	movl	%ecx, (%rax)
	movl	$0, -12(%rbp)
.LBB24_52:
	movl	-12(%rbp), %eax
	addq	$232, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end24:
	.size	x509_crt_verify_child, .Lfunc_end24-x509_crt_verify_child
	.cfi_endproc
                                        # -- End function
	.globl	mbedtls_x509_crt_free           # -- Begin function mbedtls_x509_crt_free
	.p2align	4, 0x90
	.type	mbedtls_x509_crt_free,@function
mbedtls_x509_crt_free:                  # @mbedtls_x509_crt_free
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.LBB25_2
# %bb.1:
	jmp	.LBB25_24
.LBB25_2:
	jmp	.LBB25_3
.LBB25_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB25_4 Depth 2
                                        #     Child Loop BB25_7 Depth 2
                                        #     Child Loop BB25_10 Depth 2
                                        #     Child Loop BB25_13 Depth 2
	movq	-16(%rbp), %rdi
	addq	$328, %rdi                      # imm = 0x148
	callq	mbedtls_pk_free@PLT
	movq	-16(%rbp), %rax
	movq	536(%rax), %rdi
	callq	free@PLT
	movq	-16(%rbp), %rax
	movq	200(%rax), %rax
	movq	%rax, -32(%rbp)
.LBB25_4:                               #   Parent Loop BB25_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$0, -32(%rbp)
	je	.LBB25_6
# %bb.5:                                #   in Loop: Header=BB25_4 Depth=2
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rdi
	movl	$64, %esi
	callq	mbedtls_zeroize
	movq	-40(%rbp), %rdi
	callq	free@PLT
	jmp	.LBB25_4
.LBB25_6:                               #   in Loop: Header=BB25_3 Depth=1
	movq	-16(%rbp), %rax
	movq	264(%rax), %rax
	movq	%rax, -32(%rbp)
.LBB25_7:                               #   Parent Loop BB25_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$0, -32(%rbp)
	je	.LBB25_9
# %bb.8:                                #   in Loop: Header=BB25_7 Depth=2
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rdi
	movl	$64, %esi
	callq	mbedtls_zeroize
	movq	-40(%rbp), %rdi
	callq	free@PLT
	jmp	.LBB25_7
.LBB25_9:                               #   in Loop: Header=BB25_3 Depth=1
	movq	-16(%rbp), %rax
	movq	488(%rax), %rax
	movq	%rax, -48(%rbp)
.LBB25_10:                              #   Parent Loop BB25_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$0, -48(%rbp)
	je	.LBB25_12
# %bb.11:                               #   in Loop: Header=BB25_10 Depth=2
	movq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-56(%rbp), %rdi
	movl	$32, %esi
	callq	mbedtls_zeroize
	movq	-56(%rbp), %rdi
	callq	free@PLT
	jmp	.LBB25_10
.LBB25_12:                              #   in Loop: Header=BB25_3 Depth=1
	movq	-16(%rbp), %rax
	movq	440(%rax), %rax
	movq	%rax, -48(%rbp)
.LBB25_13:                              #   Parent Loop BB25_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$0, -48(%rbp)
	je	.LBB25_15
# %bb.14:                               #   in Loop: Header=BB25_13 Depth=2
	movq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-56(%rbp), %rdi
	movl	$32, %esi
	callq	mbedtls_zeroize
	movq	-56(%rbp), %rdi
	callq	free@PLT
	jmp	.LBB25_13
.LBB25_15:                              #   in Loop: Header=BB25_3 Depth=1
	movq	-16(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB25_17
# %bb.16:                               #   in Loop: Header=BB25_3 Depth=1
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	movq	-16(%rbp), %rax
	movq	8(%rax), %rsi
	callq	mbedtls_zeroize
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	callq	free@PLT
.LBB25_17:                              #   in Loop: Header=BB25_3 Depth=1
	movq	-16(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -16(%rbp)
# %bb.18:                               #   in Loop: Header=BB25_3 Depth=1
	cmpq	$0, -16(%rbp)
	jne	.LBB25_3
# %bb.19:
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
.LBB25_20:                              # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	544(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rdi
	movl	$552, %esi                      # imm = 0x228
	callq	mbedtls_zeroize
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	je	.LBB25_22
# %bb.21:                               #   in Loop: Header=BB25_20 Depth=1
	movq	-24(%rbp), %rdi
	callq	free@PLT
.LBB25_22:                              #   in Loop: Header=BB25_20 Depth=1
	jmp	.LBB25_23
.LBB25_23:                              #   in Loop: Header=BB25_20 Depth=1
	cmpq	$0, -16(%rbp)
	jne	.LBB25_20
.LBB25_24:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end25:
	.size	mbedtls_x509_crt_free, .Lfunc_end25-mbedtls_x509_crt_free
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_version
	.type	x509_get_version,@function
x509_get_version:                       # @x509_get_version
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	movl	$160, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB26_4
# %bb.1:
	cmpl	$-98, -36(%rbp)
	jne	.LBB26_3
# %bb.2:
	movq	-32(%rbp), %rax
	movl	$0, (%rax)
	movl	$0, -4(%rbp)
	jmp	.LBB26_9
.LBB26_3:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB26_9
.LBB26_4:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	mbedtls_asn1_get_int@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB26_6
# %bb.5:
	movl	-36(%rbp), %eax
	addl	$4294958592, %eax               # imm = 0xFFFFDE00
	movl	%eax, -4(%rbp)
	jmp	.LBB26_9
.LBB26_6:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB26_8
# %bb.7:
	movl	$-8806, -4(%rbp)                # imm = 0xDD9A
	jmp	.LBB26_9
.LBB26_8:
	movl	$0, -4(%rbp)
.LBB26_9:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end26:
	.size	x509_get_version, .Lfunc_end26-x509_get_version
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_dates
	.type	x509_get_dates,@function
x509_get_dates:                         # @x509_get_dates
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-56(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, %eax
	je	.LBB27_2
# %bb.1:
	movl	-44(%rbp), %eax
	addl	$4294958080, %eax               # imm = 0xFFFFDC00
	movl	%eax, -4(%rbp)
	jmp	.LBB27_9
.LBB27_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	-56(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	mbedtls_x509_get_time@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, %eax
	je	.LBB27_4
# %bb.3:
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB27_9
.LBB27_4:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdx
	callq	mbedtls_x509_get_time@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, %eax
	je	.LBB27_6
# %bb.5:
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB27_9
.LBB27_6:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB27_8
# %bb.7:
	movl	$-9318, -4(%rbp)                # imm = 0xDB9A
	jmp	.LBB27_9
.LBB27_8:
	movl	$0, -4(%rbp)
.LBB27_9:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end27:
	.size	x509_get_dates, .Lfunc_end27-x509_get_dates
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_uid
	.type	x509_get_uid,@function
x509_get_uid:                           # @x509_get_uid
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB28_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB28_7
.LBB28_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$8, %rdx
	movl	-36(%rbp), %ecx
	orl	$160, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -40(%rbp)
	cmpl	$0, %eax
	je	.LBB28_6
# %bb.3:
	cmpl	$-98, -40(%rbp)
	jne	.LBB28_5
# %bb.4:
	movl	$0, -4(%rbp)
	jmp	.LBB28_7
.LBB28_5:
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB28_7
.LBB28_6:
	movq	-16(%rbp), %rax
	movq	(%rax), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 16(%rax)
	movq	-32(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-16(%rbp), %rax
	addq	(%rax), %rcx
	movq	%rcx, (%rax)
	movl	$0, -4(%rbp)
.LBB28_7:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end28:
	.size	x509_get_uid, .Lfunc_end28-x509_get_uid
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_crt_ext
	.type	x509_get_crt_ext,@function
x509_get_crt_ext:                       # @x509_get_crt_ext
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$392, %rdx                      # imm = 0x188
	movl	$3, %ecx
	callq	mbedtls_x509_get_ext@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_4
# %bb.1:
	cmpl	$-98, -36(%rbp)
	jne	.LBB29_3
# %bb.2:
	movl	$0, -4(%rbp)
	jmp	.LBB29_46
.LBB29_3:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_4:
	jmp	.LBB29_5
.LBB29_5:                               # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	jae	.LBB29_43
# %bb.6:                                #   in Loop: Header=BB29_5 Depth=1
	leaq	-88(%rbp), %rdi
	xorl	%esi, %esi
	movl	$24, %edx
	callq	memset@PLT
	movl	$0, -92(%rbp)
	movl	$0, -96(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_8
# %bb.7:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_8:                               #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	movl	%eax, -88(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-88(%rbp), %rdx
	addq	$8, %rdx
	movl	$6, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_10
# %bb.9:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_10:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-80(%rbp), %rcx
	movq	-16(%rbp), %rax
	addq	(%rax), %rcx
	movq	%rcx, (%rax)
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	subq	%rcx, %rax
	cmpq	$1, %rax
	jge	.LBB29_12
# %bb.11:
	movl	$-9568, -4(%rbp)                # imm = 0xDAA0
	jmp	.LBB29_46
.LBB29_12:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-56(%rbp), %rsi
	leaq	-92(%rbp), %rdx
	callq	mbedtls_asn1_get_bool@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_15
# %bb.13:                               #   in Loop: Header=BB29_5 Depth=1
	cmpl	$-98, -36(%rbp)
	je	.LBB29_15
# %bb.14:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_15:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-56(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	movl	$4, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_17
# %bb.16:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_17:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	-48(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	-56(%rbp), %rax
	je	.LBB29_19
# %bb.18:
	movl	$-9574, -4(%rbp)                # imm = 0xDA9A
	jmp	.LBB29_46
.LBB29_19:                              #   in Loop: Header=BB29_5 Depth=1
	leaq	-88(%rbp), %rdi
	leaq	-96(%rbp), %rsi
	callq	mbedtls_oid_get_x509_ext_type@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	je	.LBB29_23
# %bb.20:                               #   in Loop: Header=BB29_5 Depth=1
	movq	-64(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	cmpl	$0, -92(%rbp)
	je	.LBB29_22
# %bb.21:
	movl	$-9570, -4(%rbp)                # imm = 0xDA9E
	jmp	.LBB29_46
.LBB29_22:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_5
.LBB29_23:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-32(%rbp), %rax
	movl	448(%rax), %eax
	andl	-96(%rbp), %eax
	cmpl	$0, %eax
	je	.LBB29_25
# %bb.24:
	movl	$-9472, -4(%rbp)                # imm = 0xDB00
	jmp	.LBB29_46
.LBB29_25:                              #   in Loop: Header=BB29_5 Depth=1
	movl	-96(%rbp), %edx
	movq	-32(%rbp), %rax
	movl	448(%rax), %ecx
	orl	%edx, %ecx
	movl	%ecx, 448(%rax)
	movl	-96(%rbp), %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	subl	$4, %eax
	je	.LBB29_29
	jmp	.LBB29_47
.LBB29_47:                              #   in Loop: Header=BB29_5 Depth=1
	movl	-100(%rbp), %eax                # 4-byte Reload
	subl	$32, %eax
	je	.LBB29_35
	jmp	.LBB29_48
.LBB29_48:                              #   in Loop: Header=BB29_5 Depth=1
	movl	-100(%rbp), %eax                # 4-byte Reload
	subl	$256, %eax                      # imm = 0x100
	je	.LBB29_26
	jmp	.LBB29_49
.LBB29_49:                              #   in Loop: Header=BB29_5 Depth=1
	movl	-100(%rbp), %eax                # 4-byte Reload
	subl	$2048, %eax                     # imm = 0x800
	je	.LBB29_32
	jmp	.LBB29_50
.LBB29_50:                              #   in Loop: Header=BB29_5 Depth=1
	movl	-100(%rbp), %eax                # 4-byte Reload
	subl	$65536, %eax                    # imm = 0x10000
	je	.LBB29_38
	jmp	.LBB29_41
.LBB29_26:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$452, %rdx                      # imm = 0x1C4
	movq	-32(%rbp), %rcx
	addq	$456, %rcx                      # imm = 0x1C8
	callq	x509_get_basic_constraints
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_28
# %bb.27:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_28:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_42
.LBB29_29:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$460, %rdx                      # imm = 0x1CC
	callq	x509_get_key_usage
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_31
# %bb.30:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_31:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_42
.LBB29_32:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$464, %rdx                      # imm = 0x1D0
	callq	x509_get_ext_key_usage
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_34
# %bb.33:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_34:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_42
.LBB29_35:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$416, %rdx                      # imm = 0x1A0
	callq	x509_get_subject_alt_name
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_37
# %bb.36:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_37:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_42
.LBB29_38:                              #   in Loop: Header=BB29_5 Depth=1
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-32(%rbp), %rdx
	addq	$496, %rdx                      # imm = 0x1F0
	callq	x509_get_ns_cert_type
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB29_40
# %bb.39:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_46
.LBB29_40:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_42
.LBB29_41:
	movl	$-8320, -4(%rbp)                # imm = 0xDF80
	jmp	.LBB29_46
.LBB29_42:                              #   in Loop: Header=BB29_5 Depth=1
	jmp	.LBB29_5
.LBB29_43:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB29_45
# %bb.44:
	movl	$-9574, -4(%rbp)                # imm = 0xDA9A
	jmp	.LBB29_46
.LBB29_45:
	movl	$0, -4(%rbp)
.LBB29_46:
	movl	-4(%rbp), %eax
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end29:
	.size	x509_get_crt_ext, .Lfunc_end29-x509_get_crt_ext
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_basic_constraints
	.type	x509_get_basic_constraints,@function
x509_get_basic_constraints:             # @x509_get_basic_constraints
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	-32(%rbp), %rax
	movl	$0, (%rax)
	movq	-40(%rbp), %rax
	movl	$0, (%rax)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-56(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, %eax
	je	.LBB30_2
# %bb.1:
	movl	-44(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB30_19
.LBB30_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB30_4
# %bb.3:
	movl	$0, -4(%rbp)
	jmp	.LBB30_19
.LBB30_4:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	mbedtls_asn1_get_bool@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, %eax
	je	.LBB30_12
# %bb.5:
	cmpl	$-98, -44(%rbp)
	jne	.LBB30_7
# %bb.6:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	mbedtls_asn1_get_int@PLT
	movl	%eax, -44(%rbp)
.LBB30_7:
	cmpl	$0, -44(%rbp)
	je	.LBB30_9
# %bb.8:
	movl	-44(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB30_19
.LBB30_9:
	movq	-32(%rbp), %rax
	cmpl	$0, (%rax)
	je	.LBB30_11
# %bb.10:
	movq	-32(%rbp), %rax
	movl	$1, (%rax)
.LBB30_11:
	jmp	.LBB30_12
.LBB30_12:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB30_14
# %bb.13:
	movl	$0, -4(%rbp)
	jmp	.LBB30_19
.LBB30_14:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdx
	callq	mbedtls_asn1_get_int@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, %eax
	je	.LBB30_16
# %bb.15:
	movl	-44(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB30_19
.LBB30_16:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB30_18
# %bb.17:
	movl	$-9574, -4(%rbp)                # imm = 0xDA9A
	jmp	.LBB30_19
.LBB30_18:
	movq	-40(%rbp), %rax
	movl	(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, (%rax)
	movl	$0, -4(%rbp)
.LBB30_19:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end30:
	.size	x509_get_basic_constraints, .Lfunc_end30-x509_get_basic_constraints
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_key_usage
	.type	x509_get_key_usage,@function
x509_get_key_usage:                     # @x509_get_key_usage
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	leaq	-72(%rbp), %rdi
	xorl	%esi, %esi
	movl	$24, %edx
	callq	memset@PLT
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-72(%rbp), %rdx
	callq	mbedtls_asn1_get_bitstring@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB31_2
# %bb.1:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB31_11
.LBB31_2:
	cmpq	$1, -72(%rbp)
	jae	.LBB31_4
# %bb.3:
	movl	$-9572, -4(%rbp)                # imm = 0xDA9C
	jmp	.LBB31_11
.LBB31_4:
	movq	-32(%rbp), %rax
	movl	$0, (%rax)
	movq	$0, -48(%rbp)
.LBB31_5:                               # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rcx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	-72(%rbp), %rcx
	movb	%al, -73(%rbp)                  # 1-byte Spill
	jae	.LBB31_7
# %bb.6:                                #   in Loop: Header=BB31_5 Depth=1
	cmpq	$4, -48(%rbp)
	setb	%al
	movb	%al, -73(%rbp)                  # 1-byte Spill
.LBB31_7:                               #   in Loop: Header=BB31_5 Depth=1
	movb	-73(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB31_8
	jmp	.LBB31_10
.LBB31_8:                               #   in Loop: Header=BB31_5 Depth=1
	movq	-56(%rbp), %rax
	movq	-48(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movq	-48(%rbp), %rcx
	shlq	$3, %rcx
                                        # kill: def $ecx killed $ecx killed $rcx
                                        # kill: def $cl killed $ecx
	shll	%cl, %eax
	movl	%eax, %ecx
	movq	-32(%rbp), %rax
	orl	(%rax), %ecx
	movl	%ecx, (%rax)
# %bb.9:                                #   in Loop: Header=BB31_5 Depth=1
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB31_5
.LBB31_10:
	movl	$0, -4(%rbp)
.LBB31_11:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end31:
	.size	x509_get_key_usage, .Lfunc_end31-x509_get_key_usage
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_ext_key_usage
	.type	x509_get_ext_key_usage,@function
x509_get_ext_key_usage:                 # @x509_get_ext_key_usage
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movl	$6, %ecx
	callq	mbedtls_asn1_get_sequence_of@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB32_2
# %bb.1:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB32_5
.LBB32_2:
	movq	-32(%rbp), %rax
	cmpq	$0, 16(%rax)
	jne	.LBB32_4
# %bb.3:
	movl	$-9572, -4(%rbp)                # imm = 0xDA9C
	jmp	.LBB32_5
.LBB32_4:
	movl	$0, -4(%rbp)
.LBB32_5:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end32:
	.size	x509_get_ext_key_usage, .Lfunc_end32-x509_get_ext_key_usage
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_subject_alt_name
	.type	x509_get_subject_alt_name,@function
x509_get_subject_alt_name:              # @x509_get_subject_alt_name
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	movl	$48, %ecx
	callq	mbedtls_asn1_get_tag@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB33_2
# %bb.1:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB33_24
.LBB33_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	-48(%rbp), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB33_4
# %bb.3:
	movl	$-9574, -4(%rbp)                # imm = 0xDA9A
	jmp	.LBB33_24
.LBB33_4:
	jmp	.LBB33_5
.LBB33_5:                               # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	jae	.LBB33_21
# %bb.6:                                #   in Loop: Header=BB33_5 Depth=1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	subq	%rcx, %rax
	cmpq	$1, %rax
	jge	.LBB33_8
# %bb.7:
	movl	$-9568, -4(%rbp)                # imm = 0xDAA0
	jmp	.LBB33_24
.LBB33_8:                               #   in Loop: Header=BB33_5 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movb	(%rax), %al
	movb	%al, -65(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, (%rax)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-56(%rbp), %rdx
	callq	mbedtls_asn1_get_len@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB33_10
# %bb.9:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB33_24
.LBB33_10:                              #   in Loop: Header=BB33_5 Depth=1
	movzbl	-65(%rbp), %eax
	andl	$128, %eax
	cmpl	$128, %eax
	je	.LBB33_12
# %bb.11:
	movl	$-9570, -4(%rbp)                # imm = 0xDA9E
	jmp	.LBB33_24
.LBB33_12:                              #   in Loop: Header=BB33_5 Depth=1
	movzbl	-65(%rbp), %eax
	cmpl	$130, %eax
	je	.LBB33_14
# %bb.13:                               #   in Loop: Header=BB33_5 Depth=1
	movq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	addq	(%rax), %rcx
	movq	%rcx, (%rax)
	jmp	.LBB33_5
.LBB33_14:                              #   in Loop: Header=BB33_5 Depth=1
	movq	-80(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB33_20
# %bb.15:                               #   in Loop: Header=BB33_5 Depth=1
	movq	-80(%rbp), %rax
	cmpq	$0, 24(%rax)
	je	.LBB33_17
# %bb.16:
	movl	$-9472, -4(%rbp)                # imm = 0xDB00
	jmp	.LBB33_24
.LBB33_17:                              #   in Loop: Header=BB33_5 Depth=1
	movl	$1, %edi
	movl	$32, %esi
	callq	calloc@PLT
	movq	%rax, %rcx
	movq	-80(%rbp), %rax
	movq	%rcx, 24(%rax)
	movq	-80(%rbp), %rax
	cmpq	$0, 24(%rax)
	jne	.LBB33_19
# %bb.18:
	movl	$-9578, -4(%rbp)                # imm = 0xDA96
	jmp	.LBB33_24
.LBB33_19:                              #   in Loop: Header=BB33_5 Depth=1
	movq	-80(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -80(%rbp)
.LBB33_20:                              #   in Loop: Header=BB33_5 Depth=1
	movq	-80(%rbp), %rax
	movq	%rax, -64(%rbp)
	movzbl	-65(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rcx
	movq	-64(%rbp), %rax
	movq	%rcx, 16(%rax)
	movq	-56(%rbp), %rcx
	movq	-64(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-64(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-16(%rbp), %rax
	addq	(%rax), %rcx
	movq	%rcx, (%rax)
	jmp	.LBB33_5
.LBB33_21:
	movq	-80(%rbp), %rax
	movq	$0, 24(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB33_23
# %bb.22:
	movl	$-9574, -4(%rbp)                # imm = 0xDA9A
	jmp	.LBB33_24
.LBB33_23:
	movl	$0, -4(%rbp)
.LBB33_24:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end33:
	.size	x509_get_subject_alt_name, .Lfunc_end33-x509_get_subject_alt_name
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_get_ns_cert_type
	.type	x509_get_ns_cert_type,@function
x509_get_ns_cert_type:                  # @x509_get_ns_cert_type
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	movl	$24, %edx
	callq	memset@PLT
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	leaq	-64(%rbp), %rdx
	callq	mbedtls_asn1_get_bitstring@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, %eax
	je	.LBB34_2
# %bb.1:
	movl	-36(%rbp), %eax
	addl	$4294957824, %eax               # imm = 0xFFFFDB00
	movl	%eax, -4(%rbp)
	jmp	.LBB34_5
.LBB34_2:
	cmpq	$1, -64(%rbp)
	je	.LBB34_4
# %bb.3:
	movl	$-9572, -4(%rbp)                # imm = 0xDA9C
	jmp	.LBB34_5
.LBB34_4:
	movq	-48(%rbp), %rax
	movb	(%rax), %cl
	movq	-32(%rbp), %rax
	movb	%cl, (%rax)
	movl	$0, -4(%rbp)
.LBB34_5:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end34:
	.size	x509_get_ns_cert_type, .Lfunc_end34-x509_get_ns_cert_type
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function mbedtls_pk_ec
	.type	mbedtls_pk_ec,@function
mbedtls_pk_ec:                          # @mbedtls_pk_ec
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end35:
	.size	mbedtls_pk_ec, .Lfunc_end35-mbedtls_pk_ec
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_name_cmp
	.type	x509_name_cmp,@function
x509_name_cmp:                          # @x509_name_cmp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
.LBB36_1:                               # =>This Inner Loop Header: Depth=1
	movb	$1, %al
	cmpq	$0, -16(%rbp)
	movb	%al, -25(%rbp)                  # 1-byte Spill
	jne	.LBB36_3
# %bb.2:                                #   in Loop: Header=BB36_1 Depth=1
	cmpq	$0, -24(%rbp)
	setne	%al
	movb	%al, -25(%rbp)                  # 1-byte Spill
.LBB36_3:                               #   in Loop: Header=BB36_1 Depth=1
	movb	-25(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB36_4
	jmp	.LBB36_16
.LBB36_4:                               #   in Loop: Header=BB36_1 Depth=1
	cmpq	$0, -16(%rbp)
	je	.LBB36_6
# %bb.5:                                #   in Loop: Header=BB36_1 Depth=1
	cmpq	$0, -24(%rbp)
	jne	.LBB36_7
.LBB36_6:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_17
.LBB36_7:                               #   in Loop: Header=BB36_1 Depth=1
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rcx
	cmpl	(%rcx), %eax
	jne	.LBB36_10
# %bb.8:                                #   in Loop: Header=BB36_1 Depth=1
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jne	.LBB36_10
# %bb.9:                                #   in Loop: Header=BB36_1 Depth=1
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	je	.LBB36_11
.LBB36_10:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_17
.LBB36_11:                              #   in Loop: Header=BB36_1 Depth=1
	movq	-16(%rbp), %rdi
	addq	$24, %rdi
	movq	-24(%rbp), %rsi
	addq	$24, %rsi
	callq	x509_string_cmp
	cmpl	$0, %eax
	je	.LBB36_13
# %bb.12:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_17
.LBB36_13:                              #   in Loop: Header=BB36_1 Depth=1
	movq	-16(%rbp), %rax
	movzbl	56(%rax), %eax
	movq	-24(%rbp), %rcx
	movzbl	56(%rcx), %ecx
	cmpl	%ecx, %eax
	je	.LBB36_15
# %bb.14:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_17
.LBB36_15:                              #   in Loop: Header=BB36_1 Depth=1
	movq	-16(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB36_1
.LBB36_16:
	movl	$0, -4(%rbp)
.LBB36_17:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end36:
	.size	x509_name_cmp, .Lfunc_end36-x509_name_cmp
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_string_cmp
	.type	x509_string_cmp,@function
x509_string_cmp:                        # @x509_string_cmp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rcx
	cmpl	(%rcx), %eax
	jne	.LBB37_4
# %bb.1:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jne	.LBB37_4
# %bb.2:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	jne	.LBB37_4
# %bb.3:
	movl	$0, -4(%rbp)
	jmp	.LBB37_12
.LBB37_4:
	movq	-16(%rbp), %rax
	cmpl	$12, (%rax)
	je	.LBB37_6
# %bb.5:
	movq	-16(%rbp), %rax
	cmpl	$19, (%rax)
	jne	.LBB37_11
.LBB37_6:
	movq	-24(%rbp), %rax
	cmpl	$12, (%rax)
	je	.LBB37_8
# %bb.7:
	movq	-24(%rbp), %rax
	cmpl	$19, (%rax)
	jne	.LBB37_11
.LBB37_8:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jne	.LBB37_11
# %bb.9:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	16(%rax), %rsi
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	callq	x509_memcasecmp
	cmpl	$0, %eax
	jne	.LBB37_11
# %bb.10:
	movl	$0, -4(%rbp)
	jmp	.LBB37_12
.LBB37_11:
	movl	$-1, -4(%rbp)
.LBB37_12:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end37:
	.size	x509_string_cmp, .Lfunc_end37-x509_string_cmp
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_profile_check_md_alg
	.type	x509_profile_check_md_alg,@function
x509_profile_check_md_alg:              # @x509_profile_check_md_alg
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	-20(%rbp), %ecx
	subl	$1, %ecx
	movl	$1, %edx
                                        # kill: def $cl killed $ecx
	shll	%cl, %edx
	movl	%edx, %ecx
	andl	%ecx, %eax
	cmpl	$0, %eax
	je	.LBB38_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB38_3
.LBB38_2:
	movl	$-1, -4(%rbp)
.LBB38_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end38:
	.size	x509_profile_check_md_alg, .Lfunc_end38-x509_profile_check_md_alg
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function x509_crt_verifycrl
	.type	x509_crt_verifycrl,@function
x509_crt_verifycrl:                     # @x509_crt_verifycrl
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$176, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	$0, -44(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB39_2
# %bb.1:
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB39_28
.LBB39_2:
	jmp	.LBB39_3
.LBB39_3:                               # =>This Inner Loop Header: Depth=1
	cmpq	$0, -32(%rbp)
	je	.LBB39_27
# %bb.4:                                #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	cmpl	$0, 48(%rax)
	je	.LBB39_7
# %bb.5:                                #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	movq	88(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	136(%rcx), %rax
	jne	.LBB39_7
# %bb.6:                                #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	movq	96(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	144(%rax), %rsi
	movq	-32(%rbp), %rax
	movq	88(%rax), %rdx
	callq	memcmp@PLT
	cmpl	$0, %eax
	je	.LBB39_8
.LBB39_7:                               #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	movq	408(%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB39_3
.LBB39_8:                               #   in Loop: Header=BB39_3 Depth=1
	movq	-24(%rbp), %rdi
	movl	$2, %esi
	callq	mbedtls_x509_crt_check_key_usage
	cmpl	$0, %eax
	je	.LBB39_10
# %bb.9:
	movl	-44(%rbp), %eax
	orl	$16, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB39_27
.LBB39_10:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-40(%rbp), %rdi
	movq	-32(%rbp), %rax
	movl	392(%rax), %esi
	callq	x509_profile_check_md_alg
	cmpl	$0, %eax
	je	.LBB39_12
# %bb.11:                               #   in Loop: Header=BB39_3 Depth=1
	movl	-44(%rbp), %eax
	orl	$131072, %eax                   # imm = 0x20000
	movl	%eax, -44(%rbp)
.LBB39_12:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-40(%rbp), %rdi
	movq	-32(%rbp), %rax
	movl	396(%rax), %esi
	callq	x509_profile_check_pk_alg
	cmpl	$0, %eax
	je	.LBB39_14
# %bb.13:                               #   in Loop: Header=BB39_3 Depth=1
	movl	-44(%rbp), %eax
	orl	$262144, %eax                   # imm = 0x40000
	movl	%eax, -44(%rbp)
.LBB39_14:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	movl	392(%rax), %edi
	callq	mbedtls_md_info_from_type@PLT
	movq	%rax, -120(%rbp)
	cmpq	$0, -120(%rbp)
	jne	.LBB39_16
# %bb.15:
	movl	-44(%rbp), %eax
	orl	$16, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB39_27
.LBB39_16:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-120(%rbp), %rdi
	movq	-32(%rbp), %rax
	movq	40(%rax), %rsi
	movq	-32(%rbp), %rax
	movq	32(%rax), %rdx
	leaq	-112(%rbp), %rcx
	callq	mbedtls_md@PLT
	movq	-40(%rbp), %rdi
	movq	-32(%rbp), %rax
	movl	396(%rax), %esi
	movq	-24(%rbp), %rdx
	addq	$328, %rdx                      # imm = 0x148
	callq	x509_profile_check_key
	cmpl	$0, %eax
	je	.LBB39_18
# %bb.17:                               #   in Loop: Header=BB39_3 Depth=1
	movl	-44(%rbp), %eax
	orl	$65536, %eax                    # imm = 0x10000
	movl	%eax, -44(%rbp)
.LBB39_18:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	movl	396(%rax), %eax
	movl	%eax, -156(%rbp)                # 4-byte Spill
	movq	-32(%rbp), %rax
	movq	400(%rax), %rax
	movq	%rax, -152(%rbp)                # 8-byte Spill
	movq	-24(%rbp), %rax
	addq	$328, %rax                      # imm = 0x148
	movq	%rax, -144(%rbp)                # 8-byte Spill
	movq	-32(%rbp), %rax
	movl	392(%rax), %eax
	movl	%eax, -132(%rbp)                # 4-byte Spill
	leaq	-112(%rbp), %rax
	movq	%rax, -128(%rbp)                # 8-byte Spill
	movq	-120(%rbp), %rdi
	callq	mbedtls_md_get_size@PLT
	movl	-156(%rbp), %edi                # 4-byte Reload
	movq	-152(%rbp), %rsi                # 8-byte Reload
	movq	-144(%rbp), %rdx                # 8-byte Reload
	movl	-132(%rbp), %ecx                # 4-byte Reload
	movq	-128(%rbp), %r8                 # 8-byte Reload
	movzbl	%al, %eax
	movl	%eax, %r9d
	movq	-32(%rbp), %rax
	movq	384(%rax), %r10
	movq	-32(%rbp), %rax
	movq	376(%rax), %rax
	movq	%r10, (%rsp)
	movq	%rax, 8(%rsp)
	callq	mbedtls_pk_verify_ext@PLT
	cmpl	$0, %eax
	je	.LBB39_20
# %bb.19:
	movl	-44(%rbp), %eax
	orl	$16, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB39_27
.LBB39_20:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rdi
	addq	$192, %rdi
	callq	mbedtls_x509_time_is_past@PLT
	cmpl	$0, %eax
	je	.LBB39_22
# %bb.21:                               #   in Loop: Header=BB39_3 Depth=1
	movl	-44(%rbp), %eax
	orl	$32, %eax
	movl	%eax, -44(%rbp)
.LBB39_22:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rdi
	addq	$168, %rdi
	callq	mbedtls_x509_time_is_future@PLT
	cmpl	$0, %eax
	je	.LBB39_24
# %bb.23:                               #   in Loop: Header=BB39_3 Depth=1
	movl	-44(%rbp), %eax
	orl	$1024, %eax                     # imm = 0x400
	movl	%eax, -44(%rbp)
.LBB39_24:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	mbedtls_x509_crt_is_revoked
	cmpl	$0, %eax
	je	.LBB39_26
# %bb.25:
	movl	-44(%rbp), %eax
	orl	$2, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB39_27
.LBB39_26:                              #   in Loop: Header=BB39_3 Depth=1
	movq	-32(%rbp), %rax
	movq	408(%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB39_3
.LBB39_27:
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB39_28:
	movl	-4(%rbp), %eax
	addq	$176, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end39:
	.size	x509_crt_verifycrl, .Lfunc_end39-x509_crt_verifycrl
	.cfi_endproc
                                        # -- End function
	.type	mbedtls_x509_crt_profile_default,@object # @mbedtls_x509_crt_profile_default
	.section	.rodata,"a",@progbits
	.globl	mbedtls_x509_crt_profile_default
	.p2align	2, 0x0
mbedtls_x509_crt_profile_default:
	.long	240                             # 0xf0
	.long	268435455                       # 0xfffffff
	.long	268435455                       # 0xfffffff
	.long	2048                            # 0x800
	.size	mbedtls_x509_crt_profile_default, 16

	.type	mbedtls_x509_crt_profile_next,@object # @mbedtls_x509_crt_profile_next
	.globl	mbedtls_x509_crt_profile_next
	.p2align	2, 0x0
mbedtls_x509_crt_profile_next:
	.long	224                             # 0xe0
	.long	268435455                       # 0xfffffff
	.long	2300                            # 0x8fc
	.long	2048                            # 0x800
	.size	mbedtls_x509_crt_profile_next, 16

	.type	mbedtls_x509_crt_profile_suiteb,@object # @mbedtls_x509_crt_profile_suiteb
	.globl	mbedtls_x509_crt_profile_suiteb
	.p2align	2, 0x0
mbedtls_x509_crt_profile_suiteb:
	.long	96                              # 0x60
	.long	8                               # 0x8
	.long	12                              # 0xc
	.long	0                               # 0x0
	.size	mbedtls_x509_crt_profile_suiteb, 16

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"-----BEGIN CERTIFICATE-----"
	.size	.L.str, 28

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"-----END CERTIFICATE-----"
	.size	.L.str.1, 26

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"%s/%s"
	.size	.L.str.2, 6

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"\nCertificate is uninitialised!\n"
	.size	.L.str.3, 32

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"%scert. version     : %d\n"
	.size	.L.str.4, 26

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"%sserial number     : "
	.size	.L.str.5, 23

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"\n%sissuer name       : "
	.size	.L.str.6, 24

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"\n%ssubject name      : "
	.size	.L.str.7, 24

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"\n%sissued  on        : %04d-%02d-%02d %02d:%02d:%02d"
	.size	.L.str.8, 53

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"\n%sexpires on        : %04d-%02d-%02d %02d:%02d:%02d"
	.size	.L.str.9, 53

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"\n%ssigned using      : "
	.size	.L.str.10, 24

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"\n%s%-18s: %d bits"
	.size	.L.str.11, 18

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"\n%sbasic constraints : CA=%s"
	.size	.L.str.12, 29

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"true"
	.size	.L.str.13, 5

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"false"
	.size	.L.str.14, 6

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	", max_pathlen=%d"
	.size	.L.str.15, 17

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"\n%ssubject alt name  : "
	.size	.L.str.16, 24

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"\n%scert. type        : "
	.size	.L.str.17, 24

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"\n%skey usage         : "
	.size	.L.str.18, 24

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"\n%sext key usage     : "
	.size	.L.str.19, 24

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"\n"
	.size	.L.str.20, 2

	.type	x509_crt_verify_strings,@object # @x509_crt_verify_strings
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
x509_crt_verify_strings:
	.long	1                               # 0x1
	.zero	4
	.quad	.L.str.47
	.long	2                               # 0x2
	.zero	4
	.quad	.L.str.48
	.long	4                               # 0x4
	.zero	4
	.quad	.L.str.49
	.long	8                               # 0x8
	.zero	4
	.quad	.L.str.50
	.long	16                              # 0x10
	.zero	4
	.quad	.L.str.51
	.long	32                              # 0x20
	.zero	4
	.quad	.L.str.52
	.long	64                              # 0x40
	.zero	4
	.quad	.L.str.53
	.long	128                             # 0x80
	.zero	4
	.quad	.L.str.54
	.long	256                             # 0x100
	.zero	4
	.quad	.L.str.55
	.long	512                             # 0x200
	.zero	4
	.quad	.L.str.56
	.long	1024                            # 0x400
	.zero	4
	.quad	.L.str.57
	.long	2048                            # 0x800
	.zero	4
	.quad	.L.str.58
	.long	4096                            # 0x1000
	.zero	4
	.quad	.L.str.59
	.long	8192                            # 0x2000
	.zero	4
	.quad	.L.str.60
	.long	16384                           # 0x4000
	.zero	4
	.quad	.L.str.61
	.long	32768                           # 0x8000
	.zero	4
	.quad	.L.str.62
	.long	65536                           # 0x10000
	.zero	4
	.quad	.L.str.63
	.long	131072                          # 0x20000
	.zero	4
	.quad	.L.str.64
	.long	262144                          # 0x40000
	.zero	4
	.quad	.L.str.65
	.long	524288                          # 0x80000
	.zero	4
	.quad	.L.str.66
	.zero	16
	.size	x509_crt_verify_strings, 336

	.type	.L.str.21,@object               # @.str.21
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.21:
	.asciz	"%s%s\n"
	.size	.L.str.21, 6

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"%sUnknown reason (this should not happen)\n"
	.size	.L.str.22, 43

	.type	.L.str.23,@object               # @.str.23
	.section	.rodata,"a",@progbits
.L.str.23:
	.asciz	"U\035%\000"
	.size	.L.str.23, 5

	.type	.L.str.24,@object               # @.str.24
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.24:
	.asciz	"*."
	.size	.L.str.24, 3

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"U\004\003"
	.size	.L.str.25, 4

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.zero	1
	.size	.L.str.26, 1

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	", "
	.size	.L.str.27, 3

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	"%sSSL Client"
	.size	.L.str.28, 13

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	"%sSSL Server"
	.size	.L.str.29, 13

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	"%sEmail"
	.size	.L.str.30, 8

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"%sObject Signing"
	.size	.L.str.31, 17

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"%sReserved"
	.size	.L.str.32, 11

	.type	.L.str.33,@object               # @.str.33
.L.str.33:
	.asciz	"%sSSL CA"
	.size	.L.str.33, 9

	.type	.L.str.34,@object               # @.str.34
.L.str.34:
	.asciz	"%sEmail CA"
	.size	.L.str.34, 11

	.type	.L.str.35,@object               # @.str.35
.L.str.35:
	.asciz	"%sObject Signing CA"
	.size	.L.str.35, 20

	.type	.L.str.36,@object               # @.str.36
.L.str.36:
	.asciz	"%sDigital Signature"
	.size	.L.str.36, 20

	.type	.L.str.37,@object               # @.str.37
.L.str.37:
	.asciz	"%sNon Repudiation"
	.size	.L.str.37, 18

	.type	.L.str.38,@object               # @.str.38
.L.str.38:
	.asciz	"%sKey Encipherment"
	.size	.L.str.38, 19

	.type	.L.str.39,@object               # @.str.39
.L.str.39:
	.asciz	"%sData Encipherment"
	.size	.L.str.39, 20

	.type	.L.str.40,@object               # @.str.40
.L.str.40:
	.asciz	"%sKey Agreement"
	.size	.L.str.40, 16

	.type	.L.str.41,@object               # @.str.41
.L.str.41:
	.asciz	"%sKey Cert Sign"
	.size	.L.str.41, 16

	.type	.L.str.42,@object               # @.str.42
.L.str.42:
	.asciz	"%sCRL Sign"
	.size	.L.str.42, 11

	.type	.L.str.43,@object               # @.str.43
.L.str.43:
	.asciz	"%sEncipher Only"
	.size	.L.str.43, 16

	.type	.L.str.44,@object               # @.str.44
.L.str.44:
	.asciz	"%sDecipher Only"
	.size	.L.str.44, 16

	.type	.L.str.45,@object               # @.str.45
.L.str.45:
	.asciz	"???"
	.size	.L.str.45, 4

	.type	.L.str.46,@object               # @.str.46
.L.str.46:
	.asciz	"%s%s"
	.size	.L.str.46, 5

	.type	.L.str.47,@object               # @.str.47
.L.str.47:
	.asciz	"The certificate validity has expired"
	.size	.L.str.47, 37

	.type	.L.str.48,@object               # @.str.48
.L.str.48:
	.asciz	"The certificate has been revoked (is on a CRL)"
	.size	.L.str.48, 47

	.type	.L.str.49,@object               # @.str.49
.L.str.49:
	.asciz	"The certificate Common Name (CN) does not match with the expected CN"
	.size	.L.str.49, 69

	.type	.L.str.50,@object               # @.str.50
.L.str.50:
	.asciz	"The certificate is not correctly signed by the trusted CA"
	.size	.L.str.50, 58

	.type	.L.str.51,@object               # @.str.51
.L.str.51:
	.asciz	"The CRL is not correctly signed by the trusted CA"
	.size	.L.str.51, 50

	.type	.L.str.52,@object               # @.str.52
.L.str.52:
	.asciz	"The CRL is expired"
	.size	.L.str.52, 19

	.type	.L.str.53,@object               # @.str.53
.L.str.53:
	.asciz	"Certificate was missing"
	.size	.L.str.53, 24

	.type	.L.str.54,@object               # @.str.54
.L.str.54:
	.asciz	"Certificate verification was skipped"
	.size	.L.str.54, 37

	.type	.L.str.55,@object               # @.str.55
.L.str.55:
	.asciz	"Other reason (can be used by verify callback)"
	.size	.L.str.55, 46

	.type	.L.str.56,@object               # @.str.56
.L.str.56:
	.asciz	"The certificate validity starts in the future"
	.size	.L.str.56, 46

	.type	.L.str.57,@object               # @.str.57
.L.str.57:
	.asciz	"The CRL is from the future"
	.size	.L.str.57, 27

	.type	.L.str.58,@object               # @.str.58
.L.str.58:
	.asciz	"Usage does not match the keyUsage extension"
	.size	.L.str.58, 44

	.type	.L.str.59,@object               # @.str.59
.L.str.59:
	.asciz	"Usage does not match the extendedKeyUsage extension"
	.size	.L.str.59, 52

	.type	.L.str.60,@object               # @.str.60
.L.str.60:
	.asciz	"Usage does not match the nsCertType extension"
	.size	.L.str.60, 46

	.type	.L.str.61,@object               # @.str.61
.L.str.61:
	.asciz	"The certificate is signed with an unacceptable hash."
	.size	.L.str.61, 53

	.type	.L.str.62,@object               # @.str.62
.L.str.62:
	.asciz	"The certificate is signed with an unacceptable PK alg (eg RSA vs ECDSA)."
	.size	.L.str.62, 73

	.type	.L.str.63,@object               # @.str.63
.L.str.63:
	.asciz	"The certificate is signed with an unacceptable key (eg bad curve, RSA too short)."
	.size	.L.str.63, 82

	.type	.L.str.64,@object               # @.str.64
.L.str.64:
	.asciz	"The CRL is signed with an unacceptable hash."
	.size	.L.str.64, 45

	.type	.L.str.65,@object               # @.str.65
.L.str.65:
	.asciz	"The CRL is signed with an unacceptable PK alg (eg RSA vs ECDSA)."
	.size	.L.str.65, 65

	.type	.L.str.66,@object               # @.str.66
.L.str.66:
	.asciz	"The CRL is signed with an unacceptable key (eg bad curve, RSA too short)."
	.size	.L.str.66, 74

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym mbedtls_x509_crt_parse_der
	.addrsig_sym calloc
	.addrsig_sym mbedtls_x509_crt_init
	.addrsig_sym x509_crt_parse_der_core
	.addrsig_sym free
	.addrsig_sym mbedtls_x509_crt_parse
	.addrsig_sym strstr
	.addrsig_sym mbedtls_pem_init
	.addrsig_sym mbedtls_pem_read_buffer
	.addrsig_sym mbedtls_pem_free
	.addrsig_sym mbedtls_x509_crt_parse_file
	.addrsig_sym mbedtls_pk_load_file
	.addrsig_sym mbedtls_zeroize
	.addrsig_sym opendir
	.addrsig_sym readdir
	.addrsig_sym snprintf
	.addrsig_sym stat
	.addrsig_sym closedir
	.addrsig_sym mbedtls_x509_serial_gets
	.addrsig_sym mbedtls_x509_dn_gets
	.addrsig_sym mbedtls_x509_sig_alg_gets
	.addrsig_sym mbedtls_x509_key_size_helper
	.addrsig_sym mbedtls_pk_get_name
	.addrsig_sym mbedtls_pk_get_bitlen
	.addrsig_sym x509_info_subject_alt_name
	.addrsig_sym x509_info_cert_type
	.addrsig_sym x509_info_key_usage
	.addrsig_sym x509_info_ext_key_usage
	.addrsig_sym mbedtls_x509_crt_check_key_usage
	.addrsig_sym memcmp
	.addrsig_sym mbedtls_x509_crt_is_revoked
	.addrsig_sym mbedtls_x509_time_is_past
	.addrsig_sym mbedtls_x509_crt_verify_with_profile
	.addrsig_sym strlen
	.addrsig_sym x509_memcasecmp
	.addrsig_sym x509_check_wildcard
	.addrsig_sym mbedtls_pk_get_type
	.addrsig_sym x509_profile_check_pk_alg
	.addrsig_sym x509_profile_check_key
	.addrsig_sym x509_crt_check_parent
	.addrsig_sym x509_crt_verify_top
	.addrsig_sym x509_crt_verify_child
	.addrsig_sym mbedtls_x509_crt_free
	.addrsig_sym mbedtls_pk_free
	.addrsig_sym mbedtls_asn1_get_tag
	.addrsig_sym x509_get_version
	.addrsig_sym mbedtls_x509_get_serial
	.addrsig_sym mbedtls_x509_get_alg
	.addrsig_sym mbedtls_x509_get_sig_alg
	.addrsig_sym mbedtls_x509_get_name
	.addrsig_sym x509_get_dates
	.addrsig_sym mbedtls_pk_parse_subpubkey
	.addrsig_sym x509_get_uid
	.addrsig_sym x509_get_crt_ext
	.addrsig_sym mbedtls_x509_get_sig
	.addrsig_sym mbedtls_asn1_get_int
	.addrsig_sym mbedtls_x509_get_time
	.addrsig_sym mbedtls_x509_get_ext
	.addrsig_sym mbedtls_asn1_get_bool
	.addrsig_sym mbedtls_oid_get_x509_ext_type
	.addrsig_sym x509_get_basic_constraints
	.addrsig_sym x509_get_key_usage
	.addrsig_sym x509_get_ext_key_usage
	.addrsig_sym x509_get_subject_alt_name
	.addrsig_sym x509_get_ns_cert_type
	.addrsig_sym mbedtls_asn1_get_bitstring
	.addrsig_sym mbedtls_asn1_get_sequence_of
	.addrsig_sym mbedtls_asn1_get_len
	.addrsig_sym mbedtls_oid_get_extended_key_usage
	.addrsig_sym mbedtls_pk_ec
	.addrsig_sym x509_name_cmp
	.addrsig_sym x509_string_cmp
	.addrsig_sym mbedtls_x509_time_is_future
	.addrsig_sym x509_profile_check_md_alg
	.addrsig_sym mbedtls_md_info_from_type
	.addrsig_sym mbedtls_md
	.addrsig_sym mbedtls_pk_verify_ext
	.addrsig_sym mbedtls_md_get_size
	.addrsig_sym x509_crt_verifycrl
	.addrsig_sym mbedtls_x509_crt_profile_default
	.addrsig_sym x509_crt_verify_strings
