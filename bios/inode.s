	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"inode.c"
	.globl	read_file                       # -- Begin function read_file
	.p2align	2
	.type	read_file,@function
read_file:                              # @read_file
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -16(s0)
	lw	a0, 0(a0)
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	inode_LBB0_1
inode_LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -20(s0)
	li	a0, 0
	bge	a0, a1, inode_LBB0_6
	j	inode_LBB0_2
inode_LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
	lw	a1, -20(s0)
	lui	a0, 1
	addi	a0, a0, -1
	blt	a0, a1, inode_LBB0_4
	j	inode_LBB0_3
inode_LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
	lw	a0, -20(s0)
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	j	inode_LBB0_5
inode_LBB0_4:                                #   in Loop: Header=BB0_1 Depth=1
	lui	a0, 1
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	j	inode_LBB0_5
inode_LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	sw	a0, -28(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 32(a0)
	lw	a1, -12(s0)
	call	bd_read_block
	lw	a1, -28(s0)
	lw	a0, -12(s0)
	add	a0, a0, a1
	sw	a0, -12(s0)
	lw	a1, -28(s0)
	lw	a0, -20(s0)
	sub	a0, a0, a1
	sw	a0, -20(s0)
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	inode_LBB0_1
inode_LBB0_6:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
inode_Lfunc_end0:
	.size	read_file, inode_Lfunc_end0-read_file
                                        # -- End function
	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym bd_read_block
