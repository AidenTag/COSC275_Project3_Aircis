// ==================================================================================================================================
/**
 * The functions for managing a directory system.
 *
 * \file directory.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "inode.h"
#include "bitmap.h"
#include "block-device.h"
#include "directory.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES

/** The complete directory, composed of its array of entries. */
typedef struct directory {

  /** The array of directory entries. */
  directory_entry_s* entries;

  /** The number of entries in the directory. */
  int                length;

} directory_s;
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Search for an entry by name in the directory.
 *
 * \param directory The directory of entries.
 * \param filename  The filename for which to search; `NULL` if an empty entry is sought.
 * \return the directory entry containing the filename if found; `NULL` otherwise.
 */
directory_entry_s* find_entry (directory_s* directory, const char* filename) {

  // Search each directory entry in turn.
  for (int i = 0; i < directory->length; i += 1) {

    directory_entry_s* current = &directory->entries[i];
    
    // Do we seek an empty entry?  And is this one?  OR, is this a full entry that contains the sought name?
    if ( (filename == NULL && ORDER(current->inode_block) == 0) ||
	 (filename != NULL && strncmp(current->filename, filename, MAX_FILENAME_LEN) == 0) ) {

      // Yes, so return the matching entry.
      return current;

    }
    
  }

  // The search failed.
  return NULL;
  
} // find_entry ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Read the directory from the block device.
 *
 * \param bd The block device.
 * \return the directory read from the block device.
 */
directory_s* read_directory (block_device_s* bd) {

  // Grab the directory file from the superblock.
  superblock_s* sb = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);

  // Create an entry array to hold the entire directory file.
  directory_s* directory   = malloc(sizeof(*directory));
  int          file_length = get_length(bd, ORDER(sb->directory_block));
  directory->length        = file_length / sizeof(*directory->entries);
  directory->entries       = malloc(file_length);

  // Sanity check: The directory file should be an integral number of entries.
  assert(file_length % sizeof(*directory->entries) == 0);

  // Read the directory file into place.
  read_file(bd, directory->entries, ORDER(sb->directory_block));

  return directory;
  
} // read_directory ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Write a directory to the block device.
 *
 * \param bd The block device.
 * \param the directory to write to the block device.
 */
void write_directory (block_device_s* bd, directory_s* directory) {

  // Grab the directory file from the superblock.
  superblock_s* sb = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);

  // Write the directory file into place.
  int file_length = directory->length * sizeof(*directory->entries);
  write_file(bd, directory->entries, file_length, ORDER(sb->directory_block));  
  
} // write_directory ()
// ==================================================================================================================================



// ==================================================================================================================================
void initialize_directory (block_device_s* bd) {

  // Create the file that will store the directory.
  block_number_t directory_block = create_inode(bd);
  assert(directory_block != 0);

  // Update the superblock with this inode.
  superblock_s* sb    = bd_block_to_ptr(bd, SUPERBLOCK_BLOCK);
  sb->directory_block = ORDER(directory_block);
   
}
// ==================================================================================================================================



// ==================================================================================================================================
bool add_directory_entry (block_device_s* bd, const char* filename, block_number_t inode_block) {

  // Grab the directory file from the block device.
  directory_s* directory = read_directory(bd);

  // Search the directory.  Is there an existing entry for this filename?
  directory_entry_s* entry    = find_entry(directory, filename);
  bool               existing = false;
  if (entry != NULL) {

    // Yes, there's an existing one, so unlink the old inode to which it is attached.
    existing = true;
    unlink_inode(bd, ORDER(entry->inode_block));
    entry->inode_block = 0;
    
  } else {

    // No existing one, so find an empty one.
    entry = find_entry(directory, NULL);

    // If there were no empty entries, expand the directory by one entry (for which we already have space).
    if (entry == NULL) {
      directory->length += 1;
      directory->entries = realloc(directory->entries, directory->length * sizeof(*directory->entries));
      entry              = &directory->entries[directory->length - 1];
      entry->inode_block = 0;
    }

    // Copy the filename into the entry.
    strncpy(entry->filename, filename, MAX_FILENAME_LEN);
    
  }
  assert(entry != NULL);
  assert(entry->inode_block == 0);

  // Assign the entry to lead to the give inode.
  entry->inode_block = ORDER(inode_block);
  link_inode(bd, inode_block);

  // Write the updated directory file back and free the directory.
  write_directory(bd, directory);
  free(directory->entries);
  free(directory);

  return existing;
  
} // add_directory_entry ()
// ==================================================================================================================================



// ==================================================================================================================================
block_number_t remove_directory_entry (block_device_s* bd, const char* filename) {

  // Grab the directory file from the block device.
  directory_s* directory = read_directory(bd);

  // Find the entry.
  directory_entry_s* entry = find_entry(directory, filename);

  // If the entry was not found, return the failure.
  if (entry == NULL) return 0;
  
  // Mark the entry as empty.
  block_number_t inode_block = ORDER(entry->inode_block);
  entry->filename[0] = '\0';
  entry->inode_block = 0;

  // Write the updated directory back and free the buffer.
  write_directory(bd, directory);
  free(directory->entries);
  free(directory);

  return inode_block;
  
} // remove_directory_entry ()
// ==================================================================================================================================



// ==================================================================================================================================
block_number_t search_directory (block_device_s* bd, const char* filename) {

  // Grab the directory file from the block device.
  directory_s* directory = read_directory(bd);

  // Search for the entry.
  directory_entry_s* entry       = find_entry(directory, filename);
  int                inode_block = (entry == NULL) ? 0 : ORDER(entry->inode_block);

  // Free the directory and return the result.
  free(directory->entries);
  free(directory);
  
  return inode_block;

} // search_directory ()
// ==================================================================================================================================



// ==================================================================================================================================
void list_directory (block_device_s* bd) {

  // Grab the directory file from the block device.
  directory_s* directory = read_directory(bd);

  // List each directory entry in turn.
  for (int i = 0; i < directory->length; i += 1) {

    directory_entry_s* current = &directory->entries[i];
    
    // If this entry is occupied...
    if (ORDER(current->inode_block) != 0) {

      // ...then get the file's length and emit the name & length pair.
      int length = get_length(bd, ORDER(current->inode_block));
      printf("%s\t%d\n", current->filename, length);

    }
    
  }
  
} // list_directory()
// ==================================================================================================================================
