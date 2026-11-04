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
void initialize_bitmap (block_device_s* bd) {

  assert(bd != NULL);

  // How many blocks are needed for the bitmap?
  int bits_per_block    = bd->block_size * BITS_PER_BYTE;
  int num_bitmap_blocks = bd->length / bits_per_block;
  if (bd->length % bits_per_block != 0) {
    num_bitmap_blocks += 1;
  }
  int last_bitmap_block = BITMAP_BLOCK + num_bitmap_blocks - 1;

  // Get a pointer to what will become the bitmap, and clear it all.
  bitmap_entry_t* bitmap = bd_block_to_ptr(bd, BITMAP_BLOCK);
  memset((void*)bitmap, 0, num_bitmap_blocks * bd->block_size);
  
  // Mark the superblock and the bitmap blocks as used.
  mark_allocated(bitmap, SUPERBLOCK_BLOCK);
  for (block_number_t block = BITMAP_BLOCK; block <= last_bitmap_block; block += 1) {
    mark_allocated(bitmap, block);
  }

  // Get a pointer to the superblock and record (a) where the bitmap begins, and (b) where the most recently allocated block (the
  // end of the bitmap) is.
  superblock_s* sb = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);
  sb->bitmap_block = ORDER(BITMAP_BLOCK);
  sb->mra_block    = ORDER(last_bitmap_block);
    
}
// ==================================================================================================================================



// ==================================================================================================================================
block_number_t alloc_block (block_device_s* bd)  {

  // Grab the superblock and the bitmap.
  assert(bd != NULL);
  superblock_s*   sb     = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);
  bitmap_entry_t* bitmap = bd_block_to_ptr(bd, ORDER(sb->bitmap_block));

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
