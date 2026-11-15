#ifndef BITMAP_H
#define BITMAP_H
#include <stdbool.h>
#include <stdint.h>
#include "types.h"
#include "block-device.h"

typedef uint8_t bitmap_entry_t;

bool is_free        (bitmap_entry_t* bitmap, block_number_t block);
void mark_allocated (bitmap_entry_t* bitmap, block_number_t block);
void mark_free      (bitmap_entry_t* bitmap, block_number_t block);
block_number_t alloc_block (superblock_s* sb, bitmap_entry_t* bitmap);
void free_block     (block_device_s* bd, block_number_t block);

#endif
