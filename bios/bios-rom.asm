

# ===== BEGIN bios_stub.asm =====

### ================================================================================================================================
### bios_stub.asm
### Scott F. Kaplan -- sfkaplan@amherst.edu
###
### The Basic Input/Output System (BIOS).  A ROM that provides the initial sequence of instructions when the CPU is reset.  It finds
### the kernel (currently the second ROM in the device table), copies that executable image into RAM, and then jumps to the first
### location copied as the kernel's entry point.  As the system matures in later projects, this BIOS will need to find either a
### bootloader or a kernel on a block device (e.g., a disk) rather than in a ROM.  The use of a ROM is an initial simplification
### that is used until a file system is available.
###
### v.2026-03-01 ; Stub code for a C-based BIOS.
### ================================================================================================================================



### ================================================================================================================================
	.Code
### ================================================================================================================================



### ================================================================================================================================
### Initial stub.  No stack yet exists, so this specialized starting code must configure the system for that.
	
__start:	
	## Find RAM.  Start the search at the beginning of the device table.
	lw		t0,		device_table_base			# [t0] dt_current = &device_table[0]
	lw		s0,		none_device_code			# [s0] none_device_code
	lw		s1,		RAM_device_code				# [s1] RAM_device_code
	lw		s2,		dt_entry_size				# [s2] dt_entry_size
	
RAM_search_loop_top:

	## End the search with failure if we've reached the end of the table without finding RAM.
	lw		t1,		0(t0) 					# [t1] device_code = dt_current->type_code
	beq		t1,		s0,		RAM_search_failure 	# if (device_code == none_device_code)

	## If this entry is RAM, then end the loop successfully.
	beq		t1,		s1,		RAM_found 		# if (device_code == RAM_device_code)

	## This entry is not RAM, so advance to the next entry.
	add		t0,		t0,		s2 			# [t0] dt_current += dt_entry_size
	j		RAM_search_loop_top

RAM_search_failure:

	## Record a code to indicate the error, and then halt.
	lw		a0,		RAM_search_failure_code                 # [a0] RAM_search_failure_code
	halt

RAM_found:
	
	## RAM has been found.  Initialize the stack at the limit of RAM.
	lw		sp,		8(t0) 					# [sp] dt_current->limit
	mv		fp,		sp		  			# Initialize fp = sp

	## Create an ad-hoc statics region at the top of the stack, above the first frame, with gp marking its base.
	## [See also: types.h, statics_s]
	##   [gp + 0]:  dt_console_ptr
	##   [gp + 4]:  console_cursor_column
	##   [gp + 8]:  dt_RAM_ptr
	##   [gp + 12]: DMA_portal
	##   [gp + 16]: bd_portal
	##   [gp + 20]: heap_base
	##   [gp + 24]: heap_limit
	addi		sp,		sp,		-28			# Allocate statics region
	mv		gp,		sp					# [gp] Statics region base
	sw		zero,		0(gp)					# dt_console_ptr        = 0
	sw		zero,		4(gp)					# console_cursor_column = 0
	sw		t0,		8(gp)					# &dt[RAM]
	sw		zero,		12(gp)					# DMA_portal = 0
	sw		zero,		16(gp)					# bd_portal  = 0
	sw		zero,		20(gp)					# heap_base  = 0
	sw		zero,           24(gp)					# heap_limit = 0
	
	## Find the console and set the static pointer to its entry.
	lw		a0,		console_device_code  			# arg[0] = console_code
	li		a1,		1 					# arg[1] = 1 (find 1st instance of the console)
	call		find_device	 					# rv = &dt[console]
	sw		a0,		0(gp)					# dt_console_ptr = rv
	beqz		a0,		_no_console_fail   			# Fail if a null pointer was returned

	## With the stack initialized, call main() to begin booting proper.
	call		main

	## We should never be here, but wrap it up.
	lw		a0,		main_returned_error_code
	halt

_no_console_fail:
	lw		a0,		console_search_failure_code
	halt
### ================================================================================================================================

	

### ================================================================================================================================
### Procedure: jump_to_kernel
### Parameters:
###   [a0]: target -- the address at which the kernel is loaded
### Return value:
###   <DOES NOT RETURN>

jump_to_kernel:

	jr		a0
### ================================================================================================================================


	
### ================================================================================================================================
### Procedure: find_device
### Parameters:
###   [a0]: device_type -- The device type to find.
###   [a1]: instance    -- The instance of the given device type to find (e.g., the 3rd ROM).
### Return value:
###   [a0]: The address of the device table entry that matches the request null if no such entry is found.

find_device:

	## Initialize locals.  (No callee subframe to create -- no s-registers used, no other calls made.)
	lw		t0,		device_table_base
	lw		t1,		none_device_code
	lw		t2,		dt_entry_size
	
find_device_loop_top:

	## End the search with failure if we've reached the end of the table without finding the device.
	lw		t3,		0(t0) 						# t3 = current->type
	beq		t1,		t3,		find_device_loop_failure 

	## If this entry matches the device type we seek, then decrement the instance count.  If the instance count hits zero, then
	## the search ends successfully.
	bne		t3,		a0,		find_device_continue_loop	# Not the type sought
	addi		a1,		a1,		-1				# One fewer of this device to find
	beqz		a1,		find_device_loop_success			# And that was the last one to find!
	
find_device_continue_loop:	

	## Advance to the next entry.
	add		t0,		t0,		t2				# ++current
	j		find_device_loop_top

