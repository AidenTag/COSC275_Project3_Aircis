	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"kernel.c"
	.globl	insert_process                  # -- Begin function insert_process
	.p2align	2
	.type	insert_process,@function
insert_process:                         # @insert_process
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
kernel_Lpcrel_hi0:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi0)
	lw	a0, 0(a0)
	bnez	a0, kernel_LBB0_2
	j	kernel_LBB0_1
kernel_LBB0_1:
	lw	a0, -12(s0)
kernel_Lpcrel_hi1:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi1)
	sw	a0, 0(a1)
	lw	a0, -12(s0)
	sw	a0, 0(a0)
	lw	a0, -12(s0)
	sw	a0, 4(a0)
	j	kernel_LBB0_3
kernel_LBB0_2:
kernel_Lpcrel_hi2:
	auipc	a0, %pcrel_hi(current_process)
	addi	a1, a0, %pcrel_lo(kernel_Lpcrel_hi2)
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
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end0:
	.size	insert_process, kernel_Lfunc_end0-insert_process
                                        # -- End function
	.globl	remove_process                  # -- Begin function remove_process
	.p2align	2
	.type	remove_process,@function
remove_process:                         # @remove_process
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	bne	a0, a1, kernel_LBB1_2
	j	kernel_LBB1_1
kernel_LBB1_1:
kernel_Lpcrel_hi3:
	auipc	a0, %pcrel_hi(current_process)
	addi	a1, a0, %pcrel_lo(kernel_Lpcrel_hi3)
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
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi4)
	lw	a1, 0(a1)
	bne	a0, a1, kernel_LBB1_4
	j	kernel_LBB1_3
kernel_LBB1_3:
kernel_Lpcrel_hi5:
	auipc	a0, %pcrel_hi(current_process)
	addi	a1, a0, %pcrel_lo(kernel_Lpcrel_hi5)
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
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end1:
	.size	remove_process, kernel_Lfunc_end1-remove_process
                                        # -- End function
	.globl	cpu_scheduler                   # -- Begin function cpu_scheduler
	.p2align	2
	.type	cpu_scheduler,@function
cpu_scheduler:                          # @cpu_scheduler
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	call	quantum_expired
	beqz	a0, kernel_LBB2_2
	j	kernel_LBB2_1
kernel_LBB2_1:
kernel_Lpcrel_hi6:
	auipc	a0, %pcrel_hi(current_process)
	addi	a1, a0, %pcrel_lo(kernel_Lpcrel_hi6)
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
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi7)
	lw	a3, 0(a0)
	lw	a0, 16(a3)
	lw	a1, 20(a3)
	lw	a2, 8(a3)
	lw	a3, 12(a3)
	lw	a4, -12(s0)
	call	userspace_jump
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end2:
	.size	cpu_scheduler, kernel_Lfunc_end2-cpu_scheduler
                                        # -- End function
	.globl	do_noop                         # -- Begin function do_noop
	.p2align	2
	.type	do_noop,@function
do_noop:                                # @do_noop
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
kernel_Lpcrel_hi8:
	auipc	a0, %pcrel_hi(kernel_L.str)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi8)
	call	print
kernel_Lpcrel_hi9:
	auipc	a0, %pcrel_hi(kernel_L.str.1)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi9)
	call	print
kernel_Lpcrel_hi10:
	auipc	a0, %pcrel_hi(kernel_L.str.2)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi10)
	call	print
kernel_Lpcrel_hi11:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi11)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end3:
	.size	do_noop, kernel_Lfunc_end3-do_noop
                                        # -- End function
	.globl	do_exit                         # -- Begin function do_exit
	.p2align	2
	.type	do_exit,@function
do_exit:                                # @do_exit
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
kernel_Lpcrel_hi12:
	auipc	a0, %pcrel_hi(kernel_L.str.3)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi12)
	call	print
kernel_Lpcrel_hi13:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi13)
	sw	a0, -20(s0)                     # 4-byte Folded Spill
	lw	a0, 0(a0)
	lw	a0, 24(a0)
	call	print_dec
kernel_Lpcrel_hi14:
	auipc	a0, %pcrel_hi(kernel_L.str.4)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi14)
	call	print
	lw	a0, -12(s0)
	call	print_dec
kernel_Lpcrel_hi15:
	auipc	a0, %pcrel_hi(kernel_L.str.2)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi15)
	call	print
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lw	a0, 0(a0)
	lw	a0, 8(a0)
	call	mm_deallocate
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lw	a0, 0(a0)
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	call	remove_process
	lw	a0, -16(s0)
	call	deallocate
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end4:
	.size	do_exit, kernel_Lfunc_end4-do_exit
                                        # -- End function
	.globl	do_run                          # -- Begin function do_run
	.p2align	2
	.type	do_run,@function
do_run:                                 # @do_run
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -16(s0)
kernel_Lpcrel_hi16:
	auipc	a0, %pcrel_hi(kernel_L.str.5)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi16)
	call	print
	#APP
	ebreak
	#NO_APP
	lw	a0, -16(s0)
	call	print
kernel_Lpcrel_hi17:
	auipc	a0, %pcrel_hi(kernel_L.str.2)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi17)
	call	print
kernel_Lpcrel_hi18:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi18)
	lw	a0, 0(a0)
	beqz	a0, kernel_LBB5_2
	j	kernel_LBB5_1
kernel_LBB5_1:
kernel_Lpcrel_hi19:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi19)
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
	lw	a0, -28(s0)
	lui	a1, 16
	sw	a1, 20(a0)
kernel_Lpcrel_hi20:
	auipc	a0, %pcrel_hi(next_process_ID)
	addi	a3, a0, %pcrel_lo(kernel_Lpcrel_hi20)
	lw	a0, 0(a3)
	addi	a2, a0, 1
	sw	a2, 0(a3)
	lw	a2, -28(s0)
	sw	a0, 24(a2)
	lw	a0, -20(s0)
	lw	a2, -28(s0)
	sw	a0, 8(a2)
	lw	a0, -20(s0)
	add	a0, a0, a1
	lw	a1, -28(s0)
	sw	a0, 12(a1)
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
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end5:
	.size	do_run, kernel_Lfunc_end5-do_run
                                        # -- End function
	.globl	do_print                        # -- Begin function do_print
	.p2align	2
	.type	do_print,@function
do_print:                               # @do_print
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -16(s0)
	lw	a0, -16(s0)
kernel_Lpcrel_hi21:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi21)
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
	auipc	a0, %pcrel_hi(kernel_L.str.2)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi22)
	call	print
kernel_Lpcrel_hi23:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi23)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB6_3
kernel_LBB6_3:
	lw	a0, -12(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end6:
	.size	do_print, kernel_Lfunc_end6-do_print
                                        # -- End function
	.globl	getlength                       # -- Begin function getlength
	.p2align	2
	.type	getlength,@function
getlength:                              # @getlength
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -16(s0)
	lw	a0, -16(s0)
kernel_Lpcrel_hi24:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi24)
	lw	a2, 0(a1)
	lw	a2, 8(a2)
	add	a0, a0, a2
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a1, 0(a1)
	lw	a1, 12(a1)
	bltu	a0, a1, kernel_LBB7_2
	j	kernel_LBB7_1
