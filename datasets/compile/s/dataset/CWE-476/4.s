	.text
	.file	"gd.c"
	.hidden	gd_stderr_error                 # -- Begin function gd_stderr_error
	.globl	gd_stderr_error
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
	.hidden	gd_error                        # -- Begin function gd_error
	.globl	gd_error
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
	movl	$4, %edi
	leaq	-32(%rbp), %rdx
	callq	_gd_error_ex
	addq	$208, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	gd_error, .Lfunc_end1-gd_error
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gd_error_ex
	.type	_gd_error_ex,@function
_gd_error_ex:                           # @_gd_error_ex
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
	cmpq	$0, gd_error_method(%rip)
	je	.LBB2_2
# %bb.1:
	movq	gd_error_method(%rip), %rax
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	callq	*%rax
.LBB2_2:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	_gd_error_ex, .Lfunc_end2-_gd_error_ex
	.cfi_endproc
                                        # -- End function
	.hidden	gd_error_ex                     # -- Begin function gd_error_ex
	.globl	gd_error_ex
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
	je	.LBB3_2
# %bb.1:
	movaps	%xmm0, -176(%rbp)
	movaps	%xmm1, -160(%rbp)
	movaps	%xmm2, -144(%rbp)
	movaps	%xmm3, -128(%rbp)
	movaps	%xmm4, -112(%rbp)
	movaps	%xmm5, -96(%rbp)
	movaps	%xmm6, -80(%rbp)
	movaps	%xmm7, -64(%rbp)
