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
	lw	a1, -28(s0)
	lui	a0, 16
	sw	a0, 20(a1)
kernel_Lpcrel_hi20:
	auipc	a0, %pcrel_hi(next_process_ID)
	addi	a2, a0, %pcrel_lo(kernel_Lpcrel_hi20)
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
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi22)
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
	.globl	do_syscall                      # -- Begin function do_syscall
	.p2align	2
	.type	do_syscall,@function
do_syscall:                             # @do_syscall
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
kernel_Lpcrel_hi23:
	auipc	a0, %pcrel_hi(preserved_epc)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi23)
	lw	a0, 0(a0)
kernel_Lpcrel_hi24:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi24)
	lw	a2, 0(a1)
	sw	a0, 16(a2)
kernel_Lpcrel_hi25:
	auipc	a0, %pcrel_hi(preserved_sp)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi25)
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
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi26)
	lw	a0, 0(a0)
	bnez	a0, kernel_LBB7_5
	j	kernel_LBB7_4
kernel_LBB7_4:
kernel_Lpcrel_hi27:
	auipc	a0, %pcrel_hi(kernel_L.str.6)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi27)
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
	auipc	a0, %pcrel_hi(current_process)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi28)
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
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end7:
	.size	do_syscall, kernel_Lfunc_end7-do_syscall
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
kernel_Lpcrel_hi29:
	auipc	a0, %pcrel_hi(preserved_epc)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi29)
	lw	a0, 0(a0)
kernel_Lpcrel_hi30:
	auipc	a1, %pcrel_hi(current_process)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi30)
	lw	a2, 0(a1)
	sw	a0, 16(a2)
kernel_Lpcrel_hi31:
	auipc	a0, %pcrel_hi(preserved_sp)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi31)
	lw	a0, 0(a0)
	lw	a1, 0(a1)
	sw	a0, 20(a1)
	call	cpu_scheduler
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end8:
	.size	do_alarm, kernel_Lfunc_end8-do_alarm
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
kernel_Lpcrel_hi32:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi32)
	lw	a0, 0(a0)
	beqz	a0, kernel_LBB9_2
	j	kernel_LBB9_1
kernel_LBB9_1:
kernel_Lpcrel_hi33:
	auipc	a0, %pcrel_hi(kernel_L.str.7)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi33)
	call	print
	j	kernel_LBB9_10
kernel_LBB9_2:
	call	mm_allocate
	mv	a1, a0
kernel_Lpcrel_hi34:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi34)
	sw	a1, 0(a0)
	lw	a0, 0(a0)
	bnez	a0, kernel_LBB9_4
	j	kernel_LBB9_3
kernel_LBB9_3:
kernel_Lpcrel_hi35:
	auipc	a0, %pcrel_hi(kernel_L.str.8)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi35)
	call	print
	call	halt_kernel
	j	kernel_LBB9_4
kernel_LBB9_4:
kernel_Lpcrel_hi36:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi36)
	lw	a1, 0(a0)
kernel_Lpcrel_hi37:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi37)
	sw	a1, 0(a0)
	lw	a1, 0(a0)
	li	a0, 0
	call	bd_read_block
	bgez	a0, kernel_LBB9_6
	j	kernel_LBB9_5
kernel_LBB9_5:
kernel_Lpcrel_hi38:
	auipc	a0, %pcrel_hi(kernel_L.str.9)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi38)
	call	print
	call	halt_kernel
	j	kernel_LBB9_6
kernel_LBB9_6:
kernel_Lpcrel_hi39:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi39)
	lw	a0, 0(a0)
	lui	a1, 1
	add	a0, a0, a1
kernel_Lpcrel_hi40:
	auipc	a1, %pcrel_hi(directory_inode)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi40)
	sw	a0, 0(a1)
kernel_Lpcrel_hi41:
	auipc	a0, %pcrel_hi(superblock)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi41)
	lw	a0, 0(a0)
	lw	a0, 12(a0)
	lw	a1, 0(a1)
	call	bd_read_block
	bgez	a0, kernel_LBB9_8
	j	kernel_LBB9_7
kernel_LBB9_7:
kernel_Lpcrel_hi42:
	auipc	a0, %pcrel_hi(kernel_L.str.10)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi42)
	call	print
	call	halt_kernel
	j	kernel_LBB9_8
