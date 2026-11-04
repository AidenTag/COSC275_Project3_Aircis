	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"date_time.c"
	.globl	is_leap_year                    # -- Begin function is_leap_year
	.p2align	2
	.type	is_leap_year,@function
is_leap_year:                           # @is_leap_year
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 30
	add	a1, a0, a1
	andi	a1, a1, -4
	sub	a0, a0, a1
	bnez	a0, date_time_LBB0_2
	j	date_time_LBB0_1
date_time_LBB0_1:
	lw	a0, -12(s0)
	lui	a1, 796918
	addi	a1, a1, -983
	mul	a0, a0, a1
	lui	a1, 20972
	addi	a1, a1, -1968
	add	a0, a0, a1
	slli	a1, a0, 30
	srli	a0, a0, 2
	or	a1, a0, a1
	li	a2, 1
	lui	a0, 10486
	addi	a0, a0, -984
	sw	a2, -16(s0)                     # 4-byte Folded Spill
	bltu	a0, a1, date_time_LBB0_3
	j	date_time_LBB0_2
date_time_LBB0_2:
	lw	a0, -12(s0)
	lui	a1, 796918
	addi	a1, a1, -983
	mul	a0, a0, a1
	lui	a1, 20972
	addi	a1, a1, -1968
	add	a0, a0, a1
	slli	a1, a0, 28
	srli	a0, a0, 4
	or	a0, a0, a1
	lui	a1, 2621
	addi	a1, a1, 1803
	sltu	a0, a0, a1
	sw	a0, -16(s0)                     # 4-byte Folded Spill
	j	date_time_LBB0_3
date_time_LBB0_3:
	lw	a0, -16(s0)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
date_time_Lfunc_end0:
	.size	is_leap_year, date_time_Lfunc_end0-is_leap_year
                                        # -- End function
	.globl	int_to_str_width                # -- Begin function int_to_str_width
	.p2align	2
	.type	int_to_str_width,@function
int_to_str_width:                       # @int_to_str_width
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	sw	a0, -24(s0)
	lw	a1, -24(s0)
	addi	a0, a1, -1
	sw	a0, -24(s0)
	li	a0, 0
	sb	a0, 0(a1)
	j	date_time_LBB1_1
date_time_LBB1_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -12(s0)
	addi	a1, a1, -1
	beq	a0, a1, date_time_LBB1_3
	j	date_time_LBB1_2
date_time_LBB1_2:                                #   in Loop: Header=BB1_1 Depth=1
	lw	a0, -16(s0)
	lui	a1, 838861
	addi	a1, a1, -819
	mulhu	a2, a0, a1
	srli	a2, a2, 3
	li	a3, 10
	mul	a2, a2, a3
	sub	a0, a0, a2
	sw	a0, -28(s0)
	lw	a0, -16(s0)
	mulhu	a0, a0, a1
	srli	a0, a0, 3
	sw	a0, -16(s0)
	lw	a0, -28(s0)
	addi	a0, a0, 48
	lw	a1, -24(s0)
	addi	a2, a1, -1
	sw	a2, -24(s0)
	sb	a0, 0(a1)
	j	date_time_LBB1_1
date_time_LBB1_3:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
date_time_Lfunc_end1:
	.size	int_to_str_width, date_time_Lfunc_end1-int_to_str_width
                                        # -- End function
	.globl	to_datetime                     # -- Begin function to_datetime
	.p2align	2
	.type	to_datetime,@function
