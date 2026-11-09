	.Code
insert_process:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
kernel_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi0))
	lw	a0, 0(a0) 
	bnez	a0, kernel_LBB0_2 
	j	kernel_LBB0_1 
kernel_LBB0_1:
	lw	a0, -12(s0) 
kernel_Lpcrel_hi1:
	auipc	a1, %hi(%pcrel(current_process))
	addi	a1, a1, %lo(%larel(current_process,kernel_Lpcrel_hi1))
	sw	a0, 0(a1) 
	lw	a0, -12(s0) 
	sw	a0, 0(a0) 
	lw	a0, -12(s0) 
	sw	a0, 4(a0) 
	j	kernel_LBB0_3 
kernel_LBB0_2:
kernel_Lpcrel_hi2:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a1, a0, %lo(%larel(current_process,kernel_Lpcrel_hi2))
	lw	a0, 0(a1) 
	lw	a0, 0(a0) 
	lw	a2, -12(s0) 
	sw	a0, 0(a2) 
	lw	a0, 0(a1) 
	lw	a2, -12(s0) 
	sw	a0, 4(a2) 
	lw	a0, -12(s0) 
	lw	a1, 0(a1) 
	sw	a0, 0(a1) 
	lw	a0, -12(s0) 
	lw	a1, 0(a0) 
	sw	a0, 4(a1) 
	j	kernel_LBB0_3 
kernel_LBB0_3:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end0:
	#	-- End function 
remove_process:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	lw	a1, -12(s0) 
	lw	a0, 0(a1) 
	bne	a0, a1, kernel_LBB1_2 
	j	kernel_LBB1_1 
kernel_LBB1_1:
kernel_Lpcrel_hi3:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a1, a0, %lo(%larel(current_process,kernel_Lpcrel_hi3))
	li	a0, 0 
	sw	a0, 0(a1) 
	lw	a1, -12(s0) 
	sw	a0, 0(a1) 
	lw	a1, -12(s0) 
	sw	a0, 4(a1) 
	j	kernel_LBB1_5 
kernel_LBB1_2:
	lw	a0, -12(s0) 
kernel_Lpcrel_hi4:
	auipc	a1, %hi(%pcrel(current_process))
	addi	a1, a1, %lo(%larel(current_process,kernel_Lpcrel_hi4))
	lw	a1, 0(a1) 
	bne	a0, a1, kernel_LBB1_4 
	j	kernel_LBB1_3 
kernel_LBB1_3:
kernel_Lpcrel_hi5:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a1, a0, %lo(%larel(current_process,kernel_Lpcrel_hi5))
	lw	a0, 0(a1) 
	lw	a0, 0(a0) 
	sw	a0, 0(a1) 
	j	kernel_LBB1_4 
kernel_LBB1_4:
	lw	a1, -12(s0) 
	lw	a0, 4(a1) 
	lw	a1, 0(a1) 
	sw	a0, 4(a1) 
	lw	a1, -12(s0) 
	lw	a0, 0(a1) 
	lw	a1, 4(a1) 
	sw	a0, 0(a1) 
	lw	a1, -12(s0) 
	li	a0, 0 
	sw	a0, 0(a1) 
	lw	a1, -12(s0) 
	sw	a0, 4(a1) 
	j	kernel_LBB1_5 
kernel_LBB1_5:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end1:
	#	-- End function 
cpu_scheduler:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	call	quantum_expired 
	beqz	a0, kernel_LBB2_2 
	j	kernel_LBB2_1 
kernel_LBB2_1:
kernel_Lpcrel_hi6:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a1, a0, %lo(%larel(current_process,kernel_Lpcrel_hi6))
	lw	a0, 0(a1) 
	lw	a0, 0(a0) 
	sw	a0, 0(a1) 
	li	a0, 256 
	sw	a0, -12(s0) 
	j	kernel_LBB2_3 
kernel_LBB2_2:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	kernel_LBB2_3 
kernel_LBB2_3:
kernel_Lpcrel_hi7:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi7))
	lw	a3, 0(a0) 
	lw	a0, 16(a3) 
	lw	a1, 20(a3) 
	lw	a2, 8(a3) 
	lw	a3, 12(a3) 
	lw	a4, -12(s0) 
	call	userspace_jump 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end2:
	#	-- End function 