kernel_LBB7_1:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_2:
	lw	a0, -20(s0)
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	bnez	a0, kernel_LBB7_4
	j	kernel_LBB7_3
kernel_LBB7_3:
kernel_Lpcrel_hi25:
	auipc	a0, %pcrel_hi(directory_inode)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi25)
	lw	a0, 0(a0)
	lw	a0, 0(a0)
	srli	a0, a0, 6
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_4:
	lw	a0, -16(s0)
	li	a1, 61
	sw	a1, -36(s0)                     # 4-byte Folded Spill
	call	string_length
	lw	a1, -36(s0)                     # 4-byte Folded Reload
	blt	a0, a1, kernel_LBB7_6
	j	kernel_LBB7_5
kernel_LBB7_5:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_6:
	lw	a0, -16(s0)
	call	search_directory
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, kernel_LBB7_8
	j	kernel_LBB7_7
kernel_LBB7_7:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_8:
	lui	a0, 1
	call	allocate
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB7_10
	j	kernel_LBB7_9
kernel_LBB7_9:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_10:
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB7_12
	j	kernel_LBB7_11
kernel_LBB7_11:
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_12:
	lw	a0, -28(s0)
	lw	a0, 0(a0)
	sw	a0, -32(s0)
	lw	a0, -28(s0)
	call	deallocate
	li	a0, 0
	sw	a0, -28(s0)
kernel_Lpcrel_hi26:
	auipc	a0, %pcrel_hi(kernel_L.str.6)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi26)
	call	print
	lw	a0, -16(s0)
	call	print
kernel_Lpcrel_hi27:
	auipc	a0, %pcrel_hi(kernel_L.str.7)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi27)
	call	print
	lw	a0, -32(s0)
	call	print_dec
kernel_Lpcrel_hi28:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi28)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -32(s0)
	sw	a0, -12(s0)
	j	kernel_LBB7_13
kernel_LBB7_13:
	lw	a0, -12(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end7:
	.size	getlength, kernel_Lfunc_end7-getlength
                                        # -- End function
	.globl	getdir                          # -- Begin function getdir
	.p2align	2
	.type	getdir,@function
getdir:                                 # @getdir
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	bnez	a0, kernel_LBB8_2
	j	kernel_LBB8_1
kernel_LBB8_1:
	j	kernel_LBB8_7
kernel_LBB8_2:
kernel_Lpcrel_hi29:
	auipc	a0, %pcrel_hi(directory_inode)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi29)
	lw	a0, 0(a0)
	lw	a0, 0(a0)
	srli	a0, a0, 6
	sw	a0, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	kernel_LBB8_3
kernel_LBB8_3:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	lw	a1, -16(s0)
	bge	a0, a1, kernel_LBB8_6
	j	kernel_LBB8_4
kernel_LBB8_4:                                #   in Loop: Header=BB8_3 Depth=1
	lw	a0, -12(s0)
	lw	a2, -20(s0)
	slli	a1, a2, 2
	slli	a2, a2, 6
	sub	a1, a2, a1
	add	a0, a0, a1
kernel_Lpcrel_hi30:
	auipc	a1, %pcrel_hi(directory_entries)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi30)
	lw	a1, 0(a1)
	add	a1, a1, a2
	addi	a1, a1, 4
	li	a2, 60
	call	string_copy
	j	kernel_LBB8_5
kernel_LBB8_5:                                #   in Loop: Header=BB8_3 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	kernel_LBB8_3
kernel_LBB8_6:
kernel_Lpcrel_hi31:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi31)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	call	print_array
	j	kernel_LBB8_7
kernel_LBB8_7:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end8:
	.size	getdir, kernel_Lfunc_end8-getdir
                                        # -- End function
	.globl	read                            # -- Begin function read
	.p2align	2
	.type	read,@function
read:                                   # @read
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	sw	a3, -28(s0)
kernel_Lpcrel_hi32:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi32)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -16(s0)
	bnez	a0, kernel_LBB9_2
	j	kernel_LBB9_1
kernel_LBB9_1:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_2:
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB9_4
	j	kernel_LBB9_3
kernel_LBB9_3:
	li	a0, -4
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_4:
	lw	a0, -16(s0)
kernel_Lpcrel_hi33:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi33)
	lw	a2, 0(a1)
	lw	a2, 8(a2)
	add	a0, a0, a2
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, 0(a1)
	lw	a1, 12(a1)
	bltu	a0, a1, kernel_LBB9_6
	j	kernel_LBB9_5
kernel_LBB9_5:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_6:
	lw	a0, -32(s0)
	sw	a0, -16(s0)
	lw	a0, -28(s0)
kernel_Lpcrel_hi34:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi34)
	lw	a2, 0(a1)
	lw	a2, 8(a2)
	add	a0, a0, a2
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	lw	a1, 0(a1)
	lw	a1, 12(a1)
	bltu	a0, a1, kernel_LBB9_8
	j	kernel_LBB9_7
kernel_LBB9_7:
	li	a0, -4
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_8:
	lw	a0, -36(s0)
	sw	a0, -28(s0)
	lw	a0, -16(s0)
	li	a1, 61
	sw	a1, -60(s0)                     # 4-byte Folded Spill
	call	string_length
	lw	a1, -60(s0)                     # 4-byte Folded Reload
	blt	a0, a1, kernel_LBB9_10
	j	kernel_LBB9_9
kernel_LBB9_9:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_10:
	lw	a0, -16(s0)
	call	search_directory
	sw	a0, -40(s0)
	lw	a0, -40(s0)
	bnez	a0, kernel_LBB9_12
	j	kernel_LBB9_11
kernel_LBB9_11:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_12:
	lui	a0, 1
	call	allocate
	sw	a0, -44(s0)
	lw	a0, -44(s0)
	bnez	a0, kernel_LBB9_14
	j	kernel_LBB9_13
