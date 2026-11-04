// ==================================================================================================================================
/**
 * A set of structs and functions for managing a directory system.
 *
 * \file directory.h
 **/
// ==================================================================================================================================


// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "inode.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES AND STRUCTURES

/** The maximum length of a filename. */
#define MAX_FILENAME_LEN 60

/** The form of a single entry in a directory. */
typedef struct directory_entry {

  /** The inode/file to which this entry maps; 0 if empty. */
  block_number_t inode_block;

  /** The filename, represented as a null-terminated string (if the name length is less than the maximum.) */
  char           filename[MAX_FILENAME_LEN];
  
} directory_entry_s;
// ==================================================================================================================================



// ==================================================================================================================================
// EXPORTED FUNCTIONS

/**
 * Search for a directory entry by name.
 *
 * \param entries     The table of entries to search.
 * \param num_entries The number of entries in the directory.
 * \param filename    The filename for which to search.
 * \return the block number of the inode attached to the sought entry if found; 0 if not found.
 */
block_number_t search_directory (directory_entry_s* entries, int num_entries, const char* filename);
//==================================================================================================================================
