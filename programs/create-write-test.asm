# create-write-test.asm
#
# Test CREATE and WRITE: create a file, fill a heap buffer with a message, write it to the file, then check the file's length.
# Build with stub.asm, utility.c (allocate), syscall.asm (print), and stub_end.asm.

	.Code

main:
	addi	sp,	sp,	-16
	sw	ra,	12(sp)
	sw	s0,	8(sp)			# s0 = buffer
	sw	s1,	4(sp)			# s1 = message length

	## CREATE the file.  Should return 0.
	li	a0,	0xca110008		# CREATE
	la	a1,	filename
	ecall
	la	t0,	create_ok
	beqz	a0,	print_create
	la	t0,	create_fail
print_create:
	mv	a0,	t0
	call	print

	## Allocate a buffer and copy the message into it.
	li	a0,	64
	call	allocate
	mv	s0,	a0

	la	t0,	message
	mv	t1,	s0
	li	s1,	0
copy:
	lbu	t2,	0(t0)
	sb	t2,	0(t1)
	beqz	t2,	copy_done
	addi	t0,	t0,	1
	addi	t1,	t1,	1
	addi	s1,	s1,	1
	j	copy
copy_done:

	## WRITE the buffer to the file.  Should return the number of bytes written.
	li	a0,	0xca110007		# WRITE
	la	a1,	filename		# filename
	li	a2,	0			# offset
	mv	a3,	s1			# length
	mv	a4,	s0			# buffer
	ecall
	la	t0,	write_ok
	beq	a0,	s1,	print_write
	la	t0,	write_fail
print_write:
	mv	a0,	t0
	call	print

	## GETLENGTH should now match the message length.
	li	a0,	0xca110004		# GETLENGTH
	la	a1,	filename
	ecall
	la	t0,	length_ok
	beq	a0,	s1,	print_length
	la	t0,	length_fail
print_length:
	mv	a0,	t0
	call	print

	li	a0,	0
	lw	ra,	12(sp)
	lw	s0,	8(sp)
	lw	s1,	4(sp)
	addi	sp,	sp,	16
	ret

	.Text

filename:	.asciz	"file"
message:	.asciz	"Hello from create-write-test!"

create_ok:	.asciz	"CREATE: ok\n"
create_fail:	.asciz	"CREATE: failed\n"
write_ok:	.asciz	"WRITE: ok\n"
write_fail:	.asciz	"WRITE: failed\n"
length_ok:	.asciz	"GETLENGTH: matches\n"
length_fail:	.asciz	"GETLENGTH: wrong length\n"