do_noop:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
kernel_Lpcrel_hi8:
	auipc	a0, %hi(%pcrel(kernel_L.str))
	addi	a0, a0, %lo(%larel(kernel_L.str,kernel_Lpcrel_hi8))
	call	print 
kernel_Lpcrel_hi9:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_Lpcrel_hi9))
	call	print 
kernel_Lpcrel_hi10:
	auipc	a0, %hi(%pcrel(kernel_L.str.2))
	addi	a0, a0, %lo(%larel(kernel_L.str.2,kernel_Lpcrel_hi10))
	call	print 
kernel_Lpcrel_hi11:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi11))
	lw	a1, 0(a0) 
	lw	a0, 16(a1) 
	addi	a0, a0, 4 
	sw	a0, 16(a1) 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end3:
	#	-- End function 
do_exit:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
kernel_Lpcrel_hi12:
	auipc	a0, %hi(%pcrel(kernel_L.str.3))
	addi	a0, a0, %lo(%larel(kernel_L.str.3,kernel_Lpcrel_hi12))
	call	print 
kernel_Lpcrel_hi13:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi13))
	sw	a0, -20(s0) # 4-byte Folded Spill 
	lw	a0, 0(a0) 
	lw	a0, 24(a0) 
	call	print_dec 
kernel_Lpcrel_hi14:
	auipc	a0, %hi(%pcrel(kernel_L.str.4))
	addi	a0, a0, %lo(%larel(kernel_L.str.4,kernel_Lpcrel_hi14))
	call	print 
	lw	a0, -12(s0) 
	call	print_dec 
kernel_Lpcrel_hi15:
	auipc	a0, %hi(%pcrel(kernel_L.str.2))
	addi	a0, a0, %lo(%larel(kernel_L.str.2,kernel_Lpcrel_hi15))
	call	print 
	lw	a0, -20(s0) # 4-byte Folded Reload 
	lw	a0, 0(a0) 
	lw	a0, 8(a0) 
	call	mm_deallocate 
	lw	a0, -20(s0) # 4-byte Folded Reload 
	lw	a0, 0(a0) 
	sw	a0, -16(s0) 
	lw	a0, -16(s0) 
	call	remove_process 
	lw	a0, -16(s0) 
	call	deallocate 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end4:
	#	-- End function 
do_run:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
kernel_Lpcrel_hi16:
	auipc	a0, %hi(%pcrel(kernel_L.str.5))
	addi	a0, a0, %lo(%larel(kernel_L.str.5,kernel_Lpcrel_hi16))
	call	print 
	#APP	
	ebreak	
	#NO_APP	
	lw	a0, -16(s0) 
	call	print 
kernel_Lpcrel_hi17:
	auipc	a0, %hi(%pcrel(kernel_L.str.2))
	addi	a0, a0, %lo(%larel(kernel_L.str.2,kernel_Lpcrel_hi17))
	call	print 
kernel_Lpcrel_hi18:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi18))
	lw	a0, 0(a0) 
	beqz	a0, kernel_LBB5_2 
	j	kernel_LBB5_1 
kernel_LBB5_1:
kernel_Lpcrel_hi19:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi19))
	lw	a1, 0(a0) 
	lw	a0, 16(a1) 
	addi	a0, a0, 4 
	sw	a0, 16(a1) 
	j	kernel_LBB5_2 
kernel_LBB5_2:
	call	mm_allocate 
	sw	a0, -20(s0) 
	lw	a0, -20(s0) 
	bnez	a0, kernel_LBB5_4 
	j	kernel_LBB5_3 
kernel_LBB5_3:
	li	a0, -3 
	sw	a0, -12(s0) 
	j	kernel_LBB5_11 
kernel_LBB5_4:
	lw	a0, -20(s0) 
	lw	a1, -16(s0) 
	lui	a2, 16 
	call	read_filename_to_buffer 
	sw	a0, -24(s0) 
	lw	a0, -24(s0) 
	bgez	a0, kernel_LBB5_8 
	j	kernel_LBB5_5 
