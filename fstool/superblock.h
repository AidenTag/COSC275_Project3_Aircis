// ==================================================================================================================================
/**
 * The superblock format and functions.
 *
 * \file superblock.h
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <stdbool.h>
#include <stdint.h>
#include "block-device.h"
// ==================================================================================================================================



// ==================================================================================================================================
// CONSTANTS

/** The block number used to store the superblock. */
#define SUPERBLOCK_BLOCK 0

/** The magic cookie that identifies the block device as formatted with this file system. */
#define MAGIC_COOKIE     0xfeedface
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES AND STRUCTURES

/** The superblock contents. */
typedef struct superblock {

  /** File system identifier. */
  uint32_t       magic_cookie;

  /** Size of the device (in number of blocks). */
  uint32_t       length;

  /** The starting block of the used/free bitmap. */
  block_number_t bitmap_block;

  /** The inode of the root directory. */
  block_number_t directory_block;

  /** The most recently allocated block number. */
  block_number_t mra_block;
  
} superblock_s;
// ==================================================================================================================================



// ==================================================================================================================================
// FUNCTION PROTOTYPES

/**
 * Initialize the superblock on a newly formatted file system.
 *
 * \param bd The block device on which to place a new superblock.
 */
void initialize_superblock (block_device_s* bd);

/**
 * Verify that a block device is formatted.
 *
 * \param bd The block device whose superblock should be tested.
 * \return `true` if the superblock contains a valid magic cookie; `false` otherwise.
 */
bool verify_superblock (block_device_s* bd);
// ==================================================================================================================================
