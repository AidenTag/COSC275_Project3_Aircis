// ==================================================================================================================================
/**
 * A set of structs and functions for managing a block device.
 *
 * \file block-device.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <assert.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#if !defined (_WINDOWS)
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#endif

#include "block-device.h"
#include "utilities.h"
// ==================================================================================================================================



// ==================================================================================================================================
block_device_s* bd_map (char* path) {

  // Create a new block device struct to represent this open and mapped device.
  block_device_s* bd = malloc(sizeof(*bd));
  if (bd == NULL) ABORT("bd_map(): failed to allocate new block device");
  bd->path = path;

  // Dictate the size of each block.
  bd->block_size = PAGE_SIZE;

#if defined (_WINDOWS)
  // Open the given file.
  bd->fd = CreateFile(path, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
  if (bd->fd == INVALID_HANDLE_VALUE) ABORT("bd_map(): failed to open file %s", path);

  // Get the file's size and store the number of blocks it holds.
  LARGE_INTEGER filesize;
  if (!GetFileSizeEx(bd->fd, &filesize)) ABORT("bd_map(): failed to get file size for %s", path);
  bd->length = (block_number_t)(filesize.QuadPart / bd->block_size);

  // Create a file mapping object.
  bd->map = CreateFileMapping(bd->fd, NULL, PAGE_READWRITE, 0, 0, NULL);
  if (bd->map == NULL) ABORT("bd_map(): failed to create file mapping for %s", path);

  // Map the file into virtual address space.
  bd->base = MapViewOfFile(bd->map, FILE_MAP_ALL_ACCESS, 0, 0, 0);
  if (bd->base == NULL) ABORT("bd_map(): failed to map %s", path);
#else
  // Open the given file.
  bd->fd = open(path, O_RDWR);
  if (bd->fd == -1) ABORT("bd_map(): failed to open file %s", path);

  // Get the file's size and store the number of blocks it holds.
  struct stat filestat;
  if (fstat(bd->fd, &filestat) != 0) ABORT("bd_map(): failed to get the file length of %s\n", path);
  bd->length = filestat.st_size / bd->block_size;

  // Allocate virtual address space in which the block device file reside. Make it un-shared and not backed by any file (_anonymous_
  // space).  A failure to map this space is fatal.
  bd->base = mmap(NULL, bd->length * bd->block_size, PROT_READ | PROT_WRITE, MAP_SHARED, bd->fd, 0);
  if (bd->base == MAP_FAILED) ABORT("bd_map(): failed to map %s\n", path);
#endif

  bd->limit = (void*)((uintptr_t)bd->base + (bd->length * bd->block_size));

  return bd;

} // bd_map ()
// ==================================================================================================================================



// ==================================================================================================================================
void bd_unmap (block_device_s* bd) {

  if (bd == NULL) return;

#if defined (_WINDOWS)
  // Unmap, making sure that it succeeds.
  if (!UnmapViewOfFile(bd->base)) ABORT("bd_unmap(): failed to unmap %s\n", bd->path);

  // Close the mapping and file handles.
  if (!CloseHandle(bd->map)) ABORT("bd_unmap(): failed to close mapping for %s\n", bd->path);
  if (!FlushFileBuffers(bd->fd)) ABORT("bd_unmap(): failed to flush buffers for %s\n", bd->path);
  if (!CloseHandle(bd->fd)) ABORT("bd_unmap(): failed to close %s\n", bd->path);
#else
  // Unmap, making sure that it succeeds.
  if (munmap(bd->base, bd->length * bd->block_size) != 0) ABORT("bd_unmap(): failed to unmap %s\n", bd->path);

  // Flush and close the file.
  if (fsync(bd->fd) != 0) ABORT("bd_unmap(): failed to flush buffers for %s\n", bd->path);
  if (close(bd->fd) != 0) ABORT("bd_unmap(): failed to close %s\n", bd->path);
#endif

  // Release the structure.
  free(bd);
  
} // bd_unmap ()
// ==================================================================================================================================



// ==================================================================================================================================
void* bd_block_to_ptr (block_device_s* bd, int block_number) {

  if (bd == NULL) return NULL;

  // Is the block number in range?
  if (! (0 <= block_number && block_number < bd->length) ) {
    return NULL;
  }

  // It is, so return a pointer to the block.
  void* ptr = (void*)((uintptr_t)bd->base + (block_number * bd->block_size));
  assert(bd->base <= ptr && ptr < bd->limit);
  return ptr;
  
} // bd_block_to_ptr ()
// ==================================================================================================================================



// ==================================================================================================================================
int bd_ptr_to_block (block_device_s* bd, void* block_ptr) {

  if (bd == NULL) return -1;

  // Is the block pointer in range?
  if (! (bd->base <= block_ptr && block_ptr < bd->limit) ) {
    return -1;
  }

  // It is, so return the block number for this pointer.
  int block = (int)( ((uintptr_t)block_ptr - (uintptr_t)bd->base) / bd->block_size );
  assert(0 <= block && block < bd->length);
  return block;
  
} // bd_ptr_to_block ()
// ==================================================================================================================================



// ==================================================================================================================================
void bd_print (block_device_s* bd, FILE* out) {

  fprintf(out, "bd @%p:\n",           bd            );
  fprintf(out, "\tpath       = %s\n", bd->path      );
#if defined (_WINDOWS)
  fprintf(out, "\tfd         = %p\n", bd->fd        );
#else
  fprintf(out, "\tfd         = %d\n", bd->fd        );
#endif
  fprintf(out, "\tblock_size = %d\n", bd->block_size);
  fprintf(out, "\tlength     = %d\n", bd->length    );
  fprintf(out, "\tbase       = %p\n", bd->base      );
  fprintf(out, "\tlimit      = %p\n", bd->limit     );
  
} // bd_print ()
// ==================================================================================================================================