kernel_LBB9_8:
kernel_Lpcrel_hi43:
	auipc	a0, %pcrel_hi(fs_init.fs_metadata_blocks)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi43)
	lw	a0, 0(a0)
	lui	a1, 2
	add	a1, a0, a1
kernel_Lpcrel_hi44:
	auipc	a0, %pcrel_hi(directory_entries)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi44)
	sw	a1, 0(a0)
	lui	a1, 14
	sw	a1, -12(s0)
	lw	a0, 0(a0)
kernel_Lpcrel_hi45:
	auipc	a1, %pcrel_hi(directory_inode)
	addi	a1, a1, %pcrel_lo(kernel_Lpcrel_hi45)
	lw	a1, 0(a1)
	lw	a2, -12(s0)
	call	read_inode_to_buffer
	bgez	a0, kernel_LBB9_10
	j	kernel_LBB9_9
kernel_LBB9_9:
kernel_Lpcrel_hi46:
	auipc	a0, %pcrel_hi(kernel_L.str.11)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi46)
	call	print
	call	halt_kernel
	j	kernel_LBB9_10
kernel_LBB9_10:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end9:
	.size	fs_init, kernel_Lfunc_end9-fs_init
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
kernel_Lpcrel_hi47:
	auipc	a0, %pcrel_hi(kernel_L.str.12)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi47)
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
	auipc	a0, %pcrel_hi(kernel_L.str.13)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi48)
	call	print
	j	kernel_LBB10_4
kernel_LBB10_3:
kernel_Lpcrel_hi49:
	auipc	a0, %pcrel_hi(kernel_L.str.14)
	addi	a0, a0, %pcrel_lo(kernel_Lpcrel_hi49)
	call	print
	j	kernel_LBB10_4
kernel_LBB10_4:
	call	halt_kernel
	j	kernel_LBB10_5
kernel_LBB10_5:
	call	cpu_scheduler
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end10:
	.size	run_init, kernel_Lfunc_end10-run_init
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
	.asciz	"[kernel:] All processes terminated\n"
	.size	kernel_L.str.6, 36

	.type	fs_init.fs_metadata_blocks,@object # @fs_init.fs_metadata_blocks
	.section	.sbss,"aw",@nobits
	.p2align	2, 0x0
fs_init.fs_metadata_blocks:
	.word	0
	.size	fs_init.fs_metadata_blocks, 4

	.type	kernel_L.str.7,@object                # @.str.7
	.section	.rodata.str1.1,"aMS",@progbits,1
kernel_L.str.7:
	.asciz	"[kernel:] WARNING: fs_init() unexpectedly re-called\n"
	.size	kernel_L.str.7, 53

	.type	kernel_L.str.8,@object                # @.str.8
kernel_L.str.8:
	.asciz	"[kernel:] Failed allocation for file system metadata\n"
	.size	kernel_L.str.8, 54

	.type	kernel_L.str.9,@object                # @.str.9
kernel_L.str.9:
	.asciz	"[kernel:] Failed to read superblock\n"
	.size	kernel_L.str.9, 37

	.type	kernel_L.str.10,@object               # @.str.10
kernel_L.str.10:
	.asciz	"[kernel:] Failed to read directory inode\n"
	.size	kernel_L.str.10, 42

	.type	kernel_L.str.11,@object               # @.str.11
kernel_L.str.11:
	.asciz	"[kernel:] Failed to read directory file\n"
	.size	kernel_L.str.11, 41

	.type	kernel_L.str.12,@object               # @.str.12
kernel_L.str.12:
	.asciz	"init.vmx"
	.size	kernel_L.str.12, 9

	.type	kernel_L.str.13,@object               # @.str.13
kernel_L.str.13:
	.asciz	"[kernel:] No init.vmx found\n"
	.size	kernel_L.str.13, 29

	.type	kernel_L.str.14,@object               # @.str.14
kernel_L.str.14:
	.asciz	"[kernel:] Failed to run init\n"
	.size	kernel_L.str.14, 30

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
	.addrsig_sym halt_kernel
	.addrsig_sym fs_init
	.addrsig_sym bd_read_block
	.addrsig_sym read_inode_to_buffer
	.addrsig_sym current_process
	.addrsig_sym next_process_ID
	.addrsig_sym superblock
	.addrsig_sym directory_inode
	.addrsig_sym directory_entries
	.addrsig_sym preserved_epc
	.addrsig_sym preserved_sp
	.addrsig_sym fs_init.fs_metadata_blocks