kernel_LBB5_5:
	lw	a0, -20(s0) 
	call	mm_deallocate 
	lw	a0, -24(s0) 
	li	a1, -2 
	bne	a0, a1, kernel_LBB5_7 
	j	kernel_LBB5_6 
kernel_LBB5_6:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	kernel_LBB5_11 
kernel_LBB5_7:
	li	a0, -4 
	sw	a0, -12(s0) 
	j	kernel_LBB5_11 
kernel_LBB5_8:
	li	a0, 88 
	call	allocate 
	sw	a0, -28(s0) 
	lw	a0, -28(s0) 
	bnez	a0, kernel_LBB5_10 
	j	kernel_LBB5_9 
kernel_LBB5_9:
	lw	a0, -20(s0) 
	call	mm_deallocate 
	li	a0, -2 
	sw	a0, -12(s0) 
	j	kernel_LBB5_11 
kernel_LBB5_10:
	lw	a1, -28(s0) 
	li	a0, 0 
	sw	a0, 16(a1) 
	lw	a1, -28(s0) 
	lui	a0, 16 
	sw	a0, 20(a1) 
kernel_Lpcrel_hi20:
	auipc	a0, %hi(%pcrel(next_process_ID))
	addi	a2, a0, %lo(%larel(next_process_ID,kernel_Lpcrel_hi20))
	lw	a0, 0(a2) 
	addi	a1, a0, 1 
	sw	a1, 0(a2) 
	lw	a1, -28(s0) 
	sw	a0, 24(a1) 
	lw	a0, -28(s0) 
	addi	a0, a0, 28 
	lw	a1, -16(s0) 
	li	a2, 60 
	call	string_copy 
	lw	a0, -28(s0) 
	call	insert_process 
	lw	a0, -28(s0) 
	lw	a0, 24(a0) 
	sw	a0, -12(s0) 
	j	kernel_LBB5_11 
kernel_LBB5_11:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end5:
	#	-- End function 
do_print:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -16(s0) 
	lw	a0, -16(s0) 
kernel_Lpcrel_hi21:
	auipc	a1, %hi(%pcrel(current_process))
	addi	a1, a1, %lo(%larel(current_process,kernel_Lpcrel_hi21))
	lw	a2, 0(a1) 
	lw	a2, 8(a2) 
	add	a0, a0, a2 
	sw	a0, -16(s0) 
	lw	a0, -16(s0) 
	lw	a1, 0(a1) 
	lw	a1, 12(a1) 
	bltu	a0, a1, kernel_LBB6_2 
	j	kernel_LBB6_1 
kernel_LBB6_1:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	kernel_LBB6_3 
kernel_LBB6_2:
	lw	a0, -16(s0) 
	call	print 
kernel_Lpcrel_hi22:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi22))
	lw	a1, 0(a0) 
	lw	a0, 16(a1) 
	addi	a0, a0, 4 
	sw	a0, 16(a1) 
	li	a0, 0 
	sw	a0, -12(s0) 
	j	kernel_LBB6_3 
kernel_LBB6_3:
	lw	a0, -12(s0) 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end6:
	#	-- End function 
do_syscall:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
kernel_Lpcrel_hi23:
	auipc	a0, %hi(%pcrel(preserved_epc))
	addi	a0, a0, %lo(%larel(preserved_epc,kernel_Lpcrel_hi23))
	lw	a0, 0(a0) 
kernel_Lpcrel_hi24:
	auipc	a1, %hi(%pcrel(current_process))
	addi	a1, a1, %lo(%larel(current_process,kernel_Lpcrel_hi24))
	lw	a2, 0(a1) 
	sw	a0, 16(a2) 
kernel_Lpcrel_hi25:
	auipc	a0, %hi(%pcrel(preserved_sp))
	addi	a0, a0, %lo(%larel(preserved_sp,kernel_Lpcrel_hi25))
	lw	a0, 0(a0) 
	lw	a1, 0(a1) 
	sw	a0, 20(a1) 
	li	a0, 0 
	sb	a0, -17(s0) 
	sw	a0, -24(s0) 
	lw	a0, -12(s0) 
	lui	a1, 827664 
	bne	a0, a1, kernel_LBB7_2 
	j	kernel_LBB7_1 
