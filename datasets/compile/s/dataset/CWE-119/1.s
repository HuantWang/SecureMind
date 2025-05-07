	.text
	.file	"gd.c"
	.globl	gd_stderr_error                 # -- Begin function gd_stderr_error
	.p2align	4, 0x90
	.type	gd_stderr_error,@function
gd_stderr_error:                        # @gd_stderr_error
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movl	-4(%rbp), %eax
	addl	$-3, %eax
	movl	%eax, %ecx
	movq	%rcx, -32(%rbp)                 # 8-byte Spill
	subl	$4, %eax
	ja	.LBB0_6
# %bb.7:
	movq	-32(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI0_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB0_1:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	leaq	.L.str(%rip), %rdi
	callq	fputs@PLT
	jmp	.LBB0_6
.LBB0_2:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	leaq	.L.str.1(%rip), %rdi
	callq	fputs@PLT
	jmp	.LBB0_6
.LBB0_3:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	leaq	.L.str.2(%rip), %rdi
	callq	fputs@PLT
	jmp	.LBB0_6
.LBB0_4:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	leaq	.L.str.3(%rip), %rdi
	callq	fputs@PLT
	jmp	.LBB0_6
.LBB0_5:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	leaq	.L.str.4(%rip), %rdi
	callq	fputs@PLT
.LBB0_6:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	callq	vfprintf@PLT
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	callq	fflush@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	gd_stderr_error, .Lfunc_end0-gd_stderr_error
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI0_0:
	.long	.LBB0_1-.LJTI0_0
	.long	.LBB0_2-.LJTI0_0
	.long	.LBB0_3-.LJTI0_0
	.long	.LBB0_4-.LJTI0_0
	.long	.LBB0_5-.LJTI0_0
                                        # -- End function
	.text
	.globl	gd_error                        # -- Begin function gd_error
	.p2align	4, 0x90
	.type	gd_error,@function
gd_error:                               # @gd_error
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	testb	%al, %al
	je	.LBB1_2
# %bb.1:
	movaps	%xmm0, -160(%rbp)
	movaps	%xmm1, -144(%rbp)
	movaps	%xmm2, -128(%rbp)
	movaps	%xmm3, -112(%rbp)
	movaps	%xmm4, -96(%rbp)
	movaps	%xmm5, -80(%rbp)
	movaps	%xmm6, -64(%rbp)
	movaps	%xmm7, -48(%rbp)
.LBB1_2:
	movq	%r9, -168(%rbp)
	movq	%r8, -176(%rbp)
	movq	%rcx, -184(%rbp)
	movq	%rdx, -192(%rbp)
	movq	%rsi, -200(%rbp)
	movq	%rdi, -8(%rbp)
	leaq	-208(%rbp), %rax
	movq	%rax, -16(%rbp)
	leaq	16(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	$48, -28(%rbp)
	movl	$8, -32(%rbp)
	movq	-8(%rbp), %rsi
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	movl	$4, %edi
	leaq	-32(%rbp), %rdx
	callq	gd_error_ex
	addq	$208, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	gd_error, .Lfunc_end1-gd_error
	.cfi_endproc
                                        # -- End function
	.globl	gd_error_ex                     # -- Begin function gd_error_ex
	.p2align	4, 0x90
	.type	gd_error_ex,@function
gd_error_ex:                            # @gd_error_ex
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$224, %rsp
	testb	%al, %al
	je	.LBB2_4
# %bb.3:
	movaps	%xmm0, -176(%rbp)
	movaps	%xmm1, -160(%rbp)
	movaps	%xmm2, -144(%rbp)
	movaps	%xmm3, -128(%rbp)
	movaps	%xmm4, -112(%rbp)
	movaps	%xmm5, -96(%rbp)
	movaps	%xmm6, -80(%rbp)
	movaps	%xmm7, -64(%rbp)
.LBB2_4:
	movq	%r9, -184(%rbp)
	movq	%r8, -192(%rbp)
	movq	%rcx, -200(%rbp)
	movq	%rdx, -208(%rbp)
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	-48(%rbp), %rax
	leaq	-224(%rbp), %rcx
	movq	%rcx, 16(%rax)
	leaq	16(%rbp), %rcx
	movq	%rcx, 8(%rax)
	movl	$48, 4(%rax)
	movl	$16, (%rax)
	cmpq	$0, gd_error_method(%rip)
	je	.LBB2_2
# %bb.1:
	movq	gd_error_method(%rip), %rax
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	callq	*%rax
.LBB2_2:
	addq	$224, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	gd_error_ex, .Lfunc_end2-gd_error_ex
	.cfi_endproc
                                        # -- End function
	.globl	gdSetErrorMethod                # -- Begin function gdSetErrorMethod
	.p2align	4, 0x90
	.type	gdSetErrorMethod,@function
gdSetErrorMethod:                       # @gdSetErrorMethod
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, gd_error_method(%rip)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	gdSetErrorMethod, .Lfunc_end3-gdSetErrorMethod
	.cfi_endproc
                                        # -- End function
	.globl	gdClearErrorMethod              # -- Begin function gdClearErrorMethod
	.p2align	4, 0x90
	.type	gdClearErrorMethod,@function
gdClearErrorMethod:                     # @gdClearErrorMethod
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	leaq	gd_stderr_error(%rip), %rax
	movq	%rax, gd_error_method(%rip)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	gdClearErrorMethod, .Lfunc_end4-gdClearErrorMethod
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreate                   # -- Begin function gdImageCreate
	.p2align	4, 0x90
	.type	gdImageCreate,@function
gdImageCreate:                          # @gdImageCreate
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -12(%rbp)
	movl	%esi, -16(%rbp)
	movl	-16(%rbp), %esi
	movl	$8, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB5_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB5_23
.LBB5_2:
	movl	-12(%rbp), %esi
	movl	$8, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB5_4
# %bb.3:
	movq	$0, -8(%rbp)
	jmp	.LBB5_23
.LBB5_4:
	movl	$1, %edi
	movl	$7336, %esi                     # imm = 0x1CA8
	callq	gdCalloc@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB5_6
# %bb.5:
	movq	$0, -8(%rbp)
	jmp	.LBB5_23
.LBB5_6:
	movslq	-16(%rbp), %rdi
	shlq	$3, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB5_8
# %bb.7:
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB5_23
.LBB5_8:
	movq	-32(%rbp), %rax
	movq	$0, 4120(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 4128(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 4136(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 4144(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 6208(%rax)
	movl	$0, -20(%rbp)
.LBB5_9:                                # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB5_18
# %bb.10:                               #   in Loop: Header=BB5_9 Depth=1
	movslq	-12(%rbp), %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movslq	-20(%rbp), %rcx
	movq	%rdx, (%rax,%rcx,8)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movslq	-20(%rbp), %rcx
	cmpq	$0, (%rax,%rcx,8)
	jne	.LBB5_16
# %bb.11:
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
.LBB5_12:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -20(%rbp)
	jl	.LBB5_15
# %bb.13:                               #   in Loop: Header=BB5_12 Depth=1
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movslq	-20(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.14:                               #   in Loop: Header=BB5_12 Depth=1
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB5_12
.LBB5_15:
	movq	-32(%rbp), %rax
	movq	(%rax), %rdi
	callq	gdFree@PLT
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB5_23
.LBB5_16:                               #   in Loop: Header=BB5_9 Depth=1
	jmp	.LBB5_17
.LBB5_17:                               #   in Loop: Header=BB5_9 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB5_9
.LBB5_18:
	movl	-12(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 8(%rax)
	movl	-16(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 16(%rax)
	movq	-32(%rbp), %rax
	movl	$-1, 4116(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 6216(%rax)
	movq	-32(%rbp), %rax
	movl	$1, 6220(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7272(%rax)
	movl	$0, -20(%rbp)
.LBB5_19:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -20(%rbp)                 # imm = 0x100
	jge	.LBB5_22
# %bb.20:                               #   in Loop: Header=BB5_19 Depth=1
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$1, 3092(%rax,%rcx,4)
# %bb.21:                               #   in Loop: Header=BB5_19 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB5_19
.LBB5_22:
	movq	-32(%rbp), %rax
	movl	$0, 7248(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 7256(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7284(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7288(%rax)
	movq	-32(%rbp), %rax
	movl	8(%rax), %ecx
	subl	$1, %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 7292(%rax)
	movq	-32(%rbp), %rax
	movl	12(%rax), %ecx
	subl	$1, %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 7296(%rax)
	movq	-32(%rbp), %rax
	movl	$96, 7300(%rax)
	movq	-32(%rbp), %rax
	movl	$96, 7304(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 7328(%rax)
	movq	-32(%rbp), %rax
	movl	$3, 7324(%rax)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB5_23:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	gdImageCreate, .Lfunc_end5-gdImageCreate
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCreateTrueColor          # -- Begin function gdImageCreateTrueColor
	.p2align	4, 0x90
	.type	gdImageCreateTrueColor,@function
gdImageCreateTrueColor:                 # @gdImageCreateTrueColor
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -12(%rbp)
	movl	%esi, -16(%rbp)
	movl	-12(%rbp), %edi
	movl	-16(%rbp), %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB6_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB6_20
.LBB6_2:
	movl	-16(%rbp), %esi
	movl	$8, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB6_4
# %bb.3:
	movq	$0, -8(%rbp)
	jmp	.LBB6_20
.LBB6_4:
	movl	-12(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB6_6
# %bb.5:
	movq	$0, -8(%rbp)
	jmp	.LBB6_20
.LBB6_6:
	movl	$7336, %edi                     # imm = 0x1CA8
	callq	gdMalloc@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB6_8
# %bb.7:
	movq	$0, -8(%rbp)
	jmp	.LBB6_20
.LBB6_8:
	movq	-32(%rbp), %rdi
	xorl	%esi, %esi
	movl	$7336, %edx                     # imm = 0x1CA8
	callq	memset@PLT
	movslq	-16(%rbp), %rdi
	shlq	$3, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 7256(%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, 7256(%rax)
	jne	.LBB6_10
# %bb.9:
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB6_20
.LBB6_10:
	movq	-32(%rbp), %rax
	movq	$0, 4120(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 4128(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 4136(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 4144(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 6208(%rax)
	movl	$0, -20(%rbp)
.LBB6_11:                               # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB6_19
# %bb.12:                               #   in Loop: Header=BB6_11 Depth=1
	movslq	-12(%rbp), %rdi
	movl	$4, %esi
	callq	gdCalloc@PLT
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-20(%rbp), %rcx
	movq	%rdx, (%rax,%rcx,8)
	movq	-32(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-20(%rbp), %rcx
	cmpq	$0, (%rax,%rcx,8)
	jne	.LBB6_17
# %bb.13:
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
.LBB6_14:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -20(%rbp)
	jl	.LBB6_16
# %bb.15:                               #   in Loop: Header=BB6_14 Depth=1
	movq	-32(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-20(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB6_14
.LBB6_16:
	movq	-32(%rbp), %rax
	movq	7256(%rax), %rdi
	callq	gdFree@PLT
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB6_20
.LBB6_17:                               #   in Loop: Header=BB6_11 Depth=1
	jmp	.LBB6_18
.LBB6_18:                               #   in Loop: Header=BB6_11 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB6_11
.LBB6_19:
	movl	-12(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 8(%rax)
	movl	-16(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-32(%rbp), %rax
	movl	$-1, 4116(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 6216(%rax)
	movq	-32(%rbp), %rax
	movl	$1, 7248(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7268(%rax)
	movq	-32(%rbp), %rax
	movl	$1, 7264(%rax)
	movq	-32(%rbp), %rax
	movl	$1, 6220(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7272(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7284(%rax)
	movq	-32(%rbp), %rax
	movl	$0, 7288(%rax)
	movq	-32(%rbp), %rax
	movl	8(%rax), %ecx
	subl	$1, %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 7292(%rax)
	movq	-32(%rbp), %rax
	movl	12(%rax), %ecx
	subl	$1, %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 7296(%rax)
	movq	-32(%rbp), %rax
	movl	$96, 7300(%rax)
	movq	-32(%rbp), %rax
	movl	$96, 7304(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 7328(%rax)
	movq	-32(%rbp), %rax
	movl	$3, 7324(%rax)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB6_20:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	gdImageCreateTrueColor, .Lfunc_end6-gdImageCreateTrueColor
	.cfi_endproc
                                        # -- End function
	.globl	gdImageDestroy                  # -- Begin function gdImageDestroy
	.p2align	4, 0x90
	.type	gdImageDestroy,@function
gdImageDestroy:                         # @gdImageDestroy
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB7_6
# %bb.1:
	movl	$0, -12(%rbp)
.LBB7_2:                                # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB7_5
# %bb.3:                                #   in Loop: Header=BB7_2 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-12(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.4:                                #   in Loop: Header=BB7_2 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_2
.LBB7_5:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	gdFree@PLT
.LBB7_6:
	movq	-8(%rbp), %rax
	cmpq	$0, 7256(%rax)
	je	.LBB7_12
# %bb.7:
	movl	$0, -12(%rbp)
.LBB7_8:                                # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB7_11
# %bb.9:                                #   in Loop: Header=BB7_8 Depth=1
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-12(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.10:                               #   in Loop: Header=BB7_8 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB7_8
.LBB7_11:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rdi
	callq	gdFree@PLT
.LBB7_12:
	movq	-8(%rbp), %rax
	cmpq	$0, 4120(%rax)
	je	.LBB7_14
# %bb.13:
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rdi
	callq	gdFree@PLT
.LBB7_14:
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	je	.LBB7_16
# %bb.15:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rdi
	callq	gdFree@PLT
.LBB7_16:
	movq	-8(%rbp), %rdi
	callq	gdFree@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	gdImageDestroy, .Lfunc_end7-gdImageDestroy
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorClosest             # -- Begin function gdImageColorClosest
	.p2align	4, 0x90
	.type	gdImageColorClosest,@function
gdImageColorClosest:                    # @gdImageColorClosest
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	xorl	%r8d, %r8d
	callq	gdImageColorClosestAlpha
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	gdImageColorClosest, .Lfunc_end8-gdImageColorClosest
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorClosestAlpha        # -- Begin function gdImageColorClosestAlpha
	.p2align	4, 0x90
	.type	gdImageColorClosestAlpha,@function
gdImageColorClosestAlpha:               # @gdImageColorClosestAlpha
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -32(%rbp)
	movl	$-1, -76(%rbp)
	movl	$1, -80(%rbp)
	movq	$0, -88(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB9_2
# %bb.1:
	movl	-32(%rbp), %eax
	shll	$24, %eax
	movl	-20(%rbp), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB9_12
.LBB9_2:
	movl	$0, -36(%rbp)
.LBB9_3:                                # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB9_11
# %bb.4:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB9_6
# %bb.5:                                #   in Loop: Header=BB9_3 Depth=1
	jmp	.LBB9_10
.LBB9_6:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	subl	-20(%rbp), %eax
	cltq
	movq	%rax, -48(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	subl	-24(%rbp), %eax
	cltq
	movq	%rax, -56(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	subl	-28(%rbp), %eax
	cltq
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	subl	-32(%rbp), %eax
	cltq
	movq	%rax, -72(%rbp)
	movq	-48(%rbp), %rax
	imulq	-48(%rbp), %rax
	movq	-56(%rbp), %rcx
	imulq	-56(%rbp), %rcx
	addq	%rcx, %rax
	movq	-64(%rbp), %rcx
	imulq	-64(%rbp), %rcx
	addq	%rcx, %rax
	movq	-72(%rbp), %rcx
	imulq	-72(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	cmpl	$0, -80(%rbp)
	jne	.LBB9_8
# %bb.7:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-96(%rbp), %rax
	cmpq	-88(%rbp), %rax
	jge	.LBB9_9
.LBB9_8:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-96(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	$0, -80(%rbp)
.LBB9_9:                                #   in Loop: Header=BB9_3 Depth=1
	jmp	.LBB9_10
.LBB9_10:                               #   in Loop: Header=BB9_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB9_3
.LBB9_11:
	movl	-76(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB9_12:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	gdImageColorClosestAlpha, .Lfunc_end9-gdImageColorClosestAlpha
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorClosestHWB          # -- Begin function gdImageColorClosestHWB
	.p2align	4, 0x90
	.type	gdImageColorClosestHWB,@function
gdImageColorClosestHWB:                 # @gdImageColorClosestHWB
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
	movl	$-1, -36(%rbp)
	movl	$1, -40(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -44(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB10_2
# %bb.1:
	movl	-20(%rbp), %eax
	shll	$16, %eax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB10_12
.LBB10_2:
	movl	$0, -32(%rbp)
.LBB10_3:                               # =>This Inner Loop Header: Depth=1
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB10_11
# %bb.4:                                #   in Loop: Header=BB10_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB10_6
# %bb.5:                                #   in Loop: Header=BB10_3 Depth=1
	jmp	.LBB10_10
.LBB10_6:                               #   in Loop: Header=BB10_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	20(%rax,%rcx,4), %edi
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %esi
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	HWB_Diff
	movss	%xmm0, -48(%rbp)
	cmpl	$0, -40(%rbp)
	jne	.LBB10_8
# %bb.7:                                #   in Loop: Header=BB10_3 Depth=1
	movss	-48(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-44(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB10_9
.LBB10_8:                               #   in Loop: Header=BB10_3 Depth=1
	movss	-48(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -44(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	$0, -40(%rbp)
.LBB10_9:                               #   in Loop: Header=BB10_3 Depth=1
	jmp	.LBB10_10
.LBB10_10:                              #   in Loop: Header=BB10_3 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB10_3
.LBB10_11:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB10_12:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	gdImageColorClosestHWB, .Lfunc_end10-gdImageColorClosestHWB
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function HWB_Diff
.LCPI11_0:
	.long	0xbf800000                      # float -1
.LCPI11_2:
	.long	0x40400000                      # float 3
.LCPI11_4:
	.long	0x40c00000                      # float 6
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI11_1:
	.quad	0x406fe00000000000              # double 255
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI11_3:
	.quad	0x7fffffffffffffff              # double NaN
	.quad	0x7fffffffffffffff              # double NaN
	.text
	.p2align	4, 0x90
	.type	HWB_Diff,@function
HWB_Diff:                               # @HWB_Diff
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	movl	%r8d, -20(%rbp)
	movl	%r9d, -24(%rbp)
	cvtsi2sdl	-4(%rbp), %xmm0
	movsd	.LCPI11_1(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -40(%rbp)
	cvtsi2sdl	-8(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -36(%rbp)
	cvtsi2sdl	-12(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -32(%rbp)
	cvtsi2sdl	-16(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -56(%rbp)
	cvtsi2sdl	-20(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -52(%rbp)
	cvtsi2sdl	-24(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -48(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -104(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -112(%rbp)
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	movss	-104(%rbp), %xmm1               # xmm1 = mem[0],zero,zero,zero
	leaq	-72(%rbp), %rdi
	callq	RGB_to_HWB
	movl	-48(%rbp), %eax
	movl	%eax, -120(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -128(%rbp)
	movsd	-128(%rbp), %xmm0               # xmm0 = mem[0],zero
	movss	-120(%rbp), %xmm1               # xmm1 = mem[0],zero,zero,zero
	leaq	-88(%rbp), %rdi
	callq	RGB_to_HWB
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI11_0(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB11_1
	jp	.LBB11_1
	jmp	.LBB11_2
.LBB11_1:
	movss	-88(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI11_0(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB11_3
	jp	.LBB11_3
.LBB11_2:
	xorps	%xmm0, %xmm0
	movss	%xmm0, -92(%rbp)
	jmp	.LBB11_6
.LBB11_3:
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-88(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movaps	.LCPI11_3(%rip), %xmm1          # xmm1 = [NaN,NaN]
	pand	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -92(%rbp)
	movss	-92(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI11_2(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB11_5
# %bb.4:
	movss	.LCPI11_4(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	subss	-92(%rbp), %xmm0
	movss	%xmm0, -92(%rbp)
.LBB11_5:
	jmp	.LBB11_6
.LBB11_6:
	movss	-92(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-92(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-84(%rbp), %xmm0
	movss	-68(%rbp), %xmm3                # xmm3 = mem[0],zero,zero,zero
	subss	-84(%rbp), %xmm3
	mulss	%xmm3, %xmm0
	mulss	%xmm2, %xmm1
	addss	%xmm0, %xmm1
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-80(%rbp), %xmm0
	movss	-64(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	subss	-80(%rbp), %xmm2
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -92(%rbp)
	movss	-92(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	HWB_Diff, .Lfunc_end11-HWB_Diff
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorExact               # -- Begin function gdImageColorExact
	.p2align	4, 0x90
	.type	gdImageColorExact,@function
gdImageColorExact:                      # @gdImageColorExact
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	xorl	%r8d, %r8d
	callq	gdImageColorExactAlpha
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	gdImageColorExact, .Lfunc_end12-gdImageColorExact
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorExactAlpha          # -- Begin function gdImageColorExactAlpha
	.p2align	4, 0x90
	.type	gdImageColorExactAlpha,@function
gdImageColorExactAlpha:                 # @gdImageColorExactAlpha
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -32(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB13_2
# %bb.1:
	movl	-32(%rbp), %eax
	shll	$24, %eax
	movl	-20(%rbp), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB13_14
.LBB13_2:
	movl	$0, -36(%rbp)
.LBB13_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB13_13
# %bb.4:                                #   in Loop: Header=BB13_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB13_6
# %bb.5:                                #   in Loop: Header=BB13_3 Depth=1
	jmp	.LBB13_12
.LBB13_6:                               #   in Loop: Header=BB13_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB13_11
# %bb.7:                                #   in Loop: Header=BB13_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB13_11
# %bb.8:                                #   in Loop: Header=BB13_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	cmpl	-28(%rbp), %eax
	jne	.LBB13_11
# %bb.9:                                #   in Loop: Header=BB13_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB13_11
# %bb.10:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB13_14
.LBB13_11:                              #   in Loop: Header=BB13_3 Depth=1
	jmp	.LBB13_12
.LBB13_12:                              #   in Loop: Header=BB13_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB13_3
.LBB13_13:
	movl	$-1, -4(%rbp)
.LBB13_14:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	gdImageColorExactAlpha, .Lfunc_end13-gdImageColorExactAlpha
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorAllocate            # -- Begin function gdImageColorAllocate
	.p2align	4, 0x90
	.type	gdImageColorAllocate,@function
gdImageColorAllocate:                   # @gdImageColorAllocate
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	xorl	%r8d, %r8d
	callq	gdImageColorAllocateAlpha
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end14:
	.size	gdImageColorAllocate, .Lfunc_end14-gdImageColorAllocate
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorAllocateAlpha       # -- Begin function gdImageColorAllocateAlpha
	.p2align	4, 0x90
	.type	gdImageColorAllocateAlpha,@function
gdImageColorAllocateAlpha:              # @gdImageColorAllocateAlpha
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -32(%rbp)
	movl	$-1, -40(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB15_2
# %bb.1:
	movl	-32(%rbp), %eax
	shll	$24, %eax
	movl	-20(%rbp), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB15_13
.LBB15_2:
	movl	$0, -36(%rbp)
.LBB15_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB15_8
# %bb.4:                                #   in Loop: Header=BB15_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB15_6
# %bb.5:
	movl	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB15_8
.LBB15_6:                               #   in Loop: Header=BB15_3 Depth=1
	jmp	.LBB15_7
.LBB15_7:                               #   in Loop: Header=BB15_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB15_3
.LBB15_8:
	cmpl	$-1, -40(%rbp)
	jne	.LBB15_12
# %bb.9:
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -40(%rbp)
	cmpl	$256, -40(%rbp)                 # imm = 0x100
	jne	.LBB15_11
# %bb.10:
	movl	$-1, -4(%rbp)
	jmp	.LBB15_13
.LBB15_11:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, 16(%rax)
.LBB15_12:
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	%edx, 20(%rax,%rcx,4)
	movl	-24(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	%edx, 1044(%rax,%rcx,4)
	movl	-28(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	%edx, 2068(%rax,%rcx,4)
	movl	-32(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	%edx, 6224(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	$0, 3092(%rax,%rcx,4)
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB15_13:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	gdImageColorAllocateAlpha, .Lfunc_end15-gdImageColorAllocateAlpha
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorResolve             # -- Begin function gdImageColorResolve
	.p2align	4, 0x90
	.type	gdImageColorResolve,@function
gdImageColorResolve:                    # @gdImageColorResolve
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	xorl	%r8d, %r8d
	callq	gdImageColorResolveAlpha
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end16:
	.size	gdImageColorResolve, .Lfunc_end16-gdImageColorResolve
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorResolveAlpha        # -- Begin function gdImageColorResolveAlpha
	.p2align	4, 0x90
	.type	gdImageColorResolveAlpha,@function
gdImageColorResolveAlpha:               # @gdImageColorResolveAlpha
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -32(%rbp)
	movl	$-1, -40(%rbp)
	movl	$-1, -44(%rbp)
	movq	$260100, -96(%rbp)              # imm = 0x3F804
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB17_2
# %bb.1:
	movl	-32(%rbp), %eax
	shll	$24, %eax
	movl	-20(%rbp), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB17_19
.LBB17_2:
	movl	$0, -36(%rbp)
.LBB17_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB17_14
# %bb.4:                                #   in Loop: Header=BB17_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB17_6
# %bb.5:                                #   in Loop: Header=BB17_3 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB17_13
.LBB17_6:                               #   in Loop: Header=BB17_3 Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB17_8
# %bb.7:                                #   in Loop: Header=BB17_3 Depth=1
	jmp	.LBB17_13
.LBB17_8:                               #   in Loop: Header=BB17_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	subl	-20(%rbp), %eax
	cltq
	movq	%rax, -56(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	subl	-24(%rbp), %eax
	cltq
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	subl	-28(%rbp), %eax
	cltq
	movq	%rax, -72(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	subl	-32(%rbp), %eax
	cltq
	movq	%rax, -80(%rbp)
	movq	-56(%rbp), %rax
	imulq	-56(%rbp), %rax
	movq	-64(%rbp), %rcx
	imulq	-64(%rbp), %rcx
	addq	%rcx, %rax
	movq	-72(%rbp), %rcx
	imulq	-72(%rbp), %rcx
	addq	%rcx, %rax
	movq	-80(%rbp), %rcx
	imulq	-80(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	-96(%rbp), %rax
	jge	.LBB17_12
# %bb.9:                                #   in Loop: Header=BB17_3 Depth=1
	cmpq	$0, -88(%rbp)
	jne	.LBB17_11
# %bb.10:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB17_19
.LBB17_11:                              #   in Loop: Header=BB17_3 Depth=1
	movq	-88(%rbp), %rax
	movq	%rax, -96(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB17_12:                              #   in Loop: Header=BB17_3 Depth=1
	jmp	.LBB17_13
.LBB17_13:                              #   in Loop: Header=BB17_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB17_3
.LBB17_14:
	cmpl	$-1, -44(%rbp)
	jne	.LBB17_18
# %bb.15:
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -44(%rbp)
	cmpl	$256, -44(%rbp)                 # imm = 0x100
	jne	.LBB17_17
# %bb.16:
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB17_19
.LBB17_17:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, 16(%rax)
.LBB17_18:
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	%edx, 20(%rax,%rcx,4)
	movl	-24(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	%edx, 1044(%rax,%rcx,4)
	movl	-28(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	%edx, 2068(%rax,%rcx,4)
	movl	-32(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	%edx, 6224(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	$0, 3092(%rax,%rcx,4)
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB17_19:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	gdImageColorResolveAlpha, .Lfunc_end17-gdImageColorResolveAlpha
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorDeallocate          # -- Begin function gdImageColorDeallocate
	.p2align	4, 0x90
	.type	gdImageColorDeallocate,@function
gdImageColorDeallocate:                 # @gdImageColorDeallocate
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB18_3
# %bb.1:
	cmpl	$256, -12(%rbp)                 # imm = 0x100
	jge	.LBB18_3
# %bb.2:
	cmpl	$0, -12(%rbp)
	jge	.LBB18_4
.LBB18_3:
	jmp	.LBB18_5
.LBB18_4:
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	$1, 3092(%rax,%rcx,4)
.LBB18_5:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end18:
	.size	gdImageColorDeallocate, .Lfunc_end18-gdImageColorDeallocate
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorTransparent         # -- Begin function gdImageColorTransparent
	.p2align	4, 0x90
	.type	gdImageColorTransparent,@function
gdImageColorTransparent:                # @gdImageColorTransparent
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB19_9
# %bb.1:
	cmpl	$-1, -12(%rbp)
	jl	.LBB19_3
# %bb.2:
	cmpl	$256, -12(%rbp)                 # imm = 0x100
	jl	.LBB19_4
.LBB19_3:
	jmp	.LBB19_10
.LBB19_4:
	movq	-8(%rbp), %rax
	cmpl	$-1, 4116(%rax)
	je	.LBB19_6
# %bb.5:
	movq	-8(%rbp), %rax
	movq	-8(%rbp), %rcx
	movslq	4116(%rcx), %rcx
	movl	$0, 6224(%rax,%rcx,4)
.LBB19_6:
	cmpl	$-1, -12(%rbp)
	je	.LBB19_8
# %bb.7:
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	$127, 6224(%rax,%rcx,4)
.LBB19_8:
	jmp	.LBB19_9
.LBB19_9:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 4116(%rax)
.LBB19_10:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	gdImageColorTransparent, .Lfunc_end19-gdImageColorTransparent
	.cfi_endproc
                                        # -- End function
	.globl	gdImagePaletteCopy              # -- Begin function gdImagePaletteCopy
	.p2align	4, 0x90
	.type	gdImagePaletteCopy,@function
gdImagePaletteCopy:                     # @gdImagePaletteCopy
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$1056, %rsp                     # imm = 0x420
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB20_2
# %bb.1:
	jmp	.LBB20_27
.LBB20_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB20_4
# %bb.3:
	jmp	.LBB20_27
.LBB20_4:
	movl	$0, -20(%rbp)
.LBB20_5:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -20(%rbp)                 # imm = 0x100
	jge	.LBB20_8
# %bb.6:                                #   in Loop: Header=BB20_5 Depth=1
	movslq	-20(%rbp), %rax
	movl	$-1, -1056(%rbp,%rax,4)
# %bb.7:                                #   in Loop: Header=BB20_5 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB20_5
.LBB20_8:
	movl	$0, -28(%rbp)
.LBB20_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_11 Depth 2
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB20_18
# %bb.10:                               #   in Loop: Header=BB20_9 Depth=1
	movl	$0, -24(%rbp)
.LBB20_11:                              #   Parent Loop BB20_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB20_16
# %bb.12:                               #   in Loop: Header=BB20_11 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-24(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -32(%rbp)
	movslq	-32(%rbp), %rax
	cmpl	$-1, -1056(%rbp,%rax,4)
	jne	.LBB20_14
# %bb.13:                               #   in Loop: Header=BB20_11 Depth=2
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	20(%rax,%rcx,4), %esi
	movq	-8(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %edx
	movq	-8(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %ecx
	movq	-8(%rbp), %rax
	movslq	-32(%rbp), %r8
	movl	6224(%rax,%r8,4), %r8d
	callq	gdImageColorClosestAlpha
	movl	%eax, %ecx
	movslq	-32(%rbp), %rax
	movl	%ecx, -1056(%rbp,%rax,4)
.LBB20_14:                              #   in Loop: Header=BB20_11 Depth=2
	movslq	-32(%rbp), %rax
	movl	-1056(%rbp,%rax,4), %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-24(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.15:                               #   in Loop: Header=BB20_11 Depth=2
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB20_11
.LBB20_16:                              #   in Loop: Header=BB20_9 Depth=1
	jmp	.LBB20_17
.LBB20_17:                              #   in Loop: Header=BB20_9 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB20_9
.LBB20_18:
	movl	$0, -20(%rbp)
.LBB20_19:                              # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB20_22
# %bb.20:                               #   in Loop: Header=BB20_19 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	20(%rax,%rcx,4), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 20(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 2068(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 1044(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 6224(%rax,%rcx,4)
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$0, 3092(%rax,%rcx,4)
# %bb.21:                               #   in Loop: Header=BB20_19 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB20_19
.LBB20_22:
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -20(%rbp)
.LBB20_23:                              # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB20_26
# %bb.24:                               #   in Loop: Header=BB20_23 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$1, 3092(%rax,%rcx,4)
# %bb.25:                               #   in Loop: Header=BB20_23 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB20_23
.LBB20_26:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 16(%rax)
.LBB20_27:
	addq	$1056, %rsp                     # imm = 0x420
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end20:
	.size	gdImagePaletteCopy, .Lfunc_end20-gdImagePaletteCopy
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorReplace             # -- Begin function gdImageColorReplace
	.p2align	4, 0x90
	.type	gdImageColorReplace,@function
gdImageColorReplace:                    # @gdImageColorReplace
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
	movl	$0, -36(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB21_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB21_30
.LBB21_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB21_16
# %bb.3:
	jmp	.LBB21_4
.LBB21_4:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB21_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_7 Depth 2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB21_14
# %bb.6:                                #   in Loop: Header=BB21_5 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -28(%rbp)
.LBB21_7:                               #   Parent Loop BB21_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB21_12
# %bb.8:                                #   in Loop: Header=BB21_7 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-32(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB21_10
# %bb.9:                                #   in Loop: Header=BB21_7 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.LBB21_10:                              #   in Loop: Header=BB21_7 Depth=2
	jmp	.LBB21_11
.LBB21_11:                              #   in Loop: Header=BB21_7 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB21_7
.LBB21_12:                              #   in Loop: Header=BB21_5 Depth=1
	jmp	.LBB21_13
.LBB21_13:                              #   in Loop: Header=BB21_5 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB21_5
.LBB21_14:
	jmp	.LBB21_15
.LBB21_15:
	jmp	.LBB21_29
.LBB21_16:
	jmp	.LBB21_17
.LBB21_17:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB21_18:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_20 Depth 2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB21_27
# %bb.19:                               #   in Loop: Header=BB21_18 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -28(%rbp)
.LBB21_20:                              #   Parent Loop BB21_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB21_25
# %bb.21:                               #   in Loop: Header=BB21_20 Depth=2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-32(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-28(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB21_23
# %bb.22:                               #   in Loop: Header=BB21_20 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.LBB21_23:                              #   in Loop: Header=BB21_20 Depth=2
	jmp	.LBB21_24
.LBB21_24:                              #   in Loop: Header=BB21_20 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB21_20
.LBB21_25:                              #   in Loop: Header=BB21_18 Depth=1
	jmp	.LBB21_26
.LBB21_26:                              #   in Loop: Header=BB21_18 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB21_18
.LBB21_27:
	jmp	.LBB21_28
.LBB21_28:
	jmp	.LBB21_29
.LBB21_29:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB21_30:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end21:
	.size	gdImageColorReplace, .Lfunc_end21-gdImageColorReplace
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetPixel                 # -- Begin function gdImageSetPixel
	.p2align	4, 0x90
	.type	gdImageSetPixel,@function
gdImageSetPixel:                        # @gdImageSetPixel
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	-20(%rbp), %eax
	addl	$7, %eax
	movl	%eax, %ecx
	movq	%rcx, -32(%rbp)                 # 8-byte Spill
	subl	$5, %eax
	ja	.LBB22_16
# %bb.32:
	movq	-32(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI22_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB22_1:
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	jne	.LBB22_3
# %bb.2:
	jmp	.LBB22_31
.LBB22_3:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rax
	movq	-8(%rbp), %rdx
	movl	6204(%rdx), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, 6204(%rdx)
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
# %bb.4:
	cmpl	$-6, -24(%rbp)
	je	.LBB22_6
# %bb.5:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
.LBB22_6:
	movq	-8(%rbp), %rax
	movl	6204(%rax), %eax
	movq	-8(%rbp), %rcx
	cltd
	idivl	6200(%rcx)
	movq	-8(%rbp), %rax
	movl	%edx, 6204(%rax)
	jmp	.LBB22_31
.LBB22_7:
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	jne	.LBB22_9
# %bb.8:
	jmp	.LBB22_31
.LBB22_9:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rax
	movq	-8(%rbp), %rdx
	movl	6204(%rdx), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, 6204(%rdx)
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
	cmpl	$-6, -24(%rbp)
	je	.LBB22_12
# %bb.10:
	cmpl	$0, -24(%rbp)
	je	.LBB22_12
# %bb.11:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	$4294967293, %ecx               # imm = 0xFFFFFFFD
	callq	gdImageSetPixel
.LBB22_12:
	movq	-8(%rbp), %rax
	movl	6204(%rax), %eax
	movq	-8(%rbp), %rcx
	cltd
	idivl	6200(%rcx)
	movq	-8(%rbp), %rax
	movl	%edx, 6204(%rax)
	jmp	.LBB22_31
.LBB22_13:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageBrushApply
	jmp	.LBB22_31
.LBB22_14:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageTileApply
	jmp	.LBB22_31
.LBB22_15:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	7276(%rax), %ecx
	callq	gdImageSetPixel
	jmp	.LBB22_31
.LBB22_16:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7288(%rcx), %eax
	jl	.LBB22_30
# %bb.17:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB22_30
# %bb.18:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7284(%rcx), %eax
	jl	.LBB22_30
# %bb.19:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB22_30
# %bb.20:
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB22_28
# %bb.21:
	movq	-8(%rbp), %rax
	movl	7264(%rax), %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	subq	$4, %rax
	ja	.LBB22_22
# %bb.33:
	movq	-40(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI22_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB22_22:
	jmp	.LBB22_23
.LBB22_23:
	movl	-20(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB22_27
.LBB22_24:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movl	-20(%rbp), %esi
	callq	gdAlphaBlend
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB22_27
.LBB22_25:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movl	-20(%rbp), %esi
	callq	gdLayerOverlay
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB22_27
.LBB22_26:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movl	-20(%rbp), %esi
	callq	gdLayerMultiply
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB22_27:
	jmp	.LBB22_29
.LBB22_28:
	movl	-20(%rbp), %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
.LBB22_29:
	jmp	.LBB22_30
.LBB22_30:
	jmp	.LBB22_31
.LBB22_31:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end22:
	.size	gdImageSetPixel, .Lfunc_end22-gdImageSetPixel
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI22_0:
	.long	.LBB22_15-.LJTI22_0
	.long	.LBB22_16-.LJTI22_0
	.long	.LBB22_14-.LJTI22_0
	.long	.LBB22_7-.LJTI22_0
	.long	.LBB22_13-.LJTI22_0
	.long	.LBB22_1-.LJTI22_0
.LJTI22_1:
	.long	.LBB22_23-.LJTI22_1
	.long	.LBB22_24-.LJTI22_1
	.long	.LBB22_24-.LJTI22_1
	.long	.LBB22_25-.LJTI22_1
	.long	.LBB22_26-.LJTI22_1
                                        # -- End function
	.text
	.globl	gdImageColorReplaceThreshold    # -- Begin function gdImageColorReplaceThreshold
	.p2align	4, 0x90
	.type	gdImageColorReplaceThreshold,@function
gdImageColorReplaceThreshold:           # @gdImageColorReplaceThreshold
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
	movss	%xmm0, -28(%rbp)
	movl	$0, -40(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB23_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB23_30
.LBB23_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB23_16
# %bb.3:
	jmp	.LBB23_4
.LBB23_4:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -36(%rbp)
.LBB23_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB23_7 Depth 2
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB23_14
# %bb.6:                                #   in Loop: Header=BB23_5 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB23_7:                               #   Parent Loop BB23_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB23_12
# %bb.8:                                #   in Loop: Header=BB23_7 Depth=2
	movq	-16(%rbp), %rdi
	movl	-20(%rbp), %esi
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-36(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-32(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movss	-28(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	gdColorMatch@PLT
	cmpl	$0, %eax
	je	.LBB23_10
# %bb.9:                                #   in Loop: Header=BB23_7 Depth=2
	movq	-16(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB23_10:                              #   in Loop: Header=BB23_7 Depth=2
	jmp	.LBB23_11
.LBB23_11:                              #   in Loop: Header=BB23_7 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB23_7
.LBB23_12:                              #   in Loop: Header=BB23_5 Depth=1
	jmp	.LBB23_13
.LBB23_13:                              #   in Loop: Header=BB23_5 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB23_5
.LBB23_14:
	jmp	.LBB23_15
.LBB23_15:
	jmp	.LBB23_29
.LBB23_16:
	jmp	.LBB23_17
.LBB23_17:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -36(%rbp)
.LBB23_18:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB23_20 Depth 2
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB23_27
# %bb.19:                               #   in Loop: Header=BB23_18 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB23_20:                              #   Parent Loop BB23_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB23_25
# %bb.21:                               #   in Loop: Header=BB23_20 Depth=2
	movq	-16(%rbp), %rdi
	movl	-20(%rbp), %esi
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-36(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %edx
	movss	-28(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	gdColorMatch@PLT
	cmpl	$0, %eax
	je	.LBB23_23
# %bb.22:                               #   in Loop: Header=BB23_20 Depth=2
	movq	-16(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB23_23:                              #   in Loop: Header=BB23_20 Depth=2
	jmp	.LBB23_24
.LBB23_24:                              #   in Loop: Header=BB23_20 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB23_20
.LBB23_25:                              #   in Loop: Header=BB23_18 Depth=1
	jmp	.LBB23_26
.LBB23_26:                              #   in Loop: Header=BB23_18 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB23_18
.LBB23_27:
	jmp	.LBB23_28
.LBB23_28:
	jmp	.LBB23_29
.LBB23_29:
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB23_30:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end23:
	.size	gdImageColorReplaceThreshold, .Lfunc_end23-gdImageColorReplaceThreshold
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorReplaceArray        # -- Begin function gdImageColorReplaceArray
	.p2align	4, 0x90
	.type	gdImageColorReplaceArray,@function
gdImageColorReplaceArray:               # @gdImageColorReplaceArray
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	$0, -80(%rbp)
	cmpl	$0, -20(%rbp)
	jle	.LBB24_2
# %bb.1:
	movq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.LBB24_3
.LBB24_2:
	movl	$0, -4(%rbp)
	jmp	.LBB24_41
.LBB24_3:
	cmpl	$1, -20(%rbp)
	jne	.LBB24_5
# %bb.4:
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rax
	movl	(%rax), %esi
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	callq	gdImageColorReplace
	movl	%eax, -4(%rbp)
	jmp	.LBB24_41
.LBB24_5:
	movl	-20(%rbp), %edi
	movl	$8, %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB24_7
# %bb.6:
	movl	$-1, -4(%rbp)
	jmp	.LBB24_41
.LBB24_7:
	movslq	-20(%rbp), %rdi
	shlq	$3, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB24_9
# %bb.8:
	movl	$-1, -4(%rbp)
	jmp	.LBB24_41
.LBB24_9:
	movl	$0, -76(%rbp)
.LBB24_10:                              # =>This Inner Loop Header: Depth=1
	movl	-76(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB24_13
# %bb.11:                               #   in Loop: Header=BB24_10 Depth=1
	movq	-32(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-72(%rbp), %rax
	movl	-76(%rbp), %ecx
	shll	$1, %ecx
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
	movq	-40(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-72(%rbp), %rax
	movl	-76(%rbp), %ecx
	shll	$1, %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.12:                               #   in Loop: Header=BB24_10 Depth=1
	movl	-76(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB24_10
.LBB24_13:
	movq	-72(%rbp), %rdi
	movslq	-20(%rbp), %rsi
	movl	$8, %edx
	leaq	colorCmp(%rip), %rcx
	callq	qsort@PLT
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB24_27
# %bb.14:
	jmp	.LBB24_15
.LBB24_15:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -48(%rbp)
.LBB24_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_18 Depth 2
	movl	-48(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB24_25
# %bb.17:                               #   in Loop: Header=BB24_16 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB24_18:                              #   Parent Loop BB24_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB24_23
# %bb.19:                               #   in Loop: Header=BB24_18 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-48(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)
	movq	-72(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	leaq	-52(%rbp), %rdi
	movl	$8, %ecx
	leaq	colorCmp(%rip), %r8
	callq	bsearch@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, %rax
	je	.LBB24_21
# %bb.20:                               #   in Loop: Header=BB24_18 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	4(%rax), %ecx
	callq	gdImageSetPixel
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
.LBB24_21:                              #   in Loop: Header=BB24_18 Depth=2
	jmp	.LBB24_22
.LBB24_22:                              #   in Loop: Header=BB24_18 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB24_18
.LBB24_23:                              #   in Loop: Header=BB24_16 Depth=1
	jmp	.LBB24_24
.LBB24_24:                              #   in Loop: Header=BB24_16 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB24_16
.LBB24_25:
	jmp	.LBB24_26
.LBB24_26:
	jmp	.LBB24_40
.LBB24_27:
	jmp	.LBB24_28
.LBB24_28:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -48(%rbp)
.LBB24_29:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_31 Depth 2
	movl	-48(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB24_38
# %bb.30:                               #   in Loop: Header=BB24_29 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB24_31:                              #   Parent Loop BB24_29 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB24_36
# %bb.32:                               #   in Loop: Header=BB24_31 Depth=2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-48(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-44(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -52(%rbp)
	movq	-72(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	leaq	-52(%rbp), %rdi
	movl	$8, %ecx
	leaq	colorCmp(%rip), %r8
	callq	bsearch@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, %rax
	je	.LBB24_34
# %bb.33:                               #   in Loop: Header=BB24_31 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	4(%rax), %ecx
	callq	gdImageSetPixel
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
.LBB24_34:                              #   in Loop: Header=BB24_31 Depth=2
	jmp	.LBB24_35
.LBB24_35:                              #   in Loop: Header=BB24_31 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB24_31
.LBB24_36:                              #   in Loop: Header=BB24_29 Depth=1
	jmp	.LBB24_37
.LBB24_37:                              #   in Loop: Header=BB24_29 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB24_29
.LBB24_38:
	jmp	.LBB24_39
.LBB24_39:
	jmp	.LBB24_40
.LBB24_40:
	movq	-72(%rbp), %rdi
	callq	gdFree@PLT
	movl	-80(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB24_41:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end24:
	.size	gdImageColorReplaceArray, .Lfunc_end24-gdImageColorReplaceArray
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function colorCmp
	.type	colorCmp,@function
colorCmp:                               # @colorCmp
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
	movl	(%rax), %eax
	movl	%eax, -20(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -24(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	setg	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	-20(%rbp), %ecx
	cmpl	-24(%rbp), %ecx
	setl	%cl
	andb	$1, %cl
	movzbl	%cl, %ecx
	subl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end25:
	.size	colorCmp, .Lfunc_end25-colorCmp
	.cfi_endproc
                                        # -- End function
	.globl	gdImageColorReplaceCallback     # -- Begin function gdImageColorReplaceCallback
	.p2align	4, 0x90
	.type	gdImageColorReplaceCallback,@function
gdImageColorReplaceCallback:            # @gdImageColorReplaceCallback
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
	movl	$0, -36(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB26_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB26_30
.LBB26_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB26_14
# %bb.3:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB26_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB26_6 Depth 2
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB26_13
# %bb.5:                                #   in Loop: Header=BB26_4 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -40(%rbp)
.LBB26_6:                               #   Parent Loop BB26_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB26_11
# %bb.7:                                #   in Loop: Header=BB26_6 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-44(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-40(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -28(%rbp)
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	callq	*%rax
	movl	%eax, -32(%rbp)
	cmpl	-28(%rbp), %eax
	je	.LBB26_9
# %bb.8:                                #   in Loop: Header=BB26_6 Depth=2
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-32(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.LBB26_9:                               #   in Loop: Header=BB26_6 Depth=2
	jmp	.LBB26_10
.LBB26_10:                              #   in Loop: Header=BB26_6 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB26_6
.LBB26_11:                              #   in Loop: Header=BB26_4 Depth=1
	jmp	.LBB26_12
.LBB26_12:                              #   in Loop: Header=BB26_4 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB26_4
.LBB26_13:
	jmp	.LBB26_29
.LBB26_14:
	movl	$0, -72(%rbp)
	movq	-16(%rbp), %rax
	movslq	16(%rax), %rdi
	movl	$4, %esi
	callq	gdCalloc@PLT
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB26_16
# %bb.15:
	movl	$-1, -4(%rbp)
	jmp	.LBB26_30
.LBB26_16:
	movl	$0, -28(%rbp)
.LBB26_17:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB26_22
# %bb.18:                               #   in Loop: Header=BB26_17 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	jne	.LBB26_20
# %bb.19:                               #   in Loop: Header=BB26_17 Depth=1
	movl	-28(%rbp), %edx
	movq	-56(%rbp), %rax
	movl	-72(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -72(%rbp)
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB26_20:                              #   in Loop: Header=BB26_17 Depth=1
	jmp	.LBB26_21
.LBB26_21:                              #   in Loop: Header=BB26_17 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB26_17
.LBB26_22:
	movslq	-72(%rbp), %rdi
	movl	$4, %esi
	callq	gdCalloc@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB26_24
# %bb.23:
	movq	-56(%rbp), %rdi
	callq	gdFree@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB26_30
.LBB26_24:
	movl	$0, -68(%rbp)
.LBB26_25:                              # =>This Inner Loop Header: Depth=1
	movl	-68(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jge	.LBB26_28
# %bb.26:                               #   in Loop: Header=BB26_25 Depth=1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	-56(%rbp), %rcx
	movslq	-68(%rbp), %rdx
	movl	(%rcx,%rdx,4), %esi
	callq	*%rax
	movl	%eax, %edx
	movq	-64(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.27:                               #   in Loop: Header=BB26_25 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB26_25
.LBB26_28:
	movq	-16(%rbp), %rdi
	movl	-68(%rbp), %esi
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rcx
	callq	gdImageColorReplaceArray
	movl	%eax, -36(%rbp)
	movq	-64(%rbp), %rdi
	callq	gdFree@PLT
	movq	-56(%rbp), %rdi
	callq	gdFree@PLT
.LBB26_29:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB26_30:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end26:
	.size	gdImageColorReplaceCallback, .Lfunc_end26-gdImageColorReplaceCallback
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdImageBrushApply
	.type	gdImageBrushApply,@function
gdImageBrushApply:                      # @gdImageBrushApply
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movq	-8(%rbp), %rax
	cmpq	$0, 4136(%rax)
	jne	.LBB27_2
# %bb.1:
	jmp	.LBB27_41
.LBB27_2:
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	movl	12(%rax), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -28(%rbp)
	movl	-16(%rbp), %eax
	subl	-28(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	addl	12(%rcx), %eax
	movl	%eax, -48(%rbp)
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	movl	8(%rax), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -32(%rbp)
	movl	-12(%rbp), %eax
	subl	-32(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	addl	8(%rcx), %eax
	movl	%eax, -44(%rbp)
	movl	$0, -56(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB27_27
# %bb.3:
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB27_15
# %bb.4:
	movl	-40(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB27_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB27_7 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB27_14
# %bb.6:                                #   in Loop: Header=BB27_5 Depth=1
	movl	$0, -52(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB27_7:                               #   Parent Loop BB27_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB27_12
# %bb.8:                                #   in Loop: Header=BB27_7 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetTrueColorPixel
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB27_10
# %bb.9:                                #   in Loop: Header=BB27_7 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-60(%rbp), %ecx
	callq	gdImageSetPixel
.LBB27_10:                              #   in Loop: Header=BB27_7 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.11:                               #   in Loop: Header=BB27_7 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB27_7
.LBB27_12:                              #   in Loop: Header=BB27_5 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.13:                               #   in Loop: Header=BB27_5 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB27_5
.LBB27_14:
	jmp	.LBB27_26
.LBB27_15:
	movl	-40(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB27_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB27_18 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB27_25
# %bb.17:                               #   in Loop: Header=BB27_16 Depth=1
	movl	$0, -52(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB27_18:                              #   Parent Loop BB27_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB27_23
# %bb.19:                               #   in Loop: Header=BB27_18 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -64(%rbp)
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetTrueColorPixel
	movl	%eax, -68(%rbp)
	movl	-64(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB27_21
# %bb.20:                               #   in Loop: Header=BB27_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageSetPixel
.LBB27_21:                              #   in Loop: Header=BB27_18 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.22:                               #   in Loop: Header=BB27_18 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB27_18
.LBB27_23:                              #   in Loop: Header=BB27_16 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.24:                               #   in Loop: Header=BB27_16 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB27_16
.LBB27_25:
	jmp	.LBB27_26
.LBB27_26:
	jmp	.LBB27_41
.LBB27_27:
	movl	-40(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB27_28:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB27_30 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB27_40
# %bb.29:                               #   in Loop: Header=BB27_28 Depth=1
	movl	$0, -52(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB27_30:                              #   Parent Loop BB27_28 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB27_38
# %bb.31:                               #   in Loop: Header=BB27_30 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -72(%rbp)
	movl	-72(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB27_36
# %bb.32:                               #   in Loop: Header=BB27_30 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB27_34
# %bb.33:                               #   in Loop: Header=BB27_30 Depth=2
	movq	-8(%rbp), %rax
	movq	%rax, -88(%rbp)                 # 8-byte Spill
	movl	-20(%rbp), %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
	movl	-24(%rbp), %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	movq	-8(%rbp), %rdi
	movl	-72(%rbp), %esi
	andl	$16711680, %esi                 # imm = 0xFF0000
	sarl	$16, %esi
	movl	-72(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	-72(%rbp), %ecx
	andl	$255, %ecx
	movl	-72(%rbp), %r8d
	andl	$2130706432, %r8d               # imm = 0x7F000000
	sarl	$24, %r8d
	callq	gdImageColorResolveAlpha
	movq	-88(%rbp), %rdi                 # 8-byte Reload
	movl	-80(%rbp), %esi                 # 4-byte Reload
	movl	-76(%rbp), %edx                 # 4-byte Reload
	movl	%eax, %ecx
	callq	gdImageSetPixel
	jmp	.LBB27_35
.LBB27_34:                              #   in Loop: Header=BB27_30 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	4152(%rax,%rcx,4), %ecx
	callq	gdImageSetPixel
.LBB27_35:                              #   in Loop: Header=BB27_30 Depth=2
	jmp	.LBB27_36
.LBB27_36:                              #   in Loop: Header=BB27_30 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.37:                               #   in Loop: Header=BB27_30 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB27_30
.LBB27_38:                              #   in Loop: Header=BB27_28 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.39:                               #   in Loop: Header=BB27_28 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB27_28
.LBB27_40:
	jmp	.LBB27_41
.LBB27_41:
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end27:
	.size	gdImageBrushApply, .Lfunc_end27-gdImageBrushApply
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdImageTileApply
	.type	gdImageTileApply,@function
gdImageTileApply:                       # @gdImageTileApply
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	4144(%rax), %rax
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB28_2
# %bb.1:
	jmp	.LBB28_14
.LBB28_2:
	movl	-12(%rbp), %eax
	movq	-24(%rbp), %rcx
	cltd
	idivl	8(%rcx)
	movl	%edx, -28(%rbp)
	movl	-16(%rbp), %eax
	movq	-24(%rbp), %rcx
	cltd
	idivl	12(%rcx)
	movl	%edx, -32(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB28_8
# %bb.3:
	movq	-24(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB28_7
# %bb.4:
	movq	-24(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB28_6
# %bb.5:
	movq	-24(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	shll	$24, %eax
	movq	-24(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	movl	20(%rcx,%rdx,4), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movq	-24(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	movl	1044(%rcx,%rdx,4), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	movq	-24(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	addl	2068(%rcx,%rdx,4), %eax
	movl	%eax, -36(%rbp)
.LBB28_6:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-36(%rbp), %ecx
	callq	gdImageSetPixel
.LBB28_7:
	jmp	.LBB28_14
.LBB28_8:
	movq	-24(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB28_13
# %bb.9:
	movq	-24(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB28_11
# %bb.10:
	movq	-8(%rbp), %rax
	movq	%rax, -56(%rbp)                 # 8-byte Spill
	movl	-12(%rbp), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	movl	-16(%rbp), %eax
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	andl	$16711680, %esi                 # imm = 0xFF0000
	sarl	$16, %esi
	movl	-36(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	-36(%rbp), %ecx
	andl	$255, %ecx
	movl	-36(%rbp), %r8d
	andl	$2130706432, %r8d               # imm = 0x7F000000
	sarl	$24, %r8d
	callq	gdImageColorResolveAlpha
	movq	-56(%rbp), %rdi                 # 8-byte Reload
	movl	-44(%rbp), %esi                 # 4-byte Reload
	movl	-40(%rbp), %edx                 # 4-byte Reload
	movl	%eax, %ecx
	callq	gdImageSetPixel
	jmp	.LBB28_12
.LBB28_11:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	5176(%rax,%rcx,4), %ecx
	callq	gdImageSetPixel
.LBB28_12:
	jmp	.LBB28_13
.LBB28_13:
	jmp	.LBB28_14
.LBB28_14:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end28:
	.size	gdImageTileApply, .Lfunc_end28-gdImageTileApply
	.cfi_endproc
                                        # -- End function
	.globl	gdAlphaBlend                    # -- Begin function gdAlphaBlend
	.p2align	4, 0x90
	.type	gdAlphaBlend,@function
gdAlphaBlend:                           # @gdAlphaBlend
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	-12(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -16(%rbp)
	cmpl	$0, -16(%rbp)
	jne	.LBB29_2
# %bb.1:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_7
.LBB29_2:
	movl	-8(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -20(%rbp)
	cmpl	$127, -16(%rbp)
	jne	.LBB29_4
# %bb.3:
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_7
.LBB29_4:
	cmpl	$127, -20(%rbp)
	jne	.LBB29_6
# %bb.5:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB29_7
.LBB29_6:
	movl	$127, %eax
	subl	-16(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	$127, %eax
	subl	-20(%rbp), %eax
	imull	-16(%rbp), %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -44(%rbp)
	movl	-40(%rbp), %eax
	addl	-44(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-16(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -24(%rbp)
	movl	-12(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	imull	-40(%rbp), %eax
	movl	-8(%rbp), %ecx
	andl	$16711680, %ecx                 # imm = 0xFF0000
	sarl	$16, %ecx
	imull	-44(%rbp), %ecx
	addl	%ecx, %eax
	cltd
	idivl	-48(%rbp)
	movl	%eax, -28(%rbp)
	movl	-12(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	imull	-40(%rbp), %eax
	movl	-8(%rbp), %ecx
	andl	$65280, %ecx                    # imm = 0xFF00
	sarl	$8, %ecx
	imull	-44(%rbp), %ecx
	addl	%ecx, %eax
	cltd
	idivl	-48(%rbp)
	movl	%eax, -32(%rbp)
	movl	-12(%rbp), %eax
	andl	$255, %eax
	imull	-40(%rbp), %eax
	movl	-8(%rbp), %ecx
	andl	$255, %ecx
	imull	-44(%rbp), %ecx
	addl	%ecx, %eax
	cltd
	idivl	-48(%rbp)
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	shll	$24, %eax
	movl	-28(%rbp), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	-32(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB29_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end29:
	.size	gdAlphaBlend, .Lfunc_end29-gdAlphaBlend
	.cfi_endproc
                                        # -- End function
	.globl	gdLayerOverlay                  # -- Begin function gdLayerOverlay
	.p2align	4, 0x90
	.type	gdLayerOverlay,@function
gdLayerOverlay:                         # @gdLayerOverlay
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %ecx
	andl	$2130706432, %ecx               # imm = 0x7F000000
	sarl	$24, %ecx
	movl	$127, %eax
	subl	%ecx, %eax
	movl	%eax, -12(%rbp)
	movl	-8(%rbp), %ecx
	andl	$2130706432, %ecx               # imm = 0x7F000000
	sarl	$24, %ecx
	movl	$127, %eax
	subl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	imull	-16(%rbp), %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$127, %eax
	subl	%ecx, %eax
	shll	$24, %eax
	movl	%eax, -28(%rbp)                 # 4-byte Spill
	movl	-8(%rbp), %edi
	andl	$16711680, %edi                 # imm = 0xFF0000
	sarl	$16, %edi
	movl	-4(%rbp), %esi
	andl	$16711680, %esi                 # imm = 0xFF0000
	sarl	$16, %esi
	movl	$255, %edx
	callq	gdAlphaOverlayColor
	movl	%eax, %ecx
	movl	-28(%rbp), %eax                 # 4-byte Reload
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	%eax, -24(%rbp)                 # 4-byte Spill
	movl	-8(%rbp), %edi
	andl	$65280, %edi                    # imm = 0xFF00
	sarl	$8, %edi
	movl	-4(%rbp), %esi
	andl	$65280, %esi                    # imm = 0xFF00
	sarl	$8, %esi
	movl	$255, %edx
	callq	gdAlphaOverlayColor
	movl	%eax, %ecx
	movl	-24(%rbp), %eax                 # 4-byte Reload
	shll	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -20(%rbp)                 # 4-byte Spill
	movl	-8(%rbp), %edi
	andl	$255, %edi
	movl	-4(%rbp), %esi
	andl	$255, %esi
	movl	$255, %edx
	callq	gdAlphaOverlayColor
	movl	%eax, %ecx
	movl	-20(%rbp), %eax                 # 4-byte Reload
	addl	%ecx, %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end30:
	.size	gdLayerOverlay, .Lfunc_end30-gdLayerOverlay
	.cfi_endproc
                                        # -- End function
	.globl	gdLayerMultiply                 # -- Begin function gdLayerMultiply
	.p2align	4, 0x90
	.type	gdLayerMultiply,@function
gdLayerMultiply:                        # @gdLayerMultiply
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-8(%rbp), %ecx
	andl	$2130706432, %ecx               # imm = 0x7F000000
	sarl	$24, %ecx
	movl	$127, %eax
	subl	%ecx, %eax
	movl	%eax, -12(%rbp)
	movl	-4(%rbp), %ecx
	andl	$2130706432, %ecx               # imm = 0x7F000000
	sarl	$24, %ecx
	movl	$127, %eax
	subl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	movl	-8(%rbp), %edx
	andl	$16711680, %edx                 # imm = 0xFF0000
	sarl	$16, %edx
	movl	$255, %ecx
	subl	%edx, %ecx
	imull	%ecx, %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$255, %eax
	subl	%ecx, %eax
	movl	%eax, -20(%rbp)
	movl	-16(%rbp), %eax
	movl	-4(%rbp), %edx
	andl	$16711680, %edx                 # imm = 0xFF0000
	sarl	$16, %edx
	movl	$255, %ecx
	subl	%edx, %ecx
	imull	%ecx, %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$255, %eax
	subl	%ecx, %eax
	movl	%eax, -24(%rbp)
	movl	-12(%rbp), %eax
	movl	-8(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	$255, %ecx
	subl	%edx, %ecx
	imull	%ecx, %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$255, %eax
	subl	%ecx, %eax
	movl	%eax, -28(%rbp)
	movl	-16(%rbp), %eax
	movl	-4(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	$255, %ecx
	subl	%edx, %ecx
	imull	%ecx, %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$255, %eax
	subl	%ecx, %eax
	movl	%eax, -32(%rbp)
	movl	-12(%rbp), %eax
	movl	-8(%rbp), %edx
	andl	$255, %edx
	movl	$255, %ecx
	subl	%edx, %ecx
	imull	%ecx, %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$255, %eax
	subl	%ecx, %eax
	movl	%eax, -36(%rbp)
	movl	-16(%rbp), %eax
	movl	-4(%rbp), %edx
	andl	$255, %edx
	movl	$255, %ecx
	subl	%edx, %ecx
	imull	%ecx, %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	$255, %eax
	subl	%ecx, %eax
	movl	%eax, -40(%rbp)
	movl	$127, %eax
	subl	-12(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	$127, %eax
	subl	-16(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	imull	-16(%rbp), %eax
	movl	$127, %ecx
	cltd
	idivl	%ecx
	shll	$24, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	movl	-20(%rbp), %eax
	imull	-24(%rbp), %eax
	movl	$255, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-52(%rbp), %eax                 # 4-byte Reload
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movl	-28(%rbp), %eax
	imull	-32(%rbp), %eax
	movl	$255, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-48(%rbp), %eax                 # 4-byte Reload
	shll	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	movl	-36(%rbp), %eax
	imull	-40(%rbp), %eax
	movl	$255, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-44(%rbp), %eax                 # 4-byte Reload
	addl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end31:
	.size	gdLayerMultiply, .Lfunc_end31-gdLayerMultiply
	.cfi_endproc
                                        # -- End function
	.globl	gdImageGetPixel                 # -- Begin function gdImageGetPixel
	.p2align	4, 0x90
	.type	gdImageGetPixel,@function
gdImageGetPixel:                        # @gdImageGetPixel
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7288(%rcx), %eax
	jl	.LBB32_7
# %bb.1:
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB32_7
# %bb.2:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7284(%rcx), %eax
	jl	.LBB32_7
# %bb.3:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB32_7
# %bb.4:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB32_6
# %bb.5:
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB32_8
.LBB32_6:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB32_8
.LBB32_7:
	movl	$0, -4(%rbp)
.LBB32_8:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end32:
	.size	gdImageGetPixel, .Lfunc_end32-gdImageGetPixel
	.cfi_endproc
                                        # -- End function
	.globl	gdImageGetTrueColorPixel        # -- Begin function gdImageGetTrueColorPixel
	.p2align	4, 0x90
	.type	gdImageGetTrueColorPixel,@function
gdImageGetTrueColorPixel:               # @gdImageGetTrueColorPixel
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movq	-16(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -28(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB33_5
# %bb.1:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-28(%rbp), %eax
	jne	.LBB33_3
# %bb.2:
	movl	$127, %eax
	movl	%eax, -32(%rbp)                 # 4-byte Spill
	jmp	.LBB33_4
.LBB33_3:
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -32(%rbp)                 # 4-byte Spill
.LBB33_4:
	movl	-32(%rbp), %eax                 # 4-byte Reload
	shll	$24, %eax
	movq	-16(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	movl	20(%rcx,%rdx,4), %ecx
	shll	$16, %ecx
	addl	%ecx, %eax
	movq	-16(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	movl	1044(%rcx,%rdx,4), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	movq	-16(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	addl	2068(%rcx,%rdx,4), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB33_6
.LBB33_5:
	movl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB33_6:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end33:
	.size	gdImageGetTrueColorPixel, .Lfunc_end33-gdImageGetTrueColorPixel
	.cfi_endproc
                                        # -- End function
	.globl	gdImageAABlend                  # -- Begin function gdImageAABlend
	.p2align	4, 0x90
	.type	gdImageAABlend,@function
gdImageAABlend:                         # @gdImageAABlend
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end34:
	.size	gdImageAABlend, .Lfunc_end34-gdImageAABlend
	.cfi_endproc
                                        # -- End function
	.globl	gdImageLine                     # -- Begin function gdImageLine
	.p2align	4, 0x90
	.type	gdImageLine,@function
gdImageLine:                            # @gdImageLine
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	cmpl	$-7, -28(%rbp)
	jne	.LBB35_2
# %bb.1:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movq	-8(%rbp), %rax
	movl	7276(%rax), %r9d
	callq	gdImageAALine
	jmp	.LBB35_84
.LBB35_2:
	movq	-8(%rbp), %rax
	movl	7284(%rax), %r8d
	movq	-8(%rbp), %rax
	movl	7292(%rax), %r9d
	leaq	-12(%rbp), %rdi
	leaq	-16(%rbp), %rsi
	leaq	-20(%rbp), %rdx
	leaq	-24(%rbp), %rcx
	callq	clip_1d
	cmpl	$0, %eax
	jne	.LBB35_4
# %bb.3:
	jmp	.LBB35_84
.LBB35_4:
	movq	-8(%rbp), %rax
	movl	7288(%rax), %r8d
	movq	-8(%rbp), %rax
	movl	7296(%rax), %r9d
	leaq	-16(%rbp), %rdi
	leaq	-12(%rbp), %rsi
	leaq	-24(%rbp), %rdx
	leaq	-20(%rbp), %rcx
	callq	clip_1d
	cmpl	$0, %eax
	jne	.LBB35_6
# %bb.5:
	jmp	.LBB35_84
.LBB35_6:
	movq	-8(%rbp), %rax
	movl	6220(%rax), %eax
	movl	%eax, -88(%rbp)
	movl	-20(%rbp), %edi
	subl	-12(%rbp), %edi
	callq	abs@PLT
	movl	%eax, -32(%rbp)
	movl	-24(%rbp), %edi
	subl	-16(%rbp), %edi
	callq	abs@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, -32(%rbp)
	jne	.LBB35_8
# %bb.7:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageVLine
	jmp	.LBB35_84
.LBB35_8:
	cmpl	$0, -36(%rbp)
	jne	.LBB35_10
# %bb.9:
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageHLine
	jmp	.LBB35_84
.LBB35_10:
	jmp	.LBB35_11
.LBB35_11:
	movl	-36(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jg	.LBB35_48
# %bb.12:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	cos@PLT
	movsd	%xmm0, -96(%rbp)
	movsd	-96(%rbp), %xmm0                # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB35_13
	jp	.LBB35_13
	jmp	.LBB35_14
.LBB35_13:
	cvtsi2sdl	-88(%rbp), %xmm0
	divsd	-96(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB35_15
.LBB35_14:
	movl	$1, -76(%rbp)
.LBB35_15:
	cmpl	$0, -76(%rbp)
	jne	.LBB35_17
# %bb.16:
	movl	$1, -76(%rbp)
.LBB35_17:
	movl	-36(%rbp), %eax
	shll	$1, %eax
	subl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-36(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -40(%rbp)
	movl	-36(%rbp), %eax
	subl	-32(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.LBB35_19
# %bb.18:
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$-1, -72(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB35_20
.LBB35_19:
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$1, -72(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -60(%rbp)
.LBB35_20:
	movl	-56(%rbp), %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	movl	-76(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-108(%rbp), %eax                # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB35_21:                              # =>This Inner Loop Header: Depth=1
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB35_24
# %bb.22:                               #   in Loop: Header=BB35_21 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.23:                               #   in Loop: Header=BB35_21 Depth=1
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB35_21
.LBB35_24:
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	imull	-72(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB35_36
# %bb.25:
	jmp	.LBB35_26
.LBB35_26:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB35_31 Depth 2
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB35_35
# %bb.27:                               #   in Loop: Header=BB35_26 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB35_29
# %bb.28:                               #   in Loop: Header=BB35_26 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB35_30
.LBB35_29:                              #   in Loop: Header=BB35_26 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB35_30:                              #   in Loop: Header=BB35_26 Depth=1
	movl	-56(%rbp), %eax
	movl	%eax, -112(%rbp)                # 4-byte Spill
	movl	-76(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-112(%rbp), %eax                # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB35_31:                              #   Parent Loop BB35_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB35_34
# %bb.32:                               #   in Loop: Header=BB35_31 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.33:                               #   in Loop: Header=BB35_31 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB35_31
.LBB35_34:                              #   in Loop: Header=BB35_26 Depth=1
	jmp	.LBB35_26
.LBB35_35:
	jmp	.LBB35_47
.LBB35_36:
	jmp	.LBB35_37
.LBB35_37:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB35_42 Depth 2
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB35_46
# %bb.38:                               #   in Loop: Header=BB35_37 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB35_40
# %bb.39:                               #   in Loop: Header=BB35_37 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB35_41
.LBB35_40:                              #   in Loop: Header=BB35_37 Depth=1
	movl	-56(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB35_41:                              #   in Loop: Header=BB35_37 Depth=1
	movl	-56(%rbp), %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
	movl	-76(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-116(%rbp), %eax                # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB35_42:                              #   Parent Loop BB35_37 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB35_45
# %bb.43:                               #   in Loop: Header=BB35_42 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.44:                               #   in Loop: Header=BB35_42 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB35_42
.LBB35_45:                              #   in Loop: Header=BB35_37 Depth=1
	jmp	.LBB35_37
.LBB35_46:
	jmp	.LBB35_47
.LBB35_47:
	jmp	.LBB35_84
.LBB35_48:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -104(%rbp)
	movsd	-104(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB35_49
	jp	.LBB35_49
	jmp	.LBB35_50
.LBB35_49:
	cvtsi2sdl	-88(%rbp), %xmm0
	divsd	-104(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB35_51
.LBB35_50:
	movl	$1, -76(%rbp)
.LBB35_51:
	cmpl	$0, -76(%rbp)
	jne	.LBB35_53
# %bb.52:
	movl	$1, -76(%rbp)
.LBB35_53:
	movl	-32(%rbp), %eax
	shll	$1, %eax
	subl	-36(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-32(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -40(%rbp)
	movl	-32(%rbp), %eax
	subl	-36(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.LBB35_55
# %bb.54:
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$-1, -68(%rbp)
	jmp	.LBB35_56
.LBB35_55:
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$1, -68(%rbp)
.LBB35_56:
	movl	-52(%rbp), %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
	movl	-76(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-120(%rbp), %eax                # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB35_57:                              # =>This Inner Loop Header: Depth=1
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB35_60
# %bb.58:                               #   in Loop: Header=BB35_57 Depth=1
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.59:                               #   in Loop: Header=BB35_57 Depth=1
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB35_57
.LBB35_60:
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	imull	-68(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB35_72
# %bb.61:
	jmp	.LBB35_62
.LBB35_62:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB35_67 Depth 2
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB35_71
# %bb.63:                               #   in Loop: Header=BB35_62 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB35_65
# %bb.64:                               #   in Loop: Header=BB35_62 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB35_66
.LBB35_65:                              #   in Loop: Header=BB35_62 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB35_66:                              #   in Loop: Header=BB35_62 Depth=1
	movl	-52(%rbp), %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
	movl	-76(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-124(%rbp), %eax                # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB35_67:                              #   Parent Loop BB35_62 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB35_70
# %bb.68:                               #   in Loop: Header=BB35_67 Depth=2
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.69:                               #   in Loop: Header=BB35_67 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB35_67
.LBB35_70:                              #   in Loop: Header=BB35_62 Depth=1
	jmp	.LBB35_62
.LBB35_71:
	jmp	.LBB35_83
.LBB35_72:
	jmp	.LBB35_73
.LBB35_73:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB35_78 Depth 2
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB35_82
# %bb.74:                               #   in Loop: Header=BB35_73 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB35_76
# %bb.75:                               #   in Loop: Header=BB35_73 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB35_77
.LBB35_76:                              #   in Loop: Header=BB35_73 Depth=1
	movl	-52(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB35_77:                              #   in Loop: Header=BB35_73 Depth=1
	movl	-52(%rbp), %eax
	movl	%eax, -128(%rbp)                # 4-byte Spill
	movl	-76(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-128(%rbp), %eax                # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB35_78:                              #   Parent Loop BB35_73 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB35_81
# %bb.79:                               #   in Loop: Header=BB35_78 Depth=2
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.80:                               #   in Loop: Header=BB35_78 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB35_78
.LBB35_81:                              #   in Loop: Header=BB35_73 Depth=1
	jmp	.LBB35_73
.LBB35_82:
	jmp	.LBB35_83
.LBB35_83:
	jmp	.LBB35_84
.LBB35_84:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end35:
	.size	gdImageLine, .Lfunc_end35-gdImageLine
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function gdImageAALine
.LCPI36_0:
	.quad	0x7fffffffffffffff              # double NaN
	.quad	0x7fffffffffffffff              # double NaN
	.text
	.p2align	4, 0x90
	.type	gdImageAALine,@function
gdImageAALine:                          # @gdImageAALine
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movq	-8(%rbp), %rax
	movl	6220(%rax), %eax
	movl	%eax, -104(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB36_2
# %bb.1:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine
	jmp	.LBB36_56
.LBB36_2:
	movq	-8(%rbp), %rax
	movl	7284(%rax), %r8d
	movq	-8(%rbp), %rax
	movl	7292(%rax), %r9d
	leaq	-12(%rbp), %rdi
	leaq	-16(%rbp), %rsi
	leaq	-20(%rbp), %rdx
	leaq	-24(%rbp), %rcx
	callq	clip_1d
	cmpl	$0, %eax
	jne	.LBB36_4
# %bb.3:
	jmp	.LBB36_56
.LBB36_4:
	movq	-8(%rbp), %rax
	movl	7288(%rax), %r8d
	movq	-8(%rbp), %rax
	movl	7296(%rax), %r9d
	leaq	-16(%rbp), %rdi
	leaq	-12(%rbp), %rsi
	leaq	-24(%rbp), %rdx
	leaq	-20(%rbp), %rcx
	callq	clip_1d
	cmpl	$0, %eax
	jne	.LBB36_6
# %bb.5:
	jmp	.LBB36_56
.LBB36_6:
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	cltq
	movq	%rax, -72(%rbp)
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	cltq
	movq	%rax, -80(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB36_9
# %bb.7:
	cmpq	$0, -80(%rbp)
	jne	.LBB36_9
# %bb.8:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	$255, %r8d
	callq	gdImageSetAAPixelColor
	jmp	.LBB36_56
.LBB36_9:
	movq	-80(%rbp), %rax
	movl	%eax, %edi
	callq	abs@PLT
	movl	%eax, -116(%rbp)                # 4-byte Spill
	movq	-72(%rbp), %rax
	movl	%eax, %edi
	callq	abs@PLT
	movl	%eax, %ecx
	movl	-116(%rbp), %eax                # 4-byte Reload
	cmpl	%ecx, %eax
	jge	.LBB36_11
# %bb.10:
	cvtsi2sdq	-80(%rbp), %xmm0
	cvtsi2sdq	-72(%rbp), %xmm1
	callq	atan2@PLT
	callq	cos@PLT
	movsd	%xmm0, -128(%rbp)               # 8-byte Spill
	jmp	.LBB36_12
.LBB36_11:
	cvtsi2sdq	-80(%rbp), %xmm0
	cvtsi2sdq	-72(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -128(%rbp)               # 8-byte Spill
.LBB36_12:
	movsd	-128(%rbp), %xmm0               # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movaps	.LCPI36_0(%rip), %xmm1          # xmm1 = [NaN,NaN]
	pand	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB36_13
	jp	.LBB36_13
	jmp	.LBB36_14
.LBB36_13:
	cvtsi2sdl	-104(%rbp), %xmm0
	divsd	-112(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -96(%rbp)
	jmp	.LBB36_15
.LBB36_14:
	movl	$1, -96(%rbp)
.LBB36_15:
	cmpl	$0, -96(%rbp)
	jne	.LBB36_17
# %bb.16:
	movl	$1, -96(%rbp)
.LBB36_17:
	jmp	.LBB36_18
.LBB36_18:
	cmpq	$0, -72(%rbp)
	jne	.LBB36_20
# %bb.19:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageVLine
	jmp	.LBB36_56
.LBB36_20:
	cmpq	$0, -80(%rbp)
	jne	.LBB36_22
# %bb.21:
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageHLine
	jmp	.LBB36_56
.LBB36_22:
	jmp	.LBB36_23
.LBB36_23:
	movq	-72(%rbp), %rax
	movl	%eax, %edi
	callq	abs@PLT
	movl	%eax, -132(%rbp)                # 4-byte Spill
	movq	-80(%rbp), %rax
	movl	%eax, %edi
	callq	abs@PLT
	movl	%eax, %ecx
	movl	-132(%rbp), %eax                # 4-byte Reload
	cmpl	%ecx, %eax
	jle	.LBB36_40
# %bb.24:
	cmpq	$0, -72(%rbp)
	jge	.LBB36_26
# %bb.25:
	movslq	-12(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movq	-88(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -20(%rbp)
	movslq	-16(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movq	-88(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -24(%rbp)
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	cltq
	movq	%rax, -72(%rbp)
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	cltq
	movq	%rax, -80(%rbp)
.LBB36_26:
	movslq	-16(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-80(%rbp), %rax
	shlq	$16, %rax
	cqto
	idivq	-72(%rbp)
	movq	%rax, -56(%rbp)
	movq	$0, -64(%rbp)
	movslq	-12(%rbp), %rax
	movq	%rax, -40(%rbp)
.LBB36_27:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_29 Depth 2
	movq	-40(%rbp), %rax
	movslq	-20(%rbp), %rcx
	cmpq	%rcx, %rax
	jg	.LBB36_39
# %bb.28:                               #   in Loop: Header=BB36_27 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, -144(%rbp)                # 8-byte Spill
	movl	-96(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movq	-144(%rbp), %rax                # 8-byte Reload
	movslq	%ecx, %rcx
	subq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, -92(%rbp)
.LBB36_29:                              #   Parent Loop BB36_27 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-92(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	-96(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_32
# %bb.30:                               #   in Loop: Header=BB36_29 Depth=2
	movq	-8(%rbp), %rdi
	movq	-40(%rbp), %rax
	movl	%eax, %esi
	movl	-92(%rbp), %edx
	movl	-28(%rbp), %ecx
	movq	-64(%rbp), %rax
	sarq	$8, %rax
	andq	$255, %rax
	movl	%eax, %r8d
	callq	gdImageSetAAPixelColor
	movq	-8(%rbp), %rdi
	movq	-40(%rbp), %rax
	movl	%eax, %esi
	movl	-92(%rbp), %edx
	addl	$1, %edx
	movl	-28(%rbp), %ecx
	movq	-64(%rbp), %rax
	xorq	$-1, %rax
	sarq	$8, %rax
	andq	$255, %rax
	movl	%eax, %r8d
	callq	gdImageSetAAPixelColor
# %bb.31:                               #   in Loop: Header=BB36_29 Depth=2
	movl	-92(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -92(%rbp)
	jmp	.LBB36_29
.LBB36_32:                              #   in Loop: Header=BB36_27 Depth=1
	movq	-56(%rbp), %rax
	addq	-64(%rbp), %rax
	movq	%rax, -64(%rbp)
	cmpq	$65536, -64(%rbp)               # imm = 0x10000
	jl	.LBB36_34
# %bb.33:                               #   in Loop: Header=BB36_27 Depth=1
	movq	-64(%rbp), %rax
	subq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB36_37
.LBB36_34:                              #   in Loop: Header=BB36_27 Depth=1
	cmpq	$0, -64(%rbp)
	jge	.LBB36_36
# %bb.35:                               #   in Loop: Header=BB36_27 Depth=1
	movq	-64(%rbp), %rax
	addq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-48(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -48(%rbp)
.LBB36_36:                              #   in Loop: Header=BB36_27 Depth=1
	jmp	.LBB36_37
.LBB36_37:                              #   in Loop: Header=BB36_27 Depth=1
	jmp	.LBB36_38
.LBB36_38:                              #   in Loop: Header=BB36_27 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB36_27
.LBB36_39:
	jmp	.LBB36_56
.LBB36_40:
	cmpq	$0, -80(%rbp)
	jge	.LBB36_42
# %bb.41:
	movslq	-12(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movq	-88(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -20(%rbp)
	movslq	-16(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movq	-88(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -24(%rbp)
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	cltq
	movq	%rax, -72(%rbp)
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	cltq
	movq	%rax, -80(%rbp)
.LBB36_42:
	movslq	-12(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-72(%rbp), %rax
	shlq	$16, %rax
	cqto
	idivq	-80(%rbp)
	movq	%rax, -56(%rbp)
	movq	$0, -64(%rbp)
	movslq	-16(%rbp), %rax
	movq	%rax, -48(%rbp)
.LBB36_43:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_45 Depth 2
	movq	-48(%rbp), %rax
	movslq	-24(%rbp), %rcx
	cmpq	%rcx, %rax
	jg	.LBB36_55
# %bb.44:                               #   in Loop: Header=BB36_43 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -152(%rbp)                # 8-byte Spill
	movl	-96(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movq	-152(%rbp), %rax                # 8-byte Reload
	movslq	%ecx, %rcx
	subq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, -92(%rbp)
.LBB36_45:                              #   Parent Loop BB36_43 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-92(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	-96(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_48
# %bb.46:                               #   in Loop: Header=BB36_45 Depth=2
	movq	-8(%rbp), %rdi
	movl	-92(%rbp), %esi
	movq	-48(%rbp), %rax
	movl	%eax, %edx
	movl	-28(%rbp), %ecx
	movq	-64(%rbp), %rax
	sarq	$8, %rax
	andq	$255, %rax
	movl	%eax, %r8d
	callq	gdImageSetAAPixelColor
	movq	-8(%rbp), %rdi
	movl	-92(%rbp), %esi
	addl	$1, %esi
	movq	-48(%rbp), %rax
	movl	%eax, %edx
	movl	-28(%rbp), %ecx
	movq	-64(%rbp), %rax
	xorq	$-1, %rax
	sarq	$8, %rax
	andq	$255, %rax
	movl	%eax, %r8d
	callq	gdImageSetAAPixelColor
# %bb.47:                               #   in Loop: Header=BB36_45 Depth=2
	movl	-92(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -92(%rbp)
	jmp	.LBB36_45
.LBB36_48:                              #   in Loop: Header=BB36_43 Depth=1
	movq	-56(%rbp), %rax
	addq	-64(%rbp), %rax
	movq	%rax, -64(%rbp)
	cmpq	$65536, -64(%rbp)               # imm = 0x10000
	jl	.LBB36_50
# %bb.49:                               #   in Loop: Header=BB36_43 Depth=1
	movq	-64(%rbp), %rax
	subq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB36_53
.LBB36_50:                              #   in Loop: Header=BB36_43 Depth=1
	cmpq	$0, -64(%rbp)
	jge	.LBB36_52
# %bb.51:                               #   in Loop: Header=BB36_43 Depth=1
	movq	-64(%rbp), %rax
	addq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-40(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -40(%rbp)
.LBB36_52:                              #   in Loop: Header=BB36_43 Depth=1
	jmp	.LBB36_53
.LBB36_53:                              #   in Loop: Header=BB36_43 Depth=1
	jmp	.LBB36_54
.LBB36_54:                              #   in Loop: Header=BB36_43 Depth=1
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB36_43
.LBB36_55:
	jmp	.LBB36_56
.LBB36_56:
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end36:
	.size	gdImageAALine, .Lfunc_end36-gdImageAALine
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function clip_1d
	.type	clip_1d,@function
clip_1d:                                # @clip_1d
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
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movl	%r9d, -48(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB37_6
# %bb.1:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB37_3
# %bb.2:
	movl	$0, -4(%rbp)
	jmp	.LBB37_17
.LBB37_3:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm0
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movq	-16(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	subl	-44(%rbp), %eax
	cvtsi2sd	%eax, %xmm1
	mulsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %edx
	movq	-24(%rbp), %rax
	movl	(%rax), %ecx
	subl	%edx, %ecx
	movl	%ecx, (%rax)
	movl	-44(%rbp), %ecx
	movq	-16(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB37_5
# %bb.4:
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movl	-48(%rbp), %eax
	movq	-32(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm2
	movq	-40(%rbp), %rax
	cvtsi2sdl	(%rax), %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %ecx
	movl	%ecx, (%rax)
	movl	-48(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
.LBB37_5:
	movl	$1, -4(%rbp)
	jmp	.LBB37_17
.LBB37_6:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB37_12
# %bb.7:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB37_9
# %bb.8:
	movl	$0, -4(%rbp)
	jmp	.LBB37_17
.LBB37_9:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm0
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movq	-16(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movl	-48(%rbp), %eax
	movq	-16(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm1
	mulsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %ecx
	movq	-24(%rbp), %rax
	addl	(%rax), %ecx
	movl	%ecx, (%rax)
	movl	-48(%rbp), %ecx
	movq	-16(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB37_11
# %bb.10:
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	subl	-44(%rbp), %eax
	cvtsi2sd	%eax, %xmm1
	mulsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %ecx
	subl	%edx, %ecx
	movl	%ecx, (%rax)
	movl	-44(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
.LBB37_11:
	movl	$1, -4(%rbp)
	jmp	.LBB37_17
.LBB37_12:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB37_14
# %bb.13:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm0
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movq	-16(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movl	-48(%rbp), %eax
	movq	-32(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm1
	mulsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %ecx
	movq	-40(%rbp), %rax
	addl	(%rax), %ecx
	movl	%ecx, (%rax)
	movl	-48(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB37_17
.LBB37_14:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB37_16
# %bb.15:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm0
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movq	-16(%rbp), %rcx
	subl	(%rcx), %eax
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	subl	-44(%rbp), %eax
	cvtsi2sd	%eax, %xmm1
	mulsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %ecx
	subl	%edx, %ecx
	movl	%ecx, (%rax)
	movl	-44(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB37_17
.LBB37_16:
	movl	$1, -4(%rbp)
.LBB37_17:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end37:
	.size	clip_1d, .Lfunc_end37-clip_1d
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdImageVLine
	.type	gdImageVLine,@function
gdImageVLine:                           # @gdImageVLine
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$1, 6220(%rax)
	jle	.LBB38_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	6220(%rax), %eax
	sarl	$1, %eax
	movl	%eax, -28(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	subl	-28(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	addl	6220(%rax), %ecx
	subl	-28(%rbp), %ecx
	subl	$1, %ecx
	movl	-20(%rbp), %r8d
	movl	-24(%rbp), %r9d
	callq	gdImageFilledRectangle
	jmp	.LBB38_9
.LBB38_2:
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB38_4
# %bb.3:
	movl	-16(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB38_4:
	jmp	.LBB38_5
.LBB38_5:                               # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB38_8
# %bb.6:                                #   in Loop: Header=BB38_5 Depth=1
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.7:                                #   in Loop: Header=BB38_5 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB38_5
.LBB38_8:
	jmp	.LBB38_9
.LBB38_9:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end38:
	.size	gdImageVLine, .Lfunc_end38-gdImageVLine
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdImageHLine
	.type	gdImageHLine,@function
gdImageHLine:                           # @gdImageHLine
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$1, 6220(%rax)
	jle	.LBB39_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	6220(%rax), %eax
	sarl	$1, %eax
	movl	%eax, -28(%rbp)
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	subl	-28(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-12(%rbp), %r8d
	movq	-8(%rbp), %rax
	addl	6220(%rax), %r8d
	subl	-28(%rbp), %r8d
	subl	$1, %r8d
	movl	-24(%rbp), %r9d
	callq	gdImageFilledRectangle
	jmp	.LBB39_9
.LBB39_2:
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB39_4
# %bb.3:
	movl	-20(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -16(%rbp)
.LBB39_4:
	jmp	.LBB39_5
.LBB39_5:                               # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB39_8
# %bb.6:                                #   in Loop: Header=BB39_5 Depth=1
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.7:                                #   in Loop: Header=BB39_5 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB39_5
.LBB39_8:
	jmp	.LBB39_9
.LBB39_9:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end39:
	.size	gdImageHLine, .Lfunc_end39-gdImageHLine
	.cfi_endproc
                                        # -- End function
	.globl	gdImageDashedLine               # -- Begin function gdImageDashedLine
	.p2align	4, 0x90
	.type	gdImageDashedLine,@function
gdImageDashedLine:                      # @gdImageDashedLine
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movl	$0, -76(%rbp)
	movl	$1, -80(%rbp)
	movq	-8(%rbp), %rax
	movl	6220(%rax), %eax
	movl	%eax, -92(%rbp)
	movl	-20(%rbp), %edi
	subl	-12(%rbp), %edi
	callq	abs@PLT
	movl	%eax, -32(%rbp)
	movl	-24(%rbp), %edi
	subl	-16(%rbp), %edi
	callq	abs@PLT
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jg	.LBB40_23
# %bb.1:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -104(%rbp)
	movsd	-104(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB40_2
	jp	.LBB40_2
	jmp	.LBB40_3
.LBB40_2:
	cvtsi2sdl	-92(%rbp), %xmm0
	divsd	-104(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB40_4
.LBB40_3:
	movl	$1, -84(%rbp)
.LBB40_4:
	movl	$1, -88(%rbp)
	movl	-36(%rbp), %eax
	shll	$1, %eax
	subl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-36(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -40(%rbp)
	movl	-36(%rbp), %eax
	subl	-32(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.LBB40_6
# %bb.5:
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$-1, -72(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB40_7
.LBB40_6:
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$1, -72(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -60(%rbp)
.LBB40_7:
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-84(%rbp), %r10d
	movl	-88(%rbp), %eax
	leaq	-80(%rbp), %r8
	leaq	-76(%rbp), %r9
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	callq	dashedSet
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	imull	-72(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB40_15
# %bb.8:
	jmp	.LBB40_9
.LBB40_9:                               # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB40_14
# %bb.10:                               #   in Loop: Header=BB40_9 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB40_12
# %bb.11:                               #   in Loop: Header=BB40_9 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB40_13
.LBB40_12:                              #   in Loop: Header=BB40_9 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB40_13:                              #   in Loop: Header=BB40_9 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-84(%rbp), %r10d
	movl	-88(%rbp), %eax
	leaq	-80(%rbp), %r8
	leaq	-76(%rbp), %r9
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	callq	dashedSet
	jmp	.LBB40_9
.LBB40_14:
	jmp	.LBB40_22
.LBB40_15:
	jmp	.LBB40_16
.LBB40_16:                              # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB40_21
# %bb.17:                               #   in Loop: Header=BB40_16 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB40_19
# %bb.18:                               #   in Loop: Header=BB40_16 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB40_20
.LBB40_19:                              #   in Loop: Header=BB40_16 Depth=1
	movl	-56(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB40_20:                              #   in Loop: Header=BB40_16 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-84(%rbp), %r10d
	movl	-88(%rbp), %eax
	leaq	-80(%rbp), %r8
	leaq	-76(%rbp), %r9
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	callq	dashedSet
	jmp	.LBB40_16
.LBB40_21:
	jmp	.LBB40_22
.LBB40_22:
	jmp	.LBB40_45
.LBB40_23:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -112(%rbp)
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB40_24
	jp	.LBB40_24
	jmp	.LBB40_25
.LBB40_24:
	cvtsi2sdl	-92(%rbp), %xmm0
	divsd	-112(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB40_26
.LBB40_25:
	movl	$1, -84(%rbp)
.LBB40_26:
	movl	$0, -88(%rbp)
	movl	-32(%rbp), %eax
	shll	$1, %eax
	subl	-36(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-32(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -40(%rbp)
	movl	-32(%rbp), %eax
	subl	-36(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.LBB40_28
# %bb.27:
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$-1, -68(%rbp)
	jmp	.LBB40_29
.LBB40_28:
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$1, -68(%rbp)
.LBB40_29:
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-84(%rbp), %r10d
	movl	-88(%rbp), %eax
	leaq	-80(%rbp), %r8
	leaq	-76(%rbp), %r9
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	callq	dashedSet
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	imull	-68(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB40_37
# %bb.30:
	jmp	.LBB40_31
.LBB40_31:                              # =>This Inner Loop Header: Depth=1
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB40_36
# %bb.32:                               #   in Loop: Header=BB40_31 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB40_34
# %bb.33:                               #   in Loop: Header=BB40_31 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB40_35
.LBB40_34:                              #   in Loop: Header=BB40_31 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB40_35:                              #   in Loop: Header=BB40_31 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-84(%rbp), %r10d
	movl	-88(%rbp), %eax
	leaq	-80(%rbp), %r8
	leaq	-76(%rbp), %r9
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	callq	dashedSet
	jmp	.LBB40_31
.LBB40_36:
	jmp	.LBB40_44
.LBB40_37:
	jmp	.LBB40_38
.LBB40_38:                              # =>This Inner Loop Header: Depth=1
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB40_43
# %bb.39:                               #   in Loop: Header=BB40_38 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB40_41
# %bb.40:                               #   in Loop: Header=BB40_38 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB40_42
.LBB40_41:                              #   in Loop: Header=BB40_38 Depth=1
	movl	-52(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB40_42:                              #   in Loop: Header=BB40_38 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-84(%rbp), %r10d
	movl	-88(%rbp), %eax
	leaq	-80(%rbp), %r8
	leaq	-76(%rbp), %r9
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	callq	dashedSet
	jmp	.LBB40_38
.LBB40_43:
	jmp	.LBB40_44
.LBB40_44:
	jmp	.LBB40_45
.LBB40_45:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end40:
	.size	gdImageDashedLine, .Lfunc_end40-gdImageDashedLine
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function dashedSet
	.type	dashedSet,@function
dashedSet:                              # @dashedSet
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movq	%r9, -40(%rbp)
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -48(%rbp)
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	cmpl	$4, -44(%rbp)
	jne	.LBB41_2
# %bb.1:
	movl	$0, -44(%rbp)
	cmpl	$0, -48(%rbp)
	setne	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -48(%rbp)
.LBB41_2:
	cmpl	$0, -48(%rbp)
	je	.LBB41_15
# %bb.3:
	cmpl	$0, 24(%rbp)
	je	.LBB41_9
# %bb.4:
	movl	-16(%rbp), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	movl	16(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-60(%rbp), %eax                 # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -52(%rbp)
.LBB41_5:                               # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	movl	-56(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB41_8
# %bb.6:                                #   in Loop: Header=BB41_5 Depth=1
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-52(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.7:                                #   in Loop: Header=BB41_5 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB41_5
.LBB41_8:
	jmp	.LBB41_14
.LBB41_9:
	movl	-12(%rbp), %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	movl	16(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-64(%rbp), %eax                 # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -52(%rbp)
.LBB41_10:                              # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	movl	-56(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB41_13
# %bb.11:                               #   in Loop: Header=BB41_10 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.12:                               #   in Loop: Header=BB41_10 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB41_10
.LBB41_13:
	jmp	.LBB41_14
.LBB41_14:
	jmp	.LBB41_15
.LBB41_15:
	movl	-44(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-48(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end41:
	.size	dashedSet, .Lfunc_end41-dashedSet
	.cfi_endproc
                                        # -- End function
	.globl	gdImageBoundsSafe               # -- Begin function gdImageBoundsSafe
	.p2align	4, 0x90
	.type	gdImageBoundsSafe,@function
gdImageBoundsSafe:                      # @gdImageBoundsSafe
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rdx
	movb	$1, %al
	cmpl	7288(%rdx), %ecx
	movb	%al, -17(%rbp)                  # 1-byte Spill
	jl	.LBB42_5
# %bb.1:
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rdx
	movb	$1, %al
	cmpl	7296(%rdx), %ecx
	movb	%al, -17(%rbp)                  # 1-byte Spill
	jg	.LBB42_5
# %bb.2:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rdx
	movb	$1, %al
	cmpl	7284(%rdx), %ecx
	movb	%al, -18(%rbp)                  # 1-byte Spill
	jl	.LBB42_4
# %bb.3:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	setg	%al
	movb	%al, -18(%rbp)                  # 1-byte Spill
.LBB42_4:
	movb	-18(%rbp), %al                  # 1-byte Reload
	movb	%al, -17(%rbp)                  # 1-byte Spill
.LBB42_5:
	movb	-17(%rbp), %al                  # 1-byte Reload
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end42:
	.size	gdImageBoundsSafe, .Lfunc_end42-gdImageBoundsSafe
	.cfi_endproc
                                        # -- End function
	.globl	gdImageChar                     # -- Begin function gdImageChar
	.p2align	4, 0x90
	.type	gdImageChar,@function
gdImageChar:                            # @gdImageChar
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -40(%rbp)
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4(%rcx), %eax
	jl	.LBB43_2
# %bb.1:
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	4(%rcx), %ecx
	movq	-16(%rbp), %rdx
	addl	(%rdx), %ecx
	cmpl	%ecx, %eax
	jl	.LBB43_3
.LBB43_2:
	jmp	.LBB43_13
.LBB43_3:
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	subl	4(%rcx), %eax
	movq	-16(%rbp), %rcx
	imull	12(%rcx), %eax
	movq	-16(%rbp), %rcx
	imull	8(%rcx), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB43_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB43_6 Depth 2
	movl	-48(%rbp), %eax
	movl	-24(%rbp), %ecx
	movq	-16(%rbp), %rdx
	addl	12(%rdx), %ecx
	cmpl	%ecx, %eax
	jge	.LBB43_13
# %bb.5:                                #   in Loop: Header=BB43_4 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB43_6:                               #   Parent Loop BB43_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-20(%rbp), %ecx
	movq	-16(%rbp), %rdx
	addl	8(%rdx), %ecx
	cmpl	%ecx, %eax
	jge	.LBB43_11
# %bb.7:                                #   in Loop: Header=BB43_6 Depth=2
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	-52(%rbp), %ecx
	movl	-40(%rbp), %edx
	movq	-16(%rbp), %rsi
	imull	8(%rsi), %edx
	addl	%edx, %ecx
	addl	-36(%rbp), %ecx
	movslq	%ecx, %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB43_9
# %bb.8:                                #   in Loop: Header=BB43_6 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-32(%rbp), %ecx
	callq	gdImageSetPixel
.LBB43_9:                               #   in Loop: Header=BB43_6 Depth=2
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
# %bb.10:                               #   in Loop: Header=BB43_6 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB43_6
.LBB43_11:                              #   in Loop: Header=BB43_4 Depth=1
	movl	$0, -36(%rbp)
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
# %bb.12:                               #   in Loop: Header=BB43_4 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB43_4
.LBB43_13:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end43:
	.size	gdImageChar, .Lfunc_end43-gdImageChar
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCharUp                   # -- Begin function gdImageCharUp
	.p2align	4, 0x90
	.type	gdImageCharUp,@function
gdImageCharUp:                          # @gdImageCharUp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -40(%rbp)
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4(%rcx), %eax
	jl	.LBB44_2
# %bb.1:
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	4(%rcx), %ecx
	movq	-16(%rbp), %rdx
	addl	(%rdx), %ecx
	cmpl	%ecx, %eax
	jl	.LBB44_3
.LBB44_2:
	jmp	.LBB44_13
.LBB44_3:
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	subl	4(%rcx), %eax
	movq	-16(%rbp), %rcx
	imull	12(%rcx), %eax
	movq	-16(%rbp), %rcx
	imull	8(%rcx), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB44_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB44_6 Depth 2
	movl	-48(%rbp), %eax
	movl	-24(%rbp), %ecx
	movq	-16(%rbp), %rdx
	subl	8(%rdx), %ecx
	cmpl	%ecx, %eax
	jle	.LBB44_13
# %bb.5:                                #   in Loop: Header=BB44_4 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB44_6:                               #   Parent Loop BB44_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-20(%rbp), %ecx
	movq	-16(%rbp), %rdx
	addl	12(%rdx), %ecx
	cmpl	%ecx, %eax
	jge	.LBB44_11
# %bb.7:                                #   in Loop: Header=BB44_6 Depth=2
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	-52(%rbp), %ecx
	movl	-40(%rbp), %edx
	movq	-16(%rbp), %rsi
	imull	8(%rsi), %edx
	addl	%edx, %ecx
	addl	-36(%rbp), %ecx
	movslq	%ecx, %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB44_9
# %bb.8:                                #   in Loop: Header=BB44_6 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-32(%rbp), %ecx
	callq	gdImageSetPixel
.LBB44_9:                               #   in Loop: Header=BB44_6 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
# %bb.10:                               #   in Loop: Header=BB44_6 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB44_6
.LBB44_11:                              #   in Loop: Header=BB44_4 Depth=1
	movl	$0, -40(%rbp)
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
# %bb.12:                               #   in Loop: Header=BB44_4 Depth=1
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB44_4
.LBB44_13:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end44:
	.size	gdImageCharUp, .Lfunc_end44-gdImageCharUp
	.cfi_endproc
                                        # -- End function
	.globl	gdImageString                   # -- Begin function gdImageString
	.p2align	4, 0x90
	.type	gdImageString,@function
gdImageString:                          # @gdImageString
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
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movq	-32(%rbp), %rdi
	callq	strlen@PLT
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -44(%rbp)
	movl	$0, -40(%rbp)
.LBB45_1:                               # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB45_4
# %bb.2:                                #   in Loop: Header=BB45_1 Depth=1
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %r8
	movzbl	(%rax,%r8), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageChar
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
# %bb.3:                                #   in Loop: Header=BB45_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB45_1
.LBB45_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end45:
	.size	gdImageString, .Lfunc_end45-gdImageString
	.cfi_endproc
                                        # -- End function
	.globl	gdImageStringUp                 # -- Begin function gdImageStringUp
	.p2align	4, 0x90
	.type	gdImageStringUp,@function
gdImageStringUp:                        # @gdImageStringUp
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
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movq	-32(%rbp), %rdi
	callq	strlen@PLT
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -44(%rbp)
	movl	$0, -40(%rbp)
.LBB46_1:                               # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB46_4
# %bb.2:                                #   in Loop: Header=BB46_1 Depth=1
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %r8
	movzbl	(%rax,%r8), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageCharUp
	movq	-16(%rbp), %rax
	movl	8(%rax), %ecx
	movl	-24(%rbp), %eax
	subl	%ecx, %eax
	movl	%eax, -24(%rbp)
# %bb.3:                                #   in Loop: Header=BB46_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB46_1
.LBB46_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end46:
	.size	gdImageStringUp, .Lfunc_end46-gdImageStringUp
	.cfi_endproc
                                        # -- End function
	.globl	gdImageString16                 # -- Begin function gdImageString16
	.p2align	4, 0x90
	.type	gdImageString16,@function
gdImageString16:                        # @gdImageString16
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
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movq	-32(%rbp), %rdi
	callq	strlen16
	movl	%eax, -44(%rbp)
	movl	$0, -40(%rbp)
.LBB47_1:                               # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB47_4
# %bb.2:                                #   in Loop: Header=BB47_1 Depth=1
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %r8
	movzwl	(%rax,%r8,2), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageChar
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
# %bb.3:                                #   in Loop: Header=BB47_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB47_1
.LBB47_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end47:
	.size	gdImageString16, .Lfunc_end47-gdImageString16
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function strlen16
	.type	strlen16,@function
strlen16:                               # @strlen16
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	$0, -12(%rbp)
.LBB48_1:                               # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpw	$0, (%rax)
	je	.LBB48_3
# %bb.2:                                #   in Loop: Header=BB48_1 Depth=1
	movq	-8(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -8(%rbp)
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB48_1
.LBB48_3:
	movl	-12(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end48:
	.size	strlen16, .Lfunc_end48-strlen16
	.cfi_endproc
                                        # -- End function
	.globl	gdImageStringUp16               # -- Begin function gdImageStringUp16
	.p2align	4, 0x90
	.type	gdImageStringUp16,@function
gdImageStringUp16:                      # @gdImageStringUp16
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
	movq	%r8, -32(%rbp)
	movl	%r9d, -36(%rbp)
	movq	-32(%rbp), %rdi
	callq	strlen16
	movl	%eax, -44(%rbp)
	movl	$0, -40(%rbp)
.LBB49_1:                               # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB49_4
# %bb.2:                                #   in Loop: Header=BB49_1 Depth=1
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %r8
	movzwl	(%rax,%r8,2), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageCharUp
	movq	-16(%rbp), %rax
	movl	8(%rax), %ecx
	movl	-24(%rbp), %eax
	subl	%ecx, %eax
	movl	%eax, -24(%rbp)
# %bb.3:                                #   in Loop: Header=BB49_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB49_1
.LBB49_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end49:
	.size	gdImageStringUp16, .Lfunc_end49-gdImageStringUp16
	.cfi_endproc
                                        # -- End function
	.globl	lsqrt                           # -- Begin function lsqrt
	.p2align	4, 0x90
	.type	lsqrt,@function
lsqrt:                                  # @lsqrt
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cvtsi2sdq	-8(%rbp), %xmm0
	callq	sqrt@PLT
	cvttsd2si	%xmm0, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end50:
	.size	lsqrt, .Lfunc_end50-lsqrt
	.cfi_endproc
                                        # -- End function
	.globl	gdImageArc                      # -- Begin function gdImageArc
	.p2align	4, 0x90
	.type	gdImageArc,@function
gdImageArc:                             # @gdImageArc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	movl	16(%rbp), %r10d
	movl	24(%rbp), %eax
	movl	%r10d, (%rsp)
	movl	%eax, 8(%rsp)
	movl	$2, 16(%rsp)
	callq	gdImageFilledArc
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end51:
	.size	gdImageArc, .Lfunc_end51-gdImageArc
	.cfi_endproc
                                        # -- End function
	.globl	gdImageFilledArc                # -- Begin function gdImageFilledArc
	.p2align	4, 0x90
	.type	gdImageFilledArc,@function
gdImageFilledArc:                       # @gdImageFilledArc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movl	32(%rbp), %eax
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movl	$0, -72(%rbp)
	movl	$0, -76(%rbp)
	movl	$0, -80(%rbp)
	movl	$0, -84(%rbp)
	movl	-28(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, -96(%rbp)                 # 4-byte Spill
	movl	16(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, %eax
	movl	-96(%rbp), %edx                 # 4-byte Reload
	cmpl	%eax, %edx
	jne	.LBB52_2
# %bb.1:
	movl	$0, -28(%rbp)
	movl	$360, 16(%rbp)                  # imm = 0x168
	jmp	.LBB52_15
.LBB52_2:
	cmpl	$360, -28(%rbp)                 # imm = 0x168
	jle	.LBB52_4
# %bb.3:
	movl	-28(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, -28(%rbp)
.LBB52_4:
	cmpl	$360, 16(%rbp)                  # imm = 0x168
	jle	.LBB52_6
# %bb.5:
	movl	16(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, 16(%rbp)
.LBB52_6:
	jmp	.LBB52_7
.LBB52_7:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -28(%rbp)
	jge	.LBB52_9
# %bb.8:                                #   in Loop: Header=BB52_7 Depth=1
	movl	-28(%rbp), %eax
	addl	$360, %eax                      # imm = 0x168
	movl	%eax, -28(%rbp)
	jmp	.LBB52_7
.LBB52_9:
	jmp	.LBB52_10
.LBB52_10:                              # =>This Inner Loop Header: Depth=1
	movl	16(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB52_12
# %bb.11:                               #   in Loop: Header=BB52_10 Depth=1
	movl	16(%rbp), %eax
	addl	$360, %eax                      # imm = 0x168
	movl	%eax, 16(%rbp)
	jmp	.LBB52_10
.LBB52_12:
	movl	-28(%rbp), %eax
	cmpl	16(%rbp), %eax
	jne	.LBB52_14
# %bb.13:
	movl	$0, -28(%rbp)
	movl	$360, 16(%rbp)                  # imm = 0x168
.LBB52_14:
	jmp	.LBB52_15
.LBB52_15:
	movl	-28(%rbp), %eax
	movl	%eax, -68(%rbp)
.LBB52_16:                              # =>This Inner Loop Header: Depth=1
	movl	-68(%rbp), %eax
	cmpl	16(%rbp), %eax
	jg	.LBB52_27
# %bb.17:                               #   in Loop: Header=BB52_16 Depth=1
	movl	-68(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movslq	%edx, %rcx
	movq	gdCosT@GOTPCREL(%rip), %rax
	movslq	(%rax,%rcx,4), %rax
	movslq	-20(%rbp), %rcx
	imulq	%rcx, %rax
	movl	$2048, %ecx                     # imm = 0x800
	cqto
	idivq	%rcx
	movslq	-12(%rbp), %rcx
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -88(%rbp)
	movl	-68(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movslq	%edx, %rcx
	movq	gdSinT@GOTPCREL(%rip), %rax
	movslq	(%rax,%rcx,4), %rax
	movslq	-24(%rbp), %rcx
	imulq	%rcx, %rax
	movl	$2048, %ecx                     # imm = 0x800
	cqto
	idivq	%rcx
	movslq	-16(%rbp), %rcx
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -92(%rbp)
	movl	-68(%rbp), %eax
	cmpl	-28(%rbp), %eax
	je	.LBB52_24
# %bb.18:                               #   in Loop: Header=BB52_16 Depth=1
	movl	32(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	jne	.LBB52_23
# %bb.19:                               #   in Loop: Header=BB52_16 Depth=1
	movl	32(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB52_21
# %bb.20:                               #   in Loop: Header=BB52_16 Depth=1
	movq	-8(%rbp), %rdi
	movl	-72(%rbp), %esi
	movl	-76(%rbp), %edx
	movl	-88(%rbp), %ecx
	movl	-92(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine
	jmp	.LBB52_22
.LBB52_21:                              #   in Loop: Header=BB52_16 Depth=1
	movl	-72(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-88(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	movl	24(%rbp), %ecx
	movl	$3, %edx
	callq	gdImageFilledPolygon
.LBB52_22:                              #   in Loop: Header=BB52_16 Depth=1
	jmp	.LBB52_23
.LBB52_23:                              #   in Loop: Header=BB52_16 Depth=1
	jmp	.LBB52_25
.LBB52_24:                              #   in Loop: Header=BB52_16 Depth=1
	movl	-88(%rbp), %eax
	movl	%eax, -80(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -84(%rbp)
.LBB52_25:                              #   in Loop: Header=BB52_16 Depth=1
	movl	-88(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -76(%rbp)
# %bb.26:                               #   in Loop: Header=BB52_16 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB52_16
.LBB52_27:
	movl	32(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB52_34
# %bb.28:
	movl	32(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB52_32
# %bb.29:
	movl	32(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB52_31
# %bb.30:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-72(%rbp), %ecx
	movl	-76(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-80(%rbp), %ecx
	movl	-84(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine
.LBB52_31:
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-84(%rbp), %edx
	movl	-72(%rbp), %ecx
	movl	-76(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine
	jmp	.LBB52_33
.LBB52_32:
	movl	-80(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-72(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	movl	24(%rbp), %ecx
	movl	$3, %edx
	callq	gdImageFilledPolygon
.LBB52_33:
	jmp	.LBB52_39
.LBB52_34:
	movl	32(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB52_38
# %bb.35:
	movl	32(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB52_37
# %bb.36:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-72(%rbp), %ecx
	movl	-76(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-80(%rbp), %ecx
	movl	-84(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine
.LBB52_37:
	jmp	.LBB52_38
.LBB52_38:
	jmp	.LBB52_39
.LBB52_39:
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end52:
	.size	gdImageFilledArc, .Lfunc_end52-gdImageFilledArc
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageFilledPolygon
.LCPI53_0:
	.quad	0x3fe0000000000000              # double 0.5
	.text
	.globl	gdImageFilledPolygon
	.p2align	4, 0x90
	.type	gdImageFilledPolygon,@function
gdImageFilledPolygon:                   # @gdImageFilledPolygon
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	cmpl	$0, -20(%rbp)
	jg	.LBB53_2
# %bb.1:
	jmp	.LBB53_71
.LBB53_2:
	cmpl	$-7, -24(%rbp)
	jne	.LBB53_4
# %bb.3:
	movq	-8(%rbp), %rax
	movl	7276(%rax), %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB53_5
.LBB53_4:
	movl	-24(%rbp), %eax
	movl	%eax, -84(%rbp)
.LBB53_5:
	movq	-8(%rbp), %rax
	cmpl	$0, 4128(%rax)
	jne	.LBB53_11
# %bb.6:
	movl	-20(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB53_8
# %bb.7:
	jmp	.LBB53_71
.LBB53_8:
	movslq	-20(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 4120(%rax)
	movq	-8(%rbp), %rax
	cmpq	$0, 4120(%rax)
	jne	.LBB53_10
# %bb.9:
	jmp	.LBB53_71
.LBB53_10:
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 4128(%rax)
.LBB53_11:
	movq	-8(%rbp), %rax
	movl	4128(%rax), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB53_20
# %bb.12:
	jmp	.LBB53_13
.LBB53_13:                              # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	4128(%rax), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB53_15
# %bb.14:                               #   in Loop: Header=BB53_13 Depth=1
	movq	-8(%rbp), %rax
	movl	4128(%rax), %ecx
	shll	$1, %ecx
	movl	%ecx, 4128(%rax)
	jmp	.LBB53_13
.LBB53_15:
	movq	-8(%rbp), %rax
	movl	4128(%rax), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB53_17
# %bb.16:
	jmp	.LBB53_71
.LBB53_17:
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rdi
	movq	-8(%rbp), %rax
	movslq	4128(%rax), %rsi
	shlq	$2, %rsi
	callq	gdReallocEx@PLT
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 4120(%rax)
	movq	-8(%rbp), %rax
	cmpq	$0, 4120(%rax)
	jne	.LBB53_19
# %bb.18:
	jmp	.LBB53_71
.LBB53_19:
	jmp	.LBB53_20
.LBB53_20:
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -48(%rbp)
	movl	$1, -28(%rbp)
.LBB53_21:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB53_28
# %bb.22:                               #   in Loop: Header=BB53_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB53_24
# %bb.23:                               #   in Loop: Header=BB53_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -44(%rbp)
.LBB53_24:                              #   in Loop: Header=BB53_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB53_26
# %bb.25:                               #   in Loop: Header=BB53_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -48(%rbp)
.LBB53_26:                              #   in Loop: Header=BB53_21 Depth=1
	jmp	.LBB53_27
.LBB53_27:                              #   in Loop: Header=BB53_21 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB53_21
.LBB53_28:
	movl	-48(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7288(%rcx), %eax
	jge	.LBB53_30
# %bb.29:
	movq	-8(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB53_30:
	movl	-48(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jle	.LBB53_32
# %bb.31:
	movq	-8(%rbp), %rax
	movl	7296(%rax), %eax
	movl	%eax, -48(%rbp)
.LBB53_32:
	movl	-44(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB53_33:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB53_35 Depth 2
                                        #     Child Loop BB53_55 Depth 2
                                        #       Child Loop BB53_57 Depth 3
                                        #     Child Loop BB53_64 Depth 2
	movl	-40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jg	.LBB53_69
# %bb.34:                               #   in Loop: Header=BB53_33 Depth=1
	movl	$0, -80(%rbp)
	movl	$0, -28(%rbp)
.LBB53_35:                              #   Parent Loop BB53_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB53_54
# %bb.36:                               #   in Loop: Header=BB53_35 Depth=2
	cmpl	$0, -28(%rbp)
	jne	.LBB53_38
# %bb.37:                               #   in Loop: Header=BB53_35 Depth=2
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -72(%rbp)
	movl	$0, -76(%rbp)
	jmp	.LBB53_39
.LBB53_38:                              #   in Loop: Header=BB53_35 Depth=2
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -72(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -76(%rbp)
.LBB53_39:                              #   in Loop: Header=BB53_35 Depth=2
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -68(%rbp)
	movl	-60(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB53_41
# %bb.40:                               #   in Loop: Header=BB53_35 Depth=2
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -56(%rbp)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -64(%rbp)
	jmp	.LBB53_45
.LBB53_41:                              #   in Loop: Header=BB53_35 Depth=2
	movl	-60(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jle	.LBB53_43
# %bb.42:                               #   in Loop: Header=BB53_35 Depth=2
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -68(%rbp)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -64(%rbp)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB53_44
.LBB53_43:                              #   in Loop: Header=BB53_35 Depth=2
	jmp	.LBB53_53
.LBB53_44:                              #   in Loop: Header=BB53_35 Depth=2
	jmp	.LBB53_45
.LBB53_45:                              #   in Loop: Header=BB53_35 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.LBB53_48
# %bb.46:                               #   in Loop: Header=BB53_35 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB53_48
# %bb.47:                               #   in Loop: Header=BB53_35 Depth=2
	movl	-40(%rbp), %eax
	subl	-60(%rbp), %eax
	movl	-64(%rbp), %ecx
	subl	-56(%rbp), %ecx
	imull	%ecx, %eax
	cvtsi2ss	%eax, %xmm0
	movl	-68(%rbp), %eax
	subl	-60(%rbp), %eax
	cvtsi2ss	%eax, %xmm1
	divss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	.LCPI53_0(%rip), %xmm1          # xmm1 = mem[0],zero
	addsd	%xmm1, %xmm0
	cvtsi2sdl	-56(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-80(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -80(%rbp)
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB53_52
.LBB53_48:                              #   in Loop: Header=BB53_35 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jne	.LBB53_51
# %bb.49:                               #   in Loop: Header=BB53_35 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jne	.LBB53_51
# %bb.50:                               #   in Loop: Header=BB53_35 Depth=2
	movl	-64(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-80(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -80(%rbp)
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB53_51:                              #   in Loop: Header=BB53_35 Depth=2
	jmp	.LBB53_52
.LBB53_52:                              #   in Loop: Header=BB53_35 Depth=2
	jmp	.LBB53_53
.LBB53_53:                              #   in Loop: Header=BB53_35 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB53_35
.LBB53_54:                              #   in Loop: Header=BB53_33 Depth=1
	movl	$1, -28(%rbp)
.LBB53_55:                              #   Parent Loop BB53_33 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB53_57 Depth 3
	movl	-28(%rbp), %eax
	cmpl	-80(%rbp), %eax
	jge	.LBB53_63
# %bb.56:                               #   in Loop: Header=BB53_55 Depth=2
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -32(%rbp)
.LBB53_57:                              #   Parent Loop BB53_33 Depth=1
                                        #     Parent Loop BB53_55 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, -32(%rbp)
	movb	%al, -85(%rbp)                  # 1-byte Spill
	jle	.LBB53_59
# %bb.58:                               #   in Loop: Header=BB53_57 Depth=3
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-32(%rbp), %ecx
	subl	$1, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	-36(%rbp), %eax
	setg	%al
	movb	%al, -85(%rbp)                  # 1-byte Spill
.LBB53_59:                              #   in Loop: Header=BB53_57 Depth=3
	movb	-85(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB53_60
	jmp	.LBB53_61
.LBB53_60:                              #   in Loop: Header=BB53_57 Depth=3
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-32(%rbp), %ecx
	subl	$1, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-32(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	movl	-32(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB53_57
.LBB53_61:                              #   in Loop: Header=BB53_55 Depth=2
	movl	-36(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-32(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.62:                               #   in Loop: Header=BB53_55 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB53_55
.LBB53_63:                              #   in Loop: Header=BB53_33 Depth=1
	movl	$0, -28(%rbp)
.LBB53_64:                              #   Parent Loop BB53_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	movl	-80(%rbp), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	.LBB53_67
# %bb.65:                               #   in Loop: Header=BB53_64 Depth=2
	movq	-8(%rbp), %rdi
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %esi
	movl	-40(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-28(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %ecx
	movl	-40(%rbp), %r8d
	movl	-84(%rbp), %r9d
	callq	gdImageLine
# %bb.66:                               #   in Loop: Header=BB53_64 Depth=2
	movl	-28(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB53_64
.LBB53_67:                              #   in Loop: Header=BB53_33 Depth=1
	jmp	.LBB53_68
.LBB53_68:                              #   in Loop: Header=BB53_33 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB53_33
.LBB53_69:
	cmpl	$-7, -24(%rbp)
	jne	.LBB53_71
# %bb.70:
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImagePolygon
.LBB53_71:
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end53:
	.size	gdImageFilledPolygon, .Lfunc_end53-gdImageFilledPolygon
	.cfi_endproc
                                        # -- End function
	.globl	gdImageEllipse                  # -- Begin function gdImageEllipse
	.p2align	4, 0x90
	.type	gdImageEllipse,@function
gdImageEllipse:                         # @gdImageEllipse
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movl	$0, -32(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -48(%rbp)
	movl	-20(%rbp), %eax
	sarl	$1, %eax
	cltq
	movq	%rax, -112(%rbp)
	movl	-24(%rbp), %eax
	sarl	$1, %eax
	cltq
	movq	%rax, -120(%rbp)
	movq	-8(%rbp), %rdi
	movslq	-12(%rbp), %rax
	addq	-112(%rbp), %rax
	movl	%eax, %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	movq	-8(%rbp), %rdi
	movslq	-12(%rbp), %rax
	subq	-112(%rbp), %rax
	movl	%eax, %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	movslq	-12(%rbp), %rax
	subq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -36(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -44(%rbp)
	movslq	-12(%rbp), %rax
	addq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -40(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -48(%rbp)
	movq	-112(%rbp), %rax
	imulq	-112(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-120(%rbp), %rax
	imulq	-120(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-56(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -72(%rbp)
	movq	-64(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -80(%rbp)
	movq	-112(%rbp), %rax
	imulq	-64(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -96(%rbp)
	movq	$0, -104(%rbp)
	movq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -32(%rbp)
.LBB54_1:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -32(%rbp)
	jle	.LBB54_7
# %bb.2:                                #   in Loop: Header=BB54_1 Depth=1
	cmpq	$0, -88(%rbp)
	jle	.LBB54_4
# %bb.3:                                #   in Loop: Header=BB54_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	movq	-72(%rbp), %rax
	addq	-104(%rbp), %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rcx
	movq	-88(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -88(%rbp)
.LBB54_4:                               #   in Loop: Header=BB54_1 Depth=1
	cmpq	$0, -88(%rbp)
	jg	.LBB54_6
# %bb.5:                                #   in Loop: Header=BB54_1 Depth=1
	movl	-32(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -32(%rbp)
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	movl	-40(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -40(%rbp)
	movq	-80(%rbp), %rcx
	movq	-96(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	addq	-88(%rbp), %rax
	movq	%rax, -88(%rbp)
.LBB54_6:                               #   in Loop: Header=BB54_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB54_1
.LBB54_7:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end54:
	.size	gdImageEllipse, .Lfunc_end54-gdImageEllipse
	.cfi_endproc
                                        # -- End function
	.globl	gdImageFilledEllipse            # -- Begin function gdImageFilledEllipse
	.p2align	4, 0x90
	.type	gdImageFilledEllipse,@function
gdImageFilledEllipse:                   # @gdImageFilledEllipse
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movl	$0, -32(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -48(%rbp)
	movl	-20(%rbp), %eax
	sarl	$1, %eax
	cltq
	movq	%rax, -112(%rbp)
	movl	-24(%rbp), %eax
	sarl	$1, %eax
	cltq
	movq	%rax, -120(%rbp)
	movslq	-12(%rbp), %rax
	subq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -32(%rbp)
.LBB55_1:                               # =>This Inner Loop Header: Depth=1
	movslq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	addq	-112(%rbp), %rcx
	cmpq	%rcx, %rax
	jg	.LBB55_4
# %bb.2:                                #   in Loop: Header=BB55_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.3:                                #   in Loop: Header=BB55_1 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB55_1
.LBB55_4:
	movslq	-12(%rbp), %rax
	subq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -36(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -44(%rbp)
	movslq	-12(%rbp), %rax
	addq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -40(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -48(%rbp)
	movq	-112(%rbp), %rax
	imulq	-112(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-120(%rbp), %rax
	imulq	-120(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-56(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -72(%rbp)
	movq	-64(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -80(%rbp)
	movq	-112(%rbp), %rax
	imulq	-64(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -96(%rbp)
	movq	$0, -104(%rbp)
	movq	-112(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -32(%rbp)
	movl	$-2, -128(%rbp)
.LBB55_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB55_12 Depth 2
                                        #     Child Loop BB55_18 Depth 2
	cmpl	$0, -32(%rbp)
	jle	.LBB55_23
# %bb.6:                                #   in Loop: Header=BB55_5 Depth=1
	cmpq	$0, -88(%rbp)
	jle	.LBB55_8
# %bb.7:                                #   in Loop: Header=BB55_5 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	movq	-72(%rbp), %rax
	addq	-104(%rbp), %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rcx
	movq	-88(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -88(%rbp)
.LBB55_8:                               #   in Loop: Header=BB55_5 Depth=1
	cmpq	$0, -88(%rbp)
	jg	.LBB55_10
# %bb.9:                                #   in Loop: Header=BB55_5 Depth=1
	movl	-32(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -32(%rbp)
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	movl	-40(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -40(%rbp)
	movq	-80(%rbp), %rcx
	movq	-96(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	addq	-88(%rbp), %rax
	movq	%rax, -88(%rbp)
.LBB55_10:                              #   in Loop: Header=BB55_5 Depth=1
	movl	-128(%rbp), %eax
	cmpl	-48(%rbp), %eax
	je	.LBB55_16
# %bb.11:                               #   in Loop: Header=BB55_5 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -124(%rbp)
.LBB55_12:                              #   Parent Loop BB55_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-124(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jg	.LBB55_15
# %bb.13:                               #   in Loop: Header=BB55_12 Depth=2
	movq	-8(%rbp), %rdi
	movl	-124(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.14:                               #   in Loop: Header=BB55_12 Depth=2
	movl	-124(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -124(%rbp)
	jmp	.LBB55_12
.LBB55_15:                              #   in Loop: Header=BB55_5 Depth=1
	jmp	.LBB55_16
.LBB55_16:                              #   in Loop: Header=BB55_5 Depth=1
	movl	-128(%rbp), %eax
	cmpl	-48(%rbp), %eax
	je	.LBB55_22
# %bb.17:                               #   in Loop: Header=BB55_5 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -124(%rbp)
.LBB55_18:                              #   Parent Loop BB55_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-124(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jg	.LBB55_21
# %bb.19:                               #   in Loop: Header=BB55_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-124(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.20:                               #   in Loop: Header=BB55_18 Depth=2
	movl	-124(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -124(%rbp)
	jmp	.LBB55_18
.LBB55_21:                              #   in Loop: Header=BB55_5 Depth=1
	jmp	.LBB55_22
.LBB55_22:                              #   in Loop: Header=BB55_5 Depth=1
	movl	-48(%rbp), %eax
	movl	%eax, -128(%rbp)
	jmp	.LBB55_5
.LBB55_23:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end55:
	.size	gdImageFilledEllipse, .Lfunc_end55-gdImageFilledEllipse
	.cfi_endproc
                                        # -- End function
	.globl	gdImageFillToBorder             # -- Begin function gdImageFillToBorder
	.p2align	4, 0x90
	.type	gdImageFillToBorder,@function
gdImageFillToBorder:                    # @gdImageFillToBorder
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	cmpl	$0, -20(%rbp)
	jl	.LBB56_2
# %bb.1:
	cmpl	$0, -24(%rbp)
	jge	.LBB56_3
.LBB56_2:
	jmp	.LBB56_63
.LBB56_3:
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB56_8
# %bb.4:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	16(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jg	.LBB56_6
# %bb.5:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	16(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB56_7
.LBB56_6:
	jmp	.LBB56_63
.LBB56_7:
	jmp	.LBB56_8
.LBB56_8:
	movl	$-1, -32(%rbp)
	movq	-8(%rbp), %rax
	movl	7264(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	$0, 7264(%rax)
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB56_10
# %bb.9:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB56_13
.LBB56_10:
	cmpl	$0, -12(%rbp)
	jge	.LBB56_12
# %bb.11:
	movl	$0, -12(%rbp)
.LBB56_12:
	jmp	.LBB56_13
.LBB56_13:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB56_15
# %bb.14:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB56_18
.LBB56_15:
	cmpl	$0, -16(%rbp)
	jge	.LBB56_17
# %bb.16:
	movl	$0, -16(%rbp)
.LBB56_17:
	jmp	.LBB56_18
.LBB56_18:
	movl	-12(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB56_19:                              # =>This Inner Loop Header: Depth=1
	cmpl	$0, -40(%rbp)
	jl	.LBB56_24
# %bb.20:                               #   in Loop: Header=BB56_19 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-20(%rbp), %eax
	jne	.LBB56_22
# %bb.21:
	jmp	.LBB56_24
.LBB56_22:                              #   in Loop: Header=BB56_19 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-40(%rbp), %eax
	movl	%eax, -32(%rbp)
# %bb.23:                               #   in Loop: Header=BB56_19 Depth=1
	movl	-40(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB56_19
.LBB56_24:
	cmpl	$-1, -32(%rbp)
	jne	.LBB56_26
# %bb.25:
	movl	-44(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	jmp	.LBB56_63
.LBB56_26:
	movl	-12(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB56_27:                              # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB56_32
# %bb.28:                               #   in Loop: Header=BB56_27 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-20(%rbp), %eax
	jne	.LBB56_30
# %bb.29:
	jmp	.LBB56_32
.LBB56_30:                              #   in Loop: Header=BB56_27 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-40(%rbp), %eax
	movl	%eax, -36(%rbp)
# %bb.31:                               #   in Loop: Header=BB56_27 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB56_27
.LBB56_32:
	cmpl	$0, -16(%rbp)
	jle	.LBB56_47
# %bb.33:
	movl	$1, -28(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB56_34:                              # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jg	.LBB56_46
# %bb.35:                               #   in Loop: Header=BB56_34 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	subl	$1, %edx
	callq	gdImageGetPixel
	movl	%eax, -48(%rbp)
	cmpl	$0, -28(%rbp)
	je	.LBB56_40
# %bb.36:                               #   in Loop: Header=BB56_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB56_39
# %bb.37:                               #   in Loop: Header=BB56_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB56_39
# %bb.38:                               #   in Loop: Header=BB56_34 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	subl	$1, %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	callq	gdImageFillToBorder
	movl	$0, -28(%rbp)
.LBB56_39:                              #   in Loop: Header=BB56_34 Depth=1
	jmp	.LBB56_44
.LBB56_40:                              #   in Loop: Header=BB56_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB56_42
# %bb.41:                               #   in Loop: Header=BB56_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB56_43
.LBB56_42:                              #   in Loop: Header=BB56_34 Depth=1
	movl	$1, -28(%rbp)
.LBB56_43:                              #   in Loop: Header=BB56_34 Depth=1
	jmp	.LBB56_44
.LBB56_44:                              #   in Loop: Header=BB56_34 Depth=1
	jmp	.LBB56_45
.LBB56_45:                              #   in Loop: Header=BB56_34 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB56_34
.LBB56_46:
	jmp	.LBB56_47
.LBB56_47:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	12(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	.LBB56_62
# %bb.48:
	movl	$1, -28(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB56_49:                              # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jg	.LBB56_61
# %bb.50:                               #   in Loop: Header=BB56_49 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	callq	gdImageGetPixel
	movl	%eax, -52(%rbp)
	cmpl	$0, -28(%rbp)
	je	.LBB56_55
# %bb.51:                               #   in Loop: Header=BB56_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB56_54
# %bb.52:                               #   in Loop: Header=BB56_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB56_54
# %bb.53:                               #   in Loop: Header=BB56_49 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	callq	gdImageFillToBorder
	movl	$0, -28(%rbp)
.LBB56_54:                              #   in Loop: Header=BB56_49 Depth=1
	jmp	.LBB56_59
.LBB56_55:                              #   in Loop: Header=BB56_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB56_57
# %bb.56:                               #   in Loop: Header=BB56_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB56_58
.LBB56_57:                              #   in Loop: Header=BB56_49 Depth=1
	movl	$1, -28(%rbp)
.LBB56_58:                              #   in Loop: Header=BB56_49 Depth=1
	jmp	.LBB56_59
.LBB56_59:                              #   in Loop: Header=BB56_49 Depth=1
	jmp	.LBB56_60
.LBB56_60:                              #   in Loop: Header=BB56_49 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB56_49
.LBB56_61:
	jmp	.LBB56_62
.LBB56_62:
	movl	-44(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
.LBB56_63:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end56:
	.size	gdImageFillToBorder, .Lfunc_end56-gdImageFillToBorder
	.cfi_endproc
                                        # -- End function
	.globl	gdImageFill                     # -- Begin function gdImageFill
	.p2align	4, 0x90
	.type	gdImageFill,@function
gdImageFill:                            # @gdImageFill
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB57_3
# %bb.1:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	16(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB57_3
# %bb.2:
	jmp	.LBB57_80
.LBB57_3:
	movq	-8(%rbp), %rax
	movl	7264(%rax), %eax
	movl	%eax, -52(%rbp)
	movq	-8(%rbp), %rax
	movl	$0, 7264(%rax)
	cmpl	$-5, -20(%rbp)
	jne	.LBB57_5
# %bb.4:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	_gdImageFillTiled
	movl	-52(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	jmp	.LBB57_80
.LBB57_5:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -48(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB57_10
# %bb.6:
	cmpl	$0, -12(%rbp)
	jl	.LBB57_10
# %bb.7:
	movl	-12(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jg	.LBB57_10
# %bb.8:
	cmpl	$0, -16(%rbp)
	jl	.LBB57_10
# %bb.9:
	movl	-16(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB57_11
.LBB57_10:
	movl	-52(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	jmp	.LBB57_80
.LBB57_11:
	movq	-8(%rbp), %rax
	cmpl	$4, 8(%rax)
	jge	.LBB57_21
# %bb.12:
	movl	-12(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB57_13:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB57_14 Depth 2
	jmp	.LBB57_14
.LBB57_14:                              #   Parent Loop BB57_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rdi
	movl	-76(%rbp), %esi
	movl	-80(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	cmpl	-40(%rbp), %eax
	je	.LBB57_16
# %bb.15:
	jmp	.LBB57_79
.LBB57_16:                              #   in Loop: Header=BB57_14 Depth=2
	movq	-8(%rbp), %rdi
	movl	-76(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.17:                               #   in Loop: Header=BB57_14 Depth=2
	movl	-76(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -76(%rbp)
	movq	-8(%rbp), %rcx
	movl	8(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jl	.LBB57_14
# %bb.18:                               #   in Loop: Header=BB57_13 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -76(%rbp)
# %bb.19:                               #   in Loop: Header=BB57_13 Depth=1
	movl	-80(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -80(%rbp)
	movq	-8(%rbp), %rcx
	movl	12(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jl	.LBB57_13
# %bb.20:
	jmp	.LBB57_79
.LBB57_21:
	movq	-8(%rbp), %rax
	movl	12(%rax), %edi
	movq	-8(%rbp), %rax
	movl	8(%rax), %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB57_23
# %bb.22:
	jmp	.LBB57_80
.LBB57_23:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	imull	8(%rcx), %eax
	movl	$4, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %esi
	movl	$16, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB57_25
# %bb.24:
	jmp	.LBB57_80
.LBB57_25:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	imull	8(%rcx), %eax
	movl	$4, %ecx
	cltd
	idivl	%ecx
	movslq	%eax, %rdi
	shlq	$4, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB57_27
# %bb.26:
	jmp	.LBB57_80
.LBB57_27:
	movq	-64(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -96(%rbp)                 # 8-byte Spill
	movq	-64(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-96(%rbp), %rax                 # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB57_31
# %bb.28:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	$0, %eax
	jl	.LBB57_31
# %bb.29:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB57_31
# %bb.30:
	movl	-16(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-12(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 8(%rax)
	movq	-72(%rbp), %rax
	movl	$1, 12(%rax)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
.LBB57_31:
	movq	-72(%rbp), %rax
	movq	%rax, -104(%rbp)                # 8-byte Spill
	movq	-64(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-104(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB57_35
# %bb.32:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	$0, %eax
	jl	.LBB57_35
# %bb.33:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB57_35
# %bb.34:
	movl	-16(%rbp), %ecx
	addl	$1, %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-12(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 8(%rax)
	movq	-72(%rbp), %rax
	movl	$-1, 12(%rax)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
.LBB57_35:
	jmp	.LBB57_36
.LBB57_36:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB57_38 Depth 2
                                        #     Child Loop BB57_53 Depth 2
                                        #     Child Loop BB57_70 Depth 2
	movq	-72(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jbe	.LBB57_78
# %bb.37:                               #   in Loop: Header=BB57_36 Depth=1
	movq	-72(%rbp), %rax
	addq	$-16, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	movq	-72(%rbp), %rcx
	movl	12(%rcx), %ecx
	movl	%ecx, -36(%rbp)
	addl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movq	-72(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -28(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -32(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB57_38:                              #   Parent Loop BB57_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, -12(%rbp)
	movb	%al, -105(%rbp)                 # 1-byte Spill
	jl	.LBB57_40
# %bb.39:                               #   in Loop: Header=BB57_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -105(%rbp)                 # 1-byte Spill
.LBB57_40:                              #   in Loop: Header=BB57_38 Depth=2
	movb	-105(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB57_41
	jmp	.LBB57_43
.LBB57_41:                              #   in Loop: Header=BB57_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.42:                               #   in Loop: Header=BB57_38 Depth=2
	movl	-12(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB57_38
.LBB57_43:                              #   in Loop: Header=BB57_36 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.LBB57_45
# %bb.44:                               #   in Loop: Header=BB57_36 Depth=1
	jmp	.LBB57_69
.LBB57_45:                              #   in Loop: Header=BB57_36 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB57_51
# %bb.46:                               #   in Loop: Header=BB57_36 Depth=1
	movq	-72(%rbp), %rax
	movq	%rax, -120(%rbp)                # 8-byte Spill
	movq	-64(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-120(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB57_50
# %bb.47:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB57_50
# %bb.48:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB57_50
# %bb.49:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-24(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-28(%rbp), %ecx
	subl	$1, %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 8(%rax)
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
.LBB57_50:                              #   in Loop: Header=BB57_36 Depth=1
	jmp	.LBB57_51
.LBB57_51:                              #   in Loop: Header=BB57_36 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB57_52:                              #   in Loop: Header=BB57_36 Depth=1
	jmp	.LBB57_53
.LBB57_53:                              #   Parent Loop BB57_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-44(%rbp), %ecx
	movb	%al, -121(%rbp)                 # 1-byte Spill
	jg	.LBB57_55
# %bb.54:                               #   in Loop: Header=BB57_53 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -121(%rbp)                 # 1-byte Spill
.LBB57_55:                              #   in Loop: Header=BB57_53 Depth=2
	movb	-121(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB57_56
	jmp	.LBB57_58
.LBB57_56:                              #   in Loop: Header=BB57_53 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.57:                               #   in Loop: Header=BB57_53 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB57_53
.LBB57_58:                              #   in Loop: Header=BB57_36 Depth=1
	movq	-72(%rbp), %rax
	movq	%rax, -136(%rbp)                # 8-byte Spill
	movq	-64(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-136(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB57_62
# %bb.59:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	$0, %eax
	jl	.LBB57_62
# %bb.60:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB57_62
# %bb.61:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-24(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	subl	$1, %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 8(%rax)
	movl	-36(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
.LBB57_62:                              #   in Loop: Header=BB57_36 Depth=1
	movl	-12(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB57_68
# %bb.63:                               #   in Loop: Header=BB57_36 Depth=1
	movq	-72(%rbp), %rax
	movq	%rax, -144(%rbp)                # 8-byte Spill
	movq	-64(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-144(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB57_67
# %bb.64:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB57_67
# %bb.65:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB57_67
# %bb.66:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-16(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-32(%rbp), %ecx
	addl	$1, %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	subl	$1, %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 8(%rax)
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
.LBB57_67:                              #   in Loop: Header=BB57_36 Depth=1
	jmp	.LBB57_68
.LBB57_68:                              #   in Loop: Header=BB57_36 Depth=1
	jmp	.LBB57_69
.LBB57_69:                              #   in Loop: Header=BB57_36 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB57_70:                              #   Parent Loop BB57_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-32(%rbp), %ecx
	movb	%al, -145(%rbp)                 # 1-byte Spill
	jg	.LBB57_72
# %bb.71:                               #   in Loop: Header=BB57_70 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-40(%rbp), %eax
	setne	%al
	movb	%al, -145(%rbp)                 # 1-byte Spill
.LBB57_72:                              #   in Loop: Header=BB57_70 Depth=2
	movb	-145(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB57_73
	jmp	.LBB57_75
.LBB57_73:                              #   in Loop: Header=BB57_70 Depth=2
	jmp	.LBB57_74
.LBB57_74:                              #   in Loop: Header=BB57_70 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB57_70
.LBB57_75:                              #   in Loop: Header=BB57_36 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
# %bb.76:                               #   in Loop: Header=BB57_36 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jle	.LBB57_52
# %bb.77:                               #   in Loop: Header=BB57_36 Depth=1
	jmp	.LBB57_36
.LBB57_78:
	movq	-64(%rbp), %rdi
	callq	gdFree@PLT
.LBB57_79:
	movl	-52(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
.LBB57_80:
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end57:
	.size	gdImageFill, .Lfunc_end57-gdImageFill
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gdImageFillTiled
	.type	_gdImageFillTiled,@function
_gdImageFillTiled:                      # @_gdImageFillTiled
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rax
	cmpq	$0, 4144(%rax)
	jne	.LBB58_2
# %bb.1:
	jmp	.LBB58_70
.LBB58_2:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -48(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %edi
	movq	-8(%rbp), %rax
	movl	8(%rax), %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB58_4
# %bb.3:
	jmp	.LBB58_70
.LBB58_4:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	imull	8(%rcx), %eax
	movl	$4, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %esi
	movl	$16, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB58_6
# %bb.5:
	jmp	.LBB58_70
.LBB58_6:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	imull	8(%rcx), %eax
	movslq	%eax, %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB58_8
# %bb.7:
	jmp	.LBB58_70
.LBB58_8:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	imull	8(%rcx), %eax
	movl	$4, %ecx
	cltd
	idivl	%ecx
	movslq	%eax, %rdi
	shlq	$4, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB58_10
# %bb.9:
	movq	-72(%rbp), %rdi
	callq	gdFree@PLT
	jmp	.LBB58_70
.LBB58_10:
	movq	-56(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -80(%rbp)                 # 8-byte Spill
	movq	-56(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-80(%rbp), %rax                 # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB58_14
# %bb.11:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	$0, %eax
	jl	.LBB58_14
# %bb.12:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_14
# %bb.13:
	movl	-16(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-12(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 8(%rax)
	movq	-64(%rbp), %rax
	movl	$1, 12(%rax)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -64(%rbp)
.LBB58_14:
	movq	-64(%rbp), %rax
	movq	%rax, -88(%rbp)                 # 8-byte Spill
	movq	-56(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-88(%rbp), %rax                 # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB58_18
# %bb.15:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	$0, %eax
	jl	.LBB58_18
# %bb.16:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_18
# %bb.17:
	movl	-16(%rbp), %ecx
	addl	$1, %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-12(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 8(%rax)
	movq	-64(%rbp), %rax
	movl	$-1, 12(%rax)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -64(%rbp)
.LBB58_18:
	jmp	.LBB58_19
.LBB58_19:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB58_21 Depth 2
                                        #     Child Loop BB58_38 Depth 2
                                        #     Child Loop BB58_59 Depth 2
	movq	-64(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jbe	.LBB58_69
# %bb.20:                               #   in Loop: Header=BB58_19 Depth=1
	movq	-64(%rbp), %rax
	addq	$-16, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movl	(%rax), %eax
	movq	-64(%rbp), %rcx
	movl	12(%rcx), %ecx
	movl	%ecx, -36(%rbp)
	addl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movq	-64(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -28(%rbp)
	movq	-64(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -32(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB58_21:                              #   Parent Loop BB58_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, -12(%rbp)
	movb	%al, -89(%rbp)                  # 1-byte Spill
	jl	.LBB58_25
# %bb.22:                               #   in Loop: Header=BB58_21 Depth=2
	movq	-72(%rbp), %rcx
	movl	-16(%rbp), %eax
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %eax
	movslq	%eax, %rdx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpb	$0, (%rcx,%rdx)
	movb	%al, -90(%rbp)                  # 1-byte Spill
	jne	.LBB58_24
# %bb.23:                               #   in Loop: Header=BB58_21 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -90(%rbp)                  # 1-byte Spill
.LBB58_24:                              #   in Loop: Header=BB58_21 Depth=2
	movb	-90(%rbp), %al                  # 1-byte Reload
	movb	%al, -89(%rbp)                  # 1-byte Spill
.LBB58_25:                              #   in Loop: Header=BB58_21 Depth=2
	movb	-89(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB58_26
	jmp	.LBB58_28
.LBB58_26:                              #   in Loop: Header=BB58_21 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageTileGet
	movl	%eax, -20(%rbp)
	movq	-72(%rbp), %rax
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movb	$1, (%rax,%rcx)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.27:                               #   in Loop: Header=BB58_21 Depth=2
	movl	-12(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB58_21
.LBB58_28:                              #   in Loop: Header=BB58_19 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.LBB58_30
# %bb.29:                               #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_58
.LBB58_30:                              #   in Loop: Header=BB58_19 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB58_36
# %bb.31:                               #   in Loop: Header=BB58_19 Depth=1
	movq	-64(%rbp), %rax
	movq	%rax, -104(%rbp)                # 8-byte Spill
	movq	-56(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-104(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB58_35
# %bb.32:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB58_35
# %bb.33:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_35
# %bb.34:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-24(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-28(%rbp), %ecx
	subl	$1, %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 8(%rax)
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -64(%rbp)
.LBB58_35:                              #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_36
.LBB58_36:                              #   in Loop: Header=BB58_19 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB58_37:                              #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_38
.LBB58_38:                              #   Parent Loop BB58_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-44(%rbp), %ecx
	movb	%al, -105(%rbp)                 # 1-byte Spill
	jge	.LBB58_42
# %bb.39:                               #   in Loop: Header=BB58_38 Depth=2
	movq	-72(%rbp), %rcx
	movl	-16(%rbp), %eax
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %eax
	movslq	%eax, %rdx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpb	$0, (%rcx,%rdx)
	movb	%al, -106(%rbp)                 # 1-byte Spill
	jne	.LBB58_41
# %bb.40:                               #   in Loop: Header=BB58_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -106(%rbp)                 # 1-byte Spill
.LBB58_41:                              #   in Loop: Header=BB58_38 Depth=2
	movb	-106(%rbp), %al                 # 1-byte Reload
	movb	%al, -105(%rbp)                 # 1-byte Spill
.LBB58_42:                              #   in Loop: Header=BB58_38 Depth=2
	movb	-105(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB58_43
	jmp	.LBB58_47
.LBB58_43:                              #   in Loop: Header=BB58_38 Depth=2
	movq	-72(%rbp), %rax
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB58_45
# %bb.44:                               #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_47
.LBB58_45:                              #   in Loop: Header=BB58_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageTileGet
	movl	%eax, -20(%rbp)
	movq	-72(%rbp), %rax
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movb	$1, (%rax,%rcx)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.46:                               #   in Loop: Header=BB58_38 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB58_38
.LBB58_47:                              #   in Loop: Header=BB58_19 Depth=1
	movq	-64(%rbp), %rax
	movq	%rax, -120(%rbp)                # 8-byte Spill
	movq	-56(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-120(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB58_51
# %bb.48:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	$0, %eax
	jl	.LBB58_51
# %bb.49:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_51
# %bb.50:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-24(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	subl	$1, %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 8(%rax)
	movl	-36(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -64(%rbp)
.LBB58_51:                              #   in Loop: Header=BB58_19 Depth=1
	movl	-12(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB58_57
# %bb.52:                               #   in Loop: Header=BB58_19 Depth=1
	movq	-64(%rbp), %rax
	movq	%rax, -128(%rbp)                # 8-byte Spill
	movq	-56(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rdx
	imull	8(%rdx), %eax
	movl	$4, %esi
	cltd
	idivl	%esi
	movl	%eax, %edx
	movq	-128(%rbp), %rax                # 8-byte Reload
	movslq	%edx, %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	jae	.LBB58_56
# %bb.53:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB58_56
# %bb.54:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_56
# %bb.55:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-16(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, (%rax)
	movl	-32(%rbp), %ecx
	addl	$1, %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 4(%rax)
	movl	-12(%rbp), %ecx
	subl	$1, %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 8(%rax)
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, 12(%rax)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -64(%rbp)
.LBB58_56:                              #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_57
.LBB58_57:                              #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_58
.LBB58_58:                              #   in Loop: Header=BB58_19 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB58_59:                              #   Parent Loop BB58_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-32(%rbp), %ecx
	movb	%al, -129(%rbp)                 # 1-byte Spill
	jg	.LBB58_63
# %bb.60:                               #   in Loop: Header=BB58_59 Depth=2
	movq	-72(%rbp), %rax
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movsbl	(%rax,%rcx), %ecx
	movb	$1, %al
	cmpl	$0, %ecx
	movb	%al, -130(%rbp)                 # 1-byte Spill
	jne	.LBB58_62
# %bb.61:                               #   in Loop: Header=BB58_59 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	cmpl	-40(%rbp), %eax
	setne	%al
	movb	%al, -130(%rbp)                 # 1-byte Spill
.LBB58_62:                              #   in Loop: Header=BB58_59 Depth=2
	movb	-130(%rbp), %al                 # 1-byte Reload
	movb	%al, -129(%rbp)                 # 1-byte Spill
.LBB58_63:                              #   in Loop: Header=BB58_59 Depth=2
	movb	-129(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB58_64
	jmp	.LBB58_66
.LBB58_64:                              #   in Loop: Header=BB58_59 Depth=2
	jmp	.LBB58_65
.LBB58_65:                              #   in Loop: Header=BB58_59 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB58_59
.LBB58_66:                              #   in Loop: Header=BB58_19 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
# %bb.67:                               #   in Loop: Header=BB58_19 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jle	.LBB58_37
# %bb.68:                               #   in Loop: Header=BB58_19 Depth=1
	jmp	.LBB58_19
.LBB58_69:
	movq	-72(%rbp), %rdi
	callq	gdFree@PLT
	movq	-56(%rbp), %rdi
	callq	gdFree@PLT
.LBB58_70:
	addq	$144, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end58:
	.size	_gdImageFillTiled, .Lfunc_end58-_gdImageFillTiled
	.cfi_endproc
                                        # -- End function
	.globl	gdImageRectangle                # -- Begin function gdImageRectangle
	.p2align	4, 0x90
	.type	gdImageRectangle,@function
gdImageRectangle:                       # @gdImageRectangle
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movq	-8(%rbp), %rax
	movl	6220(%rax), %eax
	movl	%eax, -32(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB59_4
# %bb.1:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB59_4
# %bb.2:
	cmpl	$1, -32(%rbp)
	jne	.LBB59_4
# %bb.3:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB59_33
.LBB59_4:
	movl	-24(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB59_6
# %bb.5:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -24(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB59_6:
	cmpl	$1, -32(%rbp)
	jle	.LBB59_32
# %bb.7:
	movl	-32(%rbp), %eax
	sarl	$1, %eax
	movl	%eax, -64(%rbp)
	movl	-12(%rbp), %eax
	subl	-64(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-16(%rbp), %eax
	subl	-64(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-20(%rbp), %eax
	addl	-64(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-24(%rbp), %eax
	addl	-64(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-52(%rbp), %eax
	addl	-32(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB59_8:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB59_10 Depth 2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$-1, %ecx
	movl	%ecx, -44(%rbp)
	cmpl	-52(%rbp), %eax
	jle	.LBB59_13
# %bb.9:                                #   in Loop: Header=BB59_8 Depth=1
	movl	-48(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB59_10:                              #   Parent Loop BB59_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -40(%rbp)
	cmpl	-56(%rbp), %eax
	jge	.LBB59_12
# %bb.11:                               #   in Loop: Header=BB59_10 Depth=2
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB59_10
.LBB59_12:                              #   in Loop: Header=BB59_8 Depth=1
	jmp	.LBB59_8
.LBB59_13:
	movl	-60(%rbp), %eax
	subl	-32(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB59_14:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB59_16 Depth 2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	cmpl	-60(%rbp), %eax
	jge	.LBB59_19
# %bb.15:                               #   in Loop: Header=BB59_14 Depth=1
	movl	-48(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB59_16:                              #   Parent Loop BB59_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -40(%rbp)
	cmpl	-56(%rbp), %eax
	jge	.LBB59_18
# %bb.17:                               #   in Loop: Header=BB59_16 Depth=2
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB59_16
.LBB59_18:                              #   in Loop: Header=BB59_14 Depth=1
	jmp	.LBB59_14
.LBB59_19:
	movl	-52(%rbp), %eax
	addl	-32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB59_20:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB59_22 Depth 2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	movl	-60(%rbp), %ecx
	subl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB59_25
# %bb.21:                               #   in Loop: Header=BB59_20 Depth=1
	movl	-48(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB59_22:                              #   Parent Loop BB59_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -40(%rbp)
	movl	-48(%rbp), %ecx
	addl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB59_24
# %bb.23:                               #   in Loop: Header=BB59_22 Depth=2
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB59_22
.LBB59_24:                              #   in Loop: Header=BB59_20 Depth=1
	jmp	.LBB59_20
.LBB59_25:
	movl	-52(%rbp), %eax
	addl	-32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB59_26:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB59_28 Depth 2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	movl	-60(%rbp), %ecx
	subl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB59_31
# %bb.27:                               #   in Loop: Header=BB59_26 Depth=1
	movl	-56(%rbp), %eax
	subl	-32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB59_28:                              #   Parent Loop BB59_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -40(%rbp)
	cmpl	-56(%rbp), %eax
	jge	.LBB59_30
# %bb.29:                               #   in Loop: Header=BB59_28 Depth=2
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB59_28
.LBB59_30:                              #   in Loop: Header=BB59_26 Depth=1
	jmp	.LBB59_26
.LBB59_31:
	jmp	.LBB59_33
.LBB59_32:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-16(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	movl	-12(%rbp), %ecx
	movl	-24(%rbp), %r8d
	subl	$1, %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	subl	$1, %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine
.LBB59_33:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end59:
	.size	gdImageRectangle, .Lfunc_end59-gdImageRectangle
	.cfi_endproc
                                        # -- End function
	.globl	gdImageFilledRectangle          # -- Begin function gdImageFilledRectangle
	.p2align	4, 0x90
	.type	gdImageFilledRectangle,@function
gdImageFilledRectangle:                 # @gdImageFilledRectangle
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB60_3
# %bb.1:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB60_3
# %bb.2:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
	jmp	.LBB60_23
.LBB60_3:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.LBB60_5
# %bb.4:
	movl	-12(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB60_5:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.LBB60_7
# %bb.6:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB60_7:
	cmpl	$0, -12(%rbp)
	jge	.LBB60_9
# %bb.8:
	movl	$0, -12(%rbp)
.LBB60_9:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB60_11
# %bb.10:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -20(%rbp)
.LBB60_11:
	cmpl	$0, -16(%rbp)
	jge	.LBB60_13
# %bb.12:
	movl	$0, -16(%rbp)
.LBB60_13:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB60_15
# %bb.14:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -24(%rbp)
.LBB60_15:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
.LBB60_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_18 Depth 2
	movl	-36(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jg	.LBB60_23
# %bb.17:                               #   in Loop: Header=BB60_16 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -32(%rbp)
.LBB60_18:                              #   Parent Loop BB60_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB60_21
# %bb.19:                               #   in Loop: Header=BB60_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel
# %bb.20:                               #   in Loop: Header=BB60_18 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB60_18
.LBB60_21:                              #   in Loop: Header=BB60_16 Depth=1
	jmp	.LBB60_22
.LBB60_22:                              #   in Loop: Header=BB60_16 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB60_16
.LBB60_23:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end60:
	.size	gdImageFilledRectangle, .Lfunc_end60-gdImageFilledRectangle
	.cfi_endproc
                                        # -- End function
	.globl	gdImageClone                    # -- Begin function gdImageClone
	.p2align	4, 0x90
	.type	gdImageClone,@function
gdImageClone:                           # @gdImageClone
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB61_2
# %bb.1:
	movq	-16(%rbp), %rax
	movl	8(%rax), %edi
	movq	-16(%rbp), %rax
	movl	12(%rax), %esi
	callq	gdImageCreateTrueColor
	movq	%rax, -24(%rbp)
	jmp	.LBB61_3
.LBB61_2:
	movq	-16(%rbp), %rax
	movl	8(%rax), %edi
	movq	-16(%rbp), %rax
	movl	12(%rax), %esi
	callq	gdImageCreate
	movq	%rax, -24(%rbp)
.LBB61_3:
	cmpq	$0, -24(%rbp)
	jne	.LBB61_5
# %bb.4:
	movq	$0, -8(%rbp)
	jmp	.LBB61_51
.LBB61_5:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB61_19
# %bb.6:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 16(%rax)
	movl	$0, -28(%rbp)
.LBB61_7:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -28(%rbp)                 # imm = 0x100
	jge	.LBB61_10
# %bb.8:                                #   in Loop: Header=BB61_7 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	20(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 20(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 1044(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 2068(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 6224(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	3092(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 3092(%rax,%rcx,4)
# %bb.9:                                #   in Loop: Header=BB61_7 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB61_7
.LBB61_10:
	movl	$0, -28(%rbp)
.LBB61_11:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB61_13 Depth 2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB61_18
# %bb.12:                               #   in Loop: Header=BB61_11 Depth=1
	movl	$0, -32(%rbp)
.LBB61_13:                              #   Parent Loop BB61_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB61_16
# %bb.14:                               #   in Loop: Header=BB61_13 Depth=2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-32(%rbp), %rcx
	movb	(%rax,%rcx), %dl
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-32(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.15:                               #   in Loop: Header=BB61_13 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB61_13
.LBB61_16:                              #   in Loop: Header=BB61_11 Depth=1
	jmp	.LBB61_17
.LBB61_17:                              #   in Loop: Header=BB61_11 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB61_11
.LBB61_18:
	jmp	.LBB61_28
.LBB61_19:
	movl	$0, -28(%rbp)
.LBB61_20:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB61_22 Depth 2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB61_27
# %bb.21:                               #   in Loop: Header=BB61_20 Depth=1
	movl	$0, -32(%rbp)
.LBB61_22:                              #   Parent Loop BB61_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB61_25
# %bb.23:                               #   in Loop: Header=BB61_22 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-32(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-32(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.24:                               #   in Loop: Header=BB61_22 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB61_22
.LBB61_25:                              #   in Loop: Header=BB61_20 Depth=1
	jmp	.LBB61_26
.LBB61_26:                              #   in Loop: Header=BB61_20 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB61_20
.LBB61_27:
	jmp	.LBB61_28
.LBB61_28:
	movq	-16(%rbp), %rax
	cmpl	$0, 6200(%rax)
	jle	.LBB61_34
# %bb.29:
	movq	-16(%rbp), %rax
	movl	6200(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 6200(%rax)
	movq	-16(%rbp), %rax
	movl	6204(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 6204(%rax)
	movl	$0, -28(%rbp)
.LBB61_30:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	6200(%rcx), %eax
	jge	.LBB61_33
# %bb.31:                               #   in Loop: Header=BB61_30 Depth=1
	movq	-16(%rbp), %rax
	movq	6208(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movq	6208(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.32:                               #   in Loop: Header=BB61_30 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB61_30
.LBB61_33:
	jmp	.LBB61_34
.LBB61_34:
	movq	-16(%rbp), %rax
	movl	6216(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 6216(%rax)
	movq	-16(%rbp), %rax
	movl	7264(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7264(%rax)
	movq	-16(%rbp), %rax
	movl	7268(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7268(%rax)
	movq	-16(%rbp), %rax
	movl	7272(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7272(%rax)
	movq	-16(%rbp), %rax
	movl	7276(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7276(%rax)
	movq	-16(%rbp), %rax
	movl	7280(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7280(%rax)
	movq	-16(%rbp), %rax
	movl	7284(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7284(%rax)
	movq	-16(%rbp), %rax
	movl	7288(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7288(%rax)
	movq	-16(%rbp), %rax
	movl	7292(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7292(%rax)
	movq	-16(%rbp), %rax
	movl	7296(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7296(%rax)
	movq	-16(%rbp), %rax
	movl	7300(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7300(%rax)
	movq	-16(%rbp), %rax
	movl	7300(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7304(%rax)
	movq	-16(%rbp), %rax
	movl	7308(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7308(%rax)
	movq	-16(%rbp), %rax
	movl	7312(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7312(%rax)
	movq	-16(%rbp), %rax
	movl	7316(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7316(%rax)
	movq	-16(%rbp), %rax
	movl	7316(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7316(%rax)
	movq	-16(%rbp), %rax
	movl	7324(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 7324(%rax)
	movq	-16(%rbp), %rax
	movq	7328(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 7328(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 4136(%rax)
	je	.LBB61_36
# %bb.35:
	movq	-16(%rbp), %rax
	movq	4136(%rax), %rdi
	callq	gdImageClone
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 4136(%rax)
.LBB61_36:
	movq	-16(%rbp), %rax
	cmpq	$0, 4144(%rax)
	je	.LBB61_38
# %bb.37:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rdi
	callq	gdImageClone
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 4144(%rax)
.LBB61_38:
	movq	-16(%rbp), %rax
	cmpq	$0, 6208(%rax)
	je	.LBB61_40
# %bb.39:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	6208(%rax), %rsi
	movq	-16(%rbp), %rax
	movl	6200(%rax), %edx
	callq	gdImageSetStyle
.LBB61_40:
	movl	$0, -28(%rbp)
.LBB61_41:                              # =>This Inner Loop Header: Depth=1
	cmpl	$256, -28(%rbp)                 # imm = 0x100
	jge	.LBB61_44
# %bb.42:                               #   in Loop: Header=BB61_41 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4152(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 4152(%rax,%rcx,4)
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	5176(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, 5176(%rax,%rcx,4)
# %bb.43:                               #   in Loop: Header=BB61_41 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB61_41
.LBB61_44:
	movq	-16(%rbp), %rax
	cmpl	$0, 4128(%rax)
	jle	.LBB61_50
# %bb.45:
	movq	-16(%rbp), %rax
	movl	4128(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 4128(%rax)
	movl	$0, -28(%rbp)
.LBB61_46:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4128(%rcx), %eax
	jge	.LBB61_49
# %bb.47:                               #   in Loop: Header=BB61_46 Depth=1
	movq	-16(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.48:                               #   in Loop: Header=BB61_46 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB61_46
.LBB61_49:
	jmp	.LBB61_50
.LBB61_50:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB61_51:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end61:
	.size	gdImageClone, .Lfunc_end61-gdImageClone
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetStyle                 # -- Begin function gdImageSetStyle
	.p2align	4, 0x90
	.type	gdImageSetStyle,@function
gdImageSetStyle:                        # @gdImageSetStyle
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
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	je	.LBB62_2
# %bb.1:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rdi
	callq	gdFree@PLT
.LBB62_2:
	movl	-20(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB62_4
# %bb.3:
	jmp	.LBB62_7
.LBB62_4:
	movslq	-20(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 6208(%rax)
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	jne	.LBB62_6
# %bb.5:
	jmp	.LBB62_7
.LBB62_6:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rdi
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	shlq	$2, %rdx
	callq	memcpy@PLT
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 6200(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 6204(%rax)
.LBB62_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end62:
	.size	gdImageSetStyle, .Lfunc_end62-gdImageSetStyle
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCopy                     # -- Begin function gdImageCopy
	.p2align	4, 0x90
	.type	gdImageCopy,@function
gdImageCopy:                            # @gdImageCopy
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$1104, %rsp                     # imm = 0x450
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB63_25
# %bb.1:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB63_13
# %bb.2:
	movl	$0, -44(%rbp)
.LBB63_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB63_5 Depth 2
	movl	-44(%rbp), %eax
	cmpl	24(%rbp), %eax
	jge	.LBB63_12
# %bb.4:                                #   in Loop: Header=BB63_3 Depth=1
	movl	$0, -40(%rbp)
.LBB63_5:                               #   Parent Loop BB63_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	cmpl	16(%rbp), %eax
	jge	.LBB63_10
# %bb.6:                                #   in Loop: Header=BB63_5 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-32(%rbp), %edx
	addl	-44(%rbp), %edx
	callq	gdImageGetTrueColorPixel
	movl	%eax, -1092(%rbp)
	movl	-1092(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB63_8
# %bb.7:                                #   in Loop: Header=BB63_5 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-24(%rbp), %edx
	addl	-44(%rbp), %edx
	movl	-1092(%rbp), %ecx
	callq	gdImageSetPixel
.LBB63_8:                               #   in Loop: Header=BB63_5 Depth=2
	jmp	.LBB63_9
.LBB63_9:                               #   in Loop: Header=BB63_5 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB63_5
.LBB63_10:                              #   in Loop: Header=BB63_3 Depth=1
	jmp	.LBB63_11
.LBB63_11:                              #   in Loop: Header=BB63_3 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB63_3
.LBB63_12:
	jmp	.LBB63_24
.LBB63_13:
	movl	$0, -44(%rbp)
.LBB63_14:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB63_16 Depth 2
	movl	-44(%rbp), %eax
	cmpl	24(%rbp), %eax
	jge	.LBB63_23
# %bb.15:                               #   in Loop: Header=BB63_14 Depth=1
	movl	$0, -40(%rbp)
.LBB63_16:                              #   Parent Loop BB63_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	cmpl	16(%rbp), %eax
	jge	.LBB63_21
# %bb.17:                               #   in Loop: Header=BB63_16 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-32(%rbp), %edx
	addl	-44(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -1096(%rbp)
	movl	-1096(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB63_19
# %bb.18:                               #   in Loop: Header=BB63_16 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-24(%rbp), %edx
	addl	-44(%rbp), %edx
	movq	-16(%rbp), %rax
	movslq	-1096(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %ecx
	shll	$24, %ecx
	movq	-16(%rbp), %rax
	movslq	-1096(%rbp), %r8
	movl	20(%rax,%r8,4), %eax
	shll	$16, %eax
	addl	%eax, %ecx
	movq	-16(%rbp), %rax
	movslq	-1096(%rbp), %r8
	movl	1044(%rax,%r8,4), %eax
	shll	$8, %eax
	addl	%eax, %ecx
	movq	-16(%rbp), %rax
	movslq	-1096(%rbp), %r8
	addl	2068(%rax,%r8,4), %ecx
	callq	gdImageSetPixel
.LBB63_19:                              #   in Loop: Header=BB63_16 Depth=2
	jmp	.LBB63_20
.LBB63_20:                              #   in Loop: Header=BB63_16 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB63_16
.LBB63_21:                              #   in Loop: Header=BB63_14 Depth=1
	jmp	.LBB63_22
.LBB63_22:                              #   in Loop: Header=BB63_14 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB63_14
.LBB63_23:
	jmp	.LBB63_24
.LBB63_24:
	jmp	.LBB63_48
.LBB63_25:
	movl	$0, -56(%rbp)
.LBB63_26:                              # =>This Inner Loop Header: Depth=1
	cmpl	$256, -56(%rbp)                 # imm = 0x100
	jge	.LBB63_29
# %bb.27:                               #   in Loop: Header=BB63_26 Depth=1
	movslq	-56(%rbp), %rax
	movl	$-1, -1088(%rbp,%rax,4)
# %bb.28:                               #   in Loop: Header=BB63_26 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB63_26
.LBB63_29:
	movl	-24(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB63_30:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB63_32 Depth 2
	movl	-44(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB63_48
# %bb.31:                               #   in Loop: Header=BB63_30 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB63_32:                              #   Parent Loop BB63_30 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB63_46
# %bb.33:                               #   in Loop: Header=BB63_32 Depth=2
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB63_35
# %bb.34:                               #   in Loop: Header=BB63_32 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB63_45
.LBB63_35:                              #   in Loop: Header=BB63_32 Depth=2
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB63_37
# %bb.36:                               #   in Loop: Header=BB63_32 Depth=2
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	andl	$16711680, %esi                 # imm = 0xFF0000
	sarl	$16, %esi
	movl	-36(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	-36(%rbp), %ecx
	andl	$255, %ecx
	movl	-36(%rbp), %r8d
	andl	$2130706432, %r8d               # imm = 0x7F000000
	sarl	$24, %r8d
	callq	gdImageColorResolveAlpha
	movl	%eax, -1104(%rbp)
	jmp	.LBB63_44
.LBB63_37:                              #   in Loop: Header=BB63_32 Depth=2
	movslq	-36(%rbp), %rax
	cmpl	$-1, -1088(%rbp,%rax,4)
	jne	.LBB63_42
# %bb.38:                               #   in Loop: Header=BB63_32 Depth=2
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB63_40
# %bb.39:                               #   in Loop: Header=BB63_32 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -1100(%rbp)
	jmp	.LBB63_41
.LBB63_40:                              #   in Loop: Header=BB63_32 Depth=2
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %esi
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %edx
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %ecx
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %r8
	movl	6224(%rax,%r8,4), %r8d
	callq	gdImageColorResolveAlpha
	movl	%eax, -1100(%rbp)
.LBB63_41:                              #   in Loop: Header=BB63_32 Depth=2
	movl	-1100(%rbp), %ecx
	movslq	-36(%rbp), %rax
	movl	%ecx, -1088(%rbp,%rax,4)
	movslq	-36(%rbp), %rax
	movl	-1088(%rbp,%rax,4), %eax
	movl	%eax, -1104(%rbp)
	jmp	.LBB63_43
.LBB63_42:                              #   in Loop: Header=BB63_32 Depth=2
	movslq	-36(%rbp), %rax
	movl	-1088(%rbp,%rax,4), %eax
	movl	%eax, -1104(%rbp)
.LBB63_43:                              #   in Loop: Header=BB63_32 Depth=2
	jmp	.LBB63_44
.LBB63_44:                              #   in Loop: Header=BB63_32 Depth=2
	movq	-8(%rbp), %rdi
	movl	-48(%rbp), %esi
	movl	-52(%rbp), %edx
	movl	-1104(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
.LBB63_45:                              #   in Loop: Header=BB63_32 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB63_32
.LBB63_46:                              #   in Loop: Header=BB63_30 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.47:                               #   in Loop: Header=BB63_30 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB63_30
.LBB63_48:
	addq	$1104, %rsp                     # imm = 0x450
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end63:
	.size	gdImageCopy, .Lfunc_end63-gdImageCopy
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyMerge
.LCPI64_0:
	.quad	0x4059000000000000              # double 100
	.text
	.globl	gdImageCopyMerge
	.p2align	4, 0x90
	.type	gdImageCopyMerge,@function
gdImageCopyMerge:                       # @gdImageCopyMerge
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movl	32(%rbp), %eax
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB64_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB64_3 Depth 2
	movl	-48(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB64_31
# %bb.2:                                #   in Loop: Header=BB64_1 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB64_3:                               #   Parent Loop BB64_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB64_29
# %bb.4:                                #   in Loop: Header=BB64_3 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB64_6
# %bb.5:                                #   in Loop: Header=BB64_3 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB64_28
.LBB64_6:                               #   in Loop: Header=BB64_3 Depth=2
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB64_8
# %bb.7:                                #   in Loop: Header=BB64_3 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -72(%rbp)
	jmp	.LBB64_27
.LBB64_8:                               #   in Loop: Header=BB64_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB64_10
# %bb.9:                                #   in Loop: Header=BB64_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	jmp	.LBB64_11
.LBB64_10:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
.LBB64_11:                              #   in Loop: Header=BB64_3 Depth=2
	movl	-76(%rbp), %eax                 # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -96(%rbp)                # 8-byte Spill
	cvtsi2sdl	32(%rbp), %xmm0
	movsd	.LCPI64_0(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -88(%rbp)                # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB64_13
# %bb.12:                               #   in Loop: Header=BB64_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	jmp	.LBB64_14
.LBB64_13:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
.LBB64_14:                              #   in Loop: Header=BB64_3 Depth=2
	movsd	-88(%rbp), %xmm2                # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	-96(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-100(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI64_0(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB64_16
# %bb.15:                               #   in Loop: Header=BB64_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -104(%rbp)                # 4-byte Spill
	jmp	.LBB64_17
.LBB64_16:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -104(%rbp)                # 4-byte Spill
.LBB64_17:                              #   in Loop: Header=BB64_3 Depth=2
	movl	-104(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -120(%rbp)               # 8-byte Spill
	cvtsi2sdl	32(%rbp), %xmm0
	movsd	.LCPI64_0(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)               # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB64_19
# %bb.18:                               #   in Loop: Header=BB64_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
	jmp	.LBB64_20
.LBB64_19:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
.LBB64_20:                              #   in Loop: Header=BB64_3 Depth=2
	movsd	-112(%rbp), %xmm2               # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	-120(%rbp), %xmm0               # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-124(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI64_0(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -64(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB64_22
# %bb.21:                               #   in Loop: Header=BB64_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -128(%rbp)                # 4-byte Spill
	jmp	.LBB64_23
.LBB64_22:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -128(%rbp)                # 4-byte Spill
.LBB64_23:                              #   in Loop: Header=BB64_3 Depth=2
	movl	-128(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -144(%rbp)               # 8-byte Spill
	cvtsi2sdl	32(%rbp), %xmm0
	movsd	.LCPI64_0(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -136(%rbp)               # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB64_25
# %bb.24:                               #   in Loop: Header=BB64_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -148(%rbp)                # 4-byte Spill
	jmp	.LBB64_26
.LBB64_25:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -148(%rbp)                # 4-byte Spill
.LBB64_26:                              #   in Loop: Header=BB64_3 Depth=2
	movsd	-136(%rbp), %xmm2               # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	-144(%rbp), %xmm0               # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-148(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI64_0(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -68(%rbp)
	movq	-8(%rbp), %rdi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageColorResolve
	movl	%eax, -72(%rbp)
.LBB64_27:                              #   in Loop: Header=BB64_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-72(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
.LBB64_28:                              #   in Loop: Header=BB64_3 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB64_3
.LBB64_29:                              #   in Loop: Header=BB64_1 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.30:                               #   in Loop: Header=BB64_1 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB64_1
.LBB64_31:
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end64:
	.size	gdImageCopyMerge, .Lfunc_end64-gdImageCopyMerge
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyMergeGray
.LCPI65_0:
	.quad	0x3fd322d0e5604189              # double 0.29899999999999999
.LCPI65_1:
	.quad	0x3fe2c8b439581062              # double 0.58699999999999997
.LCPI65_2:
	.quad	0x3fbd2f1a9fbe76c9              # double 0.114
.LCPI65_3:
	.quad	0x4059000000000000              # double 100
	.text
	.globl	gdImageCopyMergeGray
	.p2align	4, 0x90
	.type	gdImageCopyMergeGray,@function
gdImageCopyMergeGray:                   # @gdImageCopyMergeGray
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movl	32(%rbp), %eax
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB65_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB65_3 Depth 2
	movl	-48(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB65_36
# %bb.2:                                #   in Loop: Header=BB65_1 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB65_3:                               #   Parent Loop BB65_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB65_34
# %bb.4:                                #   in Loop: Header=BB65_3 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB65_6
# %bb.5:                                #   in Loop: Header=BB65_3 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB65_33
.LBB65_6:                               #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB65_9
# %bb.7:                                #   in Loop: Header=BB65_3 Depth=2
	cmpl	$100, 32(%rbp)
	jne	.LBB65_9
# %bb.8:                                #   in Loop: Header=BB65_3 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB65_32
.LBB65_9:                               #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -40(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_11
# %bb.10:                               #   in Loop: Header=BB65_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
	jmp	.LBB65_12
.LBB65_11:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
.LBB65_12:                              #   in Loop: Header=BB65_3 Depth=2
	movl	-80(%rbp), %eax                 # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -88(%rbp)                # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_14
# %bb.13:                               #   in Loop: Header=BB65_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
	jmp	.LBB65_15
.LBB65_14:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
.LBB65_15:                              #   in Loop: Header=BB65_3 Depth=2
	movsd	-88(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-92(%rbp), %eax                 # 4-byte Reload
	cvtsi2sd	%eax, %xmm2
	movsd	.LCPI65_1(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm1
	movsd	.LCPI65_0(%rip), %xmm2          # xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)               # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_17
# %bb.16:                               #   in Loop: Header=BB65_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	jmp	.LBB65_18
.LBB65_17:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
.LBB65_18:                              #   in Loop: Header=BB65_3 Depth=2
	movsd	-104(%rbp), %xmm1               # 8-byte Reload
                                        # xmm1 = mem[0],zero
	movl	-108(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	.LCPI65_2(%rip), %xmm2          # xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -72(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_20
# %bb.19:                               #   in Loop: Header=BB65_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -112(%rbp)                # 4-byte Spill
	jmp	.LBB65_21
.LBB65_20:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -112(%rbp)                # 4-byte Spill
.LBB65_21:                              #   in Loop: Header=BB65_3 Depth=2
	movl	-112(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	32(%rbp), %xmm2
	movsd	.LCPI65_3(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm2
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI65_3(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_23
# %bb.22:                               #   in Loop: Header=BB65_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
	jmp	.LBB65_24
.LBB65_23:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
.LBB65_24:                              #   in Loop: Header=BB65_3 Depth=2
	movl	-116(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	32(%rbp), %xmm2
	movsd	.LCPI65_3(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm2
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI65_3(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -64(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_26
# %bb.25:                               #   in Loop: Header=BB65_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
	jmp	.LBB65_27
.LBB65_26:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
.LBB65_27:                              #   in Loop: Header=BB65_3 Depth=2
	movl	-120(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	32(%rbp), %xmm2
	movsd	.LCPI65_3(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm2
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI65_3(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -68(%rbp)
	movq	-8(%rbp), %rdi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageColorExact
	movl	%eax, -76(%rbp)
	cmpl	$-1, -76(%rbp)
	jne	.LBB65_31
# %bb.28:                               #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageColorAllocate
	movl	%eax, -76(%rbp)
	cmpl	$-1, -76(%rbp)
	jne	.LBB65_30
# %bb.29:                               #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageColorClosest
	movl	%eax, -76(%rbp)
.LBB65_30:                              #   in Loop: Header=BB65_3 Depth=2
	jmp	.LBB65_31
.LBB65_31:                              #   in Loop: Header=BB65_3 Depth=2
	jmp	.LBB65_32
.LBB65_32:                              #   in Loop: Header=BB65_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-76(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
.LBB65_33:                              #   in Loop: Header=BB65_3 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB65_3
.LBB65_34:                              #   in Loop: Header=BB65_1 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.35:                               #   in Loop: Header=BB65_1 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB65_1
.LBB65_36:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end65:
	.size	gdImageCopyMergeGray, .Lfunc_end65-gdImageCopyMergeGray
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCopyResized              # -- Begin function gdImageCopyResized
	.p2align	4, 0x90
	.type	gdImageCopyResized,@function
gdImageCopyResized:                     # @gdImageCopyResized
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$1168, %rsp                     # imm = 0x490
	movl	40(%rbp), %eax
	movl	32(%rbp), %eax
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movl	%r8d, -28(%rbp)
	movl	%r9d, -32(%rbp)
	movl	32(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB66_2
# %bb.1:
	jmp	.LBB66_71
.LBB66_2:
	movl	40(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB66_4
# %bb.3:
	jmp	.LBB66_71
.LBB66_4:
	movslq	32(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -1096(%rbp)
	cmpq	$0, -1096(%rbp)
	jne	.LBB66_6
# %bb.5:
	jmp	.LBB66_71
.LBB66_6:
	movslq	40(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -1104(%rbp)
	cmpq	$0, -1104(%rbp)
	jne	.LBB66_8
# %bb.7:
	movq	-1096(%rbp), %rdi
	callq	gdFree@PLT
	jmp	.LBB66_71
.LBB66_8:
	movl	$0, -60(%rbp)
.LBB66_9:                               # =>This Inner Loop Header: Depth=1
	movl	-60(%rbp), %eax
	cmpl	32(%rbp), %eax
	jge	.LBB66_12
# %bb.10:                               #   in Loop: Header=BB66_9 Depth=1
	movl	16(%rbp), %eax
	movl	-60(%rbp), %ecx
	addl	$1, %ecx
	imull	%ecx, %eax
	cltd
	idivl	32(%rbp)
	movl	%eax, -1120(%rbp)               # 4-byte Spill
	movl	16(%rbp), %eax
	imull	-60(%rbp), %eax
	cltd
	idivl	32(%rbp)
	movl	-1120(%rbp), %edx               # 4-byte Reload
	subl	%eax, %edx
	movq	-1096(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.11:                               #   in Loop: Header=BB66_9 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB66_9
.LBB66_12:
	movl	$0, -60(%rbp)
.LBB66_13:                              # =>This Inner Loop Header: Depth=1
	movl	-60(%rbp), %eax
	cmpl	40(%rbp), %eax
	jge	.LBB66_16
# %bb.14:                               #   in Loop: Header=BB66_13 Depth=1
	movl	24(%rbp), %eax
	movl	-60(%rbp), %ecx
	addl	$1, %ecx
	imull	%ecx, %eax
	cltd
	idivl	40(%rbp)
	movl	%eax, -1124(%rbp)               # 4-byte Spill
	movl	24(%rbp), %eax
	imull	-60(%rbp), %eax
	cltd
	idivl	40(%rbp)
	movl	-1124(%rbp), %edx               # 4-byte Reload
	subl	%eax, %edx
	movq	-1104(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.15:                               #   in Loop: Header=BB66_13 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB66_13
.LBB66_16:
	movl	$0, -60(%rbp)
.LBB66_17:                              # =>This Inner Loop Header: Depth=1
	cmpl	$256, -60(%rbp)                 # imm = 0x100
	jge	.LBB66_20
# %bb.18:                               #   in Loop: Header=BB66_17 Depth=1
	movslq	-60(%rbp), %rax
	movl	$-1, -1088(%rbp,%rax,4)
# %bb.19:                               #   in Loop: Header=BB66_17 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB66_17
.LBB66_20:
	movl	-24(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB66_21:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB66_23 Depth 2
                                        #       Child Loop BB66_25 Depth 3
                                        #         Child Loop BB66_61 Depth 4
	movl	-44(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	40(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB66_70
# %bb.22:                               #   in Loop: Header=BB66_21 Depth=1
	movl	$0, -56(%rbp)
.LBB66_23:                              #   Parent Loop BB66_21 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB66_25 Depth 3
                                        #         Child Loop BB66_61 Depth 4
	movl	-56(%rbp), %eax
	movq	-1104(%rbp), %rcx
	movl	-44(%rbp), %edx
	subl	-32(%rbp), %edx
	movslq	%edx, %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jge	.LBB66_68
# %bb.24:                               #   in Loop: Header=BB66_23 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB66_25:                              #   Parent Loop BB66_21 Depth=1
                                        #     Parent Loop BB66_23 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB66_61 Depth 4
	movl	-40(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB66_66
# %bb.26:                               #   in Loop: Header=BB66_25 Depth=3
	movl	$0, -1108(%rbp)
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	cmpl	$0, (%rax,%rcx,4)
	jne	.LBB66_28
# %bb.27:                               #   in Loop: Header=BB66_25 Depth=3
	jmp	.LBB66_65
.LBB66_28:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_37
# %bb.29:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB66_33
# %bb.30:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -1116(%rbp)
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetTrueColorPixel
	movl	%eax, -1112(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-1116(%rbp), %eax
	jne	.LBB66_32
# %bb.31:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB66_65
.LBB66_32:                              #   in Loop: Header=BB66_25 Depth=3
	jmp	.LBB66_36
.LBB66_33:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetTrueColorPixel
	movl	%eax, -1112(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-1112(%rbp), %eax
	jne	.LBB66_35
# %bb.34:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB66_65
.LBB66_35:                              #   in Loop: Header=BB66_25 Depth=3
	jmp	.LBB66_36
.LBB66_36:                              #   in Loop: Header=BB66_25 Depth=3
	jmp	.LBB66_60
.LBB66_37:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB66_39
# %bb.38:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB66_65
.LBB66_39:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_41
# %bb.40:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	andl	$16711680, %esi                 # imm = 0xFF0000
	sarl	$16, %esi
	movl	-36(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	-36(%rbp), %ecx
	andl	$255, %ecx
	movl	-36(%rbp), %r8d
	andl	$2130706432, %r8d               # imm = 0x7F000000
	sarl	$24, %r8d
	callq	gdImageColorResolveAlpha
	movl	%eax, -1112(%rbp)
	jmp	.LBB66_59
.LBB66_41:                              #   in Loop: Header=BB66_25 Depth=3
	movslq	-36(%rbp), %rax
	cmpl	$-1, -1088(%rbp,%rax,4)
	jne	.LBB66_58
# %bb.42:                               #   in Loop: Header=BB66_25 Depth=3
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB66_44
# %bb.43:                               #   in Loop: Header=BB66_25 Depth=3
	movl	-36(%rbp), %eax
	movl	%eax, -1108(%rbp)
	jmp	.LBB66_57
.LBB66_44:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-8(%rbp), %rax
	movq	%rax, -1136(%rbp)               # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_46
# %bb.45:                               #   in Loop: Header=BB66_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -1140(%rbp)               # 4-byte Spill
	jmp	.LBB66_47
.LBB66_46:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -1140(%rbp)               # 4-byte Spill
.LBB66_47:                              #   in Loop: Header=BB66_25 Depth=3
	movl	-1140(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1144(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_49
# %bb.48:                               #   in Loop: Header=BB66_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -1148(%rbp)               # 4-byte Spill
	jmp	.LBB66_50
.LBB66_49:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -1148(%rbp)               # 4-byte Spill
.LBB66_50:                              #   in Loop: Header=BB66_25 Depth=3
	movl	-1148(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1152(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_52
# %bb.51:                               #   in Loop: Header=BB66_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -1156(%rbp)               # 4-byte Spill
	jmp	.LBB66_53
.LBB66_52:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -1156(%rbp)               # 4-byte Spill
.LBB66_53:                              #   in Loop: Header=BB66_25 Depth=3
	movl	-1156(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1160(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_55
# %bb.54:                               #   in Loop: Header=BB66_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -1164(%rbp)               # 4-byte Spill
	jmp	.LBB66_56
.LBB66_55:                              #   in Loop: Header=BB66_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -1164(%rbp)               # 4-byte Spill
.LBB66_56:                              #   in Loop: Header=BB66_25 Depth=3
	movl	-1160(%rbp), %ecx               # 4-byte Reload
	movl	-1152(%rbp), %edx               # 4-byte Reload
	movl	-1144(%rbp), %esi               # 4-byte Reload
	movq	-1136(%rbp), %rdi               # 8-byte Reload
	movl	-1164(%rbp), %r8d               # 4-byte Reload
	callq	gdImageColorResolveAlpha
	movl	%eax, -1108(%rbp)
.LBB66_57:                              #   in Loop: Header=BB66_25 Depth=3
	movl	-1108(%rbp), %ecx
	movslq	-36(%rbp), %rax
	movl	%ecx, -1088(%rbp,%rax,4)
.LBB66_58:                              #   in Loop: Header=BB66_25 Depth=3
	movslq	-36(%rbp), %rax
	movl	-1088(%rbp,%rax,4), %eax
	movl	%eax, -1112(%rbp)
.LBB66_59:                              #   in Loop: Header=BB66_25 Depth=3
	jmp	.LBB66_60
.LBB66_60:                              #   in Loop: Header=BB66_25 Depth=3
	movl	$0, -60(%rbp)
.LBB66_61:                              #   Parent Loop BB66_21 Depth=1
                                        #     Parent Loop BB66_23 Depth=2
                                        #       Parent Loop BB66_25 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-60(%rbp), %eax
	movq	-1096(%rbp), %rcx
	movl	-40(%rbp), %edx
	subl	-28(%rbp), %edx
	movslq	%edx, %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jge	.LBB66_64
# %bb.62:                               #   in Loop: Header=BB66_61 Depth=4
	movq	-8(%rbp), %rdi
	movl	-48(%rbp), %esi
	movl	-52(%rbp), %edx
	movl	-1112(%rbp), %ecx
	callq	gdImageSetPixel
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
# %bb.63:                               #   in Loop: Header=BB66_61 Depth=4
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB66_61
.LBB66_64:                              #   in Loop: Header=BB66_25 Depth=3
	jmp	.LBB66_65
.LBB66_65:                              #   in Loop: Header=BB66_25 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB66_25
.LBB66_66:                              #   in Loop: Header=BB66_23 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.67:                               #   in Loop: Header=BB66_23 Depth=2
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB66_23
.LBB66_68:                              #   in Loop: Header=BB66_21 Depth=1
	jmp	.LBB66_69
.LBB66_69:                              #   in Loop: Header=BB66_21 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB66_21
.LBB66_70:
	movq	-1096(%rbp), %rdi
	callq	gdFree@PLT
	movq	-1104(%rbp), %rdi
	callq	gdFree@PLT
.LBB66_71:
	addq	$1168, %rsp                     # imm = 0x490
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end66:
	.size	gdImageCopyResized, .Lfunc_end66-gdImageCopyResized
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyRotated
.LCPI67_0:
	.quad	0x4000000000000000              # double 2
.LCPI67_1:
	.quad	0x3f91df46a1fae711              # double 0.017453292499999998
.LCPI67_2:
	.quad	0x3ff0000000000000              # double 1
	.text
	.globl	gdImageCopyRotated
	.p2align	4, 0x90
	.type	gdImageCopyRotated,@function
gdImageCopyRotated:                     # @gdImageCopyRotated
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$1280, %rsp                     # imm = 0x500
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movsd	%xmm0, -24(%rbp)
	movsd	%xmm1, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	%ecx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movl	%r9d, -48(%rbp)
	movl	-44(%rbp), %eax
	imull	-44(%rbp), %eax
	movl	-48(%rbp), %ecx
	imull	-48(%rbp), %ecx
	addl	%ecx, %eax
	cvtsi2sd	%eax, %xmm0
	callq	sqrt@PLT
	movsd	%xmm0, -72(%rbp)
	cvtsi2sdl	16(%rbp), %xmm0
	movsd	.LCPI67_1(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm1, %xmm0
	callq	cos@PLT
	movsd	%xmm0, -80(%rbp)
	cvtsi2sdl	16(%rbp), %xmm0
	movsd	.LCPI67_1(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm1, %xmm0
	callq	sin@PLT
	movsd	%xmm0, -88(%rbp)
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-44(%rbp), %xmm1
	movsd	.LCPI67_0(%rip), %xmm2          # xmm2 = mem[0],zero
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -96(%rbp)
	cvtsi2sdl	-40(%rbp), %xmm0
	cvtsi2sdl	-48(%rbp), %xmm1
	movsd	.LCPI67_0(%rip), %xmm2          # xmm2 = mem[0],zero
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$-1, 4116(%rax)
	je	.LBB67_4
# %bb.1:
	movq	-8(%rbp), %rax
	cmpl	$-1, 4116(%rax)
	jne	.LBB67_3
# %bb.2:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 4116(%rax)
.LBB67_3:
	jmp	.LBB67_4
.LBB67_4:
	movl	$0, -1140(%rbp)
.LBB67_5:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -1140(%rbp)               # imm = 0x100
	jge	.LBB67_8
# %bb.6:                                #   in Loop: Header=BB67_5 Depth=1
	movslq	-1140(%rbp), %rax
	movl	$-1, -1136(%rbp,%rax,4)
# %bb.7:                                #   in Loop: Header=BB67_5 Depth=1
	movl	-1140(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -1140(%rbp)
	jmp	.LBB67_5
.LBB67_8:
	movsd	-32(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-72(%rbp), %xmm0
	movsd	%xmm0, -64(%rbp)
.LBB67_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB67_11 Depth 2
	movsd	-64(%rbp), %xmm1                # xmm1 = mem[0],zero
	movsd	-32(%rbp), %xmm0                # xmm0 = mem[0],zero
	addsd	-72(%rbp), %xmm0
	ucomisd	%xmm1, %xmm0
	jb	.LBB67_53
# %bb.10:                               #   in Loop: Header=BB67_9 Depth=1
	movsd	-24(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-72(%rbp), %xmm0
	movsd	%xmm0, -56(%rbp)
.LBB67_11:                              #   Parent Loop BB67_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movsd	-56(%rbp), %xmm1                # xmm1 = mem[0],zero
	movsd	-24(%rbp), %xmm0                # xmm0 = mem[0],zero
	addsd	-72(%rbp), %xmm0
	ucomisd	%xmm1, %xmm0
	jb	.LBB67_51
# %bb.12:                               #   in Loop: Header=BB67_11 Depth=2
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-24(%rbp), %xmm0
	movsd	-80(%rbp), %xmm2                # xmm2 = mem[0],zero
	movsd	-64(%rbp), %xmm1                # xmm1 = mem[0],zero
	subsd	-32(%rbp), %xmm1
	mulsd	-88(%rbp), %xmm1
	movq	%xmm1, %rax
	movabsq	$-9223372036854775808, %rcx     # imm = 0x8000000000000000
	xorq	%rcx, %rax
	movq	%rax, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -1152(%rbp)
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-32(%rbp), %xmm0
	movsd	-80(%rbp), %xmm2                # xmm2 = mem[0],zero
	movsd	-56(%rbp), %xmm1                # xmm1 = mem[0],zero
	subsd	-24(%rbp), %xmm1
	mulsd	-88(%rbp), %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -1160(%rbp)
	movsd	-1152(%rbp), %xmm0              # xmm0 = mem[0],zero
	addsd	-96(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -1164(%rbp)
	movsd	-1160(%rbp), %xmm0              # xmm0 = mem[0],zero
	addsd	-104(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -1168(%rbp)
	movl	-1164(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.LBB67_49
# %bb.13:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1164(%rbp), %eax
	movl	-36(%rbp), %ecx
	addl	-44(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB67_49
# %bb.14:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1168(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.LBB67_49
# %bb.15:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1168(%rbp), %eax
	movl	-40(%rbp), %ecx
	addl	-48(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB67_49
# %bb.16:                               #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rdi
	movl	-1164(%rbp), %esi
	movl	-1168(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -1172(%rbp)
	movl	-1172(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB67_18
# %bb.17:                               #   in Loop: Header=BB67_11 Depth=2
	movq	-8(%rbp), %rdi
	cvttsd2si	-56(%rbp), %esi
	cvttsd2si	-64(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	4116(%rax), %ecx
	callq	gdImageSetPixel
	jmp	.LBB67_48
.LBB67_18:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB67_34
# %bb.19:                               #   in Loop: Header=BB67_11 Depth=2
	movslq	-1172(%rbp), %rax
	cmpl	$-1, -1136(%rbp,%rax,4)
	jne	.LBB67_33
# %bb.20:                               #   in Loop: Header=BB67_11 Depth=2
	movq	-8(%rbp), %rax
	movq	%rax, -1184(%rbp)               # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_22
# %bb.21:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -1188(%rbp)               # 4-byte Spill
	jmp	.LBB67_23
.LBB67_22:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -1188(%rbp)               # 4-byte Spill
.LBB67_23:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1188(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1192(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_25
# %bb.24:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -1196(%rbp)               # 4-byte Spill
	jmp	.LBB67_26
.LBB67_25:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -1196(%rbp)               # 4-byte Spill
.LBB67_26:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1196(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1200(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_28
# %bb.27:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -1204(%rbp)               # 4-byte Spill
	jmp	.LBB67_29
.LBB67_28:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -1204(%rbp)               # 4-byte Spill
.LBB67_29:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1204(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1208(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_31
# %bb.30:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -1212(%rbp)               # 4-byte Spill
	jmp	.LBB67_32
.LBB67_31:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -1212(%rbp)               # 4-byte Spill
.LBB67_32:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1208(%rbp), %ecx               # 4-byte Reload
	movl	-1200(%rbp), %edx               # 4-byte Reload
	movl	-1192(%rbp), %esi               # 4-byte Reload
	movq	-1184(%rbp), %rdi               # 8-byte Reload
	movl	-1212(%rbp), %r8d               # 4-byte Reload
	callq	gdImageColorResolveAlpha
	movl	%eax, %ecx
	movslq	-1172(%rbp), %rax
	movl	%ecx, -1136(%rbp,%rax,4)
.LBB67_33:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-8(%rbp), %rdi
	cvttsd2si	-56(%rbp), %esi
	cvttsd2si	-64(%rbp), %edx
	movslq	-1172(%rbp), %rax
	movl	-1136(%rbp,%rax,4), %ecx
	callq	gdImageSetPixel
	jmp	.LBB67_47
.LBB67_34:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-8(%rbp), %rax
	movq	%rax, -1240(%rbp)               # 8-byte Spill
	cvttsd2si	-56(%rbp), %eax
	movl	%eax, -1232(%rbp)               # 4-byte Spill
	cvttsd2si	-64(%rbp), %eax
	movl	%eax, -1228(%rbp)               # 4-byte Spill
	movq	-8(%rbp), %rax
	movq	%rax, -1224(%rbp)               # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_36
# %bb.35:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -1244(%rbp)               # 4-byte Spill
	jmp	.LBB67_37
.LBB67_36:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -1244(%rbp)               # 4-byte Spill
.LBB67_37:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1244(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1248(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_39
# %bb.38:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -1252(%rbp)               # 4-byte Spill
	jmp	.LBB67_40
.LBB67_39:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -1252(%rbp)               # 4-byte Spill
.LBB67_40:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1252(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1256(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_42
# %bb.41:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -1260(%rbp)               # 4-byte Spill
	jmp	.LBB67_43
.LBB67_42:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -1260(%rbp)               # 4-byte Spill
.LBB67_43:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1260(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1264(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_45
# %bb.44:                               #   in Loop: Header=BB67_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -1268(%rbp)               # 4-byte Spill
	jmp	.LBB67_46
.LBB67_45:                              #   in Loop: Header=BB67_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -1268(%rbp)               # 4-byte Spill
.LBB67_46:                              #   in Loop: Header=BB67_11 Depth=2
	movl	-1264(%rbp), %ecx               # 4-byte Reload
	movl	-1256(%rbp), %edx               # 4-byte Reload
	movl	-1248(%rbp), %esi               # 4-byte Reload
	movq	-1224(%rbp), %rdi               # 8-byte Reload
	movl	-1268(%rbp), %r8d               # 4-byte Reload
	callq	gdImageColorResolveAlpha
	movq	-1240(%rbp), %rdi               # 8-byte Reload
	movl	-1232(%rbp), %esi               # 4-byte Reload
	movl	-1228(%rbp), %edx               # 4-byte Reload
	movl	%eax, %ecx
	callq	gdImageSetPixel
.LBB67_47:                              #   in Loop: Header=BB67_11 Depth=2
	jmp	.LBB67_48
.LBB67_48:                              #   in Loop: Header=BB67_11 Depth=2
	jmp	.LBB67_49
.LBB67_49:                              #   in Loop: Header=BB67_11 Depth=2
	jmp	.LBB67_50
.LBB67_50:                              #   in Loop: Header=BB67_11 Depth=2
	movsd	.LCPI67_2(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-56(%rbp), %xmm0
	movsd	%xmm0, -56(%rbp)
	jmp	.LBB67_11
.LBB67_51:                              #   in Loop: Header=BB67_9 Depth=1
	jmp	.LBB67_52
.LBB67_52:                              #   in Loop: Header=BB67_9 Depth=1
	movsd	.LCPI67_2(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-64(%rbp), %xmm0
	movsd	%xmm0, -64(%rbp)
	jmp	.LBB67_9
.LBB67_53:
	addq	$1280, %rsp                     # imm = 0x500
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end67:
	.size	gdImageCopyRotated, .Lfunc_end67-gdImageCopyRotated
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyResampled
.LCPI68_0:
	.quad	0x3ff0000000000000              # double 1
.LCPI68_1:
	.quad	0x3fe0000000000000              # double 0.5
.LCPI68_2:
	.quad	0x406fe00000000000              # double 255
.LCPI68_3:
	.quad	0x405fc00000000000              # double 127
	.text
	.globl	gdImageCopyResampled
	.p2align	4, 0x90
	.type	gdImageCopyResampled,@function
gdImageCopyResampled:                   # @gdImageCopyResampled
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$216, %rsp
	.cfi_offset %rbx, -24
	movl	40(%rbp), %eax
	movl	32(%rbp), %eax
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	%ecx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movl	%r9d, -40(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB68_2
# %bb.1:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %ecx
	movl	-36(%rbp), %r8d
	movl	-40(%rbp), %r9d
	movl	16(%rbp), %ebx
	movl	24(%rbp), %r11d
	movl	32(%rbp), %r10d
	movl	40(%rbp), %eax
	movl	%ebx, (%rsp)
	movl	%r11d, 8(%rsp)
	movl	%r10d, 16(%rsp)
	movl	%eax, 24(%rsp)
	callq	gdImageCopyResized
	jmp	.LBB68_46
.LBB68_2:
	movl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB68_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB68_5 Depth 2
                                        #       Child Loop BB68_7 Depth 3
                                        #         Child Loop BB68_16 Depth 4
	movl	-48(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB68_46
# %bb.4:                                #   in Loop: Header=BB68_3 Depth=1
	cvtsi2sdl	-48(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	subsd	%xmm1, %xmm0
	cvtsi2sdl	40(%rbp), %xmm1
	mulsd	%xmm1, %xmm0
	cvtsi2sdl	24(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movl	-48(%rbp), %eax
	addl	$1, %eax
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	subsd	%xmm1, %xmm0
	cvtsi2sdl	40(%rbp), %xmm1
	mulsd	%xmm1, %xmm0
	cvtsi2sdl	24(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -64(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB68_5:                               #   Parent Loop BB68_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB68_7 Depth 3
                                        #         Child Loop BB68_16 Depth 4
	movl	-44(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB68_44
# %bb.6:                                #   in Loop: Header=BB68_5 Depth=2
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -104(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -112(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -120(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -128(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -136(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -144(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -152(%rbp)
	cvtsi2sdl	-44(%rbp), %xmm0
	cvtsi2sdl	-28(%rbp), %xmm1
	subsd	%xmm1, %xmm0
	cvtsi2sdl	32(%rbp), %xmm1
	mulsd	%xmm1, %xmm0
	cvtsi2sdl	16(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -72(%rbp)
	movl	-44(%rbp), %eax
	addl	$1, %eax
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	-28(%rbp), %xmm1
	subsd	%xmm1, %xmm0
	cvtsi2sdl	32(%rbp), %xmm1
	mulsd	%xmm1, %xmm0
	cvtsi2sdl	16(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -80(%rbp)
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	movsd	%xmm0, -96(%rbp)
.LBB68_7:                               #   Parent Loop BB68_3 Depth=1
                                        #     Parent Loop BB68_5 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB68_16 Depth 4
	cvttsd2si	-96(%rbp), %rax
	cvttsd2si	-56(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB68_11
# %bb.8:                                #   in Loop: Header=BB68_7 Depth=3
	movsd	-96(%rbp), %xmm1                # xmm1 = mem[0],zero
	cvttsd2si	-96(%rbp), %rax
	cvtsi2sd	%rax, %xmm0
	subsd	%xmm0, %xmm1
	movsd	.LCPI68_0(%rip), %xmm0          # xmm0 = mem[0],zero
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -160(%rbp)
	movsd	-160(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	-64(%rbp), %xmm1                # xmm1 = mem[0],zero
	subsd	-56(%rbp), %xmm1
	ucomisd	%xmm1, %xmm0
	jbe	.LBB68_10
# %bb.9:                                #   in Loop: Header=BB68_7 Depth=3
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-56(%rbp), %xmm0
	movsd	%xmm0, -160(%rbp)
.LBB68_10:                              #   in Loop: Header=BB68_7 Depth=3
	cvttsd2si	-96(%rbp), %rax
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, -96(%rbp)
	jmp	.LBB68_15
.LBB68_11:                              #   in Loop: Header=BB68_7 Depth=3
	movsd	-96(%rbp), %xmm0                # xmm0 = mem[0],zero
	cvttsd2si	-64(%rbp), %rax
	cvtsi2sd	%rax, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB68_13
	jp	.LBB68_13
# %bb.12:                               #   in Loop: Header=BB68_7 Depth=3
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	cvttsd2si	-64(%rbp), %rax
	cvtsi2sd	%rax, %xmm1
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -160(%rbp)
	jmp	.LBB68_14
.LBB68_13:                              #   in Loop: Header=BB68_7 Depth=3
	movsd	.LCPI68_0(%rip), %xmm0          # xmm0 = mem[0],zero
	movsd	%xmm0, -160(%rbp)
.LBB68_14:                              #   in Loop: Header=BB68_7 Depth=3
	jmp	.LBB68_15
.LBB68_15:                              #   in Loop: Header=BB68_7 Depth=3
	movsd	-72(%rbp), %xmm0                # xmm0 = mem[0],zero
	movsd	%xmm0, -88(%rbp)
.LBB68_16:                              #   Parent Loop BB68_3 Depth=1
                                        #     Parent Loop BB68_5 Depth=2
                                        #       Parent Loop BB68_7 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cvttsd2si	-88(%rbp), %rax
	cvttsd2si	-72(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB68_20
# %bb.17:                               #   in Loop: Header=BB68_16 Depth=4
	movsd	-88(%rbp), %xmm1                # xmm1 = mem[0],zero
	cvttsd2si	-88(%rbp), %rax
	cvtsi2sd	%rax, %xmm0
	subsd	%xmm0, %xmm1
	movsd	.LCPI68_0(%rip), %xmm0          # xmm0 = mem[0],zero
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -168(%rbp)
	movsd	-168(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	-80(%rbp), %xmm1                # xmm1 = mem[0],zero
	subsd	-72(%rbp), %xmm1
	ucomisd	%xmm1, %xmm0
	jbe	.LBB68_19
# %bb.18:                               #   in Loop: Header=BB68_16 Depth=4
	movsd	-80(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-72(%rbp), %xmm0
	movsd	%xmm0, -168(%rbp)
.LBB68_19:                              #   in Loop: Header=BB68_16 Depth=4
	cvttsd2si	-88(%rbp), %rax
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, -88(%rbp)
	jmp	.LBB68_24
.LBB68_20:                              #   in Loop: Header=BB68_16 Depth=4
	movsd	-88(%rbp), %xmm0                # xmm0 = mem[0],zero
	cvttsd2si	-80(%rbp), %rax
	cvtsi2sd	%rax, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB68_22
	jp	.LBB68_22
# %bb.21:                               #   in Loop: Header=BB68_16 Depth=4
	movsd	-80(%rbp), %xmm0                # xmm0 = mem[0],zero
	cvttsd2si	-80(%rbp), %rax
	cvtsi2sd	%rax, %xmm1
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -168(%rbp)
	jmp	.LBB68_23
.LBB68_22:                              #   in Loop: Header=BB68_16 Depth=4
	movsd	.LCPI68_0(%rip), %xmm0          # xmm0 = mem[0],zero
	movsd	%xmm0, -168(%rbp)
.LBB68_23:                              #   in Loop: Header=BB68_16 Depth=4
	jmp	.LBB68_24
.LBB68_24:                              #   in Loop: Header=BB68_16 Depth=4
	movsd	-168(%rbp), %xmm0               # xmm0 = mem[0],zero
	mulsd	-160(%rbp), %xmm0
	movsd	%xmm0, -176(%rbp)
	movq	-24(%rbp), %rdi
	cvttsd2si	-88(%rbp), %esi
	addl	-36(%rbp), %esi
	cvttsd2si	-96(%rbp), %edx
	addl	-40(%rbp), %edx
	callq	gdImageGetTrueColorPixel
	movl	%eax, -180(%rbp)
	movl	-180(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	cvtsi2sd	%eax, %xmm0
	movsd	-176(%rbp), %xmm2               # xmm2 = mem[0],zero
	movsd	-112(%rbp), %xmm1               # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)
	movl	-180(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	cvtsi2sd	%eax, %xmm0
	movsd	-176(%rbp), %xmm2               # xmm2 = mem[0],zero
	movsd	-120(%rbp), %xmm1               # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -120(%rbp)
	movl	-180(%rbp), %eax
	andl	$255, %eax
	cvtsi2sd	%eax, %xmm0
	movsd	-176(%rbp), %xmm2               # xmm2 = mem[0],zero
	movsd	-128(%rbp), %xmm1               # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -128(%rbp)
	movl	-180(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	cvtsi2sd	%eax, %xmm0
	movsd	-176(%rbp), %xmm2               # xmm2 = mem[0],zero
	movsd	-136(%rbp), %xmm1               # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -136(%rbp)
	movsd	-168(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	-160(%rbp), %xmm2               # xmm2 = mem[0],zero
	movsd	-104(%rbp), %xmm1               # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)
	movsd	.LCPI68_0(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-88(%rbp), %xmm0
	movsd	%xmm0, -88(%rbp)
# %bb.25:                               #   in Loop: Header=BB68_16 Depth=4
	movsd	-88(%rbp), %xmm1                # xmm1 = mem[0],zero
	movsd	-80(%rbp), %xmm0                # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	ja	.LBB68_16
# %bb.26:                               #   in Loop: Header=BB68_7 Depth=3
	movsd	.LCPI68_0(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-96(%rbp), %xmm0
	movsd	%xmm0, -96(%rbp)
# %bb.27:                               #   in Loop: Header=BB68_7 Depth=3
	movsd	-96(%rbp), %xmm1                # xmm1 = mem[0],zero
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	ja	.LBB68_7
# %bb.28:                               #   in Loop: Header=BB68_5 Depth=2
	movsd	-104(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB68_29
	jp	.LBB68_29
	jmp	.LBB68_30
.LBB68_29:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-104(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)
	movsd	-104(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-120(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -120(%rbp)
	movsd	-104(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-128(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -128(%rbp)
	movsd	-104(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-136(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -136(%rbp)
	movsd	.LCPI68_1(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-136(%rbp), %xmm0
	movsd	%xmm0, -136(%rbp)
.LBB68_30:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-144(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB68_31
	jp	.LBB68_31
	jmp	.LBB68_34
.LBB68_31:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-152(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB68_32
	jp	.LBB68_32
	jmp	.LBB68_33
.LBB68_32:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-152(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-144(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -144(%rbp)
.LBB68_33:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-144(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)
	movsd	-144(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-120(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -120(%rbp)
	movsd	-144(%rbp), %xmm1               # xmm1 = mem[0],zero
	movsd	-128(%rbp), %xmm0               # xmm0 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -128(%rbp)
.LBB68_34:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	.LCPI68_2(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB68_36
# %bb.35:                               #   in Loop: Header=BB68_5 Depth=2
	movsd	.LCPI68_2(%rip), %xmm0          # xmm0 = mem[0],zero
	movsd	%xmm0, -112(%rbp)
.LBB68_36:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-120(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	.LCPI68_2(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB68_38
# %bb.37:                               #   in Loop: Header=BB68_5 Depth=2
	movsd	.LCPI68_2(%rip), %xmm0          # xmm0 = mem[0],zero
	movsd	%xmm0, -120(%rbp)
.LBB68_38:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-128(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	.LCPI68_2(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB68_40
# %bb.39:                               #   in Loop: Header=BB68_5 Depth=2
	movsd	.LCPI68_2(%rip), %xmm0          # xmm0 = mem[0],zero
	movsd	%xmm0, -128(%rbp)
.LBB68_40:                              #   in Loop: Header=BB68_5 Depth=2
	movsd	-136(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	.LCPI68_3(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB68_42
# %bb.41:                               #   in Loop: Header=BB68_5 Depth=2
	movsd	.LCPI68_3(%rip), %xmm0          # xmm0 = mem[0],zero
	movsd	%xmm0, -136(%rbp)
.LBB68_42:                              #   in Loop: Header=BB68_5 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	cvttsd2si	-136(%rbp), %ecx
	shll	$24, %ecx
	cvttsd2si	-112(%rbp), %eax
	shll	$16, %eax
	addl	%eax, %ecx
	cvttsd2si	-120(%rbp), %eax
	shll	$8, %eax
	addl	%eax, %ecx
	cvttsd2si	-128(%rbp), %eax
	addl	%eax, %ecx
	callq	gdImageSetPixel
# %bb.43:                               #   in Loop: Header=BB68_5 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB68_5
.LBB68_44:                              #   in Loop: Header=BB68_3 Depth=1
	jmp	.LBB68_45
.LBB68_45:                              #   in Loop: Header=BB68_3 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB68_3
.LBB68_46:
	addq	$216, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end68:
	.size	gdImageCopyResampled, .Lfunc_end68-gdImageCopyResampled
	.cfi_endproc
                                        # -- End function
	.globl	gdImagePolygon                  # -- Begin function gdImagePolygon
	.p2align	4, 0x90
	.type	gdImagePolygon,@function
gdImagePolygon:                         # @gdImagePolygon
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
	cmpl	$0, -20(%rbp)
	jg	.LBB69_2
# %bb.1:
	jmp	.LBB69_3
.LBB69_2:
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rax
	movl	(%rax), %esi
	movq	-16(%rbp), %rax
	movl	4(%rax), %edx
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	subl	$1, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,8), %ecx
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %r8d
	subl	$1, %r8d
	movslq	%r8d, %r8
	movl	4(%rax,%r8,8), %r8d
	movl	-24(%rbp), %r9d
	callq	gdImageLine
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageOpenPolygon
.LBB69_3:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end69:
	.size	gdImagePolygon, .Lfunc_end69-gdImagePolygon
	.cfi_endproc
                                        # -- End function
	.globl	gdImageOpenPolygon              # -- Begin function gdImageOpenPolygon
	.p2align	4, 0x90
	.type	gdImageOpenPolygon,@function
gdImageOpenPolygon:                     # @gdImageOpenPolygon
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
	cmpl	$0, -20(%rbp)
	jg	.LBB70_2
# %bb.1:
	jmp	.LBB70_6
.LBB70_2:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -36(%rbp)
	movl	$1, -28(%rbp)
.LBB70_3:                               # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB70_6
# %bb.4:                                #   in Loop: Header=BB70_3 Depth=1
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movq	-16(%rbp), %rax
	movl	(%rax), %ecx
	movq	-16(%rbp), %rax
	movl	4(%rax), %r8d
	movl	-24(%rbp), %r9d
	callq	gdImageLine
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -36(%rbp)
# %bb.5:                                #   in Loop: Header=BB70_3 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB70_3
.LBB70_6:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end70:
	.size	gdImageOpenPolygon, .Lfunc_end70-gdImageOpenPolygon
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetThickness             # -- Begin function gdImageSetThickness
	.p2align	4, 0x90
	.type	gdImageSetThickness,@function
gdImageSetThickness:                    # @gdImageSetThickness
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 6220(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end71:
	.size	gdImageSetThickness, .Lfunc_end71-gdImageSetThickness
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetBrush                 # -- Begin function gdImageSetBrush
	.p2align	4, 0x90
	.type	gdImageSetBrush,@function
gdImageSetBrush:                        # @gdImageSetBrush
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 4136(%rax)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB72_19
# %bb.1:
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB72_19
# %bb.2:
	movl	$0, -20(%rbp)
.LBB72_3:                               # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB72_18
# %bb.4:                                #   in Loop: Header=BB72_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB72_6
# %bb.5:                                #   in Loop: Header=BB72_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	jmp	.LBB72_7
.LBB72_6:                               #   in Loop: Header=BB72_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
.LBB72_7:                               #   in Loop: Header=BB72_3 Depth=1
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB72_9
# %bb.8:                                #   in Loop: Header=BB72_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	jmp	.LBB72_10
.LBB72_9:                               #   in Loop: Header=BB72_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
.LBB72_10:                              #   in Loop: Header=BB72_3 Depth=1
	movl	-44(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB72_12
# %bb.11:                               #   in Loop: Header=BB72_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB72_13
.LBB72_12:                              #   in Loop: Header=BB72_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB72_13:                              #   in Loop: Header=BB72_3 Depth=1
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB72_15
# %bb.14:                               #   in Loop: Header=BB72_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	jmp	.LBB72_16
.LBB72_15:                              #   in Loop: Header=BB72_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
.LBB72_16:                              #   in Loop: Header=BB72_3 Depth=1
	movl	-56(%rbp), %ecx                 # 4-byte Reload
	movl	-48(%rbp), %edx                 # 4-byte Reload
	movl	-40(%rbp), %esi                 # 4-byte Reload
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movl	-60(%rbp), %r8d                 # 4-byte Reload
	callq	gdImageColorResolveAlpha
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 4152(%rax,%rcx,4)
# %bb.17:                               #   in Loop: Header=BB72_3 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB72_3
.LBB72_18:
	jmp	.LBB72_19
.LBB72_19:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end72:
	.size	gdImageSetBrush, .Lfunc_end72-gdImageSetBrush
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetTile                  # -- Begin function gdImageSetTile
	.p2align	4, 0x90
	.type	gdImageSetTile,@function
gdImageSetTile:                         # @gdImageSetTile
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 4144(%rax)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB73_19
# %bb.1:
	movq	-8(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB73_19
# %bb.2:
	movl	$0, -20(%rbp)
.LBB73_3:                               # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB73_18
# %bb.4:                                #   in Loop: Header=BB73_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB73_6
# %bb.5:                                #   in Loop: Header=BB73_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	jmp	.LBB73_7
.LBB73_6:                               #   in Loop: Header=BB73_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
.LBB73_7:                               #   in Loop: Header=BB73_3 Depth=1
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB73_9
# %bb.8:                                #   in Loop: Header=BB73_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	jmp	.LBB73_10
.LBB73_9:                               #   in Loop: Header=BB73_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
.LBB73_10:                              #   in Loop: Header=BB73_3 Depth=1
	movl	-44(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB73_12
# %bb.11:                               #   in Loop: Header=BB73_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB73_13
.LBB73_12:                              #   in Loop: Header=BB73_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB73_13:                              #   in Loop: Header=BB73_3 Depth=1
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB73_15
# %bb.14:                               #   in Loop: Header=BB73_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	jmp	.LBB73_16
.LBB73_15:                              #   in Loop: Header=BB73_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
.LBB73_16:                              #   in Loop: Header=BB73_3 Depth=1
	movl	-56(%rbp), %ecx                 # 4-byte Reload
	movl	-48(%rbp), %edx                 # 4-byte Reload
	movl	-40(%rbp), %esi                 # 4-byte Reload
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movl	-60(%rbp), %r8d                 # 4-byte Reload
	callq	gdImageColorResolveAlpha
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 5176(%rax,%rcx,4)
# %bb.17:                               #   in Loop: Header=BB73_3 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB73_3
.LBB73_18:
	jmp	.LBB73_19
.LBB73_19:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end73:
	.size	gdImageSetTile, .Lfunc_end73-gdImageSetTile
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetAntiAliased           # -- Begin function gdImageSetAntiAliased
	.p2align	4, 0x90
	.type	gdImageSetAntiAliased,@function
gdImageSetAntiAliased:                  # @gdImageSetAntiAliased
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rax
	movl	$1, 7272(%rax)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7276(%rax)
	movq	-8(%rbp), %rax
	movl	$-1, 7280(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end74:
	.size	gdImageSetAntiAliased, .Lfunc_end74-gdImageSetAntiAliased
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetAntiAliasedDontBlend  # -- Begin function gdImageSetAntiAliasedDontBlend
	.p2align	4, 0x90
	.type	gdImageSetAntiAliasedDontBlend,@function
gdImageSetAntiAliasedDontBlend:         # @gdImageSetAntiAliasedDontBlend
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	$1, 7272(%rax)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7276(%rax)
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7280(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end75:
	.size	gdImageSetAntiAliasedDontBlend, .Lfunc_end75-gdImageSetAntiAliasedDontBlend
	.cfi_endproc
                                        # -- End function
	.globl	gdImageInterlace                # -- Begin function gdImageInterlace
	.p2align	4, 0x90
	.type	gdImageInterlace,@function
gdImageInterlace:                       # @gdImageInterlace
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 6216(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end76:
	.size	gdImageInterlace, .Lfunc_end76-gdImageInterlace
	.cfi_endproc
                                        # -- End function
	.globl	gdImageCompare                  # -- Begin function gdImageCompare
	.p2align	4, 0x90
	.type	gdImageCompare,@function
gdImageCompare:                         # @gdImageCompare
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$0, -36(%rbp)
	movq	-8(%rbp), %rax
	movl	6216(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	6216(%rcx), %eax
	je	.LBB77_2
# %bb.1:
	movl	-36(%rbp), %eax
	orl	$128, %eax
	movl	%eax, -36(%rbp)
.LBB77_2:
	movq	-8(%rbp), %rax
	movl	4116(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB77_4
# %bb.3:
	movl	-36(%rbp), %eax
	orl	$32, %eax
	movl	%eax, -36(%rbp)
.LBB77_4:
	movq	-8(%rbp), %rax
	movl	7248(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	7248(%rcx), %eax
	je	.LBB77_6
# %bb.5:
	movl	-36(%rbp), %eax
	orl	$256, %eax                      # imm = 0x100
	movl	%eax, -36(%rbp)
.LBB77_6:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -40(%rbp)
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	8(%rcx), %eax
	je	.LBB77_10
# %bb.7:
	movl	-36(%rbp), %eax
	orl	$9, %eax
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB77_9
# %bb.8:
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -40(%rbp)
.LBB77_9:
	jmp	.LBB77_10
.LBB77_10:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	12(%rcx), %eax
	je	.LBB77_14
# %bb.11:
	movl	-36(%rbp), %eax
	orl	$17, %eax
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB77_13
# %bb.12:
	movq	-16(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB77_13:
	jmp	.LBB77_14
.LBB77_14:
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	je	.LBB77_16
# %bb.15:
	movl	-36(%rbp), %eax
	orl	$2, %eax
	movl	%eax, -36(%rbp)
.LBB77_16:
	movl	$0, -24(%rbp)
.LBB77_17:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB77_19 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB77_56
# %bb.18:                               #   in Loop: Header=BB77_17 Depth=1
	movl	$0, -20(%rbp)
.LBB77_19:                              #   Parent Loop BB77_17 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	.LBB77_52
# %bb.20:                               #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_22
# %bb.21:                               #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	jmp	.LBB77_23
.LBB77_22:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
.LBB77_23:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-48(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -28(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_25
# %bb.24:                               #   in Loop: Header=BB77_19 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB77_26
.LBB77_25:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB77_26:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -32(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_28
# %bb.27:                               #   in Loop: Header=BB77_19 Depth=2
	movl	-28(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	jmp	.LBB77_29
.LBB77_28:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
.LBB77_29:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_31
# %bb.30:                               #   in Loop: Header=BB77_19 Depth=2
	movl	-32(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	jmp	.LBB77_32
.LBB77_31:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
.LBB77_32:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-60(%rbp), %eax                 # 4-byte Reload
	movl	-64(%rbp), %ecx                 # 4-byte Reload
	cmpl	%ecx, %eax
	je	.LBB77_34
# %bb.33:                               #   in Loop: Header=BB77_17 Depth=1
	movl	-36(%rbp), %eax
	orl	$5, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB77_52
.LBB77_34:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_36
# %bb.35:                               #   in Loop: Header=BB77_19 Depth=2
	movl	-28(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	jmp	.LBB77_37
.LBB77_36:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
.LBB77_37:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-68(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -72(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_39
# %bb.38:                               #   in Loop: Header=BB77_19 Depth=2
	movl	-32(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	jmp	.LBB77_40
.LBB77_39:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
.LBB77_40:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-72(%rbp), %eax                 # 4-byte Reload
	movl	-76(%rbp), %ecx                 # 4-byte Reload
	cmpl	%ecx, %eax
	je	.LBB77_42
# %bb.41:                               #   in Loop: Header=BB77_17 Depth=1
	movl	-36(%rbp), %eax
	orl	$5, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB77_52
.LBB77_42:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_44
# %bb.43:                               #   in Loop: Header=BB77_19 Depth=2
	movl	-28(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
	jmp	.LBB77_45
.LBB77_44:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
.LBB77_45:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-80(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -84(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB77_47
# %bb.46:                               #   in Loop: Header=BB77_19 Depth=2
	movl	-32(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -88(%rbp)                 # 4-byte Spill
	jmp	.LBB77_48
.LBB77_47:                              #   in Loop: Header=BB77_19 Depth=2
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -88(%rbp)                 # 4-byte Spill
.LBB77_48:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-84(%rbp), %eax                 # 4-byte Reload
	movl	-88(%rbp), %ecx                 # 4-byte Reload
	cmpl	%ecx, %eax
	je	.LBB77_50
# %bb.49:                               #   in Loop: Header=BB77_17 Depth=1
	movl	-36(%rbp), %eax
	orl	$5, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB77_52
.LBB77_50:                              #   in Loop: Header=BB77_19 Depth=2
	jmp	.LBB77_51
.LBB77_51:                              #   in Loop: Header=BB77_19 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB77_19
.LBB77_52:                              #   in Loop: Header=BB77_17 Depth=1
	movl	-36(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB77_54
# %bb.53:
	jmp	.LBB77_56
.LBB77_54:                              #   in Loop: Header=BB77_17 Depth=1
	jmp	.LBB77_55
.LBB77_55:                              #   in Loop: Header=BB77_17 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB77_17
.LBB77_56:
	movl	-36(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end77:
	.size	gdImageCompare, .Lfunc_end77-gdImageCompare
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdAlphaOverlayColor
	.type	gdAlphaOverlayColor,@function
gdAlphaOverlayColor:                    # @gdAlphaOverlayColor
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	-12(%rbp), %eax
	shll	$1, %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.LBB78_2
# %bb.1:
	movl	-12(%rbp), %eax
	movl	-8(%rbp), %ecx
	shll	$1, %ecx
	addl	%ecx, %eax
	movl	%eax, -20(%rbp)                 # 4-byte Spill
	movl	-12(%rbp), %eax
	imull	-8(%rbp), %eax
	cltd
	idivl	-16(%rbp)
	movl	%eax, %ecx
	movl	-20(%rbp), %eax                 # 4-byte Reload
	subl	%ecx, %eax
	subl	-16(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB78_3
.LBB78_2:
	movl	-12(%rbp), %eax
	imull	-8(%rbp), %eax
	cltd
	idivl	-16(%rbp)
	movl	%eax, -4(%rbp)
.LBB78_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end78:
	.size	gdAlphaOverlayColor, .Lfunc_end78-gdAlphaOverlayColor
	.cfi_endproc
                                        # -- End function
	.globl	gdImageAlphaBlending            # -- Begin function gdImageAlphaBlending
	.p2align	4, 0x90
	.type	gdImageAlphaBlending,@function
gdImageAlphaBlending:                   # @gdImageAlphaBlending
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end79:
	.size	gdImageAlphaBlending, .Lfunc_end79-gdImageAlphaBlending
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSaveAlpha                # -- Begin function gdImageSaveAlpha
	.p2align	4, 0x90
	.type	gdImageSaveAlpha,@function
gdImageSaveAlpha:                       # @gdImageSaveAlpha
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7268(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end80:
	.size	gdImageSaveAlpha, .Lfunc_end80-gdImageSaveAlpha
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetClip                  # -- Begin function gdImageSetClip
	.p2align	4, 0x90
	.type	gdImageSetClip,@function
gdImageSetClip:                         # @gdImageSetClip
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	cmpl	$0, -12(%rbp)
	jge	.LBB81_2
# %bb.1:
	movl	$0, -12(%rbp)
.LBB81_2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB81_4
# %bb.3:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB81_4:
	cmpl	$0, -20(%rbp)
	jge	.LBB81_6
# %bb.5:
	movl	$0, -20(%rbp)
.LBB81_6:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB81_8
# %bb.7:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -20(%rbp)
.LBB81_8:
	cmpl	$0, -16(%rbp)
	jge	.LBB81_10
# %bb.9:
	movl	$0, -16(%rbp)
.LBB81_10:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB81_12
# %bb.11:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
.LBB81_12:
	cmpl	$0, -24(%rbp)
	jge	.LBB81_14
# %bb.13:
	movl	$0, -24(%rbp)
.LBB81_14:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB81_16
# %bb.15:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -24(%rbp)
.LBB81_16:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7284(%rax)
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7288(%rax)
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7292(%rax)
	movl	-24(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7296(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end81:
	.size	gdImageSetClip, .Lfunc_end81-gdImageSetClip
	.cfi_endproc
                                        # -- End function
	.globl	gdImageGetClip                  # -- Begin function gdImageGetClip
	.p2align	4, 0x90
	.type	gdImageGetClip,@function
gdImageGetClip:                         # @gdImageGetClip
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movq	-8(%rbp), %rax
	movl	7284(%rax), %ecx
	movq	-16(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-8(%rbp), %rax
	movl	7288(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-8(%rbp), %rax
	movl	7292(%rax), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-8(%rbp), %rax
	movl	7296(%rax), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, (%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end82:
	.size	gdImageGetClip, .Lfunc_end82-gdImageGetClip
	.cfi_endproc
                                        # -- End function
	.globl	gdImageSetResolution            # -- Begin function gdImageSetResolution
	.p2align	4, 0x90
	.type	gdImageSetResolution,@function
gdImageSetResolution:                   # @gdImageSetResolution
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	cmpl	$0, -12(%rbp)
	jbe	.LBB83_2
# %bb.1:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7300(%rax)
.LBB83_2:
	cmpl	$0, -16(%rbp)
	jbe	.LBB83_4
# %bb.3:
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7304(%rax)
.LBB83_4:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end83:
	.size	gdImageSetResolution, .Lfunc_end83-gdImageSetResolution
	.cfi_endproc
                                        # -- End function
	.globl	gdImagePaletteToTrueColor       # -- Begin function gdImagePaletteToTrueColor
	.p2align	4, 0x90
	.type	gdImagePaletteToTrueColor,@function
gdImagePaletteToTrueColor:              # @gdImagePaletteToTrueColor
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB84_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB84_30
.LBB84_2:
	movq	-16(%rbp), %rax
	cmpl	$1, 7248(%rax)
	jne	.LBB84_4
# %bb.3:
	movl	$1, -4(%rbp)
	jmp	.LBB84_30
.LBB84_4:
	movq	-16(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -36(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, %edi
	shlq	$3, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 7256(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 7256(%rax)
	jne	.LBB84_6
# %bb.5:
	movl	$0, -4(%rbp)
	jmp	.LBB84_30
.LBB84_6:
	movl	$0, -20(%rbp)
.LBB84_7:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB84_11 Depth 2
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jae	.LBB84_19
# %bb.8:                                #   in Loop: Header=BB84_7 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	-20(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -48(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-20(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	%rdx, (%rax,%rcx,8)
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-20(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	cmpq	$0, (%rax,%rcx,8)
	jne	.LBB84_10
# %bb.9:
	jmp	.LBB84_25
.LBB84_10:                              #   in Loop: Header=BB84_7 Depth=1
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-20(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -56(%rbp)
	movl	$0, -28(%rbp)
.LBB84_11:                              #   Parent Loop BB84_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jae	.LBB84_17
# %bb.12:                               #   in Loop: Header=BB84_11 Depth=2
	movq	-48(%rbp), %rax
	movl	-28(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %al
	movb	%al, -57(%rbp)
	movzbl	-57(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB84_14
# %bb.13:                               #   in Loop: Header=BB84_11 Depth=2
	movq	-56(%rbp), %rax
	movl	-28(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	$2130706432, (%rax,%rcx,4)      # imm = 0x7F000000
	jmp	.LBB84_15
.LBB84_14:                              #   in Loop: Header=BB84_11 Depth=2
	movq	-16(%rbp), %rax
	movzbl	-57(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	6224(%rax,%rcx,4), %edx
	shll	$24, %edx
	movq	-16(%rbp), %rax
	movzbl	-57(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	20(%rax,%rcx,4), %eax
	shll	$16, %eax
	addl	%eax, %edx
	movq	-16(%rbp), %rax
	movzbl	-57(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	1044(%rax,%rcx,4), %eax
	shll	$8, %eax
	addl	%eax, %edx
	movq	-16(%rbp), %rax
	movzbl	-57(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	addl	2068(%rax,%rcx,4), %edx
	movq	-56(%rbp), %rax
	movl	-28(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	%edx, (%rax,%rcx,4)
.LBB84_15:                              #   in Loop: Header=BB84_11 Depth=2
	jmp	.LBB84_16
.LBB84_16:                              #   in Loop: Header=BB84_11 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB84_11
.LBB84_17:                              #   in Loop: Header=BB84_7 Depth=1
	jmp	.LBB84_18
.LBB84_18:                              #   in Loop: Header=BB84_7 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB84_7
.LBB84_19:
	jmp	.LBB84_20
.LBB84_20:
	movl	$0, -24(%rbp)
.LBB84_21:                              # =>This Inner Loop Header: Depth=1
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jae	.LBB84_24
# %bb.22:                               #   in Loop: Header=BB84_21 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.23:                               #   in Loop: Header=BB84_21 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB84_21
.LBB84_24:
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	callq	gdFree@PLT
	movq	-16(%rbp), %rax
	movl	$1, 7248(%rax)
	movq	-16(%rbp), %rax
	movq	$0, (%rax)
	movq	-16(%rbp), %rax
	movl	$0, 7264(%rax)
	movq	-16(%rbp), %rax
	movl	$1, 7268(%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB84_30
.LBB84_25:
	movl	$0, -24(%rbp)
.LBB84_26:                              # =>This Inner Loop Header: Depth=1
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jae	.LBB84_29
# %bb.27:                               #   in Loop: Header=BB84_26 Depth=1
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-24(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.28:                               #   in Loop: Header=BB84_26 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB84_26
.LBB84_29:
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rdi
	callq	gdFree@PLT
	movl	$0, -4(%rbp)
.LBB84_30:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end84:
	.size	gdImagePaletteToTrueColor, .Lfunc_end84-gdImagePaletteToTrueColor
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function RGB_to_HWB
.LCPI85_0:
	.long	0x3f800000                      # float 1
.LCPI85_1:
	.long	0xbf800000                      # float -1
	.text
	.p2align	4, 0x90
	.type	RGB_to_HWB,@function
RGB_to_HWB:                             # @RGB_to_HWB
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movlpd	%xmm0, -40(%rbp)
	movss	%xmm1, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -16(%rbp)
	movq	%rdi, -48(%rbp)
	movss	-24(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -52(%rbp)
	movss	-20(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -56(%rbp)
	movss	-16(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -60(%rbp)
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB85_5
# %bb.1:
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB85_3
# %bb.2:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -84(%rbp)                # 4-byte Spill
	jmp	.LBB85_4
.LBB85_3:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -84(%rbp)                # 4-byte Spill
.LBB85_4:
	movss	-84(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -88(%rbp)                # 4-byte Spill
	jmp	.LBB85_9
.LBB85_5:
	movss	-56(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB85_7
# %bb.6:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -92(%rbp)                # 4-byte Spill
	jmp	.LBB85_8
.LBB85_7:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -92(%rbp)                # 4-byte Spill
.LBB85_8:
	movss	-92(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -88(%rbp)                # 4-byte Spill
.LBB85_9:
	movss	-88(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -64(%rbp)
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB85_14
# %bb.10:
	movss	-56(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB85_12
# %bb.11:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -96(%rbp)                # 4-byte Spill
	jmp	.LBB85_13
.LBB85_12:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -96(%rbp)                # 4-byte Spill
.LBB85_13:
	movss	-96(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -100(%rbp)               # 4-byte Spill
	jmp	.LBB85_18
.LBB85_14:
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB85_16
# %bb.15:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -104(%rbp)               # 4-byte Spill
	jmp	.LBB85_17
.LBB85_16:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -104(%rbp)               # 4-byte Spill
.LBB85_17:
	movss	-104(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -100(%rbp)               # 4-byte Spill
.LBB85_18:
	movss	-100(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -68(%rbp)
	movss	.LCPI85_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	subss	-68(%rbp), %xmm0
	movss	%xmm0, -72(%rbp)
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB85_20
	jp	.LBB85_20
# %bb.19:
	movq	-48(%rbp), %rax
	movss	.LCPI85_1(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, (%rax)
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movq	-48(%rbp), %rax
	movss	%xmm0, 4(%rax)
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movq	-48(%rbp), %rax
	movss	%xmm0, 8(%rax)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB85_30
.LBB85_20:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB85_22
	jp	.LBB85_22
# %bb.21:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-60(%rbp), %xmm0
	movss	%xmm0, -108(%rbp)               # 4-byte Spill
	jmp	.LBB85_26
.LBB85_22:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB85_24
	jp	.LBB85_24
# %bb.23:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-52(%rbp), %xmm0
	movss	%xmm0, -112(%rbp)               # 4-byte Spill
	jmp	.LBB85_25
.LBB85_24:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-56(%rbp), %xmm0
	movss	%xmm0, -112(%rbp)               # 4-byte Spill
.LBB85_25:
	movss	-112(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -108(%rbp)               # 4-byte Spill
.LBB85_26:
	movss	-108(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -76(%rbp)
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB85_28
	jp	.LBB85_28
# %bb.27:
	movl	$3, %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
	jmp	.LBB85_29
.LBB85_28:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	-64(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movl	$1, %eax
	movl	$5, %ecx
	ucomiss	%xmm1, %xmm0
	setnp	%sil
	sete	%dl
	testb	%sil, %dl
	cmovnel	%ecx, %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
.LBB85_29:
	movl	-116(%rbp), %eax                # 4-byte Reload
	movl	%eax, -80(%rbp)
	cvtsi2ssl	-80(%rbp), %xmm0
	movss	-76(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-68(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	subss	-64(%rbp), %xmm2
	divss	%xmm2, %xmm1
	subss	%xmm1, %xmm0
	movq	-48(%rbp), %rax
	movss	%xmm0, (%rax)
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movq	-48(%rbp), %rax
	movss	%xmm0, 4(%rax)
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movq	-48(%rbp), %rax
	movss	%xmm0, 8(%rax)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB85_30:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end85:
	.size	RGB_to_HWB, .Lfunc_end85-RGB_to_HWB
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdImageTileGet
	.type	gdImageTileGet,@function
gdImageTileGet:                         # @gdImageTileGet
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movq	-16(%rbp), %rax
	cmpq	$0, 4144(%rax)
	jne	.LBB86_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB86_39
.LBB86_2:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	4144(%rcx), %rcx
	cltd
	idivl	8(%rcx)
	movl	%edx, -28(%rbp)
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	4144(%rcx), %rcx
	cltd
	idivl	12(%rcx)
	movl	%edx, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	4144(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB86_4
# %bb.3:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB86_38
.LBB86_4:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_21
# %bb.5:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_7
# %bb.6:
	movl	-40(%rbp), %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB86_20
.LBB86_7:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_9
# %bb.8:
	movl	-40(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	jmp	.LBB86_10
.LBB86_9:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
.LBB86_10:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	shll	$24, %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_12
# %bb.11:
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB86_13
.LBB86_12:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB86_13:
	movl	-48(%rbp), %eax                 # 4-byte Reload
	movl	-52(%rbp), %ecx                 # 4-byte Reload
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_15
# %bb.14:
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	jmp	.LBB86_16
.LBB86_15:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
.LBB86_16:
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movl	-60(%rbp), %ecx                 # 4-byte Reload
	shll	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_18
# %bb.17:
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	jmp	.LBB86_19
.LBB86_18:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
.LBB86_19:
	movl	-64(%rbp), %eax                 # 4-byte Reload
	movl	-68(%rbp), %ecx                 # 4-byte Reload
	addl	%ecx, %eax
	movl	%eax, -36(%rbp)
.LBB86_20:
	jmp	.LBB86_37
.LBB86_21:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_23
# %bb.22:
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	andl	$16711680, %esi                 # imm = 0xFF0000
	sarl	$16, %esi
	movl	-40(%rbp), %edx
	andl	$65280, %edx                    # imm = 0xFF00
	sarl	$8, %edx
	movl	-40(%rbp), %ecx
	andl	$255, %ecx
	movl	-40(%rbp), %r8d
	andl	$2130706432, %r8d               # imm = 0x7F000000
	sarl	$24, %r8d
	callq	gdImageColorResolveAlpha
	movl	%eax, -36(%rbp)
	jmp	.LBB86_36
.LBB86_23:
	movq	-16(%rbp), %rax
	movq	%rax, -80(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_25
# %bb.24:
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -84(%rbp)                 # 4-byte Spill
	jmp	.LBB86_26
.LBB86_25:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -84(%rbp)                 # 4-byte Spill
.LBB86_26:
	movl	-84(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -88(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_28
# %bb.27:
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
	jmp	.LBB86_29
.LBB86_28:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
.LBB86_29:
	movl	-92(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -96(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_31
# %bb.30:
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	jmp	.LBB86_32
.LBB86_31:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
.LBB86_32:
	movl	-100(%rbp), %eax                # 4-byte Reload
	movl	%eax, -104(%rbp)                # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB86_34
# %bb.33:
	movl	-40(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	jmp	.LBB86_35
.LBB86_34:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
.LBB86_35:
	movl	-104(%rbp), %ecx                # 4-byte Reload
	movl	-96(%rbp), %edx                 # 4-byte Reload
	movl	-88(%rbp), %esi                 # 4-byte Reload
	movq	-80(%rbp), %rdi                 # 8-byte Reload
	movl	-108(%rbp), %r8d                # 4-byte Reload
	callq	gdImageColorResolveAlpha
	movl	%eax, -36(%rbp)
.LBB86_36:
	jmp	.LBB86_37
.LBB86_37:
	jmp	.LBB86_38
.LBB86_38:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB86_39:
	movl	-4(%rbp), %eax
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end86:
	.size	gdImageTileGet, .Lfunc_end86-gdImageTileGet
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function gdImageSetAAPixelColor
	.type	gdImageSetAAPixelColor,@function
gdImageSetAAPixelColor:                 # @gdImageSetAAPixelColor
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7288(%rcx), %eax
	jl	.LBB87_4
# %bb.1:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB87_4
# %bb.2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7284(%rcx), %eax
	jl	.LBB87_4
# %bb.3:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jle	.LBB87_5
.LBB87_4:
	jmp	.LBB87_10
.LBB87_5:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB87_8
# %bb.6:
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7280(%rcx), %eax
	jne	.LBB87_9
# %bb.7:
	cmpl	$0, -24(%rbp)
	je	.LBB87_9
.LBB87_8:
	jmp	.LBB87_10
.LBB87_9:
	movl	-20(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -28(%rbp)
	movl	-20(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -32(%rbp)
	movl	-20(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -36(%rbp)
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -44(%rbp)
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -48(%rbp)
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -52(%rbp)
	movl	-28(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	-28(%rbp), %ecx
	imull	-24(%rbp), %ecx
	movl	-44(%rbp), %edx
	subl	-28(%rbp), %edx
	imull	-24(%rbp), %edx
	sarl	$8, %edx
	addl	%edx, %ecx
	addl	$128, %ecx
	sarl	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -28(%rbp)
	movl	-32(%rbp), %eax
	movl	-48(%rbp), %ecx
	subl	-32(%rbp), %ecx
	imull	-24(%rbp), %ecx
	movl	-48(%rbp), %edx
	subl	-32(%rbp), %edx
	imull	-24(%rbp), %edx
	sarl	$8, %edx
	addl	%edx, %ecx
	addl	$128, %ecx
	sarl	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -32(%rbp)
	movl	-36(%rbp), %eax
	movl	-52(%rbp), %ecx
	subl	-36(%rbp), %ecx
	imull	-24(%rbp), %ecx
	movl	-52(%rbp), %edx
	subl	-36(%rbp), %edx
	imull	-24(%rbp), %edx
	sarl	$8, %edx
	addl	%edx, %ecx
	addl	$128, %ecx
	sarl	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -36(%rbp)
	movl	-28(%rbp), %edx
	shll	$16, %edx
	addl	$0, %edx
	movl	-32(%rbp), %eax
	shll	$8, %eax
	addl	%eax, %edx
	addl	-36(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB87_10:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end87:
	.size	gdImageSetAAPixelColor, .Lfunc_end87-gdImageSetAAPixelColor
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"GD Error: "
	.size	.L.str, 11

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"GD Warning: "
	.size	.L.str.1, 13

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"GD Notice: "
	.size	.L.str.2, 12

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"GD Info: "
	.size	.L.str.3, 10

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"GD Debug: "
	.size	.L.str.4, 11

	.type	gd_error_method,@object         # @gd_error_method
	.data
	.p2align	3, 0x0
gd_error_method:
	.quad	gd_stderr_error
	.size	gd_error_method, 8

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gd_stderr_error
	.addrsig_sym fputs
	.addrsig_sym vfprintf
	.addrsig_sym fflush
	.addrsig_sym gd_error_ex
	.addrsig_sym gdImageCreate
	.addrsig_sym overflow2
	.addrsig_sym gdCalloc
	.addrsig_sym gdMalloc
	.addrsig_sym gdFree
	.addrsig_sym gdImageCreateTrueColor
	.addrsig_sym gdImageColorClosest
	.addrsig_sym gdImageColorClosestAlpha
	.addrsig_sym HWB_Diff
	.addrsig_sym gdImageColorExact
	.addrsig_sym gdImageColorExactAlpha
	.addrsig_sym gdImageColorAllocate
	.addrsig_sym gdImageColorAllocateAlpha
	.addrsig_sym gdImageColorResolve
	.addrsig_sym gdImageColorResolveAlpha
	.addrsig_sym gdImageColorReplace
	.addrsig_sym gdImageSetPixel
	.addrsig_sym gdColorMatch
	.addrsig_sym gdImageColorReplaceArray
	.addrsig_sym qsort
	.addrsig_sym colorCmp
	.addrsig_sym bsearch
	.addrsig_sym gdImageBrushApply
	.addrsig_sym gdImageTileApply
	.addrsig_sym gdAlphaBlend
	.addrsig_sym gdLayerOverlay
	.addrsig_sym gdLayerMultiply
	.addrsig_sym gdImageGetPixel
	.addrsig_sym gdImageGetTrueColorPixel
	.addrsig_sym gdImageLine
	.addrsig_sym gdImageAALine
	.addrsig_sym clip_1d
	.addrsig_sym abs
	.addrsig_sym gdImageVLine
	.addrsig_sym gdImageHLine
	.addrsig_sym cos
	.addrsig_sym atan2
	.addrsig_sym sin
	.addrsig_sym dashedSet
	.addrsig_sym gdImageChar
	.addrsig_sym gdImageCharUp
	.addrsig_sym strlen
	.addrsig_sym strlen16
	.addrsig_sym sqrt
	.addrsig_sym gdImageFilledArc
	.addrsig_sym gdImageFilledPolygon
	.addrsig_sym gdImageFillToBorder
	.addrsig_sym _gdImageFillTiled
	.addrsig_sym gdImageFilledRectangle
	.addrsig_sym gdImageClone
	.addrsig_sym gdImageSetStyle
	.addrsig_sym gdImageCopyResized
	.addrsig_sym gdImagePolygon
	.addrsig_sym gdImageOpenPolygon
	.addrsig_sym gdReallocEx
	.addrsig_sym gdAlphaOverlayColor
	.addrsig_sym RGB_to_HWB
	.addrsig_sym gdImageTileGet
	.addrsig_sym gdImageSetAAPixelColor
	.addrsig_sym stderr
	.addrsig_sym gd_error_method
	.addrsig_sym gdCosT
	.addrsig_sym gdSinT
