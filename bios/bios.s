	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"bios.c"
	.globl	block_allocate                  # -- Begin function block_allocate
	.p2align	2
	.type	block_allocate,@function
block_allocate:                         # @block_allocate
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	srli	a0, a0, 12
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	slli	a0, a0, 12
	lw	a1, -16(s0)
	bgeu	a0, a1, bios_LBB0_2
	j	bios_LBB0_1
bios_LBB0_1:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	bios_LBB0_2
bios_LBB0_2:
	lw	a0, -20(s0)
	slli	a0, a0, 12
	sw	a0, -24(s0)
	call	get_statics
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	a0, 24(a0)
	sw	a0, -32(s0)
	#APP
	mv	a0, sp
	#NO_APP
	sw	a0, -36(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	lw	a0, -36(s0)
	bgeu	a0, a1, bios_LBB0_4
	j	bios_LBB0_3
bios_LBB0_3:
	li	a0, 0
	sw	a0, -12(s0)
	j	bios_LBB0_5
bios_LBB0_4:
	lw	a2, -24(s0)
	lw	a1, -28(s0)
	lw	a0, 24(a1)
	add	a0, a0, a2
	sw	a0, 24(a1)
	lw	a0, -32(s0)
	sw	a0, -12(s0)
	j	bios_LBB0_5
bios_LBB0_5:
	lw	a0, -12(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
bios_Lfunc_end0:
	.size	block_allocate, bios_Lfunc_end0-block_allocate
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	li	a0, 0
	sw	a0, -12(s0)
bios_Lpcrel_hi0:
	auipc	a0, %pcrel_hi(bios_L.str)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi0)
	call	print
bios_Lpcrel_hi1:
	auipc	a0, %pcrel_hi(bios_L.str.1)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi1)
	call	print
	call	show_now
	call	get_statics
	sw	a0, -16(s0)
bios_Lpcrel_hi2:
	auipc	a0, %pcrel_hi(controller_device_code)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi2)
	lw	a0, 0(a0)
	li	a1, 1
	call	find_device
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	bnez	a0, bios_LBB1_2
	j	bios_LBB1_1
bios_LBB1_1:
bios_Lpcrel_hi3:
	auipc	a0, %pcrel_hi(bios_L.str.2)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi3)
	call	print
bios_Lpcrel_hi4:
	auipc	a0, %pcrel_hi(controller_search_failure_code)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi4)
	lw	a0, 0(a0)
	call	abort
bios_LBB1_2:
	lw	a0, -20(s0)
	lw	a0, 8(a0)
	addi	a0, a0, -12
	lw	a1, -16(s0)
	sw	a0, 12(a1)
bios_Lpcrel_hi5:
	auipc	a0, %pcrel_hi(block_device_code)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi5)
	lw	a0, 0(a0)
	li	a1, 1
	call	find_device
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, bios_LBB1_4
	j	bios_LBB1_3
bios_LBB1_3:
bios_Lpcrel_hi6:
	auipc	a0, %pcrel_hi(bios_L.str.3)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi6)
	call	print
bios_Lpcrel_hi7:
	auipc	a0, %pcrel_hi(block_device_search_failure_code)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi7)
	lw	a0, 0(a0)
	call	abort
bios_LBB1_4:
	lw	a0, -24(s0)
	lw	a0, 4(a0)
	lw	a1, -16(s0)
	sw	a0, 16(a1)
	lw	a1, -16(s0)
	lw	a2, 8(a1)
	lw	a0, 4(a2)
	lw	a2, 8(a2)
	add	a0, a0, a2
	srli	a0, a0, 1
	sw	a0, 20(a1)
	lw	a1, -16(s0)
	lw	a0, 20(a1)
	sw	a0, 24(a1)
bios_Lpcrel_hi8:
	auipc	a0, %pcrel_hi(bios_L.str.4)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi8)
	call	print
	lui	a0, 1
	call	block_allocate
	sw	a0, -28(s0)
	lw	a1, -28(s0)
	li	a0, 0
	sw	a0, -56(s0)                     # 4-byte Folded Spill
	call	bd_read_block
	lw	a0, -56(s0)                     # 4-byte Folded Reload
	lw	a1, -28(s0)
	sw	a1, -32(s0)
	lw	a1, -32(s0)
	lw	a1, 12(a1)
	sw	a1, -36(s0)
	sw	a0, -32(s0)
	lw	a0, -36(s0)
	lw	a1, -28(s0)
	call	bd_read_block
	lw	a0, -28(s0)
	sw	a0, -40(s0)
	lw	a0, -40(s0)
	lw	a0, 0(a0)
	call	block_allocate
	sw	a0, -44(s0)
	lw	a0, -44(s0)
	bnez	a0, bios_LBB1_6
	j	bios_LBB1_5