to_datetime:                            # @to_datetime
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 96
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a0, -12(s0)
	lui	a1, 795364
	addi	a1, a1, 1287
	mulhu	a2, a0, a1
	srli	a2, a2, 16
	lui	a3, 21
	addi	a3, a3, 384
	mul	a2, a2, a3
	sub	a0, a0, a2
	sw	a0, -56(s0)
	lw	a0, -56(s0)
	lui	a2, 596523
	addi	a2, a2, 965
	mulhu	a0, a0, a2
	srli	a0, a0, 11
	lw	a3, -20(s0)
	sw	a0, 12(a3)
	lw	a0, -56(s0)
	mulhu	a2, a0, a2
	srli	a2, a2, 11
	lui	a3, 1
	addi	a3, a3, -496
	mul	a2, a2, a3
	sub	a0, a0, a2
	sw	a0, -60(s0)
	lw	a0, -60(s0)
	lui	a2, 559241
	addi	a2, a2, -1911
	mulhu	a0, a0, a2
	srli	a0, a0, 5
	lw	a3, -20(s0)
	sw	a0, 16(a3)
	lw	a0, -60(s0)
	mulhu	a2, a0, a2
	srli	a2, a2, 5
	slli	a3, a2, 6
	slli	a2, a2, 2
	sub	a2, a2, a3
	add	a0, a0, a2
	lw	a2, -20(s0)
	sw	a0, 20(a2)
	lw	a0, -16(s0)
	lw	a2, -20(s0)
	sw	a0, 24(a2)
	lw	a0, -12(s0)
	mulhu	a0, a0, a1
	srli	a0, a0, 16
	sw	a0, -64(s0)
	li	a0, 1970
	sw	a0, -68(s0)
	lw	a0, -64(s0)
	sw	a0, -72(s0)
	j	date_time_LBB2_1
date_time_LBB2_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -68(s0)
	call	is_leap_year
	snez	a0, a0
	addi	a0, a0, 365
	sw	a0, -76(s0)
	lw	a0, -72(s0)
	lw	a1, -76(s0)
	bgeu	a0, a1, date_time_LBB2_3
	j	date_time_LBB2_2
date_time_LBB2_2:
	j	date_time_LBB2_4
date_time_LBB2_3:                                #   in Loop: Header=BB2_1 Depth=1
	lw	a1, -76(s0)
	lw	a0, -72(s0)
	sub	a0, a0, a1
	sw	a0, -72(s0)
	lw	a0, -68(s0)
	addi	a0, a0, 1
	sw	a0, -68(s0)
	j	date_time_LBB2_1
date_time_LBB2_4:
	lw	a0, -68(s0)
	lw	a1, -20(s0)
	sw	a0, 0(a1)
	li	a0, 0
	sw	a0, -80(s0)
	j	date_time_LBB2_5
date_time_LBB2_5:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -80(s0)
	li	a0, 11
	bltu	a0, a1, date_time_LBB2_12
	j	date_time_LBB2_6
date_time_LBB2_6:                                #   in Loop: Header=BB2_5 Depth=1
	lw	a0, -80(s0)
	slli	a1, a0, 2
date_time_Lpcrel_hi0:
	auipc	a0, %pcrel_hi(days_in_month)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi0)
	add	a0, a0, a1
	lw	a0, 0(a0)
	sw	a0, -84(s0)
	lw	a0, -80(s0)
	li	a1, 1
	bne	a0, a1, date_time_LBB2_9
	j	date_time_LBB2_7
date_time_LBB2_7:                                #   in Loop: Header=BB2_5 Depth=1
	lw	a0, -68(s0)
	call	is_leap_year
	beqz	a0, date_time_LBB2_9
	j	date_time_LBB2_8
date_time_LBB2_8:                                #   in Loop: Header=BB2_5 Depth=1
	li	a0, 29
	sw	a0, -84(s0)
	j	date_time_LBB2_9
date_time_LBB2_9:                                #   in Loop: Header=BB2_5 Depth=1
	lw	a0, -72(s0)
	lw	a1, -84(s0)
	bgeu	a0, a1, date_time_LBB2_11
	j	date_time_LBB2_10
date_time_LBB2_10:
	j	date_time_LBB2_12
date_time_LBB2_11:                               #   in Loop: Header=BB2_5 Depth=1
	lw	a1, -84(s0)
	lw	a0, -72(s0)
	sub	a0, a0, a1
	sw	a0, -72(s0)
	lw	a0, -80(s0)
	addi	a0, a0, 1
	sw	a0, -80(s0)
	j	date_time_LBB2_5
