// ==================================================================================================================================
/**
 * The functions for managing a directory system.
 *
 * \file directory.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "bd_driver.h"
#include "directory.h"
#include "inode.h"
#include "kernel.h"
#include "types.h"
#include "utility.h"
// ==================================================================================================================================



// ==================================================================================================================================
directory_entry_s* find_entry (directory_entry_s* entries, int num_entries, char* filename) {

  // Search each directory entry in turn.
  for (int i = 0; i < num_entries; i += 1) {

    directory_entry_s* current = &entries[i];

    // If this is a match, return the current entry.
    if (current->inode_block != 0 && string_compare(current->filename, filename, MAX_FILENAME_LEN) == 0) {

      // Yes, so return the matching entry.
      return current;

    }
    
  }

  // The search failed.
  return NULL;
  
} // find_entry ()
// ==================================================================================================================================



// ==================================================================================================================================
block_number_t search_directory (char* filename) {

  if (filename == NULL) return 0;
  
  // Search for the entry.
  int                num_entries = directory_inode->length / sizeof(directory_entry_s);
  directory_entry_s* entry       = find_entry(directory_entries, num_entries, filename);
  int                inode_block = (entry == NULL) ? 0 : entry->inode_block;

  return inode_block;

} // search_directory ()
// ==================================================================================================================================
