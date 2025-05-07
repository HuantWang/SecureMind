	.text
	.file	"tool_writeout.c"
	.globl	ourWriteOut                     # -- Begin function ourWriteOut
	.p2align	4, 0x90
	.type	ourWriteOut,@function
ourWriteOut:                            # @ourWriteOut
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	$0, -48(%rbp)
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_12 Depth 2
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -40(%rbp)
	movb	%al, -97(%rbp)                  # 1-byte Spill
	je	.LBB0_3
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	setne	%al
	movb	%al, -97(%rbp)                  # 1-byte Spill
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
	movb	-97(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB0_4
	jmp	.LBB0_133
.LBB0_4:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %ecx
	movl	$37, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_123
# %bb.5:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$0, %eax
	je	.LBB0_123
# %bb.6:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %ecx
	movl	$37, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_8
# %bb.7:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rsi
	movl	$37, %edi
	callq	fputc@PLT
	movq	-40(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB0_122
.LBB0_8:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %ecx
	movl	$123, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_120
# %bb.9:                                #   in Loop: Header=BB0_1 Depth=1
	movb	$0, -81(%rbp)
	movq	-40(%rbp), %rdi
	movl	$125, %esi
	callq	strchr@PLT
	movq	%rax, -72(%rbp)
	movq	-40(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -40(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB0_11
# %bb.10:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rsi
	leaq	.L.str(%rip), %rdi
	callq	fputs@PLT
	jmp	.LBB0_1
.LBB0_11:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-72(%rbp), %rax
	movb	(%rax), %al
	movb	%al, -73(%rbp)
	movq	-72(%rbp), %rax
	movb	$0, (%rax)
	movl	$0, -80(%rbp)
.LBB0_12:                               #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-80(%rbp), %rcx
	leaq	replacements(%rip), %rax
	shlq	$4, %rcx
	addq	%rcx, %rax
	cmpq	$0, (%rax)
	je	.LBB0_117
# %bb.13:                               #   in Loop: Header=BB0_12 Depth=2
	movq	-40(%rbp), %rdi
	movslq	-80(%rbp), %rcx
	leaq	replacements(%rip), %rax
	shlq	$4, %rcx
	addq	%rcx, %rax
	movq	(%rax), %rsi
	callq	curl_strequal@PLT
	cmpl	$0, %eax
	je	.LBB0_115
# %bb.14:                               #   in Loop: Header=BB0_1 Depth=1
	movb	$1, -81(%rbp)
	movslq	-80(%rbp), %rax
	shlq	$4, %rax
	leaq	replacements(%rip), %rcx
	movl	8(%rax,%rcx), %eax
	decl	%eax
	movl	%eax, %ecx
	movq	%rcx, -112(%rbp)                # 8-byte Spill
	subl	$29, %eax
	ja	.LBB0_113
# %bb.136:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-112(%rbp), %rax                # 8-byte Reload
	leaq	.LJTI0_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB0_15:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048577, %esi                  # imm = 0x100001
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_18
# %bb.16:                               #   in Loop: Header=BB0_1 Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB0_18
# %bb.17:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	fputs@PLT
.LBB0_18:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_19:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097154, %esi                  # imm = 0x200002
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_21
# %bb.20:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.1(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_21:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_22:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097174, %esi                  # imm = 0x200016
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_24
# %bb.23:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.1(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_24:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_25:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097163, %esi                  # imm = 0x20000B
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_27
# %bb.26:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_27:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_28:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097164, %esi                  # imm = 0x20000C
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_30
# %bb.29:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_30:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_31:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097178, %esi                  # imm = 0x20001A
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_33
# %bb.32:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_33:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_34:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097172, %esi                  # imm = 0x200014
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_36
# %bb.35:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_36:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_37:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145747, %esi                  # imm = 0x300013
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_39
# %bb.38:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_39:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_40:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145731, %esi                  # imm = 0x300003
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_42
# %bb.41:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_42:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_43:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145732, %esi                  # imm = 0x300004
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_45
# %bb.44:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_45:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_46:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145733, %esi                  # imm = 0x300005
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_48
# %bb.47:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_48:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_49:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145761, %esi                  # imm = 0x300021
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_51
# %bb.50:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_51:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_52:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145734, %esi                  # imm = 0x300006
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_54
# %bb.53:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_54:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_55:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145745, %esi                  # imm = 0x300011
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_57
# %bb.56:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_57:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_58:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145735, %esi                  # imm = 0x300007
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_60
# %bb.59:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.4(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_60:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_61:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145736, %esi                  # imm = 0x300008
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_63
# %bb.62:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.4(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_63:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_64:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145737, %esi                  # imm = 0x300009
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_66
# %bb.65:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.5(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_66:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_67:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$3145738, %esi                  # imm = 0x30000A
	leaq	-64(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_69
# %bb.68:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.5(%rip), %rsi
	movb	$1, %al
	callq	curl_mfprintf@PLT
.LBB0_69:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_70:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048594, %esi                  # imm = 0x100012
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_73
# %bb.71:                               #   in Loop: Header=BB0_1 Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB0_73
# %bb.72:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	fputs@PLT
.LBB0_73:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_74:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048606, %esi                  # imm = 0x10001E
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_77
# %bb.75:                               #   in Loop: Header=BB0_1 Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB0_77
# %bb.76:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	fputs@PLT
.LBB0_77:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_78:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048607, %esi                  # imm = 0x10001F
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_81
# %bb.79:                               #   in Loop: Header=BB0_1 Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB0_81
# %bb.80:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	fputs@PLT
.LBB0_81:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_82:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097165, %esi                  # imm = 0x20000D
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_84
# %bb.83:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_84:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_85:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097199, %esi                  # imm = 0x20002F
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_87
# %bb.86:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_87:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_88:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-16(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB0_90
# %bb.89:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	.L.str.6(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_90:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_91:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048608, %esi                  # imm = 0x100020
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_93
# %bb.92:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-48(%rbp), %rdx
	leaq	.L.str.6(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_93:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_94:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097192, %esi                  # imm = 0x200028
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_96
# %bb.95:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_96:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_97:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048617, %esi                  # imm = 0x100029
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_99
# %bb.98:                               #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-48(%rbp), %rdx
	leaq	.L.str.6(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_99:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_100:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097194, %esi                  # imm = 0x20002A
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_102
# %bb.101:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-56(%rbp), %rdx
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_102:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_103:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$2097198, %esi                  # imm = 0x20002E
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_109
# %bb.104:                              #   in Loop: Header=BB0_1 Depth=1
	leaq	.L.str.7(%rip), %rax
	movq	%rax, -96(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -120(%rbp)                # 8-byte Spill
	subq	$1, %rax
	je	.LBB0_105
	jmp	.LBB0_137
.LBB0_137:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-120(%rbp), %rax                # 8-byte Reload
	subq	$2, %rax
	je	.LBB0_106
	jmp	.LBB0_138
.LBB0_138:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-120(%rbp), %rax                # 8-byte Reload
	subq	$3, %rax
	je	.LBB0_107
	jmp	.LBB0_108
.LBB0_105:                              #   in Loop: Header=BB0_1 Depth=1
	leaq	.L.str.8(%rip), %rax
	movq	%rax, -96(%rbp)
	jmp	.LBB0_108
.LBB0_106:                              #   in Loop: Header=BB0_1 Depth=1
	leaq	.L.str.9(%rip), %rax
	movq	%rax, -96(%rbp)
	jmp	.LBB0_108
.LBB0_107:                              #   in Loop: Header=BB0_1 Depth=1
	leaq	.L.str.10(%rip), %rax
	movq	%rax, -96(%rbp)
.LBB0_108:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-96(%rbp), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_109:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_110:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rdi
	movl	$1048625, %esi                  # imm = 0x100031
	leaq	-48(%rbp), %rdx
	movb	$0, %al
	callq	curl_easy_getinfo@PLT
	movl	%eax, %ecx
	xorl	%eax, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_112
# %bb.111:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rdi
	movq	-48(%rbp), %rdx
	leaq	.L.str.6(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_112:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_113:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_114
.LBB0_114:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_117
.LBB0_115:                              #   in Loop: Header=BB0_12 Depth=2
	jmp	.LBB0_116
.LBB0_116:                              #   in Loop: Header=BB0_12 Depth=2
	movl	-80(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB0_12
.LBB0_117:                              #   in Loop: Header=BB0_1 Depth=1
	testb	$1, -81(%rbp)
	jne	.LBB0_119
# %bb.118:                              #   in Loop: Header=BB0_1 Depth=1
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-40(%rbp), %rdx
	leaq	.L.str.11(%rip), %rsi
	movb	$0, %al
	callq	curl_mfprintf@PLT
.LBB0_119:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-72(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	movb	-73(%rbp), %cl
	movq	-72(%rbp), %rax
	movb	%cl, (%rax)
	jmp	.LBB0_121
.LBB0_120:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rsi
	movl	$37, %edi
	callq	fputc@PLT
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %edi
	movq	-32(%rbp), %rsi
	callq	fputc@PLT
	movq	-40(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -40(%rbp)
.LBB0_121:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_122
.LBB0_122:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_132
.LBB0_123:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %ecx
	movl	$92, %eax
	cmpl	%ecx, %eax
	jne	.LBB0_130
# %bb.124:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
	subl	$110, %eax
	je	.LBB0_126
	jmp	.LBB0_134
.LBB0_134:                              #   in Loop: Header=BB0_1 Depth=1
	movl	-124(%rbp), %eax                # 4-byte Reload
	subl	$114, %eax
	je	.LBB0_125
	jmp	.LBB0_135
.LBB0_135:                              #   in Loop: Header=BB0_1 Depth=1
	movl	-124(%rbp), %eax                # 4-byte Reload
	subl	$116, %eax
	je	.LBB0_127
	jmp	.LBB0_128
.LBB0_125:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rsi
	movl	$13, %edi
	callq	fputc@PLT
	jmp	.LBB0_129
.LBB0_126:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rsi
	movl	$10, %edi
	callq	fputc@PLT
	jmp	.LBB0_129
.LBB0_127:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rsi
	movl	$9, %edi
	callq	fputc@PLT
	jmp	.LBB0_129
.LBB0_128:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %edi
	movq	-32(%rbp), %rsi
	callq	fputc@PLT
	movq	-40(%rbp), %rax
	movsbl	1(%rax), %edi
	movq	-32(%rbp), %rsi
	callq	fputc@PLT
.LBB0_129:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB0_131
.LBB0_130:                              #   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %edi
	movq	-32(%rbp), %rsi
	callq	fputc@PLT
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
.LBB0_131:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_132
.LBB0_132:                              #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_1
.LBB0_133:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	ourWriteOut, .Lfunc_end0-ourWriteOut
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI0_0:
	.long	.LBB0_40-.LJTI0_0
	.long	.LBB0_43-.LJTI0_0
	.long	.LBB0_46-.LJTI0_0
	.long	.LBB0_49-.LJTI0_0
	.long	.LBB0_52-.LJTI0_0
	.long	.LBB0_55-.LJTI0_0
	.long	.LBB0_61-.LJTI0_0
	.long	.LBB0_58-.LJTI0_0
	.long	.LBB0_64-.LJTI0_0
	.long	.LBB0_67-.LJTI0_0
	.long	.LBB0_19-.LJTI0_0
	.long	.LBB0_22-.LJTI0_0
	.long	.LBB0_25-.LJTI0_0
	.long	.LBB0_28-.LJTI0_0
	.long	.LBB0_15-.LJTI0_0
	.long	.LBB0_70-.LJTI0_0
	.long	.LBB0_31-.LJTI0_0
	.long	.LBB0_37-.LJTI0_0
	.long	.LBB0_34-.LJTI0_0
	.long	.LBB0_74-.LJTI0_0
	.long	.LBB0_78-.LJTI0_0
	.long	.LBB0_82-.LJTI0_0
	.long	.LBB0_85-.LJTI0_0
	.long	.LBB0_88-.LJTI0_0
	.long	.LBB0_91-.LJTI0_0
	.long	.LBB0_94-.LJTI0_0
	.long	.LBB0_97-.LJTI0_0
	.long	.LBB0_100-.LJTI0_0
	.long	.LBB0_103-.LJTI0_0
	.long	.LBB0_110-.LJTI0_0
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%{"
	.size	.L.str, 3

	.type	replacements,@object            # @replacements
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
replacements:
	.quad	.L.str.12
	.long	15                              # 0xf
	.zero	4
	.quad	.L.str.13
	.long	11                              # 0xb
	.zero	4
	.quad	.L.str.14
	.long	11                              # 0xb
	.zero	4
	.quad	.L.str.15
	.long	12                              # 0xc
	.zero	4
	.quad	.L.str.16
	.long	1                               # 0x1
	.zero	4
	.quad	.L.str.17
	.long	2                               # 0x2
	.zero	4
	.quad	.L.str.18
	.long	3                               # 0x3
	.zero	4
	.quad	.L.str.19
	.long	4                               # 0x4
	.zero	4
	.quad	.L.str.20
	.long	5                               # 0x5
	.zero	4
	.quad	.L.str.21
	.long	6                               # 0x6
	.zero	4
	.quad	.L.str.22
	.long	13                              # 0xd
	.zero	4
	.quad	.L.str.23
	.long	14                              # 0xe
	.zero	4
	.quad	.L.str.24
	.long	7                               # 0x7
	.zero	4
	.quad	.L.str.25
	.long	8                               # 0x8
	.zero	4
	.quad	.L.str.26
	.long	9                               # 0x9
	.zero	4
	.quad	.L.str.27
	.long	10                              # 0xa
	.zero	4
	.quad	.L.str.28
	.long	16                              # 0x10
	.zero	4
	.quad	.L.str.29
	.long	17                              # 0x11
	.zero	4
	.quad	.L.str.30
	.long	18                              # 0x12
	.zero	4
	.quad	.L.str.31
	.long	19                              # 0x13
	.zero	4
	.quad	.L.str.32
	.long	20                              # 0x14
	.zero	4
	.quad	.L.str.33
	.long	21                              # 0x15
	.zero	4
	.quad	.L.str.34
	.long	22                              # 0x16
	.zero	4
	.quad	.L.str.35
	.long	23                              # 0x17
	.zero	4
	.quad	.L.str.36
	.long	24                              # 0x18
	.zero	4
	.quad	.L.str.37
	.long	25                              # 0x19
	.zero	4
	.quad	.L.str.38
	.long	26                              # 0x1a
	.zero	4
	.quad	.L.str.39
	.long	27                              # 0x1b
	.zero	4
	.quad	.L.str.40
	.long	28                              # 0x1c
	.zero	4
	.quad	.L.str.41
	.long	29                              # 0x1d
	.zero	4
	.quad	.L.str.42
	.long	30                              # 0x1e
	.zero	4
	.zero	16
	.size	replacements, 512

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"%03ld"
	.size	.L.str.1, 6

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"%ld"
	.size	.L.str.2, 4

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"%.6f"
	.size	.L.str.3, 5

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"%.0f"
	.size	.L.str.4, 5

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"%.3f"
	.size	.L.str.5, 5

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"%s"
	.size	.L.str.6, 3

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"0"
	.size	.L.str.7, 2

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"1.0"
	.size	.L.str.8, 4

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"1.1"
	.size	.L.str.9, 4

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"2"
	.size	.L.str.10, 2

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"curl: unknown --write-out variable: '%s'\n"
	.size	.L.str.11, 42

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"url_effective"
	.size	.L.str.12, 14

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"http_code"
	.size	.L.str.13, 10

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"response_code"
	.size	.L.str.14, 14

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"http_connect"
	.size	.L.str.15, 13

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"time_total"
	.size	.L.str.16, 11

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"time_namelookup"
	.size	.L.str.17, 16

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"time_connect"
	.size	.L.str.18, 13

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"time_appconnect"
	.size	.L.str.19, 16

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"time_pretransfer"
	.size	.L.str.20, 17

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"time_starttransfer"
	.size	.L.str.21, 19

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"size_header"
	.size	.L.str.22, 12

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"size_request"
	.size	.L.str.23, 13

	.type	.L.str.24,@object               # @.str.24
.L.str.24:
	.asciz	"size_download"
	.size	.L.str.24, 14

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"size_upload"
	.size	.L.str.25, 12

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"speed_download"
	.size	.L.str.26, 15

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	"speed_upload"
	.size	.L.str.27, 13

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	"content_type"
	.size	.L.str.28, 13

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	"num_connects"
	.size	.L.str.29, 13

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	"time_redirect"
	.size	.L.str.30, 14

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"num_redirects"
	.size	.L.str.31, 14

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"ftp_entry_path"
	.size	.L.str.32, 15

	.type	.L.str.33,@object               # @.str.33
.L.str.33:
	.asciz	"redirect_url"
	.size	.L.str.33, 13

	.type	.L.str.34,@object               # @.str.34
.L.str.34:
	.asciz	"ssl_verify_result"
	.size	.L.str.34, 18

	.type	.L.str.35,@object               # @.str.35
.L.str.35:
	.asciz	"proxy_ssl_verify_result"
	.size	.L.str.35, 24

	.type	.L.str.36,@object               # @.str.36
.L.str.36:
	.asciz	"filename_effective"
	.size	.L.str.36, 19

	.type	.L.str.37,@object               # @.str.37
.L.str.37:
	.asciz	"remote_ip"
	.size	.L.str.37, 10

	.type	.L.str.38,@object               # @.str.38
.L.str.38:
	.asciz	"remote_port"
	.size	.L.str.38, 12

	.type	.L.str.39,@object               # @.str.39
.L.str.39:
	.asciz	"local_ip"
	.size	.L.str.39, 9

	.type	.L.str.40,@object               # @.str.40
.L.str.40:
	.asciz	"local_port"
	.size	.L.str.40, 11

	.type	.L.str.41,@object               # @.str.41
.L.str.41:
	.asciz	"http_version"
	.size	.L.str.41, 13

	.type	.L.str.42,@object               # @.str.42
.L.str.42:
	.asciz	"scheme"
	.size	.L.str.42, 7

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym fputc
	.addrsig_sym strchr
	.addrsig_sym fputs
	.addrsig_sym curl_strequal
	.addrsig_sym curl_easy_getinfo
	.addrsig_sym curl_mfprintf
	.addrsig_sym stdout
	.addrsig_sym replacements
	.addrsig_sym stderr
