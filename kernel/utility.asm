	.Code
int_to_hex:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	li	a0, 28 
	sw	a0, -20(s0) 
	j	utility_LBB0_1 
utility_LBB0_1:
	lw	a0, -20(s0) 
	bltz	a0, utility_LBB0_4 
	j	utility_LBB0_2 
utility_LBB0_2:
	lw	a0, -12(s0) 
	lw	a1, -20(s0) 
	srl	a0, a0, a1 
	andi	a0, a0, 15 
	sw	a0, -24(s0) 
	lw	a1, -24(s0) 
utility_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(int_to_hex.hex_digits))
	addi	a0, a0, %lo(%larel(int_to_hex.hex_digits,utility_Lpcrel_hi0))
	add	a0, a0, a1 
	lbu	a0, 0(a0) 
	lw	a1, -16(s0) 
	addi	a2, a1, 1 
	sw	a2, -16(s0) 
	sb	a0, 0(a1) 
	j	utility_LBB0_3 
utility_LBB0_3:
	lw	a0, -20(s0) 
	addi	a0, a0, -4 
	sw	a0, -20(s0) 
	j	utility_LBB0_1 
utility_LBB0_4:
	lw	a1, -16(s0) 
	li	a0, 0 
	sb	a0, 0(a1) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end0:
	#	-- End function 
int_to_dec:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	lw	a0, -12(s0) 
	bnez	a0, utility_LBB1_2 
	j	utility_LBB1_1 
utility_LBB1_1:
	lw	a1, -16(s0) 
	li	a0, 48 
	sb	a0, 0(a1) 
	lw	a1, -16(s0) 
	li	a0, 0 
	sb	a0, 1(a1) 
	j	utility_LBB1_9 
utility_LBB1_2:
	li	a0, 0 
	sw	a0, -32(s0) 
	j	utility_LBB1_3 
utility_LBB1_3:
	lw	a0, -12(s0) 
	beqz	a0, utility_LBB1_5 
	j	utility_LBB1_4 
utility_LBB1_4:
	lw	a0, -12(s0) 
	lui	a1, 838861 
	addi	a1, a1, -819 
	mulhu	a2, a0, a1 
	srli	a2, a2, 3 
	li	a3, 10 
	mul	a2, a2, a3 
	sub	a0, a0, a2 
	sw	a0, -36(s0) 
	lw	a0, -12(s0) 
	mulhu	a0, a0, a1 
	srli	a0, a0, 3 
	sw	a0, -12(s0) 
	lw	a0, -36(s0) 
	addi	a0, a0, 48 
	lw	a2, -32(s0) 
	addi	a1, a2, 1 
	sw	a1, -32(s0) 
	addi	a1, s0, -28 
	add	a1, a1, a2 
	sb	a0, 0(a1) 
	j	utility_LBB1_3 
utility_LBB1_5:
	lw	a0, -32(s0) 
	addi	a0, a0, -1 
	sw	a0, -32(s0) 
	j	utility_LBB1_6 
utility_LBB1_6:
	lw	a0, -32(s0) 
	bltz	a0, utility_LBB1_8 
	j	utility_LBB1_7 
utility_LBB1_7:
	lw	a1, -32(s0) 
	addi	a0, a1, -1 
	sw	a0, -32(s0) 
	addi	a0, s0, -28 
	add	a0, a0, a1 
	lbu	a0, 0(a0) 
	lw	a1, -16(s0) 
	addi	a2, a1, 1 
	sw	a2, -16(s0) 
	sb	a0, 0(a1) 
	j	utility_LBB1_6 
utility_LBB1_8:
	lw	a1, -16(s0) 
	li	a0, 0 
	sb	a0, 0(a1) 
	j	utility_LBB1_9 
utility_LBB1_9:
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
utility_Lfunc_end1:
	#	-- End function 
print_dec:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	addi	a1, s0, -28 
	sw	a1, -32(s0) # 4-byte Folded Spill 
	call	int_to_dec 
	lw	a0, -32(s0) # 4-byte Folded Reload 
	call	print 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end2:
	#	-- End function 