kernel_LBB9_13:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_14:
	lw	a0, -40(s0)
	lw	a1, -44(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB9_16
	j	kernel_LBB9_15
kernel_LBB9_15:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_16:
	lw	a0, -44(s0)
	lw	a0, 0(a0)
	sw	a0, -48(s0)
	lw	a0, -20(s0)
	bltz	a0, kernel_LBB9_19
	j	kernel_LBB9_17
kernel_LBB9_17:
	lw	a0, -24(s0)
	bltz	a0, kernel_LBB9_19
	j	kernel_LBB9_18
kernel_LBB9_18:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	lw	a0, -48(s0)
	bge	a0, a1, kernel_LBB9_20
	j	kernel_LBB9_19
kernel_LBB9_19:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -3
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_20:
	lw	a0, -48(s0)
	lui	a1, 1
	addi	a1, a1, -1
	add	a0, a0, a1
	srai	a1, a0, 31
	srli	a1, a1, 20
	add	a0, a0, a1
	srai	a0, a0, 12
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	slli	a0, a0, 12
	call	allocate
	sw	a0, -56(s0)
	lw	a0, -56(s0)
	bnez	a0, kernel_LBB9_22
	j	kernel_LBB9_21
kernel_LBB9_21:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_22:
	lw	a0, -56(s0)
	lw	a1, -44(s0)
	lw	a2, -48(s0)
	call	read_inode_to_buffer
	bgez	a0, kernel_LBB9_24
	j	kernel_LBB9_23
kernel_LBB9_23:
	lw	a0, -56(s0)
	call	deallocate
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_24:
	lw	a0, -56(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
kernel_Lpcrel_hi35:
	auipc	a1, %pcrel_hi(DMA_portal_ptr)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi35)
	lw	a2, 0(a1)
	sw	a0, 0(a2)
	lw	a0, -28(s0)
	lw	a2, 0(a1)
	sw	a0, 4(a2)
	lw	a0, -24(s0)
	lw	a1, 0(a1)
	sw	a0, 8(a1)
	lw	a0, -56(s0)
	call	deallocate
	lw	a0, -44(s0)
	call	deallocate
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	j	kernel_LBB9_25
kernel_LBB9_25:
	lw	a0, -12(s0)
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
kernel_Lfunc_end9:
	.size	read, kernel_Lfunc_end9-read
                                        # -- End function
	.globl	write                           # -- Begin function write
	.p2align	2
	.type	write,@function
write:                                  # @write
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 96
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	sw	a3, -28(s0)
kernel_Lpcrel_hi36:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi36)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -16(s0)
	bnez	a0, kernel_LBB10_2
	j	kernel_LBB10_1
kernel_LBB10_1:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_2:
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB10_4
	j	kernel_LBB10_3
kernel_LBB10_3:
	li	a0, -4
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_4:
	lw	a0, -16(s0)
kernel_Lpcrel_hi37:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi37)
	lw	a2, 0(a1)
	lw	a2, 8(a2)
	add	a0, a0, a2
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, 0(a1)
	lw	a1, 12(a1)
	bltu	a0, a1, kernel_LBB10_6
	j	kernel_LBB10_5
kernel_LBB10_5:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_6:
	lw	a0, -32(s0)
	sw	a0, -16(s0)
	lw	a0, -28(s0)
kernel_Lpcrel_hi38:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi38)
	lw	a2, 0(a1)
	lw	a2, 8(a2)
	add	a0, a0, a2
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	lw	a1, 0(a1)
	lw	a1, 12(a1)
	bltu	a0, a1, kernel_LBB10_8
	j	kernel_LBB10_7
kernel_LBB10_7:
	li	a0, -4
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_8:
	lw	a0, -36(s0)
	sw	a0, -28(s0)
	lw	a0, -16(s0)
	li	a1, 61
	sw	a1, -84(s0)                     # 4-byte Folded Spill
	call	string_length
	lw	a1, -84(s0)                     # 4-byte Folded Reload
	blt	a0, a1, kernel_LBB10_10
	j	kernel_LBB10_9
kernel_LBB10_9:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_10:
	lw	a0, -16(s0)
	call	search_directory
	sw	a0, -40(s0)
	lw	a0, -40(s0)
	bnez	a0, kernel_LBB10_12
	j	kernel_LBB10_11
kernel_LBB10_11:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_12:
	lui	a0, 1
	call	allocate
	sw	a0, -44(s0)
	lw	a0, -44(s0)
	bnez	a0, kernel_LBB10_14
	j	kernel_LBB10_13
kernel_LBB10_13:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_14:
	lw	a0, -40(s0)
	lw	a1, -44(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB10_16
	j	kernel_LBB10_15
kernel_LBB10_15:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_16:
	lw	a0, -44(s0)
	lw	a0, 0(a0)
	sw	a0, -48(s0)
	lw	a0, -20(s0)
	bltz	a0, kernel_LBB10_18
	j	kernel_LBB10_17
kernel_LBB10_17:
	lw	a0, -24(s0)
	bgez	a0, kernel_LBB10_19
	j	kernel_LBB10_18
kernel_LBB10_18:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -3
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_19:
	lw	a0, -48(s0)
	lui	a1, 1
	addi	a1, a1, -1
	add	a0, a0, a1
	srai	a1, a0, 31
	srli	a1, a1, 20
	add	a0, a0, a1
	srai	a0, a0, 12
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	slli	a0, a0, 12
	call	allocate
	sw	a0, -56(s0)
	lw	a0, -56(s0)
	bnez	a0, kernel_LBB10_21
	j	kernel_LBB10_20
kernel_LBB10_20:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_21:
	lw	a0, -56(s0)
	lw	a1, -44(s0)
	lw	a2, -48(s0)
	call	read_inode_to_buffer
	bgez	a0, kernel_LBB10_23
	j	kernel_LBB10_22
kernel_LBB10_22:
	lw	a0, -56(s0)
	call	deallocate
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_23:
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	lw	a0, -48(s0)
	bge	a0, a1, kernel_LBB10_38
	j	kernel_LBB10_24
kernel_LBB10_24:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	lui	a0, 1
	addi	a2, a0, -1
	add	a1, a1, a2
	srai	a2, a1, 31
	srli	a2, a2, 20
	add	a1, a1, a2
	srai	a1, a1, 12
	lw	a2, -52(s0)
	sub	a1, a1, a2
	sw	a1, -60(s0)
	lw	a1, -20(s0)
	lw	a2, -24(s0)
	add	a1, a1, a2
	sw	a1, -48(s0)
	lw	a1, -48(s0)
	lw	a2, -44(s0)
	sw	a1, 0(a2)
kernel_Lpcrel_hi39:
	auipc	a1, %pcrel_hi(superblock)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi39)
	lw	a1, 0(a1)
	lw	a1, 8(a1)
	sw	a1, -64(s0)
	call	allocate
	sw	a0, -68(s0)
	lw	a0, -68(s0)
	bnez	a0, kernel_LBB10_26
	j	kernel_LBB10_25
