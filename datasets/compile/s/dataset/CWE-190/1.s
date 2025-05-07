	.text
	.file	"hiredis.c"
	.globl	freeReplyObject                 # -- Begin function freeReplyObject
	.p2align	4, 0x90
	.type	freeReplyObject,@function
freeReplyObject:                        # @freeReplyObject
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB0_2
# %bb.1:
	jmp	.LBB0_13
.LBB0_2:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -28(%rbp)                 # 4-byte Spill
	subl	$1, %eax
	je	.LBB0_11
	jmp	.LBB0_14
.LBB0_14:
	movl	-28(%rbp), %eax                 # 4-byte Reload
	subl	$2, %eax
	je	.LBB0_4
	jmp	.LBB0_15
.LBB0_15:
	movl	-28(%rbp), %eax                 # 4-byte Reload
	subl	$3, %eax
	je	.LBB0_3
	jmp	.LBB0_16
.LBB0_16:
	movl	-28(%rbp), %eax                 # 4-byte Reload
	addl	$-5, %eax
	subl	$3, %eax
	jb	.LBB0_11
	jmp	.LBB0_17
.LBB0_17:
	movl	-28(%rbp), %eax                 # 4-byte Reload
	addl	$-9, %eax
	subl	$2, %eax
	jb	.LBB0_4
	jmp	.LBB0_18
.LBB0_18:
	movl	-28(%rbp), %eax                 # 4-byte Reload
	subl	$12, %eax
	je	.LBB0_4
	jmp	.LBB0_19
.LBB0_19:
	movl	-28(%rbp), %eax                 # 4-byte Reload
	subl	$14, %eax
	je	.LBB0_11
	jmp	.LBB0_12
.LBB0_3:
	jmp	.LBB0_12
.LBB0_4:
	movq	-16(%rbp), %rax
	cmpq	$0, 56(%rax)
	je	.LBB0_10
# %bb.5:
	movq	$0, -24(%rbp)
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	48(%rcx), %rax
	jae	.LBB0_9
# %bb.7:                                #   in Loop: Header=BB0_6 Depth=1
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	freeReplyObject@PLT
# %bb.8:                                #   in Loop: Header=BB0_6 Depth=1
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB0_6
.LBB0_9:
	movq	-16(%rbp), %rax
	movq	56(%rax), %rdi
	callq	hi_free
.LBB0_10:
	jmp	.LBB0_12
.LBB0_11:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rdi
	callq	hi_free
.LBB0_12:
	movq	-16(%rbp), %rdi
	callq	hi_free
.LBB0_13:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	freeReplyObject, .Lfunc_end0-freeReplyObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function hi_free
	.type	hi_free,@function
hi_free:                                # @hi_free
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	hiredisAllocFns@GOTPCREL(%rip), %rax
	movq	32(%rax), %rax
	movq	-8(%rbp), %rdi
	callq	*%rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	hi_free, .Lfunc_end1-hi_free
	.cfi_endproc
                                        # -- End function
	.globl	redisvFormatCommand             # -- Begin function redisvFormatCommand
	.p2align	4, 0x90
	.type	redisvFormatCommand,@function
