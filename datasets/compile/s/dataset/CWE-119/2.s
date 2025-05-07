	.text
	.file	"QuotedString.cpp"
	.globl	_ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print # -- Begin function _ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print
	.p2align	4, 0x90
	.type	_ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print,@function
_ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print: # @_ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print
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
	cmpq	$0, -16(%rbp)
	jne	.LBB0_2
# %bb.1:
	movq	-24(%rbp), %rdi
	leaq	.L.str(%rip), %rsi
	callq	_ZN5Print5printEPKc@PLT
	movq	%rax, -8(%rbp)
	jmp	.LBB0_6
.LBB0_2:
	movq	-24(%rbp), %rdi
	movq	(%rdi), %rax
	movl	$34, %esi
	callq	*16(%rax)
	movq	%rax, -32(%rbp)
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB0_5
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movb	(%rax), %al
	movq	-24(%rbp), %rsi
	movsbl	%al, %edi
	callq	_ZL11printCharTocR5Print
	addq	-32(%rbp), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB0_3
.LBB0_5:
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	movq	-24(%rbp), %rdi
	movq	(%rdi), %rax
	movl	$34, %esi
	callq	*16(%rax)
	movq	%rax, %rcx
	movq	-40(%rbp), %rax                 # 8-byte Reload
	addq	%rcx, %rax
	movq	%rax, -8(%rbp)
.LBB0_6:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	_ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print, .Lfunc_end0-_ZN11ArduinoJson9Internals12QuotedString7printToEPKcR5Print
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _ZL11printCharTocR5Print
	.type	_ZL11printCharTocR5Print,@function
_ZL11printCharTocR5Print:               # @_ZL11printCharTocR5Print
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movq	%rsi, -16(%rbp)
	movsbl	-1(%rbp), %edi
	callq	_ZL14getSpecialCharc
	movb	%al, -17(%rbp)
	cmpb	$0, -17(%rbp)
	je	.LBB1_2
# %bb.1:
	movq	-16(%rbp), %rdi
	movq	(%rdi), %rax
	movl	$92, %esi
	callq	*16(%rax)
	movq	%rax, -40(%rbp)                 # 8-byte Spill
	movq	-16(%rbp), %rdi
	movb	-17(%rbp), %cl
	movq	(%rdi), %rax
	movzbl	%cl, %esi
	callq	*16(%rax)
	movq	%rax, %rcx
	movq	-40(%rbp), %rax                 # 8-byte Reload
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)                 # 8-byte Spill
	jmp	.LBB1_3
.LBB1_2:
	movq	-16(%rbp), %rdi
	movb	-1(%rbp), %cl
	movq	(%rdi), %rax
	movzbl	%cl, %esi
	callq	*16(%rax)
	movq	%rax, -32(%rbp)                 # 8-byte Spill
.LBB1_3:
	movq	-32(%rbp), %rax                 # 8-byte Reload
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	_ZL11printCharTocR5Print, .Lfunc_end1-_ZL11printCharTocR5Print
	.cfi_endproc
                                        # -- End function
	.globl	_ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_ # -- Begin function _ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_
	.p2align	4, 0x90
	.type	_ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_,@function
_ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_: # @_ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_
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
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-16(%rbp), %rax
	movb	(%rax), %al
	movb	%al, -50(%rbp)
	movb	-50(%rbp), %al
	movb	%al, -51(%rbp)
	movsbl	-50(%rbp), %edi
	callq	_ZL7isQuotec
	testb	$1, %al
	jne	.LBB2_2
# %bb.1:
	jmp	.LBB2_13
.LBB2_2:
	jmp	.LBB2_3
.LBB2_3:                                # =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -40(%rbp)
	movb	(%rax), %al
	movb	%al, -49(%rbp)
	movsbl	-49(%rbp), %eax
	cmpl	$0, %eax
	jne	.LBB2_5
# %bb.4:
	jmp	.LBB2_14
