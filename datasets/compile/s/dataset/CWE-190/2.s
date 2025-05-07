	.text
	.file	"gd_gd2.c"
	.globl	gdImageCreateFromGd2            # -- Begin function gdImageCreateFromGd2
	.p2align	4, 0x90
	.type	gdImageCreateFromGd2,@function
gdImageCreateFromGd2:                   # @gdImageCreateFromGd2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rdi
	callq	gdNewFileCtx@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB0_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB0_3
.LBB0_2:
	movq	-24(%rbp), %rdi
	callq	gdImageCreateFromGd2Ctx@PLT
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	48(%rax), %rax
	movq	-24(%rbp), %rdi
	callq	*%rax
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB0_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	gdImageCreateFromGd2, .Lfunc_end0-gdImageCreateFromGd2
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreateFromGd2Ctx         # -- Begin function gdImageCreateFromGd2Ctx
	.p2align	4, 0x90
	.type	gdImageCreateFromGd2Ctx,@function
gdImageCreateFromGd2Ctx:                # @gdImageCreateFromGd2Ctx
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movq	%rdi, -16(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -104(%rbp)
	movl	$0, -108(%rbp)
	movl	$0, -112(%rbp)
	movl	$0, -124(%rbp)
	movl	$0, -128(%rbp)
	movq	$0, -144(%rbp)
	movq	-16(%rbp), %rdi
	leaq	-20(%rbp), %rsi
	leaq	-24(%rbp), %rdx
	leaq	-44(%rbp), %rcx
	leaq	-80(%rbp), %r8
	leaq	-84(%rbp), %r9
	leaq	-32(%rbp), %r11
	leaq	-36(%rbp), %r10
	leaq	-96(%rbp), %rax
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	_gd2CreateFromFile
	movq	%rax, -152(%rbp)
	cmpq	$0, -152(%rbp)
	jne	.LBB1_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB1_66
.LBB1_2:
	movq	-152(%rbp), %rax
	movl	7248(%rax), %edx
	movl	$1, %eax
	movl	$4, %ecx
	cmpl	$0, %edx
	cmovnel	%ecx, %eax
	movl	%eax, -132(%rbp)
	movl	-32(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
	cmpl	$2, -84(%rbp)
	je	.LBB1_4
# %bb.3:
	cmpl	$4, -84(%rbp)
	jne	.LBB1_15
.LBB1_4:
	movl	$0, -128(%rbp)
	movl	$0, -28(%rbp)
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	.LBB1_10
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
	movq	-96(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	cmpl	-128(%rbp), %eax
	jle	.LBB1_8
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
	movq	-96(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -128(%rbp)
.LBB1_8:                                #   in Loop: Header=BB1_5 Depth=1
	jmp	.LBB1_9
.LBB1_9:                                #   in Loop: Header=BB1_5 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB1_5
.LBB1_10:
	movl	-128(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -128(%rbp)
	movl	-44(%rbp), %eax
	imull	-132(%rbp), %eax
	imull	-44(%rbp), %eax
	movl	%eax, -112(%rbp)
	movslq	-112(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -104(%rbp)
	cmpq	$0, -104(%rbp)
	jne	.LBB1_12
# %bb.11:
	jmp	.LBB1_59
.LBB1_12:
	movslq	-128(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -144(%rbp)
	cmpq	$0, -144(%rbp)
	jne	.LBB1_14
# %bb.13:
	jmp	.LBB1_59
.LBB1_14:
	jmp	.LBB1_15
.LBB1_15:
	movl	$0, -52(%rbp)
.LBB1_16:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_18 Depth 2
                                        #       Child Loop BB1_27 Depth 3
                                        #         Child Loop BB1_33 Depth 4
                                        #         Child Loop BB1_45 Depth 4
	movl	-52(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jge	.LBB1_58
# %bb.17:                               #   in Loop: Header=BB1_16 Depth=1
	movl	$0, -48(%rbp)
.LBB1_18:                               #   Parent Loop BB1_16 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_27 Depth 3
                                        #         Child Loop BB1_33 Depth 4
                                        #         Child Loop BB1_45 Depth 4
	movl	-48(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB1_56
# %bb.19:                               #   in Loop: Header=BB1_18 Depth=2
	movl	-52(%rbp), %eax
	imull	-44(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-64(%rbp), %eax
	addl	-44(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	movq	-152(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jle	.LBB1_21
# %bb.20:                               #   in Loop: Header=BB1_18 Depth=2
	movq	-152(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -68(%rbp)
.LBB1_21:                               #   in Loop: Header=BB1_18 Depth=2
	cmpl	$2, -84(%rbp)
	je	.LBB1_23
# %bb.22:                               #   in Loop: Header=BB1_18 Depth=2
	cmpl	$4, -84(%rbp)
	jne	.LBB1_26
.LBB1_23:                               #   in Loop: Header=BB1_18 Depth=2
	movslq	-112(%rbp), %rax
	movq	%rax, -120(%rbp)
	movq	-96(%rbp), %rax
	movslq	-108(%rbp), %rcx
	movl	(%rax,%rcx,8), %edi
	movq	-144(%rbp), %rsi
	movq	-96(%rbp), %rax
	movslq	-108(%rbp), %rcx
	movl	4(%rax,%rcx,8), %edx
	movq	-104(%rbp), %rcx
	movq	-16(%rbp), %r9
	leaq	-120(%rbp), %r8
	callq	_gd2ReadChunk
	cmpl	$0, %eax
	jne	.LBB1_25
# %bb.24:
	jmp	.LBB1_59
.LBB1_25:                               #   in Loop: Header=BB1_18 Depth=2
	movl	$0, -124(%rbp)
.LBB1_26:                               #   in Loop: Header=BB1_18 Depth=2
	movl	-64(%rbp), %eax
	movl	%eax, -60(%rbp)
.LBB1_27:                               #   Parent Loop BB1_16 Depth=1
                                        #     Parent Loop BB1_18 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_33 Depth 4
                                        #         Child Loop BB1_45 Depth 4
	movl	-60(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB1_54
# %bb.28:                               #   in Loop: Header=BB1_27 Depth=3
	movl	-48(%rbp), %eax
	imull	-44(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-72(%rbp), %eax
	addl	-44(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movq	-152(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jle	.LBB1_30
# %bb.29:                               #   in Loop: Header=BB1_27 Depth=3
	movq	-152(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -76(%rbp)
.LBB1_30:                               #   in Loop: Header=BB1_27 Depth=3
	cmpl	$2, -84(%rbp)
	je	.LBB1_44
# %bb.31:                               #   in Loop: Header=BB1_27 Depth=3
	cmpl	$4, -84(%rbp)
	je	.LBB1_44
# %bb.32:                               #   in Loop: Header=BB1_27 Depth=3
	movl	-72(%rbp), %eax
	movl	%eax, -56(%rbp)
.LBB1_33:                               #   Parent Loop BB1_16 Depth=1
                                        #     Parent Loop BB1_18 Depth=2
                                        #       Parent Loop BB1_27 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-56(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jge	.LBB1_43
# %bb.34:                               #   in Loop: Header=BB1_33 Depth=4
	movq	-152(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB1_38
# %bb.35:                               #   in Loop: Header=BB1_33 Depth=4
	movq	-152(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-60(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	movslq	-56(%rbp), %rax
	shlq	$2, %rax
	addq	%rax, %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetInt@PLT
	cmpl	$0, %eax
	jne	.LBB1_37
# %bb.36:
	leaq	.L.str(%rip), %rdi
	movb	$0, %al
	callq	gd_error@PLT
	movq	-152(%rbp), %rdi
	callq	gdImageDestroy@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB1_66
.LBB1_37:                               #   in Loop: Header=BB1_33 Depth=4
	jmp	.LBB1_41
.LBB1_38:                               #   in Loop: Header=BB1_33 Depth=4
	movq	-16(%rbp), %rsi
	leaq	-156(%rbp), %rdi
	callq	gdGetByte@PLT
	cmpl	$0, %eax
	jne	.LBB1_40
# %bb.39:
	leaq	.L.str(%rip), %rdi
	movb	$0, %al
	callq	gd_error@PLT
	movq	-152(%rbp), %rdi
	callq	gdImageDestroy@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB1_66
.LBB1_40:                               #   in Loop: Header=BB1_33 Depth=4
	movl	-156(%rbp), %eax
	movb	%al, %dl
	movq	-152(%rbp), %rax
	movq	(%rax), %rax
	movslq	-60(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-56(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
.LBB1_41:                               #   in Loop: Header=BB1_33 Depth=4
	jmp	.LBB1_42
.LBB1_42:                               #   in Loop: Header=BB1_33 Depth=4
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB1_33
.LBB1_43:                               #   in Loop: Header=BB1_27 Depth=3
	jmp	.LBB1_52
.LBB1_44:                               #   in Loop: Header=BB1_27 Depth=3
	movl	-72(%rbp), %eax
	movl	%eax, -56(%rbp)
.LBB1_45:                               #   Parent Loop BB1_16 Depth=1
                                        #     Parent Loop BB1_18 Depth=2
                                        #       Parent Loop BB1_27 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-56(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jge	.LBB1_51
# %bb.46:                               #   in Loop: Header=BB1_45 Depth=4
	movq	-152(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB1_48
# %bb.47:                               #   in Loop: Header=BB1_45 Depth=4
	movq	-104(%rbp), %rax
	movl	-124(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -124(%rbp)
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	shll	$24, %eax
	movl	%eax, -160(%rbp)
	movq	-104(%rbp), %rax
	movl	-124(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -124(%rbp)
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	shll	$16, %eax
	movl	%eax, -164(%rbp)
	movq	-104(%rbp), %rax
	movl	-124(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -124(%rbp)
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	shll	$8, %eax
	movl	%eax, -168(%rbp)
	movq	-104(%rbp), %rax
	movl	-124(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -124(%rbp)
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -172(%rbp)
	movl	-160(%rbp), %edx
	addl	-164(%rbp), %edx
	addl	-168(%rbp), %edx
	addl	-172(%rbp), %edx
	movq	-152(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-60(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-56(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB1_49
.LBB1_48:                               #   in Loop: Header=BB1_45 Depth=4
	movq	-104(%rbp), %rax
	movl	-124(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -124(%rbp)
	movslq	%ecx, %rcx
	movb	(%rax,%rcx), %dl
	movq	-152(%rbp), %rax
	movq	(%rax), %rax
	movslq	-60(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-56(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
.LBB1_49:                               #   in Loop: Header=BB1_45 Depth=4
	jmp	.LBB1_50
.LBB1_50:                               #   in Loop: Header=BB1_45 Depth=4
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB1_45
.LBB1_51:                               #   in Loop: Header=BB1_27 Depth=3
	jmp	.LBB1_52
.LBB1_52:                               #   in Loop: Header=BB1_27 Depth=3
	jmp	.LBB1_53
.LBB1_53:                               #   in Loop: Header=BB1_27 Depth=3
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB1_27
.LBB1_54:                               #   in Loop: Header=BB1_18 Depth=2
	movl	-108(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -108(%rbp)
# %bb.55:                               #   in Loop: Header=BB1_18 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB1_18
.LBB1_56:                               #   in Loop: Header=BB1_16 Depth=1
	jmp	.LBB1_57
.LBB1_57:                               #   in Loop: Header=BB1_16 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB1_16
.LBB1_58:
	movq	-104(%rbp), %rdi
	callq	gdFree@PLT
	movq	-144(%rbp), %rdi
	callq	gdFree@PLT
	movq	-96(%rbp), %rdi
	callq	gdFree@PLT
	movq	-152(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB1_66
.LBB1_59:
	movq	-152(%rbp), %rdi
	callq	gdImageDestroy@PLT
	cmpq	$0, -104(%rbp)
	je	.LBB1_61
# %bb.60:
	movq	-104(%rbp), %rdi
	callq	gdFree@PLT
.LBB1_61:
	cmpq	$0, -144(%rbp)
	je	.LBB1_63
# %bb.62:
	movq	-144(%rbp), %rdi
	callq	gdFree@PLT
.LBB1_63:
	cmpq	$0, -96(%rbp)
	je	.LBB1_65
# %bb.64:
	movq	-96(%rbp), %rdi
	callq	gdFree@PLT
.LBB1_65:
	movq	$0, -8(%rbp)
.LBB1_66:
	movq	-8(%rbp), %rax
	addq	$208, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	gdImageCreateFromGd2Ctx, .Lfunc_end1-gdImageCreateFromGd2Ctx
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreateFromGd2Ptr         # -- Begin function gdImageCreateFromGd2Ptr
	.p2align	4, 0x90
	.type	gdImageCreateFromGd2Ptr,@function
gdImageCreateFromGd2Ptr:                # @gdImageCreateFromGd2Ptr
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	%edi, -12(%rbp)
	movq	%rsi, -24(%rbp)
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rsi
	xorl	%edx, %edx
	callq	gdNewDynamicCtxEx@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB2_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB2_3
.LBB2_2:
	movq	-40(%rbp), %rdi
	callq	gdImageCreateFromGd2Ctx@PLT
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-40(%rbp), %rdi
	callq	*%rax
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB2_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	gdImageCreateFromGd2Ptr, .Lfunc_end2-gdImageCreateFromGd2Ptr
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gd2CreateFromFile
	.type	_gd2CreateFromFile,@function
_gd2CreateFromFile:                     # @_gd2CreateFromFile
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	32(%rbp), %rax
	movq	24(%rbp), %rax
	movq	16(%rbp), %rax
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %r8
	movq	-56(%rbp), %r9
	movq	16(%rbp), %r11
	movq	24(%rbp), %r10
	movq	32(%rbp), %rax
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	_gd2GetHeader
	cmpl	$1, %eax
	je	.LBB3_2
# %bb.1:
	jmp	.LBB3_13
.LBB3_2:
	movq	-56(%rbp), %rax
	cmpl	$3, (%rax)
	je	.LBB3_4
# %bb.3:
	movq	-56(%rbp), %rax
	cmpl	$4, (%rax)
	jne	.LBB3_5
.LBB3_4:
	movq	-24(%rbp), %rax
	movl	(%rax), %edi
	movq	-32(%rbp), %rax
	movl	(%rax), %esi
	callq	gdImageCreateTrueColor@PLT
	movq	%rax, -64(%rbp)
	jmp	.LBB3_6
.LBB3_5:
	movq	-24(%rbp), %rax
	movl	(%rax), %edi
	movq	-32(%rbp), %rax
	movl	(%rax), %esi
	callq	gdImageCreate@PLT
	movq	%rax, -64(%rbp)
.LBB3_6:
	cmpq	$0, -64(%rbp)
	jne	.LBB3_8
# %bb.7:
	jmp	.LBB3_12
.LBB3_8:
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rax
	cmpl	$2, (%rax)
	sete	%al
	andb	$1, %al
	movzbl	%al, %edx
	callq	_gdGetColors@PLT
	cmpl	$0, %eax
	jne	.LBB3_10
# %bb.9:
	jmp	.LBB3_11
.LBB3_10:
	movq	-64(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB3_14
.LBB3_11:
	movq	-64(%rbp), %rdi
	callq	gdImageDestroy@PLT
.LBB3_12:
	movq	32(%rbp), %rax
	movq	(%rax), %rdi
	callq	gdFree@PLT
.LBB3_13:
	movq	$0, -8(%rbp)
.LBB3_14:
	movq	-8(%rbp), %rax
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	_gd2CreateFromFile, .Lfunc_end3-_gd2CreateFromFile
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gd2ReadChunk
	.type	_gd2ReadChunk,@function
_gd2ReadChunk:                          # @_gd2ReadChunk
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	movq	-48(%rbp), %rdi
	callq	gdTell@PLT
	movslq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	je	.LBB4_2
# %bb.1:
	movq	-48(%rbp), %rdi
	movl	-8(%rbp), %esi
	callq	gdSeek@PLT
	jmp	.LBB4_3
.LBB4_2:
	jmp	.LBB4_3
.LBB4_3:
	movq	-16(%rbp), %rdi
	movl	-20(%rbp), %esi
	movq	-48(%rbp), %rdx
	callq	gdGetBuf@PLT
	cmpl	-20(%rbp), %eax
	je	.LBB4_5
# %bb.4:
	movl	$0, -4(%rbp)
	jmp	.LBB4_8
.LBB4_5:
	movq	-32(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-16(%rbp), %rdx
	movslq	-20(%rbp), %rcx
	callq	uncompress@PLT
	movl	%eax, -52(%rbp)
	cmpl	$0, -52(%rbp)
	je	.LBB4_7
# %bb.6:
	movl	$0, -4(%rbp)
	jmp	.LBB4_8
.LBB4_7:
	movl	$1, -4(%rbp)
.LBB4_8:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	_gd2ReadChunk, .Lfunc_end4-_gd2ReadChunk
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreateFromGd2Part        # -- Begin function gdImageCreateFromGd2Part
	.p2align	4, 0x90
	.type	gdImageCreateFromGd2Part,@function
gdImageCreateFromGd2Part:               # @gdImageCreateFromGd2Part
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
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -32(%rbp)
	movq	-16(%rbp), %rdi
	callq	gdNewFileCtx@PLT
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB5_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB5_3
.LBB5_2:
	movq	-48(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-32(%rbp), %r8d
	callq	gdImageCreateFromGd2PartCtx@PLT
	movq	%rax, -40(%rbp)
	movq	-48(%rbp), %rax
	movq	48(%rax), %rax
	movq	-48(%rbp), %rdi
	callq	*%rax
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB5_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	gdImageCreateFromGd2Part, .Lfunc_end5-gdImageCreateFromGd2Part
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreateFromGd2PartCtx     # -- Begin function gdImageCreateFromGd2PartCtx
	.p2align	4, 0x90
	.type	gdImageCreateFromGd2PartCtx,@function
gdImageCreateFromGd2PartCtx:            # @gdImageCreateFromGd2PartCtx
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -32(%rbp)
	movq	$0, -136(%rbp)
	movq	$0, -144(%rbp)
	movl	$0, -152(%rbp)
	movl	$0, -164(%rbp)
	movq	$0, -176(%rbp)
	movq	-16(%rbp), %rdi
	leaq	-52(%rbp), %rsi
	leaq	-56(%rbp), %rdx
	leaq	-72(%rbp), %rcx
	leaq	-124(%rbp), %r8
	leaq	-128(%rbp), %r9
	leaq	-64(%rbp), %r11
	leaq	-68(%rbp), %r10
	leaq	-136(%rbp), %rax
	movq	%r11, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%rax, 16(%rsp)
	callq	_gd2GetHeader
	cmpl	$1, %eax
	je	.LBB6_2
# %bb.1:
	jmp	.LBB6_93
.LBB6_2:
	cmpl	$3, -128(%rbp)
	je	.LBB6_4
# %bb.3:
	cmpl	$4, -128(%rbp)
	jne	.LBB6_5
.LBB6_4:
	movl	-28(%rbp), %edi
	movl	-32(%rbp), %esi
	callq	gdImageCreateTrueColor@PLT
	movq	%rax, -184(%rbp)
	jmp	.LBB6_6
.LBB6_5:
	movl	-28(%rbp), %edi
	movl	-32(%rbp), %esi
	callq	gdImageCreate@PLT
	movq	%rax, -184(%rbp)
.LBB6_6:
	cmpq	$0, -184(%rbp)
	jne	.LBB6_8
# %bb.7:
	jmp	.LBB6_93
.LBB6_8:
	movq	-16(%rbp), %rdi
	movq	-184(%rbp), %rsi
	cmpl	$2, -124(%rbp)
	sete	%al
	andb	$1, %al
	movzbl	%al, %edx
	callq	_gdGetColors@PLT
	cmpl	$0, %eax
	jne	.LBB6_10
# %bb.9:
	jmp	.LBB6_92
.LBB6_10:
	movl	-64(%rbp), %eax
	imull	-68(%rbp), %eax
	movl	%eax, -60(%rbp)
	cmpl	$2, -128(%rbp)
	je	.LBB6_12
# %bb.11:
	cmpl	$4, -128(%rbp)
	jne	.LBB6_26
.LBB6_12:
	movl	$0, -168(%rbp)
	movl	$0, -116(%rbp)
.LBB6_13:                               # =>This Inner Loop Header: Depth=1
	movl	-116(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB6_18
# %bb.14:                               #   in Loop: Header=BB6_13 Depth=1
	movq	-136(%rbp), %rax
	movslq	-116(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	cmpl	-168(%rbp), %eax
	jle	.LBB6_16
# %bb.15:                               #   in Loop: Header=BB6_13 Depth=1
	movq	-136(%rbp), %rax
	movslq	-116(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -168(%rbp)
.LBB6_16:                               #   in Loop: Header=BB6_13 Depth=1
	jmp	.LBB6_17
.LBB6_17:                               #   in Loop: Header=BB6_13 Depth=1
	movl	-116(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -116(%rbp)
	jmp	.LBB6_13
.LBB6_18:
	movl	-168(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -168(%rbp)
	movq	-184(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB6_20
# %bb.19:
	movl	-72(%rbp), %eax
	imull	-72(%rbp), %eax
	shll	$2, %eax
	movl	%eax, -152(%rbp)
	jmp	.LBB6_21
.LBB6_20:
	movl	-72(%rbp), %eax
	imull	-72(%rbp), %eax
	movl	%eax, -152(%rbp)
.LBB6_21:
	movslq	-152(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -144(%rbp)
	cmpq	$0, -144(%rbp)
	jne	.LBB6_23
# %bb.22:
	jmp	.LBB6_92
.LBB6_23:
	movslq	-168(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -176(%rbp)
	cmpq	$0, -176(%rbp)
	jne	.LBB6_25
# %bb.24:
	jmp	.LBB6_92
.LBB6_25:
	jmp	.LBB6_26
.LBB6_26:
	movl	-20(%rbp), %eax
	cltd
	idivl	-72(%rbp)
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	cltd
	idivl	-72(%rbp)
	movl	%eax, -40(%rbp)
	cmpl	$0, -36(%rbp)
	jge	.LBB6_28
# %bb.27:
	movl	$0, -36(%rbp)
.LBB6_28:
	cmpl	$0, -40(%rbp)
	jge	.LBB6_30
# %bb.29:
	movl	$0, -40(%rbp)
.LBB6_30:
	movl	-20(%rbp), %eax
	addl	-28(%rbp), %eax
	cltd
	idivl	-72(%rbp)
	movl	%eax, -44(%rbp)
	movl	-24(%rbp), %eax
	addl	-32(%rbp), %eax
	cltd
	idivl	-72(%rbp)
	movl	%eax, -48(%rbp)
	movl	-44(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jl	.LBB6_32
# %bb.31:
	movl	-64(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB6_32:
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB6_34
# %bb.33:
	movl	-68(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
.LBB6_34:
	movq	-16(%rbp), %rdi
	callq	gdTell@PLT
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -108(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB6_35:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_39 Depth 2
                                        #       Child Loop BB6_54 Depth 3
                                        #         Child Loop BB6_56 Depth 4
	movl	-80(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jg	.LBB6_91
# %bb.36:                               #   in Loop: Header=BB6_35 Depth=1
	movl	-80(%rbp), %eax
	imull	-72(%rbp), %eax
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	addl	-72(%rbp), %eax
	movl	%eax, -96(%rbp)
	movl	-96(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jle	.LBB6_38
# %bb.37:                               #   in Loop: Header=BB6_35 Depth=1
	movl	-56(%rbp), %eax
	movl	%eax, -96(%rbp)
.LBB6_38:                               #   in Loop: Header=BB6_35 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -76(%rbp)
.LBB6_39:                               #   Parent Loop BB6_35 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB6_54 Depth 3
                                        #         Child Loop BB6_56 Depth 4
	movl	-76(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jg	.LBB6_89
# %bb.40:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-76(%rbp), %eax
	imull	-72(%rbp), %eax
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	addl	-72(%rbp), %eax
	movl	%eax, -104(%rbp)
	movl	-104(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jle	.LBB6_42
# %bb.41:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-52(%rbp), %eax
	movl	%eax, -104(%rbp)
.LBB6_42:                               #   in Loop: Header=BB6_39 Depth=2
	cmpl	$2, -128(%rbp)
	je	.LBB6_50
# %bb.43:                               #   in Loop: Header=BB6_39 Depth=2
	cmpl	$4, -128(%rbp)
	je	.LBB6_50
# %bb.44:                               #   in Loop: Header=BB6_39 Depth=2
	movq	-184(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB6_46
# %bb.45:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-80(%rbp), %eax
	movl	-72(%rbp), %ecx
	imull	-52(%rbp), %ecx
	imull	%ecx, %eax
	shll	$2, %eax
	movl	-76(%rbp), %ecx
	imull	-72(%rbp), %ecx
	movl	-96(%rbp), %edx
	subl	-92(%rbp), %edx
	imull	%edx, %ecx
	shll	$2, %ecx
	addl	%ecx, %eax
	addl	-108(%rbp), %eax
	movl	%eax, -112(%rbp)
	jmp	.LBB6_47
.LBB6_46:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-80(%rbp), %eax
	movl	-72(%rbp), %ecx
	imull	-52(%rbp), %ecx
	imull	%ecx, %eax
	movl	-76(%rbp), %ecx
	imull	-72(%rbp), %ecx
	movl	-96(%rbp), %edx
	subl	-92(%rbp), %edx
	imull	%edx, %ecx
	addl	%ecx, %eax
	addl	-108(%rbp), %eax
	movl	%eax, -112(%rbp)
.LBB6_47:                               #   in Loop: Header=BB6_39 Depth=2
	movq	-16(%rbp), %rdi
	movl	-112(%rbp), %esi
	callq	gdSeek@PLT
	cmpl	$0, %eax
	jne	.LBB6_49
# %bb.48:
	leaq	.L.str.1(%rip), %rdi
	movb	$0, %al
	callq	gd_error@PLT
	jmp	.LBB6_92
.LBB6_49:                               #   in Loop: Header=BB6_39 Depth=2
	jmp	.LBB6_53
.LBB6_50:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-76(%rbp), %eax
	movl	-80(%rbp), %ecx
	imull	-64(%rbp), %ecx
	addl	%ecx, %eax
	movl	%eax, -148(%rbp)
	movslq	-152(%rbp), %rax
	movq	%rax, -160(%rbp)
	movq	-136(%rbp), %rax
	movslq	-148(%rbp), %rcx
	movl	(%rax,%rcx,8), %edi
	movq	-176(%rbp), %rsi
	movq	-136(%rbp), %rax
	movslq	-148(%rbp), %rcx
	movl	4(%rax,%rcx,8), %edx
	movq	-144(%rbp), %rcx
	movq	-16(%rbp), %r9
	leaq	-160(%rbp), %r8
	callq	_gd2ReadChunk
	cmpl	$0, %eax
	jne	.LBB6_52
# %bb.51:
	leaq	.L.str.2(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	jmp	.LBB6_92
.LBB6_52:                               #   in Loop: Header=BB6_39 Depth=2
	movl	$0, -164(%rbp)
.LBB6_53:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-92(%rbp), %eax
	movl	%eax, -88(%rbp)
.LBB6_54:                               #   Parent Loop BB6_35 Depth=1
                                        #     Parent Loop BB6_39 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB6_56 Depth 4
	movl	-88(%rbp), %eax
	cmpl	-96(%rbp), %eax
	jge	.LBB6_87
# %bb.55:                               #   in Loop: Header=BB6_54 Depth=3
	movl	-100(%rbp), %eax
	movl	%eax, -84(%rbp)
.LBB6_56:                               #   Parent Loop BB6_35 Depth=1
                                        #     Parent Loop BB6_39 Depth=2
                                        #       Parent Loop BB6_54 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-84(%rbp), %eax
	cmpl	-104(%rbp), %eax
	jge	.LBB6_85
# %bb.57:                               #   in Loop: Header=BB6_56 Depth=4
	cmpl	$2, -128(%rbp)
	je	.LBB6_67
# %bb.58:                               #   in Loop: Header=BB6_56 Depth=4
	cmpl	$4, -128(%rbp)
	je	.LBB6_67
# %bb.59:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-184(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB6_63
# %bb.60:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-16(%rbp), %rsi
	leaq	-120(%rbp), %rdi
	callq	gdGetInt@PLT
	cmpl	$0, %eax
	jne	.LBB6_62
# %bb.61:                               #   in Loop: Header=BB6_56 Depth=4
	movl	$0, -120(%rbp)
.LBB6_62:                               #   in Loop: Header=BB6_56 Depth=4
	jmp	.LBB6_66
.LBB6_63:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-16(%rbp), %rdi
	callq	gdGetC@PLT
	movl	%eax, -120(%rbp)
	cmpl	$-1, -120(%rbp)
	jne	.LBB6_65
# %bb.64:                               #   in Loop: Header=BB6_56 Depth=4
	movl	$0, -120(%rbp)
.LBB6_65:                               #   in Loop: Header=BB6_56 Depth=4
	jmp	.LBB6_66
.LBB6_66:                               #   in Loop: Header=BB6_56 Depth=4
	jmp	.LBB6_71
.LBB6_67:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-184(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB6_69
# %bb.68:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-144(%rbp), %rax
	movl	-164(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -164(%rbp)
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	shll	$8, %eax
	movq	-144(%rbp), %rcx
	movl	-164(%rbp), %edx
	movl	%edx, %esi
	addl	$1, %esi
	movl	%esi, -164(%rbp)
	movslq	%edx, %rdx
	movzbl	(%rcx,%rdx), %ecx
	addl	%ecx, %eax
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	shll	$8, %eax
	movq	-144(%rbp), %rcx
	movl	-164(%rbp), %edx
	movl	%edx, %esi
	addl	$1, %esi
	movl	%esi, -164(%rbp)
	movslq	%edx, %rdx
	movzbl	(%rcx,%rdx), %ecx
	addl	%ecx, %eax
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	shll	$8, %eax
	movq	-144(%rbp), %rcx
	movl	-164(%rbp), %edx
	movl	%edx, %esi
	addl	$1, %esi
	movl	%esi, -164(%rbp)
	movslq	%edx, %rdx
	movzbl	(%rcx,%rdx), %ecx
	addl	%ecx, %eax
	movl	%eax, -120(%rbp)
	jmp	.LBB6_70
.LBB6_69:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-144(%rbp), %rax
	movl	-164(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -164(%rbp)
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -120(%rbp)
.LBB6_70:                               #   in Loop: Header=BB6_56 Depth=4
	jmp	.LBB6_71
.LBB6_71:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-84(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.LBB6_83
# %bb.72:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-84(%rbp), %eax
	movl	-20(%rbp), %ecx
	addl	-28(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB6_83
# %bb.73:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-84(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jge	.LBB6_83
# %bb.74:                               #   in Loop: Header=BB6_56 Depth=4
	cmpl	$0, -84(%rbp)
	jl	.LBB6_83
# %bb.75:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-88(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.LBB6_83
# %bb.76:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-88(%rbp), %eax
	movl	-24(%rbp), %ecx
	addl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB6_83
# %bb.77:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-88(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jge	.LBB6_83
# %bb.78:                               #   in Loop: Header=BB6_56 Depth=4
	cmpl	$0, -88(%rbp)
	jl	.LBB6_83
# %bb.79:                               #   in Loop: Header=BB6_56 Depth=4
	movq	-184(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB6_81
# %bb.80:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-120(%rbp), %edx
	movq	-184(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-88(%rbp), %ecx
	subl	-24(%rbp), %ecx
	movslq	%ecx, %rcx
	movq	(%rax,%rcx,8), %rax
	movl	-84(%rbp), %ecx
	subl	-20(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB6_82
.LBB6_81:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-120(%rbp), %eax
	movb	%al, %dl
	movq	-184(%rbp), %rax
	movq	(%rax), %rax
	movl	-88(%rbp), %ecx
	subl	-24(%rbp), %ecx
	movslq	%ecx, %rcx
	movq	(%rax,%rcx,8), %rax
	movl	-84(%rbp), %ecx
	subl	-20(%rbp), %ecx
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
.LBB6_82:                               #   in Loop: Header=BB6_56 Depth=4
	jmp	.LBB6_83
.LBB6_83:                               #   in Loop: Header=BB6_56 Depth=4
	jmp	.LBB6_84
.LBB6_84:                               #   in Loop: Header=BB6_56 Depth=4
	movl	-84(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB6_56
.LBB6_85:                               #   in Loop: Header=BB6_54 Depth=3
	jmp	.LBB6_86
.LBB6_86:                               #   in Loop: Header=BB6_54 Depth=3
	movl	-88(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -88(%rbp)
	jmp	.LBB6_54
.LBB6_87:                               #   in Loop: Header=BB6_39 Depth=2
	jmp	.LBB6_88
.LBB6_88:                               #   in Loop: Header=BB6_39 Depth=2
	movl	-76(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB6_39
.LBB6_89:                               #   in Loop: Header=BB6_35 Depth=1
	jmp	.LBB6_90
.LBB6_90:                               #   in Loop: Header=BB6_35 Depth=1
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB6_35
.LBB6_91:
	movq	-144(%rbp), %rdi
	callq	gdFree@PLT
	movq	-176(%rbp), %rdi
	callq	gdFree@PLT
	movq	-136(%rbp), %rdi
	callq	gdFree@PLT
	movq	-184(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB6_100
.LBB6_92:
	movq	-184(%rbp), %rdi
	callq	gdImageDestroy@PLT
.LBB6_93:
	cmpq	$0, -144(%rbp)
	je	.LBB6_95
# %bb.94:
	movq	-144(%rbp), %rdi
	callq	gdFree@PLT
.LBB6_95:
	cmpq	$0, -176(%rbp)
	je	.LBB6_97
# %bb.96:
	movq	-176(%rbp), %rdi
	callq	gdFree@PLT
.LBB6_97:
	cmpq	$0, -136(%rbp)
	je	.LBB6_99
# %bb.98:
	movq	-136(%rbp), %rdi
	callq	gdFree@PLT
.LBB6_99:
	movq	$0, -8(%rbp)
.LBB6_100:
	movq	-8(%rbp), %rax
	addq	$208, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	gdImageCreateFromGd2PartCtx, .Lfunc_end6-gdImageCreateFromGd2PartCtx
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreateFromGd2PartPtr     # -- Begin function gdImageCreateFromGd2PartPtr
	.p2align	4, 0x90
	.type	gdImageCreateFromGd2PartPtr,@function
gdImageCreateFromGd2PartPtr:            # @gdImageCreateFromGd2PartPtr
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	%edi, -12(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	%ecx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movl	%r9d, -40(%rbp)
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rsi
	xorl	%edx, %edx
	callq	gdNewDynamicCtxEx@PLT
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB7_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB7_3
.LBB7_2:
	movq	-56(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	movl	-36(%rbp), %ecx
	movl	-40(%rbp), %r8d
	callq	gdImageCreateFromGd2PartCtx@PLT
	movq	%rax, -48(%rbp)
	movq	-56(%rbp), %rax
	movq	48(%rax), %rax
	movq	-56(%rbp), %rdi
	callq	*%rax
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB7_3:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	gdImageCreateFromGd2PartPtr, .Lfunc_end7-gdImageCreateFromGd2PartPtr
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gd2GetHeader
	.type	_gd2GetHeader,@function
_gd2GetHeader:                          # @_gd2GetHeader
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	32(%rbp), %rax
	movq	24(%rbp), %rax
	movq	16(%rbp), %rax
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	movl	$0, -60(%rbp)
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	cmpl	$4, -60(%rbp)
	jge	.LBB8_6
# %bb.2:                                #   in Loop: Header=BB8_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	gdGetC@PLT
	movl	%eax, -64(%rbp)
	cmpl	$-1, -64(%rbp)
	jne	.LBB8_4
# %bb.3:
	jmp	.LBB8_59
.LBB8_4:                                #   in Loop: Header=BB8_1 Depth=1
	movl	-64(%rbp), %eax
	movb	%al, %cl
	movslq	-60(%rbp), %rax
	movb	%cl, -69(%rbp,%rax)
# %bb.5:                                #   in Loop: Header=BB8_1 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB8_1
.LBB8_6:
	movb	$0, -65(%rbp)
	leaq	-69(%rbp), %rdi
	leaq	.L.str.3(%rip), %rsi
	callq	strcmp@PLT
	cmpl	$0, %eax
	je	.LBB8_8
# %bb.7:
	jmp	.LBB8_59
.LBB8_8:
	movq	-48(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$1, %eax
	je	.LBB8_10
# %bb.9:
	jmp	.LBB8_59
.LBB8_10:
	movq	-48(%rbp), %rax
	cmpl	$1, (%rax)
	je	.LBB8_13
# %bb.11:
	movq	-48(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB8_13
# %bb.12:
	jmp	.LBB8_59
.LBB8_13:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$0, %eax
	jne	.LBB8_15
# %bb.14:
	jmp	.LBB8_59
.LBB8_15:
	movq	-32(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$0, %eax
	jne	.LBB8_17
# %bb.16:
	jmp	.LBB8_59
.LBB8_17:
	movq	-40(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$1, %eax
	je	.LBB8_19
# %bb.18:
	jmp	.LBB8_59
.LBB8_19:
	movq	-40(%rbp), %rax
	cmpl	$64, (%rax)
	jl	.LBB8_21
# %bb.20:
	movq	-40(%rbp), %rax
	cmpl	$4096, (%rax)                   # imm = 0x1000
	jle	.LBB8_22
.LBB8_21:
	jmp	.LBB8_59
.LBB8_22:
	movq	-56(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$1, %eax
	je	.LBB8_24
# %bb.23:
	jmp	.LBB8_59
.LBB8_24:
	movq	-56(%rbp), %rax
	cmpl	$1, (%rax)
	je	.LBB8_29
# %bb.25:
	movq	-56(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB8_29
# %bb.26:
	movq	-56(%rbp), %rax
	cmpl	$3, (%rax)
	je	.LBB8_29
# %bb.27:
	movq	-56(%rbp), %rax
	cmpl	$4, (%rax)
	je	.LBB8_29
# %bb.28:
	jmp	.LBB8_59
.LBB8_29:
	movq	16(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$1, %eax
	je	.LBB8_31
# %bb.30:
	jmp	.LBB8_59
.LBB8_31:
	movq	24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetWord@PLT
	cmpl	$1, %eax
	je	.LBB8_33
# %bb.32:
	jmp	.LBB8_59
.LBB8_33:
	movq	-56(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB8_35
# %bb.34:
	movq	-56(%rbp), %rax
	cmpl	$4, (%rax)
	jne	.LBB8_57
.LBB8_35:
	movq	16(%rbp), %rax
	cmpl	$0, (%rax)
	jle	.LBB8_38
# %bb.36:
	movq	24(%rbp), %rax
	cmpl	$0, (%rax)
	jle	.LBB8_38
# %bb.37:
	movq	16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
	movq	24(%rbp), %rcx
	movl	$2147483647, %eax               # imm = 0x7FFFFFFF
	cltd
	idivl	(%rcx)
	movl	%eax, %ecx
	movl	-92(%rbp), %eax                 # 4-byte Reload
	cmpl	%ecx, %eax
	jle	.LBB8_39
.LBB8_38:
	jmp	.LBB8_59
.LBB8_39:
	movq	16(%rbp), %rax
	movl	(%rax), %eax
	movq	24(%rbp), %rcx
	imull	(%rcx), %eax
	movl	%eax, -88(%rbp)
	movl	-88(%rbp), %esi
	movl	$8, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB8_41
# %bb.40:
	jmp	.LBB8_59
.LBB8_41:
	movslq	-88(%rbp), %rax
	shlq	$3, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -84(%rbp)
	cmpl	$0, -84(%rbp)
	jg	.LBB8_43
# %bb.42:
	jmp	.LBB8_59
.LBB8_43:
	movslq	-84(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -80(%rbp)
	cmpq	$0, -80(%rbp)
	jne	.LBB8_45
# %bb.44:
	jmp	.LBB8_59
.LBB8_45:
	movl	$0, -60(%rbp)
.LBB8_46:                               # =>This Inner Loop Header: Depth=1
	movl	-60(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jge	.LBB8_56
# %bb.47:                               #   in Loop: Header=BB8_46 Depth=1
	movq	-80(%rbp), %rdi
	movslq	-60(%rbp), %rax
	shlq	$3, %rax
	addq	%rax, %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetInt@PLT
	cmpl	$1, %eax
	je	.LBB8_49
# %bb.48:
	jmp	.LBB8_58
.LBB8_49:                               #   in Loop: Header=BB8_46 Depth=1
	movq	-80(%rbp), %rdi
	movslq	-60(%rbp), %rax
	shlq	$3, %rax
	addq	%rax, %rdi
	addq	$4, %rdi
	movq	-16(%rbp), %rsi
	callq	gdGetInt@PLT
	cmpl	$1, %eax
	je	.LBB8_51
# %bb.50:
	jmp	.LBB8_58
.LBB8_51:                               #   in Loop: Header=BB8_46 Depth=1
	movq	-80(%rbp), %rax
	movslq	-60(%rbp), %rcx
	cmpl	$0, (%rax,%rcx,8)
	jl	.LBB8_53
# %bb.52:                               #   in Loop: Header=BB8_46 Depth=1
	movq	-80(%rbp), %rax
	movslq	-60(%rbp), %rcx
	cmpl	$0, 4(%rax,%rcx,8)
	jge	.LBB8_54
.LBB8_53:
	jmp	.LBB8_58
.LBB8_54:                               #   in Loop: Header=BB8_46 Depth=1
	jmp	.LBB8_55
.LBB8_55:                               #   in Loop: Header=BB8_46 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB8_46
.LBB8_56:
	movq	-80(%rbp), %rcx
	movq	32(%rbp), %rax
	movq	%rcx, (%rax)
.LBB8_57:
	movl	$1, -4(%rbp)
	jmp	.LBB8_60
.LBB8_58:
	movq	-80(%rbp), %rdi
	callq	gdFree@PLT
.LBB8_59:
	movl	$0, -4(%rbp)
.LBB8_60:
	movl	-4(%rbp), %eax
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	_gd2GetHeader, .Lfunc_end8-_gd2GetHeader
	.cfi_endproc
                                        # -- End function
	.globl	gdImageGd2                      # -- Begin function gdImageGd2
	.p2align	4, 0x90
	.type	gdImageGd2,@function
gdImageGd2:                             # @gdImageGd2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movq	-16(%rbp), %rdi
	callq	gdNewFileCtx@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB9_2
# %bb.1:
	jmp	.LBB9_3
.LBB9_2:
	movq	-8(%rbp), %rdi
	movq	-32(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	_gdImageGd2
	movq	-32(%rbp), %rax
	movq	48(%rax), %rax
	movq	-32(%rbp), %rdi
	callq	*%rax
.LBB9_3:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	gdImageGd2, .Lfunc_end9-gdImageGd2
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _gdImageGd2
.LCPI10_0:
	.quad	0x3ff051eb851eb852              # double 1.02
.LCPI10_1:
	.quad	0x4028000000000000              # double 12
	.text
	.p2align	4, 0x90
	.type	_gdImageGd2,@function
_gdImageGd2:                            # @_gdImageGd2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	$0, -72(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -88(%rbp)
	movl	$0, -100(%rbp)
	movq	$0, -112(%rbp)
	movq	-8(%rbp), %rax
	movl	7248(%rax), %edx
	movl	$1, %eax
	movl	$4, %ecx
	cmpl	$0, %edx
	cmovnel	%ecx, %eax
	movl	%eax, -120(%rbp)
	movl	$0, -124(%rbp)
	cmpl	$1, -24(%rbp)
	je	.LBB10_3
# %bb.1:
	cmpl	$2, -24(%rbp)
	je	.LBB10_3
# %bb.2:
	movl	$2, -24(%rbp)
.LBB10_3:
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB10_5
# %bb.4:
	movl	-24(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -24(%rbp)
.LBB10_5:
	cmpl	$0, -20(%rbp)
	jne	.LBB10_7
# %bb.6:
	movl	$128, -20(%rbp)
	jmp	.LBB10_13
.LBB10_7:
	cmpl	$64, -20(%rbp)
	jge	.LBB10_9
# %bb.8:
	movl	$64, -20(%rbp)
	jmp	.LBB10_12
.LBB10_9:
	cmpl	$4096, -20(%rbp)                # imm = 0x1000
	jle	.LBB10_11
# %bb.10:
	movl	$4096, -20(%rbp)                # imm = 0x1000
.LBB10_11:
	jmp	.LBB10_12
.LBB10_12:
	jmp	.LBB10_13
.LBB10_13:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	addl	-20(%rbp), %eax
	subl	$1, %eax
	cltd
	idivl	-20(%rbp)
	movl	%eax, -28(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	addl	-20(%rbp), %eax
	subl	$1, %eax
	cltd
	idivl	-20(%rbp)
	movl	%eax, -32(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movl	-28(%rbp), %r8d
	movl	-32(%rbp), %r9d
	callq	_gd2PutHeader
	cmpl	$2, -24(%rbp)
	je	.LBB10_15
# %bb.14:
	cmpl	$4, -24(%rbp)
	jne	.LBB10_22
.LBB10_15:
	movl	-20(%rbp), %eax
	imull	-120(%rbp), %eax
	imull	-20(%rbp), %eax
	cvtsi2sd	%eax, %xmm0
	movsd	.LCPI10_0(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm1, %xmm0
	movsd	.LCPI10_1(%rip), %xmm1          # xmm1 = mem[0],zero
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -124(%rbp)
	movl	-20(%rbp), %eax
	imull	-120(%rbp), %eax
	imull	-20(%rbp), %eax
	movslq	%eax, %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -80(%rbp)
	cmpq	$0, -80(%rbp)
	jne	.LBB10_17
# %bb.16:
	jmp	.LBB10_72
.LBB10_17:
	movslq	-124(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -88(%rbp)
	cmpq	$0, -88(%rbp)
	jne	.LBB10_19
# %bb.18:
	jmp	.LBB10_72
.LBB10_19:
	movq	-16(%rbp), %rdi
	callq	gdTell@PLT
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -100(%rbp)
	movl	-28(%rbp), %eax
	imull	-32(%rbp), %eax
	cltq
	shlq	$3, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -104(%rbp)
	movq	-16(%rbp), %rdi
	movl	-100(%rbp), %esi
	addl	-104(%rbp), %esi
	callq	gdSeek@PLT
	movslq	-104(%rbp), %rdi
	shlq	$3, %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -112(%rbp)
	cmpq	$0, -112(%rbp)
	jne	.LBB10_21
# %bb.20:
	jmp	.LBB10_72
.LBB10_21:
	jmp	.LBB10_22
.LBB10_22:
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	_gdPutColors@PLT
	movl	$0, -40(%rbp)
.LBB10_23:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB10_25 Depth 2
                                        #       Child Loop BB10_29 Depth 3
                                        #         Child Loop BB10_43 Depth 4
                                        #         Child Loop BB10_35 Depth 4
	movl	-40(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB10_64
# %bb.24:                               #   in Loop: Header=BB10_23 Depth=1
	movl	$0, -36(%rbp)
.LBB10_25:                              #   Parent Loop BB10_23 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB10_29 Depth 3
                                        #         Child Loop BB10_43 Depth 4
                                        #         Child Loop BB10_35 Depth 4
	movl	-36(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB10_62
# %bb.26:                               #   in Loop: Header=BB10_25 Depth=2
	movl	-40(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	addl	-20(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jle	.LBB10_28
# %bb.27:                               #   in Loop: Header=BB10_25 Depth=2
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -56(%rbp)
.LBB10_28:                              #   in Loop: Header=BB10_25 Depth=2
	movl	$0, -68(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB10_29:                              #   Parent Loop BB10_23 Depth=1
                                        #     Parent Loop BB10_25 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB10_43 Depth 4
                                        #         Child Loop BB10_35 Depth 4
	movl	-48(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jge	.LBB10_52
# %bb.30:                               #   in Loop: Header=BB10_29 Depth=3
	movl	-36(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	addl	-20(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-64(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jle	.LBB10_32
# %bb.31:                               #   in Loop: Header=BB10_29 Depth=3
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -64(%rbp)
.LBB10_32:                              #   in Loop: Header=BB10_29 Depth=3
	cmpl	$2, -24(%rbp)
	je	.LBB10_34
# %bb.33:                               #   in Loop: Header=BB10_29 Depth=3
	cmpl	$4, -24(%rbp)
	jne	.LBB10_42
.LBB10_34:                              #   in Loop: Header=BB10_29 Depth=3
	movl	-60(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB10_35:                              #   Parent Loop BB10_23 Depth=1
                                        #     Parent Loop BB10_25 Depth=2
                                        #       Parent Loop BB10_29 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-44(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB10_41
# %bb.36:                               #   in Loop: Header=BB10_35 Depth=4
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB10_38
# %bb.37:                               #   in Loop: Header=BB10_35 Depth=4
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-48(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -128(%rbp)
	movl	-128(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movb	%al, %dl
	movq	-80(%rbp), %rax
	movl	-68(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -68(%rbp)
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	movl	-128(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movb	%al, %dl
	movq	-80(%rbp), %rax
	movl	-68(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -68(%rbp)
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	movl	-128(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movb	%al, %dl
	movq	-80(%rbp), %rax
	movl	-68(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -68(%rbp)
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	movl	-128(%rbp), %eax
	andl	$255, %eax
	movb	%al, %dl
	movq	-80(%rbp), %rax
	movl	-68(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -68(%rbp)
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	jmp	.LBB10_39
.LBB10_38:                              #   in Loop: Header=BB10_35 Depth=4
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-48(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-44(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -132(%rbp)
	movl	-132(%rbp), %eax
	movb	%al, %dl
	movq	-80(%rbp), %rax
	movl	-68(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -68(%rbp)
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
.LBB10_39:                              #   in Loop: Header=BB10_35 Depth=4
	jmp	.LBB10_40
.LBB10_40:                              #   in Loop: Header=BB10_35 Depth=4
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB10_35
.LBB10_41:                              #   in Loop: Header=BB10_29 Depth=3
	jmp	.LBB10_50
.LBB10_42:                              #   in Loop: Header=BB10_29 Depth=3
	movl	-60(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB10_43:                              #   Parent Loop BB10_23 Depth=1
                                        #     Parent Loop BB10_25 Depth=2
                                        #       Parent Loop BB10_29 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-44(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB10_49
# %bb.44:                               #   in Loop: Header=BB10_43 Depth=4
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB10_46
# %bb.45:                               #   in Loop: Header=BB10_43 Depth=4
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-48(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutInt@PLT
	jmp	.LBB10_47
.LBB10_46:                              #   in Loop: Header=BB10_43 Depth=4
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-48(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-44(%rbp), %rcx
	movb	(%rax,%rcx), %al
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	gdPutC@PLT
.LBB10_47:                              #   in Loop: Header=BB10_43 Depth=4
	jmp	.LBB10_48
.LBB10_48:                              #   in Loop: Header=BB10_43 Depth=4
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB10_43
.LBB10_49:                              #   in Loop: Header=BB10_29 Depth=3
	jmp	.LBB10_50
.LBB10_50:                              #   in Loop: Header=BB10_29 Depth=3
	jmp	.LBB10_51
.LBB10_51:                              #   in Loop: Header=BB10_29 Depth=3
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB10_29
.LBB10_52:                              #   in Loop: Header=BB10_25 Depth=2
	cmpl	$2, -24(%rbp)
	je	.LBB10_54
# %bb.53:                               #   in Loop: Header=BB10_25 Depth=2
	cmpl	$4, -24(%rbp)
	jne	.LBB10_60
.LBB10_54:                              #   in Loop: Header=BB10_25 Depth=2
	movslq	-124(%rbp), %rax
	movq	%rax, -96(%rbp)
	movq	-88(%rbp), %rdi
	movq	-80(%rbp), %rdx
	movslq	-68(%rbp), %rcx
	leaq	-96(%rbp), %rsi
	callq	compress@PLT
	cmpl	$0, %eax
	je	.LBB10_56
# %bb.55:                               #   in Loop: Header=BB10_25 Depth=2
	leaq	.L.str.4(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	jmp	.LBB10_59
.LBB10_56:                              #   in Loop: Header=BB10_25 Depth=2
	movq	-16(%rbp), %rdi
	callq	gdTell@PLT
	movl	%eax, %edx
	movq	-112(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	%edx, (%rax,%rcx,8)
	movq	-96(%rbp), %rax
	movl	%eax, %edx
	movq	-112(%rbp), %rax
	movl	-72(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -72(%rbp)
	movslq	%ecx, %rcx
	movl	%edx, 4(%rax,%rcx,8)
	movq	-88(%rbp), %rdi
	movq	-96(%rbp), %rax
	movl	%eax, %esi
	movq	-16(%rbp), %rdx
	callq	gdPutBuf@PLT
	cmpl	$0, %eax
	jg	.LBB10_58
# %bb.57:                               #   in Loop: Header=BB10_25 Depth=2
	leaq	.L.str.5(%rip), %rdi
	movb	$0, %al
	callq	gd_error@PLT
.LBB10_58:                              #   in Loop: Header=BB10_25 Depth=2
	jmp	.LBB10_59
.LBB10_59:                              #   in Loop: Header=BB10_25 Depth=2
	jmp	.LBB10_60
.LBB10_60:                              #   in Loop: Header=BB10_25 Depth=2
	jmp	.LBB10_61
.LBB10_61:                              #   in Loop: Header=BB10_25 Depth=2
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB10_25
.LBB10_62:                              #   in Loop: Header=BB10_23 Depth=1
	jmp	.LBB10_63
.LBB10_63:                              #   in Loop: Header=BB10_23 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB10_23
.LBB10_64:
	cmpl	$2, -24(%rbp)
	je	.LBB10_66
# %bb.65:
	cmpl	$4, -24(%rbp)
	jne	.LBB10_71
.LBB10_66:
	movq	-16(%rbp), %rdi
	callq	gdTell@PLT
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -116(%rbp)
	movq	-16(%rbp), %rdi
	movl	-100(%rbp), %esi
	callq	gdSeek@PLT
	movl	$0, -44(%rbp)
.LBB10_67:                              # =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jge	.LBB10_70
# %bb.68:                               #   in Loop: Header=BB10_67 Depth=1
	movq	-112(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,8), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutInt@PLT
	movq	-112(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	4(%rax,%rcx,8), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutInt@PLT
# %bb.69:                               #   in Loop: Header=BB10_67 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB10_67
.LBB10_70:
	movq	-16(%rbp), %rdi
	movl	-116(%rbp), %esi
	callq	gdSeek@PLT
.LBB10_71:
	jmp	.LBB10_72
.LBB10_72:
	cmpq	$0, -80(%rbp)
	je	.LBB10_74
# %bb.73:
	movq	-80(%rbp), %rdi
	callq	gdFree@PLT
.LBB10_74:
	cmpq	$0, -88(%rbp)
	je	.LBB10_76
# %bb.75:
	movq	-88(%rbp), %rdi
	callq	gdFree@PLT
.LBB10_76:
	cmpq	$0, -112(%rbp)
	je	.LBB10_78
# %bb.77:
	movq	-112(%rbp), %rdi
	callq	gdFree@PLT
.LBB10_78:
	addq	$144, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	_gdImageGd2, .Lfunc_end10-_gdImageGd2
	.cfi_endproc
                                        # -- End function
	.globl	gdImageGd2Ptr                   # -- Begin function gdImageGd2Ptr
	.p2align	4, 0x90
	.type	gdImageGd2Ptr,@function
gdImageGd2Ptr:                          # @gdImageGd2Ptr
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
	movl	%edx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	$2048, %edi                     # imm = 0x800
	xorl	%eax, %eax
	movl	%eax, %esi
	callq	gdNewDynamicCtx@PLT
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB11_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB11_3
.LBB11_2:
	movq	-16(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	_gdImageGd2
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	gdDPExtractData@PLT
	movq	%rax, -40(%rbp)
	movq	-48(%rbp), %rax
	movq	48(%rax), %rax
	movq	-48(%rbp), %rdi
	callq	*%rax
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB11_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	gdImageGd2Ptr, .Lfunc_end11-gdImageGd2Ptr
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gd2PutHeader
	.type	_gd2PutHeader,@function
_gd2PutHeader:                          # @_gd2PutHeader
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movl	$0, -36(%rbp)
.LBB12_1:                               # =>This Inner Loop Header: Depth=1
	cmpl	$4, -36(%rbp)
	jge	.LBB12_4
# %bb.2:                                #   in Loop: Header=BB12_1 Depth=1
	movslq	-36(%rbp), %rcx
	leaq	.L.str.3(%rip), %rax
	movb	(%rax,%rcx), %al
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	gdPutC@PLT
# %bb.3:                                #   in Loop: Header=BB12_1 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB12_1
.LBB12_4:
	movq	-16(%rbp), %rsi
	movl	$2, %edi
	callq	gdPutWord@PLT
	movq	-8(%rbp), %rax
	movl	8(%rax), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutWord@PLT
	movq	-8(%rbp), %rax
	movl	12(%rax), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutWord@PLT
	movl	-20(%rbp), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutWord@PLT
	movl	-24(%rbp), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutWord@PLT
	movl	-28(%rbp), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutWord@PLT
	movl	-32(%rbp), %edi
	movq	-16(%rbp), %rsi
	callq	gdPutWord@PLT
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	_gd2PutHeader, .Lfunc_end12-_gd2PutHeader
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"gd2: EOF while reading\n"
	.size	.L.str, 24

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Seek error\n"
	.size	.L.str.1, 12

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"Error reading comproessed chunk\n"
	.size	.L.str.2, 33

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"gd2"
	.size	.L.str.3, 4

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"Error from compressing\n"
	.size	.L.str.4, 24

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"gd write error\n"
	.size	.L.str.5, 16

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gdNewFileCtx
	.addrsig_sym gdImageCreateFromGd2Ctx
	.addrsig_sym gdNewDynamicCtxEx
	.addrsig_sym _gd2CreateFromFile
	.addrsig_sym gdCalloc
	.addrsig_sym _gd2ReadChunk
	.addrsig_sym gdGetInt
	.addrsig_sym gd_error
	.addrsig_sym gdImageDestroy
	.addrsig_sym gdGetByte
	.addrsig_sym gdFree
	.addrsig_sym gdImageCreateFromGd2PartCtx
	.addrsig_sym _gd2GetHeader
	.addrsig_sym gdImageCreateTrueColor
	.addrsig_sym gdImageCreate
	.addrsig_sym _gdGetColors
	.addrsig_sym gdTell
	.addrsig_sym gdSeek
	.addrsig_sym printf
	.addrsig_sym gdGetC
	.addrsig_sym _gdImageGd2
	.addrsig_sym gdNewDynamicCtx
	.addrsig_sym gdDPExtractData
	.addrsig_sym gdGetBuf
	.addrsig_sym uncompress
	.addrsig_sym strcmp
	.addrsig_sym gdGetWord
	.addrsig_sym overflow2
	.addrsig_sym _gd2PutHeader
	.addrsig_sym _gdPutColors
	.addrsig_sym gdPutInt
	.addrsig_sym gdPutC
	.addrsig_sym compress
	.addrsig_sym gdPutBuf
	.addrsig_sym gdPutWord
