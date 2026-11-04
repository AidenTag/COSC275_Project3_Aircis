CC            = clang
SPECIAL_FLAGS = -ggdb -Wall -DDEBUG_MSGS
#SPECIAL_FLAGS = -O3
CFLAGS        = -std=gnu99 -DSWAP_ENDIANNESS $(SPECIAL_FLAGS)

fstool: main.o bitmap.o block-device.o inode.o superblock.o directory.o
	$(CC) $(CFLAGS) -o fstool main.o bitmap.o block-device.o inode.o superblock.o directory.o

main.o: main.c utilities.h
	$(CC) $(CFLAGS) -c main.c

bitmap.o: bitmap.c bitmap.h superblock.h
	$(CC) $(CFLAGS) -c bitmap.c

block-device.o: block-device.c block-device.h utilities.h
	$(CC) $(CFLAGS) -c block-device.c

inode.o: inode.c inode.h bitmap.h
	$(CC) $(CFLAGS) -c inode.c

superblock.o: superblock.c superblock.h block-device.h
	$(CC) $(CFLAGS) -c superblock.c

directory.o: directory.c directory.h block-device.h inode.h bitmap.h
	$(CC) $(CFLAGS) -c directory.c

clean:
	rm -rf *.o fstool