find_device_loop_failure:

	## Set the return value to a null pointer.
	mv		a0,		zero						# rv = 0 (null)
	j		find_device_return

find_device_loop_success:

	## Set the return pointer into the device table that currently points to the given iteration of the given type.
	mv		a0,		t0						# rv = current
	## Fall through...
	
find_device_return:

	## Return.
	ret
### ================================================================================================================================



### ================================================================================================================================
### Procedure: print
### Parameters:
###   [a0]: str_ptr -- A pointer to the beginning of a null-terminated string.
### Return value:
###   <none>
### Locals:
###   [s1]: current_ptr        -- Pointer to the current position in the string.
###   [s2]: console_buffer_end -- The console buffer's limit.
###   [s3]: cursor_column      -- The current cursor column (always on the bottom row).
###   [s4]: newline_char       -- A copy of the newline character.
###   [s5]: cursor_char        -- A copy of the cursor character.
###   [s6]: console_width      -- The console's width.
	
print:

	## Callee prologue: Push preserved registers.
	addi		sp,		sp,		-32			# Push & preserve ra / fp / s[1-6]
	sw		ra,		28(sp)
	sw		fp,		24(sp)
	sw		s1,		20(sp)
	sw		s2,		16(sp)
	sw		s3,		12(sp)
	sw		s4,		8(sp)
	sw		s5,		4(sp)
	sw		s6,		0(sp)
	addi		fp,		sp,		32

	## Initialize locals.
	mv		s1,		a0					# current_ptr = str_ptr
	lw		s2,		0(gp)					# s2 = dt_console_ptr (static)
	lw		s2,		8(s2)					#   = dt_console_ptr->limit
	addi		s2,		s2,		-4			# console_buffer_end = console_limit - |word| (offset portal)
	lw		s3,		4(gp)					# cursor_column (static)
	lb		s4,		newline_char
	lb		s5,		cursor_char
	lw		s6,		console_width

	## Loop through the characters of the given string until the terminating null character is found.
_string_loop_top:
	lb		t0,		0(s1)					# t0 = current_char = *current_ptr

	## The loop should end if this is a null character
	beqz		t0,		_string_loop_end

	## Scroll without copying the character if this is a newline.
	beq		t0,		s4,		_print_scroll_call

	## Assume that the cursor is in a valid location.  Copy the current character into it.
	sub		t1,		s2,		s6			# t1 = console[limit] - width
	add		t1,		t1,		s3			#    = console[limit] - width + cursor_column
	sb		t0,		0(t1)					# Display current char @t1.
	
	## Advance the cursor, scrolling if necessary.
	addi		s3,		s3,		1			# cursor_column++
	blt		s3,		s6,		_print_scroll_end       # Skip scrolling if cursor_column < width

_print_scroll_call:
	sw		s3,		4(gp)					# Spill cursor_column (static)
	call		scroll_console
	lw		s3,		4(gp)					# Restore cursor_column (static), which may have changed

_print_scroll_end:
	## Place the cursor character in its new position.
	sub		t1,		s2,		s6			# t1 = console[limit] - width
	add		t1,		t1,		s3			#    = console[limit] - width + cursor_column
	sb		s5,		0(t1)					# Display cursor char @t1.
	
	## Iterate by advancing to the next character in the string.
	addi		s1,		s1,		1
	j		_string_loop_top

_string_loop_end:
	## Callee Epilogue...
	##   Store cursor_column back into statics.
	sw		s3,		4(gp)					# Store cursor_column (static)
	##   Pop and restore preserved registers, then return.
	lw		s6,		0(sp)					# Restore & pop fp + s[1-6]
	lw		s5,		4(sp)
	lw		s4,		8(sp)
	lw		s3,		12(sp)
	lw		s2,		16(sp)
	lw		s1,		20(sp)
	lw		fp,		24(sp)
	lw		ra,		28(sp)
	addi		sp,		sp,		32
	ret
### ================================================================================================================================


### ================================================================================================================================
### Procedure: scroll_console
### Description: Scroll the console and reset the cursor at the 0th column.
### Parameters:
###   <none>
### Return value:
###   <none>
### Locals:
###   [t0]: console_buffer_end / console_offset_ptr
###   [t1]: console_width
###   [t2]: console_buffer_begin
###   [t3]: cursor_column
###   [t4]: screen_size	
	
scroll_console:

	## Initialize locals.
	lw		t5,		0(gp)					# [t5] dt_console_ptr (static)
	lw		t2,		4(t5)					# console_buffer_begin = dt_console_ptr->base
	lw		t0,		8(t5)					# [t0] dt_console_ptr->limit
	addi		t0,		t0,		-4			# console_buffer_end = console_limit - |word| (offset portal)
	lw		t1,		console_width				# console_width
	lw		t3,		4(gp)					# cursor_column
	lw		t4,		console_height				# t4 = console_height
	mul		t4,		t1,		t4			# screen_size = console_width * console_height
	
	## Blank the top line.
	lw		t5,		device_table_base                       # t5 = dt_controller_ptr
	lw		t5,		8(t5)					#    = dt_controller_ptr->limit
	addi		t5,		t5,		-12			# DMA_portal_ptr = dt_controller_ptr->limit - 3*|word|
	la		t6,		blank_line				# t6 = &blank_line
	sw		t6,		0(t5)					# DMA_portal_ptr->src = &blank_line
	sw		t2,		4(t5)					# DMA_portal_ptr->dst = console_buffer_begin
	sw		t1,		8(t5)					# DMA_portal_ptr->len = console_width

	## Clear the cursor if it isn't off the end of the line.
	beq		t1,		t3,		_scroll_console_update_offset	# Skip if width == cursor_column
	sub		t5,		t0,		t1			# t5 = console_buffer_end - width
	add		t5,		t5,		t3			#    = console_buffer_end - width + cursor_column
	lb		t6,		space_char
	sb		t6,		0(t5)

	## Update the offset, wrapping around if needed.
