#ifndef BITMAP_H
#define BITMAP_H
#include <stdbool.h>
#include <stdint.h>
#include "types.h"
#include "superblock.h"   /* superblock_s, and block_number_t via bd_driver.h */

/** One byte of the free/used bitmap: bit i of byte j describes block (j * 8 + i).  A set bit means _used_. */
typedef uint8_t bitmap_entry_t;

bool           is_free        (bitmap_entry_t* bitmap, block_number_t block);
void           mark_allocated (bitmap_entry_t* bitmap, block_number_t block);
void           mark_free      (bitmap_entry_t* bitmap, block_number_t block);
block_number_t alloc_block    (superblock_s* sb, bitmap_entry_t* bitmap);

#endif