kernel_LBB10_25:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_26:
	lw	a0, -64(s0)
	lw	a1, -68(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB10_28
	j	kernel_LBB10_27
kernel_LBB10_27:
	lw	a0, -44(s0)
	call	deallocate
	lw	a0, -68(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_28:
	li	a0, 0
	sw	a0, -72(s0)
	j	kernel_LBB10_29
kernel_LBB10_29:                              # =>This Inner Loop Header: Depth=1
	lw	a0, -72(s0)
	lw	a1, -60(s0)
	bge	a0, a1, kernel_LBB10_35
	j	kernel_LBB10_30
kernel_LBB10_30:                              #   in Loop: Header=BB10_29 Depth=1
kernel_Lpcrel_hi40:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi40)
	lw	a0, 0(a0)
	lw	a1, -68(s0)
	call	alloc_block
	sw	a0, -76(s0)
	lw	a0, -76(s0)
	bnez	a0, kernel_LBB10_32
	j	kernel_LBB10_31
kernel_LBB10_31:
	lw	a0, -44(s0)
	call	deallocate
	lw	a0, -68(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_32:                              #   in Loop: Header=BB10_29 Depth=1
	lw	a0, -76(s0)
	lw	a1, -44(s0)
	lw	a2, -52(s0)
	lw	a3, -72(s0)
	add	a2, a2, a3
	slli	a2, a2, 2
	add	a1, a1, a2
	sw	a0, 32(a1)
	j	kernel_LBB10_33
kernel_LBB10_33:                              #   in Loop: Header=BB10_29 Depth=1
	j	kernel_LBB10_34
kernel_LBB10_34:                              #   in Loop: Header=BB10_29 Depth=1
	lw	a0, -72(s0)
	addi	a0, a0, 1
	sw	a0, -72(s0)
	j	kernel_LBB10_29
kernel_LBB10_35:
	lw	a0, -64(s0)
	lw	a1, -68(s0)
	call	bd_write_block
	bgez	a0, kernel_LBB10_37
	j	kernel_LBB10_36
kernel_LBB10_36:
	lw	a0, -44(s0)
	call	deallocate
	lw	a0, -68(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_37:
	lw	a0, -68(s0)
	call	deallocate
	lw	a0, -48(s0)
	lui	a1, 1
	addi	a1, a1, -1
	add	a0, a0, a1
	srai	a1, a0, 31
	srli	a1, a1, 20
	add	a0, a0, a1
	srai	a0, a0, 12
	sw	a0, -52(s0)
	j	kernel_LBB10_38
kernel_LBB10_38:
	lw	a0, -28(s0)
kernel_Lpcrel_hi41:
	auipc	a1, %pcrel_hi(DMA_portal_ptr)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi41)
	lw	a2, 0(a1)
	sw	a0, 0(a2)
	lw	a0, -56(s0)
	lw	a2, -20(s0)
	add	a0, a0, a2
	lw	a2, 0(a1)
	sw	a0, 4(a2)
	lw	a0, -24(s0)
	lw	a1, 0(a1)
	sw	a0, 8(a1)
	li	a0, 0
	sw	a0, -80(s0)
	j	kernel_LBB10_39
kernel_LBB10_39:                              # =>This Inner Loop Header: Depth=1
	lw	a0, -80(s0)
	lw	a1, -52(s0)
	bge	a0, a1, kernel_LBB10_44
	j	kernel_LBB10_40
kernel_LBB10_40:                              #   in Loop: Header=BB10_39 Depth=1
	lw	a0, -44(s0)
	lw	a2, -80(s0)
	slli	a1, a2, 2
	add	a0, a0, a1
	lw	a0, 32(a0)
	lw	a1, -56(s0)
	slli	a2, a2, 12
	add	a1, a1, a2
	call	bd_write_block
	bgez	a0, kernel_LBB10_42
	j	kernel_LBB10_41
kernel_LBB10_41:
	lw	a0, -56(s0)
	call	deallocate
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_42:                              #   in Loop: Header=BB10_39 Depth=1
	j	kernel_LBB10_43
kernel_LBB10_43:                              #   in Loop: Header=BB10_39 Depth=1
	lw	a0, -80(s0)
	addi	a0, a0, 1
	sw	a0, -80(s0)
	j	kernel_LBB10_39
kernel_LBB10_44:
	lw	a0, -40(s0)
	lw	a1, -44(s0)
	call	bd_write_block
	bgez	a0, kernel_LBB10_46
	j	kernel_LBB10_45
kernel_LBB10_45:
	lw	a0, -44(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_46:
	lw	a0, -56(s0)
	call	deallocate
	lw	a0, -44(s0)
	call	deallocate
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	j	kernel_LBB10_47
kernel_LBB10_47:
	lw	a0, -12(s0)
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
kernel_Lfunc_end10:
	.size	write, kernel_Lfunc_end10-write
                                        # -- End function
	.globl	create                          # -- Begin function create
	.p2align	2
	.type	create,@function
create:                                 # @create
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	sw	a0, -16(s0)
kernel_Lpcrel_hi42:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi42)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -16(s0)
	bnez	a0, kernel_LBB11_2
	j	kernel_LBB11_1
kernel_LBB11_1:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_2:
	lw	a0, -16(s0)
kernel_Lpcrel_hi43:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi43)
	lw	a2, 0(a1)
	lw	a2, 8(a2)
	add	a0, a0, a2
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a1, 0(a1)
	lw	a1, 12(a1)
	bltu	a0, a1, kernel_LBB11_4
	j	kernel_LBB11_3
kernel_LBB11_3:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_4:
	lw	a0, -20(s0)
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	li	a1, 61
	sw	a1, -48(s0)                     # 4-byte Folded Spill
	call	string_length
	lw	a1, -48(s0)                     # 4-byte Folded Reload
	blt	a0, a1, kernel_LBB11_6
	j	kernel_LBB11_5
kernel_LBB11_5:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_6:
	lw	a0, -16(s0)
	call	search_directory
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	beqz	a0, kernel_LBB11_8
	j	kernel_LBB11_7
kernel_LBB11_7:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_8:
	lui	a0, 1
	call	allocate
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB11_10
	j	kernel_LBB11_9
kernel_LBB11_9:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_10:
	lui	a0, 1
	call	allocate
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	bnez	a0, kernel_LBB11_12
	j	kernel_LBB11_11
kernel_LBB11_11:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_12:
	lw	a1, -32(s0)
	li	a0, 0
	sw	a0, 0(a1)
	lw	a1, -32(s0)
	li	a0, 1
	sw	a0, 4(a1)
kernel_Lpcrel_hi44:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi44)
	lw	a0, 0(a0)
	lw	a0, 8(a0)
	sw	a0, -36(s0)
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB11_14
	j	kernel_LBB11_13