_scroll_console_update_offset:
	lw		t6,		0(t0)					# [t6] offset
	add		t6,		t6,		t1			# offset += column_width
	rem		t6,		t6,		t4			# offset %= screen_size
	sw		t6,		0(t0)					# Set offset in console
	
	## Reset the cursor at the start of the new line.
	li		t3,		0					# cursor_column = 0
	sw		t3,		4(gp)					# Store cursor_column (static)
	lb		t6,		cursor_char				# [t6] cursor_char
	sub		t5,		t0,		t1			# t5 = console_buffer_end - width (cursor_column == 0)	
	sb		t6,		0(t5)
	
	## Return.
	ret
### ================================================================================================================================


	
### ================================================================================================================================
get_statics:
	mv		a0,		gp
	ret
### ================================================================================================================================
	


### ================================================================================================================================
abort:
	halt
### ================================================================================================================================



### ================================================================================================================================
	.Numeric

	## Device table location and codes.
device_table_base:	0x00001000
dt_entry_size:		12
none_device_code:	0
controller_device_code:	1
ROM_device_code:	2
RAM_device_code:	3
console_device_code:	4
block_device_code:	5
wall_clock_device_code:	6
random_device_code:	7

	## Error codes.
main_returned_error_code:		0xffff0000
controller_search_failure_code:		0xffff0001
RAM_search_failure_code:		0xffff0002
console_search_failure_code:		0xffff0003
block_device_search_failure_code:	0xffff0004
wall_clock_search_failure_code:		0xffff0005
allocation_failure_code:		0xffff0006
block_device_access_failure_code:	0xffff0007
kernel_file_failure_code:		0xffff0008

	## Constants for printing and console management.
console_width:		80
console_height:		24
### ================================================================================================================================


	
### ================================================================================================================================
	.Text

space_char:	" "
cursor_char:	"_"
newline_char:	"\n"
banner_msg:	"Fivish BIOS v.2026-01-24\n"
copyright_msg:	"(c) Scott F. Kaplan / sfkaplan@amherst.edu\n"
stage_end_msg:	"done.\n"
stage_fail_msg:	"failed!  Halting now.\n"
blank_line:	"                                                                                "
### ================================================================================================================================


# =====  END  bios_stub.asm =====



# ===== BEGIN ./bios.asm =====

	.Code
block_allocate:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -16(s0) 
	lw	a0, -16(s0) 
	srli	a0, a0, 12 
	sw	a0, -20(s0) 
	lw	a0, -20(s0) 
	slli	a0, a0, 12 
	lw	a1, -16(s0) 
	bgeu	a0, a1, bios_LBB0_2 
	j	bios_LBB0_1 
bios_LBB0_1:
	lw	a0, -20(s0) 
	addi	a0, a0, 1 
	sw	a0, -20(s0) 
	j	bios_LBB0_2 
bios_LBB0_2:
	lw	a0, -20(s0) 
	slli	a0, a0, 12 
	sw	a0, -24(s0) 
	call	get_statics 
	sw	a0, -28(s0) 
	lw	a0, -28(s0) 
	lw	a0, 24(a0) 
	sw	a0, -32(s0) 
	#APP	
	mv	a0, sp 
	#NO_APP	
	sw	a0, -36(s0) 
	lw	a0, -32(s0) 
	lw	a1, -24(s0) 
	add	a1, a0, a1 
	lw	a0, -36(s0) 
	bgeu	a0, a1, bios_LBB0_4 
	j	bios_LBB0_3 
bios_LBB0_3:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	bios_LBB0_5 
bios_LBB0_4:
	lw	a2, -24(s0) 
	lw	a1, -28(s0) 
	lw	a0, 24(a1) 
	add	a0, a0, a2 
	sw	a0, 24(a1) 
	lw	a0, -32(s0) 
	sw	a0, -12(s0) 
	j	bios_LBB0_5 
bios_LBB0_5:
	lw	a0, -12(s0) 
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
bios_Lfunc_end0:
	#	-- End function 
main:
	#	%bb.0: 
	addi	sp, sp, -64 
	sw	ra, 60(sp) # 4-byte Folded Spill 
	sw	s0, 56(sp) # 4-byte Folded Spill 
	addi	s0, sp, 64 
	li	a0, 0 
	sw	a0, -12(s0) 
bios_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(bios_L.str))
	addi	a0, a0, %lo(%larel(bios_L.str,bios_Lpcrel_hi0))
	call	print 
bios_Lpcrel_hi1:
	auipc	a0, %hi(%pcrel(bios_L.str.1))
	addi	a0, a0, %lo(%larel(bios_L.str.1,bios_Lpcrel_hi1))
	call	print 
	call	show_now 
	call	get_statics 
	sw	a0, -16(s0) 
