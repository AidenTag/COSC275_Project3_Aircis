// ==================================================================================================================================
/**
 * Kernel-side bitmap and block allocation.  A stripped-down version of fstool/bitmap.c: no C library (no assert), no
 * block_device_s, and no ORDER() byte swapping, since the kernel runs on the target and the on-disk values are already in
 * its native byte order.
 *
 * These functions only change the in-memory copy of the bitmap (and the superblock's mra_block).  The caller reads the bitmap
 * block with bd_read_block() first and writes it back with bd_write_block() afterwards.
 *
 * \file bitmap.c
 **/
// ==================================================================================================================================

#include "bitmap.h"

/** Is this block free? */
bool is_free (bitmap_entry_t* bitmap, block_number_t block) {

  int byte_offset = block / BITS_PER_BYTE;
  int bit_offset  = block % BITS_PER_BYTE;

  return (bitmap[byte_offset] & (1 << bit_offset)) == 0;

}

/** Mark a block as used. */
void mark_allocated (bitmap_entry_t* bitmap, block_number_t block) {

  int byte_offset = block / BITS_PER_BYTE;
  int bit_offset  = block % BITS_PER_BYTE;

  bitmap[byte_offset] |= (1 << bit_offset);

}

/** Mark a block as free (for delete). */
void mark_free (bitmap_entry_t* bitmap, block_number_t block) {

  int byte_offset = block / BITS_PER_BYTE;
  int bit_offset  = block % BITS_PER_BYTE;

  bitmap[byte_offset] &= ~(1 << bit_offset);

}

/**
 * Find a free block, mark it used, and return its number.  Searches linearly starting just after the most recently allocated
 * block, wrapping around once.
 *
 * \return the allocated block number, or `0` if the device is full.  (Block 0 is the superblock, so it is never a valid result.)
 */
block_number_t alloc_block (superblock_s* sb, bitmap_entry_t* bitmap) {

  block_number_t current_block = (sb->mra_block + 1) % sb->length;

  while (current_block != sb->mra_block) {

    if (is_free(bitmap, current_block)) {
      mark_allocated(bitmap, current_block);
      sb->mra_block = current_block;
      return current_block;
    }

    current_block = (current_block + 1) % sb->length;

  }

  return 0;

}