.LBB2_5:                                #   in Loop: Header=BB2_3 Depth=1
	movsbl	-49(%rbp), %eax
	movsbl	-51(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB2_7
# %bb.6:
	jmp	.LBB2_12
.LBB2_7:                                #   in Loop: Header=BB2_3 Depth=1
	movsbl	-49(%rbp), %eax
	cmpl	$92, %eax
	jne	.LBB2_11
# %bb.8:                                #   in Loop: Header=BB2_3 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, -40(%rbp)
	movsbl	(%rax), %edi
	callq	_ZL12unescapeCharc
	movb	%al, -49(%rbp)
	movsbl	-49(%rbp), %eax
	cmpl	$0, %eax
	jne	.LBB2_10
# %bb.9:
	jmp	.LBB2_15
.LBB2_10:                               #   in Loop: Header=BB2_3 Depth=1
	jmp	.LBB2_11
.LBB2_11:                               #   in Loop: Header=BB2_3 Depth=1
	movb	-49(%rbp), %cl
	movq	-48(%rbp), %rax
	movq	%rax, %rdx
	addq	$1, %rdx
	movq	%rdx, -48(%rbp)
	movb	%cl, (%rax)
	jmp	.LBB2_3
.LBB2_12:
	movq	-48(%rbp), %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB2_16
.LBB2_13:
	jmp	.LBB2_14
.LBB2_14:
	jmp	.LBB2_15
.LBB2_15:
	movq	$0, -8(%rbp)
.LBB2_16:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	_ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_, .Lfunc_end2-_ZN11ArduinoJson9Internals12QuotedString11extractFromEPcPS2_
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _ZL7isQuotec
	.type	_ZL7isQuotec,@function
_ZL7isQuotec:                           # @_ZL7isQuotec
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movsbl	-1(%rbp), %ecx
	movb	$1, %al
	cmpl	$34, %ecx
	movb	%al, -2(%rbp)                   # 1-byte Spill
	je	.LBB3_2
# %bb.1:
	movsbl	-1(%rbp), %eax
	cmpl	$39, %eax
	sete	%al
	movb	%al, -2(%rbp)                   # 1-byte Spill
.LBB3_2:
	movb	-2(%rbp), %al                   # 1-byte Reload
	andb	$1, %al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	_ZL7isQuotec, .Lfunc_end3-_ZL7isQuotec
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _ZL12unescapeCharc
	.type	_ZL12unescapeCharc,@function
_ZL12unescapeCharc:                     # @_ZL12unescapeCharc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%dil, %al
	movb	%al, -2(%rbp)
	leaq	_ZL12specialChars(%rip), %rax
	addq	$4, %rax
	movq	%rax, -16(%rbp)
.LBB4_1:                                # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	jne	.LBB4_3
# %bb.2:
	movb	-2(%rbp), %al
	movb	%al, -1(%rbp)
	jmp	.LBB4_6
.LBB4_3:                                #   in Loop: Header=BB4_1 Depth=1
	movq	-16(%rbp), %rax
	movsbl	(%rax), %eax
	movsbl	-2(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB4_5
# %bb.4:
	movq	-16(%rbp), %rax
	movb	1(%rax), %al
	movb	%al, -1(%rbp)
	jmp	.LBB4_6
.LBB4_5:                                #   in Loop: Header=BB4_1 Depth=1
	movq	-16(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB4_1
.LBB4_6:
	movsbl	-1(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	_ZL12unescapeCharc, .Lfunc_end4-_ZL12unescapeCharc
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function _ZL14getSpecialCharc
	.type	_ZL14getSpecialCharc,@function
_ZL14getSpecialCharc:                   # @_ZL14getSpecialCharc
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	leaq	_ZL12specialChars(%rip), %rax
	movq	%rax, -16(%rbp)
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rcx
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpb	$0, (%rcx)
	movb	%al, -17(%rbp)                  # 1-byte Spill
	je	.LBB5_3
# %bb.2:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-16(%rbp), %rax
	movsbl	1(%rax), %eax
	movsbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	setne	%al
	movb	%al, -17(%rbp)                  # 1-byte Spill
.LBB5_3:                                #   in Loop: Header=BB5_1 Depth=1
	movb	-17(%rbp), %al                  # 1-byte Reload
	testb	$1, %al
	jne	.LBB5_4
	jmp	.LBB5_5
.LBB5_4:                                #   in Loop: Header=BB5_1 Depth=1
	movq	-16(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB5_1
.LBB5_5:
	movq	-16(%rbp), %rax
	movsbl	(%rax), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	_ZL14getSpecialCharc, .Lfunc_end5-_ZL14getSpecialCharc
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"null"
	.size	.L.str, 5

	.type	_ZL12specialChars,@object       # @_ZL12specialChars
	.section	.rodata,"a",@progbits
_ZL12specialChars:
	.asciz	"\"\"\\\\b\bf\fn\nr\rt\t"
	.size	_ZL12specialChars, 15

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 08d094a0e457360ad8b94b017d2dc277e697ca76)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZN5Print5printEPKc
	.addrsig_sym _ZL11printCharTocR5Print
	.addrsig_sym _ZL7isQuotec
	.addrsig_sym _ZL12unescapeCharc
	.addrsig_sym _ZL14getSpecialCharc
	.addrsig_sym _ZL12specialChars
