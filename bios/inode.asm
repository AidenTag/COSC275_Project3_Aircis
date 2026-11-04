	.Code
read_file:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	lw	a0, -16(s0) 
	lw	a0, 0(a0) 
	sw	a0, -20(s0) 
	li	a0, 0 
	sw	a0, -24(s0) 
	j	inode_LBB0_1 
inode_LBB0_1:
	lw	a1, -20(s0) 
	li	a0, 0 
	bge	a0, a1, inode_LBB0_6 
	j	inode_LBB0_2 
inode_LBB0_2:
	lw	a1, -20(s0) 
	lui	a0, 1 
	addi	a0, a0, -1 
	blt	a0, a1, inode_LBB0_4 
	j	inode_LBB0_3 
inode_LBB0_3:
	lw	a0, -20(s0) 
	sw	a0, -32(s0) # 4-byte Folded Spill 
	j	inode_LBB0_5 
inode_LBB0_4:
	lui	a0, 1 
	sw	a0, -32(s0) # 4-byte Folded Spill 
	j	inode_LBB0_5 
inode_LBB0_5:
	lw	a0, -32(s0) # 4-byte Folded Reload 
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
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
inode_Lfunc_end0:
	#	-- End function 