bios_Lpcrel_hi2:
	auipc	a0, %hi(%pcrel(controller_device_code))
	addi	a0, a0, %lo(%larel(controller_device_code,bios_Lpcrel_hi2))
	lw	a0, 0(a0) 
	li	a1, 1 
	call	find_device 
	sw	a0, -20(s0) 
	lw	a0, -20(s0) 
	bnez	a0, bios_LBB1_2 
	j	bios_LBB1_1 
bios_LBB1_1:
bios_Lpcrel_hi3:
	auipc	a0, %hi(%pcrel(bios_L.str.2))
	addi	a0, a0, %lo(%larel(bios_L.str.2,bios_Lpcrel_hi3))
	call	print 
bios_Lpcrel_hi4:
	auipc	a0, %hi(%pcrel(controller_search_failure_code))
	addi	a0, a0, %lo(%larel(controller_search_failure_code,bios_Lpcrel_hi4))
	lw	a0, 0(a0) 
	call	abort 
bios_LBB1_2:
	lw	a0, -20(s0) 
	lw	a0, 8(a0) 
	addi	a0, a0, -12 
	lw	a1, -16(s0) 
	sw	a0, 12(a1) 
bios_Lpcrel_hi5:
	auipc	a0, %hi(%pcrel(block_device_code))
	addi	a0, a0, %lo(%larel(block_device_code,bios_Lpcrel_hi5))
	lw	a0, 0(a0) 
	li	a1, 1 
	call	find_device 
	sw	a0, -24(s0) 
	lw	a0, -24(s0) 
	bnez	a0, bios_LBB1_4 
	j	bios_LBB1_3 
bios_LBB1_3:
bios_Lpcrel_hi6:
	auipc	a0, %hi(%pcrel(bios_L.str.3))
	addi	a0, a0, %lo(%larel(bios_L.str.3,bios_Lpcrel_hi6))
	call	print 
bios_Lpcrel_hi7:
	auipc	a0, %hi(%pcrel(block_device_search_failure_code))
	addi	a0, a0, %lo(%larel(block_device_search_failure_code,bios_Lpcrel_hi7))
	lw	a0, 0(a0) 
	call	abort 
bios_LBB1_4:
	lw	a0, -24(s0) 
	lw	a0, 4(a0) 
	lw	a1, -16(s0) 
	sw	a0, 16(a1) 
	lw	a1, -16(s0) 
	lw	a2, 8(a1) 
	lw	a0, 4(a2) 
	lw	a2, 8(a2) 
	add	a0, a0, a2 
	srli	a0, a0, 1 
	sw	a0, 20(a1) 
	lw	a1, -16(s0) 
	lw	a0, 20(a1) 
	sw	a0, 24(a1) 
bios_Lpcrel_hi8:
	auipc	a0, %hi(%pcrel(bios_L.str.4))
	addi	a0, a0, %lo(%larel(bios_L.str.4,bios_Lpcrel_hi8))
	call	print 
	lui	a0, 1 
	call	block_allocate 
	sw	a0, -28(s0) 
	lw	a1, -28(s0) 
	li	a0, 0 
	sw	a0, -56(s0) # 4-byte Folded Spill 
	call	bd_read_block 
	lw	a0, -56(s0) # 4-byte Folded Reload 
	lw	a1, -28(s0) 
	sw	a1, -32(s0) 
	lw	a1, -32(s0) 
	lw	a1, 12(a1) 
	sw	a1, -36(s0) 
	sw	a0, -32(s0) 
	lw	a0, -36(s0) 
	lw	a1, -28(s0) 
	call	bd_read_block 
	lw	a0, -28(s0) 
	sw	a0, -40(s0) 
	lw	a0, -40(s0) 
	lw	a0, 0(a0) 
	call	block_allocate 
	sw	a0, -44(s0) 
	lw	a0, -44(s0) 
	bnez	a0, bios_LBB1_6 
	j	bios_LBB1_5 
bios_LBB1_5:
bios_Lpcrel_hi9:
	auipc	a0, %hi(%pcrel(bios_L.str.5))
	addi	a0, a0, %lo(%larel(bios_L.str.5,bios_Lpcrel_hi9))
	call	print 
bios_Lpcrel_hi10:
	auipc	a0, %hi(%pcrel(allocation_failure_code))
	addi	a0, a0, %lo(%larel(allocation_failure_code,bios_Lpcrel_hi10))
	lw	a0, 0(a0) 
	call	abort 
bios_LBB1_6:
	lw	a0, -44(s0) 
	lw	a1, -40(s0) 
	call	read_file 
	lw	a0, -40(s0) 
	lw	a0, 0(a0) 
	srli	a0, a0, 6 
	sw	a0, -48(s0) 
	lw	a0, -44(s0) 
	lw	a1, -48(s0) 
bios_Lpcrel_hi11:
	auipc	a2, %hi(%pcrel(bios_L.str.6))
	addi	a2, a2, %lo(%larel(bios_L.str.6,bios_Lpcrel_hi11))
	call	search_directory 
	sw	a0, -52(s0) 
	lw	a0, -52(s0) 
	bnez	a0, bios_LBB1_8 
	j	bios_LBB1_7 
bios_LBB1_7:
bios_Lpcrel_hi12:
	auipc	a0, %hi(%pcrel(bios_L.str.7))
	addi	a0, a0, %lo(%larel(bios_L.str.7,bios_Lpcrel_hi12))
	call	print 
