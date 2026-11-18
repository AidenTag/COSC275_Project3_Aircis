# Test CREATE.  Exits with CREATE's result as the status (0 = success).

	.Code

	li	a0,	0xca110008	# CREATE
	la	a1,	filename
	ecall

	mv	a1,	a0		# exit status = CREATE's result
	li	a0,	0xca110001	# EXIT
	ecall

	.Text

filename:	.asciz	"file"