bios_LBB1_5:
bios_Lpcrel_hi9:
	auipc	a0, %pcrel_hi(bios_L.str.5)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi9)
	call	print
bios_Lpcrel_hi10:
	auipc	a0, %pcrel_hi(allocation_failure_code)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi10)
	lw	a0, 0(a0)
	call	abort
bios_LBB1_6:
	lw	a0, -44(s0)
	lw	a1, -40(s0)
	call	read_file
	lw	a0, -40(s0)
	lw	a0, 0(a0)
	srli	a0, a0, 6
	sw	a0, -48(s0)
	lw	a0, -44(s0)
	lw	a1, -48(s0)
bios_Lpcrel_hi11:
	auipc	a2, %pcrel_hi(bios_L.str.6)
	addi	a2, a2, %pcrel_lo(bios_Lpcrel_hi11)
	call	search_directory
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	bnez	a0, bios_LBB1_8
	j	bios_LBB1_7
bios_LBB1_7:
bios_Lpcrel_hi12:
	auipc	a0, %pcrel_hi(bios_L.str.7)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi12)
	call	print
bios_Lpcrel_hi13:
	auipc	a0, %pcrel_hi(kernel_file_failure_code)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi13)
	lw	a0, 0(a0)
	call	abort
bios_LBB1_8:
bios_Lpcrel_hi14:
	auipc	a0, %pcrel_hi(bios_L.str.8)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi14)
	call	print
	lw	a0, -52(s0)
	lw	a1, -28(s0)
	call	bd_read_block
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	lw	a0, 4(a0)
	lw	a1, -40(s0)
	call	read_file
bios_Lpcrel_hi15:
	auipc	a0, %pcrel_hi(bios_L.str.9)
	addi	a0, a0, %pcrel_lo(bios_Lpcrel_hi15)
	call	print
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	lw	a0, 4(a0)
	call	jump_to_kernel
	li	a0, -1
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
bios_Lfunc_end1:
	.size	main, bios_Lfunc_end1-main
                                        # -- End function
	.type	bios_L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
bios_L.str:
	.asciz	"Fivish BIOS+ v.2026-10-24\n"
	.size	bios_L.str, 27

	.type	bios_L.str.1,@object                # @.str.1
bios_L.str.1:
	.asciz	"(c) Scott F. Kaplan | sfkaplan@amherst.edu\n"
	.size	bios_L.str.1, 44

	.type	bios_L.str.2,@object                # @.str.2
bios_L.str.2:
	.asciz	"ERROR: Bus controller not found"
	.size	bios_L.str.2, 32

	.type	bios_L.str.3,@object                # @.str.3
bios_L.str.3:
	.asciz	"ERROR: Block device not found\n"
	.size	bios_L.str.3, 31

	.type	bios_L.str.4,@object                # @.str.4
bios_L.str.4:
	.asciz	"  Kernel: Finding..."
	.size	bios_L.str.4, 21

	.type	bios_L.str.5,@object                # @.str.5
bios_L.str.5:
	.asciz	"ERROR: Failed to allocate memory for directory\n"
	.size	bios_L.str.5, 48

	.type	bios_L.str.6,@object                # @.str.6
bios_L.str.6:
	.asciz	"kernel.vmx"
	.size	bios_L.str.6, 11

	.type	bios_L.str.7,@object                # @.str.7
bios_L.str.7:
	.asciz	"ERROR: Failed to find kernel.vmx\n"
	.size	bios_L.str.7, 34

	.type	bios_L.str.8,@object                # @.str.8
bios_L.str.8:
	.asciz	"Loading..."
	.size	bios_L.str.8, 11

	.type	bios_L.str.9,@object                # @.str.9
bios_L.str.9:
	.asciz	"Vectoring...\n\n"
	.size	bios_L.str.9, 15

	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym block_allocate
	.addrsig_sym get_statics
	.addrsig_sym print
	.addrsig_sym show_now
	.addrsig_sym find_device
	.addrsig_sym abort
	.addrsig_sym bd_read_block
	.addrsig_sym read_file
	.addrsig_sym search_directory
	.addrsig_sym jump_to_kernel
	.addrsig_sym controller_device_code
	.addrsig_sym controller_search_failure_code
	.addrsig_sym block_device_code
	.addrsig_sym block_device_search_failure_code
	.addrsig_sym allocation_failure_code
	.addrsig_sym kernel_file_failure_code
