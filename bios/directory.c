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
#include "types.h"
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Compare two null-terminated strings for equality.
 *
 * \param strA       The first string to compare.
 * \param strB       The second string to compare.
 * \param max_length The maximum number of characters to compare.
 * \return `0` if the strings are equal, a negative value if `strA` is alphanumerically lesser, and a positive value if `strB` is
 *         alphanumerically lesser.
 */
int string_compare (const char* strA, const char* strB, int max_length) {

  /* Special cases. */
  if (strA == NULL && strB == NULL) return 0;
  if (strA == NULL) return -1;
  if (strB == NULL) return 1;
  
  /* Compare character by character. */
  for (int i = 0; i < max_length; i += 1) {

    char a = *strA++;
    char b = *strB++;
    int diff = a - b;
    if (diff != 0) return diff;
    if (a == '\0') return 0;

  }

  return 0;
  
} // string_compare ()
// ==================================================================================================================================



// ==================================================================================================================================
directory_entry_s* find_entry (directory_entry_s* entries, int num_entries, const char* filename) {

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
block_number_t search_directory (directory_entry_s* entries, int num_entries, const char* filename) {

  // Search for the entry.
  directory_entry_s* entry       = find_entry(entries, num_entries, filename);
  int                inode_block = (entry == NULL) ? 0 : entry->inode_block;

  return inode_block;

} // search_directory ()
// ==================================================================================================================================