kernel_LBB7_1:
	call	do_noop 
	j	kernel_LBB7_14 
kernel_LBB7_2:
	lw	a0, -12(s0) 
	lui	a1, 827664 
	addi	a1, a1, 1 
	bne	a0, a1, kernel_LBB7_6 
	j	kernel_LBB7_3 
kernel_LBB7_3:
	lw	a0, -16(s0) 
	call	do_exit 
kernel_Lpcrel_hi26:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi26))
	lw	a0, 0(a0) 
	bnez	a0, kernel_LBB7_5 
	j	kernel_LBB7_4 
kernel_LBB7_4:
kernel_Lpcrel_hi27:
	auipc	a0, %hi(%pcrel(kernel_L.str.6))
	addi	a0, a0, %lo(%larel(kernel_L.str.6,kernel_Lpcrel_hi27))
	call	print 
	call	halt_kernel 
	j	kernel_LBB7_5 
kernel_LBB7_5:
	j	kernel_LBB7_13 
kernel_LBB7_6:
	lw	a0, -12(s0) 
	lui	a1, 827664 
	addi	a1, a1, 3 
	bne	a0, a1, kernel_LBB7_8 
	j	kernel_LBB7_7 
kernel_LBB7_7:
	li	a0, 1 
	sb	a0, -17(s0) 
	lw	a0, -16(s0) 
	call	do_run 
	sw	a0, -24(s0) 
	j	kernel_LBB7_12 
kernel_LBB7_8:
	lw	a0, -12(s0) 
	lui	a1, 827664 
	addi	a1, a1, 2 
	bne	a0, a1, kernel_LBB7_10 
	j	kernel_LBB7_9 
kernel_LBB7_9:
	li	a0, 1 
	sb	a0, -17(s0) 
	lw	a0, -16(s0) 
	call	do_print 
	sw	a0, -24(s0) 
	j	kernel_LBB7_11 
kernel_LBB7_10:
	li	a0, -1 
	sw	a0, -24(s0) 
	j	kernel_LBB7_11 
kernel_LBB7_11:
	j	kernel_LBB7_12 
kernel_LBB7_12:
	j	kernel_LBB7_13 
kernel_LBB7_13:
	j	kernel_LBB7_14 
kernel_LBB7_14:
	lbu	a0, -17(s0) 
	andi	a0, a0, 1 
	beqz	a0, kernel_LBB7_16 
	j	kernel_LBB7_15 
kernel_LBB7_15:
kernel_Lpcrel_hi28:
	auipc	a0, %hi(%pcrel(current_process))
	addi	a0, a0, %lo(%larel(current_process,kernel_Lpcrel_hi28))
	lw	a1, 0(a0) 
	lw	a0, 8(a1) 
	lw	a1, 20(a1) 
	add	a0, a0, a1 
	addi	a0, a0, -36 
	sw	a0, -28(s0) 
	lw	a0, -24(s0) 
	lw	a1, -28(s0) 
	sw	a0, 0(a1) 
	j	kernel_LBB7_16 
kernel_LBB7_16:
	call	cpu_scheduler 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end7:
	#	-- End function 
do_alarm:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
kernel_Lpcrel_hi29:
	auipc	a0, %hi(%pcrel(preserved_epc))
	addi	a0, a0, %lo(%larel(preserved_epc,kernel_Lpcrel_hi29))
	lw	a0, 0(a0) 
kernel_Lpcrel_hi30:
	auipc	a1, %hi(%pcrel(current_process))
	addi	a1, a1, %lo(%larel(current_process,kernel_Lpcrel_hi30))
	lw	a2, 0(a1) 
	sw	a0, 16(a2) 
kernel_Lpcrel_hi31:
	auipc	a0, %hi(%pcrel(preserved_sp))
	addi	a0, a0, %lo(%larel(preserved_sp,kernel_Lpcrel_hi31))
	lw	a0, 0(a0) 
	lw	a1, 0(a1) 
	sw	a0, 20(a1) 
	call	cpu_scheduler 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end8:
	#	-- End function 