bios_Lpcrel_hi13:
	auipc	a0, %hi(%pcrel(kernel_file_failure_code))
	addi	a0, a0, %lo(%larel(kernel_file_failure_code,bios_Lpcrel_hi13))
	lw	a0, 0(a0) 
	call	abort 
bios_LBB1_8:
bios_Lpcrel_hi14:
	auipc	a0, %hi(%pcrel(bios_L.str.8))
	addi	a0, a0, %lo(%larel(bios_L.str.8,bios_Lpcrel_hi14))
	call	print 
	lw	a0, -52(s0) 
	lw	a1, -28(s0) 
	call	bd_read_block 
	lw	a0, -16(s0) 
	lw	a0, 8(a0) 
	lw	a0, 4(a0) 
	lw	a1, -40(s0) 
	call	read_file 
bios_Lpcrel_hi15:
	auipc	a0, %hi(%pcrel(bios_L.str.9))
	addi	a0, a0, %lo(%larel(bios_L.str.9,bios_Lpcrel_hi15))
	call	print 
	lw	a0, -16(s0) 
	lw	a0, 8(a0) 
	lw	a0, 4(a0) 
	call	jump_to_kernel 
	li	a0, -1 
	lw	ra, 60(sp) # 4-byte Folded Reload 
	lw	s0, 56(sp) # 4-byte Folded Reload 
	addi	sp, sp, 64 
	ret	
bios_Lfunc_end1:
	#	-- End function 
bios_L.str:
	.Text
	.asciz	"Fivish BIOS+ v.2026-10-24\n"
bios_L.str.1:
	.asciz	"(c) Scott F. Kaplan | sfkaplan@amherst.edu\n"
bios_L.str.2:
	.asciz	"ERROR: Bus controller not found"
bios_L.str.3:
	.asciz	"ERROR: Block device not found\n"
bios_L.str.4:
	.asciz	"  Kernel: Finding..."
bios_L.str.5:
	.asciz	"ERROR: Failed to allocate memory for directory\n"
bios_L.str.6:
	.asciz	"kernel.vmx"
bios_L.str.7:
	.asciz	"ERROR: Failed to find kernel.vmx\n"
bios_L.str.8:
	.asciz	"Loading..."
bios_L.str.9:
	.asciz	"Vectoring...\n\n"


# =====  END  ./bios.asm =====



# ===== BEGIN ./bd_driver.asm =====

	.Code
bd_read_block:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	call	get_statics 
	sw	a0, -20(s0) 
	lw	a0, -20(s0) 
	lw	a0, 16(a0) 
	sw	a0, -24(s0) 
	lw	a0, -20(s0) 
	lw	a0, 12(a0) 
	sw	a0, -28(s0) 
	lw	a0, -12(s0) 
	lw	a1, -24(s0) 
	lui	a2, 1 
	add	a1, a1, a2 
	sw	a0, 0(a1) 
	lw	a0, -24(s0) 
	add	a0, a0, a2 
	li	a1, -1 
	sw	a1, 4(a0) 
	lw	a0, -24(s0) 
	add	a0, a0, a2 
	lw	a0, 4(a0) 
	bne	a0, a1, bd_driver_LBB0_2 
	j	bd_driver_LBB0_1 
bd_driver_LBB0_1:
bd_driver_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(bd_driver_L.str))
	addi	a0, a0, %lo(%larel(bd_driver_L.str,bd_driver_Lpcrel_hi0))
	call	print 
bd_driver_Lpcrel_hi1:
	auipc	a0, %hi(%pcrel(block_device_access_failure_code))
	addi	a0, a0, %lo(%larel(block_device_access_failure_code,bd_driver_Lpcrel_hi1))
	lw	a0, 0(a0) 
	call	abort 
bd_driver_LBB0_2:
	lw	a0, -24(s0) 
	lui	a1, 1 
	add	a0, a0, a1 
	lw	a0, 4(a0) 
	li	a1, -2 
	bne	a0, a1, bd_driver_LBB0_4 
	j	bd_driver_LBB0_3 
bd_driver_LBB0_3:
bd_driver_Lpcrel_hi2:
	auipc	a0, %hi(%pcrel(bd_driver_L.str.1))
	addi	a0, a0, %lo(%larel(bd_driver_L.str.1,bd_driver_Lpcrel_hi2))
	call	print 
bd_driver_Lpcrel_hi3:
	auipc	a0, %hi(%pcrel(block_device_access_failure_code))
	addi	a0, a0, %lo(%larel(block_device_access_failure_code,bd_driver_Lpcrel_hi3))
	lw	a0, 0(a0) 
	call	abort 
bd_driver_LBB0_4:
	j	bd_driver_LBB0_5 
bd_driver_LBB0_5:
	lw	a0, -24(s0) 
	lw	a1, -28(s0) 
	sw	a0, 0(a1) 
	lw	a0, -16(s0) 
	lw	a1, -28(s0) 
	sw	a0, 4(a1) 
	lw	a1, -28(s0) 
	lui	a0, 1 
	sw	a0, 8(a1) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
bd_driver_Lfunc_end0:
	#	-- End function 
bd_driver_L.str:
	.Text
	.asciz	"ERROR: Attempt to read invalid block number\n"
bd_driver_L.str.1:
	.asciz	"ERROR: Failure in reading block device\n"


# =====  END  ./bd_driver.asm =====



