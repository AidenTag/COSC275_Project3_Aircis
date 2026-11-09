	.Code
heap_init:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
heap_alloc_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(heap_limit))
	addi	a0, a0, %lo(%larel(heap_limit,heap_alloc_Lpcrel_hi0))
	lw	a0, 0(a0) 
	beqz	a0, heap_alloc_LBB0_2 
	j	heap_alloc_LBB0_1 
heap_alloc_LBB0_1:
	j	heap_alloc_LBB0_3 
heap_alloc_LBB0_2:
heap_alloc_Lpcrel_hi1:
	auipc	a0, %hi(%pcrel(heap_limit))
	addi	a1, a0, %lo(%larel(heap_limit,heap_alloc_Lpcrel_hi1))
heap_alloc_Lpcrel_hi2:
	auipc	a0, %hi(%pcrel(statics_limit))
	addi	a0, a0, %lo(%larel(statics_limit,heap_alloc_Lpcrel_hi2))
	sw	a0, 0(a1) 
heap_alloc_Lpcrel_hi3:
	auipc	a0, %hi(%pcrel(free_head))
	addi	a0, a0, %lo(%larel(free_head,heap_alloc_Lpcrel_hi3))
heap_alloc_Lpcrel_hi4:
	auipc	a1, %hi(%pcrel(free_tail))
	addi	a1, a1, %lo(%larel(free_tail,heap_alloc_Lpcrel_hi4))
	sw	a1, 4(a0) 
	sw	a0, 8(a1) 
	j	heap_alloc_LBB0_3 
heap_alloc_LBB0_3:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
heap_alloc_Lfunc_end0:
	#	-- End function 
allocate:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
heap_alloc_Lpcrel_hi5:
	auipc	a0, %hi(%pcrel(heap_alloc_L.str))
	addi	a0, a0, %lo(%larel(heap_alloc_L.str,heap_alloc_Lpcrel_hi5))
	call	print 
	lw	a0, -12(s0) 
	call	print_dec 
heap_alloc_Lpcrel_hi6:
	auipc	a0, %hi(%pcrel(heap_alloc_L.str.1))
	addi	a0, a0, %lo(%larel(heap_alloc_L.str.1,heap_alloc_Lpcrel_hi6))
	call	print 
	call	heap_init 
	lbu	a0, -12(s0) 
	andi	a0, a0, 3 
	bnez	a0, heap_alloc_LBB1_2 
	j	heap_alloc_LBB1_1 
heap_alloc_LBB1_1:
	lw	a0, -12(s0) 
	sw	a0, -28(s0) # 4-byte Folded Spill 
	j	heap_alloc_LBB1_3 
heap_alloc_LBB1_2:
	lw	a0, -12(s0) 
	addi	a0, a0, 4 
	andi	a0, a0, -4 
	sw	a0, -28(s0) # 4-byte Folded Spill 
	j	heap_alloc_LBB1_3 
heap_alloc_LBB1_3:
	lw	a0, -28(s0) # 4-byte Folded Reload 
	sw	a0, -12(s0) 
heap_alloc_Lpcrel_hi7:
	auipc	a0, %hi(%pcrel(free_head))
	addi	a0, a0, %lo(%larel(free_head,heap_alloc_Lpcrel_hi7))
	lw	a0, 4(a0) 
	sw	a0, -16(s0) 
	j	heap_alloc_LBB1_4 
heap_alloc_LBB1_4:
	lw	a0, -16(s0) 
heap_alloc_Lpcrel_hi8:
	auipc	a1, %hi(%pcrel(free_tail))
	addi	a1, a1, %lo(%larel(free_tail,heap_alloc_Lpcrel_hi8))
	beq	a0, a1, heap_alloc_LBB1_9 
	j	heap_alloc_LBB1_5 
heap_alloc_LBB1_5:
	lw	a0, -16(s0) 
	lw	a0, 0(a0) 
	lw	a1, -12(s0) 
	bltu	a0, a1, heap_alloc_LBB1_7 
	j	heap_alloc_LBB1_6 
heap_alloc_LBB1_6:
	lw	a1, -16(s0) 
	lw	a0, 4(a1) 
	lw	a1, 8(a1) 
	sw	a0, 4(a1) 
	lw	a1, -16(s0) 
	lw	a0, 8(a1) 
	lw	a1, 4(a1) 
	sw	a0, 8(a1) 
	lw	a1, -16(s0) 
	li	a0, 0 
	sw	a0, 4(a1) 
	lw	a1, -16(s0) 
	sw	a0, 8(a1) 
	j	heap_alloc_LBB1_9 
