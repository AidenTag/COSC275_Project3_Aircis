// ==================================================================================================================================
/**
 * Inode/file types and functions.
 *
 * \file inode.h
 */
// ==================================================================================================================================



// ==================================================================================================================================
// Avoid multiple inclusion

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "bd_driver.h"
#include "types.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES

#define DIRECT_BLOCK_SIZE 1016
#define MAX_FILE_SIZE(bd) (DIRECT_BLOCK_SIZE * bd->block_size)

typedef struct inode {

  /** Length of the file in bytes. */
  uint32_t length;

  /** Number of directory entries pointing to this inode. */
  uint32_t link_count;

  /** The time at which the file was created. */
  uint64_t creation_time;

  /** The time at which the file was last modified. */
  uint64_t modified_time;

  /** The time at which the file was last accessed. */
  uint64_t accessed_time;

  /** Direct block numbers containing file data. */
  block_number_t blocks[DIRECT_BLOCK_SIZE];
  
} inode_s;
// ==================================================================================================================================



// ==================================================================================================================================
// FUNCTION PROTOTYPES

/**
 * Copy the file given by a filename into a provided buffer.
 *
 * \param dst      The buffer into which to copy the file's contents.
 * \param filename The name of the file to read into the buffer.
 * \param maxlen   The size of the buffer, which limits how large of a file can be read.
 * \return `0` for success, and a negative value (see `READ` syscall result codes) for failure.
 */
int read_filename_to_buffer (address_t dst, char* filename, int maxlen);

/**
 * Copy the file represented by a given inode into a provided buffer.
 * 
 * \param dst    The buffer into which to copy the file's contents.
 * \param inode  The pre-loaded inode representing the file to be copied.
 * \param maxlen The size of the buffer, which limits how large of a file can be read.
 * \return `0` for success, and a negative value (see `READ` syscall result codes) for failure.
 */
int read_inode_to_buffer (address_t dst, inode_s* inode, int maxlen);
// ==================================================================================================================================