# ===== BEGIN ./date_time.asm =====

	.Code
is_leap_year:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
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
	sw	a2, -16(s0) # 4-byte Folded Spill 
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
	sw	a0, -16(s0) # 4-byte Folded Spill 
	j	date_time_LBB0_3 
date_time_LBB0_3:
	lw	a0, -16(s0) # 4-byte Folded Reload 
	andi	a0, a0, 1 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
date_time_Lfunc_end0:
	#	-- End function 
int_to_str_width:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
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
date_time_LBB1_1:
	lw	a0, -24(s0) 
	lw	a1, -12(s0) 
	addi	a1, a1, -1 
	beq	a0, a1, date_time_LBB1_3 
	j	date_time_LBB1_2 
date_time_LBB1_2:
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
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
date_time_Lfunc_end1:
	#	-- End function 
to_datetime:
	#	%bb.0: 
	addi	sp, sp, -96 
	sw	ra, 92(sp) # 4-byte Folded Spill 
	sw	s0, 88(sp) # 4-byte Folded Spill 
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
date_time_LBB2_1:
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
date_time_LBB2_3:
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
date_time_LBB2_5:
	lw	a1, -80(s0) 
	li	a0, 11 
	bltu	a0, a1, date_time_LBB2_12 
	j	date_time_LBB2_6 
date_time_LBB2_6:
	lw	a0, -80(s0) 
	slli	a1, a0, 2 
date_time_Lpcrel_hi0:
	auipc	a0, %hi(%pcrel(days_in_month))
	addi	a0, a0, %lo(%larel(days_in_month,date_time_Lpcrel_hi0))
	add	a0, a0, a1 
	lw	a0, 0(a0) 
	sw	a0, -84(s0) 
	lw	a0, -80(s0) 
	li	a1, 1 
	bne	a0, a1, date_time_LBB2_9 
	j	date_time_LBB2_7 
date_time_LBB2_7:
	lw	a0, -68(s0) 
	call	is_leap_year 
	beqz	a0, date_time_LBB2_9 
	j	date_time_LBB2_8 
date_time_LBB2_8:
	li	a0, 29 
	sw	a0, -84(s0) 
	j	date_time_LBB2_9 
date_time_LBB2_9:
	lw	a0, -72(s0) 
	lw	a1, -84(s0) 
	bgeu	a0, a1, date_time_LBB2_11 
	j	date_time_LBB2_10 
date_time_LBB2_10:
	j	date_time_LBB2_12 
date_time_LBB2_11:
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
	lw	ra, 92(sp) # 4-byte Folded Reload 
	lw	s0, 88(sp) # 4-byte Folded Reload 
	addi	sp, sp, 96 
	ret	
date_time_Lfunc_end2:
	#	-- End function 
time_to_str:
	#	%bb.0: 
	addi	sp, sp, -96 
	sw	ra, 92(sp) # 4-byte Folded Spill 
	sw	s0, 88(sp) # 4-byte Folded Spill 
	addi	s0, sp, 96 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
date_time_Lpcrel_hi1:
	auipc	a0, %hi(%pcrel(date_time_L.str))
	addi	a0, a0, %lo(%larel(date_time_L.str,date_time_Lpcrel_hi1))
	sw	a0, -64(s0) 
date_time_Lpcrel_hi2:
	auipc	a0, %hi(%pcrel(date_time_L.str.1))
	addi	a0, a0, %lo(%larel(date_time_L.str.1,date_time_Lpcrel_hi2))
	sw	a0, -60(s0) 
date_time_Lpcrel_hi3:
	auipc	a0, %hi(%pcrel(date_time_L.str.2))
	addi	a0, a0, %lo(%larel(date_time_L.str.2,date_time_Lpcrel_hi3))
	sw	a0, -56(s0) 
date_time_Lpcrel_hi4:
	auipc	a0, %hi(%pcrel(date_time_L.str.3))
	addi	a0, a0, %lo(%larel(date_time_L.str.3,date_time_Lpcrel_hi4))
	sw	a0, -52(s0) 
date_time_Lpcrel_hi5:
	auipc	a0, %hi(%pcrel(date_time_L.str.4))
	addi	a0, a0, %lo(%larel(date_time_L.str.4,date_time_Lpcrel_hi5))
	sw	a0, -48(s0) 
date_time_Lpcrel_hi6:
	auipc	a0, %hi(%pcrel(date_time_L.str.5))
	addi	a0, a0, %lo(%larel(date_time_L.str.5,date_time_Lpcrel_hi6))
	sw	a0, -44(s0) 
date_time_Lpcrel_hi7:
	auipc	a0, %hi(%pcrel(date_time_L.str.6))
	addi	a0, a0, %lo(%larel(date_time_L.str.6,date_time_Lpcrel_hi7))
	sw	a0, -40(s0) 
date_time_Lpcrel_hi8:
	auipc	a0, %hi(%pcrel(date_time_L.str.7))
	addi	a0, a0, %lo(%larel(date_time_L.str.7,date_time_Lpcrel_hi8))
	sw	a0, -36(s0) 
date_time_Lpcrel_hi9:
	auipc	a0, %hi(%pcrel(date_time_L.str.8))
	addi	a0, a0, %lo(%larel(date_time_L.str.8,date_time_Lpcrel_hi9))
	sw	a0, -32(s0) 