kernel_LBB11_13:
	lw	a0, -32(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_14:
	lw	a0, -36(s0)
	lw	a1, -28(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB11_16
	j	kernel_LBB11_15
kernel_LBB11_15:
	lw	a0, -32(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_16:
kernel_Lpcrel_hi45:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi45)
	lw	a0, 0(a0)
	lw	a1, -28(s0)
	call	alloc_block
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, kernel_LBB11_18
	j	kernel_LBB11_17
kernel_LBB11_17:
	lw	a0, -32(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_18:
kernel_Lpcrel_hi46:
	auipc	a0, %pcrel_hi(directory_inode)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi46)
	sw	a0, -52(s0)                     # 4-byte Folded Spill
	lw	a0, 0(a0)
	lw	a0, 0(a0)
	srli	a0, a0, 6
	sw	a0, -40(s0)
kernel_Lpcrel_hi47:
	auipc	a0, %pcrel_hi(directory_entries)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi47)
	lw	a0, 0(a0)
	lw	a1, -40(s0)
	slli	a1, a1, 6
	add	a0, a0, a1
	sw	a0, -44(s0)
	lw	a0, -24(s0)
	lw	a1, -44(s0)
	sw	a0, 0(a1)
	lw	a0, -44(s0)
	addi	a0, a0, 4
	lw	a1, -16(s0)
	li	a2, 60
	call	string_copy
                                        # kill: def $x11 killed $x10
	lw	a0, -52(s0)                     # 4-byte Folded Reload
	lw	a1, 0(a0)
	lw	a0, 0(a1)
	addi	a0, a0, 64
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lw	a1, -32(s0)
	call	bd_write_block
	bgez	a0, kernel_LBB11_20
	j	kernel_LBB11_19
kernel_LBB11_19:
	lw	a0, -32(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_20:
	lw	a0, -36(s0)
	lw	a1, -28(s0)
	call	bd_write_block
	bgez	a0, kernel_LBB11_22
	j	kernel_LBB11_21
kernel_LBB11_21:
	lw	a0, -32(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_22:
kernel_Lpcrel_hi48:
	auipc	a0, %pcrel_hi(kernel_L.str.8)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi48)
	call	print
	lw	a0, -16(s0)
	call	search_directory
	bnez	a0, kernel_LBB11_24
	j	kernel_LBB11_23
kernel_LBB11_23:
kernel_Lpcrel_hi49:
	auipc	a0, %pcrel_hi(kernel_L.str.9)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi49)
	call	print
	lw	a0, -32(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_24:
	lw	a0, -32(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB11_25
kernel_LBB11_25:
	lw	a0, -12(s0)
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
kernel_Lfunc_end11:
	.size	create, kernel_Lfunc_end11-create
                                        # -- End function
	.globl	find_and_delete_dir_entry       # -- Begin function find_and_delete_dir_entry
	.p2align	2
	.type	find_and_delete_dir_entry,@function
find_and_delete_dir_entry:              # @find_and_delete_dir_entry
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -16(s0)
kernel_Lpcrel_hi50:
	auipc	a0, %pcrel_hi(directory_inode)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi50)
	lw	a0, 0(a0)
	lw	a0, 0(a0)
	srli	a0, a0, 6
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	kernel_LBB12_1
kernel_LBB12_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	bge	a0, a1, kernel_LBB12_6
	j	kernel_LBB12_2
kernel_LBB12_2:                               #   in Loop: Header=BB12_1 Depth=1
kernel_Lpcrel_hi51:
	auipc	a0, %pcrel_hi(directory_entries)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi51)
	lw	a0, 0(a0)
	lw	a1, -24(s0)
	slli	a1, a1, 6
	add	a0, a0, a1
	addi	a0, a0, 4
	lw	a1, -16(s0)
	li	a2, 60
	call	string_compare
	bnez	a0, kernel_LBB12_4
	j	kernel_LBB12_3
kernel_LBB12_3:
kernel_Lpcrel_hi52:
	auipc	a0, %pcrel_hi(directory_entries)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi52)
	lw	a2, 0(a0)
	lw	a1, -20(s0)
	slli	a1, a1, 6
	add	a1, a1, a2
	lw	a1, -64(a1)
	lw	a3, -24(s0)
	slli	a3, a3, 6
	add	a2, a2, a3
	sw	a1, 0(a2)
	lw	a2, 0(a0)
	lw	a0, -24(s0)
	slli	a0, a0, 6
	add	a0, a2, a0
	addi	a0, a0, 4
	lw	a1, -20(s0)
	slli	a1, a1, 6
	add	a1, a1, a2
	addi	a1, a1, -60
	li	a2, 60
	call	string_copy
kernel_Lpcrel_hi53:
	auipc	a0, %pcrel_hi(directory_inode)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi53)
	lw	a1, 0(a0)
	lw	a0, 0(a1)
	addi	a0, a0, -64
	sw	a0, 0(a1)
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB12_7
kernel_LBB12_4:                               #   in Loop: Header=BB12_1 Depth=1
	j	kernel_LBB12_5
kernel_LBB12_5:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	kernel_LBB12_1
kernel_LBB12_6:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB12_7
kernel_LBB12_7:
	lw	a0, -12(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end12:
	.size	find_and_delete_dir_entry, kernel_Lfunc_end12-find_and_delete_dir_entry
                                        # -- End function
	.globl	delete                          # -- Begin function delete
	.p2align	2
	.type	delete,@function
delete:                                 # @delete
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -16(s0)
kernel_Lpcrel_hi54:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi54)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -16(s0)
	beqz	a0, kernel_LBB13_2
	j	kernel_LBB13_1
kernel_LBB13_1:
	lw	a0, -16(s0)
	li	a1, 61
	sw	a1, -44(s0)                     # 4-byte Folded Spill
	call	string_length
	lw	a1, -44(s0)                     # 4-byte Folded Reload
	blt	a0, a1, kernel_LBB13_3
	j	kernel_LBB13_2
kernel_LBB13_2:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_3:
	lw	a0, -16(s0)
	call	search_directory
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	bnez	a0, kernel_LBB13_5
	j	kernel_LBB13_4
kernel_LBB13_4:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_5:
	lui	a0, 1
	call	allocate
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, kernel_LBB13_7
	j	kernel_LBB13_6
kernel_LBB13_6:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_7:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB13_9
	j	kernel_LBB13_8
kernel_LBB13_8:
	lw	a0, -24(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_9:
	lui	a0, 1
	call	allocate
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB13_11
	j	kernel_LBB13_10
kernel_LBB13_10:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_11:
kernel_Lpcrel_hi55:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi55)
	lw	a0, 0(a0)
	lw	a0, 8(a0)
	sw	a0, -32(s0)
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB13_13
	j	kernel_LBB13_12