date_time_LBB2_12:
	lw	a0, -80(s0)
	addi	a0, a0, 1
	lw	a1, -20(s0)
	sw	a0, 4(a1)
	lw	a0, -72(s0)
	addi	a0, a0, 1
	lw	a1, -20(s0)
	sw	a0, 8(a1)
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
date_time_Lfunc_end2:
	.size	to_datetime, date_time_Lfunc_end2-to_datetime
                                        # -- End function
	.globl	time_to_str                     # -- Begin function time_to_str
	.p2align	2
	.type	time_to_str,@function
time_to_str:                            # @time_to_str
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 96
	sw	a0, -12(s0)
	sw	a1, -16(s0)
date_time_Lpcrel_hi1:
	auipc	a0, %pcrel_hi(date_time_L.str)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi1)
	sw	a0, -64(s0)
date_time_Lpcrel_hi2:
	auipc	a0, %pcrel_hi(date_time_L.str.1)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi2)
	sw	a0, -60(s0)
date_time_Lpcrel_hi3:
	auipc	a0, %pcrel_hi(date_time_L.str.2)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi3)
	sw	a0, -56(s0)
date_time_Lpcrel_hi4:
	auipc	a0, %pcrel_hi(date_time_L.str.3)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi4)
	sw	a0, -52(s0)
date_time_Lpcrel_hi5:
	auipc	a0, %pcrel_hi(date_time_L.str.4)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi5)
	sw	a0, -48(s0)
date_time_Lpcrel_hi6:
	auipc	a0, %pcrel_hi(date_time_L.str.5)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi6)
	sw	a0, -44(s0)
date_time_Lpcrel_hi7:
	auipc	a0, %pcrel_hi(date_time_L.str.6)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi7)
	sw	a0, -40(s0)
date_time_Lpcrel_hi8:
	auipc	a0, %pcrel_hi(date_time_L.str.7)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi8)
	sw	a0, -36(s0)
date_time_Lpcrel_hi9:
	auipc	a0, %pcrel_hi(date_time_L.str.8)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi9)
	sw	a0, -32(s0)
date_time_Lpcrel_hi10:
	auipc	a0, %pcrel_hi(date_time_L.str.9)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi10)
	sw	a0, -28(s0)
date_time_Lpcrel_hi11:
	auipc	a0, %pcrel_hi(date_time_L.str.10)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi11)
	sw	a0, -24(s0)