print_hex:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	addi	a1, s0, -28 
	sw	a1, -32(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -32(s0) # 4-byte Folded Reload 
	call	print 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end3:
	#	-- End function 
string_length:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	lw	a0, -16(s0) 
	bnez	a0, utility_LBB4_2 
	j	utility_LBB4_1 
utility_LBB4_1:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	utility_LBB4_8 
utility_LBB4_2:
	li	a0, 0 
	sw	a0, -24(s0) 
	j	utility_LBB4_3 
utility_LBB4_3:
	lw	a0, -24(s0) 
	lw	a1, -20(s0) 
	li	a2, 0 
	sw	a2, -28(s0) # 4-byte Folded Spill 
	bge	a0, a1, utility_LBB4_5 
	j	utility_LBB4_4 
utility_LBB4_4:
	lw	a0, -16(s0) 
	addi	a1, a0, 1 
	sw	a1, -16(s0) 
	lbu	a0, 0(a0) 
	snez	a0, a0 
	sw	a0, -28(s0) # 4-byte Folded Spill 
	j	utility_LBB4_5 
utility_LBB4_5:
	lw	a0, -28(s0) # 4-byte Folded Reload 
	andi	a0, a0, 1 
	beqz	a0, utility_LBB4_7 
	j	utility_LBB4_6 
utility_LBB4_6:
	lw	a0, -24(s0) 
	addi	a0, a0, 1 
	sw	a0, -24(s0) 
	j	utility_LBB4_3 
utility_LBB4_7:
	lw	a0, -24(s0) 
	sw	a0, -12(s0) 
	j	utility_LBB4_8 
utility_LBB4_8:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end4:
	#	-- End function 
string_copy:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	sw	a2, -24(s0) 
	lw	a0, -16(s0) 
	beqz	a0, utility_LBB5_2 
	j	utility_LBB5_1 
utility_LBB5_1:
	lw	a0, -20(s0) 
	bnez	a0, utility_LBB5_3 
	j	utility_LBB5_2 
utility_LBB5_2:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	utility_LBB5_9 
utility_LBB5_3:
	li	a0, 0 
	sw	a0, -28(s0) 
	j	utility_LBB5_4 
utility_LBB5_4:
	lw	a0, -28(s0) 
	lw	a1, -24(s0) 
	bge	a0, a1, utility_LBB5_8 
	j	utility_LBB5_5 
utility_LBB5_5:
	lw	a0, -20(s0) 
	addi	a1, a0, 1 
	sw	a1, -20(s0) 
	lbu	a0, 0(a0) 
	sb	a0, -29(s0) 
	lbu	a0, -29(s0) 
	lw	a1, -16(s0) 
	addi	a2, a1, 1 
	sw	a2, -16(s0) 
	sb	a0, 0(a1) 
	lbu	a0, -29(s0) 
	bnez	a0, utility_LBB5_7 
	j	utility_LBB5_6 
utility_LBB5_6:
	j	utility_LBB5_8 
utility_LBB5_7:
	lw	a0, -28(s0) 
	addi	a0, a0, 1 
	sw	a0, -28(s0) 
	j	utility_LBB5_4 
utility_LBB5_8:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	utility_LBB5_9 
utility_LBB5_9:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end5:
	#	-- End function 
string_compare:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	sw	a2, -24(s0) 
	lw	a0, -16(s0) 
	bnez	a0, utility_LBB6_3 
	j	utility_LBB6_1 
utility_LBB6_1:
	lw	a0, -20(s0) 
	bnez	a0, utility_LBB6_3 
	j	utility_LBB6_2 
utility_LBB6_2:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_3:
	lw	a0, -16(s0) 
	bnez	a0, utility_LBB6_6 
	j	utility_LBB6_4 
utility_LBB6_4:
	lw	a0, -20(s0) 
	beqz	a0, utility_LBB6_6 
	j	utility_LBB6_5 
utility_LBB6_5:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_6:
	lw	a0, -16(s0) 
	beqz	a0, utility_LBB6_9 
	j	utility_LBB6_7 
utility_LBB6_7:
	lw	a0, -20(s0) 
	bnez	a0, utility_LBB6_9 
	j	utility_LBB6_8 
utility_LBB6_8:
	li	a0, 1 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_9:
	li	a0, 0 
	sw	a0, -28(s0) 
	j	utility_LBB6_10 
utility_LBB6_10:
	lw	a0, -28(s0) 
	lw	a1, -24(s0) 
	bge	a0, a1, utility_LBB6_18 
	j	utility_LBB6_11 
utility_LBB6_11:
	lw	a0, -16(s0) 
	lbu	a0, 0(a0) 
	lw	a1, -20(s0) 
	lbu	a1, 0(a1) 
	bge	a0, a1, utility_LBB6_13 
	j	utility_LBB6_12 
utility_LBB6_12:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_13:
	lw	a0, -16(s0) 
	lbu	a1, 0(a0) 
	lw	a0, -20(s0) 
	lbu	a0, 0(a0) 
	bge	a0, a1, utility_LBB6_15 
	j	utility_LBB6_14 
utility_LBB6_14:
	li	a0, 1 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_15:
	lw	a0, -16(s0) 
	lbu	a0, 0(a0) 
	bnez	a0, utility_LBB6_17 
	j	utility_LBB6_16 
utility_LBB6_16:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_17:
	lw	a0, -16(s0) 
	addi	a0, a0, 1 
	sw	a0, -16(s0) 
	lw	a0, -20(s0) 
	addi	a0, a0, 1 
	sw	a0, -20(s0) 
	j	utility_LBB6_10 
utility_LBB6_18:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	utility_LBB6_19 
utility_LBB6_19:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end6:
	#	-- End function 
print_array:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	lw	a0, -16(s0) 
	bnez	a0, utility_LBB7_2 
	j	utility_LBB7_1 
utility_LBB7_1:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	utility_LBB7_7 
utility_LBB7_2:
	li	a0, 0 
	sw	a0, -24(s0) 
	j	utility_LBB7_3 
utility_LBB7_3:
	lw	a0, -24(s0) 
	lw	a1, -20(s0) 
	bge	a0, a1, utility_LBB7_6 
	j	utility_LBB7_4 
utility_LBB7_4:
	lw	a0, -16(s0) 
	lw	a1, -24(s0) 
	slli	a1, a1, 2 
	add	a0, a0, a1 
	lw	a0, 0(a0) 
	call	print 
utility_Lpcrel_hi1:
	auipc	a0, %hi(%pcrel(utility_L.str))
	addi	a0, a0, %lo(%larel(utility_L.str,utility_Lpcrel_hi1))
	call	print 
	j	utility_LBB7_5 
utility_LBB7_5:
	lw	a0, -24(s0) 
	addi	a0, a0, 1 
	sw	a0, -24(s0) 
	j	utility_LBB7_3 
utility_LBB7_6:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	utility_LBB7_7 
utility_LBB7_7:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
utility_Lfunc_end7:
	#	-- End function 
	.Numeric
int_to_hex.hex_digits:
	.Text
	.ascii	"0123456789abcdef"
utility_L.str:
	.asciz	"\n"
