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
