# A test of system calls.

	.Code

	li	a0,	0xca110000	# NOOP
	ecall

	li	a0,	0xca110002	# PRINT
	la	a1,	msg
	ecall

	li	a0,	0xca110004	# GETLENGTH
	la	a1,	my_filename
	ecall

	# after this the length should be in a0
	mv a1, a0
	# after this length should be in a1 BUT PRINT CAN'T HANDLE INTS SO DOESN'T ACTUALLY WORK BUT ALL GOOD

	li a0,   0xca110002 # PRINT
	ecall

	li a0 	0xcall0005 # GETDIR

	
	li	a0,	0xca110001	# EXIT
	li	a1,	0xd04e
	ecall
	
	.Text

my_filename:	"do-nothing.vmx"
msg:	"User program printing a message!\n"
	
