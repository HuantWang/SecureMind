	.text
	.file	"cJSON.c"
	.globl	cJSON_GetErrorPtr               # -- Begin function cJSON_GetErrorPtr
	.p2align	4, 0x90
	.type	cJSON_GetErrorPtr,@function
cJSON_GetErrorPtr:                      # @cJSON_GetErrorPtr
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	global_error(%rip), %rax
	addq	global_error+8(%rip), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	cJSON_GetErrorPtr, .Lfunc_end0-cJSON_GetErrorPtr
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_GetStringValue            # -- Begin function cJSON_GetStringValue
	.p2align	4, 0x90
	.type	cJSON_GetStringValue,@function
cJSON_GetStringValue:                   # @cJSON_GetStringValue
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
	callq	cJSON_IsString@PLT
	cmpl	$0, %eax
	jne	.LBB1_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB1_3
.LBB1_2:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, -8(%rbp)
.LBB1_3:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	cJSON_GetStringValue, .Lfunc_end1-cJSON_GetStringValue
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsString                  # -- Begin function cJSON_IsString
	.p2align	4, 0x90
	.type	cJSON_IsString,@function
cJSON_IsString:                         # @cJSON_IsString
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB2_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB2_3
.LBB2_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$16, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB2_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	cJSON_IsString, .Lfunc_end2-cJSON_IsString
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Version                   # -- Begin function cJSON_Version
	.p2align	4, 0x90
	.type	cJSON_Version,@function
cJSON_Version:                          # @cJSON_Version
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	leaq	cJSON_Version.version(%rip), %rdi
	leaq	.L.str(%rip), %rsi
	movl	$1, %edx
	movl	$7, %ecx
	movl	$8, %r8d
	movb	$0, %al
	callq	sprintf@PLT
	leaq	cJSON_Version.version(%rip), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	cJSON_Version, .Lfunc_end3-cJSON_Version
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_InitHooks                 # -- Begin function cJSON_InitHooks
	.p2align	4, 0x90
	.type	cJSON_InitHooks,@function
cJSON_InitHooks:                        # @cJSON_InitHooks
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.LBB4_2
# %bb.1:
	movq	malloc@GOTPCREL(%rip), %rax
	movq	%rax, global_hooks(%rip)
	movq	free@GOTPCREL(%rip), %rax
	movq	%rax, global_hooks+8(%rip)
	movq	realloc@GOTPCREL(%rip), %rax
	movq	%rax, global_hooks+16(%rip)
	jmp	.LBB4_9
.LBB4_2:
	movq	malloc@GOTPCREL(%rip), %rax
	movq	%rax, global_hooks(%rip)
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB4_4
# %bb.3:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, global_hooks(%rip)
.LBB4_4:
	movq	free@GOTPCREL(%rip), %rax
	movq	%rax, global_hooks+8(%rip)
	movq	-8(%rbp), %rax
	cmpq	$0, 8(%rax)
	je	.LBB4_6
# %bb.5:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, global_hooks+8(%rip)
.LBB4_6:
	movq	$0, global_hooks+16(%rip)
	movq	malloc@GOTPCREL(%rip), %rax
	cmpq	%rax, global_hooks(%rip)
	jne	.LBB4_9
# %bb.7:
	movq	free@GOTPCREL(%rip), %rax
	cmpq	%rax, global_hooks+8(%rip)
	jne	.LBB4_9
# %bb.8:
	movq	realloc@GOTPCREL(%rip), %rax
	movq	%rax, global_hooks+16(%rip)
.LBB4_9:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	cJSON_InitHooks, .Lfunc_end4-cJSON_InitHooks
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Delete                    # -- Begin function cJSON_Delete
	.p2align	4, 0x90
	.type	cJSON_Delete,@function
cJSON_Delete:                           # @cJSON_Delete
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, -16(%rbp)
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	cmpq	$0, -8(%rbp)
	je	.LBB5_12
# %bb.2:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	24(%rax), %eax
	andl	$256, %eax                      # imm = 0x100
	cmpl	$0, %eax
	jne	.LBB5_5
# %bb.3:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB5_5
# %bb.4:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdi
	callq	cJSON_Delete@PLT
.LBB5_5:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	movl	24(%rax), %eax
	andl	$256, %eax                      # imm = 0x100
	cmpl	$0, %eax
	jne	.LBB5_8
# %bb.6:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB5_8
# %bb.7:                                #   in Loop: Header=BB5_1 Depth=1
	movq	global_hooks+8(%rip), %rax
	movq	-8(%rbp), %rcx
	movq	32(%rcx), %rdi
	callq	*%rax
.LBB5_8:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	movl	24(%rax), %eax
	andl	$512, %eax                      # imm = 0x200
	cmpl	$0, %eax
	jne	.LBB5_11
# %bb.9:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rax
	cmpq	$0, 56(%rax)
	je	.LBB5_11
# %bb.10:                               #   in Loop: Header=BB5_1 Depth=1
	movq	global_hooks+8(%rip), %rax
	movq	-8(%rbp), %rcx
	movq	56(%rcx), %rdi
	callq	*%rax
.LBB5_11:                               #   in Loop: Header=BB5_1 Depth=1
	movq	global_hooks+8(%rip), %rax
	movq	-8(%rbp), %rdi
	callq	*%rax
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB5_1
.LBB5_12:
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	cJSON_Delete, .Lfunc_end5-cJSON_Delete
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function cJSON_SetNumberHelper
.LCPI6_0:
	.quad	0x41dfffffffc00000              # double 2147483647
.LCPI6_1:
	.quad	0xc1e0000000000000              # double -2147483648
	.text
	.globl	cJSON_SetNumberHelper
	.p2align	4, 0x90
	.type	cJSON_SetNumberHelper,@function
cJSON_SetNumberHelper:                  # @cJSON_SetNumberHelper
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movsd	%xmm0, -16(%rbp)
	movsd	-16(%rbp), %xmm0                # xmm0 = mem[0],zero
	movsd	.LCPI6_0(%rip), %xmm1           # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	.LBB6_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	$2147483647, 40(%rax)           # imm = 0x7FFFFFFF
	jmp	.LBB6_6
.LBB6_2:
	movsd	.LCPI6_1(%rip), %xmm0           # xmm0 = mem[0],zero
	ucomisd	-16(%rbp), %xmm0
	jb	.LBB6_4
# %bb.3:
	movq	-8(%rbp), %rax
	movl	$-2147483648, 40(%rax)          # imm = 0x80000000
	jmp	.LBB6_5