kernel_LBB13_12:
	lw	a0, -24(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_13:
	lw	a0, -32(s0)
	lw	a1, -28(s0)
	call	bd_read_block
	bgez	a0, kernel_LBB13_15
	j	kernel_LBB13_14
kernel_LBB13_14:
	lw	a0, -24(s0)
	call	deallocate
	lw	a0, -28(s0)
	call	deallocate
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_15:
	lw	a0, -24(s0)
	lw	a0, 0(a0)
	lui	a1, 1
	addi	a1, a1, -1
	add	a0, a0, a1
	srli	a0, a0, 12
	sw	a0, -36(s0)
	li	a0, 0
	sw	a0, -40(s0)
	j	kernel_LBB13_16
kernel_LBB13_16:                              # =>This Inner Loop Header: Depth=1
	lw	a0, -40(s0)
	lw	a1, -36(s0)
	bge	a0, a1, kernel_LBB13_19
	j	kernel_LBB13_17
kernel_LBB13_17:                              #   in Loop: Header=BB13_16 Depth=1
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	lw	a2, -40(s0)
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 32(a1)
	call	mark_free
	j	kernel_LBB13_18
kernel_LBB13_18:                              #   in Loop: Header=BB13_16 Depth=1
	lw	a0, -40(s0)
	addi	a0, a0, 1
	sw	a0, -40(s0)
	j	kernel_LBB13_16
kernel_LBB13_19:
	lw	a0, -16(s0)
	call	find_and_delete_dir_entry
	beqz	a0, kernel_LBB13_21
	j	kernel_LBB13_20
kernel_LBB13_20:
	li	a0, -5
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_21:
	lw	a0, -28(s0)
	lw	a1, -20(s0)
	call	mark_free
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB13_22
kernel_LBB13_22:
	lw	a0, -12(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end13:
	.size	delete, kernel_Lfunc_end13-delete
                                        # -- End function
	.globl	rename                          # -- Begin function rename
	.p2align	2
	.type	rename,@function
rename:                                 # @rename
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -16(s0)
	sw	a1, -20(s0)
kernel_Lpcrel_hi56:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi56)
	lw	a1, 0(a0)
	lw	a0, 16(a1)
	addi	a0, a0, 4
	sw	a0, 16(a1)
	lw	a0, -20(s0)
	beqz	a0, kernel_LBB14_4
	j	kernel_LBB14_1
kernel_LBB14_1:
	lw	a0, -20(s0)
	li	a1, 61
	call	string_length
	mv	a1, a0
	li	a0, 60
	blt	a0, a1, kernel_LBB14_4
	j	kernel_LBB14_2
kernel_LBB14_2:
	lw	a0, -16(s0)
	beqz	a0, kernel_LBB14_4
	j	kernel_LBB14_3
kernel_LBB14_3:
	lw	a0, -16(s0)
	li	a1, 61
	sw	a1, -36(s0)                     # 4-byte Folded Spill
	call	string_length
	lw	a1, -36(s0)                     # 4-byte Folded Reload
	blt	a0, a1, kernel_LBB14_5
	j	kernel_LBB14_4
kernel_LBB14_4:
	li	a0, -1
	sw	a0, -12(s0)
	j	kernel_LBB14_17
kernel_LBB14_5:
	lw	a0, -16(s0)
	call	search_directory
	bnez	a0, kernel_LBB14_7
	j	kernel_LBB14_6
kernel_LBB14_6:
	li	a0, -2
	sw	a0, -12(s0)
	j	kernel_LBB14_17
kernel_LBB14_7:
	lw	a0, -20(s0)
	call	search_directory
	beqz	a0, kernel_LBB14_9
	j	kernel_LBB14_8
kernel_LBB14_8:
	li	a0, -3
	sw	a0, -12(s0)
	j	kernel_LBB14_17
kernel_LBB14_9:
kernel_Lpcrel_hi57:
	auipc	a0, %pcrel_hi(directory_inode)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi57)
	lw	a0, 0(a0)
	lw	a0, 0(a0)
	srli	a0, a0, 6
	sw	a0, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	kernel_LBB14_10
kernel_LBB14_10:                              # =>This Inner Loop Header: Depth=1
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bge	a0, a1, kernel_LBB14_16
	j	kernel_LBB14_11
kernel_LBB14_11:                              #   in Loop: Header=BB14_10 Depth=1
kernel_Lpcrel_hi58:
	auipc	a0, %pcrel_hi(directory_entries)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi58)
	lw	a0, 0(a0)
	lw	a1, -28(s0)
	slli	a1, a1, 6
	add	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a0, 0(a0)
	beqz	a0, kernel_LBB14_14
	j	kernel_LBB14_12
kernel_LBB14_12:                              #   in Loop: Header=BB14_10 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 4
	lw	a1, -16(s0)
	li	a2, 60
	call	string_compare
	bnez	a0, kernel_LBB14_14
	j	kernel_LBB14_13
kernel_LBB14_13:                              #   in Loop: Header=BB14_10 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 4
	lw	a1, -20(s0)
	li	a2, 60
	call	string_copy
	j	kernel_LBB14_14
kernel_LBB14_14:                              #   in Loop: Header=BB14_10 Depth=1
	j	kernel_LBB14_15
kernel_LBB14_15:                              #   in Loop: Header=BB14_10 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	kernel_LBB14_10
kernel_LBB14_16:
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB14_17
kernel_LBB14_17:
	lw	a0, -12(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end14:
	.size	rename, kernel_Lfunc_end14-rename
                                        # -- End function
	.globl	do_syscall                      # -- Begin function do_syscall
	.p2align	2
	.type	do_syscall,@function
do_syscall:                             # @do_syscall
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	sw	a5, -32(s0)
kernel_Lpcrel_hi59:
	auipc	a0, %pcrel_hi(preserved_epc)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi59)
	lw	a0, 0(a0)
kernel_Lpcrel_hi60:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi60)
	lw	a2, 0(a1)
	sw	a0, 16(a2)
kernel_Lpcrel_hi61:
	auipc	a0, %pcrel_hi(preserved_sp)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi61)
	lw	a0, 0(a0)
	lw	a1, 0(a1)
	sw	a0, 20(a1)
	li	a0, 0
	sb	a0, -33(s0)
	sw	a0, -40(s0)
	lw	a0, -12(s0)
	lui	a1, 827664
	bne	a0, a1, kernel_LBB15_2
	j	kernel_LBB15_1
kernel_LBB15_1:
	call	do_noop
	j	kernel_LBB15_35
kernel_LBB15_2:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 1
	bne	a0, a1, kernel_LBB15_6
	j	kernel_LBB15_3
kernel_LBB15_3:
	lw	a0, -16(s0)
	call	do_exit
kernel_Lpcrel_hi62:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi62)
	lw	a0, 0(a0)
	bnez	a0, kernel_LBB15_5
	j	kernel_LBB15_4
kernel_LBB15_4:
kernel_Lpcrel_hi63:
	auipc	a0, %pcrel_hi(kernel_L.str.10)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi63)
	call	print
	call	halt_kernel
	j	kernel_LBB15_5
kernel_LBB15_5:
	j	kernel_LBB15_34
kernel_LBB15_6:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 3
	bne	a0, a1, kernel_LBB15_8
	j	kernel_LBB15_7
kernel_LBB15_7:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	call	do_run
	sw	a0, -40(s0)
	j	kernel_LBB15_33
kernel_LBB15_8:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 2
	bne	a0, a1, kernel_LBB15_10
	j	kernel_LBB15_9
kernel_LBB15_9:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	call	do_print
	sw	a0, -40(s0)
	j	kernel_LBB15_32
kernel_LBB15_10:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 4
	bne	a0, a1, kernel_LBB15_12
	j	kernel_LBB15_11
kernel_LBB15_11:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	call	getlength
	sw	a0, -40(s0)
	j	kernel_LBB15_31
kernel_LBB15_12:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 5
	bne	a0, a1, kernel_LBB15_14
	j	kernel_LBB15_13
kernel_LBB15_13:
	lw	a0, -16(s0)
	call	getdir
	j	kernel_LBB15_30
kernel_LBB15_14:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 6
	bne	a0, a1, kernel_LBB15_16
	j	kernel_LBB15_15
kernel_LBB15_15:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	lw	a2, -24(s0)
	lw	a3, -28(s0)
	call	read
	sw	a0, -40(s0)
	j	kernel_LBB15_29
kernel_LBB15_16:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 7
	bne	a0, a1, kernel_LBB15_18
	j	kernel_LBB15_17
kernel_LBB15_17:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	lw	a2, -24(s0)
	lw	a3, -28(s0)
	call	write
	sw	a0, -40(s0)
	j	kernel_LBB15_28
