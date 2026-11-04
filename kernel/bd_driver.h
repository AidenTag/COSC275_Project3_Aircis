// ==================================================================================================================================
/**
 * Functions for accessing the block device.
 *
 * \file bd_driver.h
 **/
// ==================================================================================================================================


// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "types.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES AND STRUCTURES

typedef word_t block_number_t;
typedef char   block_t[BYTES_PER_BLOCK];
// ==================================================================================================================================



// ==================================================================================================================================
// CONSTANTS

/* The operation codes to trigger the block device to perform an action. */
#define BD_OP_READ    -1
#define BD_OP_GETSIZE  0
#define BD_OP_WRITE    1

/* Return codes for the operations. */
#define BD_SUCCESS             0
#define BD_INVAL_BLOCK_NUMBER -1
#define BD_INVAL_BUFFER       -2
// ==================================================================================================================================



// ==================================================================================================================================
// EXPORTED FUNCTIONS

/**
 * Read a given block into a memory buffer.
 *
 * \param block_number The block number to read on the device.
 * \param buffer       The space into which to read.
 * \return `0` upon success, `-1` for an invalid block number, `-2` for an invalid buffer, and `-3` any other error in accessing the
 *         device.
 */
int bd_read_block (block_number_t block_number, address_t buffer);

/**
 * Write a memory buffer into a given block.
 *
 * \param block_number The block number to write on the device.
 * \param buffer       The data to write.
 * \return `0` upon success, `-1` for an invalid block number, `-2` for an invalid buffer, and `-3` any other error in accessing the
 *         device.
 */
int bd_write_block (block_number_t block_number, address_t buffer);

/**
 * Get the size of the device.
 *
 * \return the number of block available in the device.
 */
word_t bd_get_length ();
//==================================================================================================================================
