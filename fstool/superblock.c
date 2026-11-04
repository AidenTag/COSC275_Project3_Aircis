// ==================================================================================================================================
/**
 * The superblock functions.
 *
 * \file superblock.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <assert.h>
#include "superblock.h"
#include "utilities.h"
// ==================================================================================================================================




// ==================================================================================================================================
void initialize_superblock (block_device_s* bd) {

  // Grab a pointer to the superblock.
  assert(bd != NULL);
  superblock_s* sb = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);

  // These values will never change.
  sb->magic_cookie    = ORDER(MAGIC_COOKIE);
  sb->length          = ORDER(bd->length);

  // These values will be changed by later initialization and use.
  sb->bitmap_block    = ORDER(0);
  sb->directory_block = ORDER(0);
  sb->mra_block       = ORDER(0);

} // initialize_superblock ()
// ==================================================================================================================================



// ==================================================================================================================================
bool verify_superblock (block_device_s* bd) {

  // Grab a pointer to the superblock.
  assert(bd != NULL);
  superblock_s* sb = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);

  // Return whether the superblock contains the expected magic cookie value.
  return sb->magic_cookie == ORDER(MAGIC_COOKIE);
  
} // verify_superblock ()
// ==================================================================================================================================