date_time_Lpcrel_hi12:
	auipc	a0, %pcrel_hi(date_time_L.str.11)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi12)
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -76(s0)                     # 4-byte Folded Spill
	sw	a0, -68(s0)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	lw	a1, 0(a1)
	li	a2, 4
	call	int_to_str_width
	lw	a0, -68(s0)
	addi	a0, a0, 4
	sw	a0, -68(s0)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	addi	a2, a1, 1
	sw	a2, -68(s0)
	add	a1, a0, a1
	li	a0, 45
	sb	a0, 0(a1)
	lw	a1, -16(s0)
	lw	a1, 4(a1)
	addi	a1, a1, -1
	sw	a1, -72(s0)
	lw	a1, -72(s0)
	slli	a2, a1, 2
	addi	a1, s0, -64
	add	a2, a1, a2
	lw	a2, 0(a2)
	lbu	a2, 0(a2)
	lw	a3, -12(s0)
	lw	a4, -68(s0)
	addi	a5, a4, 1
	sw	a5, -68(s0)
	add	a3, a3, a4
	sb	a2, 0(a3)
	lw	a2, -72(s0)
	slli	a2, a2, 2
	add	a2, a1, a2
	lw	a2, 0(a2)
	lbu	a2, 1(a2)
	lw	a3, -12(s0)
	lw	a4, -68(s0)
	addi	a5, a4, 1
	sw	a5, -68(s0)
	add	a3, a3, a4
	sb	a2, 0(a3)
	lw	a2, -72(s0)
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	lbu	a1, 2(a1)
	lw	a2, -12(s0)
	lw	a3, -68(s0)
	addi	a4, a3, 1
	sw	a4, -68(s0)
	add	a2, a2, a3
	sb	a1, 0(a2)
	lw	a1, -12(s0)
	lw	a2, -68(s0)
	addi	a3, a2, 1
	sw	a3, -68(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	lw	a1, 8(a1)
	li	a2, 2
	sw	a2, -80(s0)                     # 4-byte Folded Spill
	call	int_to_str_width
	lw	a2, -80(s0)                     # 4-byte Folded Reload
	lw	a0, -68(s0)
	addi	a0, a0, 2
	sw	a0, -68(s0)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	addi	a3, a1, 1
	sw	a3, -68(s0)
	add	a1, a0, a1
	li	a0, 32
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	lw	a1, 12(a1)
	call	int_to_str_width
	lw	a2, -80(s0)                     # 4-byte Folded Reload
	lw	a0, -68(s0)
	addi	a0, a0, 2
	sw	a0, -68(s0)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	addi	a3, a1, 1
	sw	a3, -68(s0)
	add	a1, a0, a1
	li	a0, 58
	sw	a0, -84(s0)                     # 4-byte Folded Spill
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	lw	a1, 16(a1)
	call	int_to_str_width
	lw	a0, -84(s0)                     # 4-byte Folded Reload
	lw	a2, -80(s0)                     # 4-byte Folded Reload
	lw	a1, -68(s0)
	addi	a1, a1, 2
	sw	a1, -68(s0)
	lw	a1, -12(s0)
	lw	a3, -68(s0)
	addi	a4, a3, 1
	sw	a4, -68(s0)
	add	a1, a1, a3
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	lw	a1, 20(a1)
	call	int_to_str_width
	lw	a0, -68(s0)
	addi	a0, a0, 2
	sw	a0, -68(s0)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	addi	a2, a1, 1
	sw	a2, -68(s0)
	add	a1, a0, a1
	li	a0, 46
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -68(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	lw	a1, 24(a1)
	li	a2, 3
	call	int_to_str_width
	lw	a0, -76(s0)                     # 4-byte Folded Reload
	lw	a1, -68(s0)
	addi	a1, a1, 3
	sw	a1, -68(s0)
	lw	a1, -12(s0)
	lw	a2, -68(s0)
	addi	a3, a2, 1
	sw	a3, -68(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
date_time_Lfunc_end3:
	.size	time_to_str, date_time_Lfunc_end3-time_to_str
                                        # -- End function
	.globl	show_now                        # -- Begin function show_now
	.p2align	2
	.type	show_now,@function
show_now:                               # @show_now
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 96
date_time_Lpcrel_hi13:
	auipc	a0, %pcrel_hi(wall_clock_device_code)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi13)
	lw	a0, 0(a0)
	li	a1, 1
	call	find_device
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	bnez	a0, date_time_LBB4_2
	j	date_time_LBB4_1
date_time_LBB4_1:
date_time_Lpcrel_hi14:
	auipc	a0, %pcrel_hi(date_time_L.str.12)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi14)
	call	print
date_time_Lpcrel_hi15:
	auipc	a0, %pcrel_hi(wall_clock_search_failure_code)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi15)
	lw	a0, 0(a0)
	call	abort
date_time_LBB4_2:
	lw	a0, -12(s0)
	lw	a0, 4(a0)
	sw	a0, -16(s0)
	lw	a1, -16(s0)
	li	a0, 0
	sw	a0, 8(a1)
	lw	a0, -16(s0)
	lw	a0, 0(a0)
	sw	a0, -20(s0)
	lw	a0, -16(s0)
	lw	a0, 4(a0)
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lui	a1, 1048572
	addi	a1, a1, 1984
	add	a0, a0, a1
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	addi	a2, s0, -52
	sw	a2, -92(s0)                     # 4-byte Folded Spill
	call	to_datetime
	lw	a1, -92(s0)                     # 4-byte Folded Reload
	addi	a0, s0, -84
	sw	a0, -88(s0)                     # 4-byte Folded Spill
	call	time_to_str
	lw	a0, -88(s0)                     # 4-byte Folded Reload
	call	print