redisvFormatCommand:                    # @redisvFormatCommand
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$448, %rsp                      # imm = 0x1C0
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	$0, -48(%rbp)
	movl	$0, -76(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -96(%rbp)
	movl	$0, -100(%rbp)
	movl	$0, -104(%rbp)
	movl	$0, -108(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB2_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB2_130
.LBB2_2:
	callq	sdsempty@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB2_4
# %bb.3:
	movl	$-1, -4(%rbp)
	jmp	.LBB2_130
.LBB2_4:
	jmp	.LBB2_5
.LBB2_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_38 Depth 2
                                        #     Child Loop BB2_43 Depth 2
                                        #     Child Loop BB2_49 Depth 2
	movq	-40(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB2_107
# %bb.6:                                #   in Loop: Header=BB2_5 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$37, %eax
	jne	.LBB2_8
# %bb.7:                                #   in Loop: Header=BB2_5 Depth=1
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$0, %eax
	jne	.LBB2_20
.LBB2_8:                                #   in Loop: Header=BB2_5 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$32, %eax
	jne	.LBB2_16
# %bb.9:                                #   in Loop: Header=BB2_5 Depth=1
	cmpl	$0, -76(%rbp)
	je	.LBB2_15
# %bb.10:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-88(%rbp), %rdi
	movl	-100(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rsi
	shlq	$3, %rsi
	callq	hi_realloc
	movq	%rax, -96(%rbp)
	cmpq	$0, -96(%rbp)
	jne	.LBB2_12
# %bb.11:
	jmp	.LBB2_123
.LBB2_12:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-96(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-64(%rbp), %rdx
	movq	-88(%rbp), %rax
	movl	-100(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -100(%rbp)
	movslq	%ecx, %rcx
	movq	%rdx, (%rax,%rcx,8)
	movq	-64(%rbp), %rdi
	callq	sdslen
	movq	%rax, %rdi
	callq	bulklen
	movq	%rax, %rcx
	movslq	-104(%rbp), %rax
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -104(%rbp)
	callq	sdsempty@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB2_14
# %bb.13:
	jmp	.LBB2_123
.LBB2_14:                               #   in Loop: Header=BB2_5 Depth=1
	movl	$0, -76(%rbp)
.LBB2_15:                               #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_19
.LBB2_16:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-64(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movl	$1, %edx
	callq	sdscatlen@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB2_18
# %bb.17:
	jmp	.LBB2_123
.LBB2_18:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-72(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	$1, -76(%rbp)
.LBB2_19:                               #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_106
.LBB2_20:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-64(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %eax
	movl	%eax, -196(%rbp)                # 4-byte Spill
	subl	$37, %eax
	je	.LBB2_36
	jmp	.LBB2_131
.LBB2_131:                              #   in Loop: Header=BB2_5 Depth=1
	movl	-196(%rbp), %eax                # 4-byte Reload
	subl	$98, %eax
	je	.LBB2_27
	jmp	.LBB2_132
.LBB2_132:                              #   in Loop: Header=BB2_5 Depth=1
	movl	-196(%rbp), %eax                # 4-byte Reload
	subl	$115, %eax
	jne	.LBB2_37
	jmp	.LBB2_21
.LBB2_21:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -208(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -200(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_23
# %bb.22:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-208(%rbp), %rcx                # 8-byte Reload
	movl	-200(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -216(%rbp)                # 8-byte Spill
	jmp	.LBB2_24
.LBB2_23:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-208(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -216(%rbp)                # 8-byte Spill
.LBB2_24:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-216(%rbp), %rax                # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rdi
	callq	strlen@PLT
	movq	%rax, -128(%rbp)
	cmpq	$0, -128(%rbp)
	jbe	.LBB2_26
# %bb.25:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-64(%rbp), %rdi
	movq	-120(%rbp), %rsi
	movq	-128(%rbp), %rdx
	callq	sdscatlen@PLT
	movq	%rax, -72(%rbp)
.LBB2_26:                               #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_103
.LBB2_27:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -232(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -220(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_29
# %bb.28:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-232(%rbp), %rcx                # 8-byte Reload
	movl	-220(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -240(%rbp)                # 8-byte Spill
	jmp	.LBB2_30
.LBB2_29:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-232(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -240(%rbp)                # 8-byte Spill
.LBB2_30:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-240(%rbp), %rax                # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -256(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -244(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_32
# %bb.31:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-256(%rbp), %rcx                # 8-byte Reload
	movl	-244(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -264(%rbp)                # 8-byte Spill
	jmp	.LBB2_33
.LBB2_32:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-256(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -264(%rbp)                # 8-byte Spill
.LBB2_33:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-264(%rbp), %rax                # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	cmpq	$0, -128(%rbp)
	jbe	.LBB2_35
# %bb.34:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-64(%rbp), %rdi
	movq	-120(%rbp), %rsi
	movq	-128(%rbp), %rdx
	callq	sdscatlen@PLT
	movq	%rax, -72(%rbp)
.LBB2_35:                               #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_103
.LBB2_36:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-64(%rbp), %rdi
	leaq	.L.str(%rip), %rsi
	callq	sdscat@PLT
	movq	%rax, -72(%rbp)
	jmp	.LBB2_103
.LBB2_37:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
	movq	$0, -160(%rbp)
.LBB2_38:                               #   Parent Loop BB2_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-152(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, %ecx
	movb	%al, -265(%rbp)                 # 1-byte Spill
	je	.LBB2_40
# %bb.39:                               #   in Loop: Header=BB2_38 Depth=2
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	redisvFormatCommand.flags(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	setne	%al
	movb	%al, -265(%rbp)                 # 1-byte Spill
.LBB2_40:                               #   in Loop: Header=BB2_38 Depth=2
	movb	-265(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB2_41
	jmp	.LBB2_42
.LBB2_41:                               #   in Loop: Header=BB2_38 Depth=2
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
	jmp	.LBB2_38
.LBB2_42:                               #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_43
.LBB2_43:                               #   Parent Loop BB2_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-152(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, %ecx
	movb	%al, -266(%rbp)                 # 1-byte Spill
	je	.LBB2_45
# %bb.44:                               #   in Loop: Header=BB2_43 Depth=2
	callq	__ctype_b_loc@PLT
	movq	(%rax), %rax
	movq	-152(%rbp), %rcx
	movsbl	(%rcx), %ecx
	movslq	%ecx, %rcx
	movzwl	(%rax,%rcx,2), %eax
	andl	$2048, %eax                     # imm = 0x800
	cmpl	$0, %eax
	setne	%al
	movb	%al, -266(%rbp)                 # 1-byte Spill
.LBB2_45:                               #   in Loop: Header=BB2_43 Depth=2
	movb	-266(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB2_46
	jmp	.LBB2_47
.LBB2_46:                               #   in Loop: Header=BB2_43 Depth=2
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
	jmp	.LBB2_43
.LBB2_47:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$46, %eax
	jne	.LBB2_54
# %bb.48:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
.LBB2_49:                               #   Parent Loop BB2_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-152(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, %ecx
	movb	%al, -267(%rbp)                 # 1-byte Spill
	je	.LBB2_51
# %bb.50:                               #   in Loop: Header=BB2_49 Depth=2
	callq	__ctype_b_loc@PLT
	movq	(%rax), %rax
	movq	-152(%rbp), %rcx
	movsbl	(%rcx), %ecx
	movslq	%ecx, %rcx
	movzwl	(%rax,%rcx,2), %eax
	andl	$2048, %eax                     # imm = 0x800
	cmpl	$0, %eax
	setne	%al
	movb	%al, -267(%rbp)                 # 1-byte Spill
.LBB2_51:                               #   in Loop: Header=BB2_49 Depth=2
	movb	-267(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB2_52
	jmp	.LBB2_53
.LBB2_52:                               #   in Loop: Header=BB2_49 Depth=2
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
	jmp	.LBB2_49
.LBB2_53:                               #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_54
.LBB2_54:                               #   in Loop: Header=BB2_5 Depth=1
	leaq	-192(%rbp), %rax
	movq	-32(%rbp), %rcx
	movq	16(%rcx), %rdx
	movq	%rdx, 16(%rax)
	movups	(%rcx), %xmm0
	movups	%xmm0, (%rax)
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	redisvFormatCommand.intfmts(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	je	.LBB2_59
# %bb.55:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -280(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -272(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_57
# %bb.56:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-280(%rbp), %rcx                # 8-byte Reload
	movl	-272(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -288(%rbp)                # 8-byte Spill
	jmp	.LBB2_58
.LBB2_57:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-280(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -288(%rbp)                # 8-byte Spill
.LBB2_58:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-288(%rbp), %rax                # 8-byte Reload
	jmp	.LBB2_100
.LBB2_59:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	.L.str.1(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	je	.LBB2_64
# %bb.60:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -312(%rbp)                # 8-byte Spill
	movq	%rax, %rcx
	addq	$4, %rcx
	movq	%rcx, -304(%rbp)                # 8-byte Spill
	movl	4(%rax), %eax
	movl	%eax, -292(%rbp)                # 4-byte Spill
	cmpl	$160, %eax
	ja	.LBB2_62
# %bb.61:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-304(%rbp), %rcx                # 8-byte Reload
	movl	-292(%rbp), %edx                # 4-byte Reload
	movq	-312(%rbp), %rsi                # 8-byte Reload
	movslq	%edx, %rax
	addq	16(%rsi), %rax
	addl	$16, %edx
	movl	%edx, (%rcx)
	movq	%rax, -320(%rbp)                # 8-byte Spill
	jmp	.LBB2_63
.LBB2_62:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-312(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -320(%rbp)                # 8-byte Spill
.LBB2_63:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-320(%rbp), %rax                # 8-byte Reload
	jmp	.LBB2_100
.LBB2_64:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$104, %eax
	jne	.LBB2_73
# %bb.65:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$104, %eax
	jne	.LBB2_73
# %bb.66:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB2_72
# %bb.67:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	redisvFormatCommand.intfmts(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	je	.LBB2_72
# %bb.68:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -336(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -324(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_70
# %bb.69:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-336(%rbp), %rcx                # 8-byte Reload
	movl	-324(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -344(%rbp)                # 8-byte Spill
	jmp	.LBB2_71
.LBB2_70:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-336(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -344(%rbp)                # 8-byte Spill
.LBB2_71:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-344(%rbp), %rax                # 8-byte Reload
	jmp	.LBB2_100
.LBB2_72:
	jmp	.LBB2_99
.LBB2_73:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$104, %eax
	jne	.LBB2_81
# %bb.74:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB2_80
# %bb.75:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	redisvFormatCommand.intfmts(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	je	.LBB2_80
# %bb.76:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -360(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -348(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_78
# %bb.77:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-360(%rbp), %rcx                # 8-byte Reload
	movl	-348(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -368(%rbp)                # 8-byte Spill
	jmp	.LBB2_79
.LBB2_78:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-360(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -368(%rbp)                # 8-byte Spill
.LBB2_79:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-368(%rbp), %rax                # 8-byte Reload
	jmp	.LBB2_100
.LBB2_80:
	jmp	.LBB2_99
.LBB2_81:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$108, %eax
	jne	.LBB2_90
# %bb.82:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$108, %eax
	jne	.LBB2_90
# %bb.83:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB2_89
# %bb.84:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	redisvFormatCommand.intfmts(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	je	.LBB2_89
# %bb.85:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -384(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -372(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_87
# %bb.86:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-384(%rbp), %rcx                # 8-byte Reload
	movl	-372(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -392(%rbp)                # 8-byte Spill
	jmp	.LBB2_88
.LBB2_87:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-384(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -392(%rbp)                # 8-byte Spill
.LBB2_88:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-392(%rbp), %rax                # 8-byte Reload
	jmp	.LBB2_100
.LBB2_89:
	jmp	.LBB2_99
.LBB2_90:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$108, %eax
	jne	.LBB2_98
# %bb.91:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB2_97
# %bb.92:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	movsbl	(%rax), %esi
	leaq	redisvFormatCommand.intfmts(%rip), %rdi
	callq	strchr@PLT
	cmpq	$0, %rax
	je	.LBB2_97
# %bb.93:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, -408(%rbp)                # 8-byte Spill
	movl	(%rax), %eax
	movl	%eax, -396(%rbp)                # 4-byte Spill
	cmpl	$40, %eax
	ja	.LBB2_95
# %bb.94:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-408(%rbp), %rcx                # 8-byte Reload
	movl	-396(%rbp), %edx                # 4-byte Reload
	movslq	%edx, %rax
	addq	16(%rcx), %rax
	addl	$8, %edx
	movl	%edx, (%rcx)
	movq	%rax, -416(%rbp)                # 8-byte Spill
	jmp	.LBB2_96
.LBB2_95:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-408(%rbp), %rcx                # 8-byte Reload
	movq	8(%rcx), %rax
	movq	%rax, %rdx
	addq	$8, %rdx
	movq	%rdx, 8(%rcx)
	movq	%rax, -416(%rbp)                # 8-byte Spill
.LBB2_96:                               #   in Loop: Header=BB2_5 Depth=1
	movq	-416(%rbp), %rax                # 8-byte Reload
	jmp	.LBB2_100
.LBB2_97:
	jmp	.LBB2_99
.LBB2_98:
	jmp	.LBB2_99
.LBB2_99:
	leaq	-192(%rbp), %rax
	jmp	.LBB2_122
.LBB2_100:                              #   in Loop: Header=BB2_5 Depth=1
	movq	-152(%rbp), %rax
	addq	$1, %rax
	movq	-40(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, -160(%rbp)
	cmpq	$14, -160(%rbp)
	jae	.LBB2_102
# %bb.101:                              #   in Loop: Header=BB2_5 Depth=1
	leaq	-144(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-160(%rbp), %rdx
	callq	memcpy@PLT
	movq	-160(%rbp), %rax
	movb	$0, -144(%rbp,%rax)
	movq	-64(%rbp), %rdi
	leaq	-144(%rbp), %rsi
	leaq	-192(%rbp), %rdx
	callq	sdscatvprintf@PLT
	movq	%rax, -72(%rbp)
	movq	-152(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -40(%rbp)
.LBB2_102:                              #   in Loop: Header=BB2_5 Depth=1
	leaq	-192(%rbp), %rax
.LBB2_103:                              #   in Loop: Header=BB2_5 Depth=1
	cmpq	$0, -72(%rbp)
	jne	.LBB2_105
# %bb.104:
	jmp	.LBB2_123
.LBB2_105:                              #   in Loop: Header=BB2_5 Depth=1
	movq	-72(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	$1, -76(%rbp)
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
.LBB2_106:                              #   in Loop: Header=BB2_5 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB2_5
.LBB2_107:
	cmpl	$0, -76(%rbp)
	je	.LBB2_111
# %bb.108:
	movq	-88(%rbp), %rdi
	movl	-100(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rsi
	shlq	$3, %rsi
	callq	hi_realloc
	movq	%rax, -96(%rbp)
	cmpq	$0, -96(%rbp)
	jne	.LBB2_110
# %bb.109:
	jmp	.LBB2_123
.LBB2_110:
	movq	-96(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-64(%rbp), %rdx
	movq	-88(%rbp), %rax
	movl	-100(%rbp), %ecx
	movl	%ecx, %esi
	addl	$1, %esi
	movl	%esi, -100(%rbp)
	movslq	%ecx, %rcx
	movq	%rdx, (%rax,%rcx,8)
	movq	-64(%rbp), %rdi
	callq	sdslen
	movq	%rax, %rdi
	callq	bulklen
	movq	%rax, %rcx
	movslq	-104(%rbp), %rax
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -104(%rbp)
	jmp	.LBB2_112
.LBB2_111:
	movq	-64(%rbp), %rdi
	callq	sdsfree@PLT
.LBB2_112:
	movq	$0, -64(%rbp)
	movslq	-100(%rbp), %rdi
	callq	countDigits
	addl	$1, %eax
	addl	$2, %eax
	addl	-104(%rbp), %eax
	movl	%eax, -104(%rbp)
	movl	-104(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rdi
	callq	hi_malloc
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB2_114
# %bb.113:
	jmp	.LBB2_123
.LBB2_114:
	movq	-48(%rbp), %rdi
	movl	-100(%rbp), %edx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	sprintf@PLT
	movl	%eax, -52(%rbp)
	movl	$0, -112(%rbp)
.LBB2_115:                              # =>This Inner Loop Header: Depth=1
	movl	-112(%rbp), %eax
	cmpl	-100(%rbp), %eax
	jge	.LBB2_118
# %bb.116:                              #   in Loop: Header=BB2_115 Depth=1
	movq	-48(%rbp), %rax
	movslq	-52(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, -440(%rbp)                # 8-byte Spill
	movq	-88(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	sdslen
	movq	-440(%rbp), %rdi                # 8-byte Reload
	movq	%rax, %rdx
	leaq	.L.str.3(%rip), %rsi
	movb	$0, %al
	callq	sprintf@PLT
	addl	-52(%rbp), %eax
	movl	%eax, -52(%rbp)
	movq	-48(%rbp), %rax
	movslq	-52(%rbp), %rcx
	addq	%rcx, %rax
	movq	%rax, -432(%rbp)                # 8-byte Spill
	movq	-88(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -424(%rbp)                # 8-byte Spill
	movq	-88(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	sdslen
	movq	-432(%rbp), %rdi                # 8-byte Reload
	movq	-424(%rbp), %rsi                # 8-byte Reload
	movq	%rax, %rdx
	callq	memcpy@PLT
	movq	-88(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	sdslen
	movq	%rax, %rcx
	movslq	-52(%rbp), %rax
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -52(%rbp)
	movq	-88(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	sdsfree@PLT
	movq	-48(%rbp), %rax
	movl	-52(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -52(%rbp)
	movslq	%ecx, %rcx
	movb	$13, (%rax,%rcx)
	movq	-48(%rbp), %rax
	movl	-52(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -52(%rbp)
	movslq	%ecx, %rcx
	movb	$10, (%rax,%rcx)
# %bb.117:                              #   in Loop: Header=BB2_115 Depth=1
	movl	-112(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -112(%rbp)
	jmp	.LBB2_115
.LBB2_118:
	movl	-52(%rbp), %eax
	cmpl	-104(%rbp), %eax
	jne	.LBB2_120
# %bb.119:
	jmp	.LBB2_121
.LBB2_120:
	leaq	.L.str.4(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$507, %edx                      # imm = 0x1FB
	leaq	.L__PRETTY_FUNCTION__.redisvFormatCommand(%rip), %rcx
	callq	__assert_fail@PLT
.LBB2_121:
	movq	-48(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movq	-88(%rbp), %rdi
	callq	hi_free
	movq	-48(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movl	-104(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_130
.LBB2_122:
	movl	$-2, -108(%rbp)
	jmp	.LBB2_124
.LBB2_123:
	movl	$-1, -108(%rbp)
.LBB2_124:
	cmpq	$0, -88(%rbp)
	je	.LBB2_129
# %bb.125:
	jmp	.LBB2_126
.LBB2_126:                              # =>This Inner Loop Header: Depth=1
	movl	-100(%rbp), %eax
	movl	%eax, %ecx
	addl	$-1, %ecx
	movl	%ecx, -100(%rbp)
	cmpl	$0, %eax
	je	.LBB2_128
# %bb.127:                              #   in Loop: Header=BB2_126 Depth=1
	movq	-88(%rbp), %rax
	movslq	-100(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	sdsfree@PLT
	jmp	.LBB2_126
.LBB2_128:
	movq	-88(%rbp), %rdi
	callq	hi_free
.LBB2_129:
	movq	-64(%rbp), %rdi
	callq	sdsfree@PLT
	movq	-48(%rbp), %rdi
	callq	hi_free
	movl	-108(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB2_130:
	movl	-4(%rbp), %eax
	addq	$448, %rsp                      # imm = 0x1C0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	redisvFormatCommand, .Lfunc_end2-redisvFormatCommand
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function hi_realloc
	.type	hi_realloc,@function
hi_realloc:                             # @hi_realloc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	hiredisAllocFns@GOTPCREL(%rip), %rax
	movq	16(%rax), %rax
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	*%rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	hi_realloc, .Lfunc_end3-hi_realloc
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function bulklen
	.type	bulklen,@function
bulklen:                                # @bulklen
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
	callq	countDigits
	addl	$1, %eax
	addl	$2, %eax
	movl	%eax, %eax
                                        # kill: def $rax killed $eax
	addq	-8(%rbp), %rax
	addq	$2, %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	bulklen, .Lfunc_end4-bulklen
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function sdslen
	.type	sdslen,@function
sdslen:                                 # @sdslen
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rax
	movb	-1(%rax), %al
	movb	%al, -17(%rbp)
	movzbl	-17(%rbp), %eax
	andl	$7, %eax
	movl	%eax, %ecx
	movq	%rcx, -32(%rbp)                 # 8-byte Spill
	subl	$4, %eax
	ja	.LBB5_6
# %bb.8:
	movq	-32(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI5_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB5_1:
	movzbl	-17(%rbp), %eax
	sarl	$3, %eax
	cltq
	movq	%rax, -8(%rbp)
	jmp	.LBB5_7
.LBB5_2:
	movq	-16(%rbp), %rax
	movzbl	-3(%rax), %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -8(%rbp)
	jmp	.LBB5_7
.LBB5_3:
	movq	-16(%rbp), %rax
	movzwl	-5(%rax), %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -8(%rbp)
	jmp	.LBB5_7
.LBB5_4:
	movq	-16(%rbp), %rax
	movl	-9(%rax), %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -8(%rbp)
	jmp	.LBB5_7
.LBB5_5:
	movq	-16(%rbp), %rax
	movq	-17(%rax), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB5_7
.LBB5_6:
	movq	$0, -8(%rbp)
.LBB5_7:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	sdslen, .Lfunc_end5-sdslen
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI5_0:
	.long	.LBB5_1-.LJTI5_0
	.long	.LBB5_2-.LJTI5_0
	.long	.LBB5_3-.LJTI5_0
	.long	.LBB5_4-.LJTI5_0
	.long	.LBB5_5-.LJTI5_0
                                        # -- End function
	.text
	.p2align	4, 0x90                         # -- Begin function countDigits
	.type	countDigits,@function
countDigits:                            # @countDigits
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$1, -20(%rbp)
.LBB6_1:                                # =>This Inner Loop Header: Depth=1
	cmpq	$10, -16(%rbp)
	jae	.LBB6_3
# %bb.2:
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_10
.LBB6_3:                                #   in Loop: Header=BB6_1 Depth=1
	cmpq	$100, -16(%rbp)
	jae	.LBB6_5
# %bb.4:
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_10
.LBB6_5:                                #   in Loop: Header=BB6_1 Depth=1
	cmpq	$1000, -16(%rbp)                # imm = 0x3E8
	jae	.LBB6_7
# %bb.6:
	movl	-20(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_10
.LBB6_7:                                #   in Loop: Header=BB6_1 Depth=1
	cmpq	$10000, -16(%rbp)               # imm = 0x2710
	jae	.LBB6_9
# %bb.8:
	movl	-20(%rbp), %eax
	addl	$3, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_10
.LBB6_9:                                #   in Loop: Header=BB6_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$10000, %ecx                    # imm = 0x2710
	xorl	%edx, %edx
                                        # kill: def $rdx killed $edx
	divq	%rcx
	movq	%rax, -16(%rbp)
	movl	-20(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB6_1
.LBB6_10:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	countDigits, .Lfunc_end6-countDigits
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function hi_malloc
	.type	hi_malloc,@function
hi_malloc:                              # @hi_malloc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	hiredisAllocFns@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rdi
	callq	*%rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	hi_malloc, .Lfunc_end7-hi_malloc
	.cfi_endproc
                                        # -- End function
	.globl	redisFormatCommand              # -- Begin function redisFormatCommand
	.p2align	4, 0x90
	.type	redisFormatCommand,@function
redisFormatCommand:                     # @redisFormatCommand
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$240, %rsp
	testb	%al, %al
	je	.LBB8_4
# %bb.3:
	movaps	%xmm0, -192(%rbp)
	movaps	%xmm1, -176(%rbp)
	movaps	%xmm2, -160(%rbp)
	movaps	%xmm3, -144(%rbp)
	movaps	%xmm4, -128(%rbp)
	movaps	%xmm5, -112(%rbp)
	movaps	%xmm6, -96(%rbp)
	movaps	%xmm7, -80(%rbp)
.LBB8_4:
	movq	%r9, -200(%rbp)
	movq	%r8, -208(%rbp)
	movq	%rcx, -216(%rbp)
	movq	%rdx, -224(%rbp)
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	-48(%rbp), %rax
	leaq	-240(%rbp), %rcx
	movq	%rcx, 16(%rax)
	leaq	16(%rbp), %rcx
	movq	%rcx, 8(%rax)
	movl	$48, 4(%rax)
	movl	$16, (%rax)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	callq	redisvFormatCommand@PLT
	movl	%eax, -52(%rbp)
	leaq	-48(%rbp), %rax
	cmpl	$0, -52(%rbp)
	jge	.LBB8_2
# %bb.1:
	movl	$-1, -52(%rbp)
.LBB8_2:
	movl	-52(%rbp), %eax
	addq	$240, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	redisFormatCommand, .Lfunc_end8-redisFormatCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisFormatSdsCommandArgv       # -- Begin function redisFormatSdsCommandArgv
	.p2align	4, 0x90
	.type	redisFormatSdsCommandArgv,@function
redisFormatSdsCommandArgv:              # @redisFormatSdsCommandArgv
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB9_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB9_24
.LBB9_2:
	movslq	-20(%rbp), %rdi
	callq	countDigits
	addl	$1, %eax
	addl	$2, %eax
	movl	%eax, %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -64(%rbp)
	movl	$0, -68(%rbp)
.LBB9_3:                                # =>This Inner Loop Header: Depth=1
	movl	-68(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB9_9
# %bb.4:                                #   in Loop: Header=BB9_3 Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB9_6
# %bb.5:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-40(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -88(%rbp)                 # 8-byte Spill
	jmp	.LBB9_7
.LBB9_6:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-32(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	strlen@PLT
	movq	%rax, -88(%rbp)                 # 8-byte Spill
.LBB9_7:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-88(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rdi
	callq	bulklen
	addq	-64(%rbp), %rax
	movq	%rax, -64(%rbp)
# %bb.8:                                #   in Loop: Header=BB9_3 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB9_3
.LBB9_9:
	callq	sdsempty@PLT
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB9_11
# %bb.10:
	movl	$-1, -4(%rbp)
	jmp	.LBB9_24
.LBB9_11:
	movq	-48(%rbp), %rdi
	movq	-64(%rbp), %rsi
	callq	sdsMakeRoomFor@PLT
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB9_13
# %bb.12:
	movq	-48(%rbp), %rdi
	callq	sdsfree@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB9_24
.LBB9_13:
	movq	-56(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rdi
	movl	-20(%rbp), %edx
	leaq	.L.str.6(%rip), %rsi
	movb	$0, %al
	callq	sdscatfmt@PLT
	movq	%rax, -48(%rbp)
	movl	$0, -68(%rbp)
.LBB9_14:                               # =>This Inner Loop Header: Depth=1
	movl	-68(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB9_20
# %bb.15:                               #   in Loop: Header=BB9_14 Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB9_17
# %bb.16:                               #   in Loop: Header=BB9_14 Depth=1
	movq	-40(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -96(%rbp)                 # 8-byte Spill
	jmp	.LBB9_18
.LBB9_17:                               #   in Loop: Header=BB9_14 Depth=1
	movq	-32(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	strlen@PLT
	movq	%rax, -96(%rbp)                 # 8-byte Spill
.LBB9_18:                               #   in Loop: Header=BB9_14 Depth=1
	movq	-96(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -80(%rbp)
	movq	-48(%rbp), %rdi
	movq	-80(%rbp), %rdx
	leaq	.L.str.7(%rip), %rsi
	movb	$0, %al
	callq	sdscatfmt@PLT
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movq	(%rax,%rcx,8), %rsi
	movq	-80(%rbp), %rdx
	callq	sdscatlen@PLT
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rdi
	leaq	.L.str.8(%rip), %rsi
	movl	$2, %edx
	callq	sdscatlen@PLT
	movq	%rax, -48(%rbp)
# %bb.19:                               #   in Loop: Header=BB9_14 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB9_14
.LBB9_20:
	movq	-48(%rbp), %rdi
	callq	sdslen
	cmpq	-64(%rbp), %rax
	jne	.LBB9_22
# %bb.21:
	jmp	.LBB9_23
.LBB9_22:
	leaq	.L.str.9(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$610, %edx                      # imm = 0x262
	leaq	.L__PRETTY_FUNCTION__.redisFormatSdsCommandArgv(%rip), %rcx
	callq	__assert_fail@PLT
.LBB9_23:
	movq	-48(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-64(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -4(%rbp)
.LBB9_24:
	movl	-4(%rbp), %eax
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	redisFormatSdsCommandArgv, .Lfunc_end9-redisFormatSdsCommandArgv
	.cfi_endproc
                                        # -- End function
	.globl	redisFreeSdsCommand             # -- Begin function redisFreeSdsCommand
	.p2align	4, 0x90
	.type	redisFreeSdsCommand,@function
redisFreeSdsCommand:                    # @redisFreeSdsCommand
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
	callq	sdsfree@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	redisFreeSdsCommand, .Lfunc_end10-redisFreeSdsCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisFormatCommandArgv          # -- Begin function redisFormatCommandArgv
	.p2align	4, 0x90
	.type	redisFormatCommandArgv,@function
redisFormatCommandArgv:                 # @redisFormatCommandArgv
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	$0, -48(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB11_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB11_22
.LBB11_2:
	movslq	-20(%rbp), %rdi
	callq	countDigits
	addl	$1, %eax
	addl	$2, %eax
	movl	%eax, -68(%rbp)
	movl	$0, -72(%rbp)
.LBB11_3:                               # =>This Inner Loop Header: Depth=1
	movl	-72(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB11_9
# %bb.4:                                #   in Loop: Header=BB11_3 Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB11_6
# %bb.5:                                #   in Loop: Header=BB11_3 Depth=1
	movq	-40(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -80(%rbp)                 # 8-byte Spill
	jmp	.LBB11_7
.LBB11_6:                               #   in Loop: Header=BB11_3 Depth=1
	movq	-32(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	strlen@PLT
	movq	%rax, -80(%rbp)                 # 8-byte Spill
.LBB11_7:                               #   in Loop: Header=BB11_3 Depth=1
	movq	-80(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rdi
	callq	bulklen
	movq	%rax, %rcx
	movslq	-68(%rbp), %rax
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -68(%rbp)
# %bb.8:                                #   in Loop: Header=BB11_3 Depth=1
	movl	-72(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -72(%rbp)
	jmp	.LBB11_3
.LBB11_9:
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rdi
	callq	hi_malloc
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB11_11
# %bb.10:
	movl	$-1, -4(%rbp)
	jmp	.LBB11_22
.LBB11_11:
	movq	-48(%rbp), %rdi
	movl	-20(%rbp), %edx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	sprintf@PLT
	movl	%eax, -52(%rbp)
	movl	$0, -72(%rbp)
.LBB11_12:                              # =>This Inner Loop Header: Depth=1
	movl	-72(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB11_18
# %bb.13:                               #   in Loop: Header=BB11_12 Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB11_15
# %bb.14:                               #   in Loop: Header=BB11_12 Depth=1
	movq	-40(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -88(%rbp)                 # 8-byte Spill
	jmp	.LBB11_16
.LBB11_15:                              #   in Loop: Header=BB11_12 Depth=1
	movq	-32(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	strlen@PLT
	movq	%rax, -88(%rbp)                 # 8-byte Spill
.LBB11_16:                              #   in Loop: Header=BB11_12 Depth=1
	movq	-88(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -64(%rbp)
	movq	-48(%rbp), %rdi
	movslq	-52(%rbp), %rax
	addq	%rax, %rdi
	movq	-64(%rbp), %rdx
	leaq	.L.str.3(%rip), %rsi
	movb	$0, %al
	callq	sprintf@PLT
	addl	-52(%rbp), %eax
	movl	%eax, -52(%rbp)
	movq	-48(%rbp), %rdi
	movslq	-52(%rbp), %rax
	addq	%rax, %rdi
	movq	-32(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movq	(%rax,%rcx,8), %rsi
	movq	-64(%rbp), %rdx
	callq	memcpy@PLT
	movq	-64(%rbp), %rcx
	movslq	-52(%rbp), %rax
	addq	%rcx, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -52(%rbp)
	movq	-48(%rbp), %rax
	movl	-52(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -52(%rbp)
	movslq	%ecx, %rcx
	movb	$13, (%rax,%rcx)
	movq	-48(%rbp), %rax
	movl	-52(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -52(%rbp)
	movslq	%ecx, %rcx
	movb	$10, (%rax,%rcx)
# %bb.17:                               #   in Loop: Header=BB11_12 Depth=1
	movl	-72(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -72(%rbp)
	jmp	.LBB11_12
.LBB11_18:
	movl	-52(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jne	.LBB11_20
# %bb.19:
	jmp	.LBB11_21
.LBB11_20:
	leaq	.L.str.4(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$656, %edx                      # imm = 0x290
	leaq	.L__PRETTY_FUNCTION__.redisFormatCommandArgv(%rip), %rcx
	callq	__assert_fail@PLT
.LBB11_21:
	movq	-48(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movq	-48(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movl	-68(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB11_22:
	movl	-4(%rbp), %eax
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	redisFormatCommandArgv, .Lfunc_end11-redisFormatCommandArgv
	.cfi_endproc
                                        # -- End function
	.globl	redisFreeCommand                # -- Begin function redisFreeCommand
	.p2align	4, 0x90
	.type	redisFreeCommand,@function
redisFreeCommand:                       # @redisFreeCommand
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
	callq	hi_free
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	redisFreeCommand, .Lfunc_end12-redisFreeCommand
	.cfi_endproc
                                        # -- End function
	.globl	__redisSetError                 # -- Begin function __redisSetError
	.p2align	4, 0x90
	.type	__redisSetError,@function
__redisSetError:                        # @__redisSetError
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
	movq	%rdx, -24(%rbp)
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 8(%rax)
	cmpq	$0, -24(%rbp)
	je	.LBB13_5
# %bb.1:
	movq	-24(%rbp), %rdi
	callq	strlen@PLT
	movq	%rax, -32(%rbp)
	cmpq	$127, -32(%rbp)
	jae	.LBB13_3
# %bb.2:
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	jmp	.LBB13_4
.LBB13_3:
	movl	$127, %eax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	jmp	.LBB13_4
.LBB13_4:
	movq	-40(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rdi
	addq	$12, %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	memcpy@PLT
	movq	-8(%rbp), %rax
	movq	-32(%rbp), %rcx
	movb	$0, 12(%rax,%rcx)
	jmp	.LBB13_9
.LBB13_5:
	cmpl	$1, -12(%rbp)
	jne	.LBB13_7
# %bb.6:
	jmp	.LBB13_8
.LBB13_7:
	leaq	.L.str.10(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$678, %edx                      # imm = 0x2A6
	leaq	.L__PRETTY_FUNCTION__.__redisSetError(%rip), %rcx
	callq	__assert_fail@PLT
.LBB13_8:
	callq	__errno_location@PLT
	movl	(%rax), %edi
	movq	-8(%rbp), %rsi
	addq	$12, %rsi
	movl	$128, %edx
	callq	__xpg_strerror_r@PLT
.LBB13_9:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	__redisSetError, .Lfunc_end13-__redisSetError
	.cfi_endproc
                                        # -- End function
	.globl	redisReaderCreate               # -- Begin function redisReaderCreate
	.p2align	4, 0x90
	.type	redisReaderCreate,@function
redisReaderCreate:                      # @redisReaderCreate
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	leaq	defaultFunctions(%rip), %rdi
	callq	redisReaderCreateWithFunctions@PLT
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end14:
	.size	redisReaderCreate, .Lfunc_end14-redisReaderCreate
	.cfi_endproc
                                        # -- End function
	.globl	redisFree                       # -- Begin function redisFree
	.p2align	4, 0x90
	.type	redisFree,@function
redisFree:                              # @redisFree
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.LBB15_2
# %bb.1:
	jmp	.LBB15_8
.LBB15_2:
	movq	-8(%rbp), %rdi
	callq	redisNetClose@PLT
	movq	-8(%rbp), %rax
	movq	152(%rax), %rdi
	callq	sdsfree@PLT
	movq	-8(%rbp), %rax
	movq	160(%rax), %rdi
	callq	redisReaderFree@PLT
	movq	-8(%rbp), %rax
	movq	192(%rax), %rdi
	callq	hi_free
	movq	-8(%rbp), %rax
	movq	200(%rax), %rdi
	callq	hi_free
	movq	-8(%rbp), %rax
	movq	216(%rax), %rdi
	callq	hi_free
	movq	-8(%rbp), %rax
	movq	176(%rax), %rdi
	callq	hi_free
	movq	-8(%rbp), %rax
	movq	184(%rax), %rdi
	callq	hi_free
	movq	-8(%rbp), %rax
	movq	224(%rax), %rdi
	callq	hi_free
	movq	-8(%rbp), %rax
	cmpq	$0, 240(%rax)
	je	.LBB15_5
# %bb.3:
	movq	-8(%rbp), %rax
	cmpq	$0, 248(%rax)
	je	.LBB15_5
# %bb.4:
	movq	-8(%rbp), %rax
	movq	248(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	240(%rcx), %rdi
	callq	*%rax
.LBB15_5:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpq	$0, (%rax)
	je	.LBB15_7
# %bb.6:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	256(%rcx), %rdi
	callq	*%rax
.LBB15_7:
	movq	-8(%rbp), %rdi
	movl	$255, %esi
	movl	$272, %edx                      # imm = 0x110
	callq	memset@PLT
	movq	-8(%rbp), %rdi
	callq	hi_free
.LBB15_8:
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	redisFree, .Lfunc_end15-redisFree
	.cfi_endproc
                                        # -- End function
	.globl	redisFreeKeepFd                 # -- Begin function redisFreeKeepFd
	.p2align	4, 0x90
	.type	redisFreeKeepFd,@function
redisFreeKeepFd:                        # @redisFreeKeepFd
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
	movl	140(%rax), %eax
	movl	%eax, -12(%rbp)
	movq	-8(%rbp), %rax
	movl	$-1, 140(%rax)
	movq	-8(%rbp), %rdi
	callq	redisFree@PLT
	movl	-12(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end16:
	.size	redisFreeKeepFd, .Lfunc_end16-redisFreeKeepFd
	.cfi_endproc
                                        # -- End function
	.globl	redisReconnect                  # -- Begin function redisReconnect
	.p2align	4, 0x90
	.type	redisReconnect,@function
redisReconnect:                         # @redisReconnect
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
	movl	$0, 8(%rax)
	movq	-16(%rbp), %rax
	addq	$12, %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rdi
	addq	$12, %rdi
	callq	strlen@PLT
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %rdx
	xorl	%esi, %esi
	callq	memset@PLT
	movq	-16(%rbp), %rax
	cmpq	$0, 256(%rax)
	je	.LBB17_3
# %bb.1:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	$0, (%rax)
	je	.LBB17_3
# %bb.2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	256(%rcx), %rdi
	callq	*%rax
	movq	-16(%rbp), %rax
	movq	$0, 256(%rax)
.LBB17_3:
	movq	-16(%rbp), %rdi
	callq	redisNetClose@PLT
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	callq	sdsfree@PLT
	movq	-16(%rbp), %rax
	movq	160(%rax), %rdi
	callq	redisReaderFree@PLT
	callq	sdsempty@PLT
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 152(%rax)
	callq	redisReaderCreate@PLT
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 160(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 152(%rax)
	je	.LBB17_5
# %bb.4:
	movq	-16(%rbp), %rax
	cmpq	$0, 160(%rax)
	jne	.LBB17_6
.LBB17_5:
	movq	-16(%rbp), %rdi
	movl	$5, %esi
	leaq	.L.str.11(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB17_17
.LBB17_6:
	movl	$-1, -20(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 168(%rax)
	jne	.LBB17_8
# %bb.7:
	movq	-16(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	192(%rax), %rsi
	movq	-16(%rbp), %rax
	movl	208(%rax), %edx
	movq	-16(%rbp), %rax
	movq	176(%rax), %rcx
	movq	-16(%rbp), %rax
	movq	200(%rax), %r8
	callq	redisContextConnectBindTcp@PLT
	movl	%eax, -20(%rbp)
	jmp	.LBB17_12
.LBB17_8:
	movq	-16(%rbp), %rax
	cmpl	$1, 168(%rax)
	jne	.LBB17_10
# %bb.9:
	movq	-16(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	216(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	176(%rax), %rdx
	callq	redisContextConnectUnix@PLT
	movl	%eax, -20(%rbp)
	jmp	.LBB17_11
.LBB17_10:
	movq	-16(%rbp), %rdi
	movl	$2, %esi
	leaq	.L.str.12(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -20(%rbp)
.LBB17_11:
	jmp	.LBB17_12
.LBB17_12:
	movq	-16(%rbp), %rax
	cmpq	$0, 184(%rax)
	je	.LBB17_16
# %bb.13:
	movq	-16(%rbp), %rax
	movl	144(%rax), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB17_16
# %bb.14:
	movq	-16(%rbp), %rax
	cmpl	$-1, 140(%rax)
	je	.LBB17_16
# %bb.15:
	movq	-16(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	184(%rax), %rax
	movq	(%rax), %rsi
	movq	8(%rax), %rdx
	callq	redisContextSetTimeout@PLT
.LBB17_16:
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB17_17:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	redisReconnect, .Lfunc_end17-redisReconnect
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectWithOptions         # -- Begin function redisConnectWithOptions
	.p2align	4, 0x90
	.type	redisConnectWithOptions,@function
redisConnectWithOptions:                # @redisConnectWithOptions
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	callq	redisContextInit
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB18_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB18_30
.LBB18_2:
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	jne	.LBB18_4
# %bb.3:
	movq	-24(%rbp), %rax
	movl	144(%rax), %ecx
	orl	$1, %ecx
	movl	%ecx, 144(%rax)
.LBB18_4:
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	andl	$2, %eax
	cmpl	$0, %eax
	je	.LBB18_6
# %bb.5:
	movq	-24(%rbp), %rax
	movl	144(%rax), %ecx
	orl	$128, %ecx
	movl	%ecx, 144(%rax)
.LBB18_6:
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	andl	$4, %eax
	cmpl	$0, %eax
	je	.LBB18_8
# %bb.7:
	movq	-24(%rbp), %rax
	movl	144(%rax), %ecx
	orl	$512, %ecx                      # imm = 0x200
	movl	%ecx, 144(%rax)
.LBB18_8:
	movq	-16(%rbp), %rax
	cmpq	$0, 64(%rax)
	je	.LBB18_10
# %bb.9:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	64(%rax), %rsi
	callq	redisSetPushCallback@PLT
	jmp	.LBB18_13
.LBB18_10:
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	andl	$8, %eax
	cmpl	$0, %eax
	jne	.LBB18_12
# %bb.11:
	movq	-24(%rbp), %rdi
	leaq	redisPushAutoFree(%rip), %rsi
	callq	redisSetPushCallback@PLT
.LBB18_12:
	jmp	.LBB18_13
.LBB18_13:
	movq	-16(%rbp), %rax
	movq	48(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 240(%rax)
	movq	-16(%rbp), %rax
	movq	56(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 248(%rax)
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	8(%rax), %rsi
	callq	redisContextUpdateConnectTimeout@PLT
	cmpl	$0, %eax
	jne	.LBB18_15
# %bb.14:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	16(%rax), %rsi
	callq	redisContextUpdateCommandTimeout@PLT
	cmpl	$0, %eax
	je	.LBB18_16
.LBB18_15:
	movq	-24(%rbp), %rdi
	movl	$5, %esi
	leaq	.L.str.11(%rip), %rdx
	callq	__redisSetError@PLT
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB18_30
.LBB18_16:
	movq	-16(%rbp), %rax
	cmpl	$0, (%rax)
	jne	.LBB18_18
# %bb.17:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	32(%rax), %rsi
	movq	-16(%rbp), %rax
	movl	40(%rax), %edx
	movq	-16(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-16(%rbp), %rax
	movq	24(%rax), %r8
	callq	redisContextConnectBindTcp@PLT
	jmp	.LBB18_25
.LBB18_18:
	movq	-16(%rbp), %rax
	cmpl	$1, (%rax)
	jne	.LBB18_20
# %bb.19:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	24(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	callq	redisContextConnectUnix@PLT
	jmp	.LBB18_24
.LBB18_20:
	movq	-16(%rbp), %rax
	cmpl	$2, (%rax)
	jne	.LBB18_22
# %bb.21:
	movq	-16(%rbp), %rax
	movl	24(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, 140(%rax)
	movq	-24(%rbp), %rax
	movl	144(%rax), %ecx
	orl	$2, %ecx
	movl	%ecx, 144(%rax)
	jmp	.LBB18_23
.LBB18_22:
	movq	$0, -8(%rbp)
	jmp	.LBB18_30
.LBB18_23:
	jmp	.LBB18_24
.LBB18_24:
	jmp	.LBB18_25
.LBB18_25:
	movq	-16(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB18_29
# %bb.26:
	movq	-24(%rbp), %rax
	movl	144(%rax), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB18_29
# %bb.27:
	movq	-24(%rbp), %rax
	cmpl	$-1, 140(%rax)
	je	.LBB18_29
# %bb.28:
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	(%rax), %rsi
	movq	8(%rax), %rdx
	callq	redisContextSetTimeout@PLT
.LBB18_29:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB18_30:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end18:
	.size	redisConnectWithOptions, .Lfunc_end18-redisConnectWithOptions
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function redisContextInit
	.type	redisContextInit,@function
redisContextInit:                       # @redisContextInit
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$1, %edi
	movl	$272, %esi                      # imm = 0x110
	callq	hi_calloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB19_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB19_6
.LBB19_2:
	movq	-16(%rbp), %rax
	leaq	redisContextDefaultFuncs(%rip), %rcx
	movq	%rcx, (%rax)
	callq	sdsempty@PLT
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 152(%rax)
	callq	redisReaderCreate@PLT
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 160(%rax)
	movq	-16(%rbp), %rax
	movl	$-1, 140(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 152(%rax)
	je	.LBB19_4
# %bb.3:
	movq	-16(%rbp), %rax
	cmpq	$0, 160(%rax)
	jne	.LBB19_5
.LBB19_4:
	movq	-16(%rbp), %rdi
	callq	redisFree@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB19_6
.LBB19_5:
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB19_6:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	redisContextInit, .Lfunc_end19-redisContextInit
	.cfi_endproc
                                        # -- End function
	.globl	redisSetPushCallback            # -- Begin function redisSetPushCallback
	.p2align	4, 0x90
	.type	redisSetPushCallback,@function
redisSetPushCallback:                   # @redisSetPushCallback
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
	movq	264(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 264(%rax)
	movq	-24(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end20:
	.size	redisSetPushCallback, .Lfunc_end20-redisSetPushCallback
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function redisPushAutoFree
	.type	redisPushAutoFree,@function
redisPushAutoFree:                      # @redisPushAutoFree
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdi
	callq	freeReplyObject@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end21:
	.size	redisPushAutoFree, .Lfunc_end21-redisPushAutoFree
	.cfi_endproc
                                        # -- End function
	.globl	redisConnect                    # -- Begin function redisConnect
	.p2align	4, 0x90
	.type	redisConnect,@function
redisConnect:                           # @redisConnect
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
	leaq	-96(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$0, -96(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -56(%rbp)
	leaq	-96(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end22:
	.size	redisConnect, .Lfunc_end22-redisConnect
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectWithTimeout         # -- Begin function redisConnectWithTimeout
	.p2align	4, 0x90
	.type	redisConnectWithTimeout,@function
redisConnectWithTimeout:                # @redisConnectWithTimeout
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%rdx, -16(%rbp)
	movq	%rcx, -8(%rbp)
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	leaq	-112(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$0, -112(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -80(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -72(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, -104(%rbp)
	leaq	-112(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end23:
	.size	redisConnectWithTimeout, .Lfunc_end23-redisConnectWithTimeout
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectNonBlock            # -- Begin function redisConnectNonBlock
	.p2align	4, 0x90
	.type	redisConnectNonBlock,@function
redisConnectNonBlock:                   # @redisConnectNonBlock
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
	leaq	-96(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$0, -96(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-92(%rbp), %eax
	orl	$1, %eax
	movl	%eax, -92(%rbp)
	leaq	-96(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end24:
	.size	redisConnectNonBlock, .Lfunc_end24-redisConnectNonBlock
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectBindNonBlock        # -- Begin function redisConnectBindNonBlock
	.p2align	4, 0x90
	.type	redisConnectBindNonBlock,@function
redisConnectBindNonBlock:               # @redisConnectBindNonBlock
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	leaq	-104(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$0, -104(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -72(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -64(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -80(%rbp)
	movl	-100(%rbp), %eax
	orl	$1, %eax
	movl	%eax, -100(%rbp)
	leaq	-104(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end25:
	.size	redisConnectBindNonBlock, .Lfunc_end25-redisConnectBindNonBlock
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectBindNonBlockWithReuse # -- Begin function redisConnectBindNonBlockWithReuse
	.p2align	4, 0x90
	.type	redisConnectBindNonBlockWithReuse,@function
redisConnectBindNonBlockWithReuse:      # @redisConnectBindNonBlockWithReuse
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	leaq	-104(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$0, -104(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -72(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -64(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -80(%rbp)
	movl	-100(%rbp), %eax
	orl	$3, %eax
	movl	%eax, -100(%rbp)
	leaq	-104(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end26:
	.size	redisConnectBindNonBlockWithReuse, .Lfunc_end26-redisConnectBindNonBlockWithReuse
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectUnix                # -- Begin function redisConnectUnix
	.p2align	4, 0x90
	.type	redisConnectUnix,@function
redisConnectUnix:                       # @redisConnectUnix
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -8(%rbp)
	leaq	-88(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$1, -88(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -64(%rbp)
	leaq	-88(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end27:
	.size	redisConnectUnix, .Lfunc_end27-redisConnectUnix
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectUnixWithTimeout     # -- Begin function redisConnectUnixWithTimeout
	.p2align	4, 0x90
	.type	redisConnectUnixWithTimeout,@function
redisConnectUnixWithTimeout:            # @redisConnectUnixWithTimeout
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%rsi, -16(%rbp)
	movq	%rdx, -8(%rbp)
	movq	%rdi, -24(%rbp)
	leaq	-104(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$1, -104(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -80(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, -96(%rbp)
	leaq	-104(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end28:
	.size	redisConnectUnixWithTimeout, .Lfunc_end28-redisConnectUnixWithTimeout
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectUnixNonBlock        # -- Begin function redisConnectUnixNonBlock
	.p2align	4, 0x90
	.type	redisConnectUnixNonBlock,@function
redisConnectUnixNonBlock:               # @redisConnectUnixNonBlock
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -8(%rbp)
	leaq	-88(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$1, -88(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	-84(%rbp), %eax
	orl	$1, %eax
	movl	%eax, -84(%rbp)
	leaq	-88(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end29:
	.size	redisConnectUnixNonBlock, .Lfunc_end29-redisConnectUnixNonBlock
	.cfi_endproc
                                        # -- End function
	.globl	redisConnectFd                  # -- Begin function redisConnectFd
	.p2align	4, 0x90
	.type	redisConnectFd,@function
redisConnectFd:                         # @redisConnectFd
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movl	%edi, -4(%rbp)
	leaq	-88(%rbp), %rdi
	xorl	%esi, %esi
	movl	$80, %edx
	callq	memset@PLT
	movl	$2, -88(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -64(%rbp)
	leaq	-88(%rbp), %rdi
	callq	redisConnectWithOptions@PLT
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end30:
	.size	redisConnectFd, .Lfunc_end30-redisConnectFd
	.cfi_endproc
                                        # -- End function
	.globl	redisSetTimeout                 # -- Begin function redisSetTimeout
	.p2align	4, 0x90
	.type	redisSetTimeout,@function
redisSetTimeout:                        # @redisSetTimeout
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rsi, -24(%rbp)
	movq	%rdx, -16(%rbp)
	movq	%rdi, -32(%rbp)
	movq	-32(%rbp), %rax
	movl	144(%rax), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB31_2
# %bb.1:
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rdx
	callq	redisContextSetTimeout@PLT
	movl	%eax, -4(%rbp)
	jmp	.LBB31_3
.LBB31_2:
	movl	$-1, -4(%rbp)
.LBB31_3:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end31:
	.size	redisSetTimeout, .Lfunc_end31-redisSetTimeout
	.cfi_endproc
                                        # -- End function
	.globl	redisEnableKeepAlive            # -- Begin function redisEnableKeepAlive
	.p2align	4, 0x90
	.type	redisEnableKeepAlive,@function
redisEnableKeepAlive:                   # @redisEnableKeepAlive
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rdi
	movl	$15, %esi
	callq	redisKeepAlive@PLT
	cmpl	$0, %eax
	je	.LBB32_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB32_3
.LBB32_2:
	movl	$0, -4(%rbp)
.LBB32_3:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end32:
	.size	redisEnableKeepAlive, .Lfunc_end32-redisEnableKeepAlive
	.cfi_endproc
                                        # -- End function
	.globl	redisBufferRead                 # -- Begin function redisBufferRead
	.p2align	4, 0x90
	.type	redisBufferRead,@function
redisBufferRead:                        # @redisBufferRead
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16416, %rsp                    # imm = 0x4020
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 8(%rax)
	je	.LBB33_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB33_11
.LBB33_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	24(%rax), %rax
	movq	-16(%rbp), %rdi
	leaq	-16400(%rbp), %rsi
	movl	$16384, %edx                    # imm = 0x4000
	callq	*%rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -16404(%rbp)
	cmpl	$0, -16404(%rbp)
	jle	.LBB33_7
# %bb.3:
	movq	-16(%rbp), %rax
	movq	160(%rax), %rdi
	leaq	-16400(%rbp), %rsi
	movslq	-16404(%rbp), %rdx
	callq	redisReaderFeed@PLT
	cmpl	$0, %eax
	je	.LBB33_5
# %bb.4:
	movq	-16(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	160(%rax), %rax
	movl	(%rax), %esi
	movq	-16(%rbp), %rax
	movq	160(%rax), %rdx
	addq	$4, %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB33_11
.LBB33_5:
	jmp	.LBB33_6
.LBB33_6:
	jmp	.LBB33_10
.LBB33_7:
	cmpl	$0, -16404(%rbp)
	jge	.LBB33_9
# %bb.8:
	movl	$-1, -4(%rbp)
	jmp	.LBB33_11
.LBB33_9:
	jmp	.LBB33_10
.LBB33_10:
	movl	$0, -4(%rbp)
.LBB33_11:
	movl	-4(%rbp), %eax
	addq	$16416, %rsp                    # imm = 0x4020
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end33:
	.size	redisBufferRead, .Lfunc_end33-redisBufferRead
	.cfi_endproc
                                        # -- End function
	.globl	redisBufferWrite                # -- Begin function redisBufferWrite
	.p2align	4, 0x90
	.type	redisBufferWrite,@function
redisBufferWrite:                       # @redisBufferWrite
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
	movq	-16(%rbp), %rax
	cmpl	$0, 8(%rax)
	je	.LBB34_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB34_20
.LBB34_2:
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	callq	sdslen
	cmpq	$0, %rax
	jbe	.LBB34_16
# %bb.3:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	32(%rax), %rax
	movq	-16(%rbp), %rdi
	callq	*%rax
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jge	.LBB34_5
# %bb.4:
	movl	$-1, -4(%rbp)
	jmp	.LBB34_20
.LBB34_5:
	cmpq	$0, -32(%rbp)
	jle	.LBB34_14
# %bb.6:
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	callq	sdslen
	movq	%rax, %rcx
	movq	-40(%rbp), %rax                 # 8-byte Reload
	cmpq	%rcx, %rax
	jne	.LBB34_10
# %bb.7:
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	callq	sdsfree@PLT
	callq	sdsempty@PLT
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 152(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 152(%rax)
	jne	.LBB34_9
# %bb.8:
	jmp	.LBB34_19
.LBB34_9:
	jmp	.LBB34_13
.LBB34_10:
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	movq	-32(%rbp), %rsi
	movq	$-1, %rdx
	callq	sdsrange@PLT
	cmpl	$0, %eax
	jge	.LBB34_12
# %bb.11:
	jmp	.LBB34_19
.LBB34_12:
	jmp	.LBB34_13
.LBB34_13:
	jmp	.LBB34_14
.LBB34_14:
	jmp	.LBB34_15
.LBB34_15:
	jmp	.LBB34_16
.LBB34_16:
	cmpq	$0, -24(%rbp)
	je	.LBB34_18
# %bb.17:
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	callq	sdslen
	cmpq	$0, %rax
	sete	%al
	andb	$1, %al
	movzbl	%al, %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, (%rax)
.LBB34_18:
	movl	$0, -4(%rbp)
	jmp	.LBB34_20
.LBB34_19:
	movq	-16(%rbp), %rdi
	movl	$5, %esi
	leaq	.L.str.11(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
.LBB34_20:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end34:
	.size	redisBufferWrite, .Lfunc_end34-redisBufferWrite
	.cfi_endproc
                                        # -- End function
	.globl	redisGetReplyFromReader         # -- Begin function redisGetReplyFromReader
	.p2align	4, 0x90
	.type	redisGetReplyFromReader,@function
redisGetReplyFromReader:                # @redisGetReplyFromReader
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
	movq	160(%rax), %rdi
	movq	-24(%rbp), %rsi
	callq	redisReaderGetReply@PLT
	cmpl	$-1, %eax
	jne	.LBB35_2
# %bb.1:
	movq	-16(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	160(%rax), %rax
	movl	(%rax), %esi
	movq	-16(%rbp), %rax
	movq	160(%rax), %rdx
	addq	$4, %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB35_3
.LBB35_2:
	movl	$0, -4(%rbp)
.LBB35_3:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end35:
	.size	redisGetReplyFromReader, .Lfunc_end35-redisGetReplyFromReader
	.cfi_endproc
                                        # -- End function
	.globl	redisGetReply                   # -- Begin function redisGetReply
	.p2align	4, 0x90
	.type	redisGetReply,@function
redisGetReply:                          # @redisGetReply
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
	movl	$0, -28(%rbp)
	movq	$0, -40(%rbp)
	movq	-16(%rbp), %rdi
	leaq	-40(%rbp), %rsi
	callq	redisGetReplyFromReader@PLT
	cmpl	$-1, %eax
	jne	.LBB36_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_24
.LBB36_2:
	cmpq	$0, -40(%rbp)
	jne	.LBB36_20
# %bb.3:
	movq	-16(%rbp), %rax
	movl	144(%rax), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB36_20
# %bb.4:
	jmp	.LBB36_5
.LBB36_5:                               # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rdi
	leaq	-28(%rbp), %rsi
	callq	redisBufferWrite@PLT
	cmpl	$-1, %eax
	jne	.LBB36_7
# %bb.6:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_24
.LBB36_7:                               #   in Loop: Header=BB36_5 Depth=1
	jmp	.LBB36_8
.LBB36_8:                               #   in Loop: Header=BB36_5 Depth=1
	cmpl	$0, -28(%rbp)
	setne	%al
	xorb	$-1, %al
	testb	$1, %al
	jne	.LBB36_5
# %bb.9:
	jmp	.LBB36_10
.LBB36_10:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_13 Depth 2
	movq	-16(%rbp), %rdi
	callq	redisBufferRead@PLT
	cmpl	$-1, %eax
	jne	.LBB36_12
# %bb.11:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_24
.LBB36_12:                              #   in Loop: Header=BB36_10 Depth=1
	jmp	.LBB36_13
.LBB36_13:                              #   Parent Loop BB36_10 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rdi
	leaq	-40(%rbp), %rsi
	callq	redisGetReplyFromReader@PLT
	cmpl	$-1, %eax
	jne	.LBB36_15
# %bb.14:
	movl	$-1, -4(%rbp)
	jmp	.LBB36_24
.LBB36_15:                              #   in Loop: Header=BB36_13 Depth=2
	jmp	.LBB36_16
.LBB36_16:                              #   in Loop: Header=BB36_13 Depth=2
	movq	-16(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	redisHandledPushReply
	cmpl	$0, %eax
	jne	.LBB36_13
# %bb.17:                               #   in Loop: Header=BB36_10 Depth=1
	jmp	.LBB36_18
.LBB36_18:                              #   in Loop: Header=BB36_10 Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB36_10
# %bb.19:
	jmp	.LBB36_20
.LBB36_20:
	cmpq	$0, -24(%rbp)
	je	.LBB36_22
# %bb.21:
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	jmp	.LBB36_23
.LBB36_22:
	movq	-40(%rbp), %rdi
	callq	freeReplyObject@PLT
.LBB36_23:
	movl	$0, -4(%rbp)
.LBB36_24:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end36:
	.size	redisGetReply, .Lfunc_end36-redisGetReply
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function redisHandledPushReply
	.type	redisHandledPushReply,@function
redisHandledPushReply:                  # @redisHandledPushReply
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
	cmpq	$0, -24(%rbp)
	je	.LBB37_4
# %bb.1:
	movq	-16(%rbp), %rax
	cmpq	$0, 264(%rax)
	je	.LBB37_4
# %bb.2:
	movq	-24(%rbp), %rax
	cmpl	$12, (%rax)
	jne	.LBB37_4
# %bb.3:
	movq	-16(%rbp), %rax
	movq	264(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	240(%rcx), %rdi
	movq	-24(%rbp), %rsi
	callq	*%rax
	movl	$1, -4(%rbp)
	jmp	.LBB37_5
.LBB37_4:
	movl	$0, -4(%rbp)
.LBB37_5:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end37:
	.size	redisHandledPushReply, .Lfunc_end37-redisHandledPushReply
	.cfi_endproc
                                        # -- End function
	.globl	__redisAppendCommand            # -- Begin function __redisAppendCommand
	.p2align	4, 0x90
	.type	__redisAppendCommand,@function
__redisAppendCommand:                   # @__redisAppendCommand
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
	movq	-16(%rbp), %rax
	movq	152(%rax), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	sdscatlen@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB38_2
# %bb.1:
	movq	-16(%rbp), %rdi
	movl	$5, %esi
	leaq	.L.str.11(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB38_3
.LBB38_2:
	movq	-40(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 152(%rax)
	movl	$0, -4(%rbp)
.LBB38_3:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end38:
	.size	__redisAppendCommand, .Lfunc_end38-__redisAppendCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisAppendFormattedCommand     # -- Begin function redisAppendFormattedCommand
	.p2align	4, 0x90
	.type	redisAppendFormattedCommand,@function
redisAppendFormattedCommand:            # @redisAppendFormattedCommand
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
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	__redisAppendCommand@PLT
	cmpl	$0, %eax
	je	.LBB39_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB39_3
.LBB39_2:
	movl	$0, -4(%rbp)
.LBB39_3:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end39:
	.size	redisAppendFormattedCommand, .Lfunc_end39-redisAppendFormattedCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisvAppendCommand             # -- Begin function redisvAppendCommand
	.p2align	4, 0x90
	.type	redisvAppendCommand,@function
redisvAppendCommand:                    # @redisvAppendCommand
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
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	leaq	-40(%rbp), %rdi
	callq	redisvFormatCommand@PLT
	movl	%eax, -44(%rbp)
	cmpl	$-1, -44(%rbp)
	jne	.LBB40_2
# %bb.1:
	movq	-16(%rbp), %rdi
	movl	$5, %esi
	leaq	.L.str.11(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB40_8
.LBB40_2:
	cmpl	$-2, -44(%rbp)
	jne	.LBB40_4
# %bb.3:
	movq	-16(%rbp), %rdi
	movl	$2, %esi
	leaq	.L.str.13(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB40_8
.LBB40_4:
	jmp	.LBB40_5
.LBB40_5:
	movq	-16(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movslq	-44(%rbp), %rdx
	callq	__redisAppendCommand@PLT
	cmpl	$0, %eax
	je	.LBB40_7
# %bb.6:
	movq	-40(%rbp), %rdi
	callq	hi_free
	movl	$-1, -4(%rbp)
	jmp	.LBB40_8
.LBB40_7:
	movq	-40(%rbp), %rdi
	callq	hi_free
	movl	$0, -4(%rbp)
.LBB40_8:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end40:
	.size	redisvAppendCommand, .Lfunc_end40-redisvAppendCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisAppendCommand              # -- Begin function redisAppendCommand
	.p2align	4, 0x90
	.type	redisAppendCommand,@function
redisAppendCommand:                     # @redisAppendCommand
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$240, %rsp
	testb	%al, %al
	je	.LBB41_2
# %bb.1:
	movaps	%xmm0, -192(%rbp)
	movaps	%xmm1, -176(%rbp)
	movaps	%xmm2, -160(%rbp)
	movaps	%xmm3, -144(%rbp)
	movaps	%xmm4, -128(%rbp)
	movaps	%xmm5, -112(%rbp)
	movaps	%xmm6, -96(%rbp)
	movaps	%xmm7, -80(%rbp)
.LBB41_2:
	movq	%r9, -200(%rbp)
	movq	%r8, -208(%rbp)
	movq	%rcx, -216(%rbp)
	movq	%rdx, -224(%rbp)
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	-240(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	16(%rbp), %rax
	movq	%rax, -40(%rbp)
	movl	$48, -44(%rbp)
	movl	$16, -48(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	callq	redisvAppendCommand@PLT
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	addq	$240, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end41:
	.size	redisAppendCommand, .Lfunc_end41-redisAppendCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisAppendCommandArgv          # -- Begin function redisAppendCommandArgv
	.p2align	4, 0x90
	.type	redisAppendCommandArgv,@function
redisAppendCommandArgv:                 # @redisAppendCommandArgv
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	-20(%rbp), %esi
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rcx
	leaq	-48(%rbp), %rdi
	callq	redisFormatSdsCommandArgv@PLT
	movl	%eax, -52(%rbp)
	cmpl	$-1, -52(%rbp)
	jne	.LBB42_2
# %bb.1:
	movq	-16(%rbp), %rdi
	movl	$5, %esi
	leaq	.L.str.11(%rip), %rdx
	callq	__redisSetError@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB42_5
.LBB42_2:
	movq	-16(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movslq	-52(%rbp), %rdx
	callq	__redisAppendCommand@PLT
	cmpl	$0, %eax
	je	.LBB42_4
# %bb.3:
	movq	-48(%rbp), %rdi
	callq	sdsfree@PLT
	movl	$-1, -4(%rbp)
	jmp	.LBB42_5
.LBB42_4:
	movq	-48(%rbp), %rdi
	callq	sdsfree@PLT
	movl	$0, -4(%rbp)
.LBB42_5:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end42:
	.size	redisAppendCommandArgv, .Lfunc_end42-redisAppendCommandArgv
	.cfi_endproc
                                        # -- End function
	.globl	redisvCommand                   # -- Begin function redisvCommand
	.p2align	4, 0x90
	.type	redisvCommand,@function
redisvCommand:                          # @redisvCommand
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
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	redisvAppendCommand@PLT
	cmpl	$0, %eax
	je	.LBB43_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB43_3
.LBB43_2:
	movq	-16(%rbp), %rdi
	callq	__redisBlockForReply
	movq	%rax, -8(%rbp)
.LBB43_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end43:
	.size	redisvCommand, .Lfunc_end43-redisvCommand
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function __redisBlockForReply
	.type	__redisBlockForReply,@function
__redisBlockForReply:                   # @__redisBlockForReply
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
	movl	144(%rax), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB44_4
# %bb.1:
	movq	-16(%rbp), %rdi
	leaq	-24(%rbp), %rsi
	callq	redisGetReply@PLT
	cmpl	$0, %eax
	je	.LBB44_3
# %bb.2:
	movq	$0, -8(%rbp)
	jmp	.LBB44_5
.LBB44_3:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB44_5
.LBB44_4:
	movq	$0, -8(%rbp)
.LBB44_5:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end44:
	.size	__redisBlockForReply, .Lfunc_end44-__redisBlockForReply
	.cfi_endproc
                                        # -- End function
	.globl	redisCommand                    # -- Begin function redisCommand
	.p2align	4, 0x90
	.type	redisCommand,@function
redisCommand:                           # @redisCommand
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$240, %rsp
	testb	%al, %al
	je	.LBB45_2
# %bb.1:
	movaps	%xmm0, -192(%rbp)
	movaps	%xmm1, -176(%rbp)
	movaps	%xmm2, -160(%rbp)
	movaps	%xmm3, -144(%rbp)
	movaps	%xmm4, -128(%rbp)
	movaps	%xmm5, -112(%rbp)
	movaps	%xmm6, -96(%rbp)
	movaps	%xmm7, -80(%rbp)
.LBB45_2:
	movq	%r9, -200(%rbp)
	movq	%r8, -208(%rbp)
	movq	%rcx, -216(%rbp)
	movq	%rdx, -224(%rbp)
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	-240(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	16(%rbp), %rax
	movq	%rax, -40(%rbp)
	movl	$48, -44(%rbp)
	movl	$16, -48(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	callq	redisvCommand@PLT
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	addq	$240, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end45:
	.size	redisCommand, .Lfunc_end45-redisCommand
	.cfi_endproc
                                        # -- End function
	.globl	redisCommandArgv                # -- Begin function redisCommandArgv
	.p2align	4, 0x90
	.type	redisCommandArgv,@function
redisCommandArgv:                       # @redisCommandArgv
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
	movq	%rcx, -40(%rbp)
	movq	-16(%rbp), %rdi
	movl	-20(%rbp), %esi
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rcx
	callq	redisAppendCommandArgv@PLT
	cmpl	$0, %eax
	je	.LBB46_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB46_3
.LBB46_2:
	movq	-16(%rbp), %rdi
	callq	__redisBlockForReply
	movq	%rax, -8(%rbp)
.LBB46_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end46:
	.size	redisCommandArgv, .Lfunc_end46-redisCommandArgv
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createStringObject
	.type	createStringObject,@function
createStringObject:                     # @createStringObject
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
	movl	(%rax), %edi
	callq	createReplyObject
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB47_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB47_25
.LBB47_2:
	movq	-16(%rbp), %rax
	cmpl	$6, (%rax)
	je	.LBB47_6
# %bb.3:
	movq	-16(%rbp), %rax
	cmpl	$5, (%rax)
	je	.LBB47_6
# %bb.4:
	movq	-16(%rbp), %rax
	cmpl	$1, (%rax)
	je	.LBB47_6
# %bb.5:
	movq	-16(%rbp), %rax
	cmpl	$14, (%rax)
	jne	.LBB47_7
.LBB47_6:
	jmp	.LBB47_8
.LBB47_7:
	leaq	.L.str.14(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$132, %edx
	leaq	.L__PRETTY_FUNCTION__.createStringObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB47_8:
	movq	-16(%rbp), %rax
	cmpl	$14, (%rax)
	jne	.LBB47_12
# %bb.9:
	movq	-32(%rbp), %rdi
	subq	$4, %rdi
	addq	$1, %rdi
	callq	hi_malloc
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB47_11
# %bb.10:
	jmp	.LBB47_24
.LBB47_11:
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rcx
	movw	(%rcx), %dx
	movw	%dx, 40(%rax)
	movb	2(%rcx), %cl
	movb	%cl, 42(%rax)
	movq	-40(%rbp), %rax
	movb	$0, 43(%rax)
	movq	-56(%rbp), %rdi
	movq	-24(%rbp), %rsi
	addq	$4, %rsi
	movq	-32(%rbp), %rdx
	subq	$4, %rdx
	callq	memcpy@PLT
	movq	-56(%rbp), %rax
	movq	-32(%rbp), %rcx
	subq	$4, %rcx
	movb	$0, (%rax,%rcx)
	movq	-32(%rbp), %rcx
	subq	$4, %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, 24(%rax)
	jmp	.LBB47_15
.LBB47_12:
	movq	-32(%rbp), %rdi
	addq	$1, %rdi
	callq	hi_malloc
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB47_14
# %bb.13:
	jmp	.LBB47_24
.LBB47_14:
	movq	-56(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	memcpy@PLT
	movq	-56(%rbp), %rax
	movq	-32(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movq	-32(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, 24(%rax)
.LBB47_15:
	movq	-56(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB47_23
# %bb.16:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB47_20
# %bb.17:
	movq	-48(%rbp), %rax
	cmpl	$9, (%rax)
	je	.LBB47_20
# %bb.18:
	movq	-48(%rbp), %rax
	cmpl	$10, (%rax)
	je	.LBB47_20
# %bb.19:
	movq	-48(%rbp), %rax
	cmpl	$12, (%rax)
	jne	.LBB47_21
.LBB47_20:
	jmp	.LBB47_22
.LBB47_21:
	leaq	.L.str.15(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$159, %edx
	leaq	.L__PRETTY_FUNCTION__.createStringObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB47_22:
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movslq	16(%rcx), %rcx
	movq	%rdx, (%rax,%rcx,8)
.LBB47_23:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB47_25
.LBB47_24:
	movq	-40(%rbp), %rdi
	callq	freeReplyObject@PLT
	movq	$0, -8(%rbp)
.LBB47_25:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end47:
	.size	createStringObject, .Lfunc_end47-createStringObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createArrayObject
	.type	createArrayObject,@function
createArrayObject:                      # @createArrayObject
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
	movq	-16(%rbp), %rax
	movl	(%rax), %edi
	callq	createReplyObject
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB48_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB48_17
.LBB48_2:
	cmpq	$0, -24(%rbp)
	jbe	.LBB48_8
# %bb.3:
	movabsq	$2305843009213693951, %rax      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	-24(%rbp), %rax
	jae	.LBB48_5
# %bb.4:
	movq	$0, -8(%rbp)
	jmp	.LBB48_17
.LBB48_5:
	movq	-24(%rbp), %rdi
	movl	$8, %esi
	callq	hi_calloc
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 56(%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, 56(%rax)
	jne	.LBB48_7
# %bb.6:
	movq	-32(%rbp), %rdi
	callq	freeReplyObject@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB48_17
.LBB48_7:
	jmp	.LBB48_8
.LBB48_8:
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 48(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB48_16
# %bb.9:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB48_13
# %bb.10:
	movq	-40(%rbp), %rax
	cmpl	$9, (%rax)
	je	.LBB48_13
# %bb.11:
	movq	-40(%rbp), %rax
	cmpl	$10, (%rax)
	je	.LBB48_13
# %bb.12:
	movq	-40(%rbp), %rax
	cmpl	$12, (%rax)
	jne	.LBB48_14
.LBB48_13:
	jmp	.LBB48_15
.LBB48_14:
	leaq	.L.str.15(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$192, %edx
	leaq	.L__PRETTY_FUNCTION__.createArrayObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB48_15:
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movslq	16(%rcx), %rcx
	movq	%rdx, (%rax,%rcx,8)
.LBB48_16:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB48_17:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end48:
	.size	createArrayObject, .Lfunc_end48-createArrayObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createIntegerObject
	.type	createIntegerObject,@function
createIntegerObject:                    # @createIntegerObject
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
	movl	$3, %edi
	callq	createReplyObject
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB49_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB49_11
.LBB49_2:
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB49_10
# %bb.3:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB49_7
# %bb.4:
	movq	-40(%rbp), %rax
	cmpl	$9, (%rax)
	je	.LBB49_7
# %bb.5:
	movq	-40(%rbp), %rax
	cmpl	$10, (%rax)
	je	.LBB49_7
# %bb.6:
	movq	-40(%rbp), %rax
	cmpl	$12, (%rax)
	jne	.LBB49_8
.LBB49_7:
	jmp	.LBB49_9
.LBB49_8:
	leaq	.L.str.15(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$212, %edx
	leaq	.L__PRETTY_FUNCTION__.createIntegerObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB49_9:
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movslq	16(%rcx), %rcx
	movq	%rdx, (%rax,%rcx,8)
.LBB49_10:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB49_11:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end49:
	.size	createIntegerObject, .Lfunc_end49-createIntegerObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createDoubleObject
	.type	createDoubleObject,@function
createDoubleObject:                     # @createDoubleObject
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movsd	%xmm0, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$7, %edi
	callq	createReplyObject
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB50_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB50_12
.LBB50_2:
	movsd	-24(%rbp), %xmm0                # xmm0 = mem[0],zero
	movq	-48(%rbp), %rax
	movsd	%xmm0, 16(%rax)
	movq	-40(%rbp), %rdi
	addq	$1, %rdi
	callq	hi_malloc
	movq	%rax, %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-48(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB50_4
# %bb.3:
	movq	-48(%rbp), %rdi
	callq	freeReplyObject@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB50_12
.LBB50_4:
	movq	-48(%rbp), %rax
	movq	32(%rax), %rdi
	movq	-32(%rbp), %rsi
	movq	-40(%rbp), %rdx
	callq	memcpy@PLT
	movq	-48(%rbp), %rax
	movq	32(%rax), %rax
	movq	-40(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB50_11
# %bb.5:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB50_8
# %bb.6:
	movq	-56(%rbp), %rax
	cmpl	$9, (%rax)
	je	.LBB50_8
# %bb.7:
	movq	-56(%rbp), %rax
	cmpl	$10, (%rax)
	jne	.LBB50_9
.LBB50_8:
	jmp	.LBB50_10
.LBB50_9:
	leaq	.L.str.16(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$244, %edx
	leaq	.L__PRETTY_FUNCTION__.createDoubleObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB50_10:
	movq	-48(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movslq	16(%rcx), %rcx
	movq	%rdx, (%rax,%rcx,8)
.LBB50_11:
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB50_12:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end50:
	.size	createDoubleObject, .Lfunc_end50-createDoubleObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createNilObject
	.type	createNilObject,@function
createNilObject:                        # @createNilObject
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movl	$4, %edi
	callq	createReplyObject
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB51_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB51_10
.LBB51_2:
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB51_9
# %bb.3:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB51_6
# %bb.4:
	movq	-32(%rbp), %rax
	cmpl	$9, (%rax)
	je	.LBB51_6
# %bb.5:
	movq	-32(%rbp), %rax
	cmpl	$10, (%rax)
	jne	.LBB51_7
.LBB51_6:
	jmp	.LBB51_8
.LBB51_7:
	leaq	.L.str.16(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$261, %edx                      # imm = 0x105
	leaq	.L__PRETTY_FUNCTION__.createNilObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB51_8:
	movq	-24(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movslq	16(%rcx), %rcx
	movq	%rdx, (%rax,%rcx,8)
.LBB51_9:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB51_10:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end51:
	.size	createNilObject, .Lfunc_end51-createNilObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createBoolObject
	.type	createBoolObject,@function
createBoolObject:                       # @createBoolObject
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
	movl	$8, %edi
	callq	createReplyObject
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB52_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB52_10
.LBB52_2:
	cmpl	$0, -20(%rbp)
	setne	%al
	andb	$1, %al
	movzbl	%al, %eax
	movslq	%eax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB52_9
# %bb.3:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	cmpl	$2, (%rax)
	je	.LBB52_6
# %bb.4:
	movq	-40(%rbp), %rax
	cmpl	$9, (%rax)
	je	.LBB52_6
# %bb.5:
	movq	-40(%rbp), %rax
	cmpl	$10, (%rax)
	jne	.LBB52_7
.LBB52_6:
	jmp	.LBB52_8
.LBB52_7:
	leaq	.L.str.16(%rip), %rdi
	leaq	.L.str.5(%rip), %rsi
	movl	$280, %edx                      # imm = 0x118
	leaq	.L__PRETTY_FUNCTION__.createBoolObject(%rip), %rcx
	callq	__assert_fail@PLT
.LBB52_8:
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movslq	16(%rcx), %rcx
	movq	%rdx, (%rax,%rcx,8)
.LBB52_9:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB52_10:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end52:
	.size	createBoolObject, .Lfunc_end52-createBoolObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function createReplyObject
	.type	createReplyObject,@function
createReplyObject:                      # @createReplyObject
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -12(%rbp)
	movl	$1, %edi
	movl	$64, %esi
	callq	hi_calloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB53_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB53_3
.LBB53_2:
	movl	-12(%rbp), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, (%rax)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB53_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end53:
	.size	createReplyObject, .Lfunc_end53-createReplyObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function hi_calloc
	.type	hi_calloc,@function
hi_calloc:                              # @hi_calloc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	hiredisAllocFns@GOTPCREL(%rip), %rax
	movq	8(%rax), %rax
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	*%rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end54:
	.size	hi_calloc, .Lfunc_end54-hi_calloc
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%"
	.size	.L.str, 2

	.type	redisvFormatCommand.intfmts,@object # @redisvFormatCommand.intfmts
	.section	.rodata,"a",@progbits
redisvFormatCommand.intfmts:
	.asciz	"diouxX"
	.size	redisvFormatCommand.intfmts, 7

	.type	redisvFormatCommand.flags,@object # @redisvFormatCommand.flags
redisvFormatCommand.flags:
	.asciz	"#0-+ "
	.size	redisvFormatCommand.flags, 6

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"eEfFgGaA"
	.size	.L.str.1, 9

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"*%d\r\n"
	.size	.L.str.2, 6

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"$%zu\r\n"
	.size	.L.str.3, 7

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"pos == totlen"
	.size	.L.str.4, 14

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"/out/redis___hiredis/git_repo_dir_76a7b10005c70babee357a7d0f2becf28ec7ed1e/hiredis.c"
	.size	.L.str.5, 85

	.type	.L__PRETTY_FUNCTION__.redisvFormatCommand,@object # @__PRETTY_FUNCTION__.redisvFormatCommand
.L__PRETTY_FUNCTION__.redisvFormatCommand:
	.asciz	"int redisvFormatCommand(char **, const char *, struct __va_list_tag *)"
	.size	.L__PRETTY_FUNCTION__.redisvFormatCommand, 71

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"*%i\r\n"
	.size	.L.str.6, 6

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"$%u\r\n"
	.size	.L.str.7, 6

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"\r\n"
	.size	.L.str.8, 3

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"sdslen(cmd)==totlen"
	.size	.L.str.9, 20

	.type	.L__PRETTY_FUNCTION__.redisFormatSdsCommandArgv,@object # @__PRETTY_FUNCTION__.redisFormatSdsCommandArgv
.L__PRETTY_FUNCTION__.redisFormatSdsCommandArgv:
	.asciz	"int redisFormatSdsCommandArgv(sds *, int, const char **, const size_t *)"
	.size	.L__PRETTY_FUNCTION__.redisFormatSdsCommandArgv, 73

	.type	.L__PRETTY_FUNCTION__.redisFormatCommandArgv,@object # @__PRETTY_FUNCTION__.redisFormatCommandArgv
.L__PRETTY_FUNCTION__.redisFormatCommandArgv:
	.asciz	"int redisFormatCommandArgv(char **, int, const char **, const size_t *)"
	.size	.L__PRETTY_FUNCTION__.redisFormatCommandArgv, 72

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"type == REDIS_ERR_IO"
	.size	.L.str.10, 21

	.type	.L__PRETTY_FUNCTION__.__redisSetError,@object # @__PRETTY_FUNCTION__.__redisSetError
.L__PRETTY_FUNCTION__.__redisSetError:
	.asciz	"void __redisSetError(redisContext *, int, const char *)"
	.size	.L__PRETTY_FUNCTION__.__redisSetError, 56

	.type	defaultFunctions,@object        # @defaultFunctions
	.data
	.p2align	3, 0x0
defaultFunctions:
	.quad	createStringObject
	.quad	createArrayObject
	.quad	createIntegerObject
	.quad	createDoubleObject
	.quad	createNilObject
	.quad	createBoolObject
	.quad	freeReplyObject
	.size	defaultFunctions, 56

	.type	.L.str.11,@object               # @.str.11
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.11:
	.asciz	"Out of memory"
	.size	.L.str.11, 14

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"Not enough information to reconnect"
	.size	.L.str.12, 36

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"Invalid format string"
	.size	.L.str.13, 22

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"task->type == REDIS_REPLY_ERROR || task->type == REDIS_REPLY_STATUS || task->type == REDIS_REPLY_STRING || task->type == REDIS_REPLY_VERB"
	.size	.L.str.14, 138

	.type	.L__PRETTY_FUNCTION__.createStringObject,@object # @__PRETTY_FUNCTION__.createStringObject
.L__PRETTY_FUNCTION__.createStringObject:
	.asciz	"void *createStringObject(const redisReadTask *, char *, size_t)"
	.size	.L__PRETTY_FUNCTION__.createStringObject, 64

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"parent->type == REDIS_REPLY_ARRAY || parent->type == REDIS_REPLY_MAP || parent->type == REDIS_REPLY_SET || parent->type == REDIS_REPLY_PUSH"
	.size	.L.str.15, 140

	.type	.L__PRETTY_FUNCTION__.createArrayObject,@object # @__PRETTY_FUNCTION__.createArrayObject
.L__PRETTY_FUNCTION__.createArrayObject:
	.asciz	"void *createArrayObject(const redisReadTask *, size_t)"
	.size	.L__PRETTY_FUNCTION__.createArrayObject, 55

	.type	.L__PRETTY_FUNCTION__.createIntegerObject,@object # @__PRETTY_FUNCTION__.createIntegerObject
.L__PRETTY_FUNCTION__.createIntegerObject:
	.asciz	"void *createIntegerObject(const redisReadTask *, long long)"
	.size	.L__PRETTY_FUNCTION__.createIntegerObject, 60

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"parent->type == REDIS_REPLY_ARRAY || parent->type == REDIS_REPLY_MAP || parent->type == REDIS_REPLY_SET"
	.size	.L.str.16, 104

	.type	.L__PRETTY_FUNCTION__.createDoubleObject,@object # @__PRETTY_FUNCTION__.createDoubleObject
.L__PRETTY_FUNCTION__.createDoubleObject:
	.asciz	"void *createDoubleObject(const redisReadTask *, double, char *, size_t)"
	.size	.L__PRETTY_FUNCTION__.createDoubleObject, 72

	.type	.L__PRETTY_FUNCTION__.createNilObject,@object # @__PRETTY_FUNCTION__.createNilObject
.L__PRETTY_FUNCTION__.createNilObject:
	.asciz	"void *createNilObject(const redisReadTask *)"
	.size	.L__PRETTY_FUNCTION__.createNilObject, 45

	.type	.L__PRETTY_FUNCTION__.createBoolObject,@object # @__PRETTY_FUNCTION__.createBoolObject
.L__PRETTY_FUNCTION__.createBoolObject:
	.asciz	"void *createBoolObject(const redisReadTask *, int)"
	.size	.L__PRETTY_FUNCTION__.createBoolObject, 51

	.type	redisContextDefaultFuncs,@object # @redisContextDefaultFuncs
	.data
	.p2align	3, 0x0
redisContextDefaultFuncs:
	.quad	0
	.quad	redisAsyncRead
	.quad	redisAsyncWrite
	.quad	redisNetRead
	.quad	redisNetWrite
	.size	redisContextDefaultFuncs, 40

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym freeReplyObject
	.addrsig_sym hi_free
	.addrsig_sym redisvFormatCommand
	.addrsig_sym sdsempty
	.addrsig_sym hi_realloc
	.addrsig_sym bulklen
	.addrsig_sym sdslen
	.addrsig_sym sdscatlen
	.addrsig_sym strlen
	.addrsig_sym sdscat
	.addrsig_sym strchr
	.addrsig_sym __ctype_b_loc
	.addrsig_sym sdscatvprintf
	.addrsig_sym sdsfree
	.addrsig_sym countDigits
	.addrsig_sym hi_malloc
	.addrsig_sym sprintf
	.addrsig_sym __assert_fail
	.addrsig_sym redisFormatSdsCommandArgv
	.addrsig_sym sdsMakeRoomFor
	.addrsig_sym sdscatfmt
	.addrsig_sym __redisSetError
	.addrsig_sym __xpg_strerror_r
	.addrsig_sym __errno_location
	.addrsig_sym redisReaderCreate
	.addrsig_sym redisReaderCreateWithFunctions
	.addrsig_sym redisFree
	.addrsig_sym redisNetClose
	.addrsig_sym redisReaderFree
	.addrsig_sym redisContextConnectBindTcp
	.addrsig_sym redisContextConnectUnix
	.addrsig_sym redisContextSetTimeout
	.addrsig_sym redisConnectWithOptions
	.addrsig_sym redisContextInit
	.addrsig_sym redisSetPushCallback
	.addrsig_sym redisPushAutoFree
	.addrsig_sym redisContextUpdateConnectTimeout
	.addrsig_sym redisContextUpdateCommandTimeout
	.addrsig_sym redisKeepAlive
	.addrsig_sym redisBufferRead
	.addrsig_sym redisReaderFeed
	.addrsig_sym redisBufferWrite
	.addrsig_sym sdsrange
	.addrsig_sym redisGetReplyFromReader
	.addrsig_sym redisReaderGetReply
	.addrsig_sym redisGetReply
	.addrsig_sym redisHandledPushReply
	.addrsig_sym __redisAppendCommand
	.addrsig_sym redisvAppendCommand
	.addrsig_sym redisAppendCommandArgv
	.addrsig_sym redisvCommand
	.addrsig_sym __redisBlockForReply
	.addrsig_sym createStringObject
	.addrsig_sym createArrayObject
	.addrsig_sym createIntegerObject
	.addrsig_sym createDoubleObject
	.addrsig_sym createNilObject
	.addrsig_sym createBoolObject
	.addrsig_sym createReplyObject
	.addrsig_sym hi_calloc
	.addrsig_sym redisAsyncRead
	.addrsig_sym redisAsyncWrite
	.addrsig_sym redisNetRead
	.addrsig_sym redisNetWrite
	.addrsig_sym redisvFormatCommand.intfmts
	.addrsig_sym redisvFormatCommand.flags
	.addrsig_sym defaultFunctions
	.addrsig_sym hiredisAllocFns
	.addrsig_sym redisContextDefaultFuncs
