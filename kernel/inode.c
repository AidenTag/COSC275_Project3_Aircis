// ==================================================================================================================================
/**
 * Inode/file functions.
 *
 * \file inode.c
 */
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "bd_driver.h"
#include "directory.h"
#include "heap_alloc.h"
#include "inode.h"
#include "kernel.h"
#include "types.h"
#include "utility.h"
// ==================================================================================================================================



// ==================================================================================================================================
int read_filename_to_buffer (address_t dst, char* filename, int maxlen) {

  if (dst == 0) return FS_INVAL_BUFFER;
  if ( (filename == NULL) || (string_length(filename, MAX_FILENAME_LEN + 1) > MAX_FILENAME_LEN) ) return FS_INVAL_NAME;

  /* Lookup the filename to get the inode. */
  block_number_t inode_block = search_directory(filename);
  if (inode_block == 0) return FS_NO_SUCH_FILE;
  
  /* Load the inode. */
  inode_s* inode = allocate(BYTES_PER_BLOCK);
  if (inode == NULL) return FS_OTHER_FAIL;
  if (bd_read_block(inode_block, (address_t)inode) < 0) {
    deallocate(inode);
    return FS_OTHER_FAIL;
  }

  /* Read the file into the buffer, release the inode, and return the outcome. */
  int result = read_inode_to_buffer(dst, inode, maxlen);
  deallocate(inode);
  inode = NULL;
  return result;
  
} /* read_filename_to_buffer () */
// ==================================================================================================================================



// ==================================================================================================================================
int read_inode_to_buffer (address_t dst, inode_s* inode, int maxlen) {

  if (dst == 0)               return FS_INVAL_BUFFER;
  if (inode == NULL)          return FS_OTHER_FAIL;
  if (inode->length > maxlen) return FS_INVAL_BUFFER;

  // Copy bytes from blocks, one block at a time, into the buffer.
  int bytes_remaining = inode->length;
  int block_number    = 0;
  while (bytes_remaining > 0) {

    // Read all the bytes from this block that are part of the file.
    int bytes_to_copy = MIN(bytes_remaining, BYTES_PER_BLOCK);
    bd_read_block(inode->blocks[block_number], dst);

    // Advance to the next block.
    dst             += bytes_to_copy;
    bytes_remaining -= bytes_to_copy;
    block_number    += 1;
    
  }

  return FS_SUCCESS;
  
} // read_inode_to_buffer ()
// ==================================================================================================================================
