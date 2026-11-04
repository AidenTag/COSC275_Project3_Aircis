	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"directory.c"
	.globl	string_compare                  # -- Begin function string_compare
	.p2align	2
	.type	string_compare,@function
string_compare:                         # @string_compare
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	lw	a0, -16(s0)
	bnez	a0, directory_LBB0_3
	j	directory_LBB0_1
directory_LBB0_1:
	lw	a0, -20(s0)
	bnez	a0, directory_LBB0_3
	j	directory_LBB0_2
directory_LBB0_2:
	li	a0, 0
	sw	a0, -12(s0)
	j	directory_LBB0_16
directory_LBB0_3:
	lw	a0, -16(s0)
	bnez	a0, directory_LBB0_5
	j	directory_LBB0_4
directory_LBB0_4:
	li	a0, -1
	sw	a0, -12(s0)
	j	directory_LBB0_16
directory_LBB0_5:
	lw	a0, -20(s0)
	bnez	a0, directory_LBB0_7
	j	directory_LBB0_6
directory_LBB0_6:
	li	a0, 1
	sw	a0, -12(s0)
	j	directory_LBB0_16
directory_LBB0_7:
	li	a0, 0
	sw	a0, -28(s0)
	j	directory_LBB0_8
directory_LBB0_8:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bge	a0, a1, directory_LBB0_15
	j	directory_LBB0_9
directory_LBB0_9:                                #   in Loop: Header=BB0_8 Depth=1
	lw	a0, -16(s0)
	addi	a1, a0, 1
	sw	a1, -16(s0)
	lbu	a0, 0(a0)
	sb	a0, -29(s0)
	lw	a0, -20(s0)
	addi	a1, a0, 1
	sw	a1, -20(s0)
	lbu	a0, 0(a0)
	sb	a0, -30(s0)
	lbu	a0, -29(s0)
	lbu	a1, -30(s0)
	sub	a0, a0, a1
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	beqz	a0, directory_LBB0_11
	j	directory_LBB0_10
directory_LBB0_10:
	lw	a0, -36(s0)
	sw	a0, -12(s0)
	j	directory_LBB0_16
directory_LBB0_11:                               #   in Loop: Header=BB0_8 Depth=1
	lbu	a0, -29(s0)
	bnez	a0, directory_LBB0_13
	j	directory_LBB0_12
directory_LBB0_12:
	li	a0, 0
	sw	a0, -12(s0)
	j	directory_LBB0_16
directory_LBB0_13:                               #   in Loop: Header=BB0_8 Depth=1
	j	directory_LBB0_14
directory_LBB0_14:                               #   in Loop: Header=BB0_8 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	directory_LBB0_8
directory_LBB0_15:
	li	a0, 0
	sw	a0, -12(s0)
	j	directory_LBB0_16
directory_LBB0_16:
	lw	a0, -12(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
directory_Lfunc_end0:
	.size	string_compare, directory_Lfunc_end0-string_compare
                                        # -- End function
	.globl	find_entry                      # -- Begin function find_entry
	.p2align	2
	.type	find_entry,@function
find_entry:                             # @find_entry
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	directory_LBB1_1
directory_LBB1_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -28(s0)
	lw	a1, -20(s0)
	bge	a0, a1, directory_LBB1_7
	j	directory_LBB1_2
directory_LBB1_2:                                #   in Loop: Header=BB1_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -28(s0)
	slli	a1, a1, 6
	add	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a0, 0(a0)
	beqz	a0, directory_LBB1_5
	j	directory_LBB1_3
directory_LBB1_3:                                #   in Loop: Header=BB1_1 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 4
	lw	a1, -24(s0)
	li	a2, 60
	call	string_compare
	bnez	a0, directory_LBB1_5
	j	directory_LBB1_4
directory_LBB1_4:
	lw	a0, -32(s0)
	sw	a0, -12(s0)
	j	directory_LBB1_8
directory_LBB1_5:                                #   in Loop: Header=BB1_1 Depth=1
	j	directory_LBB1_6
directory_LBB1_6:                                #   in Loop: Header=BB1_1 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	directory_LBB1_1
directory_LBB1_7:
	li	a0, 0
	sw	a0, -12(s0)
	j	directory_LBB1_8
directory_LBB1_8:
	lw	a0, -12(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
directory_Lfunc_end1:
	.size	find_entry, directory_Lfunc_end1-find_entry
                                        # -- End function
	.globl	search_directory                # -- Begin function search_directory
	.p2align	2
	.type	search_directory,@function
search_directory:                       # @search_directory
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	call	find_entry
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, directory_LBB2_2
	j	directory_LBB2_1
directory_LBB2_1:
	li	a0, 0
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	j	directory_LBB2_3
directory_LBB2_2:
	lw	a0, -24(s0)
	lw	a0, 0(a0)
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	j	directory_LBB2_3
directory_LBB2_3:
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
directory_Lfunc_end2:
	.size	search_directory, directory_Lfunc_end2-search_directory
                                        # -- End function
	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym string_compare
	.addrsig_sym find_entry
