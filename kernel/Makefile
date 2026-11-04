BUILD	  = f-build
HEAD_STUB = kernel_stub.asm
TAIL_STUB = stub_end.asm
C_SOURCES = bd_driver.c directory.c heap_alloc.c inode.c utility.c kernel.c mm_alloc.c
C_HEADERS = bd_driver.h directory.h heap_alloc.h inode.h utility.h kernel.h kernel_stub.h mm_alloc.h superblock.h types.h
ROM       = kernel-image.vmx
C_ASMS    = bd_driver.asm directory.asm heap_alloc.asm inode.asm utility.asm kernel.asm mm_alloc.asm

all: kernel

clean: kernel-clean

kernel: $(HEAD_STUB) $(TAIL_STUB) $(C_SOURCES) $(C_HEADERS)
	$(BUILD) $(ROM) $(HEAD_STUB) $(C_SOURCES) $(TAIL_STUB)

kernel-clean:
	rm -fv kernel-image.* *.s $(C_ASMS)
