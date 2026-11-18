BUILD	=	f-build

all: do-nothing syscall-test fib init longloop create-write-test create-test

clean: do-nothing-clean syscall-test-clean fib-clean init-clean longloop-clean create-write-test-clean create-test-clean

do-nothing: do-nothing.asm
	$(BUILD) do-nothing-prog.vmx do-nothing.asm

do-nothing-clean:
	rm -fv do-nothing-prog.*

syscall-test: syscall-test.asm
	$(BUILD) syscall-test-prog.vmx syscall-test.asm

syscall-test-clean:
	rm -fv syscall-test-prog.*

fib: stub.asm fib.c utility.c syscall.asm stub_end.asm
	$(BUILD) fib-prog.vmx stub.asm fib.c utility.c syscall.asm stub_end.asm

fib-clean:
	rm -fv fib-prog.* utility.asm utility.s fib.asm fib.s

init: stub.asm init.c utility.c syscall.asm stub_end.asm
	$(BUILD) init-prog.vmx stub.asm init.c utility.c syscall.asm stub_end.asm

init-clean:
	rm -fv init-prog.* utility.asm utility.s init.asm init.s

longloop: stub.asm longloop.c utility.c syscall.asm stub_end.asm
	$(BUILD) longloop-prog.vmx stub.asm longloop.c utility.c syscall.asm stub_end.asm

longloop-clean:
	rm -fv longloop-prog.* utility.asm utility.s longloop.asm longloop.s

create-write-test: stub.asm create-write-test.asm utility.c syscall.asm stub_end.asm
	$(BUILD) create-write-test-prog.vmx stub.asm create-write-test.asm utility.c syscall.asm stub_end.asm

create-write-test-clean:
	rm -fv create-write-test-prog.* utility.asm utility.s

create-test: create-test.asm
	$(BUILD) create-test-prog.vmx create-test.asm

create-test-clean:
	rm -fv create-test-prog.*
