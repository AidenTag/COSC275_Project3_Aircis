	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"bd_driver.c"
	.globl	bd_read_block                   # -- Begin function bd_read_block
	.p2align	2
	.type	bd_read_block,@function
bd_read_block:                          # @bd_read_block
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	call	get_statics
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a0, 16(a0)
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a0, 12(a0)
	sw	a0, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	lui	a2, 1
	add	a1, a1, a2
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	add	a0, a0, a2
	li	a1, -1
	sw	a1, 4(a0)
	lw	a0, -24(s0)
	add	a0, a0, a2
	lw	a0, 4(a0)
	bne	a0, a1, bd_driver_LBB0_2
	j	bd_driver_LBB0_1
bd_driver_LBB0_1:
bd_driver_Lpcrel_hi0:
	auipc	a0, %pcrel_hi(bd_driver_L.str)
	addi	a0, a0, %pcrel_lo(bd_driver_Lpcrel_hi0)
	call	print
bd_driver_Lpcrel_hi1:
	auipc	a0, %pcrel_hi(block_device_access_failure_code)
	addi	a0, a0, %pcrel_lo(bd_driver_Lpcrel_hi1)
	lw	a0, 0(a0)
	call	abort
bd_driver_LBB0_2:
	lw	a0, -24(s0)
	lui	a1, 1
	add	a0, a0, a1
	lw	a0, 4(a0)
	li	a1, -2
	bne	a0, a1, bd_driver_LBB0_4
	j	bd_driver_LBB0_3
bd_driver_LBB0_3:
bd_driver_Lpcrel_hi2:
	auipc	a0, %pcrel_hi(bd_driver_L.str.1)
	addi	a0, a0, %pcrel_lo(bd_driver_Lpcrel_hi2)
	call	print
bd_driver_Lpcrel_hi3:
	auipc	a0, %pcrel_hi(block_device_access_failure_code)
	addi	a0, a0, %pcrel_lo(bd_driver_Lpcrel_hi3)
	lw	a0, 0(a0)
	call	abort
bd_driver_LBB0_4:
	j	bd_driver_LBB0_5
bd_driver_LBB0_5:
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a1, -28(s0)
	sw	a0, 4(a1)
	lw	a1, -28(s0)
	lui	a0, 1
	sw	a0, 8(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
bd_driver_Lfunc_end0:
	.size	bd_read_block, bd_driver_Lfunc_end0-bd_read_block
                                        # -- End function
	.type	bd_driver_L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
bd_driver_L.str:
	.asciz	"ERROR: Attempt to read invalid block number\n"
	.size	bd_driver_L.str, 45

	.type	bd_driver_L.str.1,@object                # @.str.1
bd_driver_L.str.1:
	.asciz	"ERROR: Failure in reading block device\n"
	.size	bd_driver_L.str.1, 40

	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym get_statics
	.addrsig_sym print
	.addrsig_sym abort
	.addrsig_sym block_device_access_failure_code