date_time_Lpcrel_hi10:
	auipc	a0, %hi(%pcrel(date_time_L.str.9))
	addi	a0, a0, %lo(%larel(date_time_L.str.9,date_time_Lpcrel_hi10))
	sw	a0, -28(s0) 
date_time_Lpcrel_hi11:
	auipc	a0, %hi(%pcrel(date_time_L.str.10))
	addi	a0, a0, %lo(%larel(date_time_L.str.10,date_time_Lpcrel_hi11))
	sw	a0, -24(s0) 
date_time_Lpcrel_hi12:
	auipc	a0, %hi(%pcrel(date_time_L.str.11))
	addi	a0, a0, %lo(%larel(date_time_L.str.11,date_time_Lpcrel_hi12))
	sw	a0, -20(s0) 
	li	a0, 0 
	sw	a0, -76(s0) # 4-byte Folded Spill 
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
	sw	a2, -80(s0) # 4-byte Folded Spill 
	call	int_to_str_width 
	lw	a2, -80(s0) # 4-byte Folded Reload 
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
	lw	a2, -80(s0) # 4-byte Folded Reload 
	lw	a0, -68(s0) 
	addi	a0, a0, 2 
	sw	a0, -68(s0) 
	lw	a0, -12(s0) 
	lw	a1, -68(s0) 
	addi	a3, a1, 1 
	sw	a3, -68(s0) 
	add	a1, a0, a1 
	li	a0, 58 
	sw	a0, -84(s0) # 4-byte Folded Spill 
	sb	a0, 0(a1) 
	lw	a0, -12(s0) 
	lw	a1, -68(s0) 
	add	a0, a0, a1 
	lw	a1, -16(s0) 
	lw	a1, 16(a1) 
	call	int_to_str_width 
	lw	a0, -84(s0) # 4-byte Folded Reload 
	lw	a2, -80(s0) # 4-byte Folded Reload 
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
	lw	a0, -76(s0) # 4-byte Folded Reload 
	lw	a1, -68(s0) 
	addi	a1, a1, 3 
	sw	a1, -68(s0) 
	lw	a1, -12(s0) 
	lw	a2, -68(s0) 
	addi	a3, a2, 1 
	sw	a3, -68(s0) 
	add	a1, a1, a2 
	sb	a0, 0(a1) 
	lw	ra, 92(sp) # 4-byte Folded Reload 
	lw	s0, 88(sp) # 4-byte Folded Reload 
	addi	sp, sp, 96 
	ret	
date_time_Lfunc_end3:
	#	-- End function 
show_now:
	#	%bb.0: 
	addi	sp, sp, -96 
	sw	ra, 92(sp) # 4-byte Folded Spill 
	sw	s0, 88(sp) # 4-byte Folded Spill 
	addi	s0, sp, 96 
date_time_Lpcrel_hi13:
	auipc	a0, %hi(%pcrel(wall_clock_device_code))
	addi	a0, a0, %lo(%larel(wall_clock_device_code,date_time_Lpcrel_hi13))
	lw	a0, 0(a0) 
	li	a1, 1 
	call	find_device 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	bnez	a0, date_time_LBB4_2 
	j	date_time_LBB4_1 
date_time_LBB4_1:
date_time_Lpcrel_hi14:
	auipc	a0, %hi(%pcrel(date_time_L.str.12))
	addi	a0, a0, %lo(%larel(date_time_L.str.12,date_time_Lpcrel_hi14))
	call	print 
date_time_Lpcrel_hi15:
	auipc	a0, %hi(%pcrel(wall_clock_search_failure_code))
	addi	a0, a0, %lo(%larel(wall_clock_search_failure_code,date_time_Lpcrel_hi15))
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
	sw	a2, -92(s0) # 4-byte Folded Spill 
	call	to_datetime 
	lw	a1, -92(s0) # 4-byte Folded Reload 
	addi	a0, s0, -84 
	sw	a0, -88(s0) # 4-byte Folded Spill 
	call	time_to_str 
	lw	a0, -88(s0) # 4-byte Folded Reload 
	call	print 
date_time_Lpcrel_hi16:
	auipc	a0, %hi(%pcrel(date_time_L.str.13))
	addi	a0, a0, %lo(%larel(date_time_L.str.13,date_time_Lpcrel_hi16))
	call	print 
	lw	ra, 92(sp) # 4-byte Folded Reload 
	lw	s0, 88(sp) # 4-byte Folded Reload 
	addi	sp, sp, 96 
	ret	
date_time_Lfunc_end4:
	#	-- End function 
days_in_month:
	.Numeric
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
date_time_L.str:
	.Text
	.asciz	"Jan"
date_time_L.str.1:
	.asciz	"Feb"
date_time_L.str.2:
	.asciz	"Mar"
date_time_L.str.3:
	.asciz	"Apr"
date_time_L.str.4:
	.asciz	"May"
date_time_L.str.5:
	.asciz	"Jun"
date_time_L.str.6:
	.asciz	"Jul"
date_time_L.str.7:
	.asciz	"Aug"
date_time_L.str.8:
	.asciz	"Sep"
date_time_L.str.9:
	.asciz	"Oct"
date_time_L.str.10:
	.asciz	"Nov"
date_time_L.str.11:
	.asciz	"Dec"
date_time_L.str.12:
	.asciz	"Failed to find wall clock device\n"
date_time_L.str.13:
	.asciz	"\n"


# =====  END  ./date_time.asm =====



