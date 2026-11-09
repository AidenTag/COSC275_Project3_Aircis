	.Code
read_filename_to_buffer:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	sw	a2, -24(s0) 
	lw	a0, -16(s0) 
	bnez	a0, inode_LBB0_2 
	j	inode_LBB0_1 
inode_LBB0_1:
	li	a0, -4 
	sw	a0, -12(s0) 
	j	inode_LBB0_12 
inode_LBB0_2:
	lw	a0, -20(s0) 
	beqz	a0, inode_LBB0_4 
	j	inode_LBB0_3 
inode_LBB0_3:
	lw	a0, -20(s0) 
	li	a1, 61 
	sw	a1, -40(s0) # 4-byte Folded Spill 
	call	string_length 
	lw	a1, -40(s0) # 4-byte Folded Reload 
	blt	a0, a1, inode_LBB0_5 
	j	inode_LBB0_4 
inode_LBB0_4:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	inode_LBB0_12 
inode_LBB0_5:
	lw	a0, -20(s0) 
	call	search_directory 
	sw	a0, -28(s0) 
	lw	a0, -28(s0) 
	bnez	a0, inode_LBB0_7 
	j	inode_LBB0_6 
inode_LBB0_6:
	li	a0, -2 
	sw	a0, -12(s0) 
	j	inode_LBB0_12 
inode_LBB0_7:
	lui	a0, 1 
	call	allocate 
	sw	a0, -32(s0) 
	lw	a0, -32(s0) 
	bnez	a0, inode_LBB0_9 
	j	inode_LBB0_8 
inode_LBB0_8:
	li	a0, -5 
	sw	a0, -12(s0) 
	j	inode_LBB0_12 
inode_LBB0_9:
	lw	a0, -28(s0) 
	lw	a1, -32(s0) 
	call	bd_read_block 
	bgez	a0, inode_LBB0_11 
	j	inode_LBB0_10 
inode_LBB0_10:
	lw	a0, -32(s0) 
	call	deallocate 
	li	a0, -5 
	sw	a0, -12(s0) 
	j	inode_LBB0_12 
inode_LBB0_11:
	lw	a0, -16(s0) 
	lw	a1, -32(s0) 
	lw	a2, -24(s0) 
	call	read_inode_to_buffer 
	sw	a0, -36(s0) 
	lw	a0, -32(s0) 
	call	deallocate 
	li	a0, 0 
	sw	a0, -32(s0) 
	lw	a0, -36(s0) 
	sw	a0, -12(s0) 
	j	inode_LBB0_12 
inode_LBB0_12:
	lw	a0, -12(s0) 
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
inode_Lfunc_end0:
	#	-- End function 
read_inode_to_buffer:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	sw	a2, -24(s0) 
	lw	a0, -16(s0) 
	bnez	a0, inode_LBB1_2 
	j	inode_LBB1_1 
inode_LBB1_1:
	li	a0, -4 
	sw	a0, -12(s0) 
	j	inode_LBB1_13 
inode_LBB1_2:
	lw	a0, -20(s0) 
	bnez	a0, inode_LBB1_4 
	j	inode_LBB1_3 
inode_LBB1_3:
	li	a0, -5 
	sw	a0, -12(s0) 
	j	inode_LBB1_13 
inode_LBB1_4:
	lw	a0, -20(s0) 
	lw	a1, 0(a0) 
	lw	a0, -24(s0) 
	bgeu	a0, a1, inode_LBB1_6 
	j	inode_LBB1_5 
inode_LBB1_5:
	li	a0, -4 
	sw	a0, -12(s0) 
	j	inode_LBB1_13 
inode_LBB1_6:
	lw	a0, -20(s0) 
	lw	a0, 0(a0) 
	sw	a0, -28(s0) 
	li	a0, 0 
	sw	a0, -32(s0) 
	j	inode_LBB1_7 
inode_LBB1_7:
	lw	a1, -28(s0) 
	li	a0, 0 
	bge	a0, a1, inode_LBB1_12 
	j	inode_LBB1_8 
inode_LBB1_8:
	lw	a1, -28(s0) 
	lui	a0, 1 
	addi	a0, a0, -1 
	blt	a0, a1, inode_LBB1_10 
	j	inode_LBB1_9 
inode_LBB1_9:
	lw	a0, -28(s0) 
	sw	a0, -40(s0) # 4-byte Folded Spill 
	j	inode_LBB1_11 
inode_LBB1_10:
	lui	a0, 1 
	sw	a0, -40(s0) # 4-byte Folded Spill 
	j	inode_LBB1_11 
inode_LBB1_11:
	lw	a0, -40(s0) # 4-byte Folded Reload 
	sw	a0, -36(s0) 
	lw	a0, -20(s0) 
	lw	a1, -32(s0) 
	slli	a1, a1, 2 
	add	a0, a0, a1 
	lw	a0, 32(a0) 
	lw	a1, -16(s0) 
	call	bd_read_block 
	lw	a1, -36(s0) 
	lw	a0, -16(s0) 
	add	a0, a0, a1 
	sw	a0, -16(s0) 
	lw	a1, -36(s0) 
	lw	a0, -28(s0) 
	sub	a0, a0, a1 
	sw	a0, -28(s0) 
	lw	a0, -32(s0) 
	addi	a0, a0, 1 
	sw	a0, -32(s0) 
	j	inode_LBB1_7 
inode_LBB1_12:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	inode_LBB1_13 
inode_LBB1_13:
	lw	a0, -12(s0) 
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
inode_Lfunc_end1:
	#	-- End function 
