// ==================================================================================================================================
/**
 * Inode/file functions.
 *
 * \file inode.c
 */
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "inode.h"
#include "types.h"
// ==================================================================================================================================



// ==================================================================================================================================
void read_file (address_t dst, inode_s* inode) {

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
  
} // read_file ()
// ==================================================================================================================================