# ===== BEGIN ./directory.asm =====

	.Code
string_compare:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	sw	a2, -24(s0) 
	lw	a0, -16(s0) 
	bnez	a0, directory_LBB0_3 
	j	directory_LBB0_1 
directory_LBB0_1:
	lw	a0, -20(s0) 
	bnez	a0, directory_LBB0_3 
	j	directory_LBB0_2 
directory_LBB0_2:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	directory_LBB0_16 
directory_LBB0_3:
	lw	a0, -16(s0) 
	bnez	a0, directory_LBB0_5 
	j	directory_LBB0_4 
directory_LBB0_4:
	li	a0, -1 
	sw	a0, -12(s0) 
	j	directory_LBB0_16 
directory_LBB0_5:
	lw	a0, -20(s0) 
	bnez	a0, directory_LBB0_7 
	j	directory_LBB0_6 
directory_LBB0_6:
	li	a0, 1 
	sw	a0, -12(s0) 
	j	directory_LBB0_16 
directory_LBB0_7:
	li	a0, 0 
	sw	a0, -28(s0) 
	j	directory_LBB0_8 
directory_LBB0_8:
	lw	a0, -28(s0) 
	lw	a1, -24(s0) 
	bge	a0, a1, directory_LBB0_15 
	j	directory_LBB0_9 
directory_LBB0_9:
	lw	a0, -16(s0) 
	addi	a1, a0, 1 
	sw	a1, -16(s0) 
	lbu	a0, 0(a0) 
	sb	a0, -29(s0) 
	lw	a0, -20(s0) 
	addi	a1, a0, 1 
	sw	a1, -20(s0) 
	lbu	a0, 0(a0) 
	sb	a0, -30(s0) 
	lbu	a0, -29(s0) 
	lbu	a1, -30(s0) 
	sub	a0, a0, a1 
	sw	a0, -36(s0) 
	lw	a0, -36(s0) 
	beqz	a0, directory_LBB0_11 
	j	directory_LBB0_10 
directory_LBB0_10:
	lw	a0, -36(s0) 
	sw	a0, -12(s0) 
	j	directory_LBB0_16 
directory_LBB0_11:
	lbu	a0, -29(s0) 
	bnez	a0, directory_LBB0_13 
	j	directory_LBB0_12 
directory_LBB0_12:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	directory_LBB0_16 
directory_LBB0_13:
	j	directory_LBB0_14 
directory_LBB0_14:
	lw	a0, -28(s0) 
	addi	a0, a0, 1 
	sw	a0, -28(s0) 
	j	directory_LBB0_8 
directory_LBB0_15:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	directory_LBB0_16 
directory_LBB0_16:
	lw	a0, -12(s0) 
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
directory_Lfunc_end0:
	#	-- End function 
find_entry:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -16(s0) 
	sw	a1, -20(s0) 
	sw	a2, -24(s0) 
	li	a0, 0 
	sw	a0, -28(s0) 
	j	directory_LBB1_1 
directory_LBB1_1:
	lw	a0, -28(s0) 
	lw	a1, -20(s0) 
	bge	a0, a1, directory_LBB1_7 
	j	directory_LBB1_2 
directory_LBB1_2:
	lw	a0, -16(s0) 
	lw	a1, -28(s0) 
	slli	a1, a1, 6 
	add	a0, a0, a1 
	sw	a0, -32(s0) 
	lw	a0, -32(s0) 
	lw	a0, 0(a0) 
	beqz	a0, directory_LBB1_5 
	j	directory_LBB1_3 
directory_LBB1_3:
	lw	a0, -32(s0) 
	addi	a0, a0, 4 
	lw	a1, -24(s0) 
	li	a2, 60 
	call	string_compare 
	bnez	a0, directory_LBB1_5 
	j	directory_LBB1_4 
directory_LBB1_4:
	lw	a0, -32(s0) 
	sw	a0, -12(s0) 
	j	directory_LBB1_8 
directory_LBB1_5:
	j	directory_LBB1_6 
directory_LBB1_6:
	lw	a0, -28(s0) 
	addi	a0, a0, 1 
	sw	a0, -28(s0) 
	j	directory_LBB1_1 
directory_LBB1_7:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	directory_LBB1_8 
directory_LBB1_8:
	lw	a0, -12(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
directory_Lfunc_end1:
	#	-- End function 
search_directory:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	sw	a2, -20(s0) 
	lw	a0, -12(s0) 
	lw	a1, -16(s0) 
	lw	a2, -20(s0) 
	call	find_entry 
	sw	a0, -24(s0) 
	lw	a0, -24(s0) 
	bnez	a0, directory_LBB2_2 
	j	directory_LBB2_1 
directory_LBB2_1:
	li	a0, 0 
	sw	a0, -32(s0) # 4-byte Folded Spill 
	j	directory_LBB2_3 
directory_LBB2_2:
	lw	a0, -24(s0) 
	lw	a0, 0(a0) 
	sw	a0, -32(s0) # 4-byte Folded Spill 
	j	directory_LBB2_3 
directory_LBB2_3:
	lw	a0, -32(s0) # 4-byte Folded Reload 
	sw	a0, -28(s0) 
	lw	a0, -28(s0) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
directory_Lfunc_end2:
	#	-- End function 


# =====  END  ./directory.asm =====



# ===== BEGIN ./inode.asm =====

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


# =====  END  ./inode.asm =====