.LBB6_4:
	cvttsd2si	-16(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, 40(%rax)
.LBB6_5:
	jmp	.LBB6_6
.LBB6_6:
	movsd	-16(%rbp), %xmm0                # xmm0 = mem[0],zero
	movq	-8(%rbp), %rax
	movsd	%xmm0, 48(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	cJSON_SetNumberHelper, .Lfunc_end6-cJSON_SetNumberHelper
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_ParseWithOpts             # -- Begin function cJSON_ParseWithOpts
	.p2align	4, 0x90
	.type	cJSON_ParseWithOpts,@function
cJSON_ParseWithOpts:                    # @cJSON_ParseWithOpts
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -96(%rbp)
	movq	%rsi, -104(%rbp)
	movl	%edx, -108(%rbp)
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	movl	$56, %edx
	callq	memset@PLT
	movq	$0, -120(%rbp)
	movq	$0, global_error(%rip)
	movq	$0, global_error+8(%rip)
	cmpq	$0, -96(%rbp)
	jne	.LBB7_2
# %bb.1:
	jmp	.LBB7_14
.LBB7_2:
	movq	-96(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-96(%rbp), %rdi
	callq	strlen@PLT
	addq	$1, %rax
	movq	%rax, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	global_hooks(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	global_hooks+8(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	global_hooks+16(%rip), %rax
	movq	%rax, -16(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -120(%rbp)
	cmpq	$0, -120(%rbp)
	jne	.LBB7_4
# %bb.3:
	jmp	.LBB7_14
.LBB7_4:
	movq	-120(%rbp), %rax
	movq	%rax, -128(%rbp)                # 8-byte Spill
	leaq	-64(%rbp), %rdi
	callq	skip_utf8_bom
	movq	%rax, %rdi
	callq	buffer_skip_whitespace
	movq	-128(%rbp), %rdi                # 8-byte Reload
	movq	%rax, %rsi
	callq	parse_value
	cmpl	$0, %eax
	jne	.LBB7_6
# %bb.5:
	jmp	.LBB7_14
.LBB7_6:
	cmpl	$0, -108(%rbp)
	je	.LBB7_11
# %bb.7:
	leaq	-64(%rbp), %rdi
	callq	buffer_skip_whitespace
	movq	-48(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jae	.LBB7_9
# %bb.8:
	movq	-64(%rbp), %rax
	movq	-48(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$0, %eax
	je	.LBB7_10
.LBB7_9:
	jmp	.LBB7_14
.LBB7_10:
	jmp	.LBB7_11
.LBB7_11:
	cmpq	$0, -104(%rbp)
	je	.LBB7_13
# %bb.12:
	movq	-64(%rbp), %rcx
	addq	-48(%rbp), %rcx
	movq	-104(%rbp), %rax
	movq	%rcx, (%rax)
.LBB7_13:
	movq	-120(%rbp), %rax
	movq	%rax, -88(%rbp)
	jmp	.LBB7_26
.LBB7_14:
	cmpq	$0, -120(%rbp)
	je	.LBB7_16
# %bb.15:
	movq	-120(%rbp), %rdi
	callq	cJSON_Delete@PLT
.LBB7_16:
	cmpq	$0, -96(%rbp)
	je	.LBB7_25
# %bb.17:
	movq	-96(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	-48(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jae	.LBB7_19
# %bb.18:
	movq	-48(%rbp), %rax
	movq	%rax, -72(%rbp)
	jmp	.LBB7_22
.LBB7_19:
	cmpq	$0, -56(%rbp)
	jbe	.LBB7_21
# %bb.20:
	movq	-56(%rbp), %rax
	subq	$1, %rax
	movq	%rax, -72(%rbp)
.LBB7_21:
	jmp	.LBB7_22
.LBB7_22:
	cmpq	$0, -104(%rbp)
	je	.LBB7_24
# %bb.23:
	movq	-80(%rbp), %rcx
	addq	-72(%rbp), %rcx
	movq	-104(%rbp), %rax
	movq	%rcx, (%rax)
.LBB7_24:
	movq	-80(%rbp), %rax
	movq	%rax, global_error(%rip)
	movq	-72(%rbp), %rax
	movq	%rax, global_error+8(%rip)
.LBB7_25:
	movq	$0, -88(%rbp)
.LBB7_26:
	movq	-88(%rbp), %rax
	movq	%rax, -136(%rbp)                # 8-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB7_28
# %bb.27:
	movq	-136(%rbp), %rax                # 8-byte Reload
	addq	$144, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB7_28:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end7:
	.size	cJSON_ParseWithOpts, .Lfunc_end7-cJSON_ParseWithOpts
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function cJSON_New_Item
	.type	cJSON_New_Item,@function
cJSON_New_Item:                         # @cJSON_New_Item
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
	movl	$64, %edi
	callq	*(%rax)
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB8_2
# %bb.1:
	movq	-16(%rbp), %rdi
	xorl	%esi, %esi
	movl	$64, %edx
	callq	memset@PLT
.LBB8_2:
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	cJSON_New_Item, .Lfunc_end8-cJSON_New_Item
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function parse_value
	.type	parse_value,@function
parse_value:                            # @parse_value
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
	je	.LBB9_2
# %bb.1:
	movq	-24(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB9_3
.LBB9_2:
	movl	$0, -4(%rbp)
	jmp	.LBB9_34
.LBB9_3:
	cmpq	$0, -24(%rbp)
	je	.LBB9_7
# %bb.4:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$4, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	ja	.LBB9_7
# %bb.5:
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movq	-24(%rbp), %rax
	addq	16(%rax), %rdi
	leaq	.L.str.2(%rip), %rsi
	movl	$4, %edx
	callq	strncmp@PLT
	cmpl	$0, %eax
	jne	.LBB9_7
# %bb.6:
	movq	-16(%rbp), %rax
	movl	$4, 24(%rax)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$4, %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB9_34
.LBB9_7:
	cmpq	$0, -24(%rbp)
	je	.LBB9_11
# %bb.8:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$5, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	ja	.LBB9_11
# %bb.9:
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movq	-24(%rbp), %rax
	addq	16(%rax), %rdi
	leaq	.L.str.3(%rip), %rsi
	movl	$5, %edx
	callq	strncmp@PLT
	cmpl	$0, %eax
	jne	.LBB9_11
# %bb.10:
	movq	-16(%rbp), %rax
	movl	$1, 24(%rax)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$5, %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB9_34
.LBB9_11:
	cmpq	$0, -24(%rbp)
	je	.LBB9_15
# %bb.12:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$4, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	ja	.LBB9_15
# %bb.13:
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movq	-24(%rbp), %rax
	addq	16(%rax), %rdi
	leaq	.L.str.4(%rip), %rsi
	movl	$4, %edx
	callq	strncmp@PLT
	cmpl	$0, %eax
	jne	.LBB9_15
# %bb.14:
	movq	-16(%rbp), %rax
	movl	$2, 24(%rax)
	movq	-16(%rbp), %rax
	movl	$1, 40(%rax)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$4, %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB9_34
.LBB9_15:
	cmpq	$0, -24(%rbp)
	je	.LBB9_19
# %bb.16:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB9_19
# %bb.17:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$34, %eax
	jne	.LBB9_19
# %bb.18:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_string
	movl	%eax, -4(%rbp)
	jmp	.LBB9_34
.LBB9_19:
	cmpq	$0, -24(%rbp)
	je	.LBB9_25
# %bb.20:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB9_25
# %bb.21:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$45, %eax
	je	.LBB9_24
# %bb.22:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$48, %eax
	jl	.LBB9_25
# %bb.23:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$57, %eax
	jg	.LBB9_25
.LBB9_24:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_number
	movl	%eax, -4(%rbp)
	jmp	.LBB9_34
.LBB9_25:
	cmpq	$0, -24(%rbp)
	je	.LBB9_29
# %bb.26:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB9_29
# %bb.27:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$91, %eax
	jne	.LBB9_29
# %bb.28:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_array
	movl	%eax, -4(%rbp)
	jmp	.LBB9_34
.LBB9_29:
	cmpq	$0, -24(%rbp)
	je	.LBB9_33
# %bb.30:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB9_33
# %bb.31:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$123, %eax
	jne	.LBB9_33
# %bb.32:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_object
	movl	%eax, -4(%rbp)
	jmp	.LBB9_34
.LBB9_33:
	movl	$0, -4(%rbp)
.LBB9_34:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	parse_value, .Lfunc_end9-parse_value
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function buffer_skip_whitespace
	.type	buffer_skip_whitespace,@function
buffer_skip_whitespace:                 # @buffer_skip_whitespace
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB10_2
# %bb.1:
	movq	-16(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB10_3
.LBB10_2:
	movq	$0, -8(%rbp)
	jmp	.LBB10_12
.LBB10_3:
	jmp	.LBB10_4
.LBB10_4:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -16(%rbp)
	movb	%al, -17(%rbp)                  # 1-byte Spill
	je	.LBB10_7
# %bb.5:                                #   in Loop: Header=BB10_4 Depth=1
	movq	-16(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$0, %rcx
	movq	-16(%rbp), %rdx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	8(%rdx), %rcx
	movb	%al, -17(%rbp)                  # 1-byte Spill
	jae	.LBB10_7
# %bb.6:                                #   in Loop: Header=BB10_4 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$32, %eax
	setle	%al
	movb	%al, -17(%rbp)                  # 1-byte Spill
.LBB10_7:                               #   in Loop: Header=BB10_4 Depth=1
	movb	-17(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB10_8
	jmp	.LBB10_9
.LBB10_8:                               #   in Loop: Header=BB10_4 Depth=1
	movq	-16(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	jmp	.LBB10_4
.LBB10_9:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	-16(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jne	.LBB10_11
# %bb.10:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 16(%rax)
.LBB10_11:
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB10_12:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	buffer_skip_whitespace, .Lfunc_end10-buffer_skip_whitespace
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function skip_utf8_bom
	.type	skip_utf8_bom,@function
skip_utf8_bom:                          # @skip_utf8_bom
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB11_3
# %bb.1:
	movq	-16(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB11_3
# %bb.2:
	movq	-16(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB11_4
.LBB11_3:
	movq	$0, -8(%rbp)
	jmp	.LBB11_9
.LBB11_4:
	cmpq	$0, -16(%rbp)
	je	.LBB11_8
# %bb.5:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	addq	$4, %rax
	movq	-16(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB11_8
# %bb.6:
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	movq	-16(%rbp), %rax
	addq	16(%rax), %rdi
	leaq	.L.str.1(%rip), %rsi
	movl	$3, %edx
	callq	strncmp@PLT
	cmpl	$0, %eax
	jne	.LBB11_8
# %bb.7:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$3, %rcx
	movq	%rcx, 16(%rax)
.LBB11_8:
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB11_9:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	skip_utf8_bom, .Lfunc_end11-skip_utf8_bom
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Parse                     # -- Begin function cJSON_Parse
	.p2align	4, 0x90
	.type	cJSON_Parse,@function
cJSON_Parse:                            # @cJSON_Parse
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
	xorl	%eax, %eax
	movl	%eax, %esi
	xorl	%edx, %edx
	callq	cJSON_ParseWithOpts@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	cJSON_Parse, .Lfunc_end12-cJSON_Parse
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Print                     # -- Begin function cJSON_Print
	.p2align	4, 0x90
	.type	cJSON_Print,@function
cJSON_Print:                            # @cJSON_Print
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
	movl	$1, %esi
	leaq	global_hooks(%rip), %rdx
	callq	print
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	cJSON_Print, .Lfunc_end13-cJSON_Print
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print
	.type	print,@function
print:                                  # @print
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -96(%rbp)
	movl	%esi, -100(%rbp)
	movq	%rdx, -112(%rbp)
	movq	$0, -120(%rbp)
	leaq	-80(%rbp), %rdi
	xorl	%esi, %esi
	movl	$64, %edx
	callq	memset@PLT
	movq	-112(%rbp), %rax
	movl	$256, %edi                      # imm = 0x100
	callq	*(%rax)
	movq	%rax, -80(%rbp)
	movq	$256, -72(%rbp)                 # imm = 0x100
	movl	-100(%rbp), %eax
	movl	%eax, -44(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	8(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	16(%rax), %rax
	movq	%rax, -24(%rbp)
	cmpq	$0, -80(%rbp)
	jne	.LBB14_2
# %bb.1:
	jmp	.LBB14_15
.LBB14_2:
	movq	-96(%rbp), %rdi
	leaq	-80(%rbp), %rsi
	callq	print_value
	cmpl	$0, %eax
	jne	.LBB14_4
# %bb.3:
	jmp	.LBB14_15
.LBB14_4:
	leaq	-80(%rbp), %rdi
	callq	update_offset
	movq	-112(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB14_8
# %bb.5:
	movq	-112(%rbp), %rax
	movq	16(%rax), %rax
	movq	-80(%rbp), %rdi
	movq	-64(%rbp), %rsi
	addq	$1, %rsi
	callq	*%rax
	movq	%rax, -120(%rbp)
	cmpq	$0, -120(%rbp)
	jne	.LBB14_7
# %bb.6:
	jmp	.LBB14_15
.LBB14_7:
	movq	$0, -80(%rbp)
	jmp	.LBB14_14
.LBB14_8:
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	-64(%rbp), %rdi
	addq	$1, %rdi
	callq	*%rax
	movq	%rax, -120(%rbp)
	cmpq	$0, -120(%rbp)
	jne	.LBB14_10
# %bb.9:
	jmp	.LBB14_15
.LBB14_10:
	movq	-120(%rbp), %rax
	movq	%rax, -136(%rbp)                # 8-byte Spill
	movq	-80(%rbp), %rax
	movq	%rax, -128(%rbp)                # 8-byte Spill
	movq	-72(%rbp), %rax
	movq	-64(%rbp), %rcx
	addq	$1, %rcx
	cmpq	%rcx, %rax
	jae	.LBB14_12
# %bb.11:
	movq	-72(%rbp), %rax
	movq	%rax, -144(%rbp)                # 8-byte Spill
	jmp	.LBB14_13
.LBB14_12:
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -144(%rbp)                # 8-byte Spill
.LBB14_13:
	movq	-128(%rbp), %rsi                # 8-byte Reload
	movq	-136(%rbp), %rdi                # 8-byte Reload
	movq	-144(%rbp), %rdx                # 8-byte Reload
	callq	memcpy@PLT
	movq	-120(%rbp), %rax
	movq	-64(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	movq	-80(%rbp), %rdi
	callq	*%rax
.LBB14_14:
	movq	-120(%rbp), %rax
	movq	%rax, -88(%rbp)
	jmp	.LBB14_20
.LBB14_15:
	cmpq	$0, -80(%rbp)
	je	.LBB14_17
# %bb.16:
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	movq	-80(%rbp), %rdi
	callq	*%rax
.LBB14_17:
	cmpq	$0, -120(%rbp)
	je	.LBB14_19
# %bb.18:
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	movq	-120(%rbp), %rdi
	callq	*%rax
.LBB14_19:
	movq	$0, -88(%rbp)
.LBB14_20:
	movq	-88(%rbp), %rax
	movq	%rax, -152(%rbp)                # 8-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB14_22
# %bb.21:
	movq	-152(%rbp), %rax                # 8-byte Reload
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB14_22:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end14:
	.size	print, .Lfunc_end14-print
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_PrintUnformatted          # -- Begin function cJSON_PrintUnformatted
	.p2align	4, 0x90
	.type	cJSON_PrintUnformatted,@function
cJSON_PrintUnformatted:                 # @cJSON_PrintUnformatted
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
	leaq	global_hooks(%rip), %rdx
	callq	print
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	cJSON_PrintUnformatted, .Lfunc_end15-cJSON_PrintUnformatted
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_PrintBuffered             # -- Begin function cJSON_PrintBuffered
	.p2align	4, 0x90
	.type	cJSON_PrintBuffered,@function
cJSON_PrintBuffered:                    # @cJSON_PrintBuffered
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -88(%rbp)
	movl	%esi, -92(%rbp)
	movl	%edx, -96(%rbp)
	leaq	-72(%rbp), %rdi
	xorl	%esi, %esi
	movl	$64, %edx
	callq	memset@PLT
	cmpl	$0, -92(%rbp)
	jge	.LBB16_2
# %bb.1:
	movq	$0, -80(%rbp)
	jmp	.LBB16_7
.LBB16_2:
	movq	global_hooks(%rip), %rax
	movslq	-92(%rbp), %rdi
	callq	*%rax
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	jne	.LBB16_4
# %bb.3:
	movq	$0, -80(%rbp)
	jmp	.LBB16_7
.LBB16_4:
	movslq	-92(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	$0, -56(%rbp)
	movl	$0, -40(%rbp)
	movl	-96(%rbp), %eax
	movl	%eax, -36(%rbp)
	movq	global_hooks(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	global_hooks+8(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	global_hooks+16(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	-88(%rbp), %rdi
	leaq	-72(%rbp), %rsi
	callq	print_value
	cmpl	$0, %eax
	jne	.LBB16_6
# %bb.5:
	movq	global_hooks+8(%rip), %rax
	movq	-72(%rbp), %rdi
	callq	*%rax
	movq	$0, -80(%rbp)
	jmp	.LBB16_7
.LBB16_6:
	movq	-72(%rbp), %rax
	movq	%rax, -80(%rbp)
.LBB16_7:
	movq	-80(%rbp), %rax
	movq	%rax, -104(%rbp)                # 8-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB16_9
# %bb.8:
	movq	-104(%rbp), %rax                # 8-byte Reload
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB16_9:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end16:
	.size	cJSON_PrintBuffered, .Lfunc_end16-cJSON_PrintBuffered
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_value
	.type	print_value,@function
print_value:                            # @print_value
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
	movq	$0, -32(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB17_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB17_3
.LBB17_2:
	movl	$0, -4(%rbp)
	jmp	.LBB17_23
.LBB17_3:
	movq	-16(%rbp), %rax
	movzbl	24(%rax), %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	subl	$1, %eax
	je	.LBB17_7
	jmp	.LBB17_24
.LBB17_24:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$2, %eax
	je	.LBB17_10
	jmp	.LBB17_25
.LBB17_25:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$4, %eax
	je	.LBB17_4
	jmp	.LBB17_26
.LBB17_26:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$8, %eax
	je	.LBB17_13
	jmp	.LBB17_27
.LBB17_27:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$16, %eax
	je	.LBB17_19
	jmp	.LBB17_28
.LBB17_28:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$32, %eax
	je	.LBB17_20
	jmp	.LBB17_29
.LBB17_29:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$64, %eax
	je	.LBB17_21
	jmp	.LBB17_30
.LBB17_30:
	movl	-44(%rbp), %eax                 # 4-byte Reload
	subl	$128, %eax
	je	.LBB17_14
	jmp	.LBB17_22
.LBB17_4:
	movq	-24(%rbp), %rdi
	movl	$5, %esi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB17_6
# %bb.5:
	movl	$0, -4(%rbp)
	jmp	.LBB17_23
.LBB17_6:
	movq	-32(%rbp), %rdi
	leaq	.L.str.2(%rip), %rsi
	callq	strcpy@PLT
	movl	$1, -4(%rbp)
	jmp	.LBB17_23
.LBB17_7:
	movq	-24(%rbp), %rdi
	movl	$6, %esi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB17_9
# %bb.8:
	movl	$0, -4(%rbp)
	jmp	.LBB17_23
.LBB17_9:
	movq	-32(%rbp), %rdi
	leaq	.L.str.3(%rip), %rsi
	callq	strcpy@PLT
	movl	$1, -4(%rbp)
	jmp	.LBB17_23
.LBB17_10:
	movq	-24(%rbp), %rdi
	movl	$5, %esi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB17_12
# %bb.11:
	movl	$0, -4(%rbp)
	jmp	.LBB17_23
.LBB17_12:
	movq	-32(%rbp), %rdi
	leaq	.L.str.4(%rip), %rsi
	callq	strcpy@PLT
	movl	$1, -4(%rbp)
	jmp	.LBB17_23
.LBB17_13:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	print_number
	movl	%eax, -4(%rbp)
	jmp	.LBB17_23
.LBB17_14:
	movq	$0, -40(%rbp)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB17_16
# %bb.15:
	movl	$0, -4(%rbp)
	jmp	.LBB17_23
.LBB17_16:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rdi
	callq	strlen@PLT
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB17_18
# %bb.17:
	movl	$0, -4(%rbp)
	jmp	.LBB17_23
.LBB17_18:
	movq	-32(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	32(%rax), %rsi
	movq	-40(%rbp), %rdx
	callq	memcpy@PLT
	movl	$1, -4(%rbp)
	jmp	.LBB17_23
.LBB17_19:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	print_string
	movl	%eax, -4(%rbp)
	jmp	.LBB17_23
.LBB17_20:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	print_array
	movl	%eax, -4(%rbp)
	jmp	.LBB17_23
.LBB17_21:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	print_object
	movl	%eax, -4(%rbp)
	jmp	.LBB17_23
.LBB17_22:
	movl	$0, -4(%rbp)
.LBB17_23:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	print_value, .Lfunc_end17-print_value
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_PrintPreallocated         # -- Begin function cJSON_PrintPreallocated
	.p2align	4, 0x90
	.type	cJSON_PrintPreallocated,@function
cJSON_PrintPreallocated:                # @cJSON_PrintPreallocated
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movl	%edx, -100(%rbp)
	movl	%ecx, -104(%rbp)
	leaq	-72(%rbp), %rdi
	xorl	%esi, %esi
	movl	$64, %edx
	callq	memset@PLT
	cmpl	$0, -100(%rbp)
	jl	.LBB18_2
# %bb.1:
	cmpq	$0, -96(%rbp)
	jne	.LBB18_3
.LBB18_2:
	movl	$0, -76(%rbp)
	jmp	.LBB18_4
.LBB18_3:
	movq	-96(%rbp), %rax
	movq	%rax, -72(%rbp)
	movslq	-100(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	$0, -56(%rbp)
	movl	$1, -40(%rbp)
	movl	-104(%rbp), %eax
	movl	%eax, -36(%rbp)
	movq	global_hooks(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	global_hooks+8(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	global_hooks+16(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	-88(%rbp), %rdi
	leaq	-72(%rbp), %rsi
	callq	print_value
	movl	%eax, -76(%rbp)
.LBB18_4:
	movl	-76(%rbp), %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB18_6
# %bb.5:
	movl	-108(%rbp), %eax                # 4-byte Reload
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB18_6:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end18:
	.size	cJSON_PrintPreallocated, .Lfunc_end18-cJSON_PrintPreallocated
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_GetArraySize              # -- Begin function cJSON_GetArraySize
	.p2align	4, 0x90
	.type	cJSON_GetArraySize,@function
cJSON_GetArraySize:                     # @cJSON_GetArraySize
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB19_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB19_6
.LBB19_2:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -24(%rbp)
.LBB19_3:                               # =>This Inner Loop Header: Depth=1
	cmpq	$0, -24(%rbp)
	je	.LBB19_5
# %bb.4:                                #   in Loop: Header=BB19_3 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB19_3
.LBB19_5:
	movq	-32(%rbp), %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, -4(%rbp)
.LBB19_6:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	cJSON_GetArraySize, .Lfunc_end19-cJSON_GetArraySize
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_GetArrayItem              # -- Begin function cJSON_GetArrayItem
	.p2align	4, 0x90
	.type	cJSON_GetArrayItem,@function
cJSON_GetArrayItem:                     # @cJSON_GetArrayItem
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
	cmpl	$0, -20(%rbp)
	jge	.LBB20_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB20_3
.LBB20_2:
	movq	-16(%rbp), %rdi
	movslq	-20(%rbp), %rsi
	callq	get_array_item
	movq	%rax, -8(%rbp)
.LBB20_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end20:
	.size	cJSON_GetArrayItem, .Lfunc_end20-cJSON_GetArrayItem
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function get_array_item
	.type	get_array_item,@function
get_array_item:                         # @get_array_item
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	$0, -32(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB21_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB21_8
.LBB21_2:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -32(%rbp)
.LBB21_3:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -32(%rbp)
	movb	%al, -33(%rbp)                  # 1-byte Spill
	je	.LBB21_5
# %bb.4:                                #   in Loop: Header=BB21_3 Depth=1
	cmpq	$0, -24(%rbp)
	seta	%al
	movb	%al, -33(%rbp)                  # 1-byte Spill
.LBB21_5:                               #   in Loop: Header=BB21_3 Depth=1
	movb	-33(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB21_6
	jmp	.LBB21_7
.LBB21_6:                               #   in Loop: Header=BB21_3 Depth=1
	movq	-24(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB21_3
.LBB21_7:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB21_8:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end21:
	.size	get_array_item, .Lfunc_end21-get_array_item
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_GetObjectItem             # -- Begin function cJSON_GetObjectItem
	.p2align	4, 0x90
	.type	cJSON_GetObjectItem,@function
cJSON_GetObjectItem:                    # @cJSON_GetObjectItem
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	xorl	%edx, %edx
	callq	get_object_item
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end22:
	.size	cJSON_GetObjectItem, .Lfunc_end22-cJSON_GetObjectItem
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function get_object_item
	.type	get_object_item,@function
get_object_item:                        # @get_object_item
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
	movq	$0, -40(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB23_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB23_3
.LBB23_2:
	movq	$0, -8(%rbp)
	jmp	.LBB23_21
.LBB23_3:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -40(%rbp)
	cmpl	$0, -28(%rbp)
	je	.LBB23_11
# %bb.4:
	jmp	.LBB23_5
.LBB23_5:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -40(%rbp)
	movb	%al, -41(%rbp)                  # 1-byte Spill
	je	.LBB23_8
# %bb.6:                                #   in Loop: Header=BB23_5 Depth=1
	movq	-40(%rbp), %rcx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, 56(%rcx)
	movb	%al, -41(%rbp)                  # 1-byte Spill
	je	.LBB23_8
# %bb.7:                                #   in Loop: Header=BB23_5 Depth=1
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rax
	movq	56(%rax), %rsi
	callq	strcmp@PLT
	cmpl	$0, %eax
	setne	%al
	movb	%al, -41(%rbp)                  # 1-byte Spill
.LBB23_8:                               #   in Loop: Header=BB23_5 Depth=1
	movb	-41(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB23_9
	jmp	.LBB23_10
.LBB23_9:                               #   in Loop: Header=BB23_5 Depth=1
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB23_5
.LBB23_10:
	jmp	.LBB23_17
.LBB23_11:
	jmp	.LBB23_12
.LBB23_12:                              # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -40(%rbp)
	movb	%al, -42(%rbp)                  # 1-byte Spill
	je	.LBB23_14
# %bb.13:                               #   in Loop: Header=BB23_12 Depth=1
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rax
	movq	56(%rax), %rsi
	callq	case_insensitive_strcmp
	cmpl	$0, %eax
	setne	%al
	movb	%al, -42(%rbp)                  # 1-byte Spill
.LBB23_14:                              #   in Loop: Header=BB23_12 Depth=1
	movb	-42(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB23_15
	jmp	.LBB23_16
.LBB23_15:                              #   in Loop: Header=BB23_12 Depth=1
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB23_12
.LBB23_16:
	jmp	.LBB23_17
.LBB23_17:
	cmpq	$0, -40(%rbp)
	je	.LBB23_19
# %bb.18:
	movq	-40(%rbp), %rax
	cmpq	$0, 56(%rax)
	jne	.LBB23_20
.LBB23_19:
	movq	$0, -8(%rbp)
	jmp	.LBB23_21
.LBB23_20:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB23_21:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end23:
	.size	get_object_item, .Lfunc_end23-get_object_item
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_GetObjectItemCaseSensitive # -- Begin function cJSON_GetObjectItemCaseSensitive
	.p2align	4, 0x90
	.type	cJSON_GetObjectItemCaseSensitive,@function
cJSON_GetObjectItemCaseSensitive:       # @cJSON_GetObjectItemCaseSensitive
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	$1, %edx
	callq	get_object_item
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end24:
	.size	cJSON_GetObjectItemCaseSensitive, .Lfunc_end24-cJSON_GetObjectItemCaseSensitive
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_HasObjectItem             # -- Begin function cJSON_HasObjectItem
	.p2align	4, 0x90
	.type	cJSON_HasObjectItem,@function
cJSON_HasObjectItem:                    # @cJSON_HasObjectItem
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	cJSON_GetObjectItem@PLT
	movq	%rax, %rdx
	xorl	%eax, %eax
	movl	$1, %ecx
	cmpq	$0, %rdx
	cmovnel	%ecx, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end25:
	.size	cJSON_HasObjectItem, .Lfunc_end25-cJSON_HasObjectItem
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddItemToArray            # -- Begin function cJSON_AddItemToArray
	.p2align	4, 0x90
	.type	cJSON_AddItemToArray,@function
cJSON_AddItemToArray:                   # @cJSON_AddItemToArray
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	add_item_to_array
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end26:
	.size	cJSON_AddItemToArray, .Lfunc_end26-cJSON_AddItemToArray
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function add_item_to_array
	.type	add_item_to_array,@function
add_item_to_array:                      # @add_item_to_array
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
	movq	$0, -32(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB27_2
# %bb.1:
	cmpq	$0, -16(%rbp)
	jne	.LBB27_3
.LBB27_2:
	movl	$0, -4(%rbp)
	jmp	.LBB27_10
.LBB27_3:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB27_5
# %bb.4:
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
	jmp	.LBB27_9
.LBB27_5:
	jmp	.LBB27_6
.LBB27_6:                               # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB27_8
# %bb.7:                                #   in Loop: Header=BB27_6 Depth=1
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB27_6
.LBB27_8:
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	suffix_object
.LBB27_9:
	movl	$1, -4(%rbp)
.LBB27_10:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end27:
	.size	add_item_to_array, .Lfunc_end27-add_item_to_array
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddItemToObject           # -- Begin function cJSON_AddItemToObject
	.p2align	4, 0x90
	.type	cJSON_AddItemToObject,@function
cJSON_AddItemToObject:                  # @cJSON_AddItemToObject
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
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end28:
	.size	cJSON_AddItemToObject, .Lfunc_end28-cJSON_AddItemToObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function add_item_to_object
	.type	add_item_to_object,@function
add_item_to_object:                     # @add_item_to_object
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
	movl	%r8d, -44(%rbp)
	movq	$0, -56(%rbp)
	movl	$0, -60(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB29_3
# %bb.1:
	cmpq	$0, -24(%rbp)
	je	.LBB29_3
# %bb.2:
	cmpq	$0, -32(%rbp)
	jne	.LBB29_4
.LBB29_3:
	movl	$0, -4(%rbp)
	jmp	.LBB29_13
.LBB29_4:
	cmpl	$0, -44(%rbp)
	je	.LBB29_6
# %bb.5:
	movq	-24(%rbp), %rdi
	callq	cast_away_const
	movq	%rax, -56(%rbp)
	movq	-32(%rbp), %rax
	movl	24(%rax), %eax
	orl	$512, %eax                      # imm = 0x200
	movl	%eax, -60(%rbp)
	jmp	.LBB29_9
.LBB29_6:
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	cJSON_strdup
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB29_8
# %bb.7:
	movl	$0, -4(%rbp)
	jmp	.LBB29_13
.LBB29_8:
	movq	-32(%rbp), %rax
	movl	24(%rax), %eax
	andl	$-513, %eax                     # imm = 0xFDFF
	movl	%eax, -60(%rbp)
.LBB29_9:
	movq	-32(%rbp), %rax
	movl	24(%rax), %eax
	andl	$512, %eax                      # imm = 0x200
	cmpl	$0, %eax
	jne	.LBB29_12
# %bb.10:
	movq	-32(%rbp), %rax
	cmpq	$0, 56(%rax)
	je	.LBB29_12
# %bb.11:
	movq	-40(%rbp), %rax
	movq	8(%rax), %rax
	movq	-32(%rbp), %rcx
	movq	56(%rcx), %rdi
	callq	*%rax
.LBB29_12:
	movq	-56(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 56(%rax)
	movl	-60(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	add_item_to_array
	movl	%eax, -4(%rbp)
.LBB29_13:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end29:
	.size	add_item_to_object, .Lfunc_end29-add_item_to_object
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddItemToObjectCS         # -- Begin function cJSON_AddItemToObjectCS
	.p2align	4, 0x90
	.type	cJSON_AddItemToObjectCS,@function
cJSON_AddItemToObjectCS:                # @cJSON_AddItemToObjectCS
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
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	movl	$1, %r8d
	callq	add_item_to_object
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end30:
	.size	cJSON_AddItemToObjectCS, .Lfunc_end30-cJSON_AddItemToObjectCS
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddItemReferenceToArray   # -- Begin function cJSON_AddItemReferenceToArray
	.p2align	4, 0x90
	.type	cJSON_AddItemReferenceToArray,@function
cJSON_AddItemReferenceToArray:          # @cJSON_AddItemReferenceToArray
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
	cmpq	$0, -8(%rbp)
	jne	.LBB31_2
# %bb.1:
	jmp	.LBB31_3
.LBB31_2:
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	create_reference
	movq	-24(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %rsi
	callq	add_item_to_array
.LBB31_3:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end31:
	.size	cJSON_AddItemReferenceToArray, .Lfunc_end31-cJSON_AddItemReferenceToArray
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function create_reference
	.type	create_reference,@function
create_reference:                       # @create_reference
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
	movq	$0, -32(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB32_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB32_5
.LBB32_2:
	movq	-24(%rbp), %rdi
	callq	cJSON_New_Item
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB32_4
# %bb.3:
	movq	$0, -8(%rbp)
	jmp	.LBB32_5
.LBB32_4:
	movq	-32(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movl	$64, %edx
	callq	memcpy@PLT
	movq	-32(%rbp), %rax
	movq	$0, 56(%rax)
	movq	-32(%rbp), %rax
	movl	24(%rax), %ecx
	orl	$256, %ecx                      # imm = 0x100
	movl	%ecx, 24(%rax)
	movq	-32(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-32(%rbp), %rax
	movq	$0, (%rax)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB32_5:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end32:
	.size	create_reference, .Lfunc_end32-create_reference
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddItemReferenceToObject  # -- Begin function cJSON_AddItemReferenceToObject
	.p2align	4, 0x90
	.type	cJSON_AddItemReferenceToObject,@function
cJSON_AddItemReferenceToObject:         # @cJSON_AddItemReferenceToObject
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
	movq	%rdx, -24(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB33_2
# %bb.1:
	cmpq	$0, -16(%rbp)
	jne	.LBB33_3
.LBB33_2:
	jmp	.LBB33_4
.LBB33_3:
	movq	-8(%rbp), %rax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-24(%rbp), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	create_reference
	movq	-40(%rbp), %rdi                 # 8-byte Reload
	movq	-32(%rbp), %rsi                 # 8-byte Reload
	movq	%rax, %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
.LBB33_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end33:
	.size	cJSON_AddItemReferenceToObject, .Lfunc_end33-cJSON_AddItemReferenceToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddNullToObject           # -- Begin function cJSON_AddNullToObject
	.p2align	4, 0x90
	.type	cJSON_AddNullToObject,@function
cJSON_AddNullToObject:                  # @cJSON_AddNullToObject
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
	callq	cJSON_CreateNull@PLT
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB34_2
# %bb.1:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB34_3
.LBB34_2:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB34_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end34:
	.size	cJSON_AddNullToObject, .Lfunc_end34-cJSON_AddNullToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateNull                # -- Begin function cJSON_CreateNull
	.p2align	4, 0x90
	.type	cJSON_CreateNull,@function
cJSON_CreateNull:                       # @cJSON_CreateNull
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB35_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	$4, 24(%rax)
.LBB35_2:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end35:
	.size	cJSON_CreateNull, .Lfunc_end35-cJSON_CreateNull
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddTrueToObject           # -- Begin function cJSON_AddTrueToObject
	.p2align	4, 0x90
	.type	cJSON_AddTrueToObject,@function
cJSON_AddTrueToObject:                  # @cJSON_AddTrueToObject
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
	callq	cJSON_CreateTrue@PLT
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB36_2
# %bb.1:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB36_3
.LBB36_2:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB36_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end36:
	.size	cJSON_AddTrueToObject, .Lfunc_end36-cJSON_AddTrueToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateTrue                # -- Begin function cJSON_CreateTrue
	.p2align	4, 0x90
	.type	cJSON_CreateTrue,@function
cJSON_CreateTrue:                       # @cJSON_CreateTrue
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB37_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	$2, 24(%rax)
.LBB37_2:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end37:
	.size	cJSON_CreateTrue, .Lfunc_end37-cJSON_CreateTrue
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddFalseToObject          # -- Begin function cJSON_AddFalseToObject
	.p2align	4, 0x90
	.type	cJSON_AddFalseToObject,@function
cJSON_AddFalseToObject:                 # @cJSON_AddFalseToObject
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
	callq	cJSON_CreateFalse@PLT
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB38_2
# %bb.1:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB38_3
.LBB38_2:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB38_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end38:
	.size	cJSON_AddFalseToObject, .Lfunc_end38-cJSON_AddFalseToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateFalse               # -- Begin function cJSON_CreateFalse
	.p2align	4, 0x90
	.type	cJSON_CreateFalse,@function
cJSON_CreateFalse:                      # @cJSON_CreateFalse
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB39_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	$1, 24(%rax)
.LBB39_2:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end39:
	.size	cJSON_CreateFalse, .Lfunc_end39-cJSON_CreateFalse
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddBoolToObject           # -- Begin function cJSON_AddBoolToObject
	.p2align	4, 0x90
	.type	cJSON_AddBoolToObject,@function
cJSON_AddBoolToObject:                  # @cJSON_AddBoolToObject
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
	movl	-28(%rbp), %edi
	callq	cJSON_CreateBool@PLT
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB40_2
# %bb.1:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB40_3
.LBB40_2:
	movq	-40(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB40_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end40:
	.size	cJSON_AddBoolToObject, .Lfunc_end40-cJSON_AddBoolToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateBool                # -- Begin function cJSON_CreateBool
	.p2align	4, 0x90
	.type	cJSON_CreateBool,@function
cJSON_CreateBool:                       # @cJSON_CreateBool
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB41_2
# %bb.1:
	movl	-4(%rbp), %edx
	movl	$1, %ecx
	movl	$2, %eax
	cmpl	$0, %edx
	cmovnel	%eax, %ecx
	movq	-16(%rbp), %rax
	movl	%ecx, 24(%rax)
.LBB41_2:
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end41:
	.size	cJSON_CreateBool, .Lfunc_end41-cJSON_CreateBool
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddNumberToObject         # -- Begin function cJSON_AddNumberToObject
	.p2align	4, 0x90
	.type	cJSON_AddNumberToObject,@function
cJSON_AddNumberToObject:                # @cJSON_AddNumberToObject
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
	movsd	%xmm0, -32(%rbp)
	movsd	-32(%rbp), %xmm0                # xmm0 = mem[0],zero
	callq	cJSON_CreateNumber@PLT
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB42_2
# %bb.1:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB42_3
.LBB42_2:
	movq	-40(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB42_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end42:
	.size	cJSON_AddNumberToObject, .Lfunc_end42-cJSON_AddNumberToObject
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function cJSON_CreateNumber
.LCPI43_0:
	.quad	0x41dfffffffc00000              # double 2147483647
.LCPI43_1:
	.quad	0xc1e0000000000000              # double -2147483648
	.text
	.globl	cJSON_CreateNumber
	.p2align	4, 0x90
	.type	cJSON_CreateNumber,@function
cJSON_CreateNumber:                     # @cJSON_CreateNumber
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movsd	%xmm0, -8(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB43_8
# %bb.1:
	movq	-16(%rbp), %rax
	movl	$8, 24(%rax)
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movsd	%xmm0, 48(%rax)
	movsd	-8(%rbp), %xmm0                 # xmm0 = mem[0],zero
	movsd	.LCPI43_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	.LBB43_3
# %bb.2:
	movq	-16(%rbp), %rax
	movl	$2147483647, 40(%rax)           # imm = 0x7FFFFFFF
	jmp	.LBB43_7
.LBB43_3:
	movsd	.LCPI43_1(%rip), %xmm0          # xmm0 = mem[0],zero
	ucomisd	-8(%rbp), %xmm0
	jb	.LBB43_5
# %bb.4:
	movq	-16(%rbp), %rax
	movl	$-2147483648, 40(%rax)          # imm = 0x80000000
	jmp	.LBB43_6
.LBB43_5:
	cvttsd2si	-8(%rbp), %ecx
	movq	-16(%rbp), %rax
	movl	%ecx, 40(%rax)
.LBB43_6:
	jmp	.LBB43_7
.LBB43_7:
	jmp	.LBB43_8
.LBB43_8:
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end43:
	.size	cJSON_CreateNumber, .Lfunc_end43-cJSON_CreateNumber
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddStringToObject         # -- Begin function cJSON_AddStringToObject
	.p2align	4, 0x90
	.type	cJSON_AddStringToObject,@function
cJSON_AddStringToObject:                # @cJSON_AddStringToObject
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
	movq	-32(%rbp), %rdi
	callq	cJSON_CreateString@PLT
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB44_2
# %bb.1:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB44_3
.LBB44_2:
	movq	-40(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB44_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end44:
	.size	cJSON_AddStringToObject, .Lfunc_end44-cJSON_AddStringToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateString              # -- Begin function cJSON_CreateString
	.p2align	4, 0x90
	.type	cJSON_CreateString,@function
cJSON_CreateString:                     # @cJSON_CreateString
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB45_4
# %bb.1:
	movq	-24(%rbp), %rax
	movl	$16, 24(%rax)
	movq	-16(%rbp), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	cJSON_strdup
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-24(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB45_3
# %bb.2:
	movq	-24(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB45_5
.LBB45_3:
	jmp	.LBB45_4
.LBB45_4:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB45_5:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end45:
	.size	cJSON_CreateString, .Lfunc_end45-cJSON_CreateString
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddRawToObject            # -- Begin function cJSON_AddRawToObject
	.p2align	4, 0x90
	.type	cJSON_AddRawToObject,@function
cJSON_AddRawToObject:                   # @cJSON_AddRawToObject
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
	movq	-32(%rbp), %rdi
	callq	cJSON_CreateRaw@PLT
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB46_2
# %bb.1:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB46_3
.LBB46_2:
	movq	-40(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB46_3:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end46:
	.size	cJSON_AddRawToObject, .Lfunc_end46-cJSON_AddRawToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateRaw                 # -- Begin function cJSON_CreateRaw
	.p2align	4, 0x90
	.type	cJSON_CreateRaw,@function
cJSON_CreateRaw:                        # @cJSON_CreateRaw
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB47_4
# %bb.1:
	movq	-24(%rbp), %rax
	movl	$128, 24(%rax)
	movq	-16(%rbp), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	cJSON_strdup
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-24(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB47_3
# %bb.2:
	movq	-24(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB47_5
.LBB47_3:
	jmp	.LBB47_4
.LBB47_4:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB47_5:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end47:
	.size	cJSON_CreateRaw, .Lfunc_end47-cJSON_CreateRaw
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddObjectToObject         # -- Begin function cJSON_AddObjectToObject
	.p2align	4, 0x90
	.type	cJSON_AddObjectToObject,@function
cJSON_AddObjectToObject:                # @cJSON_AddObjectToObject
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
	callq	cJSON_CreateObject@PLT
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB48_2
# %bb.1:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB48_3
.LBB48_2:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB48_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end48:
	.size	cJSON_AddObjectToObject, .Lfunc_end48-cJSON_AddObjectToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateObject              # -- Begin function cJSON_CreateObject
	.p2align	4, 0x90
	.type	cJSON_CreateObject,@function
cJSON_CreateObject:                     # @cJSON_CreateObject
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB49_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	$64, 24(%rax)
.LBB49_2:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end49:
	.size	cJSON_CreateObject, .Lfunc_end49-cJSON_CreateObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_AddArrayToObject          # -- Begin function cJSON_AddArrayToObject
	.p2align	4, 0x90
	.type	cJSON_AddArrayToObject,@function
cJSON_AddArrayToObject:                 # @cJSON_AddArrayToObject
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
	callq	cJSON_CreateArray@PLT
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	leaq	global_hooks(%rip), %rcx
	xorl	%r8d, %r8d
	callq	add_item_to_object
	cmpl	$0, %eax
	je	.LBB50_2
# %bb.1:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB50_3
.LBB50_2:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
.LBB50_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end50:
	.size	cJSON_AddArrayToObject, .Lfunc_end50-cJSON_AddArrayToObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateArray               # -- Begin function cJSON_CreateArray
	.p2align	4, 0x90
	.type	cJSON_CreateArray,@function
cJSON_CreateArray:                      # @cJSON_CreateArray
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB51_2
# %bb.1:
	movq	-8(%rbp), %rax
	movl	$32, 24(%rax)
.LBB51_2:
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end51:
	.size	cJSON_CreateArray, .Lfunc_end51-cJSON_CreateArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DetachItemViaPointer      # -- Begin function cJSON_DetachItemViaPointer
	.p2align	4, 0x90
	.type	cJSON_DetachItemViaPointer,@function
cJSON_DetachItemViaPointer:             # @cJSON_DetachItemViaPointer
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB52_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB52_3
.LBB52_2:
	movq	$0, -8(%rbp)
	jmp	.LBB52_10
.LBB52_3:
	movq	-24(%rbp), %rax
	cmpq	$0, 8(%rax)
	je	.LBB52_5
# %bb.4:
	movq	-24(%rbp), %rax
	movq	(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rcx, (%rax)
.LBB52_5:
	movq	-24(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB52_7
# %bb.6:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rcx, 8(%rax)
.LBB52_7:
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	16(%rcx), %rax
	jne	.LBB52_9
# %bb.8:
	movq	-24(%rbp), %rax
	movq	(%rax), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
.LBB52_9:
	movq	-24(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-24(%rbp), %rax
	movq	$0, (%rax)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB52_10:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end52:
	.size	cJSON_DetachItemViaPointer, .Lfunc_end52-cJSON_DetachItemViaPointer
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DetachItemFromArray       # -- Begin function cJSON_DetachItemFromArray
	.p2align	4, 0x90
	.type	cJSON_DetachItemFromArray,@function
cJSON_DetachItemFromArray:              # @cJSON_DetachItemFromArray
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
	cmpl	$0, -20(%rbp)
	jge	.LBB53_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB53_3
.LBB53_2:
	movq	-16(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rdi
	movslq	-20(%rbp), %rsi
	callq	get_array_item
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %rsi
	callq	cJSON_DetachItemViaPointer@PLT
	movq	%rax, -8(%rbp)
.LBB53_3:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end53:
	.size	cJSON_DetachItemFromArray, .Lfunc_end53-cJSON_DetachItemFromArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DeleteItemFromArray       # -- Begin function cJSON_DeleteItemFromArray
	.p2align	4, 0x90
	.type	cJSON_DeleteItemFromArray,@function
cJSON_DeleteItemFromArray:              # @cJSON_DeleteItemFromArray
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rdi
	movl	-12(%rbp), %esi
	callq	cJSON_DetachItemFromArray@PLT
	movq	%rax, %rdi
	callq	cJSON_Delete@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end54:
	.size	cJSON_DeleteItemFromArray, .Lfunc_end54-cJSON_DeleteItemFromArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DetachItemFromObject      # -- Begin function cJSON_DetachItemFromObject
	.p2align	4, 0x90
	.type	cJSON_DetachItemFromObject,@function
cJSON_DetachItemFromObject:             # @cJSON_DetachItemFromObject
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	cJSON_GetObjectItem@PLT
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	cJSON_DetachItemViaPointer@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end55:
	.size	cJSON_DetachItemFromObject, .Lfunc_end55-cJSON_DetachItemFromObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DetachItemFromObjectCaseSensitive # -- Begin function cJSON_DetachItemFromObjectCaseSensitive
	.p2align	4, 0x90
	.type	cJSON_DetachItemFromObjectCaseSensitive,@function
cJSON_DetachItemFromObjectCaseSensitive: # @cJSON_DetachItemFromObjectCaseSensitive
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	cJSON_GetObjectItemCaseSensitive@PLT
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	cJSON_DetachItemViaPointer@PLT
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end56:
	.size	cJSON_DetachItemFromObjectCaseSensitive, .Lfunc_end56-cJSON_DetachItemFromObjectCaseSensitive
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DeleteItemFromObject      # -- Begin function cJSON_DeleteItemFromObject
	.p2align	4, 0x90
	.type	cJSON_DeleteItemFromObject,@function
cJSON_DeleteItemFromObject:             # @cJSON_DeleteItemFromObject
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	cJSON_DetachItemFromObject@PLT
	movq	%rax, %rdi
	callq	cJSON_Delete@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end57:
	.size	cJSON_DeleteItemFromObject, .Lfunc_end57-cJSON_DeleteItemFromObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_DeleteItemFromObjectCaseSensitive # -- Begin function cJSON_DeleteItemFromObjectCaseSensitive
	.p2align	4, 0x90
	.type	cJSON_DeleteItemFromObjectCaseSensitive,@function
cJSON_DeleteItemFromObjectCaseSensitive: # @cJSON_DeleteItemFromObjectCaseSensitive
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
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	cJSON_DetachItemFromObjectCaseSensitive@PLT
	movq	%rax, %rdi
	callq	cJSON_Delete@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end58:
	.size	cJSON_DeleteItemFromObjectCaseSensitive, .Lfunc_end58-cJSON_DeleteItemFromObjectCaseSensitive
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_InsertItemInArray         # -- Begin function cJSON_InsertItemInArray
	.p2align	4, 0x90
	.type	cJSON_InsertItemInArray,@function
cJSON_InsertItemInArray:                # @cJSON_InsertItemInArray
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
	movq	%rdx, -24(%rbp)
	movq	$0, -32(%rbp)
	cmpl	$0, -12(%rbp)
	jge	.LBB59_2
# %bb.1:
	jmp	.LBB59_7
.LBB59_2:
	movq	-8(%rbp), %rdi
	movslq	-12(%rbp), %rsi
	callq	get_array_item
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB59_4
# %bb.3:
	movq	-8(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	add_item_to_array
	jmp	.LBB59_7
.LBB59_4:
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-32(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-32(%rbp), %rax
	movq	-8(%rbp), %rcx
	cmpq	16(%rcx), %rax
	jne	.LBB59_6
# %bb.5:
	movq	-24(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, 16(%rax)
	jmp	.LBB59_7
.LBB59_6:
	movq	-24(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rcx, (%rax)
.LBB59_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end59:
	.size	cJSON_InsertItemInArray, .Lfunc_end59-cJSON_InsertItemInArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_ReplaceItemViaPointer     # -- Begin function cJSON_ReplaceItemViaPointer
	.p2align	4, 0x90
	.type	cJSON_ReplaceItemViaPointer,@function
cJSON_ReplaceItemViaPointer:            # @cJSON_ReplaceItemViaPointer
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
	cmpq	$0, -16(%rbp)
	je	.LBB60_3
# %bb.1:
	cmpq	$0, -32(%rbp)
	je	.LBB60_3
# %bb.2:
	cmpq	$0, -24(%rbp)
	jne	.LBB60_4
.LBB60_3:
	movl	$0, -4(%rbp)
	jmp	.LBB60_13
.LBB60_4:
	movq	-32(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB60_6
# %bb.5:
	movl	$1, -4(%rbp)
	jmp	.LBB60_13
.LBB60_6:
	movq	-24(%rbp), %rax
	movq	(%rax), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB60_8
# %bb.7:
	movq	-32(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rcx, 8(%rax)
.LBB60_8:
	movq	-32(%rbp), %rax
	cmpq	$0, 8(%rax)
	je	.LBB60_10
# %bb.9:
	movq	-32(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rcx, (%rax)
.LBB60_10:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB60_12
# %bb.11:
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
.LBB60_12:
	movq	-24(%rbp), %rax
	movq	$0, (%rax)
	movq	-24(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-24(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movl	$1, -4(%rbp)
.LBB60_13:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end60:
	.size	cJSON_ReplaceItemViaPointer, .Lfunc_end60-cJSON_ReplaceItemViaPointer
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_ReplaceItemInArray        # -- Begin function cJSON_ReplaceItemInArray
	.p2align	4, 0x90
	.type	cJSON_ReplaceItemInArray,@function
cJSON_ReplaceItemInArray:               # @cJSON_ReplaceItemInArray
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
	movq	%rdx, -24(%rbp)
	cmpl	$0, -12(%rbp)
	jge	.LBB61_2
# %bb.1:
	jmp	.LBB61_3
.LBB61_2:
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	movq	-8(%rbp), %rdi
	movslq	-12(%rbp), %rsi
	callq	get_array_item
	movq	-32(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %rsi
	movq	-24(%rbp), %rdx
	callq	cJSON_ReplaceItemViaPointer@PLT
.LBB61_3:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end61:
	.size	cJSON_ReplaceItemInArray, .Lfunc_end61-cJSON_ReplaceItemInArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_ReplaceItemInObject       # -- Begin function cJSON_ReplaceItemInObject
	.p2align	4, 0x90
	.type	cJSON_ReplaceItemInObject,@function
cJSON_ReplaceItemInObject:              # @cJSON_ReplaceItemInObject
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
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	xorl	%ecx, %ecx
	callq	replace_item_in_object
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end62:
	.size	cJSON_ReplaceItemInObject, .Lfunc_end62-cJSON_ReplaceItemInObject
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function replace_item_in_object
	.type	replace_item_in_object,@function
replace_item_in_object:                 # @replace_item_in_object
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
	cmpq	$0, -32(%rbp)
	je	.LBB63_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB63_3
.LBB63_2:
	movl	$0, -4(%rbp)
	jmp	.LBB63_7
.LBB63_3:
	movq	-32(%rbp), %rax
	movl	24(%rax), %eax
	andl	$512, %eax                      # imm = 0x200
	cmpl	$0, %eax
	jne	.LBB63_6
# %bb.4:
	movq	-32(%rbp), %rax
	cmpq	$0, 56(%rax)
	je	.LBB63_6
# %bb.5:
	movq	-32(%rbp), %rax
	movq	56(%rax), %rdi
	callq	cJSON_free@PLT
.LBB63_6:
	movq	-24(%rbp), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	cJSON_strdup
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 56(%rax)
	movq	-32(%rbp), %rax
	movl	24(%rax), %ecx
	andl	$-513, %ecx                     # imm = 0xFDFF
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	movq	%rax, -48(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movl	-36(%rbp), %edx
	callq	get_object_item
	movq	-48(%rbp), %rdi                 # 8-byte Reload
	movq	%rax, %rsi
	movq	-32(%rbp), %rdx
	callq	cJSON_ReplaceItemViaPointer@PLT
	movl	$1, -4(%rbp)
.LBB63_7:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end63:
	.size	replace_item_in_object, .Lfunc_end63-replace_item_in_object
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_ReplaceItemInObjectCaseSensitive # -- Begin function cJSON_ReplaceItemInObjectCaseSensitive
	.p2align	4, 0x90
	.type	cJSON_ReplaceItemInObjectCaseSensitive,@function
cJSON_ReplaceItemInObjectCaseSensitive: # @cJSON_ReplaceItemInObjectCaseSensitive
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
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movl	$1, %ecx
	callq	replace_item_in_object
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end64:
	.size	cJSON_ReplaceItemInObjectCaseSensitive, .Lfunc_end64-cJSON_ReplaceItemInObjectCaseSensitive
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function cJSON_strdup
	.type	cJSON_strdup,@function
cJSON_strdup:                           # @cJSON_strdup
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB65_2
# %bb.1:
	movq	$0, -8(%rbp)
	jmp	.LBB65_5
.LBB65_2:
	movq	-16(%rbp), %rdi
	callq	strlen@PLT
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-32(%rbp), %rdi
	callq	*%rax
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB65_4
# %bb.3:
	movq	$0, -8(%rbp)
	jmp	.LBB65_5
.LBB65_4:
	movq	-40(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-32(%rbp), %rdx
	callq	memcpy@PLT
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB65_5:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end65:
	.size	cJSON_strdup, .Lfunc_end65-cJSON_strdup
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateStringReference     # -- Begin function cJSON_CreateStringReference
	.p2align	4, 0x90
	.type	cJSON_CreateStringReference,@function
cJSON_CreateStringReference:            # @cJSON_CreateStringReference
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB66_2
# %bb.1:
	movq	-16(%rbp), %rax
	movl	$272, 24(%rax)                  # imm = 0x110
	movq	-8(%rbp), %rdi
	callq	cast_away_const
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 32(%rax)
.LBB66_2:
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end66:
	.size	cJSON_CreateStringReference, .Lfunc_end66-cJSON_CreateStringReference
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function cast_away_const
	.type	cast_away_const,@function
cast_away_const:                        # @cast_away_const
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end67:
	.size	cast_away_const, .Lfunc_end67-cast_away_const
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateObjectReference     # -- Begin function cJSON_CreateObjectReference
	.p2align	4, 0x90
	.type	cJSON_CreateObjectReference,@function
cJSON_CreateObjectReference:            # @cJSON_CreateObjectReference
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB68_2
# %bb.1:
	movq	-16(%rbp), %rax
	movl	$320, 24(%rax)                  # imm = 0x140
	movq	-8(%rbp), %rdi
	callq	cast_away_const
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
.LBB68_2:
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end68:
	.size	cJSON_CreateObjectReference, .Lfunc_end68-cJSON_CreateObjectReference
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateArrayReference      # -- Begin function cJSON_CreateArrayReference
	.p2align	4, 0x90
	.type	cJSON_CreateArrayReference,@function
cJSON_CreateArrayReference:             # @cJSON_CreateArrayReference
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB69_2
# %bb.1:
	movq	-16(%rbp), %rax
	movl	$288, 24(%rax)                  # imm = 0x120
	movq	-8(%rbp), %rdi
	callq	cast_away_const
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
.LBB69_2:
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end69:
	.size	cJSON_CreateArrayReference, .Lfunc_end69-cJSON_CreateArrayReference
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateIntArray            # -- Begin function cJSON_CreateIntArray
	.p2align	4, 0x90
	.type	cJSON_CreateIntArray,@function
cJSON_CreateIntArray:                   # @cJSON_CreateIntArray
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	cmpl	$0, -20(%rbp)
	jl	.LBB70_2
# %bb.1:
	cmpq	$0, -16(%rbp)
	jne	.LBB70_3
.LBB70_2:
	movq	$0, -8(%rbp)
	jmp	.LBB70_15
.LBB70_3:
	callq	cJSON_CreateArray@PLT
	movq	%rax, -56(%rbp)
	movq	$0, -32(%rbp)
.LBB70_4:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -56(%rbp)
	movb	%al, -57(%rbp)                  # 1-byte Spill
	je	.LBB70_6
# %bb.5:                                #   in Loop: Header=BB70_4 Depth=1
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	cmpq	%rcx, %rax
	setb	%al
	movb	%al, -57(%rbp)                  # 1-byte Spill
.LBB70_6:                               #   in Loop: Header=BB70_4 Depth=1
	movb	-57(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB70_7
	jmp	.LBB70_14
.LBB70_7:                               #   in Loop: Header=BB70_4 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	cvtsi2sdl	(%rax,%rcx,4), %xmm0
	callq	cJSON_CreateNumber@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB70_9
# %bb.8:
	movq	-56(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB70_15
.LBB70_9:                               #   in Loop: Header=BB70_4 Depth=1
	cmpq	$0, -32(%rbp)
	jne	.LBB70_11
# %bb.10:                               #   in Loop: Header=BB70_4 Depth=1
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, 16(%rax)
	jmp	.LBB70_12
.LBB70_11:                              #   in Loop: Header=BB70_4 Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	suffix_object
.LBB70_12:                              #   in Loop: Header=BB70_4 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.13:                               #   in Loop: Header=BB70_4 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB70_4
.LBB70_14:
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB70_15:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end70:
	.size	cJSON_CreateIntArray, .Lfunc_end70-cJSON_CreateIntArray
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function suffix_object
	.type	suffix_object,@function
suffix_object:                          # @suffix_object
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-8(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 8(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end71:
	.size	suffix_object, .Lfunc_end71-suffix_object
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateFloatArray          # -- Begin function cJSON_CreateFloatArray
	.p2align	4, 0x90
	.type	cJSON_CreateFloatArray,@function
cJSON_CreateFloatArray:                 # @cJSON_CreateFloatArray
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	cmpl	$0, -20(%rbp)
	jl	.LBB72_2
# %bb.1:
	cmpq	$0, -16(%rbp)
	jne	.LBB72_3
.LBB72_2:
	movq	$0, -8(%rbp)
	jmp	.LBB72_15
.LBB72_3:
	callq	cJSON_CreateArray@PLT
	movq	%rax, -56(%rbp)
	movq	$0, -32(%rbp)
.LBB72_4:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -56(%rbp)
	movb	%al, -57(%rbp)                  # 1-byte Spill
	je	.LBB72_6
# %bb.5:                                #   in Loop: Header=BB72_4 Depth=1
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	cmpq	%rcx, %rax
	setb	%al
	movb	%al, -57(%rbp)                  # 1-byte Spill
.LBB72_6:                               #   in Loop: Header=BB72_4 Depth=1
	movb	-57(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB72_7
	jmp	.LBB72_14
.LBB72_7:                               #   in Loop: Header=BB72_4 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movss	(%rax,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	callq	cJSON_CreateNumber@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB72_9
# %bb.8:
	movq	-56(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB72_15
.LBB72_9:                               #   in Loop: Header=BB72_4 Depth=1
	cmpq	$0, -32(%rbp)
	jne	.LBB72_11
# %bb.10:                               #   in Loop: Header=BB72_4 Depth=1
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, 16(%rax)
	jmp	.LBB72_12
.LBB72_11:                              #   in Loop: Header=BB72_4 Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	suffix_object
.LBB72_12:                              #   in Loop: Header=BB72_4 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.13:                               #   in Loop: Header=BB72_4 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB72_4
.LBB72_14:
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB72_15:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end72:
	.size	cJSON_CreateFloatArray, .Lfunc_end72-cJSON_CreateFloatArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateDoubleArray         # -- Begin function cJSON_CreateDoubleArray
	.p2align	4, 0x90
	.type	cJSON_CreateDoubleArray,@function
cJSON_CreateDoubleArray:                # @cJSON_CreateDoubleArray
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	cmpl	$0, -20(%rbp)
	jl	.LBB73_2
# %bb.1:
	cmpq	$0, -16(%rbp)
	jne	.LBB73_3
.LBB73_2:
	movq	$0, -8(%rbp)
	jmp	.LBB73_15
.LBB73_3:
	callq	cJSON_CreateArray@PLT
	movq	%rax, -56(%rbp)
	movq	$0, -32(%rbp)
.LBB73_4:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -56(%rbp)
	movb	%al, -57(%rbp)                  # 1-byte Spill
	je	.LBB73_6
# %bb.5:                                #   in Loop: Header=BB73_4 Depth=1
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	cmpq	%rcx, %rax
	setb	%al
	movb	%al, -57(%rbp)                  # 1-byte Spill
.LBB73_6:                               #   in Loop: Header=BB73_4 Depth=1
	movb	-57(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB73_7
	jmp	.LBB73_14
.LBB73_7:                               #   in Loop: Header=BB73_4 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movsd	(%rax,%rcx,8), %xmm0            # xmm0 = mem[0],zero
	callq	cJSON_CreateNumber@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB73_9
# %bb.8:
	movq	-56(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB73_15
.LBB73_9:                               #   in Loop: Header=BB73_4 Depth=1
	cmpq	$0, -32(%rbp)
	jne	.LBB73_11
# %bb.10:                               #   in Loop: Header=BB73_4 Depth=1
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, 16(%rax)
	jmp	.LBB73_12
.LBB73_11:                              #   in Loop: Header=BB73_4 Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	suffix_object
.LBB73_12:                              #   in Loop: Header=BB73_4 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.13:                               #   in Loop: Header=BB73_4 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB73_4
.LBB73_14:
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB73_15:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end73:
	.size	cJSON_CreateDoubleArray, .Lfunc_end73-cJSON_CreateDoubleArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_CreateStringArray         # -- Begin function cJSON_CreateStringArray
	.p2align	4, 0x90
	.type	cJSON_CreateStringArray,@function
cJSON_CreateStringArray:                # @cJSON_CreateStringArray
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	cmpl	$0, -20(%rbp)
	jl	.LBB74_2
# %bb.1:
	cmpq	$0, -16(%rbp)
	jne	.LBB74_3
.LBB74_2:
	movq	$0, -8(%rbp)
	jmp	.LBB74_15
.LBB74_3:
	callq	cJSON_CreateArray@PLT
	movq	%rax, -56(%rbp)
	movq	$0, -32(%rbp)
.LBB74_4:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -56(%rbp)
	movb	%al, -57(%rbp)                  # 1-byte Spill
	je	.LBB74_6
# %bb.5:                                #   in Loop: Header=BB74_4 Depth=1
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	cmpq	%rcx, %rax
	setb	%al
	movb	%al, -57(%rbp)                  # 1-byte Spill
.LBB74_6:                               #   in Loop: Header=BB74_4 Depth=1
	movb	-57(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB74_7
	jmp	.LBB74_14
.LBB74_7:                               #   in Loop: Header=BB74_4 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movq	(%rax,%rcx,8), %rdi
	callq	cJSON_CreateString@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB74_9
# %bb.8:
	movq	-56(%rbp), %rdi
	callq	cJSON_Delete@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB74_15
.LBB74_9:                               #   in Loop: Header=BB74_4 Depth=1
	cmpq	$0, -32(%rbp)
	jne	.LBB74_11
# %bb.10:                               #   in Loop: Header=BB74_4 Depth=1
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, 16(%rax)
	jmp	.LBB74_12
.LBB74_11:                              #   in Loop: Header=BB74_4 Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	suffix_object
.LBB74_12:                              #   in Loop: Header=BB74_4 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
# %bb.13:                               #   in Loop: Header=BB74_4 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB74_4
.LBB74_14:
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBB74_15:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end74:
	.size	cJSON_CreateStringArray, .Lfunc_end74-cJSON_CreateStringArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Duplicate                 # -- Begin function cJSON_Duplicate
	.p2align	4, 0x90
	.type	cJSON_Duplicate,@function
cJSON_Duplicate:                        # @cJSON_Duplicate
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB75_2
# %bb.1:
	jmp	.LBB75_26
.LBB75_2:
	leaq	global_hooks(%rip), %rdi
	callq	cJSON_New_Item
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB75_4
# %bb.3:
	jmp	.LBB75_26
.LBB75_4:
	movq	-16(%rbp), %rax
	movl	24(%rax), %ecx
	andl	$-257, %ecx                     # imm = 0xFEFF
	movq	-32(%rbp), %rax
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	movl	40(%rax), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, 40(%rax)
	movq	-16(%rbp), %rax
	movsd	48(%rax), %xmm0                 # xmm0 = mem[0],zero
	movq	-32(%rbp), %rax
	movsd	%xmm0, 48(%rax)
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB75_8
# %bb.5:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	cJSON_strdup
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB75_7
# %bb.6:
	jmp	.LBB75_26
.LBB75_7:
	jmp	.LBB75_8
.LBB75_8:
	movq	-16(%rbp), %rax
	cmpq	$0, 56(%rax)
	je	.LBB75_15
# %bb.9:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$512, %eax                      # imm = 0x200
	cmpl	$0, %eax
	je	.LBB75_11
# %bb.10:
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -64(%rbp)                 # 8-byte Spill
	jmp	.LBB75_12
.LBB75_11:
	movq	-16(%rbp), %rax
	movq	56(%rax), %rdi
	leaq	global_hooks(%rip), %rsi
	callq	cJSON_strdup
	movq	%rax, -64(%rbp)                 # 8-byte Spill
.LBB75_12:
	movq	-64(%rbp), %rcx                 # 8-byte Reload
	movq	-32(%rbp), %rax
	movq	%rcx, 56(%rax)
	movq	-32(%rbp), %rax
	cmpq	$0, 56(%rax)
	jne	.LBB75_14
# %bb.13:
	jmp	.LBB75_26
.LBB75_14:
	jmp	.LBB75_15
.LBB75_15:
	cmpl	$0, -20(%rbp)
	jne	.LBB75_17
# %bb.16:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB75_29
.LBB75_17:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -40(%rbp)
.LBB75_18:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -40(%rbp)
	je	.LBB75_25
# %bb.19:                               #   in Loop: Header=BB75_18 Depth=1
	movq	-40(%rbp), %rdi
	movl	$1, %esi
	callq	cJSON_Duplicate@PLT
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB75_21
# %bb.20:
	jmp	.LBB75_26
.LBB75_21:                              #   in Loop: Header=BB75_18 Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB75_23
# %bb.22:                               #   in Loop: Header=BB75_18 Depth=1
	movq	-56(%rbp), %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-48(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-56(%rbp), %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB75_24
.LBB75_23:                              #   in Loop: Header=BB75_18 Depth=1
	movq	-56(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 16(%rax)
	movq	-56(%rbp), %rax
	movq	%rax, -48(%rbp)
.LBB75_24:                              #   in Loop: Header=BB75_18 Depth=1
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB75_18
.LBB75_25:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB75_29
.LBB75_26:
	cmpq	$0, -32(%rbp)
	je	.LBB75_28
# %bb.27:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
.LBB75_28:
	movq	$0, -8(%rbp)
.LBB75_29:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end75:
	.size	cJSON_Duplicate, .Lfunc_end75-cJSON_Duplicate
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Minify                    # -- Begin function cJSON_Minify
	.p2align	4, 0x90
	.type	cJSON_Minify,@function
cJSON_Minify:                           # @cJSON_Minify
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.LBB76_2
# %bb.1:
	jmp	.LBB76_48
.LBB76_2:
	jmp	.LBB76_3
.LBB76_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB76_15 Depth 2
                                        #     Child Loop BB76_23 Depth 2
                                        #     Child Loop BB76_32 Depth 2
	movq	-8(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB76_47
# %bb.4:                                #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$32, %eax
	jne	.LBB76_6
# %bb.5:                                #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_46
.LBB76_6:                               #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$9, %eax
	jne	.LBB76_8
# %bb.7:                                #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_45
.LBB76_8:                               #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$13, %eax
	jne	.LBB76_10
# %bb.9:                                #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_44
.LBB76_10:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$10, %eax
	jne	.LBB76_12
# %bb.11:                               #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_43
.LBB76_12:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$47, %eax
	jne	.LBB76_20
# %bb.13:                               #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$47, %eax
	jne	.LBB76_20
# %bb.14:                               #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_15
.LBB76_15:                              #   Parent Loop BB76_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, %ecx
	movb	%al, -17(%rbp)                  # 1-byte Spill
	je	.LBB76_17
# %bb.16:                               #   in Loop: Header=BB76_15 Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$10, %eax
	setne	%al
	movb	%al, -17(%rbp)                  # 1-byte Spill
.LBB76_17:                              #   in Loop: Header=BB76_15 Depth=2
	movb	-17(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB76_18
	jmp	.LBB76_19
.LBB76_18:                              #   in Loop: Header=BB76_15 Depth=2
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_15
.LBB76_19:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_42
.LBB76_20:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$47, %eax
	jne	.LBB76_30
# %bb.21:                               #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$42, %eax
	jne	.LBB76_30
# %bb.22:                               #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_23
.LBB76_23:                              #   Parent Loop BB76_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, %ecx
	movb	%al, -18(%rbp)                  # 1-byte Spill
	je	.LBB76_27
# %bb.24:                               #   in Loop: Header=BB76_23 Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$42, %ecx
	movb	%al, -19(%rbp)                  # 1-byte Spill
	jne	.LBB76_26
# %bb.25:                               #   in Loop: Header=BB76_23 Depth=2
	movq	-8(%rbp), %rax
	movsbl	1(%rax), %eax
	cmpl	$47, %eax
	sete	%al
	movb	%al, -19(%rbp)                  # 1-byte Spill
.LBB76_26:                              #   in Loop: Header=BB76_23 Depth=2
	movb	-19(%rbp), %al                  # 1-byte Reload
	xorb	$-1, %al
	movb	%al, -18(%rbp)                  # 1-byte Spill
.LBB76_27:                              #   in Loop: Header=BB76_23 Depth=2
	movb	-18(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB76_28
	jmp	.LBB76_29
.LBB76_28:                              #   in Loop: Header=BB76_23 Depth=2
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_23
.LBB76_29:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB76_41
.LBB76_30:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$34, %eax
	jne	.LBB76_39
# %bb.31:                               #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -8(%rbp)
	movb	(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
.LBB76_32:                              #   Parent Loop BB76_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %ecx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, %ecx
	movb	%al, -20(%rbp)                  # 1-byte Spill
	je	.LBB76_34
# %bb.33:                               #   in Loop: Header=BB76_32 Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$34, %eax
	setne	%al
	movb	%al, -20(%rbp)                  # 1-byte Spill
.LBB76_34:                              #   in Loop: Header=BB76_32 Depth=2
	movb	-20(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB76_35
	jmp	.LBB76_38
.LBB76_35:                              #   in Loop: Header=BB76_32 Depth=2
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$92, %eax
	jne	.LBB76_37
# %bb.36:                               #   in Loop: Header=BB76_32 Depth=2
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -8(%rbp)
	movb	(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
.LBB76_37:                              #   in Loop: Header=BB76_32 Depth=2
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -8(%rbp)
	movb	(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
	jmp	.LBB76_32
.LBB76_38:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -8(%rbp)
	movb	(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
	jmp	.LBB76_40
.LBB76_39:                              #   in Loop: Header=BB76_3 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -8(%rbp)
	movb	(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
.LBB76_40:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_41
.LBB76_41:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_42
.LBB76_42:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_43
.LBB76_43:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_44
.LBB76_44:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_45
.LBB76_45:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_46
.LBB76_46:                              #   in Loop: Header=BB76_3 Depth=1
	jmp	.LBB76_3
.LBB76_47:
	movq	-16(%rbp), %rax
	movb	$0, (%rax)
.LBB76_48:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end76:
	.size	cJSON_Minify, .Lfunc_end76-cJSON_Minify
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsInvalid                 # -- Begin function cJSON_IsInvalid
	.p2align	4, 0x90
	.type	cJSON_IsInvalid,@function
cJSON_IsInvalid:                        # @cJSON_IsInvalid
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB77_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB77_3
.LBB77_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$0, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB77_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end77:
	.size	cJSON_IsInvalid, .Lfunc_end77-cJSON_IsInvalid
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsFalse                   # -- Begin function cJSON_IsFalse
	.p2align	4, 0x90
	.type	cJSON_IsFalse,@function
cJSON_IsFalse:                          # @cJSON_IsFalse
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB78_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB78_3
.LBB78_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$1, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB78_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end78:
	.size	cJSON_IsFalse, .Lfunc_end78-cJSON_IsFalse
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsTrue                    # -- Begin function cJSON_IsTrue
	.p2align	4, 0x90
	.type	cJSON_IsTrue,@function
cJSON_IsTrue:                           # @cJSON_IsTrue
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB79_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB79_3
.LBB79_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$2, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB79_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end79:
	.size	cJSON_IsTrue, .Lfunc_end79-cJSON_IsTrue
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsBool                    # -- Begin function cJSON_IsBool
	.p2align	4, 0x90
	.type	cJSON_IsBool,@function
cJSON_IsBool:                           # @cJSON_IsBool
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB80_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB80_3
.LBB80_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$3, %eax
	cmpl	$0, %eax
	setne	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB80_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end80:
	.size	cJSON_IsBool, .Lfunc_end80-cJSON_IsBool
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsNull                    # -- Begin function cJSON_IsNull
	.p2align	4, 0x90
	.type	cJSON_IsNull,@function
cJSON_IsNull:                           # @cJSON_IsNull
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB81_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB81_3
.LBB81_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$4, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB81_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end81:
	.size	cJSON_IsNull, .Lfunc_end81-cJSON_IsNull
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsNumber                  # -- Begin function cJSON_IsNumber
	.p2align	4, 0x90
	.type	cJSON_IsNumber,@function
cJSON_IsNumber:                         # @cJSON_IsNumber
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB82_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB82_3
.LBB82_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$8, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB82_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end82:
	.size	cJSON_IsNumber, .Lfunc_end82-cJSON_IsNumber
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsArray                   # -- Begin function cJSON_IsArray
	.p2align	4, 0x90
	.type	cJSON_IsArray,@function
cJSON_IsArray:                          # @cJSON_IsArray
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB83_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB83_3
.LBB83_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$32, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB83_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end83:
	.size	cJSON_IsArray, .Lfunc_end83-cJSON_IsArray
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsObject                  # -- Begin function cJSON_IsObject
	.p2align	4, 0x90
	.type	cJSON_IsObject,@function
cJSON_IsObject:                         # @cJSON_IsObject
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB84_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB84_3
.LBB84_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$64, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB84_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end84:
	.size	cJSON_IsObject, .Lfunc_end84-cJSON_IsObject
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_IsRaw                     # -- Begin function cJSON_IsRaw
	.p2align	4, 0x90
	.type	cJSON_IsRaw,@function
cJSON_IsRaw:                            # @cJSON_IsRaw
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB85_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB85_3
.LBB85_2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	cmpl	$128, %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.LBB85_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end85:
	.size	cJSON_IsRaw, .Lfunc_end85-cJSON_IsRaw
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_Compare                   # -- Begin function cJSON_Compare
	.p2align	4, 0x90
	.type	cJSON_Compare,@function
cJSON_Compare:                          # @cJSON_Compare
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
	movl	%edx, -28(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB86_4
# %bb.1:
	cmpq	$0, -24(%rbp)
	je	.LBB86_4
# %bb.2:
	movq	-16(%rbp), %rax
	movl	24(%rax), %eax
	andl	$255, %eax
	movq	-24(%rbp), %rcx
	movl	24(%rcx), %ecx
	andl	$255, %ecx
	cmpl	%ecx, %eax
	jne	.LBB86_4
# %bb.3:
	movq	-16(%rbp), %rdi
	callq	cJSON_IsInvalid@PLT
	cmpl	$0, %eax
	je	.LBB86_5
.LBB86_4:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_5:
	movq	-16(%rbp), %rax
	movzbl	24(%rax), %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	decl	%eax
	subl	$2, %eax
	jb	.LBB86_6
	jmp	.LBB86_56
.LBB86_56:
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$4, %eax
	je	.LBB86_6
	jmp	.LBB86_57
.LBB86_57:
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$8, %eax
	je	.LBB86_6
	jmp	.LBB86_58
.LBB86_58:
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$16, %eax
	je	.LBB86_6
	jmp	.LBB86_59
.LBB86_59:
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$32, %eax
	je	.LBB86_6
	jmp	.LBB86_60
.LBB86_60:
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$64, %eax
	je	.LBB86_6
	jmp	.LBB86_61
.LBB86_61:
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$128, %eax
	jne	.LBB86_7
	jmp	.LBB86_6
.LBB86_6:
	jmp	.LBB86_8
.LBB86_7:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_8:
	movq	-16(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB86_10
# %bb.9:
	movl	$1, -4(%rbp)
	jmp	.LBB86_55
.LBB86_10:
	movq	-16(%rbp), %rax
	movzbl	24(%rax), %eax
	movl	%eax, -72(%rbp)                 # 4-byte Spill
	decl	%eax
	subl	$2, %eax
	jb	.LBB86_11
	jmp	.LBB86_62
.LBB86_62:
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$4, %eax
	je	.LBB86_11
	jmp	.LBB86_63
.LBB86_63:
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$8, %eax
	je	.LBB86_12
	jmp	.LBB86_64
.LBB86_64:
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$16, %eax
	je	.LBB86_15
	jmp	.LBB86_65
.LBB86_65:
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$32, %eax
	je	.LBB86_21
	jmp	.LBB86_66
.LBB86_66:
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$64, %eax
	je	.LBB86_31
	jmp	.LBB86_67
.LBB86_67:
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$128, %eax
	je	.LBB86_15
	jmp	.LBB86_54
.LBB86_11:
	movl	$1, -4(%rbp)
	jmp	.LBB86_55
.LBB86_12:
	movq	-16(%rbp), %rax
	movsd	48(%rax), %xmm0                 # xmm0 = mem[0],zero
	movq	-24(%rbp), %rax
	ucomisd	48(%rax), %xmm0
	jne	.LBB86_14
	jp	.LBB86_14
# %bb.13:
	movl	$1, -4(%rbp)
	jmp	.LBB86_55
.LBB86_14:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_15:
	movq	-16(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB86_17
# %bb.16:
	movq	-24(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB86_18
.LBB86_17:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_18:
	movq	-16(%rbp), %rax
	movq	32(%rax), %rdi
	movq	-24(%rbp), %rax
	movq	32(%rax), %rsi
	callq	strcmp@PLT
	cmpl	$0, %eax
	jne	.LBB86_20
# %bb.19:
	movl	$1, -4(%rbp)
	jmp	.LBB86_55
.LBB86_20:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_21:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -48(%rbp)
.LBB86_22:                              # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -40(%rbp)
	movb	%al, -73(%rbp)                  # 1-byte Spill
	je	.LBB86_24
# %bb.23:                               #   in Loop: Header=BB86_22 Depth=1
	cmpq	$0, -48(%rbp)
	setne	%al
	movb	%al, -73(%rbp)                  # 1-byte Spill
.LBB86_24:                              #   in Loop: Header=BB86_22 Depth=1
	movb	-73(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB86_25
	jmp	.LBB86_28
.LBB86_25:                              #   in Loop: Header=BB86_22 Depth=1
	movq	-40(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movl	-28(%rbp), %edx
	callq	cJSON_Compare@PLT
	cmpl	$0, %eax
	jne	.LBB86_27
# %bb.26:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_27:                              #   in Loop: Header=BB86_22 Depth=1
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB86_22
.LBB86_28:
	movq	-40(%rbp), %rax
	cmpq	-48(%rbp), %rax
	je	.LBB86_30
# %bb.29:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_30:
	movl	$1, -4(%rbp)
	jmp	.LBB86_55
.LBB86_31:
	movq	$0, -56(%rbp)
	movq	$0, -64(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB86_33
# %bb.32:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -88(%rbp)                 # 8-byte Spill
	jmp	.LBB86_34
.LBB86_33:
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -88(%rbp)                 # 8-byte Spill
	jmp	.LBB86_34
.LBB86_34:
	movq	-88(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -56(%rbp)
.LBB86_35:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -56(%rbp)
	je	.LBB86_42
# %bb.36:                               #   in Loop: Header=BB86_35 Depth=1
	movq	-24(%rbp), %rdi
	movq	-56(%rbp), %rax
	movq	56(%rax), %rsi
	movl	-28(%rbp), %edx
	callq	get_object_item
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB86_38
# %bb.37:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_38:                              #   in Loop: Header=BB86_35 Depth=1
	movq	-56(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movl	-28(%rbp), %edx
	callq	cJSON_Compare@PLT
	cmpl	$0, %eax
	jne	.LBB86_40
# %bb.39:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_40:                              #   in Loop: Header=BB86_35 Depth=1
	jmp	.LBB86_41
.LBB86_41:                              #   in Loop: Header=BB86_35 Depth=1
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	jmp	.LBB86_35
.LBB86_42:
	cmpq	$0, -24(%rbp)
	je	.LBB86_44
# %bb.43:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -96(%rbp)                 # 8-byte Spill
	jmp	.LBB86_45
.LBB86_44:
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -96(%rbp)                 # 8-byte Spill
	jmp	.LBB86_45
.LBB86_45:
	movq	-96(%rbp), %rax                 # 8-byte Reload
	movq	%rax, -64(%rbp)
.LBB86_46:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -64(%rbp)
	je	.LBB86_53
# %bb.47:                               #   in Loop: Header=BB86_46 Depth=1
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movq	56(%rax), %rsi
	movl	-28(%rbp), %edx
	callq	get_object_item
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.LBB86_49
# %bb.48:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_49:                              #   in Loop: Header=BB86_46 Depth=1
	movq	-64(%rbp), %rdi
	movq	-56(%rbp), %rsi
	movl	-28(%rbp), %edx
	callq	cJSON_Compare@PLT
	cmpl	$0, %eax
	jne	.LBB86_51
# %bb.50:
	movl	$0, -4(%rbp)
	jmp	.LBB86_55
.LBB86_51:                              #   in Loop: Header=BB86_46 Depth=1
	jmp	.LBB86_52
.LBB86_52:                              #   in Loop: Header=BB86_46 Depth=1
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	jmp	.LBB86_46
.LBB86_53:
	movl	$1, -4(%rbp)
	jmp	.LBB86_55
.LBB86_54:
	movl	$0, -4(%rbp)
.LBB86_55:
	movl	-4(%rbp), %eax
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end86:
	.size	cJSON_Compare, .Lfunc_end86-cJSON_Compare
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_malloc                    # -- Begin function cJSON_malloc
	.p2align	4, 0x90
	.type	cJSON_malloc,@function
cJSON_malloc:                           # @cJSON_malloc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	global_hooks(%rip), %rax
	movq	-8(%rbp), %rdi
	callq	*%rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end87:
	.size	cJSON_malloc, .Lfunc_end87-cJSON_malloc
	.cfi_endproc
                                        # -- End function
	.globl	cJSON_free                      # -- Begin function cJSON_free
	.p2align	4, 0x90
	.type	cJSON_free,@function
cJSON_free:                             # @cJSON_free
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	global_hooks+8(%rip), %rax
	movq	-8(%rbp), %rdi
	callq	*%rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end88:
	.size	cJSON_free, .Lfunc_end88-cJSON_free
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function update_offset
	.type	update_offset,@function
update_offset:                          # @update_offset
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, -16(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB89_2
# %bb.1:
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB89_3
.LBB89_2:
	jmp	.LBB89_4
.LBB89_3:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	addq	16(%rcx), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rdi
	callq	strlen@PLT
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
.LBB89_4:
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end89:
	.size	update_offset, .Lfunc_end89-update_offset
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function parse_string
	.type	parse_string,@function
parse_string:                           # @parse_string
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rcx
	addq	16(%rcx), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rcx
	addq	16(%rcx), %rax
	addq	$1, %rax
	movq	%rax, -56(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -64(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$34, %eax
	je	.LBB90_2
# %bb.1:
	jmp	.LBB90_36
.LBB90_2:
	movq	$0, -72(%rbp)
	movq	$0, -80(%rbp)
.LBB90_3:                               # =>This Inner Loop Header: Depth=1
	movq	-56(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	subq	%rax, %rcx
	movq	-40(%rbp), %rdx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	8(%rdx), %rcx
	movb	%al, -82(%rbp)                  # 1-byte Spill
	jae	.LBB90_5
# %bb.4:                                #   in Loop: Header=BB90_3 Depth=1
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$34, %eax
	setne	%al
	movb	%al, -82(%rbp)                  # 1-byte Spill
.LBB90_5:                               #   in Loop: Header=BB90_3 Depth=1
	movb	-82(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB90_6
	jmp	.LBB90_11
.LBB90_6:                               #   in Loop: Header=BB90_3 Depth=1
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$92, %eax
	jne	.LBB90_10
# %bb.7:                                #   in Loop: Header=BB90_3 Depth=1
	movq	-56(%rbp), %rax
	addq	$1, %rax
	movq	-40(%rbp), %rcx
	movq	(%rcx), %rcx
	subq	%rcx, %rax
	movq	-40(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jb	.LBB90_9
# %bb.8:
	jmp	.LBB90_36
.LBB90_9:                               #   in Loop: Header=BB90_3 Depth=1
	movq	-80(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -80(%rbp)
	movq	-56(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -56(%rbp)
.LBB90_10:                              #   in Loop: Header=BB90_3 Depth=1
	movq	-56(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -56(%rbp)
	jmp	.LBB90_3
.LBB90_11:
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movq	(%rcx), %rcx
	subq	%rcx, %rax
	movq	-40(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB90_13
# %bb.12:
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$34, %eax
	je	.LBB90_14
.LBB90_13:
	jmp	.LBB90_36
.LBB90_14:
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-40(%rbp), %rdx
	addq	16(%rdx), %rcx
	subq	%rcx, %rax
	subq	-80(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-40(%rbp), %rax
	movq	32(%rax), %rax
	movq	-72(%rbp), %rdi
	addq	$1, %rdi
	callq	*%rax
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.LBB90_16
# %bb.15:
	jmp	.LBB90_36
.LBB90_16:
	movq	-64(%rbp), %rax
	movq	%rax, -16(%rbp)
.LBB90_17:                              # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jae	.LBB90_35
# %bb.18:                               #   in Loop: Header=BB90_17 Depth=1
	movq	-48(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$92, %eax
	je	.LBB90_20
# %bb.19:                               #   in Loop: Header=BB90_17 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -48(%rbp)
	movb	(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
	jmp	.LBB90_34
.LBB90_20:                              #   in Loop: Header=BB90_17 Depth=1
	movb	$2, -81(%rbp)
	movq	-56(%rbp), %rax
	movq	-48(%rbp), %rcx
	subq	%rcx, %rax
	cmpq	$1, %rax
	jge	.LBB90_22
# %bb.21:
	jmp	.LBB90_36
.LBB90_22:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	addl	$-34, %eax
	movl	%eax, %ecx
	movq	%rcx, -96(%rbp)                 # 8-byte Spill
	subl	$83, %eax
	ja	.LBB90_32
# %bb.44:                               #   in Loop: Header=BB90_17 Depth=1
	movq	-96(%rbp), %rax                 # 8-byte Reload
	leaq	.LJTI90_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB90_23:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movb	$8, (%rax)
	jmp	.LBB90_33
.LBB90_24:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movb	$12, (%rax)
	jmp	.LBB90_33
.LBB90_25:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movb	$10, (%rax)
	jmp	.LBB90_33
.LBB90_26:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movb	$13, (%rax)
	jmp	.LBB90_33
.LBB90_27:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movb	$9, (%rax)
	jmp	.LBB90_33
.LBB90_28:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-48(%rbp), %rax
	movb	1(%rax), %cl
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -16(%rbp)
	movb	%cl, (%rax)
	jmp	.LBB90_33
.LBB90_29:                              #   in Loop: Header=BB90_17 Depth=1
	movq	-48(%rbp), %rdi
	movq	-56(%rbp), %rsi
	leaq	-16(%rbp), %rdx
	callq	utf16_literal_to_utf8
	movb	%al, -81(%rbp)
	movzbl	-81(%rbp), %eax
	cmpl	$0, %eax
	jne	.LBB90_31
# %bb.30:
	jmp	.LBB90_36
.LBB90_31:                              #   in Loop: Header=BB90_17 Depth=1
	jmp	.LBB90_33
.LBB90_32:
	jmp	.LBB90_36
.LBB90_33:                              #   in Loop: Header=BB90_17 Depth=1
	movzbl	-81(%rbp), %ecx
	movq	-48(%rbp), %rax
	movslq	%ecx, %rcx
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
.LBB90_34:                              #   in Loop: Header=BB90_17 Depth=1
	jmp	.LBB90_17
.LBB90_35:
	movq	-16(%rbp), %rax
	movb	$0, (%rax)
	movq	-32(%rbp), %rax
	movl	$16, 24(%rax)
	movq	-64(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, 32(%rax)
	movq	-56(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	subq	%rax, %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, 16(%rax)
	movq	-40(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -20(%rbp)
	jmp	.LBB90_41
.LBB90_36:
	cmpq	$0, -64(%rbp)
	je	.LBB90_38
# %bb.37:
	movq	-40(%rbp), %rax
	movq	40(%rax), %rax
	movq	-64(%rbp), %rdi
	callq	*%rax
.LBB90_38:
	cmpq	$0, -48(%rbp)
	je	.LBB90_40
# %bb.39:
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	subq	%rax, %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, 16(%rax)
.LBB90_40:
	movl	$0, -20(%rbp)
.LBB90_41:
	movl	-20(%rbp), %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB90_43
# %bb.42:
	movl	-100(%rbp), %eax                # 4-byte Reload
	addq	$112, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB90_43:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end90:
	.size	parse_string, .Lfunc_end90-parse_string
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI90_0:
	.long	.LBB90_28-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_28-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_28-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_23-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_24-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_25-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_26-.LJTI90_0
	.long	.LBB90_32-.LJTI90_0
	.long	.LBB90_27-.LJTI90_0
	.long	.LBB90_29-.LJTI90_0
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function parse_number
.LCPI91_0:
	.quad	0x41dfffffffc00000              # double 2147483647
.LCPI91_1:
	.quad	0xc1e0000000000000              # double -2147483648
	.text
	.p2align	4, 0x90
	.type	parse_number,@function
parse_number:                           # @parse_number
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -120(%rbp)
	movq	$0, -88(%rbp)
	callq	get_decimal_point
	movb	%al, -121(%rbp)
	movq	$0, -136(%rbp)
	cmpq	$0, -112(%rbp)
	je	.LBB91_2
# %bb.1:
	movq	-112(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB91_3
.LBB91_2:
	movl	$0, -92(%rbp)
	jmp	.LBB91_25
.LBB91_3:
	movq	$0, -136(%rbp)
.LBB91_4:                               # =>This Inner Loop Header: Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$63, -136(%rbp)
	movb	%al, -137(%rbp)                 # 1-byte Spill
	jae	.LBB91_8
# %bb.5:                                #   in Loop: Header=BB91_4 Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -112(%rbp)
	movb	%al, -138(%rbp)                 # 1-byte Spill
	je	.LBB91_7
# %bb.6:                                #   in Loop: Header=BB91_4 Depth=1
	movq	-112(%rbp), %rax
	movq	16(%rax), %rax
	addq	-136(%rbp), %rax
	movq	-112(%rbp), %rcx
	cmpq	8(%rcx), %rax
	setb	%al
	movb	%al, -138(%rbp)                 # 1-byte Spill
.LBB91_7:                               #   in Loop: Header=BB91_4 Depth=1
	movb	-138(%rbp), %al                 # 1-byte Reload
	movb	%al, -137(%rbp)                 # 1-byte Spill
.LBB91_8:                               #   in Loop: Header=BB91_4 Depth=1
	movb	-137(%rbp), %al                 # 1-byte Reload
	testb	$1, %al
	jne	.LBB91_9
	jmp	.LBB91_15
.LBB91_9:                               #   in Loop: Header=BB91_4 Depth=1
	movq	-112(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rax), %rax
	addq	%rax, %rcx
	movq	-136(%rbp), %rax
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -144(%rbp)                # 4-byte Spill
	subl	$43, %eax
	je	.LBB91_10
	jmp	.LBB91_28
.LBB91_28:                              #   in Loop: Header=BB91_4 Depth=1
	movl	-144(%rbp), %eax                # 4-byte Reload
	subl	$45, %eax
	je	.LBB91_10
	jmp	.LBB91_29
.LBB91_29:                              #   in Loop: Header=BB91_4 Depth=1
	movl	-144(%rbp), %eax                # 4-byte Reload
	subl	$46, %eax
	je	.LBB91_11
	jmp	.LBB91_30
.LBB91_30:                              #   in Loop: Header=BB91_4 Depth=1
	movl	-144(%rbp), %eax                # 4-byte Reload
	addl	$-48, %eax
	subl	$10, %eax
	jb	.LBB91_10
	jmp	.LBB91_31
.LBB91_31:                              #   in Loop: Header=BB91_4 Depth=1
	movl	-144(%rbp), %eax                # 4-byte Reload
	subl	$69, %eax
	je	.LBB91_10
	jmp	.LBB91_32
.LBB91_32:                              #   in Loop: Header=BB91_4 Depth=1
	movl	-144(%rbp), %eax                # 4-byte Reload
	subl	$101, %eax
	jne	.LBB91_12
	jmp	.LBB91_10
.LBB91_10:                              #   in Loop: Header=BB91_4 Depth=1
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	-112(%rbp), %rcx
	addq	16(%rcx), %rax
	movq	-136(%rbp), %rcx
	movb	(%rax,%rcx), %cl
	movq	-136(%rbp), %rax
	movb	%cl, -80(%rbp,%rax)
	jmp	.LBB91_13
.LBB91_11:                              #   in Loop: Header=BB91_4 Depth=1
	movb	-121(%rbp), %cl
	movq	-136(%rbp), %rax
	movb	%cl, -80(%rbp,%rax)
	jmp	.LBB91_13
.LBB91_12:
	jmp	.LBB91_16
.LBB91_13:                              #   in Loop: Header=BB91_4 Depth=1
	jmp	.LBB91_14
.LBB91_14:                              #   in Loop: Header=BB91_4 Depth=1
	movq	-136(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -136(%rbp)
	jmp	.LBB91_4
.LBB91_15:
	jmp	.LBB91_16
.LBB91_16:
	movq	-136(%rbp), %rax
	movb	$0, -80(%rbp,%rax)
	leaq	-80(%rbp), %rdi
	leaq	-88(%rbp), %rsi
	callq	strtod@PLT
	movsd	%xmm0, -120(%rbp)
	leaq	-80(%rbp), %rax
	cmpq	-88(%rbp), %rax
	jne	.LBB91_18
# %bb.17:
	movl	$0, -92(%rbp)
	jmp	.LBB91_25
.LBB91_18:
	movsd	-120(%rbp), %xmm0               # xmm0 = mem[0],zero
	movq	-104(%rbp), %rax
	movsd	%xmm0, 48(%rax)
	movsd	-120(%rbp), %xmm0               # xmm0 = mem[0],zero
	movsd	.LCPI91_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	.LBB91_20
# %bb.19:
	movq	-104(%rbp), %rax
	movl	$2147483647, 40(%rax)           # imm = 0x7FFFFFFF
	jmp	.LBB91_24
.LBB91_20:
	movsd	.LCPI91_1(%rip), %xmm0          # xmm0 = mem[0],zero
	ucomisd	-120(%rbp), %xmm0
	jb	.LBB91_22
# %bb.21:
	movq	-104(%rbp), %rax
	movl	$-2147483648, 40(%rax)          # imm = 0x80000000
	jmp	.LBB91_23
.LBB91_22:
	cvttsd2si	-120(%rbp), %ecx
	movq	-104(%rbp), %rax
	movl	%ecx, 40(%rax)
.LBB91_23:
	jmp	.LBB91_24
.LBB91_24:
	movq	-104(%rbp), %rax
	movl	$8, 24(%rax)
	movq	-88(%rbp), %rcx
	leaq	-80(%rbp), %rax
	subq	%rax, %rcx
	movq	-112(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -92(%rbp)
.LBB91_25:
	movl	-92(%rbp), %eax
	movl	%eax, -148(%rbp)                # 4-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB91_27
# %bb.26:
	movl	-148(%rbp), %eax                # 4-byte Reload
	addq	$160, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB91_27:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end91:
	.size	parse_number, .Lfunc_end91-parse_number
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function parse_array
	.type	parse_array,@function
parse_array:                            # @parse_array
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1000, 24(%rax)                 # imm = 0x3E8
	jb	.LBB92_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB92_33
.LBB92_2:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 24(%rax)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$91, %eax
	je	.LBB92_4
# %bb.3:
	jmp	.LBB92_30
.LBB92_4:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
	cmpq	$0, -24(%rbp)
	je	.LBB92_8
# %bb.5:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB92_8
# %bb.6:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$93, %eax
	jne	.LBB92_8
# %bb.7:
	jmp	.LBB92_29
.LBB92_8:
	cmpq	$0, -24(%rbp)
	je	.LBB92_10
# %bb.9:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jb	.LBB92_11
.LBB92_10:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 16(%rax)
	jmp	.LBB92_30
.LBB92_11:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 16(%rax)
.LBB92_12:                              # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rdi
	addq	$32, %rdi
	callq	cJSON_New_Item
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB92_14
# %bb.13:
	jmp	.LBB92_30
.LBB92_14:                              #   in Loop: Header=BB92_12 Depth=1
	cmpq	$0, -32(%rbp)
	jne	.LBB92_16
# %bb.15:                               #   in Loop: Header=BB92_12 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	%rax, -40(%rbp)
	jmp	.LBB92_17
.LBB92_16:                              #   in Loop: Header=BB92_12 Depth=1
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-48(%rbp), %rax
	movq	%rax, -40(%rbp)
.LBB92_17:                              #   in Loop: Header=BB92_12 Depth=1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
	movq	-40(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_value
	cmpl	$0, %eax
	jne	.LBB92_19
# %bb.18:
	jmp	.LBB92_30
.LBB92_19:                              #   in Loop: Header=BB92_12 Depth=1
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
# %bb.20:                               #   in Loop: Header=BB92_12 Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -24(%rbp)
	movb	%al, -49(%rbp)                  # 1-byte Spill
	je	.LBB92_23
# %bb.21:                               #   in Loop: Header=BB92_12 Depth=1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$0, %rcx
	movq	-24(%rbp), %rdx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	8(%rdx), %rcx
	movb	%al, -49(%rbp)                  # 1-byte Spill
	jae	.LBB92_23
# %bb.22:                               #   in Loop: Header=BB92_12 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$44, %eax
	sete	%al
	movb	%al, -49(%rbp)                  # 1-byte Spill
.LBB92_23:                              #   in Loop: Header=BB92_12 Depth=1
	movb	-49(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB92_12
# %bb.24:
	cmpq	$0, -24(%rbp)
	je	.LBB92_27
# %bb.25:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB92_27
# %bb.26:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$93, %eax
	je	.LBB92_28
.LBB92_27:
	jmp	.LBB92_30
.LBB92_28:
	jmp	.LBB92_29
.LBB92_29:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 24(%rax)
	movq	-16(%rbp), %rax
	movl	$32, 24(%rax)
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB92_33
.LBB92_30:
	cmpq	$0, -32(%rbp)
	je	.LBB92_32
# %bb.31:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
.LBB92_32:
	movl	$0, -4(%rbp)
.LBB92_33:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end92:
	.size	parse_array, .Lfunc_end92-parse_array
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function parse_object
	.type	parse_object,@function
parse_object:                           # @parse_object
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1000, 24(%rax)                 # imm = 0x3E8
	jb	.LBB93_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB93_41
.LBB93_2:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 24(%rax)
	cmpq	$0, -24(%rbp)
	je	.LBB93_5
# %bb.3:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB93_5
# %bb.4:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$123, %eax
	je	.LBB93_6
.LBB93_5:
	jmp	.LBB93_38
.LBB93_6:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
	cmpq	$0, -24(%rbp)
	je	.LBB93_10
# %bb.7:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB93_10
# %bb.8:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$125, %eax
	jne	.LBB93_10
# %bb.9:
	jmp	.LBB93_37
.LBB93_10:
	cmpq	$0, -24(%rbp)
	je	.LBB93_12
# %bb.11:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jb	.LBB93_13
.LBB93_12:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 16(%rax)
	jmp	.LBB93_38
.LBB93_13:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 16(%rax)
.LBB93_14:                              # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rdi
	addq	$32, %rdi
	callq	cJSON_New_Item
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.LBB93_16
# %bb.15:
	jmp	.LBB93_38
.LBB93_16:                              #   in Loop: Header=BB93_14 Depth=1
	cmpq	$0, -32(%rbp)
	jne	.LBB93_18
# %bb.17:                               #   in Loop: Header=BB93_14 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	%rax, -40(%rbp)
	jmp	.LBB93_19
.LBB93_18:                              #   in Loop: Header=BB93_14 Depth=1
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-48(%rbp), %rax
	movq	%rax, -40(%rbp)
.LBB93_19:                              #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
	movq	-40(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_string
	cmpl	$0, %eax
	jne	.LBB93_21
# %bb.20:
	jmp	.LBB93_38
.LBB93_21:                              #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
	movq	-40(%rbp), %rax
	movq	32(%rax), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, 56(%rax)
	movq	-40(%rbp), %rax
	movq	$0, 32(%rax)
	cmpq	$0, -24(%rbp)
	je	.LBB93_24
# %bb.22:                               #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB93_24
# %bb.23:                               #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$58, %eax
	je	.LBB93_25
.LBB93_24:
	jmp	.LBB93_38
.LBB93_25:                              #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
	movq	-40(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	parse_value
	cmpl	$0, %eax
	jne	.LBB93_27
# %bb.26:
	jmp	.LBB93_38
.LBB93_27:                              #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rdi
	callq	buffer_skip_whitespace
# %bb.28:                               #   in Loop: Header=BB93_14 Depth=1
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	$0, -24(%rbp)
	movb	%al, -49(%rbp)                  # 1-byte Spill
	je	.LBB93_31
# %bb.29:                               #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$0, %rcx
	movq	-24(%rbp), %rdx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpq	8(%rdx), %rcx
	movb	%al, -49(%rbp)                  # 1-byte Spill
	jae	.LBB93_31
# %bb.30:                               #   in Loop: Header=BB93_14 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$44, %eax
	sete	%al
	movb	%al, -49(%rbp)                  # 1-byte Spill
.LBB93_31:                              #   in Loop: Header=BB93_14 Depth=1
	movb	-49(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB93_14
# %bb.32:
	cmpq	$0, -24(%rbp)
	je	.LBB93_35
# %bb.33:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	addq	$0, %rax
	movq	-24(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jae	.LBB93_35
# %bb.34:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movq	16(%rcx), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$125, %eax
	je	.LBB93_36
.LBB93_35:
	jmp	.LBB93_38
.LBB93_36:
	jmp	.LBB93_37
.LBB93_37:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 24(%rax)
	movq	-16(%rbp), %rax
	movl	$64, 24(%rax)
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -4(%rbp)
	jmp	.LBB93_41
.LBB93_38:
	cmpq	$0, -32(%rbp)
	je	.LBB93_40
# %bb.39:
	movq	-32(%rbp), %rdi
	callq	cJSON_Delete@PLT
.LBB93_40:
	movl	$0, -4(%rbp)
.LBB93_41:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end93:
	.size	parse_object, .Lfunc_end93-parse_object
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function utf16_literal_to_utf8
	.type	utf16_literal_to_utf8,@function
utf16_literal_to_utf8:                  # @utf16_literal_to_utf8
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
	movq	$0, -40(%rbp)
	movl	$0, -44(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -56(%rbp)
	movb	$0, -57(%rbp)
	movb	$0, -58(%rbp)
	movb	$0, -59(%rbp)
	movb	$0, -60(%rbp)
	movq	-24(%rbp), %rax
	movq	-56(%rbp), %rcx
	subq	%rcx, %rax
	cmpq	$6, %rax
	jge	.LBB94_2
# %bb.1:
	jmp	.LBB94_37
.LBB94_2:
	movq	-56(%rbp), %rdi
	addq	$2, %rdi
	callq	parse_hex4
	movl	%eax, -44(%rbp)
	cmpl	$56320, -44(%rbp)               # imm = 0xDC00
	jb	.LBB94_5
# %bb.3:
	cmpl	$57343, -44(%rbp)               # imm = 0xDFFF
	ja	.LBB94_5
# %bb.4:
	jmp	.LBB94_37
.LBB94_5:
	cmpl	$55296, -44(%rbp)               # imm = 0xD800
	jb	.LBB94_16
# %bb.6:
	cmpl	$56319, -44(%rbp)               # imm = 0xDBFF
	ja	.LBB94_16
# %bb.7:
	movq	-56(%rbp), %rax
	addq	$6, %rax
	movq	%rax, -72(%rbp)
	movl	$0, -76(%rbp)
	movb	$12, -59(%rbp)
	movq	-24(%rbp), %rax
	movq	-72(%rbp), %rcx
	subq	%rcx, %rax
	cmpq	$6, %rax
	jge	.LBB94_9
# %bb.8:
	jmp	.LBB94_37
.LBB94_9:
	movq	-72(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$92, %eax
	jne	.LBB94_11
# %bb.10:
	movq	-72(%rbp), %rax
	movzbl	1(%rax), %eax
	cmpl	$117, %eax
	je	.LBB94_12
.LBB94_11:
	jmp	.LBB94_37
.LBB94_12:
	movq	-72(%rbp), %rdi
	addq	$2, %rdi
	callq	parse_hex4
	movl	%eax, -76(%rbp)
	cmpl	$56320, -76(%rbp)               # imm = 0xDC00
	jb	.LBB94_14
# %bb.13:
	cmpl	$57343, -76(%rbp)               # imm = 0xDFFF
	jbe	.LBB94_15
.LBB94_14:
	jmp	.LBB94_37
.LBB94_15:
	movl	-44(%rbp), %eax
	andl	$1023, %eax                     # imm = 0x3FF
	shll	$10, %eax
	movl	-76(%rbp), %ecx
	andl	$1023, %ecx                     # imm = 0x3FF
	orl	%ecx, %eax
	addl	$65536, %eax                    # imm = 0x10000
	movl	%eax, %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -40(%rbp)
	jmp	.LBB94_17
.LBB94_16:
	movb	$6, -59(%rbp)
	movl	-44(%rbp), %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -40(%rbp)
.LBB94_17:
	cmpq	$128, -40(%rbp)
	jae	.LBB94_19
# %bb.18:
	movb	$1, -57(%rbp)
	jmp	.LBB94_29
.LBB94_19:
	cmpq	$2048, -40(%rbp)                # imm = 0x800
	jae	.LBB94_21
# %bb.20:
	movb	$2, -57(%rbp)
	movb	$-64, -60(%rbp)
	jmp	.LBB94_28
.LBB94_21:
	cmpq	$65536, -40(%rbp)               # imm = 0x10000
	jae	.LBB94_23
# %bb.22:
	movb	$3, -57(%rbp)
	movb	$-32, -60(%rbp)
	jmp	.LBB94_27
.LBB94_23:
	cmpq	$1114111, -40(%rbp)             # imm = 0x10FFFF
	ja	.LBB94_25
# %bb.24:
	movb	$4, -57(%rbp)
	movb	$-16, -60(%rbp)
	jmp	.LBB94_26
.LBB94_25:
	jmp	.LBB94_37
.LBB94_26:
	jmp	.LBB94_27
.LBB94_27:
	jmp	.LBB94_28
.LBB94_28:
	jmp	.LBB94_29
.LBB94_29:
	movzbl	-57(%rbp), %eax
	subl	$1, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -58(%rbp)
.LBB94_30:                              # =>This Inner Loop Header: Depth=1
	movzbl	-58(%rbp), %eax
	cmpl	$0, %eax
	jle	.LBB94_33
# %bb.31:                               #   in Loop: Header=BB94_30 Depth=1
	movq	-40(%rbp), %rax
	orq	$128, %rax
	andq	$191, %rax
	movb	%al, %dl
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movzbl	-58(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-40(%rbp), %rax
	shrq	$6, %rax
	movq	%rax, -40(%rbp)
# %bb.32:                               #   in Loop: Header=BB94_30 Depth=1
	movb	-58(%rbp), %al
	addb	$-1, %al
	movb	%al, -58(%rbp)
	jmp	.LBB94_30
.LBB94_33:
	movzbl	-57(%rbp), %eax
	cmpl	$1, %eax
	jle	.LBB94_35
# %bb.34:
	movq	-40(%rbp), %rax
	movzbl	-60(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	orq	%rcx, %rax
	andq	$255, %rax
	movb	%al, %cl
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movb	%cl, (%rax)
	jmp	.LBB94_36
.LBB94_35:
	movq	-40(%rbp), %rax
	andq	$127, %rax
	movb	%al, %cl
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movb	%cl, (%rax)
.LBB94_36:
	movzbl	-57(%rbp), %edx
	movq	-32(%rbp), %rax
	movq	(%rax), %rcx
	movslq	%edx, %rdx
	addq	%rdx, %rcx
	movq	%rcx, (%rax)
	movb	-59(%rbp), %al
	movb	%al, -1(%rbp)
	jmp	.LBB94_38
.LBB94_37:
	movb	$0, -1(%rbp)
.LBB94_38:
	movzbl	-1(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end94:
	.size	utf16_literal_to_utf8, .Lfunc_end94-utf16_literal_to_utf8
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function parse_hex4
	.type	parse_hex4,@function
parse_hex4:                             # @parse_hex4
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, -20(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -32(%rbp)
.LBB95_1:                               # =>This Inner Loop Header: Depth=1
	cmpq	$4, -32(%rbp)
	jae	.LBB95_18
# %bb.2:                                #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$48, %eax
	jl	.LBB95_5
# %bb.3:                                #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$57, %eax
	jg	.LBB95_5
# %bb.4:                                #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	subl	$48, %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB95_14
.LBB95_5:                               #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$65, %eax
	jl	.LBB95_8
# %bb.6:                                #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$70, %eax
	jg	.LBB95_8
# %bb.7:                                #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	addl	$10, %eax
	subl	$65, %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB95_13
.LBB95_8:                               #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$97, %eax
	jl	.LBB95_11
# %bb.9:                                #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	$102, %eax
	jg	.LBB95_11
# %bb.10:                               #   in Loop: Header=BB95_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-32(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	addl	$10, %eax
	subl	$97, %eax
	addl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB95_12
.LBB95_11:
	movl	$0, -4(%rbp)
	jmp	.LBB95_19
.LBB95_12:                              #   in Loop: Header=BB95_1 Depth=1
	jmp	.LBB95_13
.LBB95_13:                              #   in Loop: Header=BB95_1 Depth=1
	jmp	.LBB95_14
.LBB95_14:                              #   in Loop: Header=BB95_1 Depth=1
	cmpq	$3, -32(%rbp)
	jae	.LBB95_16
# %bb.15:                               #   in Loop: Header=BB95_1 Depth=1
	movl	-20(%rbp), %eax
	shll	$4, %eax
	movl	%eax, -20(%rbp)
.LBB95_16:                              #   in Loop: Header=BB95_1 Depth=1
	jmp	.LBB95_17
.LBB95_17:                              #   in Loop: Header=BB95_1 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB95_1
.LBB95_18:
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB95_19:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end95:
	.size	parse_hex4, .Lfunc_end95-parse_hex4
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function get_decimal_point
	.type	get_decimal_point,@function
get_decimal_point:                      # @get_decimal_point
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	callq	localeconv@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end96:
	.size	get_decimal_point, .Lfunc_end96-get_decimal_point
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function ensure
	.type	ensure,@function
ensure:                                 # @ensure
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB97_2
# %bb.1:
	movq	-16(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB97_3
.LBB97_2:
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_3:
	movq	-16(%rbp), %rax
	cmpq	$0, 8(%rax)
	jbe	.LBB97_6
# %bb.4:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	-16(%rbp), %rcx
	cmpq	8(%rcx), %rax
	jb	.LBB97_6
# %bb.5:
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_6:
	cmpq	$2147483647, -24(%rbp)          # imm = 0x7FFFFFFF
	jbe	.LBB97_8
# %bb.7:
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_8:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	addq	$1, %rax
	addq	-24(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	8(%rcx), %rax
	ja	.LBB97_10
# %bb.9:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rcx
	addq	16(%rcx), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB97_28
.LBB97_10:
	movq	-16(%rbp), %rax
	cmpl	$0, 32(%rax)
	je	.LBB97_12
# %bb.11:
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_12:
	cmpq	$1073741823, -24(%rbp)          # imm = 0x3FFFFFFF
	jbe	.LBB97_17
# %bb.13:
	cmpq	$2147483647, -24(%rbp)          # imm = 0x7FFFFFFF
	ja	.LBB97_15
# %bb.14:
	movq	$2147483647, -40(%rbp)          # imm = 0x7FFFFFFF
	jmp	.LBB97_16
.LBB97_15:
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_16:
	jmp	.LBB97_18
.LBB97_17:
	movq	-24(%rbp), %rax
	shlq	$1, %rax
	movq	%rax, -40(%rbp)
.LBB97_18:
	movq	-16(%rbp), %rax
	cmpq	$0, 56(%rax)
	je	.LBB97_22
# %bb.19:
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rdi
	movq	-40(%rbp), %rsi
	callq	*%rax
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB97_21
# %bb.20:
	movq	-16(%rbp), %rax
	movq	48(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rdi
	callq	*%rax
	movq	-16(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-16(%rbp), %rax
	movq	$0, (%rax)
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_21:
	jmp	.LBB97_27
.LBB97_22:
	movq	-16(%rbp), %rax
	movq	40(%rax), %rax
	movq	-40(%rbp), %rdi
	callq	*%rax
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB97_24
# %bb.23:
	movq	-16(%rbp), %rax
	movq	48(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rdi
	callq	*%rax
	movq	-16(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-16(%rbp), %rax
	movq	$0, (%rax)
	movq	$0, -8(%rbp)
	jmp	.LBB97_28
.LBB97_24:
	cmpq	$0, -32(%rbp)
	je	.LBB97_26
# %bb.25:
	movq	-32(%rbp), %rdi
	movq	-16(%rbp), %rax
	movq	(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdx
	addq	$1, %rdx
	callq	memcpy@PLT
.LBB97_26:
	movq	-16(%rbp), %rax
	movq	48(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rdi
	callq	*%rax
.LBB97_27:
	movq	-40(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-32(%rbp), %rax
	movq	-16(%rbp), %rcx
	addq	16(%rcx), %rax
	movq	%rax, -8(%rbp)
.LBB97_28:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end97:
	.size	ensure, .Lfunc_end97-ensure
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_number
	.type	print_number,@function
print_number:                           # @print_number
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	$0, -88(%rbp)
	movq	-72(%rbp), %rax
	movsd	48(%rax), %xmm0                 # xmm0 = mem[0],zero
	movsd	%xmm0, -96(%rbp)
	movl	$0, -100(%rbp)
	movq	$0, -112(%rbp)
	callq	get_decimal_point
	movb	%al, -113(%rbp)
	cmpq	$0, -80(%rbp)
	jne	.LBB98_2
# %bb.1:
	movl	$0, -60(%rbp)
	jmp	.LBB98_20
.LBB98_2:
	xorps	%xmm0, %xmm0
	mulsd	-96(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.LBB98_3
	jp	.LBB98_3
	jmp	.LBB98_4
.LBB98_3:
	leaq	-48(%rbp), %rdi
	leaq	.L.str.2(%rip), %rsi
	movb	$0, %al
	callq	sprintf@PLT
	movl	%eax, -100(%rbp)
	jmp	.LBB98_8
.LBB98_4:
	leaq	-48(%rbp), %rdi
	movsd	-96(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.5(%rip), %rsi
	movb	$1, %al
	callq	sprintf@PLT
	movl	%eax, -100(%rbp)
	leaq	-48(%rbp), %rdi
	leaq	.L.str.6(%rip), %rsi
	leaq	-56(%rbp), %rdx
	movb	$0, %al
	callq	__isoc99_sscanf@PLT
	cmpl	$1, %eax
	jne	.LBB98_6
# %bb.5:
	movsd	-56(%rbp), %xmm0                # xmm0 = mem[0],zero
	ucomisd	-96(%rbp), %xmm0
	jne	.LBB98_6
	jp	.LBB98_6
	jmp	.LBB98_7
.LBB98_6:
	leaq	-48(%rbp), %rdi
	movsd	-96(%rbp), %xmm0                # xmm0 = mem[0],zero
	leaq	.L.str.7(%rip), %rsi
	movb	$1, %al
	callq	sprintf@PLT
	movl	%eax, -100(%rbp)
.LBB98_7:
	jmp	.LBB98_8
.LBB98_8:
	cmpl	$0, -100(%rbp)
	jl	.LBB98_10
# %bb.9:
	cmpl	$25, -100(%rbp)
	jle	.LBB98_11
.LBB98_10:
	movl	$0, -60(%rbp)
	jmp	.LBB98_20
.LBB98_11:
	movq	-80(%rbp), %rdi
	movslq	-100(%rbp), %rsi
	addq	$1, %rsi
	callq	ensure
	movq	%rax, -88(%rbp)
	cmpq	$0, -88(%rbp)
	jne	.LBB98_13
# %bb.12:
	movl	$0, -60(%rbp)
	jmp	.LBB98_20
.LBB98_13:
	movq	$0, -112(%rbp)
.LBB98_14:                              # =>This Inner Loop Header: Depth=1
	movq	-112(%rbp), %rax
	movslq	-100(%rbp), %rcx
	cmpq	%rcx, %rax
	jae	.LBB98_19
# %bb.15:                               #   in Loop: Header=BB98_14 Depth=1
	movq	-112(%rbp), %rax
	movzbl	-48(%rbp,%rax), %eax
	movzbl	-113(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB98_17
# %bb.16:                               #   in Loop: Header=BB98_14 Depth=1
	movq	-88(%rbp), %rax
	movq	-112(%rbp), %rcx
	movb	$46, (%rax,%rcx)
	jmp	.LBB98_18
.LBB98_17:                              #   in Loop: Header=BB98_14 Depth=1
	movq	-112(%rbp), %rax
	movb	-48(%rbp,%rax), %dl
	movq	-88(%rbp), %rax
	movq	-112(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
.LBB98_18:                              #   in Loop: Header=BB98_14 Depth=1
	movq	-112(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -112(%rbp)
	jmp	.LBB98_14
.LBB98_19:
	movq	-88(%rbp), %rax
	movq	-112(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movslq	-100(%rbp), %rcx
	movq	-80(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
	movl	$1, -60(%rbp)
.LBB98_20:
	movl	-60(%rbp), %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
	movq	%fs:40, %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	.LBB98_22
# %bb.21:
	movl	-120(%rbp), %eax                # 4-byte Reload
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB98_22:
	.cfi_def_cfa %rbp, 16
	callq	__stack_chk_fail@PLT
.Lfunc_end98:
	.size	print_number, .Lfunc_end98-print_number
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_string
	.type	print_string,@function
print_string:                           # @print_string
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
	movq	-8(%rbp), %rax
	movq	32(%rax), %rdi
	movq	-16(%rbp), %rsi
	callq	print_string_ptr
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end99:
	.size	print_string, .Lfunc_end99-print_string
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_array
	.type	print_array,@function
print_array:                            # @print_array
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -48(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB100_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB100_18
.LBB100_2:
	movq	-24(%rbp), %rdi
	movl	$1, %esi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB100_4
# %bb.3:
	movl	$0, -4(%rbp)
	jmp	.LBB100_18
.LBB100_4:
	movq	-32(%rbp), %rax
	movb	$91, (%rax)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 24(%rax)
.LBB100_5:                              # =>This Inner Loop Header: Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB100_15
# %bb.6:                                #   in Loop: Header=BB100_5 Depth=1
	movq	-48(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	print_value
	cmpl	$0, %eax
	jne	.LBB100_8
# %bb.7:
	movl	$0, -4(%rbp)
	jmp	.LBB100_18
.LBB100_8:                              #   in Loop: Header=BB100_5 Depth=1
	movq	-24(%rbp), %rdi
	callq	update_offset
	movq	-48(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB100_14
# %bb.9:                                #   in Loop: Header=BB100_5 Depth=1
	movq	-24(%rbp), %rax
	movl	36(%rax), %edx
	movl	$1, %eax
	movl	$2, %ecx
	cmpl	$0, %edx
	cmovnel	%ecx, %eax
	cltq
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rsi
	addq	$1, %rsi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB100_11
# %bb.10:
	movl	$0, -4(%rbp)
	jmp	.LBB100_18
.LBB100_11:                             #   in Loop: Header=BB100_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$44, (%rax)
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB100_13
# %bb.12:                               #   in Loop: Header=BB100_5 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$32, (%rax)
.LBB100_13:                             #   in Loop: Header=BB100_5 Depth=1
	movq	-32(%rbp), %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
.LBB100_14:                             #   in Loop: Header=BB100_5 Depth=1
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB100_5
.LBB100_15:
	movq	-24(%rbp), %rdi
	movl	$2, %esi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB100_17
# %bb.16:
	movl	$0, -4(%rbp)
	jmp	.LBB100_18
.LBB100_17:
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$93, (%rax)
	movq	-32(%rbp), %rax
	movb	$0, (%rax)
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 24(%rax)
	movl	$1, -4(%rbp)
.LBB100_18:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end100:
	.size	print_array, .Lfunc_end100-print_array
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_object
	.type	print_object,@function
print_object:                           # @print_object
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -48(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB101_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_2:
	movq	-24(%rbp), %rax
	movl	36(%rax), %edx
	movl	$1, %eax
	movl	$2, %ecx
	cmpl	$0, %edx
	cmovnel	%ecx, %eax
	cltq
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rsi
	addq	$1, %rsi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB101_4
# %bb.3:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_4:
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$123, (%rax)
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$1, %rcx
	movq	%rcx, 24(%rax)
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB101_6
# %bb.5:
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$10, (%rax)
.LBB101_6:
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
.LBB101_7:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB101_12 Depth 2
	cmpq	$0, -48(%rbp)
	je	.LBB101_31
# %bb.8:                                #   in Loop: Header=BB101_7 Depth=1
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB101_16
# %bb.9:                                #   in Loop: Header=BB101_7 Depth=1
	movq	-24(%rbp), %rdi
	movq	-24(%rbp), %rax
	movq	24(%rax), %rsi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB101_11
# %bb.10:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_11:                             #   in Loop: Header=BB101_7 Depth=1
	movq	$0, -56(%rbp)
.LBB101_12:                             #   Parent Loop BB101_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-56(%rbp), %rax
	movq	-24(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB101_15
# %bb.13:                               #   in Loop: Header=BB101_12 Depth=2
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$9, (%rax)
# %bb.14:                               #   in Loop: Header=BB101_12 Depth=2
	movq	-56(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -56(%rbp)
	jmp	.LBB101_12
.LBB101_15:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	movq	-24(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
.LBB101_16:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-48(%rbp), %rax
	movq	56(%rax), %rdi
	movq	-24(%rbp), %rsi
	callq	print_string_ptr
	cmpl	$0, %eax
	jne	.LBB101_18
# %bb.17:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_18:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-24(%rbp), %rdi
	callq	update_offset
	movq	-24(%rbp), %rax
	movl	36(%rax), %edx
	movl	$1, %eax
	movl	$2, %ecx
	cmpl	$0, %edx
	cmovnel	%ecx, %eax
	cltq
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB101_20
# %bb.19:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_20:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$58, (%rax)
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB101_22
# %bb.21:                               #   in Loop: Header=BB101_7 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$9, (%rax)
.LBB101_22:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
	movq	-48(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	print_value
	cmpl	$0, %eax
	jne	.LBB101_24
# %bb.23:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_24:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-24(%rbp), %rdi
	callq	update_offset
	movq	-24(%rbp), %rax
	movl	36(%rax), %edx
	xorl	%eax, %eax
	movl	$1, %ecx
	cmpl	$0, %edx
	cmovnel	%ecx, %eax
	cltq
	movq	-48(%rbp), %rcx
	movq	(%rcx), %rsi
	xorl	%ecx, %ecx
	movl	$1, %edx
	cmpq	$0, %rsi
	cmovnel	%edx, %ecx
	movslq	%ecx, %rcx
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	movq	-40(%rbp), %rsi
	addq	$1, %rsi
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB101_26
# %bb.25:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_26:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-48(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB101_28
# %bb.27:                               #   in Loop: Header=BB101_7 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$44, (%rax)
.LBB101_28:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB101_30
# %bb.29:                               #   in Loop: Header=BB101_7 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$10, (%rax)
.LBB101_30:                             #   in Loop: Header=BB101_7 Depth=1
	movq	-32(%rbp), %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	16(%rax), %rcx
	movq	%rcx, 16(%rax)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB101_7
.LBB101_31:
	movq	-24(%rbp), %rax
	movq	%rax, -72(%rbp)                 # 8-byte Spill
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB101_33
# %bb.32:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	addq	$1, %rax
	movq	%rax, -80(%rbp)                 # 8-byte Spill
	jmp	.LBB101_34
.LBB101_33:
	movl	$2, %eax
	movq	%rax, -80(%rbp)                 # 8-byte Spill
	jmp	.LBB101_34
.LBB101_34:
	movq	-72(%rbp), %rdi                 # 8-byte Reload
	movq	-80(%rbp), %rsi                 # 8-byte Reload
	callq	ensure
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.LBB101_36
# %bb.35:
	movl	$0, -4(%rbp)
	jmp	.LBB101_43
.LBB101_36:
	movq	-24(%rbp), %rax
	cmpl	$0, 36(%rax)
	je	.LBB101_42
# %bb.37:
	movq	$0, -64(%rbp)
.LBB101_38:                             # =>This Inner Loop Header: Depth=1
	movq	-64(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	24(%rcx), %rcx
	subq	$1, %rcx
	cmpq	%rcx, %rax
	jae	.LBB101_41
# %bb.39:                               #   in Loop: Header=BB101_38 Depth=1
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$9, (%rax)
# %bb.40:                               #   in Loop: Header=BB101_38 Depth=1
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -64(%rbp)
	jmp	.LBB101_38
.LBB101_41:
	jmp	.LBB101_42
.LBB101_42:
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -32(%rbp)
	movb	$125, (%rax)
	movq	-32(%rbp), %rax
	movb	$0, (%rax)
	movq	-24(%rbp), %rax
	movq	24(%rax), %rcx
	addq	$-1, %rcx
	movq	%rcx, 24(%rax)
	movl	$1, -4(%rbp)
.LBB101_43:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end101:
	.size	print_object, .Lfunc_end101-print_object
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_string_ptr
	.type	print_string_ptr,@function
print_string_ptr:                       # @print_string_ptr
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
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -64(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.LBB102_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB102_38
.LBB102_2:
	cmpq	$0, -16(%rbp)
	jne	.LBB102_6
# %bb.3:
	movq	-24(%rbp), %rdi
	movl	$3, %esi
	callq	ensure
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB102_5
# %bb.4:
	movl	$0, -4(%rbp)
	jmp	.LBB102_38
.LBB102_5:
	movq	-40(%rbp), %rdi
	leaq	.L.str.8(%rip), %rsi
	callq	strcpy@PLT
	movl	$1, -4(%rbp)
	jmp	.LBB102_38
.LBB102_6:
	movq	-16(%rbp), %rax
	movq	%rax, -32(%rbp)
.LBB102_7:                              # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB102_15
# %bb.8:                                #   in Loop: Header=BB102_7 Depth=1
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	addl	$-8, %eax
	subl	$3, %eax
	jb	.LBB102_9
	jmp	.LBB102_45
.LBB102_45:                             #   in Loop: Header=BB102_7 Depth=1
	movl	-68(%rbp), %eax                 # 4-byte Reload
	addl	$-12, %eax
	subl	$2, %eax
	jb	.LBB102_9
	jmp	.LBB102_46
.LBB102_46:                             #   in Loop: Header=BB102_7 Depth=1
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$34, %eax
	je	.LBB102_9
	jmp	.LBB102_47
.LBB102_47:                             #   in Loop: Header=BB102_7 Depth=1
	movl	-68(%rbp), %eax                 # 4-byte Reload
	subl	$92, %eax
	jne	.LBB102_10
	jmp	.LBB102_9
.LBB102_9:                              #   in Loop: Header=BB102_7 Depth=1
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -64(%rbp)
	jmp	.LBB102_13
.LBB102_10:                             #   in Loop: Header=BB102_7 Depth=1
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$32, %eax
	jge	.LBB102_12
# %bb.11:                               #   in Loop: Header=BB102_7 Depth=1
	movq	-64(%rbp), %rax
	addq	$5, %rax
	movq	%rax, -64(%rbp)
.LBB102_12:                             #   in Loop: Header=BB102_7 Depth=1
	jmp	.LBB102_13
.LBB102_13:                             #   in Loop: Header=BB102_7 Depth=1
	jmp	.LBB102_14
.LBB102_14:                             #   in Loop: Header=BB102_7 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB102_7
.LBB102_15:
	movq	-32(%rbp), %rax
	movq	-16(%rbp), %rcx
	subq	%rcx, %rax
	addq	-64(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-24(%rbp), %rdi
	movq	-56(%rbp), %rsi
	addq	$3, %rsi
	callq	ensure
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB102_17
# %bb.16:
	movl	$0, -4(%rbp)
	jmp	.LBB102_38
.LBB102_17:
	cmpq	$0, -64(%rbp)
	jne	.LBB102_19
# %bb.18:
	movq	-40(%rbp), %rax
	movb	$34, (%rax)
	movq	-40(%rbp), %rdi
	addq	$1, %rdi
	movq	-16(%rbp), %rsi
	movq	-56(%rbp), %rdx
	callq	memcpy@PLT
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rcx
	movb	$34, 1(%rax,%rcx)
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rcx
	movb	$0, 2(%rax,%rcx)
	movl	$1, -4(%rbp)
	jmp	.LBB102_38
.LBB102_19:
	movq	-40(%rbp), %rax
	movb	$34, (%rax)
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -32(%rbp)
.LBB102_20:                             # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB102_37
# %bb.21:                               #   in Loop: Header=BB102_20 Depth=1
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$31, %eax
	jle	.LBB102_25
# %bb.22:                               #   in Loop: Header=BB102_20 Depth=1
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$34, %eax
	je	.LBB102_25
# %bb.23:                               #   in Loop: Header=BB102_20 Depth=1
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$92, %eax
	je	.LBB102_25
# %bb.24:                               #   in Loop: Header=BB102_20 Depth=1
	movq	-32(%rbp), %rax
	movb	(%rax), %cl
	movq	-48(%rbp), %rax
	movb	%cl, (%rax)
	jmp	.LBB102_35
.LBB102_25:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, %rcx
	incq	%rcx
	movq	%rcx, -48(%rbp)
	movb	$92, (%rax)
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	movl	%eax, -72(%rbp)                 # 4-byte Spill
	subl	$8, %eax
	je	.LBB102_28
	jmp	.LBB102_39
.LBB102_39:                             #   in Loop: Header=BB102_20 Depth=1
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$9, %eax
	je	.LBB102_32
	jmp	.LBB102_40
.LBB102_40:                             #   in Loop: Header=BB102_20 Depth=1
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$10, %eax
	je	.LBB102_30
	jmp	.LBB102_41
.LBB102_41:                             #   in Loop: Header=BB102_20 Depth=1
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$12, %eax
	je	.LBB102_29
	jmp	.LBB102_42
.LBB102_42:                             #   in Loop: Header=BB102_20 Depth=1
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$13, %eax
	je	.LBB102_31
	jmp	.LBB102_43
.LBB102_43:                             #   in Loop: Header=BB102_20 Depth=1
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$34, %eax
	je	.LBB102_27
	jmp	.LBB102_44
.LBB102_44:                             #   in Loop: Header=BB102_20 Depth=1
	movl	-72(%rbp), %eax                 # 4-byte Reload
	subl	$92, %eax
	jne	.LBB102_33
	jmp	.LBB102_26
.LBB102_26:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$92, (%rax)
	jmp	.LBB102_34
.LBB102_27:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$34, (%rax)
	jmp	.LBB102_34
.LBB102_28:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$98, (%rax)
	jmp	.LBB102_34
.LBB102_29:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$102, (%rax)
	jmp	.LBB102_34
.LBB102_30:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$110, (%rax)
	jmp	.LBB102_34
.LBB102_31:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$114, (%rax)
	jmp	.LBB102_34
.LBB102_32:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rax
	movb	$116, (%rax)
	jmp	.LBB102_34
.LBB102_33:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-48(%rbp), %rdi
	movq	-32(%rbp), %rax
	movzbl	(%rax), %edx
	leaq	.L.str.9(%rip), %rsi
	movb	$0, %al
	callq	sprintf@PLT
	movq	-48(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -48(%rbp)
.LBB102_34:                             #   in Loop: Header=BB102_20 Depth=1
	jmp	.LBB102_35
.LBB102_35:                             #   in Loop: Header=BB102_20 Depth=1
	jmp	.LBB102_36
.LBB102_36:                             #   in Loop: Header=BB102_20 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	.LBB102_20
.LBB102_37:
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rcx
	movb	$34, 1(%rax,%rcx)
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rcx
	movb	$0, 2(%rax,%rcx)
	movl	$1, -4(%rbp)
.LBB102_38:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end102:
	.size	print_string_ptr, .Lfunc_end102-print_string_ptr
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function case_insensitive_strcmp
	.type	case_insensitive_strcmp,@function
case_insensitive_strcmp:                # @case_insensitive_strcmp
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
	cmpq	$0, -16(%rbp)
	je	.LBB103_2
# %bb.1:
	cmpq	$0, -24(%rbp)
	jne	.LBB103_3
.LBB103_2:
	movl	$1, -4(%rbp)
	jmp	.LBB103_12
.LBB103_3:
	movq	-16(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jne	.LBB103_5
# %bb.4:
	movl	$0, -4(%rbp)
	jmp	.LBB103_12
.LBB103_5:
	jmp	.LBB103_6
.LBB103_6:                              # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movzbl	(%rax), %edi
	callq	tolower@PLT
	movl	%eax, -28(%rbp)                 # 4-byte Spill
	movq	-24(%rbp), %rax
	movzbl	(%rax), %edi
	callq	tolower@PLT
	movl	%eax, %ecx
	movl	-28(%rbp), %eax                 # 4-byte Reload
	cmpl	%ecx, %eax
	jne	.LBB103_11
# %bb.7:                                #   in Loop: Header=BB103_6 Depth=1
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpl	$0, %eax
	jne	.LBB103_9
# %bb.8:
	movl	$0, -4(%rbp)
	jmp	.LBB103_12
.LBB103_9:                              #   in Loop: Header=BB103_6 Depth=1
	jmp	.LBB103_10
.LBB103_10:                             #   in Loop: Header=BB103_6 Depth=1
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB103_6
.LBB103_11:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %edi
	callq	tolower@PLT
	movl	%eax, -32(%rbp)                 # 4-byte Spill
	movq	-24(%rbp), %rax
	movzbl	(%rax), %edi
	callq	tolower@PLT
	movl	%eax, %ecx
	movl	-32(%rbp), %eax                 # 4-byte Reload
	subl	%ecx, %eax
	movl	%eax, -4(%rbp)
.LBB103_12:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end103:
	.size	case_insensitive_strcmp, .Lfunc_end103-case_insensitive_strcmp
	.cfi_endproc
                                        # -- End function
	.type	global_error,@object            # @global_error
	.local	global_error
	.comm	global_error,16,8
	.type	cJSON_Version.version,@object   # @cJSON_Version.version
	.local	cJSON_Version.version
	.comm	cJSON_Version.version,15,1
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%i.%i.%i"
	.size	.L.str, 9

	.type	global_hooks,@object            # @global_hooks
	.data
	.p2align	3, 0x0
global_hooks:
	.quad	malloc
	.quad	free
	.quad	realloc
	.size	global_hooks, 24

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"\357\273\277"
	.size	.L.str.1, 4

	.type	print.default_buffer_size,@object # @print.default_buffer_size
	.section	.rodata,"a",@progbits
	.p2align	3, 0x0
print.default_buffer_size:
	.quad	256                             # 0x100
	.size	print.default_buffer_size, 8

	.type	.L.str.2,@object                # @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"null"
	.size	.L.str.2, 5

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"false"
	.size	.L.str.3, 6

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"true"
	.size	.L.str.4, 5

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"%1.15g"
	.size	.L.str.5, 7

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"%lg"
	.size	.L.str.6, 4

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"%1.17g"
	.size	.L.str.7, 7

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"\"\""
	.size	.L.str.8, 3

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"u%04x"
	.size	.L.str.9, 6

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym cJSON_IsString
	.addrsig_sym sprintf
	.addrsig_sym malloc
	.addrsig_sym free
	.addrsig_sym realloc
	.addrsig_sym cJSON_Delete
	.addrsig_sym cJSON_ParseWithOpts
	.addrsig_sym strlen
	.addrsig_sym cJSON_New_Item
	.addrsig_sym parse_value
	.addrsig_sym buffer_skip_whitespace
	.addrsig_sym skip_utf8_bom
	.addrsig_sym print
	.addrsig_sym print_value
	.addrsig_sym get_array_item
	.addrsig_sym cJSON_GetObjectItem
	.addrsig_sym get_object_item
	.addrsig_sym cJSON_GetObjectItemCaseSensitive
	.addrsig_sym add_item_to_array
	.addrsig_sym add_item_to_object
	.addrsig_sym create_reference
	.addrsig_sym cJSON_CreateNull
	.addrsig_sym cJSON_CreateTrue
	.addrsig_sym cJSON_CreateFalse
	.addrsig_sym cJSON_CreateBool
	.addrsig_sym cJSON_CreateNumber
	.addrsig_sym cJSON_CreateString
	.addrsig_sym cJSON_CreateRaw
	.addrsig_sym cJSON_CreateObject
	.addrsig_sym cJSON_CreateArray
	.addrsig_sym cJSON_DetachItemViaPointer
	.addrsig_sym cJSON_DetachItemFromArray
	.addrsig_sym cJSON_DetachItemFromObject
	.addrsig_sym cJSON_DetachItemFromObjectCaseSensitive
	.addrsig_sym cJSON_ReplaceItemViaPointer
	.addrsig_sym replace_item_in_object
	.addrsig_sym cJSON_strdup
	.addrsig_sym cast_away_const
	.addrsig_sym suffix_object
	.addrsig_sym cJSON_Duplicate
	.addrsig_sym cJSON_IsInvalid
	.addrsig_sym cJSON_Compare
	.addrsig_sym strcmp
	.addrsig_sym cJSON_free
	.addrsig_sym strncmp
	.addrsig_sym update_offset
	.addrsig_sym parse_string
	.addrsig_sym parse_number
	.addrsig_sym parse_array
	.addrsig_sym parse_object
	.addrsig_sym utf16_literal_to_utf8
	.addrsig_sym parse_hex4
	.addrsig_sym get_decimal_point
	.addrsig_sym strtod
	.addrsig_sym localeconv
	.addrsig_sym ensure
	.addrsig_sym strcpy
	.addrsig_sym print_number
	.addrsig_sym print_string
	.addrsig_sym print_array
	.addrsig_sym print_object
	.addrsig_sym __isoc99_sscanf
	.addrsig_sym print_string_ptr
	.addrsig_sym case_insensitive_strcmp
	.addrsig_sym tolower
	.addrsig_sym __stack_chk_fail
	.addrsig_sym global_error
	.addrsig_sym cJSON_Version.version
	.addrsig_sym global_hooks