fs_init:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
kernel_Lpcrel_hi32:
	auipc	a0, %hi(%pcrel(fs_init.fs_metadata_blocks))
	addi	a0, a0, %lo(%larel(fs_init.fs_metadata_blocks,kernel_Lpcrel_hi32))
	lw	a0, 0(a0) 
	beqz	a0, kernel_LBB9_2 
	j	kernel_LBB9_1 
kernel_LBB9_1:
kernel_Lpcrel_hi33:
	auipc	a0, %hi(%pcrel(kernel_L.str.7))
	addi	a0, a0, %lo(%larel(kernel_L.str.7,kernel_Lpcrel_hi33))
	call	print 
	j	kernel_LBB9_10 
kernel_LBB9_2:
	call	mm_allocate 
	mv	a1, a0 
kernel_Lpcrel_hi34:
	auipc	a0, %hi(%pcrel(fs_init.fs_metadata_blocks))
	addi	a0, a0, %lo(%larel(fs_init.fs_metadata_blocks,kernel_Lpcrel_hi34))
	sw	a1, 0(a0) 
	lw	a0, 0(a0) 
	bnez	a0, kernel_LBB9_4 
	j	kernel_LBB9_3 
kernel_LBB9_3:
kernel_Lpcrel_hi35:
	auipc	a0, %hi(%pcrel(kernel_L.str.8))
	addi	a0, a0, %lo(%larel(kernel_L.str.8,kernel_Lpcrel_hi35))
	call	print 
	call	halt_kernel 
	j	kernel_LBB9_4 
kernel_LBB9_4:
kernel_Lpcrel_hi36:
	auipc	a0, %hi(%pcrel(fs_init.fs_metadata_blocks))
	addi	a0, a0, %lo(%larel(fs_init.fs_metadata_blocks,kernel_Lpcrel_hi36))
	lw	a1, 0(a0) 
kernel_Lpcrel_hi37:
	auipc	a0, %hi(%pcrel(superblock))
	addi	a0, a0, %lo(%larel(superblock,kernel_Lpcrel_hi37))
	sw	a1, 0(a0) 
	lw	a1, 0(a0) 
	li	a0, 0 
	call	bd_read_block 
	bgez	a0, kernel_LBB9_6 
	j	kernel_LBB9_5 
kernel_LBB9_5:
kernel_Lpcrel_hi38:
	auipc	a0, %hi(%pcrel(kernel_L.str.9))
	addi	a0, a0, %lo(%larel(kernel_L.str.9,kernel_Lpcrel_hi38))
	call	print 
	call	halt_kernel 
	j	kernel_LBB9_6 
kernel_LBB9_6:
kernel_Lpcrel_hi39:
	auipc	a0, %hi(%pcrel(fs_init.fs_metadata_blocks))
	addi	a0, a0, %lo(%larel(fs_init.fs_metadata_blocks,kernel_Lpcrel_hi39))
	lw	a0, 0(a0) 
	lui	a1, 1 
	add	a0, a0, a1 
kernel_Lpcrel_hi40:
	auipc	a1, %hi(%pcrel(directory_inode))
	addi	a1, a1, %lo(%larel(directory_inode,kernel_Lpcrel_hi40))
	sw	a0, 0(a1) 
kernel_Lpcrel_hi41:
	auipc	a0, %hi(%pcrel(superblock))
	addi	a0, a0, %lo(%larel(superblock,kernel_Lpcrel_hi41))
	lw	a0, 0(a0) 
	lw	a0, 12(a0) 
	lw	a1, 0(a1) 
	call	bd_read_block 
	bgez	a0, kernel_LBB9_8 
	j	kernel_LBB9_7 
kernel_LBB9_7:
kernel_Lpcrel_hi42:
	auipc	a0, %hi(%pcrel(kernel_L.str.10))
	addi	a0, a0, %lo(%larel(kernel_L.str.10,kernel_Lpcrel_hi42))
	call	print 
	call	halt_kernel 
	j	kernel_LBB9_8 
kernel_LBB9_8:
kernel_Lpcrel_hi43:
	auipc	a0, %hi(%pcrel(fs_init.fs_metadata_blocks))
	addi	a0, a0, %lo(%larel(fs_init.fs_metadata_blocks,kernel_Lpcrel_hi43))
	lw	a0, 0(a0) 
	lui	a1, 2 
	add	a1, a0, a1 
