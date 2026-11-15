// ==================================================================================================================================
/**
 * Functions that manage the bitmap and block allocation.
 * 
 * \file bitmap.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include "bitmap.h"
#include "block-device.h"
#include "superblock.h"
#include "utilities.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES

typedef uint8_t bitmap_entry_t;
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Determine whether a block is free.
 * 
 * \param bitmap The bitmap of free/used blocks.
 * \param block  The block number to check.
 * \return `true` if the block is _free_; `false` otherwise.
 */
bool is_free (bitmap_entry_t* bitmap, block_number_t block) {

  assert(bitmap != NULL);

  int byte_offset = block / (sizeof(*bitmap) * BITS_PER_BYTE);
  int bit_offset  = block % (sizeof(*bitmap) * BITS_PER_BYTE);

  return (bitmap[byte_offset] & (1 << bit_offset)) == 0;
    
}
// ==================================================================================================================================




// ==================================================================================================================================
/**
 * Mark the given block as _used_ in the bitmap.
 * 
 * \param bitmap The bitmap of free/used blocks.
 * \param block  The block number to mark as _free_.
 */
void mark_allocated (bitmap_entry_t* bitmap, block_number_t block) {

  assert(bitmap != NULL);
  assert(is_free(bitmap, block));
  
  int byte_offset = block / (sizeof(*bitmap) * BITS_PER_BYTE);
  int bit_offset  = block % (sizeof(*bitmap) * BITS_PER_BYTE);
  
  bitmap[byte_offset] |= (1 << bit_offset);

}
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Mark the given block as _free_ in the bitmap.
 * 
 * \param bitmap The bitmap of free/used blocks.
 * \param block  The block number to mark as _free_.
 */
void mark_free (bitmap_entry_t* bitmap, block_number_t block) {

  assert(bitmap != NULL);
  assert(!is_free(bitmap, block));

  int byte_offset = block / (sizeof(*bitmap) * BITS_PER_BYTE);
  int bit_offset  = block % (sizeof(*bitmap) * BITS_PER_BYTE);

  bitmap[byte_offset] &= (~(1 << bit_offset));
  
}
// ==================================================================================================================================


// ==================================================================================================================================
block_number_t alloc_block (superblock_s* sb, bitmap_entry_t* bitmap)  {

  // Search linearly, starting after the most recently allocated block until we wrap all the way around.
  block_number_t current_block = (ORDER(sb->mra_block) + 1) % ORDER(sb->length);
  bool found = false;
  while (!found && current_block != ORDER(sb->mra_block)) {
    
    if (is_free(bitmap, current_block)) {
      found = true;
    } else {
      current_block = (current_block + 1) % ORDER(sb->length);
    }

  }

  // Was a free block found?
  if (found) {

    // Yes.  Mark it allocated and remember that it was the most recently allocated, then return it.
    mark_allocated(bitmap, current_block);
    sb->mra_block = ORDER(current_block);
    return current_block;

  } else {

    // No, failure to allocate.
    return 0;

  }
    
} // alloc_block ()
// ==================================================================================================================================



// ==================================================================================================================================
void free_block (block_device_s* bd, block_number_t block) {

  // Grab the superblock and the bitmap.
  assert(bd != NULL);
  assert(block > 0);
  superblock_s*   sb     = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);
  bitmap_entry_t* bitmap = bd_block_to_ptr(bd, ORDER(sb->bitmap_block));

  // Mark the block as free.
  mark_free(bitmap, block);

} // free_block ()
// ==================================================================================================================================