heap_alloc_LBB1_7:
	lw	a0, -16(s0) 
	lw	a0, 4(a0) 
	sw	a0, -16(s0) 
	j	heap_alloc_LBB1_8 
heap_alloc_LBB1_8:
	j	heap_alloc_LBB1_4 
heap_alloc_LBB1_9:
	lw	a0, -16(s0) 
heap_alloc_Lpcrel_hi9:
	auipc	a1, %hi(%pcrel(free_tail))
	addi	a1, a1, %lo(%larel(free_tail,heap_alloc_Lpcrel_hi9))
	bne	a0, a1, heap_alloc_LBB1_11 
	j	heap_alloc_LBB1_10 
heap_alloc_LBB1_10:
	lw	a0, -12(s0) 
	addi	a0, a0, 12 
	sw	a0, -20(s0) 
heap_alloc_Lpcrel_hi10:
	auipc	a0, %hi(%pcrel(heap_limit))
	addi	a1, a0, %lo(%larel(heap_limit,heap_alloc_Lpcrel_hi10))
	lw	a0, 0(a1) 
	sw	a0, -16(s0) 
	lw	a0, -12(s0) 
	lw	a2, -16(s0) 
	sw	a0, 0(a2) 
	lw	a2, -20(s0) 
	lw	a0, 0(a1) 
	add	a0, a0, a2 
	sw	a0, 0(a1) 
	j	heap_alloc_LBB1_11 
heap_alloc_LBB1_11:
	lw	a0, -16(s0) 
	addi	a0, a0, 12 
	sw	a0, -24(s0) 
	lw	a0, -24(s0) 
	call	print_hex 
heap_alloc_Lpcrel_hi11:
	auipc	a0, %hi(%pcrel(heap_alloc_L.str.2))
	addi	a0, a0, %lo(%larel(heap_alloc_L.str.2,heap_alloc_Lpcrel_hi11))
	call	print 
	lw	a0, -24(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
heap_alloc_Lfunc_end1:
	#	-- End function 
deallocate:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	bnez	a0, heap_alloc_LBB2_2 
	j	heap_alloc_LBB2_1 
heap_alloc_LBB2_1:
	j	heap_alloc_LBB2_3 
heap_alloc_LBB2_2:
heap_alloc_Lpcrel_hi12:
	auipc	a0, %hi(%pcrel(heap_alloc_L.str.3))
	addi	a0, a0, %lo(%larel(heap_alloc_L.str.3,heap_alloc_Lpcrel_hi12))
	call	print 
	lw	a0, -12(s0) 
	call	print_hex 
heap_alloc_Lpcrel_hi13:
	auipc	a0, %hi(%pcrel(heap_alloc_L.str.4))
	addi	a0, a0, %lo(%larel(heap_alloc_L.str.4,heap_alloc_Lpcrel_hi13))
	call	print 
	lw	a0, -12(s0) 
	addi	a0, a0, -12 
	sw	a0, -16(s0) 
heap_alloc_Lpcrel_hi14:
	auipc	a0, %hi(%pcrel(free_head))
	addi	a1, a0, %lo(%larel(free_head,heap_alloc_Lpcrel_hi14))
	lw	a0, 4(a1) 
	lw	a2, -16(s0) 
	sw	a0, 4(a2) 
	lw	a0, -16(s0) 
	sw	a1, 8(a0) 
	lw	a0, -16(s0) 
	lw	a2, 4(a1) 
	sw	a0, 8(a2) 
	lw	a0, -16(s0) 
	sw	a0, 4(a1) 
	lw	a0, -16(s0) 
	lw	a0, 0(a0) 
	call	print_dec 
heap_alloc_Lpcrel_hi15:
	auipc	a0, %hi(%pcrel(heap_alloc_L.str.5))
	addi	a0, a0, %lo(%larel(heap_alloc_L.str.5,heap_alloc_Lpcrel_hi15))
	call	print 
	j	heap_alloc_LBB2_3 
heap_alloc_LBB2_3:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
heap_alloc_Lfunc_end2:
	#	-- End function 
free_head:
	.Numeric
	.byte 0 0 0 0 0 0 0 0 0 0 0 0 
free_tail:
	.byte 0 0 0 0 0 0 0 0 0 0 0 0 
heap_limit:
	.word	0                               # 0x0
heap_alloc_L.str:
	.Text
	.asciz	"[debug: ] allocate("
heap_alloc_L.str.1:
	.asciz	") -> 0x"
heap_alloc_L.str.2:
	.asciz	"\n"
heap_alloc_L.str.3:
	.asciz	"[debug: ] deallocate(0x"
heap_alloc_L.str.4:
	.asciz	") [size = "
heap_alloc_L.str.5:
	.asciz	"]\n"