kernel_Lpcrel_hi44:
	auipc	a0, %hi(%pcrel(directory_entries))
	addi	a0, a0, %lo(%larel(directory_entries,kernel_Lpcrel_hi44))
	sw	a1, 0(a0) 
	lui	a1, 14 
	sw	a1, -12(s0) 
	lw	a0, 0(a0) 
kernel_Lpcrel_hi45:
	auipc	a1, %hi(%pcrel(directory_inode))
	addi	a1, a1, %lo(%larel(directory_inode,kernel_Lpcrel_hi45))
	lw	a1, 0(a1) 
	lw	a2, -12(s0) 
	call	read_inode_to_buffer 
	bgez	a0, kernel_LBB9_10 
	j	kernel_LBB9_9 
kernel_LBB9_9:
kernel_Lpcrel_hi46:
	auipc	a0, %hi(%pcrel(kernel_L.str.11))
	addi	a0, a0, %lo(%larel(kernel_L.str.11,kernel_Lpcrel_hi46))
	call	print 
	call	halt_kernel 
	j	kernel_LBB9_10 
kernel_LBB9_10:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end9:
	#	-- End function 
run_init:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	call	fs_init 
kernel_Lpcrel_hi47:
	auipc	a0, %hi(%pcrel(kernel_L.str.12))
	addi	a0, a0, %lo(%larel(kernel_L.str.12,kernel_Lpcrel_hi47))
	call	do_run 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	bgez	a0, kernel_LBB10_5 
	j	kernel_LBB10_1 
kernel_LBB10_1:
	lw	a0, -12(s0) 
	li	a1, -1 
	bne	a0, a1, kernel_LBB10_3 
	j	kernel_LBB10_2 
kernel_LBB10_2:
kernel_Lpcrel_hi48:
	auipc	a0, %hi(%pcrel(kernel_L.str.13))
	addi	a0, a0, %lo(%larel(kernel_L.str.13,kernel_Lpcrel_hi48))
	call	print 
	j	kernel_LBB10_4 
kernel_LBB10_3:
kernel_Lpcrel_hi49:
	auipc	a0, %hi(%pcrel(kernel_L.str.14))
	addi	a0, a0, %lo(%larel(kernel_L.str.14,kernel_Lpcrel_hi49))
	call	print 
	j	kernel_LBB10_4 
kernel_LBB10_4:
	call	halt_kernel 
	j	kernel_LBB10_5 
kernel_LBB10_5:
	call	cpu_scheduler 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end10:
	#	-- End function 
current_process:
	.Numeric
	.word	0
next_process_ID:
	.word	0                               # 0x0
superblock:
	.word	0
directory_inode:
	.word	0
directory_entries:
	.word	0
kernel_L.str:
	.Text
	.asciz	"[debug: ] "
kernel_L.str.1:
	.asciz	"NOOP requested"
kernel_L.str.2:
	.asciz	"\n"
kernel_L.str.3:
	.asciz	"[kernel:] EXIT pid "
kernel_L.str.4:
	.asciz	" with status "
kernel_L.str.5:
	.asciz	"[kernel:] RUN "
kernel_L.str.6:
	.asciz	"[kernel:] All processes terminated\n"
fs_init.fs_metadata_blocks:
	.Numeric
	.word	0
kernel_L.str.7:
	.Text
	.asciz	"[kernel:] WARNING: fs_init() unexpectedly re-called\n"
kernel_L.str.8:
	.asciz	"[kernel:] Failed allocation for file system metadata\n"
kernel_L.str.9:
	.asciz	"[kernel:] Failed to read superblock\n"
kernel_L.str.10:
	.asciz	"[kernel:] Failed to read directory inode\n"
kernel_L.str.11:
	.asciz	"[kernel:] Failed to read directory file\n"
kernel_L.str.12:
	.asciz	"init.vmx"
kernel_L.str.13:
	.asciz	"[kernel:] No init.vmx found\n"
kernel_L.str.14:
	.asciz	"[kernel:] Failed to run init\n"
