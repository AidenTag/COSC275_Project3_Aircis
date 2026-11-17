	.Code
is_free:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	lw	a0, -16(s0) 
	srli	a0, a0, 3 
	sw	a0, -20(s0) 
	lw	a0, -16(s0) 
	andi	a0, a0, 7 
	sw	a0, -24(s0) 
	lw	a0, -12(s0) 
	lw	a1, -20(s0) 
	add	a0, a0, a1 
	lbu	a0, 0(a0) 
	lw	a1, -24(s0) 
	srl	a0, a0, a1 
	andi	a0, a0, 1 
	seqz	a0, a0 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bitmap_Lfunc_end0:
	#	-- End function 
mark_allocated:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	lw	a0, -16(s0) 
	srli	a0, a0, 3 
	sw	a0, -20(s0) 
	lw	a0, -16(s0) 
	andi	a0, a0, 7 
	sw	a0, -24(s0) 
	lw	a1, -24(s0) 
	li	a0, 1 
	sll	a2, a0, a1 
	lw	a0, -12(s0) 
	lw	a1, -20(s0) 
	add	a1, a0, a1 
	lbu	a0, 0(a1) 
	or	a0, a0, a2 
	sb	a0, 0(a1) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bitmap_Lfunc_end1:
	#	-- End function 
mark_free:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	lw	a0, -16(s0) 
	srli	a0, a0, 3 
	sw	a0, -20(s0) 
	lw	a0, -16(s0) 
	andi	a0, a0, 7 
	sw	a0, -24(s0) 
	lw	a1, -24(s0) 
	li	a0, 1 
	sll	a0, a0, a1 
	not	a2, a0 
	lw	a0, -12(s0) 
	lw	a1, -20(s0) 
	add	a1, a0, a1 
	lbu	a0, 0(a1) 
	and	a0, a0, a2 
	sb	a0, 0(a1) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bitmap_Lfunc_end2:
	#	-- End function 
alloc_block:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	lw	a1, -16(s0) 
	lw	a0, 16(a1) 
	addi	a0, a0, 1 
	lw	a1, 4(a1) 
	remu	a0, a0, a1 
	sw	a0, -24(s0) 
	j	bitmap_LBB3_1 
bitmap_LBB3_1:
	lw	a0, -24(s0) 
	lw	a1, -16(s0) 
	lw	a1, 16(a1) 
	beq	a0, a1, bitmap_LBB3_5 
	j	bitmap_LBB3_2 
bitmap_LBB3_2:
	lw	a0, -20(s0) 
	lw	a1, -24(s0) 
	call	is_free 
	beqz	a0, bitmap_LBB3_4 
	j	bitmap_LBB3_3 
bitmap_LBB3_3:
	lw	a0, -20(s0) 
	lw	a1, -24(s0) 
	call	mark_allocated 
	lw	a0, -24(s0) 
	lw	a1, -16(s0) 
	sw	a0, 16(a1) 
	lw	a0, -24(s0) 
	sw	a0, -12(s0) 
	j	bitmap_LBB3_6 
bitmap_LBB3_4:
	lw	a0, -24(s0) 
	addi	a0, a0, 1 
	lw	a1, -16(s0) 
	lw	a1, 4(a1) 
	remu	a0, a0, a1 
	sw	a0, -24(s0) 
	j	bitmap_LBB3_1 
bitmap_LBB3_5:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	bitmap_LBB3_6 
bitmap_LBB3_6:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bitmap_Lfunc_end3:
	#	-- End function 
