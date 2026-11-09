	.Code
get_bd_portal:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
bd_driver_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(get_bd_portal.bd_portal))
	addi	a0, a0, %lo(%larel(get_bd_portal.bd_portal,bd_driver_Lpcrel_hi0))
	lw	a0, 0(a0) 
	bnez	a0, bd_driver_LBB0_4 
	j	bd_driver_LBB0_1 
bd_driver_LBB0_1:
bd_driver_Lpcrel_hi1:
	auipc	a0, %hi(%pcrel(block_device_code))
	addi	a0, a0, %lo(%larel(block_device_code,bd_driver_Lpcrel_hi1))
	lw	a0, 0(a0) 
	li	a1, 1 
	call	find_device 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	beqz	a0, bd_driver_LBB0_3 
	j	bd_driver_LBB0_2 
bd_driver_LBB0_2:
	lw	a0, -12(s0) 
	lw	a0, 4(a0) 
bd_driver_Lpcrel_hi2:
	auipc	a1, %hi(%pcrel(get_bd_portal.bd_portal))
	addi	a1, a1, %lo(%larel(get_bd_portal.bd_portal,bd_driver_Lpcrel_hi2))
	sw	a0, 0(a1) 
	j	bd_driver_LBB0_3 
bd_driver_LBB0_3:
	j	bd_driver_LBB0_4 
bd_driver_LBB0_4:
bd_driver_Lpcrel_hi3:
	auipc	a0, %hi(%pcrel(get_bd_portal.bd_portal))
	addi	a0, a0, %lo(%larel(get_bd_portal.bd_portal,bd_driver_Lpcrel_hi3))
	lw	a0, 0(a0) 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
bd_driver_Lfunc_end0:
	#	-- End function 
bd_read_block:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	call	get_bd_portal 
	sw	a0, -24(s0) 
	lw	a0, -16(s0) 
	lw	a2, -24(s0) 
	lui	a1, 1 
	add	a2, a2, a1 
	sw	a0, 0(a2) 
	lw	a0, -24(s0) 
	add	a1, a0, a1 
	li	a0, -1 
	sw	a0, 4(a1) 
	li	a0, 1 
	bnez	a0, bd_driver_LBB1_2 
	j	bd_driver_LBB1_1 
bd_driver_LBB1_1:
	lw	a0, -24(s0) 
	lui	a1, 1 
	add	a0, a0, a1 
	lw	a0, 4(a0) 
	sw	a0, -12(s0) 
	j	bd_driver_LBB1_3 
bd_driver_LBB1_2:
	lw	a1, -24(s0) 
bd_driver_Lpcrel_hi4:
	auipc	a0, %hi(%pcrel(DMA_portal_ptr))
	addi	a0, a0, %lo(%larel(DMA_portal_ptr,bd_driver_Lpcrel_hi4))
	lw	a2, 0(a0) 
	sw	a1, 0(a2) 
	lw	a1, -20(s0) 
	lw	a2, 0(a0) 
	sw	a1, 4(a2) 
	lw	a1, 0(a0) 
	lui	a0, 1 
	sw	a0, 8(a1) 
	li	a0, 0 
	sw	a0, -12(s0) 
	j	bd_driver_LBB1_3 
bd_driver_LBB1_3:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bd_driver_Lfunc_end1:
	#	-- End function 
bd_write_block:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	call	get_bd_portal 
	sw	a0, -24(s0) 
	lw	a1, -20(s0) 
bd_driver_Lpcrel_hi5:
	auipc	a0, %hi(%pcrel(DMA_portal_ptr))
	addi	a0, a0, %lo(%larel(DMA_portal_ptr,bd_driver_Lpcrel_hi5))
	lw	a2, 0(a0) 
	sw	a1, 0(a2) 
	lw	a1, -24(s0) 
	lw	a2, 0(a0) 
	sw	a1, 4(a2) 
	lw	a0, 0(a0) 
	lui	a1, 1 
	sw	a1, 8(a0) 
	lw	a0, -16(s0) 
	lw	a2, -24(s0) 
	add	a2, a2, a1 
	sw	a0, 0(a2) 
	lw	a0, -24(s0) 
	add	a1, a0, a1 
	li	a0, 1 
	sw	a0, 4(a1) 
	bnez	a0, bd_driver_LBB2_2 
	j	bd_driver_LBB2_1 
bd_driver_LBB2_1:
	lw	a0, -24(s0) 
	lui	a1, 1 
	add	a0, a0, a1 
	lw	a0, 4(a0) 
	sw	a0, -12(s0) 
	j	bd_driver_LBB2_3 
bd_driver_LBB2_2:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	bd_driver_LBB2_3 
bd_driver_LBB2_3:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bd_driver_Lfunc_end2:
	#	-- End function 
bd_get_length:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	call	get_bd_portal 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	lui	a1, 1 
	add	a2, a0, a1 
	li	a0, 0 
	sw	a0, 4(a2) 
	lw	a0, -12(s0) 
	add	a0, a0, a1 
	lw	a0, 4(a0) 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
bd_driver_Lfunc_end3:
	#	-- End function 
get_bd_portal.bd_portal:
	.Numeric
	.word	0