.LBB3_2:
	movq	%r9, -184(%rbp)
	movq	%r8, -192(%rbp)
	movq	%rcx, -200(%rbp)
	movq	%rdx, -208(%rbp)
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	-224(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	16(%rbp), %rax
	movq	%rax, -40(%rbp)
	movl	$48, -44(%rbp)
	movl	$16, -48(%rbp)
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	callq	_gd_error_ex
	addq	$224, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	gd_error_ex, .Lfunc_end3-gd_error_ex
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
.Lfunc_end4:
	.size	gdSetErrorMethod, .Lfunc_end4-gdSetErrorMethod
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
.Lfunc_end5:
	.size	gdClearErrorMethod, .Lfunc_end5-gdClearErrorMethod
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
	movl	-12(%rbp), %edi
	movl	-16(%rbp), %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB6_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB6_25
.LBB6_2:
	movl	-16(%rbp), %esi
	movl	$8, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB6_4
# %bb.3:
	movq	$0, -8(%rbp)
	jmp	.LBB6_25
.LBB6_4:
	movl	-12(%rbp), %esi
	movl	$1, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB6_6
# %bb.5:
	movq	$0, -8(%rbp)
	jmp	.LBB6_25
.LBB6_6:
	movl	$1, %edi
	movl	$7336, %esi                     # imm = 0x1CA8
	callq	gdCalloc@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB6_8
# %bb.7:
	movq	$0, -8(%rbp)
	jmp	.LBB6_25
.LBB6_8:
	movslq	-16(%rbp), %rdi
	shlq	$3, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB6_10
# %bb.9:
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB6_25
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
	jge	.LBB6_20
# %bb.12:                               #   in Loop: Header=BB6_11 Depth=1
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
	jne	.LBB6_18
# %bb.13:
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
.LBB6_14:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -20(%rbp)
	jl	.LBB6_17
# %bb.15:                               #   in Loop: Header=BB6_14 Depth=1
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movslq	-20(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.16:                               #   in Loop: Header=BB6_14 Depth=1
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB6_14
.LBB6_17:
	movq	-32(%rbp), %rax
	movq	(%rax), %rdi
	callq	gdFree@PLT
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB6_25
.LBB6_18:                               #   in Loop: Header=BB6_11 Depth=1
	jmp	.LBB6_19
.LBB6_19:                               #   in Loop: Header=BB6_11 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB6_11
.LBB6_20:
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
.LBB6_21:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -20(%rbp)                 # imm = 0x100
	jge	.LBB6_24
# %bb.22:                               #   in Loop: Header=BB6_21 Depth=1
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$1, 3092(%rax,%rcx,4)
# %bb.23:                               #   in Loop: Header=BB6_21 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB6_21
.LBB6_24:
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
.LBB6_25:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	gdImageCreate, .Lfunc_end6-gdImageCreate
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
	je	.LBB7_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB7_20
.LBB7_2:
	movl	-16(%rbp), %esi
	movl	$8, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB7_4
# %bb.3:
	movq	$0, -8(%rbp)
	jmp	.LBB7_20
.LBB7_4:
	movl	-12(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB7_6
# %bb.5:
	movq	$0, -8(%rbp)
	jmp	.LBB7_20
.LBB7_6:
	movl	$7336, %edi                     # imm = 0x1CA8
	callq	gdMalloc@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB7_8
# %bb.7:
	movq	$0, -8(%rbp)
	jmp	.LBB7_20
.LBB7_8:
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
	jne	.LBB7_10
# %bb.9:
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB7_20
.LBB7_10:
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
.LBB7_11:                               # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB7_19
# %bb.12:                               #   in Loop: Header=BB7_11 Depth=1
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
	jne	.LBB7_17
# %bb.13:
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
.LBB7_14:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -20(%rbp)
	jl	.LBB7_16
# %bb.15:                               #   in Loop: Header=BB7_14 Depth=1
	movq	-32(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-20(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
	movl	-20(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB7_14
.LBB7_16:
	movq	-32(%rbp), %rax
	movq	7256(%rax), %rdi
	callq	gdFree@PLT
	movq	-32(%rbp), %rdi
	callq	gdFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB7_20
.LBB7_17:                               #   in Loop: Header=BB7_11 Depth=1
	jmp	.LBB7_18
.LBB7_18:                               #   in Loop: Header=BB7_11 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB7_11
.LBB7_19:
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
.LBB7_20:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	gdImageCreateTrueColor, .Lfunc_end7-gdImageCreateTrueColor
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
	je	.LBB8_6
# %bb.1:
	movl	$0, -12(%rbp)
.LBB8_2:                                # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB8_5
# %bb.3:                                #   in Loop: Header=BB8_2 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-12(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.4:                                #   in Loop: Header=BB8_2 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB8_2
.LBB8_5:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	gdFree@PLT
.LBB8_6:
	movq	-8(%rbp), %rax
	cmpq	$0, 7256(%rax)
	je	.LBB8_12
# %bb.7:
	movl	$0, -12(%rbp)
.LBB8_8:                                # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB8_11
# %bb.9:                                #   in Loop: Header=BB8_8 Depth=1
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-12(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.10:                               #   in Loop: Header=BB8_8 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB8_8
.LBB8_11:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rdi
	callq	gdFree@PLT
.LBB8_12:
	movq	-8(%rbp), %rax
	cmpq	$0, 4120(%rax)
	je	.LBB8_14
# %bb.13:
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rdi
	callq	gdFree@PLT
.LBB8_14:
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	je	.LBB8_16
# %bb.15:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rdi
	callq	gdFree@PLT
.LBB8_16:
	movq	-8(%rbp), %rdi
	callq	gdFree@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	gdImageDestroy, .Lfunc_end8-gdImageDestroy
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
	callq	gdImageColorClosestAlpha@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	gdImageColorClosest, .Lfunc_end9-gdImageColorClosest
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
	je	.LBB10_2
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
	jmp	.LBB10_12
.LBB10_2:
	movl	$0, -36(%rbp)
.LBB10_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB10_11
# %bb.4:                                #   in Loop: Header=BB10_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB10_6
# %bb.5:                                #   in Loop: Header=BB10_3 Depth=1
	jmp	.LBB10_10
.LBB10_6:                               #   in Loop: Header=BB10_3 Depth=1
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
	jne	.LBB10_8
# %bb.7:                                #   in Loop: Header=BB10_3 Depth=1
	movq	-96(%rbp), %rax
	cmpq	-88(%rbp), %rax
	jge	.LBB10_9
.LBB10_8:                               #   in Loop: Header=BB10_3 Depth=1
	movq	-96(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	$0, -80(%rbp)
.LBB10_9:                               #   in Loop: Header=BB10_3 Depth=1
	jmp	.LBB10_10
.LBB10_10:                              #   in Loop: Header=BB10_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB10_3
.LBB10_11:
	movl	-76(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB10_12:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	gdImageColorClosestAlpha, .Lfunc_end10-gdImageColorClosestAlpha
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
	je	.LBB11_2
# %bb.1:
	movl	-20(%rbp), %eax
	shll	$16, %eax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	%ecx, %eax
	addl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB11_12
.LBB11_2:
	movl	$0, -32(%rbp)
.LBB11_3:                               # =>This Inner Loop Header: Depth=1
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB11_11
# %bb.4:                                #   in Loop: Header=BB11_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB11_6
# %bb.5:                                #   in Loop: Header=BB11_3 Depth=1
	jmp	.LBB11_10
.LBB11_6:                               #   in Loop: Header=BB11_3 Depth=1
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
	jne	.LBB11_8
# %bb.7:                                #   in Loop: Header=BB11_3 Depth=1
	movss	-48(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-44(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB11_9
.LBB11_8:                               #   in Loop: Header=BB11_3 Depth=1
	movss	-48(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -44(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	$0, -40(%rbp)
.LBB11_9:                               #   in Loop: Header=BB11_3 Depth=1
	jmp	.LBB11_10
.LBB11_10:                              #   in Loop: Header=BB11_3 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB11_3
.LBB11_11:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB11_12:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	gdImageColorClosestHWB, .Lfunc_end11-gdImageColorClosestHWB
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function HWB_Diff
.LCPI12_0:
	.long	0xbf800000                      # float -1
.LCPI12_2:
	.long	0x40400000                      # float 3
.LCPI12_4:
	.long	0x40c00000                      # float 6
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI12_1:
	.quad	0x406fe00000000000              # double 255
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI12_3:
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
	movsd	.LCPI12_1(%rip), %xmm1          # xmm1 = mem[0],zero
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
	movss	.LCPI12_0(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB12_1
	jp	.LBB12_1
	jmp	.LBB12_2
.LBB12_1:
	movss	-88(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI12_0(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB12_3
	jp	.LBB12_3
.LBB12_2:
	xorps	%xmm0, %xmm0
	movss	%xmm0, -92(%rbp)
	jmp	.LBB12_6
.LBB12_3:
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-88(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movaps	.LCPI12_3(%rip), %xmm1          # xmm1 = [NaN,NaN]
	pand	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -92(%rbp)
	movss	-92(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI12_2(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB12_5
# %bb.4:
	movss	.LCPI12_4(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	subss	-92(%rbp), %xmm0
	movss	%xmm0, -92(%rbp)
.LBB12_5:
	jmp	.LBB12_6
.LBB12_6:
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
.Lfunc_end12:
	.size	HWB_Diff, .Lfunc_end12-HWB_Diff
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
	callq	gdImageColorExactAlpha@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	gdImageColorExact, .Lfunc_end13-gdImageColorExact
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
	je	.LBB14_2
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
	jmp	.LBB14_14
.LBB14_2:
	movl	$0, -36(%rbp)
.LBB14_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB14_13
# %bb.4:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB14_6
# %bb.5:                                #   in Loop: Header=BB14_3 Depth=1
	jmp	.LBB14_12
.LBB14_6:                               #   in Loop: Header=BB14_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB14_11
# %bb.7:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB14_11
# %bb.8:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	cmpl	-28(%rbp), %eax
	jne	.LBB14_11
# %bb.9:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB14_11
# %bb.10:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB14_14
.LBB14_11:                              #   in Loop: Header=BB14_3 Depth=1
	jmp	.LBB14_12
.LBB14_12:                              #   in Loop: Header=BB14_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB14_3
.LBB14_13:
	movl	$-1, -4(%rbp)
.LBB14_14:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end14:
	.size	gdImageColorExactAlpha, .Lfunc_end14-gdImageColorExactAlpha
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
	callq	gdImageColorAllocateAlpha@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	gdImageColorAllocate, .Lfunc_end15-gdImageColorAllocate
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
	je	.LBB16_2
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
	jmp	.LBB16_13
.LBB16_2:
	movl	$0, -36(%rbp)
.LBB16_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB16_8
# %bb.4:                                #   in Loop: Header=BB16_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB16_6
# %bb.5:
	movl	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB16_8
.LBB16_6:                               #   in Loop: Header=BB16_3 Depth=1
	jmp	.LBB16_7
.LBB16_7:                               #   in Loop: Header=BB16_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB16_3
.LBB16_8:
	cmpl	$-1, -40(%rbp)
	jne	.LBB16_12
# %bb.9:
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -40(%rbp)
	cmpl	$256, -40(%rbp)                 # imm = 0x100
	jne	.LBB16_11
# %bb.10:
	movl	$-1, -4(%rbp)
	jmp	.LBB16_13
.LBB16_11:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, 16(%rax)
.LBB16_12:
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
.LBB16_13:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end16:
	.size	gdImageColorAllocateAlpha, .Lfunc_end16-gdImageColorAllocateAlpha
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
	callq	gdImageColorResolveAlpha@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	gdImageColorResolve, .Lfunc_end17-gdImageColorResolve
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
	je	.LBB18_2
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
	jmp	.LBB18_19
.LBB18_2:
	movl	$0, -36(%rbp)
.LBB18_3:                               # =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB18_14
# %bb.4:                                #   in Loop: Header=BB18_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	je	.LBB18_6
# %bb.5:                                #   in Loop: Header=BB18_3 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB18_13
.LBB18_6:                               #   in Loop: Header=BB18_3 Depth=1
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB18_8
# %bb.7:                                #   in Loop: Header=BB18_3 Depth=1
	jmp	.LBB18_13
.LBB18_8:                               #   in Loop: Header=BB18_3 Depth=1
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
	jge	.LBB18_12
# %bb.9:                                #   in Loop: Header=BB18_3 Depth=1
	cmpq	$0, -88(%rbp)
	jne	.LBB18_11
# %bb.10:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB18_19
.LBB18_11:                              #   in Loop: Header=BB18_3 Depth=1
	movq	-88(%rbp), %rax
	movq	%rax, -96(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB18_12:                              #   in Loop: Header=BB18_3 Depth=1
	jmp	.LBB18_13
.LBB18_13:                              #   in Loop: Header=BB18_3 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB18_3
.LBB18_14:
	cmpl	$-1, -44(%rbp)
	jne	.LBB18_18
# %bb.15:
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -44(%rbp)
	cmpl	$256, -44(%rbp)                 # imm = 0x100
	jne	.LBB18_17
# %bb.16:
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB18_19
.LBB18_17:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, 16(%rax)
.LBB18_18:
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
.LBB18_19:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end18:
	.size	gdImageColorResolveAlpha, .Lfunc_end18-gdImageColorResolveAlpha
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
	jne	.LBB19_3
# %bb.1:
	cmpl	$256, -12(%rbp)                 # imm = 0x100
	jge	.LBB19_3
# %bb.2:
	cmpl	$0, -12(%rbp)
	jge	.LBB19_4
.LBB19_3:
	jmp	.LBB19_5
.LBB19_4:
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	$1, 3092(%rax,%rcx,4)
.LBB19_5:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	gdImageColorDeallocate, .Lfunc_end19-gdImageColorDeallocate
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
	cmpl	$0, -12(%rbp)
	jge	.LBB20_2
# %bb.1:
	jmp	.LBB20_9
.LBB20_2:
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB20_8
# %bb.3:
	cmpl	$256, -12(%rbp)                 # imm = 0x100
	jl	.LBB20_5
# %bb.4:
	jmp	.LBB20_9
.LBB20_5:
	movq	-8(%rbp), %rax
	cmpl	$-1, 4116(%rax)
	je	.LBB20_7
# %bb.6:
	movq	-8(%rbp), %rax
	movq	-8(%rbp), %rcx
	movslq	4116(%rcx), %rcx
	movl	$0, 6224(%rax,%rcx,4)
.LBB20_7:
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	$127, 6224(%rax,%rcx,4)
.LBB20_8:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 4116(%rax)
.LBB20_9:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end20:
	.size	gdImageColorTransparent, .Lfunc_end20-gdImageColorTransparent
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
	je	.LBB21_2
# %bb.1:
	jmp	.LBB21_27
.LBB21_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB21_4
# %bb.3:
	jmp	.LBB21_27
.LBB21_4:
	movl	$0, -20(%rbp)
.LBB21_5:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -20(%rbp)                 # imm = 0x100
	jge	.LBB21_8
# %bb.6:                                #   in Loop: Header=BB21_5 Depth=1
	movslq	-20(%rbp), %rax
	movl	$-1, -1056(%rbp,%rax,4)
# %bb.7:                                #   in Loop: Header=BB21_5 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB21_5
.LBB21_8:
	movl	$0, -28(%rbp)
.LBB21_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_11 Depth 2
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB21_18
# %bb.10:                               #   in Loop: Header=BB21_9 Depth=1
	movl	$0, -24(%rbp)
.LBB21_11:                              #   Parent Loop BB21_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB21_16
# %bb.12:                               #   in Loop: Header=BB21_11 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-24(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -32(%rbp)
	movslq	-32(%rbp), %rax
	cmpl	$-1, -1056(%rbp,%rax,4)
	jne	.LBB21_14
# %bb.13:                               #   in Loop: Header=BB21_11 Depth=2
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
	callq	gdImageColorClosestAlpha@PLT
	movl	%eax, %ecx
	movslq	-32(%rbp), %rax
	movl	%ecx, -1056(%rbp,%rax,4)
.LBB21_14:                              #   in Loop: Header=BB21_11 Depth=2
	movslq	-32(%rbp), %rax
	movl	-1056(%rbp,%rax,4), %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-24(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.15:                               #   in Loop: Header=BB21_11 Depth=2
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB21_11
.LBB21_16:                              #   in Loop: Header=BB21_9 Depth=1
	jmp	.LBB21_17
.LBB21_17:                              #   in Loop: Header=BB21_9 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB21_9
.LBB21_18:
	movl	$0, -20(%rbp)
.LBB21_19:                              # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB21_22
# %bb.20:                               #   in Loop: Header=BB21_19 Depth=1
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
# %bb.21:                               #   in Loop: Header=BB21_19 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB21_19
.LBB21_22:
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -20(%rbp)
.LBB21_23:                              # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB21_26
# %bb.24:                               #   in Loop: Header=BB21_23 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$1, 3092(%rax,%rcx,4)
# %bb.25:                               #   in Loop: Header=BB21_23 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB21_23
.LBB21_26:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 16(%rax)
.LBB21_27:
	addq	$1056, %rsp                     # imm = 0x420
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end21:
	.size	gdImagePaletteCopy, .Lfunc_end21-gdImagePaletteCopy
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
	jne	.LBB22_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB22_30
.LBB22_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB22_16
# %bb.3:
	jmp	.LBB22_4
.LBB22_4:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB22_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB22_7 Depth 2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB22_14
# %bb.6:                                #   in Loop: Header=BB22_5 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -28(%rbp)
.LBB22_7:                               #   Parent Loop BB22_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB22_12
# %bb.8:                                #   in Loop: Header=BB22_7 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-32(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB22_10
# %bb.9:                                #   in Loop: Header=BB22_7 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.LBB22_10:                              #   in Loop: Header=BB22_7 Depth=2
	jmp	.LBB22_11
.LBB22_11:                              #   in Loop: Header=BB22_7 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB22_7
.LBB22_12:                              #   in Loop: Header=BB22_5 Depth=1
	jmp	.LBB22_13
.LBB22_13:                              #   in Loop: Header=BB22_5 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB22_5
.LBB22_14:
	jmp	.LBB22_15
.LBB22_15:
	jmp	.LBB22_29
.LBB22_16:
	jmp	.LBB22_17
.LBB22_17:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB22_18:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB22_20 Depth 2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB22_27
# %bb.19:                               #   in Loop: Header=BB22_18 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -28(%rbp)
.LBB22_20:                              #   Parent Loop BB22_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB22_25
# %bb.21:                               #   in Loop: Header=BB22_20 Depth=2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-32(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-28(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB22_23
# %bb.22:                               #   in Loop: Header=BB22_20 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.LBB22_23:                              #   in Loop: Header=BB22_20 Depth=2
	jmp	.LBB22_24
.LBB22_24:                              #   in Loop: Header=BB22_20 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB22_20
.LBB22_25:                              #   in Loop: Header=BB22_18 Depth=1
	jmp	.LBB22_26
.LBB22_26:                              #   in Loop: Header=BB22_18 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB22_18
.LBB22_27:
	jmp	.LBB22_28
.LBB22_28:
	jmp	.LBB22_29
.LBB22_29:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB22_30:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end22:
	.size	gdImageColorReplace, .Lfunc_end22-gdImageColorReplace
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
	ja	.LBB23_16
# %bb.32:
	movq	-32(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI23_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB23_1:
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	jne	.LBB23_3
# %bb.2:
	jmp	.LBB23_31
.LBB23_3:
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
	je	.LBB23_6
# %bb.5:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
.LBB23_6:
	movq	-8(%rbp), %rax
	movl	6204(%rax), %eax
	movq	-8(%rbp), %rcx
	cltd
	idivl	6200(%rcx)
	movq	-8(%rbp), %rax
	movl	%edx, 6204(%rax)
	jmp	.LBB23_31
.LBB23_7:
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	jne	.LBB23_9
# %bb.8:
	jmp	.LBB23_31
.LBB23_9:
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
	je	.LBB23_12
# %bb.10:
	cmpl	$0, -24(%rbp)
	je	.LBB23_12
# %bb.11:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	$4294967293, %ecx               # imm = 0xFFFFFFFD
	callq	gdImageSetPixel@PLT
.LBB23_12:
	movq	-8(%rbp), %rax
	movl	6204(%rax), %eax
	movq	-8(%rbp), %rcx
	cltd
	idivl	6200(%rcx)
	movq	-8(%rbp), %rax
	movl	%edx, 6204(%rax)
	jmp	.LBB23_31
.LBB23_13:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageBrushApply
	jmp	.LBB23_31
.LBB23_14:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageTileApply
	jmp	.LBB23_31
.LBB23_15:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	7276(%rax), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB23_31
.LBB23_16:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7288(%rcx), %eax
	jl	.LBB23_30
# %bb.17:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB23_30
# %bb.18:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7284(%rcx), %eax
	jl	.LBB23_30
# %bb.19:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB23_30
# %bb.20:
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB23_28
# %bb.21:
	movq	-8(%rbp), %rax
	movl	7264(%rax), %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	subq	$4, %rax
	ja	.LBB23_22
# %bb.33:
	movq	-40(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI23_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB23_22:
	jmp	.LBB23_23
.LBB23_23:
	movl	-20(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB23_27
.LBB23_24:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movl	-20(%rbp), %esi
	callq	gdAlphaBlend@PLT
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB23_27
.LBB23_25:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movl	-20(%rbp), %esi
	callq	gdLayerOverlay@PLT
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
	jmp	.LBB23_27
.LBB23_26:
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %edi
	movl	-20(%rbp), %esi
	callq	gdLayerMultiply@PLT
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB23_27:
	jmp	.LBB23_29
.LBB23_28:
	movl	-20(%rbp), %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
.LBB23_29:
	jmp	.LBB23_30
.LBB23_30:
	jmp	.LBB23_31
.LBB23_31:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end23:
	.size	gdImageSetPixel, .Lfunc_end23-gdImageSetPixel
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI23_0:
	.long	.LBB23_15-.LJTI23_0
	.long	.LBB23_16-.LJTI23_0
	.long	.LBB23_14-.LJTI23_0
	.long	.LBB23_7-.LJTI23_0
	.long	.LBB23_13-.LJTI23_0
	.long	.LBB23_1-.LJTI23_0
.LJTI23_1:
	.long	.LBB23_23-.LJTI23_1
	.long	.LBB23_24-.LJTI23_1
	.long	.LBB23_24-.LJTI23_1
	.long	.LBB23_25-.LJTI23_1
	.long	.LBB23_26-.LJTI23_1
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
	jne	.LBB24_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB24_30
.LBB24_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB24_16
# %bb.3:
	jmp	.LBB24_4
.LBB24_4:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -36(%rbp)
.LBB24_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_7 Depth 2
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB24_14
# %bb.6:                                #   in Loop: Header=BB24_5 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB24_7:                               #   Parent Loop BB24_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB24_12
# %bb.8:                                #   in Loop: Header=BB24_7 Depth=2
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
	je	.LBB24_10
# %bb.9:                                #   in Loop: Header=BB24_7 Depth=2
	movq	-16(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB24_10:                              #   in Loop: Header=BB24_7 Depth=2
	jmp	.LBB24_11
.LBB24_11:                              #   in Loop: Header=BB24_7 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB24_7
.LBB24_12:                              #   in Loop: Header=BB24_5 Depth=1
	jmp	.LBB24_13
.LBB24_13:                              #   in Loop: Header=BB24_5 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB24_5
.LBB24_14:
	jmp	.LBB24_15
.LBB24_15:
	jmp	.LBB24_29
.LBB24_16:
	jmp	.LBB24_17
.LBB24_17:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -36(%rbp)
.LBB24_18:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_20 Depth 2
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB24_27
# %bb.19:                               #   in Loop: Header=BB24_18 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -32(%rbp)
.LBB24_20:                              #   Parent Loop BB24_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB24_25
# %bb.21:                               #   in Loop: Header=BB24_20 Depth=2
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
	je	.LBB24_23
# %bb.22:                               #   in Loop: Header=BB24_20 Depth=2
	movq	-16(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB24_23:                              #   in Loop: Header=BB24_20 Depth=2
	jmp	.LBB24_24
.LBB24_24:                              #   in Loop: Header=BB24_20 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB24_20
.LBB24_25:                              #   in Loop: Header=BB24_18 Depth=1
	jmp	.LBB24_26
.LBB24_26:                              #   in Loop: Header=BB24_18 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB24_18
.LBB24_27:
	jmp	.LBB24_28
.LBB24_28:
	jmp	.LBB24_29
.LBB24_29:
	movl	-40(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB24_30:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end24:
	.size	gdImageColorReplaceThreshold, .Lfunc_end24-gdImageColorReplaceThreshold
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
	jle	.LBB25_2
# %bb.1:
	movq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.LBB25_3
.LBB25_2:
	movl	$0, -4(%rbp)
	jmp	.LBB25_41
.LBB25_3:
	cmpl	$1, -20(%rbp)
	jne	.LBB25_5
# %bb.4:
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rax
	movl	(%rax), %esi
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	callq	gdImageColorReplace@PLT
	movl	%eax, -4(%rbp)
	jmp	.LBB25_41
.LBB25_5:
	movl	-20(%rbp), %edi
	movl	$8, %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB25_7
# %bb.6:
	movl	$-1, -4(%rbp)
	jmp	.LBB25_41
.LBB25_7:
	movslq	-20(%rbp), %rdi
	shlq	$3, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB25_9
# %bb.8:
	movl	$-1, -4(%rbp)
	jmp	.LBB25_41
.LBB25_9:
	movl	$0, -76(%rbp)
.LBB25_10:                              # =>This Inner Loop Header: Depth=1
	movl	-76(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB25_13
# %bb.11:                               #   in Loop: Header=BB25_10 Depth=1
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
# %bb.12:                               #   in Loop: Header=BB25_10 Depth=1
	movl	-76(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB25_10
.LBB25_13:
	movq	-72(%rbp), %rdi
	movslq	-20(%rbp), %rsi
	movl	$8, %edx
	leaq	colorCmp(%rip), %rcx
	callq	qsort@PLT
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB25_27
# %bb.14:
	jmp	.LBB25_15
.LBB25_15:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -48(%rbp)
.LBB25_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB25_18 Depth 2
	movl	-48(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB25_25
# %bb.17:                               #   in Loop: Header=BB25_16 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB25_18:                              #   Parent Loop BB25_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB25_23
# %bb.19:                               #   in Loop: Header=BB25_18 Depth=2
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
	je	.LBB25_21
# %bb.20:                               #   in Loop: Header=BB25_18 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	4(%rax), %ecx
	callq	gdImageSetPixel@PLT
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
.LBB25_21:                              #   in Loop: Header=BB25_18 Depth=2
	jmp	.LBB25_22
.LBB25_22:                              #   in Loop: Header=BB25_18 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB25_18
.LBB25_23:                              #   in Loop: Header=BB25_16 Depth=1
	jmp	.LBB25_24
.LBB25_24:                              #   in Loop: Header=BB25_16 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB25_16
.LBB25_25:
	jmp	.LBB25_26
.LBB25_26:
	jmp	.LBB25_40
.LBB25_27:
	jmp	.LBB25_28
.LBB25_28:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -48(%rbp)
.LBB25_29:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB25_31 Depth 2
	movl	-48(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB25_38
# %bb.30:                               #   in Loop: Header=BB25_29 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB25_31:                              #   Parent Loop BB25_29 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB25_36
# %bb.32:                               #   in Loop: Header=BB25_31 Depth=2
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
	je	.LBB25_34
# %bb.33:                               #   in Loop: Header=BB25_31 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	4(%rax), %ecx
	callq	gdImageSetPixel@PLT
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
.LBB25_34:                              #   in Loop: Header=BB25_31 Depth=2
	jmp	.LBB25_35
.LBB25_35:                              #   in Loop: Header=BB25_31 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB25_31
.LBB25_36:                              #   in Loop: Header=BB25_29 Depth=1
	jmp	.LBB25_37
.LBB25_37:                              #   in Loop: Header=BB25_29 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB25_29
.LBB25_38:
	jmp	.LBB25_39
.LBB25_39:
	jmp	.LBB25_40
.LBB25_40:
	movq	-72(%rbp), %rdi
	callq	gdFree@PLT
	movl	-80(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB25_41:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end25:
	.size	gdImageColorReplaceArray, .Lfunc_end25-gdImageColorReplaceArray
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
.Lfunc_end26:
	.size	colorCmp, .Lfunc_end26-colorCmp
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
	jne	.LBB27_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB27_30
.LBB27_2:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB27_14
# %bb.3:
	movq	-16(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB27_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB27_6 Depth 2
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB27_13
# %bb.5:                                #   in Loop: Header=BB27_4 Depth=1
	movq	-16(%rbp), %rax
	movl	7284(%rax), %eax
	movl	%eax, -40(%rbp)
.LBB27_6:                               #   Parent Loop BB27_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB27_11
# %bb.7:                                #   in Loop: Header=BB27_6 Depth=2
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
	je	.LBB27_9
# %bb.8:                                #   in Loop: Header=BB27_6 Depth=2
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-32(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.LBB27_9:                               #   in Loop: Header=BB27_6 Depth=2
	jmp	.LBB27_10
.LBB27_10:                              #   in Loop: Header=BB27_6 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB27_6
.LBB27_11:                              #   in Loop: Header=BB27_4 Depth=1
	jmp	.LBB27_12
.LBB27_12:                              #   in Loop: Header=BB27_4 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB27_4
.LBB27_13:
	jmp	.LBB27_29
.LBB27_14:
	movl	$0, -72(%rbp)
	movq	-16(%rbp), %rax
	movslq	16(%rax), %rdi
	movl	$4, %esi
	callq	gdCalloc@PLT
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB27_16
# %bb.15:
	movl	$-1, -4(%rbp)
	jmp	.LBB27_30
.LBB27_16:
	movl	$0, -28(%rbp)
.LBB27_17:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB27_22
# %bb.18:                               #   in Loop: Header=BB27_17 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	cmpl	$0, 3092(%rax,%rcx,4)
	jne	.LBB27_20
# %bb.19:                               #   in Loop: Header=BB27_17 Depth=1
	movl	-28(%rbp), %edx
	movq	-56(%rbp), %rax
	movl	-72(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -72(%rbp)
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB27_20:                              #   in Loop: Header=BB27_17 Depth=1
	jmp	.LBB27_21
.LBB27_21:                              #   in Loop: Header=BB27_17 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB27_17
.LBB27_22:
	movslq	-72(%rbp), %rdi
	movl	$4, %esi
	callq	gdCalloc@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB27_24
# %bb.23:
	movq	-56(%rbp), %rdi
	callq	gdFree@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB27_30
.LBB27_24:
	movl	$0, -68(%rbp)
.LBB27_25:                              # =>This Inner Loop Header: Depth=1
	movl	-68(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jge	.LBB27_28
# %bb.26:                               #   in Loop: Header=BB27_25 Depth=1
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
# %bb.27:                               #   in Loop: Header=BB27_25 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB27_25
.LBB27_28:
	movq	-16(%rbp), %rdi
	movl	-68(%rbp), %esi
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rcx
	callq	gdImageColorReplaceArray@PLT
	movl	%eax, -36(%rbp)
	movq	-64(%rbp), %rdi
	callq	gdFree@PLT
	movq	-56(%rbp), %rdi
	callq	gdFree@PLT
.LBB27_29:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB27_30:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end27:
	.size	gdImageColorReplaceCallback, .Lfunc_end27-gdImageColorReplaceCallback
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
	jne	.LBB28_2
# %bb.1:
	jmp	.LBB28_41
.LBB28_2:
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
	je	.LBB28_27
# %bb.3:
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB28_15
# %bb.4:
	movl	-40(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB28_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB28_7 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB28_14
# %bb.6:                                #   in Loop: Header=BB28_5 Depth=1
	movl	$0, -52(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB28_7:                               #   Parent Loop BB28_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB28_12
# %bb.8:                                #   in Loop: Header=BB28_7 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetTrueColorPixel@PLT
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB28_10
# %bb.9:                                #   in Loop: Header=BB28_7 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-60(%rbp), %ecx
	callq	gdImageSetPixel@PLT
.LBB28_10:                              #   in Loop: Header=BB28_7 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.11:                               #   in Loop: Header=BB28_7 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB28_7
.LBB28_12:                              #   in Loop: Header=BB28_5 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.13:                               #   in Loop: Header=BB28_5 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB28_5
.LBB28_14:
	jmp	.LBB28_26
.LBB28_15:
	movl	-40(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB28_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB28_18 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB28_25
# %bb.17:                               #   in Loop: Header=BB28_16 Depth=1
	movl	$0, -52(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB28_18:                              #   Parent Loop BB28_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB28_23
# %bb.19:                               #   in Loop: Header=BB28_18 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -64(%rbp)
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetTrueColorPixel@PLT
	movl	%eax, -68(%rbp)
	movl	-64(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB28_21
# %bb.20:                               #   in Loop: Header=BB28_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageSetPixel@PLT
.LBB28_21:                              #   in Loop: Header=BB28_18 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.22:                               #   in Loop: Header=BB28_18 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB28_18
.LBB28_23:                              #   in Loop: Header=BB28_16 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.24:                               #   in Loop: Header=BB28_16 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB28_16
.LBB28_25:
	jmp	.LBB28_26
.LBB28_26:
	jmp	.LBB28_41
.LBB28_27:
	movl	-40(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB28_28:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB28_30 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB28_40
# %bb.29:                               #   in Loop: Header=BB28_28 Depth=1
	movl	$0, -52(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB28_30:                              #   Parent Loop BB28_28 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB28_38
# %bb.31:                               #   in Loop: Header=BB28_30 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -72(%rbp)
	movl	-72(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	4136(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB28_36
# %bb.32:                               #   in Loop: Header=BB28_30 Depth=2
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB28_34
# %bb.33:                               #   in Loop: Header=BB28_30 Depth=2
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
	callq	gdImageColorResolveAlpha@PLT
	movq	-88(%rbp), %rdi                 # 8-byte Reload
	movl	-80(%rbp), %esi                 # 4-byte Reload
	movl	-76(%rbp), %edx                 # 4-byte Reload
	movl	%eax, %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB28_35
.LBB28_34:                              #   in Loop: Header=BB28_30 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	4152(%rax,%rcx,4), %ecx
	callq	gdImageSetPixel@PLT
.LBB28_35:                              #   in Loop: Header=BB28_30 Depth=2
	jmp	.LBB28_36
.LBB28_36:                              #   in Loop: Header=BB28_30 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.37:                               #   in Loop: Header=BB28_30 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB28_30
.LBB28_38:                              #   in Loop: Header=BB28_28 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.39:                               #   in Loop: Header=BB28_28 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB28_28
.LBB28_40:
	jmp	.LBB28_41
.LBB28_41:
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end28:
	.size	gdImageBrushApply, .Lfunc_end28-gdImageBrushApply
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
	jne	.LBB29_2
# %bb.1:
	jmp	.LBB29_14
.LBB29_2:
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
	je	.LBB29_8
# %bb.3:
	movq	-24(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB29_7
# %bb.4:
	movq	-24(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB29_6
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
.LBB29_6:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-36(%rbp), %ecx
	callq	gdImageSetPixel@PLT
.LBB29_7:
	jmp	.LBB29_14
.LBB29_8:
	movq	-24(%rbp), %rdi
	movl	-28(%rbp), %esi
	movl	-32(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB29_13
# %bb.9:
	movq	-24(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB29_11
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
	callq	gdImageColorResolveAlpha@PLT
	movq	-56(%rbp), %rdi                 # 8-byte Reload
	movl	-44(%rbp), %esi                 # 4-byte Reload
	movl	-40(%rbp), %edx                 # 4-byte Reload
	movl	%eax, %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB29_12
.LBB29_11:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	5176(%rax,%rcx,4), %ecx
	callq	gdImageSetPixel@PLT
.LBB29_12:
	jmp	.LBB29_13
.LBB29_13:
	jmp	.LBB29_14
.LBB29_14:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end29:
	.size	gdImageTileApply, .Lfunc_end29-gdImageTileApply
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
	jne	.LBB30_2
# %bb.1:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB30_7
.LBB30_2:
	movl	-8(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -20(%rbp)
	cmpl	$127, -16(%rbp)
	jne	.LBB30_4
# %bb.3:
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB30_7
.LBB30_4:
	cmpl	$127, -20(%rbp)
	jne	.LBB30_6
# %bb.5:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB30_7
.LBB30_6:
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
.LBB30_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end30:
	.size	gdAlphaBlend, .Lfunc_end30-gdAlphaBlend
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
.Lfunc_end31:
	.size	gdLayerOverlay, .Lfunc_end31-gdLayerOverlay
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
.Lfunc_end32:
	.size	gdLayerMultiply, .Lfunc_end32-gdLayerMultiply
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
	jl	.LBB33_7
# %bb.1:
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB33_7
# %bb.2:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7284(%rcx), %eax
	jl	.LBB33_7
# %bb.3:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jg	.LBB33_7
# %bb.4:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB33_6
# %bb.5:
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB33_8
.LBB33_6:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB33_8
.LBB33_7:
	movl	$0, -4(%rbp)
.LBB33_8:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end33:
	.size	gdImageGetPixel, .Lfunc_end33-gdImageGetPixel
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
	callq	gdImageGetPixel@PLT
	movl	%eax, -28(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB34_5
# %bb.1:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-28(%rbp), %eax
	jne	.LBB34_3
# %bb.2:
	movl	$127, %eax
	movl	%eax, -32(%rbp)                 # 4-byte Spill
	jmp	.LBB34_4
.LBB34_3:
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -32(%rbp)                 # 4-byte Spill
.LBB34_4:
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
	jmp	.LBB34_6
.LBB34_5:
	movl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB34_6:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end34:
	.size	gdImageGetTrueColorPixel, .Lfunc_end34-gdImageGetTrueColorPixel
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
.Lfunc_end35:
	.size	gdImageAABlend, .Lfunc_end35-gdImageAABlend
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
	jne	.LBB36_2
# %bb.1:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movq	-8(%rbp), %rax
	movl	7276(%rax), %r9d
	callq	gdImageAALine
	jmp	.LBB36_84
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
	jmp	.LBB36_84
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
	jmp	.LBB36_84
.LBB36_6:
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
	jne	.LBB36_8
# %bb.7:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageVLine
	jmp	.LBB36_84
.LBB36_8:
	cmpl	$0, -36(%rbp)
	jne	.LBB36_10
# %bb.9:
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageHLine
	jmp	.LBB36_84
.LBB36_10:
	jmp	.LBB36_11
.LBB36_11:
	movl	-36(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jg	.LBB36_48
# %bb.12:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	cos@PLT
	movsd	%xmm0, -96(%rbp)
	movsd	-96(%rbp), %xmm0                # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB36_13
	jp	.LBB36_13
	jmp	.LBB36_14
.LBB36_13:
	cvtsi2sdl	-88(%rbp), %xmm0
	divsd	-96(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB36_15
.LBB36_14:
	movl	$1, -76(%rbp)
.LBB36_15:
	cmpl	$0, -76(%rbp)
	jne	.LBB36_17
# %bb.16:
	movl	$1, -76(%rbp)
.LBB36_17:
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
	jle	.LBB36_19
# %bb.18:
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$-1, -72(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB36_20
.LBB36_19:
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$1, -72(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -60(%rbp)
.LBB36_20:
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
.LBB36_21:                              # =>This Inner Loop Header: Depth=1
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_24
# %bb.22:                               #   in Loop: Header=BB36_21 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.23:                               #   in Loop: Header=BB36_21 Depth=1
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB36_21
.LBB36_24:
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	imull	-72(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB36_36
# %bb.25:
	jmp	.LBB36_26
.LBB36_26:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_31 Depth 2
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB36_35
# %bb.27:                               #   in Loop: Header=BB36_26 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB36_29
# %bb.28:                               #   in Loop: Header=BB36_26 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB36_30
.LBB36_29:                              #   in Loop: Header=BB36_26 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB36_30:                              #   in Loop: Header=BB36_26 Depth=1
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
.LBB36_31:                              #   Parent Loop BB36_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_34
# %bb.32:                               #   in Loop: Header=BB36_31 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.33:                               #   in Loop: Header=BB36_31 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB36_31
.LBB36_34:                              #   in Loop: Header=BB36_26 Depth=1
	jmp	.LBB36_26
.LBB36_35:
	jmp	.LBB36_47
.LBB36_36:
	jmp	.LBB36_37
.LBB36_37:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_42 Depth 2
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB36_46
# %bb.38:                               #   in Loop: Header=BB36_37 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB36_40
# %bb.39:                               #   in Loop: Header=BB36_37 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB36_41
.LBB36_40:                              #   in Loop: Header=BB36_37 Depth=1
	movl	-56(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB36_41:                              #   in Loop: Header=BB36_37 Depth=1
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
.LBB36_42:                              #   Parent Loop BB36_37 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_45
# %bb.43:                               #   in Loop: Header=BB36_42 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.44:                               #   in Loop: Header=BB36_42 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB36_42
.LBB36_45:                              #   in Loop: Header=BB36_37 Depth=1
	jmp	.LBB36_37
.LBB36_46:
	jmp	.LBB36_47
.LBB36_47:
	jmp	.LBB36_84
.LBB36_48:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -104(%rbp)
	movsd	-104(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB36_49
	jp	.LBB36_49
	jmp	.LBB36_50
.LBB36_49:
	cvtsi2sdl	-88(%rbp), %xmm0
	divsd	-104(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB36_51
.LBB36_50:
	movl	$1, -76(%rbp)
.LBB36_51:
	cmpl	$0, -76(%rbp)
	jne	.LBB36_53
# %bb.52:
	movl	$1, -76(%rbp)
.LBB36_53:
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
	jle	.LBB36_55
# %bb.54:
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$-1, -68(%rbp)
	jmp	.LBB36_56
.LBB36_55:
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$1, -68(%rbp)
.LBB36_56:
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
.LBB36_57:                              # =>This Inner Loop Header: Depth=1
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_60
# %bb.58:                               #   in Loop: Header=BB36_57 Depth=1
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.59:                               #   in Loop: Header=BB36_57 Depth=1
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB36_57
.LBB36_60:
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	imull	-68(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB36_72
# %bb.61:
	jmp	.LBB36_62
.LBB36_62:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_67 Depth 2
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB36_71
# %bb.63:                               #   in Loop: Header=BB36_62 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB36_65
# %bb.64:                               #   in Loop: Header=BB36_62 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB36_66
.LBB36_65:                              #   in Loop: Header=BB36_62 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB36_66:                              #   in Loop: Header=BB36_62 Depth=1
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
.LBB36_67:                              #   Parent Loop BB36_62 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_70
# %bb.68:                               #   in Loop: Header=BB36_67 Depth=2
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.69:                               #   in Loop: Header=BB36_67 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB36_67
.LBB36_70:                              #   in Loop: Header=BB36_62 Depth=1
	jmp	.LBB36_62
.LBB36_71:
	jmp	.LBB36_83
.LBB36_72:
	jmp	.LBB36_73
.LBB36_73:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_78 Depth 2
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB36_82
# %bb.74:                               #   in Loop: Header=BB36_73 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB36_76
# %bb.75:                               #   in Loop: Header=BB36_73 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB36_77
.LBB36_76:                              #   in Loop: Header=BB36_73 Depth=1
	movl	-52(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB36_77:                              #   in Loop: Header=BB36_73 Depth=1
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
.LBB36_78:                              #   Parent Loop BB36_73 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	addl	-76(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB36_81
# %bb.79:                               #   in Loop: Header=BB36_78 Depth=2
	movq	-8(%rbp), %rdi
	movl	-80(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.80:                               #   in Loop: Header=BB36_78 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB36_78
.LBB36_81:                              #   in Loop: Header=BB36_73 Depth=1
	jmp	.LBB36_73
.LBB36_82:
	jmp	.LBB36_83
.LBB36_83:
	jmp	.LBB36_84
.LBB36_84:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end36:
	.size	gdImageLine, .Lfunc_end36-gdImageLine
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function gdImageAALine
.LCPI37_0:
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
	jne	.LBB37_2
# %bb.1:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine@PLT
	jmp	.LBB37_56
.LBB37_2:
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
	jne	.LBB37_4
# %bb.3:
	jmp	.LBB37_56
.LBB37_4:
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
	jne	.LBB37_6
# %bb.5:
	jmp	.LBB37_56
.LBB37_6:
	movl	-20(%rbp), %eax
	subl	-12(%rbp), %eax
	cltq
	movq	%rax, -72(%rbp)
	movl	-24(%rbp), %eax
	subl	-16(%rbp), %eax
	cltq
	movq	%rax, -80(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB37_9
# %bb.7:
	cmpq	$0, -80(%rbp)
	jne	.LBB37_9
# %bb.8:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB37_56
.LBB37_9:
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
	jge	.LBB37_11
# %bb.10:
	cvtsi2sdq	-80(%rbp), %xmm0
	cvtsi2sdq	-72(%rbp), %xmm1
	callq	atan2@PLT
	callq	cos@PLT
	movsd	%xmm0, -128(%rbp)               # 8-byte Spill
	jmp	.LBB37_12
.LBB37_11:
	cvtsi2sdq	-80(%rbp), %xmm0
	cvtsi2sdq	-72(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -128(%rbp)               # 8-byte Spill
.LBB37_12:
	movsd	-128(%rbp), %xmm0               # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movaps	.LCPI37_0(%rip), %xmm1          # xmm1 = [NaN,NaN]
	pand	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB37_13
	jp	.LBB37_13
	jmp	.LBB37_14
.LBB37_13:
	cvtsi2sdl	-104(%rbp), %xmm0
	divsd	-112(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -96(%rbp)
	jmp	.LBB37_15
.LBB37_14:
	movl	$1, -96(%rbp)
.LBB37_15:
	cmpl	$0, -96(%rbp)
	jne	.LBB37_17
# %bb.16:
	movl	$1, -96(%rbp)
.LBB37_17:
	jmp	.LBB37_18
.LBB37_18:
	cmpq	$0, -72(%rbp)
	jne	.LBB37_20
# %bb.19:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageVLine
	jmp	.LBB37_56
.LBB37_20:
	cmpq	$0, -80(%rbp)
	jne	.LBB37_22
# %bb.21:
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-28(%rbp), %r8d
	callq	gdImageHLine
	jmp	.LBB37_56
.LBB37_22:
	jmp	.LBB37_23
.LBB37_23:
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
	jle	.LBB37_40
# %bb.24:
	cmpq	$0, -72(%rbp)
	jge	.LBB37_26
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
.LBB37_26:
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
.LBB37_27:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB37_29 Depth 2
	movq	-40(%rbp), %rax
	movslq	-20(%rbp), %rcx
	cmpq	%rcx, %rax
	jg	.LBB37_39
# %bb.28:                               #   in Loop: Header=BB37_27 Depth=1
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
.LBB37_29:                              #   Parent Loop BB37_27 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-92(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	-96(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB37_32
# %bb.30:                               #   in Loop: Header=BB37_29 Depth=2
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
# %bb.31:                               #   in Loop: Header=BB37_29 Depth=2
	movl	-92(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -92(%rbp)
	jmp	.LBB37_29
.LBB37_32:                              #   in Loop: Header=BB37_27 Depth=1
	movq	-56(%rbp), %rax
	addq	-64(%rbp), %rax
	movq	%rax, -64(%rbp)
	cmpq	$65536, -64(%rbp)               # imm = 0x10000
	jl	.LBB37_34
# %bb.33:                               #   in Loop: Header=BB37_27 Depth=1
	movq	-64(%rbp), %rax
	subq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB37_37
.LBB37_34:                              #   in Loop: Header=BB37_27 Depth=1
	cmpq	$0, -64(%rbp)
	jge	.LBB37_36
# %bb.35:                               #   in Loop: Header=BB37_27 Depth=1
	movq	-64(%rbp), %rax
	addq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-48(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -48(%rbp)
.LBB37_36:                              #   in Loop: Header=BB37_27 Depth=1
	jmp	.LBB37_37
.LBB37_37:                              #   in Loop: Header=BB37_27 Depth=1
	jmp	.LBB37_38
.LBB37_38:                              #   in Loop: Header=BB37_27 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB37_27
.LBB37_39:
	jmp	.LBB37_56
.LBB37_40:
	cmpq	$0, -80(%rbp)
	jge	.LBB37_42
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
.LBB37_42:
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
.LBB37_43:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB37_45 Depth 2
	movq	-48(%rbp), %rax
	movslq	-24(%rbp), %rcx
	cmpq	%rcx, %rax
	jg	.LBB37_55
# %bb.44:                               #   in Loop: Header=BB37_43 Depth=1
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
.LBB37_45:                              #   Parent Loop BB37_43 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-92(%rbp), %eax
	movl	-100(%rbp), %ecx
	addl	-96(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB37_48
# %bb.46:                               #   in Loop: Header=BB37_45 Depth=2
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
# %bb.47:                               #   in Loop: Header=BB37_45 Depth=2
	movl	-92(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -92(%rbp)
	jmp	.LBB37_45
.LBB37_48:                              #   in Loop: Header=BB37_43 Depth=1
	movq	-56(%rbp), %rax
	addq	-64(%rbp), %rax
	movq	%rax, -64(%rbp)
	cmpq	$65536, -64(%rbp)               # imm = 0x10000
	jl	.LBB37_50
# %bb.49:                               #   in Loop: Header=BB37_43 Depth=1
	movq	-64(%rbp), %rax
	subq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB37_53
.LBB37_50:                              #   in Loop: Header=BB37_43 Depth=1
	cmpq	$0, -64(%rbp)
	jge	.LBB37_52
# %bb.51:                               #   in Loop: Header=BB37_43 Depth=1
	movq	-64(%rbp), %rax
	addq	$65536, %rax                    # imm = 0x10000
	movq	%rax, -64(%rbp)
	movq	-40(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -40(%rbp)
.LBB37_52:                              #   in Loop: Header=BB37_43 Depth=1
	jmp	.LBB37_53
.LBB37_53:                              #   in Loop: Header=BB37_43 Depth=1
	jmp	.LBB37_54
.LBB37_54:                              #   in Loop: Header=BB37_43 Depth=1
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB37_43
.LBB37_55:
	jmp	.LBB37_56
.LBB37_56:
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end37:
	.size	gdImageAALine, .Lfunc_end37-gdImageAALine
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
	jge	.LBB38_6
# %bb.1:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB38_3
# %bb.2:
	movl	$0, -4(%rbp)
	jmp	.LBB38_17
.LBB38_3:
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
	jle	.LBB38_5
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
.LBB38_5:
	movl	$1, -4(%rbp)
	jmp	.LBB38_17
.LBB38_6:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB38_12
# %bb.7:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB38_9
# %bb.8:
	movl	$0, -4(%rbp)
	jmp	.LBB38_17
.LBB38_9:
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
	jge	.LBB38_11
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
.LBB38_11:
	movl	$1, -4(%rbp)
	jmp	.LBB38_17
.LBB38_12:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB38_14
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
	jmp	.LBB38_17
.LBB38_14:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB38_16
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
	jmp	.LBB38_17
.LBB38_16:
	movl	$1, -4(%rbp)
.LBB38_17:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end38:
	.size	clip_1d, .Lfunc_end38-clip_1d
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
	jle	.LBB39_2
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
	callq	gdImageFilledRectangle@PLT
	jmp	.LBB39_9
.LBB39_2:
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB39_4
# %bb.3:
	movl	-16(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB39_4:
	jmp	.LBB39_5
.LBB39_5:                               # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB39_8
# %bb.6:                                #   in Loop: Header=BB39_5 Depth=1
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
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
	.size	gdImageVLine, .Lfunc_end39-gdImageVLine
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
	jle	.LBB40_2
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
	callq	_gdImageFilledHRectangle
	jmp	.LBB40_9
.LBB40_2:
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB40_4
# %bb.3:
	movl	-20(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -16(%rbp)
.LBB40_4:
	jmp	.LBB40_5
.LBB40_5:                               # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB40_8
# %bb.6:                                #   in Loop: Header=BB40_5 Depth=1
	movq	-8(%rbp), %rdi
	movl	-16(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.7:                                #   in Loop: Header=BB40_5 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB40_5
.LBB40_8:
	jmp	.LBB40_9
.LBB40_9:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end40:
	.size	gdImageHLine, .Lfunc_end40-gdImageHLine
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
	jg	.LBB41_23
# %bb.1:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -104(%rbp)
	movsd	-104(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB41_2
	jp	.LBB41_2
	jmp	.LBB41_3
.LBB41_2:
	cvtsi2sdl	-92(%rbp), %xmm0
	divsd	-104(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB41_4
.LBB41_3:
	movl	$1, -84(%rbp)
.LBB41_4:
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
	jle	.LBB41_6
# %bb.5:
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$-1, -72(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB41_7
.LBB41_6:
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$1, -72(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -60(%rbp)
.LBB41_7:
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
	jle	.LBB41_15
# %bb.8:
	jmp	.LBB41_9
.LBB41_9:                               # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB41_14
# %bb.10:                               #   in Loop: Header=BB41_9 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB41_12
# %bb.11:                               #   in Loop: Header=BB41_9 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB41_13
.LBB41_12:                              #   in Loop: Header=BB41_9 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB41_13:                              #   in Loop: Header=BB41_9 Depth=1
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
	jmp	.LBB41_9
.LBB41_14:
	jmp	.LBB41_22
.LBB41_15:
	jmp	.LBB41_16
.LBB41_16:                              # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jge	.LBB41_21
# %bb.17:                               #   in Loop: Header=BB41_16 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB41_19
# %bb.18:                               #   in Loop: Header=BB41_16 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB41_20
.LBB41_19:                              #   in Loop: Header=BB41_16 Depth=1
	movl	-56(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -56(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB41_20:                              #   in Loop: Header=BB41_16 Depth=1
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
	jmp	.LBB41_16
.LBB41_21:
	jmp	.LBB41_22
.LBB41_22:
	jmp	.LBB41_45
.LBB41_23:
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-32(%rbp), %xmm1
	callq	atan2@PLT
	callq	sin@PLT
	movsd	%xmm0, -112(%rbp)
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB41_24
	jp	.LBB41_24
	jmp	.LBB41_25
.LBB41_24:
	cvtsi2sdl	-92(%rbp), %xmm0
	divsd	-112(%rbp), %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB41_26
.LBB41_25:
	movl	$1, -84(%rbp)
.LBB41_26:
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
	jle	.LBB41_28
# %bb.27:
	movl	-24(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$-1, -68(%rbp)
	jmp	.LBB41_29
.LBB41_28:
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	$1, -68(%rbp)
.LBB41_29:
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
	jle	.LBB41_37
# %bb.30:
	jmp	.LBB41_31
.LBB41_31:                              # =>This Inner Loop Header: Depth=1
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB41_36
# %bb.32:                               #   in Loop: Header=BB41_31 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB41_34
# %bb.33:                               #   in Loop: Header=BB41_31 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB41_35
.LBB41_34:                              #   in Loop: Header=BB41_31 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB41_35:                              #   in Loop: Header=BB41_31 Depth=1
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
	jmp	.LBB41_31
.LBB41_36:
	jmp	.LBB41_44
.LBB41_37:
	jmp	.LBB41_38
.LBB41_38:                              # =>This Inner Loop Header: Depth=1
	movl	-56(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jge	.LBB41_43
# %bb.39:                               #   in Loop: Header=BB41_38 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	cmpl	$0, -48(%rbp)
	jge	.LBB41_41
# %bb.40:                               #   in Loop: Header=BB41_38 Depth=1
	movl	-40(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB41_42
.LBB41_41:                              #   in Loop: Header=BB41_38 Depth=1
	movl	-52(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB41_42:                              #   in Loop: Header=BB41_38 Depth=1
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
	jmp	.LBB41_38
.LBB41_43:
	jmp	.LBB41_44
.LBB41_44:
	jmp	.LBB41_45
.LBB41_45:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end41:
	.size	gdImageDashedLine, .Lfunc_end41-gdImageDashedLine
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
	jne	.LBB42_2
# %bb.1:
	movl	$0, -44(%rbp)
	cmpl	$0, -48(%rbp)
	setne	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -48(%rbp)
.LBB42_2:
	cmpl	$0, -48(%rbp)
	je	.LBB42_15
# %bb.3:
	cmpl	$0, 24(%rbp)
	je	.LBB42_9
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
.LBB42_5:                               # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	movl	-56(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB42_8
# %bb.6:                                #   in Loop: Header=BB42_5 Depth=1
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-52(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.7:                                #   in Loop: Header=BB42_5 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB42_5
.LBB42_8:
	jmp	.LBB42_14
.LBB42_9:
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
.LBB42_10:                              # =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	movl	-56(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB42_13
# %bb.11:                               #   in Loop: Header=BB42_10 Depth=1
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.12:                               #   in Loop: Header=BB42_10 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB42_10
.LBB42_13:
	jmp	.LBB42_14
.LBB42_14:
	jmp	.LBB42_15
.LBB42_15:
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
.Lfunc_end42:
	.size	dashedSet, .Lfunc_end42-dashedSet
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
	jl	.LBB43_5
# %bb.1:
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rdx
	movb	$1, %al
	cmpl	7296(%rdx), %ecx
	movb	%al, -17(%rbp)                  # 1-byte Spill
	jg	.LBB43_5
# %bb.2:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rdx
	movb	$1, %al
	cmpl	7284(%rdx), %ecx
	movb	%al, -18(%rbp)                  # 1-byte Spill
	jl	.LBB43_4
# %bb.3:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	setg	%al
	movb	%al, -18(%rbp)                  # 1-byte Spill
.LBB43_4:
	movb	-18(%rbp), %al                  # 1-byte Reload
	movb	%al, -17(%rbp)                  # 1-byte Spill
.LBB43_5:
	movb	-17(%rbp), %al                  # 1-byte Reload
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end43:
	.size	gdImageBoundsSafe, .Lfunc_end43-gdImageBoundsSafe
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
	addl	12(%rdx), %ecx
	cmpl	%ecx, %eax
	jge	.LBB44_13
# %bb.5:                                #   in Loop: Header=BB44_4 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB44_6:                               #   Parent Loop BB44_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-20(%rbp), %ecx
	movq	-16(%rbp), %rdx
	addl	8(%rdx), %ecx
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
	callq	gdImageSetPixel@PLT
.LBB44_9:                               #   in Loop: Header=BB44_6 Depth=2
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
# %bb.10:                               #   in Loop: Header=BB44_6 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB44_6
.LBB44_11:                              #   in Loop: Header=BB44_4 Depth=1
	movl	$0, -36(%rbp)
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
# %bb.12:                               #   in Loop: Header=BB44_4 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB44_4
.LBB44_13:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end44:
	.size	gdImageChar, .Lfunc_end44-gdImageChar
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
	jl	.LBB45_2
# %bb.1:
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	4(%rcx), %ecx
	movq	-16(%rbp), %rdx
	addl	(%rdx), %ecx
	cmpl	%ecx, %eax
	jl	.LBB45_3
.LBB45_2:
	jmp	.LBB45_13
.LBB45_3:
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
.LBB45_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB45_6 Depth 2
	movl	-48(%rbp), %eax
	movl	-24(%rbp), %ecx
	movq	-16(%rbp), %rdx
	subl	8(%rdx), %ecx
	cmpl	%ecx, %eax
	jle	.LBB45_13
# %bb.5:                                #   in Loop: Header=BB45_4 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB45_6:                               #   Parent Loop BB45_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-20(%rbp), %ecx
	movq	-16(%rbp), %rdx
	addl	12(%rdx), %ecx
	cmpl	%ecx, %eax
	jge	.LBB45_11
# %bb.7:                                #   in Loop: Header=BB45_6 Depth=2
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
	je	.LBB45_9
# %bb.8:                                #   in Loop: Header=BB45_6 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-32(%rbp), %ecx
	callq	gdImageSetPixel@PLT
.LBB45_9:                               #   in Loop: Header=BB45_6 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
# %bb.10:                               #   in Loop: Header=BB45_6 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB45_6
.LBB45_11:                              #   in Loop: Header=BB45_4 Depth=1
	movl	$0, -40(%rbp)
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
# %bb.12:                               #   in Loop: Header=BB45_4 Depth=1
	movl	-48(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB45_4
.LBB45_13:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end45:
	.size	gdImageCharUp, .Lfunc_end45-gdImageCharUp
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
	callq	gdImageChar@PLT
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
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
	.size	gdImageString, .Lfunc_end46-gdImageString
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
	movzbl	(%rax,%r8), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageCharUp@PLT
	movq	-16(%rbp), %rax
	movl	8(%rax), %ecx
	movl	-24(%rbp), %eax
	subl	%ecx, %eax
	movl	%eax, -24(%rbp)
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
	.size	gdImageStringUp, .Lfunc_end47-gdImageStringUp
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
.LBB48_1:                               # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB48_4
# %bb.2:                                #   in Loop: Header=BB48_1 Depth=1
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %r8
	movzwl	(%rax,%r8,2), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageChar@PLT
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
# %bb.3:                                #   in Loop: Header=BB48_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB48_1
.LBB48_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end48:
	.size	gdImageString16, .Lfunc_end48-gdImageString16
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
.LBB49_1:                               # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpw	$0, (%rax)
	je	.LBB49_3
# %bb.2:                                #   in Loop: Header=BB49_1 Depth=1
	movq	-8(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -8(%rbp)
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB49_1
.LBB49_3:
	movl	-12(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end49:
	.size	strlen16, .Lfunc_end49-strlen16
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
.LBB50_1:                               # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB50_4
# %bb.2:                                #   in Loop: Header=BB50_1 Depth=1
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %r8
	movzwl	(%rax,%r8,2), %r8d
	movl	-36(%rbp), %r9d
	callq	gdImageCharUp@PLT
	movq	-16(%rbp), %rax
	movl	8(%rax), %ecx
	movl	-24(%rbp), %eax
	subl	%ecx, %eax
	movl	%eax, -24(%rbp)
# %bb.3:                                #   in Loop: Header=BB50_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB50_1
.LBB50_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end50:
	.size	gdImageStringUp16, .Lfunc_end50-gdImageStringUp16
	.cfi_endproc
                                        # -- End function
	.hidden	lsqrt                           # -- Begin function lsqrt
	.globl	lsqrt
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
.Lfunc_end51:
	.size	lsqrt, .Lfunc_end51-lsqrt
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
	callq	gdImageFilledArc@PLT
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end52:
	.size	gdImageArc, .Lfunc_end52-gdImageArc
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
	subq	$3008, %rsp                     # imm = 0xBC0
	movl	32(%rbp), %eax
	movl	24(%rbp), %eax
	movl	16(%rbp), %eax
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -28(%rbp)
	movl	$0, -2956(%rbp)
	movl	$0, -2960(%rbp)
	movl	$0, -2964(%rbp)
	movl	$0, -2968(%rbp)
	movl	$-1, -2972(%rbp)
	movl	$-1, -2976(%rbp)
	movl	$-1, -2980(%rbp)
	movl	$-1, -2984(%rbp)
	movl	-28(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, -2996(%rbp)               # 4-byte Spill
	movl	16(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, %eax
	movl	-2996(%rbp), %edx               # 4-byte Reload
	cmpl	%eax, %edx
	jne	.LBB53_2
# %bb.1:
	movl	$0, -28(%rbp)
	movl	$360, 16(%rbp)                  # imm = 0x168
	jmp	.LBB53_15
.LBB53_2:
	cmpl	$360, -28(%rbp)                 # imm = 0x168
	jle	.LBB53_4
# %bb.3:
	movl	-28(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, -28(%rbp)
.LBB53_4:
	cmpl	$360, 16(%rbp)                  # imm = 0x168
	jle	.LBB53_6
# %bb.5:
	movl	16(%rbp), %eax
	movl	$360, %ecx                      # imm = 0x168
	cltd
	idivl	%ecx
	movl	%edx, 16(%rbp)
.LBB53_6:
	jmp	.LBB53_7
.LBB53_7:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -28(%rbp)
	jge	.LBB53_9
# %bb.8:                                #   in Loop: Header=BB53_7 Depth=1
	movl	-28(%rbp), %eax
	addl	$360, %eax                      # imm = 0x168
	movl	%eax, -28(%rbp)
	jmp	.LBB53_7
.LBB53_9:
	jmp	.LBB53_10
.LBB53_10:                              # =>This Inner Loop Header: Depth=1
	movl	16(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB53_12
# %bb.11:                               #   in Loop: Header=BB53_10 Depth=1
	movl	16(%rbp), %eax
	addl	$360, %eax                      # imm = 0x168
	movl	%eax, 16(%rbp)
	jmp	.LBB53_10
.LBB53_12:
	movl	-28(%rbp), %eax
	cmpl	16(%rbp), %eax
	jne	.LBB53_14
# %bb.13:
	movl	$0, -28(%rbp)
	movl	$360, 16(%rbp)                  # imm = 0x168
.LBB53_14:
	jmp	.LBB53_15
.LBB53_15:
	movl	-28(%rbp), %eax
	movl	%eax, -2948(%rbp)
	movl	$1, -2952(%rbp)
.LBB53_16:                              # =>This Inner Loop Header: Depth=1
	movl	-2948(%rbp), %eax
	cmpl	16(%rbp), %eax
	jg	.LBB53_39
# %bb.17:                               #   in Loop: Header=BB53_16 Depth=1
	movl	-2948(%rbp), %eax
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
	movl	%eax, -2980(%rbp)
	movl	%eax, -2988(%rbp)
	movl	-2948(%rbp), %eax
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
	movl	%eax, -2984(%rbp)
	movl	%eax, -2992(%rbp)
	movl	-2948(%rbp), %eax
	cmpl	-28(%rbp), %eax
	je	.LBB53_34
# %bb.18:                               #   in Loop: Header=BB53_16 Depth=1
	movl	32(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	jne	.LBB53_33
# %bb.19:                               #   in Loop: Header=BB53_16 Depth=1
	movl	32(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB53_21
# %bb.20:                               #   in Loop: Header=BB53_16 Depth=1
	movq	-8(%rbp), %rdi
	movl	-2956(%rbp), %esi
	movl	-2960(%rbp), %edx
	movl	-2988(%rbp), %ecx
	movl	-2992(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine@PLT
	jmp	.LBB53_32
.LBB53_21:                              #   in Loop: Header=BB53_16 Depth=1
	movl	-2992(%rbp), %eax
	cmpl	-2960(%rbp), %eax
	jne	.LBB53_30
# %bb.22:                               #   in Loop: Header=BB53_16 Depth=1
	movl	-2952(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -2952(%rbp)
	cmpl	$270, -2948(%rbp)               # imm = 0x10E
	jg	.LBB53_24
# %bb.23:                               #   in Loop: Header=BB53_16 Depth=1
	cmpl	$90, -2948(%rbp)
	jge	.LBB53_25
.LBB53_24:                              #   in Loop: Header=BB53_16 Depth=1
	movl	-2988(%rbp), %eax
	cmpl	-2956(%rbp), %eax
	jg	.LBB53_28
.LBB53_25:                              #   in Loop: Header=BB53_16 Depth=1
	cmpl	$90, -2948(%rbp)
	jle	.LBB53_29
# %bb.26:                               #   in Loop: Header=BB53_16 Depth=1
	cmpl	$270, -2948(%rbp)               # imm = 0x10E
	jge	.LBB53_29
# %bb.27:                               #   in Loop: Header=BB53_16 Depth=1
	movl	-2988(%rbp), %eax
	cmpl	-2956(%rbp), %eax
	jge	.LBB53_29
.LBB53_28:                              #   in Loop: Header=BB53_16 Depth=1
	movl	-2988(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2944(%rbp,%rax,8)
.LBB53_29:                              #   in Loop: Header=BB53_16 Depth=1
	jmp	.LBB53_31
.LBB53_30:                              #   in Loop: Header=BB53_16 Depth=1
	movl	-2988(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2944(%rbp,%rax,8)
	movl	-2992(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2940(%rbp,%rax,8)
.LBB53_31:                              #   in Loop: Header=BB53_16 Depth=1
	jmp	.LBB53_32
.LBB53_32:                              #   in Loop: Header=BB53_16 Depth=1
	jmp	.LBB53_33
.LBB53_33:                              #   in Loop: Header=BB53_16 Depth=1
	jmp	.LBB53_37
.LBB53_34:                              #   in Loop: Header=BB53_16 Depth=1
	movl	-2988(%rbp), %eax
	movl	%eax, -2964(%rbp)
	movl	-2992(%rbp), %eax
	movl	%eax, -2968(%rbp)
	movl	32(%rbp), %eax
	andl	$3, %eax
	cmpl	$0, %eax
	jne	.LBB53_36
# %bb.35:                               #   in Loop: Header=BB53_16 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -2944(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -2940(%rbp)
	movl	-2988(%rbp), %ecx
	movl	%ecx, -2972(%rbp)
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2944(%rbp,%rax,8)
	movl	-2992(%rbp), %ecx
	movl	%ecx, -2976(%rbp)
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2940(%rbp,%rax,8)
.LBB53_36:                              #   in Loop: Header=BB53_16 Depth=1
	jmp	.LBB53_37
.LBB53_37:                              #   in Loop: Header=BB53_16 Depth=1
	movl	-2988(%rbp), %eax
	movl	%eax, -2956(%rbp)
	movl	-2992(%rbp), %eax
	movl	%eax, -2960(%rbp)
# %bb.38:                               #   in Loop: Header=BB53_16 Depth=1
	movl	-2948(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -2948(%rbp)
	movl	-2952(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -2952(%rbp)
	jmp	.LBB53_16
.LBB53_39:
	movl	32(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB53_46
# %bb.40:
	movl	32(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB53_44
# %bb.41:
	movl	32(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB53_43
# %bb.42:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-2956(%rbp), %ecx
	movl	-2960(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine@PLT
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-2964(%rbp), %ecx
	movl	-2968(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine@PLT
.LBB53_43:
	movq	-8(%rbp), %rdi
	movl	-2964(%rbp), %esi
	movl	-2968(%rbp), %edx
	movl	-2956(%rbp), %ecx
	movl	-2960(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine@PLT
	jmp	.LBB53_45
.LBB53_44:
	movl	-2964(%rbp), %eax
	movl	%eax, -2944(%rbp)
	movl	-2968(%rbp), %eax
	movl	%eax, -2940(%rbp)
	movl	-2956(%rbp), %eax
	movl	%eax, -2936(%rbp)
	movl	-2960(%rbp), %eax
	movl	%eax, -2932(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -2928(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -2924(%rbp)
	movq	-8(%rbp), %rdi
	leaq	-2944(%rbp), %rsi
	movl	24(%rbp), %ecx
	movl	$3, %edx
	callq	gdImageFilledPolygon@PLT
.LBB53_45:
	jmp	.LBB53_64
.LBB53_46:
	movl	32(%rbp), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB53_50
# %bb.47:
	movl	32(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB53_49
# %bb.48:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-2956(%rbp), %ecx
	movl	-2960(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine@PLT
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-2964(%rbp), %ecx
	movl	-2968(%rbp), %r8d
	movl	24(%rbp), %r9d
	callq	gdImageLine@PLT
.LBB53_49:
	jmp	.LBB53_63
.LBB53_50:
	movl	16(%rbp), %eax
	subl	-28(%rbp), %eax
	cmpl	$360, %eax                      # imm = 0x168
	jge	.LBB53_62
# %bb.51:
	movl	-2936(%rbp), %eax
	cmpl	-2972(%rbp), %eax
	je	.LBB53_58
# %bb.52:
	movl	-2932(%rbp), %eax
	cmpl	-2976(%rbp), %eax
	jne	.LBB53_58
# %bb.53:
	movl	-2952(%rbp), %eax
	movl	%eax, -2948(%rbp)
.LBB53_54:                              # =>This Inner Loop Header: Depth=1
	cmpl	$1, -2948(%rbp)
	jle	.LBB53_57
# %bb.55:                               #   in Loop: Header=BB53_54 Depth=1
	movl	-2948(%rbp), %eax
	subl	$1, %eax
	cltq
	movl	-2944(%rbp,%rax,8), %ecx
	movslq	-2948(%rbp), %rax
	movl	%ecx, -2944(%rbp,%rax,8)
	movl	-2948(%rbp), %eax
	subl	$1, %eax
	cltq
	movl	-2940(%rbp,%rax,8), %ecx
	movslq	-2948(%rbp), %rax
	movl	%ecx, -2940(%rbp,%rax,8)
# %bb.56:                               #   in Loop: Header=BB53_54 Depth=1
	movl	-2948(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -2948(%rbp)
	jmp	.LBB53_54
.LBB53_57:
	movl	-2972(%rbp), %eax
	movl	%eax, -2936(%rbp)
	movl	-2976(%rbp), %eax
	movl	%eax, -2932(%rbp)
	movl	-2952(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -2952(%rbp)
.LBB53_58:
	movl	-2952(%rbp), %eax
	subl	$1, %eax
	cltq
	movl	-2944(%rbp,%rax,8), %eax
	cmpl	-2980(%rbp), %eax
	je	.LBB53_61
# %bb.59:
	movl	-2952(%rbp), %eax
	subl	$1, %eax
	cltq
	movl	-2940(%rbp,%rax,8), %eax
	cmpl	-2984(%rbp), %eax
	jne	.LBB53_61
# %bb.60:
	movl	-2980(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2944(%rbp,%rax,8)
	movl	-2984(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2940(%rbp,%rax,8)
	movl	-2952(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -2952(%rbp)
.LBB53_61:
	jmp	.LBB53_62
.LBB53_62:
	movl	-12(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2944(%rbp,%rax,8)
	movl	-16(%rbp), %ecx
	movslq	-2952(%rbp), %rax
	movl	%ecx, -2940(%rbp,%rax,8)
	movq	-8(%rbp), %rdi
	leaq	-2944(%rbp), %rsi
	movl	-2952(%rbp), %edx
	addl	$1, %edx
	movl	24(%rbp), %ecx
	callq	gdImageFilledPolygon@PLT
.LBB53_63:
	jmp	.LBB53_64
.LBB53_64:
	addq	$3008, %rsp                     # imm = 0xBC0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end53:
	.size	gdImageFilledArc, .Lfunc_end53-gdImageFilledArc
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageFilledPolygon
.LCPI54_0:
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
	jg	.LBB54_2
# %bb.1:
	jmp	.LBB54_83
.LBB54_2:
	cmpl	$-7, -24(%rbp)
	jne	.LBB54_4
# %bb.3:
	movq	-8(%rbp), %rax
	movl	7276(%rax), %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB54_5
.LBB54_4:
	movl	-24(%rbp), %eax
	movl	%eax, -84(%rbp)
.LBB54_5:
	movq	-8(%rbp), %rax
	cmpl	$0, 4128(%rax)
	jne	.LBB54_11
# %bb.6:
	movl	-20(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB54_8
# %bb.7:
	jmp	.LBB54_83
.LBB54_8:
	movslq	-20(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 4120(%rax)
	movq	-8(%rbp), %rax
	cmpq	$0, 4120(%rax)
	jne	.LBB54_10
# %bb.9:
	jmp	.LBB54_83
.LBB54_10:
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 4128(%rax)
.LBB54_11:
	movq	-8(%rbp), %rax
	movl	4128(%rax), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB54_20
# %bb.12:
	jmp	.LBB54_13
.LBB54_13:                              # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	4128(%rax), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB54_15
# %bb.14:                               #   in Loop: Header=BB54_13 Depth=1
	movq	-8(%rbp), %rax
	movl	4128(%rax), %ecx
	shll	$1, %ecx
	movl	%ecx, 4128(%rax)
	jmp	.LBB54_13
.LBB54_15:
	movq	-8(%rbp), %rax
	movl	4128(%rax), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB54_17
# %bb.16:
	jmp	.LBB54_83
.LBB54_17:
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
	jne	.LBB54_19
# %bb.18:
	jmp	.LBB54_83
.LBB54_19:
	jmp	.LBB54_20
.LBB54_20:
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -48(%rbp)
	movl	$1, -28(%rbp)
.LBB54_21:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB54_28
# %bb.22:                               #   in Loop: Header=BB54_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB54_24
# %bb.23:                               #   in Loop: Header=BB54_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -44(%rbp)
.LBB54_24:                              #   in Loop: Header=BB54_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB54_26
# %bb.25:                               #   in Loop: Header=BB54_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	4(%rax,%rcx,8), %eax
	movl	%eax, -48(%rbp)
.LBB54_26:                              #   in Loop: Header=BB54_21 Depth=1
	jmp	.LBB54_27
.LBB54_27:                              #   in Loop: Header=BB54_21 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB54_21
.LBB54_28:
	cmpl	$1, -20(%rbp)
	jle	.LBB54_40
# %bb.29:
	movl	-44(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jne	.LBB54_40
# %bb.30:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -64(%rbp)
	movl	%eax, -56(%rbp)
	movl	$1, -28(%rbp)
.LBB54_31:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB54_39
# %bb.32:                               #   in Loop: Header=BB54_31 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	cmpl	-56(%rbp), %eax
	jge	.LBB54_34
# %bb.33:                               #   in Loop: Header=BB54_31 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB54_37
.LBB54_34:                              #   in Loop: Header=BB54_31 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	cmpl	-64(%rbp), %eax
	jle	.LBB54_36
# %bb.35:                               #   in Loop: Header=BB54_31 Depth=1
	movq	-16(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -64(%rbp)
.LBB54_36:                              #   in Loop: Header=BB54_31 Depth=1
	jmp	.LBB54_37
.LBB54_37:                              #   in Loop: Header=BB54_31 Depth=1
	jmp	.LBB54_38
.LBB54_38:                              #   in Loop: Header=BB54_31 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB54_31
.LBB54_39:
	movq	-8(%rbp), %rdi
	movl	-56(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-64(%rbp), %ecx
	movl	-44(%rbp), %r8d
	movl	-24(%rbp), %r9d
	callq	gdImageLine@PLT
	jmp	.LBB54_83
.LBB54_40:
	movl	-48(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-44(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7288(%rcx), %eax
	jge	.LBB54_42
# %bb.41:
	movq	-8(%rbp), %rax
	movl	7288(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB54_42:
	movl	-48(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jle	.LBB54_44
# %bb.43:
	movq	-8(%rbp), %rax
	movl	7296(%rax), %eax
	movl	%eax, -48(%rbp)
.LBB54_44:
	movl	-44(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB54_45:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB54_47 Depth 2
                                        #     Child Loop BB54_67 Depth 2
                                        #       Child Loop BB54_69 Depth 3
                                        #     Child Loop BB54_76 Depth 2
	movl	-40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jg	.LBB54_81
# %bb.46:                               #   in Loop: Header=BB54_45 Depth=1
	movl	$0, -80(%rbp)
	movl	$0, -28(%rbp)
.LBB54_47:                              #   Parent Loop BB54_45 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB54_66
# %bb.48:                               #   in Loop: Header=BB54_47 Depth=2
	cmpl	$0, -28(%rbp)
	jne	.LBB54_50
# %bb.49:                               #   in Loop: Header=BB54_47 Depth=2
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -72(%rbp)
	movl	$0, -76(%rbp)
	jmp	.LBB54_51
.LBB54_50:                              #   in Loop: Header=BB54_47 Depth=2
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -72(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -76(%rbp)
.LBB54_51:                              #   in Loop: Header=BB54_47 Depth=2
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
	jge	.LBB54_53
# %bb.52:                               #   in Loop: Header=BB54_47 Depth=2
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -56(%rbp)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	(%rax,%rcx,8), %eax
	movl	%eax, -64(%rbp)
	jmp	.LBB54_57
.LBB54_53:                              #   in Loop: Header=BB54_47 Depth=2
	movl	-60(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jle	.LBB54_55
# %bb.54:                               #   in Loop: Header=BB54_47 Depth=2
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
	jmp	.LBB54_56
.LBB54_55:                              #   in Loop: Header=BB54_47 Depth=2
	jmp	.LBB54_65
.LBB54_56:                              #   in Loop: Header=BB54_47 Depth=2
	jmp	.LBB54_57
.LBB54_57:                              #   in Loop: Header=BB54_47 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.LBB54_60
# %bb.58:                               #   in Loop: Header=BB54_47 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB54_60
# %bb.59:                               #   in Loop: Header=BB54_47 Depth=2
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
	movsd	.LCPI54_0(%rip), %xmm1          # xmm1 = mem[0],zero
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
	jmp	.LBB54_64
.LBB54_60:                              #   in Loop: Header=BB54_47 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jne	.LBB54_63
# %bb.61:                               #   in Loop: Header=BB54_47 Depth=2
	movl	-40(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jne	.LBB54_63
# %bb.62:                               #   in Loop: Header=BB54_47 Depth=2
	movl	-64(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-80(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -80(%rbp)
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
.LBB54_63:                              #   in Loop: Header=BB54_47 Depth=2
	jmp	.LBB54_64
.LBB54_64:                              #   in Loop: Header=BB54_47 Depth=2
	jmp	.LBB54_65
.LBB54_65:                              #   in Loop: Header=BB54_47 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB54_47
.LBB54_66:                              #   in Loop: Header=BB54_45 Depth=1
	movl	$1, -28(%rbp)
.LBB54_67:                              #   Parent Loop BB54_45 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB54_69 Depth 3
	movl	-28(%rbp), %eax
	cmpl	-80(%rbp), %eax
	jge	.LBB54_75
# %bb.68:                               #   in Loop: Header=BB54_67 Depth=2
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -32(%rbp)
.LBB54_69:                              #   Parent Loop BB54_45 Depth=1
                                        #     Parent Loop BB54_67 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, -32(%rbp)
	movb	%al, -85(%rbp)                  # 1-byte Spill
	jle	.LBB54_71
# %bb.70:                               #   in Loop: Header=BB54_69 Depth=3
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movl	-32(%rbp), %ecx
	subl	$1, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	-36(%rbp), %eax
	setg	%al
	movb	%al, -85(%rbp)                  # 1-byte Spill
.LBB54_71:                              #   in Loop: Header=BB54_69 Depth=3
	movb	-85(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB54_72
	jmp	.LBB54_73
.LBB54_72:                              #   in Loop: Header=BB54_69 Depth=3
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
	jmp	.LBB54_69
.LBB54_73:                              #   in Loop: Header=BB54_67 Depth=2
	movl	-36(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-32(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.74:                               #   in Loop: Header=BB54_67 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB54_67
.LBB54_75:                              #   in Loop: Header=BB54_45 Depth=1
	movl	$0, -28(%rbp)
.LBB54_76:                              #   Parent Loop BB54_45 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	movl	-80(%rbp), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	.LBB54_79
# %bb.77:                               #   in Loop: Header=BB54_76 Depth=2
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
	callq	gdImageLine@PLT
# %bb.78:                               #   in Loop: Header=BB54_76 Depth=2
	movl	-28(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB54_76
.LBB54_79:                              #   in Loop: Header=BB54_45 Depth=1
	jmp	.LBB54_80
.LBB54_80:                              #   in Loop: Header=BB54_45 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB54_45
.LBB54_81:
	cmpl	$-7, -24(%rbp)
	jne	.LBB54_83
# %bb.82:
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImagePolygon@PLT
.LBB54_83:
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end54:
	.size	gdImageFilledPolygon, .Lfunc_end54-gdImageFilledPolygon
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
	callq	gdImageSetPixel@PLT
	movq	-8(%rbp), %rdi
	movslq	-12(%rbp), %rax
	subq	-112(%rbp), %rax
	movl	%eax, %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
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
.LBB55_1:                               # =>This Inner Loop Header: Depth=1
	cmpl	$0, -32(%rbp)
	jle	.LBB55_7
# %bb.2:                                #   in Loop: Header=BB55_1 Depth=1
	cmpq	$0, -88(%rbp)
	jle	.LBB55_4
# %bb.3:                                #   in Loop: Header=BB55_1 Depth=1
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
.LBB55_4:                               #   in Loop: Header=BB55_1 Depth=1
	cmpq	$0, -88(%rbp)
	jg	.LBB55_6
# %bb.5:                                #   in Loop: Header=BB55_1 Depth=1
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
.LBB55_6:                               #   in Loop: Header=BB55_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB55_1
.LBB55_7:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end55:
	.size	gdImageEllipse, .Lfunc_end55-gdImageEllipse
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
.LBB56_1:                               # =>This Inner Loop Header: Depth=1
	movslq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	addq	-112(%rbp), %rcx
	cmpq	%rcx, %rax
	jg	.LBB56_4
# %bb.2:                                #   in Loop: Header=BB56_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.3:                                #   in Loop: Header=BB56_1 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB56_1
.LBB56_4:
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
.LBB56_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB56_12 Depth 2
	cmpl	$0, -32(%rbp)
	jle	.LBB56_17
# %bb.6:                                #   in Loop: Header=BB56_5 Depth=1
	cmpq	$0, -88(%rbp)
	jle	.LBB56_8
# %bb.7:                                #   in Loop: Header=BB56_5 Depth=1
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
.LBB56_8:                               #   in Loop: Header=BB56_5 Depth=1
	cmpq	$0, -88(%rbp)
	jg	.LBB56_10
# %bb.9:                                #   in Loop: Header=BB56_5 Depth=1
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
.LBB56_10:                              #   in Loop: Header=BB56_5 Depth=1
	movl	-128(%rbp), %eax
	cmpl	-48(%rbp), %eax
	je	.LBB56_16
# %bb.11:                               #   in Loop: Header=BB56_5 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -124(%rbp)
.LBB56_12:                              #   Parent Loop BB56_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-124(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jg	.LBB56_15
# %bb.13:                               #   in Loop: Header=BB56_12 Depth=2
	movq	-8(%rbp), %rdi
	movl	-124(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movq	-8(%rbp), %rdi
	movl	-124(%rbp), %esi
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.14:                               #   in Loop: Header=BB56_12 Depth=2
	movl	-124(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -124(%rbp)
	jmp	.LBB56_12
.LBB56_15:                              #   in Loop: Header=BB56_5 Depth=1
	jmp	.LBB56_16
.LBB56_16:                              #   in Loop: Header=BB56_5 Depth=1
	movl	-48(%rbp), %eax
	movl	%eax, -128(%rbp)
	jmp	.LBB56_5
.LBB56_17:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end56:
	.size	gdImageFilledEllipse, .Lfunc_end56-gdImageFilledEllipse
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
	jl	.LBB57_2
# %bb.1:
	cmpl	$0, -24(%rbp)
	jge	.LBB57_3
.LBB57_2:
	jmp	.LBB57_63
.LBB57_3:
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB57_8
# %bb.4:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	16(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jg	.LBB57_6
# %bb.5:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	16(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB57_7
.LBB57_6:
	jmp	.LBB57_63
.LBB57_7:
	jmp	.LBB57_8
.LBB57_8:
	movl	$-1, -32(%rbp)
	movq	-8(%rbp), %rax
	movl	7264(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	$0, 7264(%rax)
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB57_10
# %bb.9:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB57_13
.LBB57_10:
	cmpl	$0, -12(%rbp)
	jge	.LBB57_12
# %bb.11:
	movl	$0, -12(%rbp)
.LBB57_12:
	jmp	.LBB57_13
.LBB57_13:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB57_15
# %bb.14:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB57_18
.LBB57_15:
	cmpl	$0, -16(%rbp)
	jge	.LBB57_17
# %bb.16:
	movl	$0, -16(%rbp)
.LBB57_17:
	jmp	.LBB57_18
.LBB57_18:
	movl	-12(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB57_19:                              # =>This Inner Loop Header: Depth=1
	cmpl	$0, -40(%rbp)
	jl	.LBB57_24
# %bb.20:                               #   in Loop: Header=BB57_19 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-20(%rbp), %eax
	jne	.LBB57_22
# %bb.21:
	jmp	.LBB57_24
.LBB57_22:                              #   in Loop: Header=BB57_19 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-40(%rbp), %eax
	movl	%eax, -32(%rbp)
# %bb.23:                               #   in Loop: Header=BB57_19 Depth=1
	movl	-40(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB57_19
.LBB57_24:
	cmpl	$-1, -32(%rbp)
	jne	.LBB57_26
# %bb.25:
	movl	-44(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	jmp	.LBB57_63
.LBB57_26:
	movl	-12(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
.LBB57_27:                              # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB57_32
# %bb.28:                               #   in Loop: Header=BB57_27 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-20(%rbp), %eax
	jne	.LBB57_30
# %bb.29:
	jmp	.LBB57_32
.LBB57_30:                              #   in Loop: Header=BB57_27 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-40(%rbp), %eax
	movl	%eax, -36(%rbp)
# %bb.31:                               #   in Loop: Header=BB57_27 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB57_27
.LBB57_32:
	cmpl	$0, -16(%rbp)
	jle	.LBB57_47
# %bb.33:
	movl	$1, -28(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB57_34:                              # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jg	.LBB57_46
# %bb.35:                               #   in Loop: Header=BB57_34 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	subl	$1, %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -48(%rbp)
	cmpl	$0, -28(%rbp)
	je	.LBB57_40
# %bb.36:                               #   in Loop: Header=BB57_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB57_39
# %bb.37:                               #   in Loop: Header=BB57_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB57_39
# %bb.38:                               #   in Loop: Header=BB57_34 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	subl	$1, %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	callq	gdImageFillToBorder@PLT
	movl	$0, -28(%rbp)
.LBB57_39:                              #   in Loop: Header=BB57_34 Depth=1
	jmp	.LBB57_44
.LBB57_40:                              #   in Loop: Header=BB57_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB57_42
# %bb.41:                               #   in Loop: Header=BB57_34 Depth=1
	movl	-48(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB57_43
.LBB57_42:                              #   in Loop: Header=BB57_34 Depth=1
	movl	$1, -28(%rbp)
.LBB57_43:                              #   in Loop: Header=BB57_34 Depth=1
	jmp	.LBB57_44
.LBB57_44:                              #   in Loop: Header=BB57_34 Depth=1
	jmp	.LBB57_45
.LBB57_45:                              #   in Loop: Header=BB57_34 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB57_34
.LBB57_46:
	jmp	.LBB57_47
.LBB57_47:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	12(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	.LBB57_62
# %bb.48:
	movl	$1, -28(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB57_49:                              # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jg	.LBB57_61
# %bb.50:                               #   in Loop: Header=BB57_49 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -52(%rbp)
	cmpl	$0, -28(%rbp)
	je	.LBB57_55
# %bb.51:                               #   in Loop: Header=BB57_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB57_54
# %bb.52:                               #   in Loop: Header=BB57_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB57_54
# %bb.53:                               #   in Loop: Header=BB57_49 Depth=1
	movq	-8(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	callq	gdImageFillToBorder@PLT
	movl	$0, -28(%rbp)
.LBB57_54:                              #   in Loop: Header=BB57_49 Depth=1
	jmp	.LBB57_59
.LBB57_55:                              #   in Loop: Header=BB57_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB57_57
# %bb.56:                               #   in Loop: Header=BB57_49 Depth=1
	movl	-52(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB57_58
.LBB57_57:                              #   in Loop: Header=BB57_49 Depth=1
	movl	$1, -28(%rbp)
.LBB57_58:                              #   in Loop: Header=BB57_49 Depth=1
	jmp	.LBB57_59
.LBB57_59:                              #   in Loop: Header=BB57_49 Depth=1
	jmp	.LBB57_60
.LBB57_60:                              #   in Loop: Header=BB57_49 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB57_49
.LBB57_61:
	jmp	.LBB57_62
.LBB57_62:
	movl	-44(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
.LBB57_63:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end57:
	.size	gdImageFillToBorder, .Lfunc_end57-gdImageFillToBorder
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
	jne	.LBB58_3
# %bb.1:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	16(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB58_3
# %bb.2:
	jmp	.LBB58_80
.LBB58_3:
	movq	-8(%rbp), %rax
	movl	7264(%rax), %eax
	movl	%eax, -52(%rbp)
	movq	-8(%rbp), %rax
	movl	$0, 7264(%rax)
	cmpl	$-5, -20(%rbp)
	jne	.LBB58_5
# %bb.4:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	_gdImageFillTiled
	movl	-52(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	jmp	.LBB58_80
.LBB58_5:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -48(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB58_10
# %bb.6:
	cmpl	$0, -12(%rbp)
	jl	.LBB58_10
# %bb.7:
	movl	-12(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jg	.LBB58_10
# %bb.8:
	cmpl	$0, -16(%rbp)
	jl	.LBB58_10
# %bb.9:
	movl	-16(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jle	.LBB58_11
.LBB58_10:
	movl	-52(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
	jmp	.LBB58_80
.LBB58_11:
	movq	-8(%rbp), %rax
	cmpl	$4, 8(%rax)
	jge	.LBB58_21
# %bb.12:
	movl	-12(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -80(%rbp)
.LBB58_13:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB58_14 Depth 2
	jmp	.LBB58_14
.LBB58_14:                              #   Parent Loop BB58_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rdi
	movl	-76(%rbp), %esi
	movl	-80(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	cmpl	-40(%rbp), %eax
	je	.LBB58_16
# %bb.15:
	jmp	.LBB58_79
.LBB58_16:                              #   in Loop: Header=BB58_14 Depth=2
	movq	-8(%rbp), %rdi
	movl	-76(%rbp), %esi
	movl	-80(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.17:                               #   in Loop: Header=BB58_14 Depth=2
	movl	-76(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -76(%rbp)
	movq	-8(%rbp), %rcx
	movl	8(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jl	.LBB58_14
# %bb.18:                               #   in Loop: Header=BB58_13 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -76(%rbp)
# %bb.19:                               #   in Loop: Header=BB58_13 Depth=1
	movl	-80(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -80(%rbp)
	movq	-8(%rbp), %rcx
	movl	12(%rcx), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jl	.LBB58_13
# %bb.20:
	jmp	.LBB58_79
.LBB58_21:
	movq	-8(%rbp), %rax
	movl	12(%rax), %edi
	movq	-8(%rbp), %rax
	movl	8(%rax), %esi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB58_23
# %bb.22:
	jmp	.LBB58_80
.LBB58_23:
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
	je	.LBB58_25
# %bb.24:
	jmp	.LBB58_80
.LBB58_25:
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
	jne	.LBB58_27
# %bb.26:
	jmp	.LBB58_80
.LBB58_27:
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
	jae	.LBB58_31
# %bb.28:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	$0, %eax
	jl	.LBB58_31
# %bb.29:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_31
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
.LBB58_31:
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
	jae	.LBB58_35
# %bb.32:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	$0, %eax
	jl	.LBB58_35
# %bb.33:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_35
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
.LBB58_35:
	jmp	.LBB58_36
.LBB58_36:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB58_38 Depth 2
                                        #     Child Loop BB58_53 Depth 2
                                        #     Child Loop BB58_70 Depth 2
	movq	-72(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jbe	.LBB58_78
# %bb.37:                               #   in Loop: Header=BB58_36 Depth=1
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
.LBB58_38:                              #   Parent Loop BB58_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, -12(%rbp)
	movb	%al, -105(%rbp)                 # 1-byte Spill
	jl	.LBB58_40
# %bb.39:                               #   in Loop: Header=BB58_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -105(%rbp)                 # 1-byte Spill
.LBB58_40:                              #   in Loop: Header=BB58_38 Depth=2
	movb	-105(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB58_41
	jmp	.LBB58_43
.LBB58_41:                              #   in Loop: Header=BB58_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.42:                               #   in Loop: Header=BB58_38 Depth=2
	movl	-12(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB58_38
.LBB58_43:                              #   in Loop: Header=BB58_36 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.LBB58_45
# %bb.44:                               #   in Loop: Header=BB58_36 Depth=1
	jmp	.LBB58_69
.LBB58_45:                              #   in Loop: Header=BB58_36 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB58_51
# %bb.46:                               #   in Loop: Header=BB58_36 Depth=1
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
	jae	.LBB58_50
# %bb.47:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB58_50
# %bb.48:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_50
# %bb.49:                               #   in Loop: Header=BB58_36 Depth=1
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
.LBB58_50:                              #   in Loop: Header=BB58_36 Depth=1
	jmp	.LBB58_51
.LBB58_51:                              #   in Loop: Header=BB58_36 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB58_52:                              #   in Loop: Header=BB58_36 Depth=1
	jmp	.LBB58_53
.LBB58_53:                              #   Parent Loop BB58_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-44(%rbp), %ecx
	movb	%al, -121(%rbp)                 # 1-byte Spill
	jg	.LBB58_55
# %bb.54:                               #   in Loop: Header=BB58_53 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -121(%rbp)                 # 1-byte Spill
.LBB58_55:                              #   in Loop: Header=BB58_53 Depth=2
	movb	-121(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB58_56
	jmp	.LBB58_58
.LBB58_56:                              #   in Loop: Header=BB58_53 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.57:                               #   in Loop: Header=BB58_53 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB58_53
.LBB58_58:                              #   in Loop: Header=BB58_36 Depth=1
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
	jae	.LBB58_62
# %bb.59:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	$0, %eax
	jl	.LBB58_62
# %bb.60:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_62
# %bb.61:                               #   in Loop: Header=BB58_36 Depth=1
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
.LBB58_62:                              #   in Loop: Header=BB58_36 Depth=1
	movl	-12(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB58_68
# %bb.63:                               #   in Loop: Header=BB58_36 Depth=1
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
	jae	.LBB58_67
# %bb.64:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB58_67
# %bb.65:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB58_67
# %bb.66:                               #   in Loop: Header=BB58_36 Depth=1
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
.LBB58_67:                              #   in Loop: Header=BB58_36 Depth=1
	jmp	.LBB58_68
.LBB58_68:                              #   in Loop: Header=BB58_36 Depth=1
	jmp	.LBB58_69
.LBB58_69:                              #   in Loop: Header=BB58_36 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB58_70:                              #   Parent Loop BB58_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-32(%rbp), %ecx
	movb	%al, -145(%rbp)                 # 1-byte Spill
	jg	.LBB58_72
# %bb.71:                               #   in Loop: Header=BB58_70 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-40(%rbp), %eax
	setne	%al
	movb	%al, -145(%rbp)                 # 1-byte Spill
.LBB58_72:                              #   in Loop: Header=BB58_70 Depth=2
	movb	-145(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB58_73
	jmp	.LBB58_75
.LBB58_73:                              #   in Loop: Header=BB58_70 Depth=2
	jmp	.LBB58_74
.LBB58_74:                              #   in Loop: Header=BB58_70 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB58_70
.LBB58_75:                              #   in Loop: Header=BB58_36 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
# %bb.76:                               #   in Loop: Header=BB58_36 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jle	.LBB58_52
# %bb.77:                               #   in Loop: Header=BB58_36 Depth=1
	jmp	.LBB58_36
.LBB58_78:
	movq	-64(%rbp), %rdi
	callq	gdFree@PLT
.LBB58_79:
	movl	-52(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7264(%rax)
.LBB58_80:
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end58:
	.size	gdImageFill, .Lfunc_end58-gdImageFill
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
	jne	.LBB59_2
# %bb.1:
	jmp	.LBB59_70
.LBB59_2:
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
	je	.LBB59_4
# %bb.3:
	jmp	.LBB59_70
.LBB59_4:
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
	je	.LBB59_6
# %bb.5:
	jmp	.LBB59_70
.LBB59_6:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	imull	8(%rcx), %eax
	movslq	%eax, %rdi
	movl	$1, %esi
	callq	gdCalloc@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB59_8
# %bb.7:
	jmp	.LBB59_70
.LBB59_8:
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
	jne	.LBB59_10
# %bb.9:
	movq	-72(%rbp), %rdi
	callq	gdFree@PLT
	jmp	.LBB59_70
.LBB59_10:
	movq	-56(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
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
	jae	.LBB59_14
# %bb.11:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	$0, %eax
	jl	.LBB59_14
# %bb.12:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB59_14
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
.LBB59_14:
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
	jae	.LBB59_18
# %bb.15:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	$0, %eax
	jl	.LBB59_18
# %bb.16:
	movl	-16(%rbp), %eax
	addl	$1, %eax
	addl	$-1, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB59_18
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
.LBB59_18:
	jmp	.LBB59_19
.LBB59_19:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB59_21 Depth 2
                                        #     Child Loop BB59_38 Depth 2
                                        #     Child Loop BB59_59 Depth 2
	movq	-64(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jbe	.LBB59_69
# %bb.20:                               #   in Loop: Header=BB59_19 Depth=1
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
.LBB59_21:                              #   Parent Loop BB59_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, -12(%rbp)
	movb	%al, -89(%rbp)                  # 1-byte Spill
	jl	.LBB59_25
# %bb.22:                               #   in Loop: Header=BB59_21 Depth=2
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
	jne	.LBB59_24
# %bb.23:                               #   in Loop: Header=BB59_21 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -90(%rbp)                  # 1-byte Spill
.LBB59_24:                              #   in Loop: Header=BB59_21 Depth=2
	movb	-90(%rbp), %al                  # 1-byte Reload
	movb	%al, -89(%rbp)                  # 1-byte Spill
.LBB59_25:                              #   in Loop: Header=BB59_21 Depth=2
	movb	-89(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB59_26
	jmp	.LBB59_28
.LBB59_26:                              #   in Loop: Header=BB59_21 Depth=2
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
	callq	gdImageSetPixel@PLT
# %bb.27:                               #   in Loop: Header=BB59_21 Depth=2
	movl	-12(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB59_21
.LBB59_28:                              #   in Loop: Header=BB59_19 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.LBB59_30
# %bb.29:                               #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_58
.LBB59_30:                              #   in Loop: Header=BB59_19 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.LBB59_36
# %bb.31:                               #   in Loop: Header=BB59_19 Depth=1
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
	jae	.LBB59_35
# %bb.32:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB59_35
# %bb.33:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB59_35
# %bb.34:                               #   in Loop: Header=BB59_19 Depth=1
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
.LBB59_35:                              #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_36
.LBB59_36:                              #   in Loop: Header=BB59_19 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB59_37:                              #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_38
.LBB59_38:                              #   Parent Loop BB59_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-44(%rbp), %ecx
	movb	%al, -105(%rbp)                 # 1-byte Spill
	jge	.LBB59_42
# %bb.39:                               #   in Loop: Header=BB59_38 Depth=2
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
	jne	.LBB59_41
# %bb.40:                               #   in Loop: Header=BB59_38 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-40(%rbp), %eax
	sete	%al
	movb	%al, -106(%rbp)                 # 1-byte Spill
.LBB59_41:                              #   in Loop: Header=BB59_38 Depth=2
	movb	-106(%rbp), %al                 # 1-byte Reload
	movb	%al, -105(%rbp)                 # 1-byte Spill
.LBB59_42:                              #   in Loop: Header=BB59_38 Depth=2
	movb	-105(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB59_43
	jmp	.LBB59_47
.LBB59_43:                              #   in Loop: Header=BB59_38 Depth=2
	movq	-72(%rbp), %rax
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	imull	-48(%rbp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB59_45
# %bb.44:                               #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_47
.LBB59_45:                              #   in Loop: Header=BB59_38 Depth=2
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
	callq	gdImageSetPixel@PLT
# %bb.46:                               #   in Loop: Header=BB59_38 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB59_38
.LBB59_47:                              #   in Loop: Header=BB59_19 Depth=1
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
	jae	.LBB59_51
# %bb.48:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	$0, %eax
	jl	.LBB59_51
# %bb.49:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-16(%rbp), %eax
	addl	-36(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB59_51
# %bb.50:                               #   in Loop: Header=BB59_19 Depth=1
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
.LBB59_51:                              #   in Loop: Header=BB59_19 Depth=1
	movl	-12(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	$1, %ecx
	cmpl	%ecx, %eax
	jle	.LBB59_57
# %bb.52:                               #   in Loop: Header=BB59_19 Depth=1
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
	jae	.LBB59_56
# %bb.53:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	$0, %eax
	jl	.LBB59_56
# %bb.54:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-16(%rbp), %eax
	xorl	%ecx, %ecx
	subl	-36(%rbp), %ecx
	addl	%ecx, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB59_56
# %bb.55:                               #   in Loop: Header=BB59_19 Depth=1
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
.LBB59_56:                              #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_57
.LBB59_57:                              #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_58
.LBB59_58:                              #   in Loop: Header=BB59_19 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB59_59:                              #   Parent Loop BB59_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	-32(%rbp), %ecx
	movb	%al, -129(%rbp)                 # 1-byte Spill
	jg	.LBB59_63
# %bb.60:                               #   in Loop: Header=BB59_59 Depth=2
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
	jne	.LBB59_62
# %bb.61:                               #   in Loop: Header=BB59_59 Depth=2
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	cmpl	-40(%rbp), %eax
	setne	%al
	movb	%al, -130(%rbp)                 # 1-byte Spill
.LBB59_62:                              #   in Loop: Header=BB59_59 Depth=2
	movb	-130(%rbp), %al                 # 1-byte Reload
	movb	%al, -129(%rbp)                 # 1-byte Spill
.LBB59_63:                              #   in Loop: Header=BB59_59 Depth=2
	movb	-129(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB59_64
	jmp	.LBB59_66
.LBB59_64:                              #   in Loop: Header=BB59_59 Depth=2
	jmp	.LBB59_65
.LBB59_65:                              #   in Loop: Header=BB59_59 Depth=2
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB59_59
.LBB59_66:                              #   in Loop: Header=BB59_19 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
# %bb.67:                               #   in Loop: Header=BB59_19 Depth=1
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jle	.LBB59_37
# %bb.68:                               #   in Loop: Header=BB59_19 Depth=1
	jmp	.LBB59_19
.LBB59_69:
	movq	-72(%rbp), %rdi
	callq	gdFree@PLT
	movq	-56(%rbp), %rdi
	callq	gdFree@PLT
.LBB59_70:
	addq	$144, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end59:
	.size	_gdImageFillTiled, .Lfunc_end59-_gdImageFillTiled
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
	subq	$80, %rsp
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
	jne	.LBB60_4
# %bb.1:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB60_4
# %bb.2:
	cmpl	$1, -32(%rbp)
	jne	.LBB60_4
# %bb.3:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB60_39
.LBB60_4:
	movl	-24(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB60_6
# %bb.5:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB60_6:
	movl	-20(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB60_8
# %bb.7:
	movl	-12(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB60_8:
	cmpl	$1, -32(%rbp)
	jle	.LBB60_34
# %bb.9:
	movl	-32(%rbp), %eax
	sarl	$1, %eax
	movl	%eax, -68(%rbp)
	movl	-12(%rbp), %eax
	subl	-68(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	subl	-68(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-20(%rbp), %eax
	addl	-68(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-24(%rbp), %eax
	addl	-68(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-56(%rbp), %eax
	addl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB60_10:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_12 Depth 2
	movl	-48(%rbp), %eax
	movl	%eax, %ecx
	addl	$-1, %ecx
	movl	%ecx, -48(%rbp)
	cmpl	-56(%rbp), %eax
	jle	.LBB60_15
# %bb.11:                               #   in Loop: Header=BB60_10 Depth=1
	movl	-52(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB60_12:                              #   Parent Loop BB60_10 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	cmpl	-60(%rbp), %eax
	jge	.LBB60_14
# %bb.13:                               #   in Loop: Header=BB60_12 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB60_12
.LBB60_14:                              #   in Loop: Header=BB60_10 Depth=1
	jmp	.LBB60_10
.LBB60_15:
	movl	-64(%rbp), %eax
	subl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB60_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_18 Depth 2
	movl	-48(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -48(%rbp)
	cmpl	-64(%rbp), %eax
	jge	.LBB60_21
# %bb.17:                               #   in Loop: Header=BB60_16 Depth=1
	movl	-52(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB60_18:                              #   Parent Loop BB60_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	cmpl	-60(%rbp), %eax
	jge	.LBB60_20
# %bb.19:                               #   in Loop: Header=BB60_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB60_18
.LBB60_20:                              #   in Loop: Header=BB60_16 Depth=1
	jmp	.LBB60_16
.LBB60_21:
	movl	-56(%rbp), %eax
	addl	-32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
.LBB60_22:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_24 Depth 2
	movl	-48(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -48(%rbp)
	movl	-64(%rbp), %ecx
	subl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB60_27
# %bb.23:                               #   in Loop: Header=BB60_22 Depth=1
	movl	-52(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB60_24:                              #   Parent Loop BB60_22 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	movl	-52(%rbp), %ecx
	addl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB60_26
# %bb.25:                               #   in Loop: Header=BB60_24 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB60_24
.LBB60_26:                              #   in Loop: Header=BB60_22 Depth=1
	jmp	.LBB60_22
.LBB60_27:
	movl	-56(%rbp), %eax
	addl	-32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -48(%rbp)
.LBB60_28:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_30 Depth 2
	movl	-48(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -48(%rbp)
	movl	-64(%rbp), %ecx
	subl	-32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB60_33
# %bb.29:                               #   in Loop: Header=BB60_28 Depth=1
	movl	-60(%rbp), %eax
	subl	-32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -44(%rbp)
.LBB60_30:                              #   Parent Loop BB60_28 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -44(%rbp)
	cmpl	-60(%rbp), %eax
	jge	.LBB60_32
# %bb.31:                               #   in Loop: Header=BB60_30 Depth=2
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB60_30
.LBB60_32:                              #   in Loop: Header=BB60_28 Depth=1
	jmp	.LBB60_28
.LBB60_33:
	jmp	.LBB60_39
.LBB60_34:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB60_36
# %bb.35:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB60_37
.LBB60_36:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine@PLT
	jmp	.LBB60_38
.LBB60_37:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-16(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine@PLT
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-24(%rbp), %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine@PLT
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	movl	-12(%rbp), %ecx
	movl	-24(%rbp), %r8d
	subl	$1, %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine@PLT
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-16(%rbp), %edx
	addl	$1, %edx
	movl	-20(%rbp), %ecx
	movl	-24(%rbp), %r8d
	subl	$1, %r8d
	movl	-28(%rbp), %r9d
	callq	gdImageLine@PLT
.LBB60_38:
	jmp	.LBB60_39
.LBB60_39:
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end60:
	.size	gdImageRectangle, .Lfunc_end60-gdImageRectangle
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
	subq	$32, %rsp
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
	callq	_gdImageFilledVRectangle
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end61:
	.size	gdImageFilledRectangle, .Lfunc_end61-gdImageFilledRectangle
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gdImageFilledVRectangle
	.type	_gdImageFilledVRectangle,@function
_gdImageFilledVRectangle:               # @_gdImageFilledVRectangle
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
	jne	.LBB62_3
# %bb.1:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB62_3
# %bb.2:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB62_23
.LBB62_3:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.LBB62_5
# %bb.4:
	movl	-12(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB62_5:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.LBB62_7
# %bb.6:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB62_7:
	cmpl	$0, -12(%rbp)
	jge	.LBB62_9
# %bb.8:
	movl	$0, -12(%rbp)
.LBB62_9:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB62_11
# %bb.10:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -20(%rbp)
.LBB62_11:
	cmpl	$0, -16(%rbp)
	jge	.LBB62_13
# %bb.12:
	movl	$0, -16(%rbp)
.LBB62_13:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB62_15
# %bb.14:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -24(%rbp)
.LBB62_15:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
.LBB62_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB62_18 Depth 2
	movl	-36(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jg	.LBB62_23
# %bb.17:                               #   in Loop: Header=BB62_16 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -32(%rbp)
.LBB62_18:                              #   Parent Loop BB62_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB62_21
# %bb.19:                               #   in Loop: Header=BB62_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.20:                               #   in Loop: Header=BB62_18 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB62_18
.LBB62_21:                              #   in Loop: Header=BB62_16 Depth=1
	jmp	.LBB62_22
.LBB62_22:                              #   in Loop: Header=BB62_16 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB62_16
.LBB62_23:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end62:
	.size	_gdImageFilledVRectangle, .Lfunc_end62-_gdImageFilledVRectangle
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
	je	.LBB63_2
# %bb.1:
	movq	-16(%rbp), %rax
	movl	8(%rax), %edi
	movq	-16(%rbp), %rax
	movl	12(%rax), %esi
	callq	gdImageCreateTrueColor@PLT
	movq	%rax, -24(%rbp)
	jmp	.LBB63_3
.LBB63_2:
	movq	-16(%rbp), %rax
	movl	8(%rax), %edi
	movq	-16(%rbp), %rax
	movl	12(%rax), %esi
	callq	gdImageCreate@PLT
	movq	%rax, -24(%rbp)
.LBB63_3:
	cmpq	$0, -24(%rbp)
	jne	.LBB63_5
# %bb.4:
	movq	$0, -8(%rbp)
	jmp	.LBB63_45
.LBB63_5:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB63_19
# %bb.6:
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 16(%rax)
	movl	$0, -28(%rbp)
.LBB63_7:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -28(%rbp)                 # imm = 0x100
	jge	.LBB63_10
# %bb.8:                                #   in Loop: Header=BB63_7 Depth=1
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
# %bb.9:                                #   in Loop: Header=BB63_7 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB63_7
.LBB63_10:
	movl	$0, -28(%rbp)
.LBB63_11:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB63_13 Depth 2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB63_18
# %bb.12:                               #   in Loop: Header=BB63_11 Depth=1
	movl	$0, -32(%rbp)
.LBB63_13:                              #   Parent Loop BB63_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB63_16
# %bb.14:                               #   in Loop: Header=BB63_13 Depth=2
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
# %bb.15:                               #   in Loop: Header=BB63_13 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB63_13
.LBB63_16:                              #   in Loop: Header=BB63_11 Depth=1
	jmp	.LBB63_17
.LBB63_17:                              #   in Loop: Header=BB63_11 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB63_11
.LBB63_18:
	jmp	.LBB63_28
.LBB63_19:
	movl	$0, -28(%rbp)
.LBB63_20:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB63_22 Depth 2
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB63_27
# %bb.21:                               #   in Loop: Header=BB63_20 Depth=1
	movl	$0, -32(%rbp)
.LBB63_22:                              #   Parent Loop BB63_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB63_25
# %bb.23:                               #   in Loop: Header=BB63_22 Depth=2
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
# %bb.24:                               #   in Loop: Header=BB63_22 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB63_22
.LBB63_25:                              #   in Loop: Header=BB63_20 Depth=1
	jmp	.LBB63_26
.LBB63_26:                              #   in Loop: Header=BB63_20 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB63_20
.LBB63_27:
	jmp	.LBB63_28
.LBB63_28:
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
	movl	7304(%rax), %ecx
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
	je	.LBB63_30
# %bb.29:
	movq	-16(%rbp), %rax
	movq	4136(%rax), %rdi
	callq	gdImageClone@PLT
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 4136(%rax)
.LBB63_30:
	movq	-16(%rbp), %rax
	cmpq	$0, 4144(%rax)
	je	.LBB63_32
# %bb.31:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rdi
	callq	gdImageClone@PLT
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 4144(%rax)
.LBB63_32:
	movq	-16(%rbp), %rax
	cmpq	$0, 6208(%rax)
	je	.LBB63_34
# %bb.33:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	6208(%rax), %rsi
	movq	-16(%rbp), %rax
	movl	6200(%rax), %edx
	callq	gdImageSetStyle@PLT
	movq	-16(%rbp), %rax
	movl	6204(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 6204(%rax)
.LBB63_34:
	movl	$0, -28(%rbp)
.LBB63_35:                              # =>This Inner Loop Header: Depth=1
	cmpl	$256, -28(%rbp)                 # imm = 0x100
	jge	.LBB63_38
# %bb.36:                               #   in Loop: Header=BB63_35 Depth=1
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
# %bb.37:                               #   in Loop: Header=BB63_35 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB63_35
.LBB63_38:
	movq	-16(%rbp), %rax
	cmpl	$0, 4128(%rax)
	jle	.LBB63_44
# %bb.39:
	movq	-16(%rbp), %rax
	movl	4128(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 4128(%rax)
	movl	$0, -28(%rbp)
.LBB63_40:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4128(%rcx), %eax
	jge	.LBB63_43
# %bb.41:                               #   in Loop: Header=BB63_40 Depth=1
	movq	-16(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movq	4120(%rax), %rax
	movslq	-28(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.42:                               #   in Loop: Header=BB63_40 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB63_40
.LBB63_43:
	jmp	.LBB63_44
.LBB63_44:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB63_45:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end63:
	.size	gdImageClone, .Lfunc_end63-gdImageClone
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
	je	.LBB64_2
# %bb.1:
	movq	-8(%rbp), %rax
	movq	6208(%rax), %rdi
	callq	gdFree@PLT
.LBB64_2:
	movl	-20(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB64_4
# %bb.3:
	jmp	.LBB64_7
.LBB64_4:
	movslq	-20(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 6208(%rax)
	movq	-8(%rbp), %rax
	cmpq	$0, 6208(%rax)
	jne	.LBB64_6
# %bb.5:
	jmp	.LBB64_7
.LBB64_6:
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
.LBB64_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end64:
	.size	gdImageSetStyle, .Lfunc_end64-gdImageSetStyle
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
	je	.LBB65_25
# %bb.1:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_13
# %bb.2:
	movl	$0, -44(%rbp)
.LBB65_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB65_5 Depth 2
	movl	-44(%rbp), %eax
	cmpl	24(%rbp), %eax
	jge	.LBB65_12
# %bb.4:                                #   in Loop: Header=BB65_3 Depth=1
	movl	$0, -40(%rbp)
.LBB65_5:                               #   Parent Loop BB65_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	cmpl	16(%rbp), %eax
	jge	.LBB65_10
# %bb.6:                                #   in Loop: Header=BB65_5 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-32(%rbp), %edx
	addl	-44(%rbp), %edx
	callq	gdImageGetTrueColorPixel@PLT
	movl	%eax, -1092(%rbp)
	movl	-1092(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB65_8
# %bb.7:                                #   in Loop: Header=BB65_5 Depth=2
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-24(%rbp), %edx
	addl	-44(%rbp), %edx
	movl	-1092(%rbp), %ecx
	callq	gdImageSetPixel@PLT
.LBB65_8:                               #   in Loop: Header=BB65_5 Depth=2
	jmp	.LBB65_9
.LBB65_9:                               #   in Loop: Header=BB65_5 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB65_5
.LBB65_10:                              #   in Loop: Header=BB65_3 Depth=1
	jmp	.LBB65_11
.LBB65_11:                              #   in Loop: Header=BB65_3 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB65_3
.LBB65_12:
	jmp	.LBB65_24
.LBB65_13:
	movl	$0, -44(%rbp)
.LBB65_14:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB65_16 Depth 2
	movl	-44(%rbp), %eax
	cmpl	24(%rbp), %eax
	jge	.LBB65_23
# %bb.15:                               #   in Loop: Header=BB65_14 Depth=1
	movl	$0, -40(%rbp)
.LBB65_16:                              #   Parent Loop BB65_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	cmpl	16(%rbp), %eax
	jge	.LBB65_21
# %bb.17:                               #   in Loop: Header=BB65_16 Depth=2
	movq	-16(%rbp), %rdi
	movl	-28(%rbp), %esi
	addl	-40(%rbp), %esi
	movl	-32(%rbp), %edx
	addl	-44(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -1096(%rbp)
	movl	-1096(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB65_19
# %bb.18:                               #   in Loop: Header=BB65_16 Depth=2
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
	callq	gdImageSetPixel@PLT
.LBB65_19:                              #   in Loop: Header=BB65_16 Depth=2
	jmp	.LBB65_20
.LBB65_20:                              #   in Loop: Header=BB65_16 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB65_16
.LBB65_21:                              #   in Loop: Header=BB65_14 Depth=1
	jmp	.LBB65_22
.LBB65_22:                              #   in Loop: Header=BB65_14 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB65_14
.LBB65_23:
	jmp	.LBB65_24
.LBB65_24:
	jmp	.LBB65_48
.LBB65_25:
	movl	$0, -56(%rbp)
.LBB65_26:                              # =>This Inner Loop Header: Depth=1
	cmpl	$256, -56(%rbp)                 # imm = 0x100
	jge	.LBB65_29
# %bb.27:                               #   in Loop: Header=BB65_26 Depth=1
	movslq	-56(%rbp), %rax
	movl	$-1, -1088(%rbp,%rax,4)
# %bb.28:                               #   in Loop: Header=BB65_26 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB65_26
.LBB65_29:
	movl	-24(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB65_30:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB65_32 Depth 2
	movl	-44(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB65_48
# %bb.31:                               #   in Loop: Header=BB65_30 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB65_32:                              #   Parent Loop BB65_30 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-40(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB65_46
# %bb.33:                               #   in Loop: Header=BB65_32 Depth=2
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB65_35
# %bb.34:                               #   in Loop: Header=BB65_32 Depth=2
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB65_45
.LBB65_35:                              #   in Loop: Header=BB65_32 Depth=2
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB65_37
# %bb.36:                               #   in Loop: Header=BB65_32 Depth=2
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
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -1104(%rbp)
	jmp	.LBB65_44
.LBB65_37:                              #   in Loop: Header=BB65_32 Depth=2
	movslq	-36(%rbp), %rax
	cmpl	$-1, -1088(%rbp,%rax,4)
	jne	.LBB65_42
# %bb.38:                               #   in Loop: Header=BB65_32 Depth=2
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB65_40
# %bb.39:                               #   in Loop: Header=BB65_32 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -1100(%rbp)
	jmp	.LBB65_41
.LBB65_40:                              #   in Loop: Header=BB65_32 Depth=2
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
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -1100(%rbp)
.LBB65_41:                              #   in Loop: Header=BB65_32 Depth=2
	movl	-1100(%rbp), %ecx
	movslq	-36(%rbp), %rax
	movl	%ecx, -1088(%rbp,%rax,4)
	movslq	-36(%rbp), %rax
	movl	-1088(%rbp,%rax,4), %eax
	movl	%eax, -1104(%rbp)
	jmp	.LBB65_43
.LBB65_42:                              #   in Loop: Header=BB65_32 Depth=2
	movslq	-36(%rbp), %rax
	movl	-1088(%rbp,%rax,4), %eax
	movl	%eax, -1104(%rbp)
.LBB65_43:                              #   in Loop: Header=BB65_32 Depth=2
	jmp	.LBB65_44
.LBB65_44:                              #   in Loop: Header=BB65_32 Depth=2
	movq	-8(%rbp), %rdi
	movl	-48(%rbp), %esi
	movl	-52(%rbp), %edx
	movl	-1104(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
.LBB65_45:                              #   in Loop: Header=BB65_32 Depth=2
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB65_32
.LBB65_46:                              #   in Loop: Header=BB65_30 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.47:                               #   in Loop: Header=BB65_30 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB65_30
.LBB65_48:
	addq	$1104, %rsp                     # imm = 0x450
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end65:
	.size	gdImageCopy, .Lfunc_end65-gdImageCopy
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyMerge
.LCPI66_0:
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
.LBB66_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB66_3 Depth 2
	movl	-48(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB66_31
# %bb.2:                                #   in Loop: Header=BB66_1 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB66_3:                               #   Parent Loop BB66_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB66_29
# %bb.4:                                #   in Loop: Header=BB66_3 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB66_6
# %bb.5:                                #   in Loop: Header=BB66_3 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB66_28
.LBB66_6:                               #   in Loop: Header=BB66_3 Depth=2
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB66_8
# %bb.7:                                #   in Loop: Header=BB66_3 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -72(%rbp)
	jmp	.LBB66_27
.LBB66_8:                               #   in Loop: Header=BB66_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_10
# %bb.9:                                #   in Loop: Header=BB66_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	jmp	.LBB66_11
.LBB66_10:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
.LBB66_11:                              #   in Loop: Header=BB66_3 Depth=2
	movl	-76(%rbp), %eax                 # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -96(%rbp)                # 8-byte Spill
	cvtsi2sdl	32(%rbp), %xmm0
	movsd	.LCPI66_0(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -88(%rbp)                # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_13
# %bb.12:                               #   in Loop: Header=BB66_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	jmp	.LBB66_14
.LBB66_13:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
.LBB66_14:                              #   in Loop: Header=BB66_3 Depth=2
	movsd	-88(%rbp), %xmm2                # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	-96(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-100(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI66_0(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_16
# %bb.15:                               #   in Loop: Header=BB66_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -104(%rbp)                # 4-byte Spill
	jmp	.LBB66_17
.LBB66_16:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -104(%rbp)                # 4-byte Spill
.LBB66_17:                              #   in Loop: Header=BB66_3 Depth=2
	movl	-104(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -120(%rbp)               # 8-byte Spill
	cvtsi2sdl	32(%rbp), %xmm0
	movsd	.LCPI66_0(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -112(%rbp)               # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_19
# %bb.18:                               #   in Loop: Header=BB66_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
	jmp	.LBB66_20
.LBB66_19:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
.LBB66_20:                              #   in Loop: Header=BB66_3 Depth=2
	movsd	-112(%rbp), %xmm2               # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	-120(%rbp), %xmm0               # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-124(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI66_0(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -64(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_22
# %bb.21:                               #   in Loop: Header=BB66_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -128(%rbp)                # 4-byte Spill
	jmp	.LBB66_23
.LBB66_22:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -128(%rbp)                # 4-byte Spill
.LBB66_23:                              #   in Loop: Header=BB66_3 Depth=2
	movl	-128(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -144(%rbp)               # 8-byte Spill
	cvtsi2sdl	32(%rbp), %xmm0
	movsd	.LCPI66_0(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -136(%rbp)               # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB66_25
# %bb.24:                               #   in Loop: Header=BB66_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -148(%rbp)                # 4-byte Spill
	jmp	.LBB66_26
.LBB66_25:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -148(%rbp)                # 4-byte Spill
.LBB66_26:                              #   in Loop: Header=BB66_3 Depth=2
	movsd	-136(%rbp), %xmm2               # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	-144(%rbp), %xmm0               # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-148(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI66_0(%rip), %xmm4          # xmm4 = mem[0],zero
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
	callq	gdImageColorResolve@PLT
	movl	%eax, -72(%rbp)
.LBB66_27:                              #   in Loop: Header=BB66_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-72(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
.LBB66_28:                              #   in Loop: Header=BB66_3 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB66_3
.LBB66_29:                              #   in Loop: Header=BB66_1 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.30:                               #   in Loop: Header=BB66_1 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB66_1
.LBB66_31:
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end66:
	.size	gdImageCopyMerge, .Lfunc_end66-gdImageCopyMerge
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyMergeGray
.LCPI67_0:
	.quad	0x3fd322d0e5604189              # double 0.29899999999999999
.LCPI67_1:
	.quad	0x3fe2c8b439581062              # double 0.58699999999999997
.LCPI67_2:
	.quad	0x3fbd2f1a9fbe76c9              # double 0.114
.LCPI67_3:
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
.LBB67_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB67_3 Depth 2
	movl	-48(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB67_36
# %bb.2:                                #   in Loop: Header=BB67_1 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB67_3:                               #   Parent Loop BB67_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB67_34
# %bb.4:                                #   in Loop: Header=BB67_3 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB67_6
# %bb.5:                                #   in Loop: Header=BB67_3 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB67_33
.LBB67_6:                               #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB67_9
# %bb.7:                                #   in Loop: Header=BB67_3 Depth=2
	cmpl	$100, 32(%rbp)
	jne	.LBB67_9
# %bb.8:                                #   in Loop: Header=BB67_3 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB67_32
.LBB67_9:                               #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -40(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_11
# %bb.10:                               #   in Loop: Header=BB67_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
	jmp	.LBB67_12
.LBB67_11:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
.LBB67_12:                              #   in Loop: Header=BB67_3 Depth=2
	movl	-80(%rbp), %eax                 # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	%xmm0, -88(%rbp)                # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_14
# %bb.13:                               #   in Loop: Header=BB67_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
	jmp	.LBB67_15
.LBB67_14:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
.LBB67_15:                              #   in Loop: Header=BB67_3 Depth=2
	movsd	-88(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movl	-92(%rbp), %eax                 # 4-byte Reload
	cvtsi2sd	%eax, %xmm2
	movsd	.LCPI67_1(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm2, %xmm1
	movsd	.LCPI67_0(%rip), %xmm2          # xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)               # 8-byte Spill
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_17
# %bb.16:                               #   in Loop: Header=BB67_3 Depth=2
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	jmp	.LBB67_18
.LBB67_17:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
.LBB67_18:                              #   in Loop: Header=BB67_3 Depth=2
	movsd	-104(%rbp), %xmm1               # 8-byte Reload
                                        # xmm1 = mem[0],zero
	movl	-108(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	movsd	.LCPI67_2(%rip), %xmm2          # xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -72(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_20
# %bb.19:                               #   in Loop: Header=BB67_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -112(%rbp)                # 4-byte Spill
	jmp	.LBB67_21
.LBB67_20:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -112(%rbp)                # 4-byte Spill
.LBB67_21:                              #   in Loop: Header=BB67_3 Depth=2
	movl	-112(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	32(%rbp), %xmm2
	movsd	.LCPI67_3(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm2
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI67_3(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -60(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_23
# %bb.22:                               #   in Loop: Header=BB67_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
	jmp	.LBB67_24
.LBB67_23:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
.LBB67_24:                              #   in Loop: Header=BB67_3 Depth=2
	movl	-116(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	32(%rbp), %xmm2
	movsd	.LCPI67_3(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm2
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI67_3(%rip), %xmm4          # xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	mulsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %eax
	movl	%eax, -64(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB67_26
# %bb.25:                               #   in Loop: Header=BB67_3 Depth=2
	movl	-36(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
	jmp	.LBB67_27
.LBB67_26:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
.LBB67_27:                              #   in Loop: Header=BB67_3 Depth=2
	movl	-120(%rbp), %eax                # 4-byte Reload
	cvtsi2sd	%eax, %xmm0
	cvtsi2sdl	32(%rbp), %xmm2
	movsd	.LCPI67_3(%rip), %xmm1          # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm2
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movl	$100, %eax
	subl	32(%rbp), %eax
	cvtsi2sd	%eax, %xmm3
	movsd	.LCPI67_3(%rip), %xmm4          # xmm4 = mem[0],zero
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
	callq	gdImageColorExact@PLT
	movl	%eax, -76(%rbp)
	cmpl	$-1, -76(%rbp)
	jne	.LBB67_31
# %bb.28:                               #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageColorAllocate@PLT
	movl	%eax, -76(%rbp)
	cmpl	$-1, -76(%rbp)
	jne	.LBB67_30
# %bb.29:                               #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	movl	-68(%rbp), %ecx
	callq	gdImageColorClosest@PLT
	movl	%eax, -76(%rbp)
.LBB67_30:                              #   in Loop: Header=BB67_3 Depth=2
	jmp	.LBB67_31
.LBB67_31:                              #   in Loop: Header=BB67_3 Depth=2
	jmp	.LBB67_32
.LBB67_32:                              #   in Loop: Header=BB67_3 Depth=2
	movq	-8(%rbp), %rdi
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %edx
	movl	-76(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
.LBB67_33:                              #   in Loop: Header=BB67_3 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB67_3
.LBB67_34:                              #   in Loop: Header=BB67_1 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
# %bb.35:                               #   in Loop: Header=BB67_1 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB67_1
.LBB67_36:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end67:
	.size	gdImageCopyMergeGray, .Lfunc_end67-gdImageCopyMergeGray
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
	je	.LBB68_2
# %bb.1:
	jmp	.LBB68_71
.LBB68_2:
	movl	40(%rbp), %esi
	movl	$4, %edi
	callq	overflow2@PLT
	cmpl	$0, %eax
	je	.LBB68_4
# %bb.3:
	jmp	.LBB68_71
.LBB68_4:
	movslq	32(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -1096(%rbp)
	cmpq	$0, -1096(%rbp)
	jne	.LBB68_6
# %bb.5:
	jmp	.LBB68_71
.LBB68_6:
	movslq	40(%rbp), %rdi
	shlq	$2, %rdi
	callq	gdMalloc@PLT
	movq	%rax, -1104(%rbp)
	cmpq	$0, -1104(%rbp)
	jne	.LBB68_8
# %bb.7:
	movq	-1096(%rbp), %rdi
	callq	gdFree@PLT
	jmp	.LBB68_71
.LBB68_8:
	movl	$0, -60(%rbp)
.LBB68_9:                               # =>This Inner Loop Header: Depth=1
	movl	-60(%rbp), %eax
	cmpl	32(%rbp), %eax
	jge	.LBB68_12
# %bb.10:                               #   in Loop: Header=BB68_9 Depth=1
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
# %bb.11:                               #   in Loop: Header=BB68_9 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB68_9
.LBB68_12:
	movl	$0, -60(%rbp)
.LBB68_13:                              # =>This Inner Loop Header: Depth=1
	movl	-60(%rbp), %eax
	cmpl	40(%rbp), %eax
	jge	.LBB68_16
# %bb.14:                               #   in Loop: Header=BB68_13 Depth=1
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
# %bb.15:                               #   in Loop: Header=BB68_13 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB68_13
.LBB68_16:
	movl	$0, -60(%rbp)
.LBB68_17:                              # =>This Inner Loop Header: Depth=1
	cmpl	$256, -60(%rbp)                 # imm = 0x100
	jge	.LBB68_20
# %bb.18:                               #   in Loop: Header=BB68_17 Depth=1
	movslq	-60(%rbp), %rax
	movl	$-1, -1088(%rbp,%rax,4)
# %bb.19:                               #   in Loop: Header=BB68_17 Depth=1
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB68_17
.LBB68_20:
	movl	-24(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB68_21:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB68_23 Depth 2
                                        #       Child Loop BB68_25 Depth 3
                                        #         Child Loop BB68_61 Depth 4
	movl	-44(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	40(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB68_70
# %bb.22:                               #   in Loop: Header=BB68_21 Depth=1
	movl	$0, -56(%rbp)
.LBB68_23:                              #   Parent Loop BB68_21 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB68_25 Depth 3
                                        #         Child Loop BB68_61 Depth 4
	movl	-56(%rbp), %eax
	movq	-1104(%rbp), %rcx
	movl	-44(%rbp), %edx
	subl	-32(%rbp), %edx
	movslq	%edx, %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jge	.LBB68_68
# %bb.24:                               #   in Loop: Header=BB68_23 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -40(%rbp)
.LBB68_25:                              #   Parent Loop BB68_21 Depth=1
                                        #     Parent Loop BB68_23 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB68_61 Depth 4
	movl	-40(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	32(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB68_66
# %bb.26:                               #   in Loop: Header=BB68_25 Depth=3
	movl	$0, -1108(%rbp)
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	cmpl	$0, (%rax,%rcx,4)
	jne	.LBB68_28
# %bb.27:                               #   in Loop: Header=BB68_25 Depth=3
	jmp	.LBB68_65
.LBB68_28:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB68_37
# %bb.29:                               #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB68_33
# %bb.30:                               #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -1116(%rbp)
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetTrueColorPixel@PLT
	movl	%eax, -1112(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-1116(%rbp), %eax
	jne	.LBB68_32
# %bb.31:                               #   in Loop: Header=BB68_25 Depth=3
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB68_65
.LBB68_32:                              #   in Loop: Header=BB68_25 Depth=3
	jmp	.LBB68_36
.LBB68_33:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetTrueColorPixel@PLT
	movl	%eax, -1112(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-1112(%rbp), %eax
	jne	.LBB68_35
# %bb.34:                               #   in Loop: Header=BB68_25 Depth=3
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB68_65
.LBB68_35:                              #   in Loop: Header=BB68_25 Depth=3
	jmp	.LBB68_36
.LBB68_36:                              #   in Loop: Header=BB68_25 Depth=3
	jmp	.LBB68_60
.LBB68_37:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rdi
	movl	-40(%rbp), %esi
	movl	-44(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB68_39
# %bb.38:                               #   in Loop: Header=BB68_25 Depth=3
	movq	-1096(%rbp), %rax
	movl	-40(%rbp), %ecx
	subl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-48(%rbp), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB68_65
.LBB68_39:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB68_41
# %bb.40:                               #   in Loop: Header=BB68_25 Depth=3
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
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -1112(%rbp)
	jmp	.LBB68_59
.LBB68_41:                              #   in Loop: Header=BB68_25 Depth=3
	movslq	-36(%rbp), %rax
	cmpl	$-1, -1088(%rbp,%rax,4)
	jne	.LBB68_58
# %bb.42:                               #   in Loop: Header=BB68_25 Depth=3
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB68_44
# %bb.43:                               #   in Loop: Header=BB68_25 Depth=3
	movl	-36(%rbp), %eax
	movl	%eax, -1108(%rbp)
	jmp	.LBB68_57
.LBB68_44:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-8(%rbp), %rax
	movq	%rax, -1136(%rbp)               # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB68_46
# %bb.45:                               #   in Loop: Header=BB68_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -1140(%rbp)               # 4-byte Spill
	jmp	.LBB68_47
.LBB68_46:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -1140(%rbp)               # 4-byte Spill
.LBB68_47:                              #   in Loop: Header=BB68_25 Depth=3
	movl	-1140(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1144(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB68_49
# %bb.48:                               #   in Loop: Header=BB68_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -1148(%rbp)               # 4-byte Spill
	jmp	.LBB68_50
.LBB68_49:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -1148(%rbp)               # 4-byte Spill
.LBB68_50:                              #   in Loop: Header=BB68_25 Depth=3
	movl	-1148(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1152(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB68_52
# %bb.51:                               #   in Loop: Header=BB68_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -1156(%rbp)               # 4-byte Spill
	jmp	.LBB68_53
.LBB68_52:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -1156(%rbp)               # 4-byte Spill
.LBB68_53:                              #   in Loop: Header=BB68_25 Depth=3
	movl	-1156(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1160(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB68_55
# %bb.54:                               #   in Loop: Header=BB68_25 Depth=3
	movl	-36(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -1164(%rbp)               # 4-byte Spill
	jmp	.LBB68_56
.LBB68_55:                              #   in Loop: Header=BB68_25 Depth=3
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -1164(%rbp)               # 4-byte Spill
.LBB68_56:                              #   in Loop: Header=BB68_25 Depth=3
	movl	-1160(%rbp), %ecx               # 4-byte Reload
	movl	-1152(%rbp), %edx               # 4-byte Reload
	movl	-1144(%rbp), %esi               # 4-byte Reload
	movq	-1136(%rbp), %rdi               # 8-byte Reload
	movl	-1164(%rbp), %r8d               # 4-byte Reload
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -1108(%rbp)
.LBB68_57:                              #   in Loop: Header=BB68_25 Depth=3
	movl	-1108(%rbp), %ecx
	movslq	-36(%rbp), %rax
	movl	%ecx, -1088(%rbp,%rax,4)
.LBB68_58:                              #   in Loop: Header=BB68_25 Depth=3
	movslq	-36(%rbp), %rax
	movl	-1088(%rbp,%rax,4), %eax
	movl	%eax, -1112(%rbp)
.LBB68_59:                              #   in Loop: Header=BB68_25 Depth=3
	jmp	.LBB68_60
.LBB68_60:                              #   in Loop: Header=BB68_25 Depth=3
	movl	$0, -60(%rbp)
.LBB68_61:                              #   Parent Loop BB68_21 Depth=1
                                        #     Parent Loop BB68_23 Depth=2
                                        #       Parent Loop BB68_25 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-60(%rbp), %eax
	movq	-1096(%rbp), %rcx
	movl	-40(%rbp), %edx
	subl	-28(%rbp), %edx
	movslq	%edx, %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jge	.LBB68_64
# %bb.62:                               #   in Loop: Header=BB68_61 Depth=4
	movq	-8(%rbp), %rdi
	movl	-48(%rbp), %esi
	movl	-52(%rbp), %edx
	movl	-1112(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
# %bb.63:                               #   in Loop: Header=BB68_61 Depth=4
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB68_61
.LBB68_64:                              #   in Loop: Header=BB68_25 Depth=3
	jmp	.LBB68_65
.LBB68_65:                              #   in Loop: Header=BB68_25 Depth=3
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB68_25
.LBB68_66:                              #   in Loop: Header=BB68_23 Depth=2
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
# %bb.67:                               #   in Loop: Header=BB68_23 Depth=2
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB68_23
.LBB68_68:                              #   in Loop: Header=BB68_21 Depth=1
	jmp	.LBB68_69
.LBB68_69:                              #   in Loop: Header=BB68_21 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB68_21
.LBB68_70:
	movq	-1096(%rbp), %rdi
	callq	gdFree@PLT
	movq	-1104(%rbp), %rdi
	callq	gdFree@PLT
.LBB68_71:
	addq	$1168, %rsp                     # imm = 0x490
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end68:
	.size	gdImageCopyResized, .Lfunc_end68-gdImageCopyResized
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gdImageCopyRotated
.LCPI69_0:
	.quad	0x4000000000000000              # double 2
.LCPI69_1:
	.quad	0x3f91df46a1fae711              # double 0.017453292499999998
.LCPI69_2:
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
	movsd	.LCPI69_1(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm1, %xmm0
	callq	cos@PLT
	movsd	%xmm0, -80(%rbp)
	cvtsi2sdl	16(%rbp), %xmm0
	movsd	.LCPI69_1(%rip), %xmm1          # xmm1 = mem[0],zero
	mulsd	%xmm1, %xmm0
	callq	sin@PLT
	movsd	%xmm0, -88(%rbp)
	cvtsi2sdl	-36(%rbp), %xmm0
	cvtsi2sdl	-44(%rbp), %xmm1
	movsd	.LCPI69_0(%rip), %xmm2          # xmm2 = mem[0],zero
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -96(%rbp)
	cvtsi2sdl	-40(%rbp), %xmm0
	cvtsi2sdl	-48(%rbp), %xmm1
	movsd	.LCPI69_0(%rip), %xmm2          # xmm2 = mem[0],zero
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -104(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$-1, 4116(%rax)
	je	.LBB69_4
# %bb.1:
	movq	-8(%rbp), %rax
	cmpl	$-1, 4116(%rax)
	jne	.LBB69_3
# %bb.2:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 4116(%rax)
.LBB69_3:
	jmp	.LBB69_4
.LBB69_4:
	movl	$0, -1140(%rbp)
.LBB69_5:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -1140(%rbp)               # imm = 0x100
	jge	.LBB69_8
# %bb.6:                                #   in Loop: Header=BB69_5 Depth=1
	movslq	-1140(%rbp), %rax
	movl	$-1, -1136(%rbp,%rax,4)
# %bb.7:                                #   in Loop: Header=BB69_5 Depth=1
	movl	-1140(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -1140(%rbp)
	jmp	.LBB69_5
.LBB69_8:
	movsd	-32(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-72(%rbp), %xmm0
	movsd	%xmm0, -64(%rbp)
.LBB69_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB69_11 Depth 2
	movsd	-64(%rbp), %xmm1                # xmm1 = mem[0],zero
	movsd	-32(%rbp), %xmm0                # xmm0 = mem[0],zero
	addsd	-72(%rbp), %xmm0
	ucomisd	%xmm1, %xmm0
	jb	.LBB69_53
# %bb.10:                               #   in Loop: Header=BB69_9 Depth=1
	movsd	-24(%rbp), %xmm0                # xmm0 = mem[0],zero
	subsd	-72(%rbp), %xmm0
	movsd	%xmm0, -56(%rbp)
.LBB69_11:                              #   Parent Loop BB69_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movsd	-56(%rbp), %xmm1                # xmm1 = mem[0],zero
	movsd	-24(%rbp), %xmm0                # xmm0 = mem[0],zero
	addsd	-72(%rbp), %xmm0
	ucomisd	%xmm1, %xmm0
	jb	.LBB69_51
# %bb.12:                               #   in Loop: Header=BB69_11 Depth=2
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
	jl	.LBB69_49
# %bb.13:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1164(%rbp), %eax
	movl	-36(%rbp), %ecx
	addl	-44(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_49
# %bb.14:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1168(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.LBB69_49
# %bb.15:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1168(%rbp), %eax
	movl	-40(%rbp), %ecx
	addl	-48(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_49
# %bb.16:                               #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rdi
	movl	-1164(%rbp), %esi
	movl	-1168(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -1172(%rbp)
	movl	-1172(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB69_18
# %bb.17:                               #   in Loop: Header=BB69_11 Depth=2
	movq	-8(%rbp), %rdi
	cvttsd2si	-56(%rbp), %esi
	cvttsd2si	-64(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	4116(%rax), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB69_48
.LBB69_18:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB69_34
# %bb.19:                               #   in Loop: Header=BB69_11 Depth=2
	movslq	-1172(%rbp), %rax
	cmpl	$-1, -1136(%rbp,%rax,4)
	jne	.LBB69_33
# %bb.20:                               #   in Loop: Header=BB69_11 Depth=2
	movq	-8(%rbp), %rax
	movq	%rax, -1184(%rbp)               # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_22
# %bb.21:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -1188(%rbp)               # 4-byte Spill
	jmp	.LBB69_23
.LBB69_22:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -1188(%rbp)               # 4-byte Spill
.LBB69_23:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1188(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1192(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_25
# %bb.24:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -1196(%rbp)               # 4-byte Spill
	jmp	.LBB69_26
.LBB69_25:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -1196(%rbp)               # 4-byte Spill
.LBB69_26:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1196(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1200(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_28
# %bb.27:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -1204(%rbp)               # 4-byte Spill
	jmp	.LBB69_29
.LBB69_28:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -1204(%rbp)               # 4-byte Spill
.LBB69_29:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1204(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1208(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_31
# %bb.30:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -1212(%rbp)               # 4-byte Spill
	jmp	.LBB69_32
.LBB69_31:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -1212(%rbp)               # 4-byte Spill
.LBB69_32:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1208(%rbp), %ecx               # 4-byte Reload
	movl	-1200(%rbp), %edx               # 4-byte Reload
	movl	-1192(%rbp), %esi               # 4-byte Reload
	movq	-1184(%rbp), %rdi               # 8-byte Reload
	movl	-1212(%rbp), %r8d               # 4-byte Reload
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, %ecx
	movslq	-1172(%rbp), %rax
	movl	%ecx, -1136(%rbp,%rax,4)
.LBB69_33:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-8(%rbp), %rdi
	cvttsd2si	-56(%rbp), %esi
	cvttsd2si	-64(%rbp), %edx
	movslq	-1172(%rbp), %rax
	movl	-1136(%rbp,%rax,4), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB69_47
.LBB69_34:                              #   in Loop: Header=BB69_11 Depth=2
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
	je	.LBB69_36
# %bb.35:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -1244(%rbp)               # 4-byte Spill
	jmp	.LBB69_37
.LBB69_36:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -1244(%rbp)               # 4-byte Spill
.LBB69_37:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1244(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1248(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_39
# %bb.38:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -1252(%rbp)               # 4-byte Spill
	jmp	.LBB69_40
.LBB69_39:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -1252(%rbp)               # 4-byte Spill
.LBB69_40:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1252(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1256(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_42
# %bb.41:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -1260(%rbp)               # 4-byte Spill
	jmp	.LBB69_43
.LBB69_42:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -1260(%rbp)               # 4-byte Spill
.LBB69_43:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1260(%rbp), %eax               # 4-byte Reload
	movl	%eax, -1264(%rbp)               # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB69_45
# %bb.44:                               #   in Loop: Header=BB69_11 Depth=2
	movl	-1172(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -1268(%rbp)               # 4-byte Spill
	jmp	.LBB69_46
.LBB69_45:                              #   in Loop: Header=BB69_11 Depth=2
	movq	-16(%rbp), %rax
	movslq	-1172(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -1268(%rbp)               # 4-byte Spill
.LBB69_46:                              #   in Loop: Header=BB69_11 Depth=2
	movl	-1264(%rbp), %ecx               # 4-byte Reload
	movl	-1256(%rbp), %edx               # 4-byte Reload
	movl	-1248(%rbp), %esi               # 4-byte Reload
	movq	-1224(%rbp), %rdi               # 8-byte Reload
	movl	-1268(%rbp), %r8d               # 4-byte Reload
	callq	gdImageColorResolveAlpha@PLT
	movq	-1240(%rbp), %rdi               # 8-byte Reload
	movl	-1232(%rbp), %esi               # 4-byte Reload
	movl	-1228(%rbp), %edx               # 4-byte Reload
	movl	%eax, %ecx
	callq	gdImageSetPixel@PLT
.LBB69_47:                              #   in Loop: Header=BB69_11 Depth=2
	jmp	.LBB69_48
.LBB69_48:                              #   in Loop: Header=BB69_11 Depth=2
	jmp	.LBB69_49
.LBB69_49:                              #   in Loop: Header=BB69_11 Depth=2
	jmp	.LBB69_50
.LBB69_50:                              #   in Loop: Header=BB69_11 Depth=2
	movsd	.LCPI69_2(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-56(%rbp), %xmm0
	movsd	%xmm0, -56(%rbp)
	jmp	.LBB69_11
.LBB69_51:                              #   in Loop: Header=BB69_9 Depth=1
	jmp	.LBB69_52
.LBB69_52:                              #   in Loop: Header=BB69_9 Depth=1
	movsd	.LCPI69_2(%rip), %xmm0          # xmm0 = mem[0],zero
	addsd	-64(%rbp), %xmm0
	movsd	%xmm0, -64(%rbp)
	jmp	.LBB69_9
.LBB69_53:
	addq	$1280, %rsp                     # imm = 0x500
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end69:
	.size	gdImageCopyRotated, .Lfunc_end69-gdImageCopyRotated
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function gdImageCopyResampled
.LCPI70_0:
	.long	0x3f800000                      # float 1
.LCPI70_3:
	.long	0x437f0000                      # float 255
.LCPI70_4:
	.long	0x42fe0000                      # float 127
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI70_1:
	.quad	0x3ff0000000000000              # double 1
.LCPI70_2:
	.quad	0x406fe00000000000              # double 255
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
	subq	$184, %rsp
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
	jne	.LBB70_2
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
	callq	gdImageCopyResized@PLT
	jmp	.LBB70_46
.LBB70_2:
	movl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
.LBB70_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB70_5 Depth 2
                                        #       Child Loop BB70_7 Depth 3
                                        #         Child Loop BB70_16 Depth 4
	movl	-48(%rbp), %eax
	movl	-32(%rbp), %ecx
	addl	24(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB70_46
# %bb.4:                                #   in Loop: Header=BB70_3 Depth=1
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
.LBB70_5:                               #   Parent Loop BB70_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB70_7 Depth 3
                                        #         Child Loop BB70_16 Depth 4
	movl	-44(%rbp), %eax
	movl	-28(%rbp), %ecx
	addl	16(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB70_44
# %bb.6:                                #   in Loop: Header=BB70_5 Depth=2
	xorps	%xmm0, %xmm0
	movss	%xmm0, -76(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -80(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -84(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -88(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -92(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -100(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -104(%rbp)
	movl	-48(%rbp), %eax
	subl	-32(%rbp), %eax
	cvtsi2ss	%eax, %xmm0
	cvtsi2ssl	40(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	cvtsi2ssl	24(%rbp), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -52(%rbp)
	movl	-48(%rbp), %eax
	addl	$1, %eax
	subl	-32(%rbp), %eax
	cvtsi2ss	%eax, %xmm0
	cvtsi2ssl	40(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	cvtsi2ssl	24(%rbp), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -56(%rbp)
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -72(%rbp)
.LBB70_7:                               #   Parent Loop BB70_3 Depth=1
                                        #     Parent Loop BB70_5 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB70_16 Depth 4
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movss	%xmm0, -124(%rbp)               # 4-byte Spill
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-124(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB70_11
	jp	.LBB70_11
# %bb.8:                                #   in Loop: Header=BB70_7 Depth=3
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -128(%rbp)               # 4-byte Spill
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-128(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	subss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm1
	movsd	.LCPI70_1(%rip), %xmm0          # xmm0 = mem[0],zero
	subsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -108(%rbp)
	movss	-108(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	movss	-56(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	subss	-52(%rbp), %xmm1
	ucomiss	%xmm1, %xmm0
	jbe	.LBB70_10
# %bb.9:                                #   in Loop: Header=BB70_7 Depth=3
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-52(%rbp), %xmm0
	movss	%xmm0, -108(%rbp)
.LBB70_10:                              #   in Loop: Header=BB70_7 Depth=3
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movss	%xmm0, -72(%rbp)
	jmp	.LBB70_15
.LBB70_11:                              #   in Loop: Header=BB70_7 Depth=3
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -132(%rbp)               # 4-byte Spill
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-132(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB70_13
	jp	.LBB70_13
# %bb.12:                               #   in Loop: Header=BB70_7 Depth=3
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -136(%rbp)               # 4-byte Spill
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-136(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	subss	%xmm1, %xmm0
	movss	%xmm0, -108(%rbp)
	jmp	.LBB70_14
.LBB70_13:                              #   in Loop: Header=BB70_7 Depth=3
	movss	.LCPI70_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -108(%rbp)
.LBB70_14:                              #   in Loop: Header=BB70_7 Depth=3
	jmp	.LBB70_15
.LBB70_15:                              #   in Loop: Header=BB70_7 Depth=3
	movl	-44(%rbp), %eax
	subl	-28(%rbp), %eax
	cvtsi2ss	%eax, %xmm0
	cvtsi2ssl	32(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	cvtsi2ssl	16(%rbp), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -60(%rbp)
	movl	-44(%rbp), %eax
	addl	$1, %eax
	subl	-28(%rbp), %eax
	cvtsi2ss	%eax, %xmm0
	cvtsi2ssl	32(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	cvtsi2ssl	16(%rbp), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -64(%rbp)
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -68(%rbp)
.LBB70_16:                              #   Parent Loop BB70_3 Depth=1
                                        #     Parent Loop BB70_5 Depth=2
                                        #       Parent Loop BB70_7 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movss	%xmm0, -140(%rbp)               # 4-byte Spill
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-140(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB70_20
	jp	.LBB70_20
# %bb.17:                               #   in Loop: Header=BB70_16 Depth=4
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -144(%rbp)               # 4-byte Spill
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-144(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	subss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm1
	movsd	.LCPI70_1(%rip), %xmm0          # xmm0 = mem[0],zero
	subsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -112(%rbp)
	movss	-112(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	movss	-64(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	subss	-60(%rbp), %xmm1
	ucomiss	%xmm1, %xmm0
	jbe	.LBB70_19
# %bb.18:                               #   in Loop: Header=BB70_16 Depth=4
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-60(%rbp), %xmm0
	movss	%xmm0, -112(%rbp)
.LBB70_19:                              #   in Loop: Header=BB70_16 Depth=4
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movss	%xmm0, -68(%rbp)
	jmp	.LBB70_24
.LBB70_20:                              #   in Loop: Header=BB70_16 Depth=4
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -148(%rbp)               # 4-byte Spill
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-148(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jne	.LBB70_22
	jp	.LBB70_22
# %bb.21:                               #   in Loop: Header=BB70_16 Depth=4
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -152(%rbp)               # 4-byte Spill
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	floorf@PLT
	movaps	%xmm0, %xmm1
	movss	-152(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	subss	%xmm1, %xmm0
	movss	%xmm0, -112(%rbp)
	jmp	.LBB70_23
.LBB70_22:                              #   in Loop: Header=BB70_16 Depth=4
	movss	.LCPI70_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -112(%rbp)
.LBB70_23:                              #   in Loop: Header=BB70_16 Depth=4
	jmp	.LBB70_24
.LBB70_24:                              #   in Loop: Header=BB70_16 Depth=4
	movss	-112(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	mulss	-108(%rbp), %xmm0
	movss	%xmm0, -116(%rbp)
	movq	-24(%rbp), %rdi
	cvttss2si	-68(%rbp), %esi
	addl	-36(%rbp), %esi
	cvttss2si	-72(%rbp), %edx
	addl	-40(%rbp), %edx
	callq	gdImageGetTrueColorPixel@PLT
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %ecx
	andl	$2130706432, %ecx               # imm = 0x7F000000
	sarl	$24, %ecx
	movl	$127, %eax
	subl	%ecx, %eax
	cvtsi2ss	%eax, %xmm0
	mulss	-116(%rbp), %xmm0
	movss	%xmm0, -96(%rbp)
	movl	-120(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	cvtsi2ss	%eax, %xmm0
	movss	-96(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	movss	-80(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -80(%rbp)
	movl	-120(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	cvtsi2ss	%eax, %xmm0
	movss	-96(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	movss	-84(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -84(%rbp)
	movl	-120(%rbp), %eax
	andl	$255, %eax
	cvtsi2ss	%eax, %xmm0
	movss	-96(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	movss	-88(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -88(%rbp)
	movl	-120(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	cvtsi2ss	%eax, %xmm0
	movss	-116(%rbp), %xmm2               # xmm2 = mem[0],zero,zero,zero
	movss	-92(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -92(%rbp)
	movss	-96(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	addss	-100(%rbp), %xmm0
	movss	%xmm0, -100(%rbp)
	movss	-116(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	addss	-104(%rbp), %xmm0
	movss	%xmm0, -104(%rbp)
	movss	-112(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	movss	-108(%rbp), %xmm2               # xmm2 = mem[0],zero,zero,zero
	movss	-76(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -76(%rbp)
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movsd	.LCPI70_1(%rip), %xmm1          # xmm1 = mem[0],zero
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -68(%rbp)
# %bb.25:                               #   in Loop: Header=BB70_16 Depth=4
	movss	-68(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	ja	.LBB70_16
# %bb.26:                               #   in Loop: Header=BB70_7 Depth=3
	movss	.LCPI70_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	addss	-72(%rbp), %xmm0
	movss	%xmm0, -72(%rbp)
# %bb.27:                               #   in Loop: Header=BB70_7 Depth=3
	movss	-72(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	ja	.LBB70_7
# %bb.28:                               #   in Loop: Header=BB70_5 Depth=2
	movss	-76(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB70_29
	jp	.LBB70_29
	jmp	.LBB70_30
.LBB70_29:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-76(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-80(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -80(%rbp)
	movss	-76(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-84(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -84(%rbp)
	movss	-76(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-88(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -88(%rbp)
	movss	-76(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-92(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -92(%rbp)
.LBB70_30:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-100(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB70_31
	jp	.LBB70_31
	jmp	.LBB70_34
.LBB70_31:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-104(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB70_32
	jp	.LBB70_32
	jmp	.LBB70_33
.LBB70_32:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-104(%rbp), %xmm1               # xmm1 = mem[0],zero,zero,zero
	movss	-100(%rbp), %xmm0               # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -100(%rbp)
.LBB70_33:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-100(%rbp), %xmm1               # xmm1 = mem[0],zero,zero,zero
	movss	-80(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -80(%rbp)
	movss	-100(%rbp), %xmm1               # xmm1 = mem[0],zero,zero,zero
	movss	-84(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -84(%rbp)
	movss	-100(%rbp), %xmm1               # xmm1 = mem[0],zero,zero,zero
	movss	-88(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	movss	%xmm0, -88(%rbp)
.LBB70_34:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-80(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movsd	.LCPI70_2(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB70_36
# %bb.35:                               #   in Loop: Header=BB70_5 Depth=2
	movss	.LCPI70_3(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -80(%rbp)
.LBB70_36:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-84(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movsd	.LCPI70_2(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB70_38
# %bb.37:                               #   in Loop: Header=BB70_5 Depth=2
	movss	.LCPI70_3(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -84(%rbp)
.LBB70_38:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-88(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI70_3(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB70_40
# %bb.39:                               #   in Loop: Header=BB70_5 Depth=2
	movss	.LCPI70_3(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -88(%rbp)
.LBB70_40:                              #   in Loop: Header=BB70_5 Depth=2
	movss	-92(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI70_4(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB70_42
# %bb.41:                               #   in Loop: Header=BB70_5 Depth=2
	movss	.LCPI70_4(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -92(%rbp)
.LBB70_42:                              #   in Loop: Header=BB70_5 Depth=2
	movq	-16(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edx
	cvttss2si	-92(%rbp), %ecx
	shll	$24, %ecx
	cvttss2si	-80(%rbp), %eax
	shll	$16, %eax
	addl	%eax, %ecx
	cvttss2si	-84(%rbp), %eax
	shll	$8, %eax
	addl	%eax, %ecx
	cvttss2si	-88(%rbp), %eax
	addl	%eax, %ecx
	callq	gdImageSetPixel@PLT
# %bb.43:                               #   in Loop: Header=BB70_5 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB70_5
.LBB70_44:                              #   in Loop: Header=BB70_3 Depth=1
	jmp	.LBB70_45
.LBB70_45:                              #   in Loop: Header=BB70_3 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB70_3
.LBB70_46:
	addq	$184, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end70:
	.size	gdImageCopyResampled, .Lfunc_end70-gdImageCopyResampled
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
	jg	.LBB71_2
# %bb.1:
	jmp	.LBB71_3
.LBB71_2:
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
	callq	gdImageLine@PLT
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	callq	gdImageOpenPolygon@PLT
.LBB71_3:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end71:
	.size	gdImagePolygon, .Lfunc_end71-gdImagePolygon
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
	jg	.LBB72_2
# %bb.1:
	jmp	.LBB72_6
.LBB72_2:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -36(%rbp)
	movl	$1, -28(%rbp)
.LBB72_3:                               # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB72_6
# %bb.4:                                #   in Loop: Header=BB72_3 Depth=1
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
	callq	gdImageLine@PLT
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -36(%rbp)
# %bb.5:                                #   in Loop: Header=BB72_3 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB72_3
.LBB72_6:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end72:
	.size	gdImageOpenPolygon, .Lfunc_end72-gdImageOpenPolygon
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
.Lfunc_end73:
	.size	gdImageSetThickness, .Lfunc_end73-gdImageSetThickness
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
	jne	.LBB74_19
# %bb.1:
	movq	-8(%rbp), %rax
	movq	4136(%rax), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB74_19
# %bb.2:
	movl	$0, -20(%rbp)
.LBB74_3:                               # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB74_18
# %bb.4:                                #   in Loop: Header=BB74_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB74_6
# %bb.5:                                #   in Loop: Header=BB74_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	jmp	.LBB74_7
.LBB74_6:                               #   in Loop: Header=BB74_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
.LBB74_7:                               #   in Loop: Header=BB74_3 Depth=1
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB74_9
# %bb.8:                                #   in Loop: Header=BB74_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	jmp	.LBB74_10
.LBB74_9:                               #   in Loop: Header=BB74_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
.LBB74_10:                              #   in Loop: Header=BB74_3 Depth=1
	movl	-44(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB74_12
# %bb.11:                               #   in Loop: Header=BB74_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB74_13
.LBB74_12:                              #   in Loop: Header=BB74_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB74_13:                              #   in Loop: Header=BB74_3 Depth=1
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB74_15
# %bb.14:                               #   in Loop: Header=BB74_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	jmp	.LBB74_16
.LBB74_15:                              #   in Loop: Header=BB74_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
.LBB74_16:                              #   in Loop: Header=BB74_3 Depth=1
	movl	-56(%rbp), %ecx                 # 4-byte Reload
	movl	-48(%rbp), %edx                 # 4-byte Reload
	movl	-40(%rbp), %esi                 # 4-byte Reload
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movl	-60(%rbp), %r8d                 # 4-byte Reload
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 4152(%rax,%rcx,4)
# %bb.17:                               #   in Loop: Header=BB74_3 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB74_3
.LBB74_18:
	jmp	.LBB74_19
.LBB74_19:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end74:
	.size	gdImageSetBrush, .Lfunc_end74-gdImageSetBrush
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
	jne	.LBB75_19
# %bb.1:
	movq	-8(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	jne	.LBB75_19
# %bb.2:
	movl	$0, -20(%rbp)
.LBB75_3:                               # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	jge	.LBB75_18
# %bb.4:                                #   in Loop: Header=BB75_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB75_6
# %bb.5:                                #   in Loop: Header=BB75_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	jmp	.LBB75_7
.LBB75_6:                               #   in Loop: Header=BB75_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
.LBB75_7:                               #   in Loop: Header=BB75_3 Depth=1
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB75_9
# %bb.8:                                #   in Loop: Header=BB75_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	jmp	.LBB75_10
.LBB75_9:                               #   in Loop: Header=BB75_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
.LBB75_10:                              #   in Loop: Header=BB75_3 Depth=1
	movl	-44(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB75_12
# %bb.11:                               #   in Loop: Header=BB75_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB75_13
.LBB75_12:                              #   in Loop: Header=BB75_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB75_13:                              #   in Loop: Header=BB75_3 Depth=1
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB75_15
# %bb.14:                               #   in Loop: Header=BB75_3 Depth=1
	movl	-20(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	jmp	.LBB75_16
.LBB75_15:                              #   in Loop: Header=BB75_3 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
.LBB75_16:                              #   in Loop: Header=BB75_3 Depth=1
	movl	-56(%rbp), %ecx                 # 4-byte Reload
	movl	-48(%rbp), %edx                 # 4-byte Reload
	movl	-40(%rbp), %esi                 # 4-byte Reload
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movl	-60(%rbp), %r8d                 # 4-byte Reload
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %edx
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	%edx, 5176(%rax,%rcx,4)
# %bb.17:                               #   in Loop: Header=BB75_3 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB75_3
.LBB75_18:
	jmp	.LBB75_19
.LBB75_19:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end75:
	.size	gdImageSetTile, .Lfunc_end75-gdImageSetTile
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
.Lfunc_end76:
	.size	gdImageSetAntiAliased, .Lfunc_end76-gdImageSetAntiAliased
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
.Lfunc_end77:
	.size	gdImageSetAntiAliasedDontBlend, .Lfunc_end77-gdImageSetAntiAliasedDontBlend
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
.Lfunc_end78:
	.size	gdImageInterlace, .Lfunc_end78-gdImageInterlace
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
	je	.LBB79_2
# %bb.1:
	movl	-36(%rbp), %eax
	orl	$128, %eax
	movl	%eax, -36(%rbp)
.LBB79_2:
	movq	-8(%rbp), %rax
	movl	4116(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	je	.LBB79_4
# %bb.3:
	movl	-36(%rbp), %eax
	orl	$32, %eax
	movl	%eax, -36(%rbp)
.LBB79_4:
	movq	-8(%rbp), %rax
	movl	7248(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	7248(%rcx), %eax
	je	.LBB79_6
# %bb.5:
	movl	-36(%rbp), %eax
	orl	$256, %eax                      # imm = 0x100
	movl	%eax, -36(%rbp)
.LBB79_6:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -40(%rbp)
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	8(%rcx), %eax
	je	.LBB79_10
# %bb.7:
	movl	-36(%rbp), %eax
	orl	$9, %eax
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jge	.LBB79_9
# %bb.8:
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, -40(%rbp)
.LBB79_9:
	jmp	.LBB79_10
.LBB79_10:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	12(%rcx), %eax
	je	.LBB79_14
# %bb.11:
	movl	-36(%rbp), %eax
	orl	$17, %eax
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movl	12(%rax), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jge	.LBB79_13
# %bb.12:
	movq	-16(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -44(%rbp)
.LBB79_13:
	jmp	.LBB79_14
.LBB79_14:
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movq	-16(%rbp), %rcx
	cmpl	16(%rcx), %eax
	je	.LBB79_16
# %bb.15:
	movl	-36(%rbp), %eax
	orl	$2, %eax
	movl	%eax, -36(%rbp)
.LBB79_16:
	movl	$0, -24(%rbp)
.LBB79_17:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB79_19 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB79_56
# %bb.18:                               #   in Loop: Header=BB79_17 Depth=1
	movl	$0, -20(%rbp)
.LBB79_19:                              #   Parent Loop BB79_17 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	.LBB79_52
# %bb.20:                               #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_22
# %bb.21:                               #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	jmp	.LBB79_23
.LBB79_22:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
.LBB79_23:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-48(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -28(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_25
# %bb.24:                               #   in Loop: Header=BB79_19 Depth=2
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB79_26
.LBB79_25:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movslq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB79_26:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -32(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_28
# %bb.27:                               #   in Loop: Header=BB79_19 Depth=2
	movl	-28(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	jmp	.LBB79_29
.LBB79_28:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
.LBB79_29:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_31
# %bb.30:                               #   in Loop: Header=BB79_19 Depth=2
	movl	-32(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	jmp	.LBB79_32
.LBB79_31:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
.LBB79_32:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-60(%rbp), %eax                 # 4-byte Reload
	movl	-64(%rbp), %ecx                 # 4-byte Reload
	cmpl	%ecx, %eax
	je	.LBB79_34
# %bb.33:                               #   in Loop: Header=BB79_17 Depth=1
	movl	-36(%rbp), %eax
	orl	$5, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB79_52
.LBB79_34:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_36
# %bb.35:                               #   in Loop: Header=BB79_19 Depth=2
	movl	-28(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	jmp	.LBB79_37
.LBB79_36:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
.LBB79_37:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-68(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -72(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_39
# %bb.38:                               #   in Loop: Header=BB79_19 Depth=2
	movl	-32(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	jmp	.LBB79_40
.LBB79_39:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
.LBB79_40:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-72(%rbp), %eax                 # 4-byte Reload
	movl	-76(%rbp), %ecx                 # 4-byte Reload
	cmpl	%ecx, %eax
	je	.LBB79_42
# %bb.41:                               #   in Loop: Header=BB79_17 Depth=1
	movl	-36(%rbp), %eax
	orl	$5, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB79_52
.LBB79_42:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_44
# %bb.43:                               #   in Loop: Header=BB79_19 Depth=2
	movl	-28(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
	jmp	.LBB79_45
.LBB79_44:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
.LBB79_45:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-80(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -84(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB79_47
# %bb.46:                               #   in Loop: Header=BB79_19 Depth=2
	movl	-32(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -88(%rbp)                 # 4-byte Spill
	jmp	.LBB79_48
.LBB79_47:                              #   in Loop: Header=BB79_19 Depth=2
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -88(%rbp)                 # 4-byte Spill
.LBB79_48:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-84(%rbp), %eax                 # 4-byte Reload
	movl	-88(%rbp), %ecx                 # 4-byte Reload
	cmpl	%ecx, %eax
	je	.LBB79_50
# %bb.49:                               #   in Loop: Header=BB79_17 Depth=1
	movl	-36(%rbp), %eax
	orl	$5, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB79_52
.LBB79_50:                              #   in Loop: Header=BB79_19 Depth=2
	jmp	.LBB79_51
.LBB79_51:                              #   in Loop: Header=BB79_19 Depth=2
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB79_19
.LBB79_52:                              #   in Loop: Header=BB79_17 Depth=1
	movl	-36(%rbp), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB79_54
# %bb.53:
	jmp	.LBB79_56
.LBB79_54:                              #   in Loop: Header=BB79_17 Depth=1
	jmp	.LBB79_55
.LBB79_55:                              #   in Loop: Header=BB79_17 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB79_17
.LBB79_56:
	movl	-36(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end79:
	.size	gdImageCompare, .Lfunc_end79-gdImageCompare
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
	jle	.LBB80_2
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
	jmp	.LBB80_3
.LBB80_2:
	movl	-12(%rbp), %eax
	imull	-8(%rbp), %eax
	cltd
	idivl	-16(%rbp)
	movl	%eax, -4(%rbp)
.LBB80_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end80:
	.size	gdAlphaOverlayColor, .Lfunc_end80-gdAlphaOverlayColor
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
.Lfunc_end81:
	.size	gdImageAlphaBlending, .Lfunc_end81-gdImageAlphaBlending
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
.Lfunc_end82:
	.size	gdImageSaveAlpha, .Lfunc_end82-gdImageSaveAlpha
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
	jge	.LBB83_2
# %bb.1:
	movl	$0, -12(%rbp)
.LBB83_2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB83_4
# %bb.3:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
.LBB83_4:
	cmpl	$0, -20(%rbp)
	jge	.LBB83_6
# %bb.5:
	movl	$0, -20(%rbp)
.LBB83_6:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB83_8
# %bb.7:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -20(%rbp)
.LBB83_8:
	cmpl	$0, -16(%rbp)
	jge	.LBB83_10
# %bb.9:
	movl	$0, -16(%rbp)
.LBB83_10:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB83_12
# %bb.11:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
.LBB83_12:
	cmpl	$0, -24(%rbp)
	jge	.LBB83_14
# %bb.13:
	movl	$0, -24(%rbp)
.LBB83_14:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB83_16
# %bb.15:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -24(%rbp)
.LBB83_16:
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
.Lfunc_end83:
	.size	gdImageSetClip, .Lfunc_end83-gdImageSetClip
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
.Lfunc_end84:
	.size	gdImageGetClip, .Lfunc_end84-gdImageGetClip
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
	jbe	.LBB85_2
# %bb.1:
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7300(%rax)
.LBB85_2:
	cmpl	$0, -16(%rbp)
	jbe	.LBB85_4
# %bb.3:
	movl	-16(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 7304(%rax)
.LBB85_4:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end85:
	.size	gdImageSetResolution, .Lfunc_end85-gdImageSetResolution
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
	jne	.LBB86_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB86_32
.LBB86_2:
	movq	-16(%rbp), %rax
	cmpl	$1, 7248(%rax)
	jne	.LBB86_4
# %bb.3:
	movl	$1, -4(%rbp)
	jmp	.LBB86_32
.LBB86_4:
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
	jne	.LBB86_6
# %bb.5:
	movl	$0, -4(%rbp)
	jmp	.LBB86_32
.LBB86_6:
	movl	$0, -20(%rbp)
.LBB86_7:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB86_11 Depth 2
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jae	.LBB86_19
# %bb.8:                                #   in Loop: Header=BB86_7 Depth=1
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
	jne	.LBB86_10
# %bb.9:
	jmp	.LBB86_27
.LBB86_10:                              #   in Loop: Header=BB86_7 Depth=1
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-20(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -56(%rbp)
	movl	$0, -28(%rbp)
.LBB86_11:                              #   Parent Loop BB86_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-28(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jae	.LBB86_17
# %bb.12:                               #   in Loop: Header=BB86_11 Depth=2
	movq	-48(%rbp), %rax
	movl	-28(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %al
	movb	%al, -57(%rbp)
	movzbl	-57(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB86_14
# %bb.13:                               #   in Loop: Header=BB86_11 Depth=2
	movq	-56(%rbp), %rax
	movl	-28(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	$2130706432, (%rax,%rcx,4)      # imm = 0x7F000000
	jmp	.LBB86_15
.LBB86_14:                              #   in Loop: Header=BB86_11 Depth=2
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
.LBB86_15:                              #   in Loop: Header=BB86_11 Depth=2
	jmp	.LBB86_16
.LBB86_16:                              #   in Loop: Header=BB86_11 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB86_11
.LBB86_17:                              #   in Loop: Header=BB86_7 Depth=1
	jmp	.LBB86_18
.LBB86_18:                              #   in Loop: Header=BB86_7 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB86_7
.LBB86_19:
	jmp	.LBB86_20
.LBB86_20:
	movl	$0, -24(%rbp)
.LBB86_21:                              # =>This Inner Loop Header: Depth=1
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jae	.LBB86_24
# %bb.22:                               #   in Loop: Header=BB86_21 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.23:                               #   in Loop: Header=BB86_21 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB86_21
.LBB86_24:
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
	movq	-16(%rbp), %rax
	cmpl	$0, 4116(%rax)
	jl	.LBB86_26
# %bb.25:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -58(%rbp)
	movq	-16(%rbp), %rax
	movzbl	-58(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movl	6224(%rax,%rcx,4), %ecx
	shll	$24, %ecx
	movq	-16(%rbp), %rax
	movzbl	-58(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movl	20(%rax,%rdx,4), %eax
	shll	$16, %eax
	addl	%eax, %ecx
	movq	-16(%rbp), %rax
	movzbl	-58(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movl	1044(%rax,%rdx,4), %eax
	shll	$8, %eax
	addl	%eax, %ecx
	movq	-16(%rbp), %rax
	movzbl	-58(%rbp), %edx
                                        # kill: def $rdx killed $edx
	addl	2068(%rax,%rdx,4), %ecx
	movq	-16(%rbp), %rax
	movl	%ecx, 4116(%rax)
.LBB86_26:
	movl	$1, -4(%rbp)
	jmp	.LBB86_32
.LBB86_27:
	movl	$0, -24(%rbp)
.LBB86_28:                              # =>This Inner Loop Header: Depth=1
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jae	.LBB86_31
# %bb.29:                               #   in Loop: Header=BB86_28 Depth=1
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rax
	movl	-24(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movq	(%rax,%rcx,8), %rdi
	callq	gdFree@PLT
# %bb.30:                               #   in Loop: Header=BB86_28 Depth=1
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB86_28
.LBB86_31:
	movq	-16(%rbp), %rax
	movq	7256(%rax), %rdi
	callq	gdFree@PLT
	movl	$0, -4(%rbp)
.LBB86_32:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end86:
	.size	gdImagePaletteToTrueColor, .Lfunc_end86-gdImagePaletteToTrueColor
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function RGB_to_HWB
.LCPI87_0:
	.long	0x3f800000                      # float 1
.LCPI87_1:
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
	jbe	.LBB87_5
# %bb.1:
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB87_3
# %bb.2:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -84(%rbp)                # 4-byte Spill
	jmp	.LBB87_4
.LBB87_3:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -84(%rbp)                # 4-byte Spill
.LBB87_4:
	movss	-84(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -88(%rbp)                # 4-byte Spill
	jmp	.LBB87_9
.LBB87_5:
	movss	-56(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB87_7
# %bb.6:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -92(%rbp)                # 4-byte Spill
	jmp	.LBB87_8
.LBB87_7:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -92(%rbp)                # 4-byte Spill
.LBB87_8:
	movss	-92(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -88(%rbp)                # 4-byte Spill
.LBB87_9:
	movss	-88(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -64(%rbp)
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB87_14
# %bb.10:
	movss	-56(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB87_12
# %bb.11:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -96(%rbp)                # 4-byte Spill
	jmp	.LBB87_13
.LBB87_12:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -96(%rbp)                # 4-byte Spill
.LBB87_13:
	movss	-96(%rbp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -100(%rbp)               # 4-byte Spill
	jmp	.LBB87_18
.LBB87_14:
	movss	-52(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	jbe	.LBB87_16
# %bb.15:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -104(%rbp)               # 4-byte Spill
	jmp	.LBB87_17
.LBB87_16:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -104(%rbp)               # 4-byte Spill
.LBB87_17:
	movss	-104(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -100(%rbp)               # 4-byte Spill
.LBB87_18:
	movss	-100(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -68(%rbp)
	movss	.LCPI87_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	subss	-68(%rbp), %xmm0
	movss	%xmm0, -72(%rbp)
	movss	-68(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB87_20
	jp	.LBB87_20
# %bb.19:
	movq	-48(%rbp), %rax
	movss	.LCPI87_1(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, (%rax)
	movss	-64(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movq	-48(%rbp), %rax
	movss	%xmm0, 4(%rax)
	movss	-72(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movq	-48(%rbp), %rax
	movss	%xmm0, 8(%rax)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB87_30
.LBB87_20:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB87_22
	jp	.LBB87_22
# %bb.21:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-60(%rbp), %xmm0
	movss	%xmm0, -108(%rbp)               # 4-byte Spill
	jmp	.LBB87_26
.LBB87_22:
	movss	-56(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB87_24
	jp	.LBB87_24
# %bb.23:
	movss	-60(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-52(%rbp), %xmm0
	movss	%xmm0, -112(%rbp)               # 4-byte Spill
	jmp	.LBB87_25
.LBB87_24:
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	subss	-56(%rbp), %xmm0
	movss	%xmm0, -112(%rbp)               # 4-byte Spill
.LBB87_25:
	movss	-112(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -108(%rbp)               # 4-byte Spill
.LBB87_26:
	movss	-108(%rbp), %xmm0               # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -76(%rbp)
	movss	-52(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	ucomiss	-64(%rbp), %xmm0
	jne	.LBB87_28
	jp	.LBB87_28
# %bb.27:
	movl	$3, %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
	jmp	.LBB87_29
.LBB87_28:
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
.LBB87_29:
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
.LBB87_30:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end87:
	.size	RGB_to_HWB, .Lfunc_end87-RGB_to_HWB
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _gdImageFilledHRectangle
	.type	_gdImageFilledHRectangle,@function
_gdImageFilledHRectangle:               # @_gdImageFilledHRectangle
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
	jne	.LBB88_3
# %bb.1:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB88_3
# %bb.2:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
	jmp	.LBB88_23
.LBB88_3:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.LBB88_5
# %bb.4:
	movl	-12(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB88_5:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.LBB88_7
# %bb.6:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB88_7:
	cmpl	$0, -12(%rbp)
	jge	.LBB88_9
# %bb.8:
	movl	$0, -12(%rbp)
.LBB88_9:
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jl	.LBB88_11
# %bb.10:
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	subl	$1, %eax
	movl	%eax, -20(%rbp)
.LBB88_11:
	cmpl	$0, -16(%rbp)
	jge	.LBB88_13
# %bb.12:
	movl	$0, -16(%rbp)
.LBB88_13:
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	12(%rcx), %eax
	jl	.LBB88_15
# %bb.14:
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -24(%rbp)
.LBB88_15:
	movl	-12(%rbp), %eax
	movl	%eax, -32(%rbp)
.LBB88_16:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB88_18 Depth 2
	movl	-32(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB88_23
# %bb.17:                               #   in Loop: Header=BB88_16 Depth=1
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
.LBB88_18:                              #   Parent Loop BB88_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-36(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jg	.LBB88_21
# %bb.19:                               #   in Loop: Header=BB88_18 Depth=2
	movq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-36(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	gdImageSetPixel@PLT
# %bb.20:                               #   in Loop: Header=BB88_18 Depth=2
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB88_18
.LBB88_21:                              #   in Loop: Header=BB88_16 Depth=1
	jmp	.LBB88_22
.LBB88_22:                              #   in Loop: Header=BB88_16 Depth=1
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB88_16
.LBB88_23:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end88:
	.size	_gdImageFilledHRectangle, .Lfunc_end88-_gdImageFilledHRectangle
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
	jne	.LBB89_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB89_39
.LBB89_2:
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
	callq	gdImageGetPixel@PLT
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	4144(%rcx), %rcx
	cmpl	4116(%rcx), %eax
	jne	.LBB89_4
# %bb.3:
	movq	-16(%rbp), %rax
	movl	4116(%rax), %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB89_38
.LBB89_4:
	movq	-16(%rbp), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_21
# %bb.5:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_7
# %bb.6:
	movl	-40(%rbp), %eax
	movl	%eax, -36(%rbp)
	jmp	.LBB89_20
.LBB89_7:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_9
# %bb.8:
	movl	-40(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	jmp	.LBB89_10
.LBB89_9:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
.LBB89_10:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	shll	$24, %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_12
# %bb.11:
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	jmp	.LBB89_13
.LBB89_12:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
.LBB89_13:
	movl	-48(%rbp), %eax                 # 4-byte Reload
	movl	-52(%rbp), %ecx                 # 4-byte Reload
	shll	$16, %ecx
	addl	%ecx, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_15
# %bb.14:
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	jmp	.LBB89_16
.LBB89_15:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
.LBB89_16:
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movl	-60(%rbp), %ecx                 # 4-byte Reload
	shll	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_18
# %bb.17:
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	jmp	.LBB89_19
.LBB89_18:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
.LBB89_19:
	movl	-64(%rbp), %eax                 # 4-byte Reload
	movl	-68(%rbp), %ecx                 # 4-byte Reload
	addl	%ecx, %eax
	movl	%eax, -36(%rbp)
.LBB89_20:
	jmp	.LBB89_37
.LBB89_21:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_23
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
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -36(%rbp)
	jmp	.LBB89_36
.LBB89_23:
	movq	-16(%rbp), %rax
	movq	%rax, -80(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_25
# %bb.24:
	movl	-40(%rbp), %eax
	andl	$16711680, %eax                 # imm = 0xFF0000
	sarl	$16, %eax
	movl	%eax, -84(%rbp)                 # 4-byte Spill
	jmp	.LBB89_26
.LBB89_25:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	20(%rax,%rcx,4), %eax
	movl	%eax, -84(%rbp)                 # 4-byte Spill
.LBB89_26:
	movl	-84(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -88(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_28
# %bb.27:
	movl	-40(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
	jmp	.LBB89_29
.LBB89_28:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	1044(%rax,%rcx,4), %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
.LBB89_29:
	movl	-92(%rbp), %eax                 # 4-byte Reload
	movl	%eax, -96(%rbp)                 # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_31
# %bb.30:
	movl	-40(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	jmp	.LBB89_32
.LBB89_31:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	2068(%rax,%rcx,4), %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
.LBB89_32:
	movl	-100(%rbp), %eax                # 4-byte Reload
	movl	%eax, -104(%rbp)                # 4-byte Spill
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	cmpl	$0, 7248(%rax)
	je	.LBB89_34
# %bb.33:
	movl	-40(%rbp), %eax
	andl	$2130706432, %eax               # imm = 0x7F000000
	sarl	$24, %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	jmp	.LBB89_35
.LBB89_34:
	movq	-16(%rbp), %rax
	movq	4144(%rax), %rax
	movslq	-40(%rbp), %rcx
	movl	6224(%rax,%rcx,4), %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
.LBB89_35:
	movl	-104(%rbp), %ecx                # 4-byte Reload
	movl	-96(%rbp), %edx                 # 4-byte Reload
	movl	-88(%rbp), %esi                 # 4-byte Reload
	movq	-80(%rbp), %rdi                 # 8-byte Reload
	movl	-108(%rbp), %r8d                # 4-byte Reload
	callq	gdImageColorResolveAlpha@PLT
	movl	%eax, -36(%rbp)
.LBB89_36:
	jmp	.LBB89_37
.LBB89_37:
	jmp	.LBB89_38
.LBB89_38:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB89_39:
	movl	-4(%rbp), %eax
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end89:
	.size	gdImageTileGet, .Lfunc_end89-gdImageTileGet
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
	jl	.LBB90_4
# %bb.1:
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7296(%rcx), %eax
	jg	.LBB90_4
# %bb.2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7284(%rcx), %eax
	jl	.LBB90_4
# %bb.3:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7292(%rcx), %eax
	jle	.LBB90_5
.LBB90_4:
	jmp	.LBB90_10
.LBB90_5:
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	callq	gdImageGetPixel@PLT
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	cmpl	-20(%rbp), %eax
	je	.LBB90_8
# %bb.6:
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	7280(%rcx), %eax
	jne	.LBB90_9
# %bb.7:
	cmpl	$0, -24(%rbp)
	je	.LBB90_9
.LBB90_8:
	jmp	.LBB90_10
.LBB90_9:
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
.LBB90_10:
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end90:
	.size	gdImageSetAAPixelColor, .Lfunc_end90-gdImageSetAAPixelColor
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
	.addrsig_sym _gd_error_ex
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
	.addrsig_sym _gdImageFilledVRectangle
	.addrsig_sym gdImageClone
	.addrsig_sym gdImageSetStyle
	.addrsig_sym gdImageCopyResized
	.addrsig_sym gdImagePolygon
	.addrsig_sym gdImageOpenPolygon
	.addrsig_sym gdReallocEx
	.addrsig_sym gdAlphaOverlayColor
	.addrsig_sym RGB_to_HWB
	.addrsig_sym _gdImageFilledHRectangle
	.addrsig_sym gdImageTileGet
	.addrsig_sym gdImageSetAAPixelColor
	.addrsig_sym stderr
	.addrsig_sym gd_error_method
	.addrsig_sym gdCosT
	.addrsig_sym gdSinT