kernel_LBB15_18:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 8
	bne	a0, a1, kernel_LBB15_20
	j	kernel_LBB15_19
kernel_LBB15_19:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	call	create
	sw	a0, -40(s0)
	j	kernel_LBB15_27
kernel_LBB15_20:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 9
	bne	a0, a1, kernel_LBB15_22
	j	kernel_LBB15_21
kernel_LBB15_21:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	call	delete
	sw	a0, -40(s0)
	j	kernel_LBB15_26
kernel_LBB15_22:
	lw	a0, -12(s0)
	lui	a1, 827664
	addi	a1, a1, 10
	bne	a0, a1, kernel_LBB15_24
	j	kernel_LBB15_23
kernel_LBB15_23:
	li	a0, 1
	sb	a0, -33(s0)
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	call	rename
	sw	a0, -40(s0)
	j	kernel_LBB15_25
kernel_LBB15_24:
	li	a0, -1
	sw	a0, -40(s0)
	j	kernel_LBB15_25
kernel_LBB15_25:
	j	kernel_LBB15_26
kernel_LBB15_26:
	j	kernel_LBB15_27
kernel_LBB15_27:
	j	kernel_LBB15_28
kernel_LBB15_28:
	j	kernel_LBB15_29
kernel_LBB15_29:
	j	kernel_LBB15_30
kernel_LBB15_30:
	j	kernel_LBB15_31
kernel_LBB15_31:
	j	kernel_LBB15_32
kernel_LBB15_32:
	j	kernel_LBB15_33
kernel_LBB15_33:
	j	kernel_LBB15_34
kernel_LBB15_34:
	j	kernel_LBB15_35
kernel_LBB15_35:
	lbu	a0, -33(s0)
	andi	a0, a0, 1
	beqz	a0, kernel_LBB15_37
	j	kernel_LBB15_36
kernel_LBB15_36:
kernel_Lpcrel_hi64:
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi64)
	lw	a1, 0(a0)
	lw	a0, 8(a1)
	lw	a1, 20(a1)
	add	a0, a0, a1
	addi	a0, a0, -36
	sw	a0, -44(s0)
	lw	a0, -40(s0)
	lw	a1, -44(s0)
	sw	a0, 0(a1)
	j	kernel_LBB15_37
kernel_LBB15_37:
	call	cpu_scheduler
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end15:
	.size	do_syscall, kernel_Lfunc_end15-do_syscall
                                        # -- End function
	.globl	do_alarm                        # -- Begin function do_alarm
	.p2align	2
	.type	do_alarm,@function
do_alarm:                               # @do_alarm
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
kernel_Lpcrel_hi65:
	auipc	a0, %pcrel_hi(preserved_epc)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi65)
	lw	a0, 0(a0)
kernel_Lpcrel_hi66:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi66)
	lw	a2, 0(a1)
	sw	a0, 16(a2)
kernel_Lpcrel_hi67:
	auipc	a0, %pcrel_hi(preserved_sp)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi67)
	lw	a0, 0(a0)
	lw	a1, 0(a1)
	sw	a0, 20(a1)
	call	cpu_scheduler
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end16:
	.size	do_alarm, kernel_Lfunc_end16-do_alarm
                                        # -- End function
	.globl	fs_init                         # -- Begin function fs_init
	.p2align	2
	.type	fs_init,@function
fs_init:                                # @fs_init
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
kernel_Lpcrel_hi68:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi68)
	lw	a0, 0(a0)
	beqz	a0, kernel_LBB17_2
	j	kernel_LBB17_1
kernel_LBB17_1:
kernel_Lpcrel_hi69:
	auipc	a0, %pcrel_hi(kernel_L.str.11)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi69)
	call	print
	j	kernel_LBB17_10
kernel_LBB17_2:
	call	mm_allocate
	mv	a1, a0
kernel_Lpcrel_hi70:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi70)
	sw	a1, 0(a0)
	lw	a0, 0(a0)
	bnez	a0, kernel_LBB17_4
	j	kernel_LBB17_3
kernel_LBB17_3:
kernel_Lpcrel_hi71:
	auipc	a0, %pcrel_hi(kernel_L.str.12)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi71)
	call	print
	call	halt_kernel
	j	kernel_LBB17_4
kernel_LBB17_4:
kernel_Lpcrel_hi72:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi72)
	lw	a1, 0(a0)
kernel_Lpcrel_hi73:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi73)
	sw	a1, 0(a0)
	lw	a1, 0(a0)
	li	a0, 0
	call	bd_read_block
	bgez	a0, kernel_LBB17_6
	j	kernel_LBB17_5
kernel_LBB17_5:
kernel_Lpcrel_hi74:
	auipc	a0, %pcrel_hi(kernel_L.str.13)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi74)
	call	print
	call	halt_kernel
	j	kernel_LBB17_6
kernel_LBB17_6:
kernel_Lpcrel_hi75:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi75)
	lw	a0, 0(a0)
	lui	a1, 1
	add	a0, a0, a1
kernel_Lpcrel_hi76:
	auipc	a1, %pcrel_hi(directory_inode)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi76)
	sw	a0, 0(a1)
kernel_Lpcrel_hi77:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi77)
	lw	a0, 0(a0)
	lw	a0, 12(a0)
	lw	a1, 0(a1)
	call	bd_read_block
	bgez	a0, kernel_LBB17_8
	j	kernel_LBB17_7
kernel_LBB17_7:
kernel_Lpcrel_hi78:
	auipc	a0, %pcrel_hi(kernel_L.str.14)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi78)
	call	print
	call	halt_kernel
	j	kernel_LBB17_8
kernel_LBB17_8:
kernel_Lpcrel_hi79:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi79)
	lw	a0, 0(a0)
	lui	a1, 2
	add	a1, a0, a1
kernel_Lpcrel_hi80:
	auipc	a0, %pcrel_hi(directory_entries)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi80)
	sw	a1, 0(a0)
	lui	a1, 14
	sw	a1, -12(s0)
	lw	a0, 0(a0)
kernel_Lpcrel_hi81:
	auipc	a1, %pcrel_hi(directory_inode)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi81)
	lw	a1, 0(a1)
	lw	a2, -12(s0)
	call	read_inode_to_buffer
	bgez	a0, kernel_LBB17_10
	j	kernel_LBB17_9
kernel_LBB17_9:
kernel_Lpcrel_hi82:
	auipc	a0, %pcrel_hi(kernel_L.str.15)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi82)
	call	print
	call	halt_kernel
	j	kernel_LBB17_10
kernel_LBB17_10:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end17:
	.size	fs_init, kernel_Lfunc_end17-fs_init
                                        # -- End function
	.globl	run_init                        # -- Begin function run_init
	.p2align	2
	.type	run_init,@function
run_init:                               # @run_init
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	call	fs_init
kernel_Lpcrel_hi83:
	auipc	a0, %pcrel_hi(kernel_L.str.16)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi83)
	call	do_run
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	bgez	a0, kernel_LBB18_5
	j	kernel_LBB18_1