date_time_Lpcrel_hi16:
	auipc	a0, %pcrel_hi(date_time_L.str.13)
	addi	a0, a0, %pcrel_lo(date_time_Lpcrel_hi16)
	call	print
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
date_time_Lfunc_end4:
	.size	show_now, date_time_Lfunc_end4-show_now
                                        # -- End function
	.type	days_in_month,@object           # @days_in_month
	.section	.rodata,"a",@progbits
	.globl	days_in_month
	.p2align	2, 0x0
days_in_month:
	.word	31                              # 0x1f
	.word	28                              # 0x1c
	.word	31                              # 0x1f
	.word	30                              # 0x1e
	.word	31                              # 0x1f
	.word	30                              # 0x1e
	.word	31                              # 0x1f
	.word	31                              # 0x1f
	.word	30                              # 0x1e
	.word	31                              # 0x1f
	.word	30                              # 0x1e
	.word	31                              # 0x1f
	.size	days_in_month, 48

	.type	date_time_L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
date_time_L.str:
	.asciz	"Jan"
	.size	date_time_L.str, 4

	.type	date_time_L.str.1,@object                # @.str.1
date_time_L.str.1:
	.asciz	"Feb"
	.size	date_time_L.str.1, 4

	.type	date_time_L.str.2,@object                # @.str.2
date_time_L.str.2:
	.asciz	"Mar"
	.size	date_time_L.str.2, 4

	.type	date_time_L.str.3,@object                # @.str.3
date_time_L.str.3:
	.asciz	"Apr"
	.size	date_time_L.str.3, 4

	.type	date_time_L.str.4,@object                # @.str.4
date_time_L.str.4:
	.asciz	"May"
	.size	date_time_L.str.4, 4

	.type	date_time_L.str.5,@object                # @.str.5
date_time_L.str.5:
	.asciz	"Jun"
	.size	date_time_L.str.5, 4

	.type	date_time_L.str.6,@object                # @.str.6
date_time_L.str.6:
	.asciz	"Jul"
	.size	date_time_L.str.6, 4

	.type	date_time_L.str.7,@object                # @.str.7
date_time_L.str.7:
	.asciz	"Aug"
	.size	date_time_L.str.7, 4

	.type	date_time_L.str.8,@object                # @.str.8
date_time_L.str.8:
	.asciz	"Sep"
	.size	date_time_L.str.8, 4

	.type	date_time_L.str.9,@object                # @.str.9
date_time_L.str.9:
	.asciz	"Oct"
	.size	date_time_L.str.9, 4

	.type	date_time_L.str.10,@object               # @.str.10
date_time_L.str.10:
	.asciz	"Nov"
	.size	date_time_L.str.10, 4

	.type	date_time_L.str.11,@object               # @.str.11
date_time_L.str.11:
	.asciz	"Dec"
	.size	date_time_L.str.11, 4

	.type	date_time_L.str.12,@object               # @.str.12
date_time_L.str.12:
	.asciz	"Failed to find wall clock device\n"
	.size	date_time_L.str.12, 34

	.type	date_time_L.str.13,@object               # @.str.13
date_time_L.str.13:
	.asciz	"\n"
	.size	date_time_L.str.13, 2

	.ident	"clang version 19.1.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym is_leap_year
	.addrsig_sym int_to_str_width
	.addrsig_sym to_datetime
	.addrsig_sym time_to_str
	.addrsig_sym find_device
	.addrsig_sym print
	.addrsig_sym abort
	.addrsig_sym days_in_month
	.addrsig_sym wall_clock_device_code
	.addrsig_sym wall_clock_search_failure_code
