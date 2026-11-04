BUILD	=	f-build

all: bios

clean: bios-clean

bios: bios_stub.h bios_stub.asm bios.c bd_driver.h bd_driver.c date_time.h date_time.c directory.h directory.c inode.h inode.c \
      superblock.h types.h
	$(BUILD) bios-rom.vmx bios_stub.asm bios.c bd_driver.c date_time.c directory.c inode.c

bios-clean:
	rm -fv bios-rom.*                \
               bios.s bios.asm           \
               bd_driver.s bd_driver.asm \
               date_time.s date_time.asm \
               directory.s directory.asm \
               inode.s inode.asm