kernel_LBB18_1:
	lw	a0, -12(s0)
	li	a1, -1
	bne	a0, a1, kernel_LBB18_3
	j	kernel_LBB18_2
kernel_LBB18_2:
kernel_Lpcrel_hi84:
	auipc	a0, %pcrel_hi(kernel_L.str.17)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi84)
	call	print
	j	kernel_LBB18_4
kernel_LBB18_3:
kernel_Lpcrel_hi85:
	auipc	a0, %pcrel_hi(kernel_L.str.18)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi85)
	call	print
	j	kernel_LBB18_4
kernel_LBB18_4:
	call	halt_kernel
	j	kernel_LBB18_5
kernel_LBB18_5:
	call	cpu_scheduler
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end18:
	.size	run_init, kernel_Lfunc_end18-run_init
                                        # -- End function
	.type	current_process,@object         # @current_process
	.section	.sbss,"aw",@nobits
	.globl	current_process
	.p2align	2, 0x0
current_process:
	.word	0
	.size	current_process, 4

	.type	next_process_ID,@object         # @next_process_ID
	.globl	next_process_ID
	.p2align	2, 0x0
next_process_ID:
	.word	0                               # 0x0
	.size	next_process_ID, 4

	.type	superblock,@object              # @superblock
	.globl	superblock
	.p2align	2, 0x0
superblock:
	.word	0
	.size	superblock, 4

	.type	directory_inode,@object         # @directory_inode
	.globl	directory_inode
	.p2align	2, 0x0
directory_inode:
	.word	0
	.size	directory_inode, 4

	.type	directory_entries,@object       # @directory_entries
	.globl	directory_entries
	.p2align	2, 0x0
directory_entries:
	.word	0
	.size	directory_entries, 4

	.type	kernel_L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
kernel_L.str:
	.asciz	"[debug: ] "
	.size	kernel_L.str, 11

	.type	kernel_L.str.1,@object                # @.str.1
kernel_L.str.1:
	.asciz	"NOOP requested"
	.size	kernel_L.str.1, 15

	.type	kernel_L.str.2,@object                # @.str.2
kernel_L.str.2:
	.asciz	"\n"
	.size	kernel_L.str.2, 2

	.type	kernel_L.str.3,@object                # @.str.3
kernel_L.str.3:
	.asciz	"[kernel:] EXIT pid "
	.size	kernel_L.str.3, 20

	.type	kernel_L.str.4,@object                # @.str.4
kernel_L.str.4:
	.asciz	" with status "
	.size	kernel_L.str.4, 14

	.type	kernel_L.str.5,@object                # @.str.5
kernel_L.str.5:
	.asciz	"[kernel:] RUN "
	.size	kernel_L.str.5, 15

	.type	kernel_L.str.6,@object                # @.str.6
kernel_L.str.6:
	.asciz	"File: "
	.size	kernel_L.str.6, 7

	.type	kernel_L.str.7,@object                # @.str.7
kernel_L.str.7:
	.asciz	"\nLength: "
	.size	kernel_L.str.7, 10

	.type	kernel_L.str.8,@object                # @.str.8
kernel_L.str.8:
	.asciz	"finished create!\n"
	.size	kernel_L.str.8, 18

	.type	kernel_L.str.9,@object                # @.str.9
kernel_L.str.9:
	.asciz	"create failed"
	.size	kernel_L.str.9, 14

	.type	kernel_L.str.10,@object               # @.str.10
kernel_L.str.10:
	.asciz	"[kernel:] All processes terminated\n"
	.size	kernel_L.str.10, 36

	.type	fs_init.fs_metadata_blocks,@object # @fs_init.fs_metadata_blocks
	.section	.sbss,"aw",@nobits
	.p2align	2, 0x0
fs_init.fs_metadata_blocks:
	.word	0
	.size	fs_init.fs_metadata_blocks, 4

	.type	kernel_L.str.11,@object               # @.str.11
	.section	.rodata.str1.1,"aMS",@progbits,1
kernel_L.str.11:
	.asciz	"[kernel:] WARNING: fs_init() unexpectedly re-called\n"
	.size	kernel_L.str.11, 53

	.type	kernel_L.str.12,@object               # @.str.12
kernel_L.str.12:
	.asciz	"[kernel:] Failed allocation for file system metadata\n"
	.size	kernel_L.str.12, 54

	.type	kernel_L.str.13,@object               # @.str.13
kernel_L.str.13:
	.asciz	"[kernel:] Failed to read superblock\n"
	.size	kernel_L.str.13, 37

	.type	kernel_L.str.14,@object               # @.str.14
kernel_L.str.14:
	.asciz	"[kernel:] Failed to read directory inode\n"
	.size	kernel_L.str.14, 42

	.type	kernel_L.str.15,@object               # @.str.15
kernel_L.str.15:
	.asciz	"[kernel:] Failed to read directory file\n"
	.size	kernel_L.str.15, 41

	.type	kernel_L.str.16,@object               # @.str.16
kernel_L.str.16:
	.asciz	"create-test.vmx"
	.size	kernel_L.str.16, 16

	.type	kernel_L.str.17,@object               # @.str.17
kernel_L.str.17:
	.asciz	"[kernel:] No init.vmx found\n"
	.size	kernel_L.str.17, 29

	.type	kernel_L.str.18,@object               # @.str.18
kernel_L.str.18:
	.asciz	"[kernel:] Failed to run init\n"
	.size	kernel_L.str.18, 30

	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym insert_process
	.addrsig_sym remove_process
	.addrsig_sym cpu_scheduler
	.addrsig_sym quantum_expired
	.addrsig_sym userspace_jump
	.addrsig_sym do_noop
	.addrsig_sym print
	.addrsig_sym do_exit
	.addrsig_sym print_dec
	.addrsig_sym mm_deallocate
	.addrsig_sym deallocate
	.addrsig_sym do_run
	.addrsig_sym mm_allocate
	.addrsig_sym read_filename_to_buffer
	.addrsig_sym allocate
	.addrsig_sym string_copy
	.addrsig_sym do_print
	.addrsig_sym getlength
	.addrsig_sym string_length
	.addrsig_sym search_directory
	.addrsig_sym bd_read_block
	.addrsig_sym getdir
	.addrsig_sym print_array
	.addrsig_sym read
	.addrsig_sym read_inode_to_buffer
	.addrsig_sym write
	.addrsig_sym alloc_block
	.addrsig_sym bd_write_block
	.addrsig_sym create
	.addrsig_sym find_and_delete_dir_entry
	.addrsig_sym string_compare
	.addrsig_sym delete
	.addrsig_sym mark_free
	.addrsig_sym rename
	.addrsig_sym halt_kernel
	.addrsig_sym fs_init
	.addrsig_sym current_process
	.addrsig_sym next_process_ID
	.addrsig_sym superblock
	.addrsig_sym directory_inode
	.addrsig_sym directory_entries
	.addrsig_sym DMA_portal_ptr
	.addrsig_sym preserved_epc
	.addrsig_sym preserved_sp
	.addrsig_sym fs_init.fs_metadata_blocks
