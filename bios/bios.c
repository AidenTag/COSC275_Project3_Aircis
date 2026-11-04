/* =============================================================================================================================== */
/* INCLUDES */

#include <stdbool.h>
#include <stdint.h>

#include "bd_driver.h"
#include "bios_stub.h"
#include "date_time.h"
#include "directory.h"
#include "inode.h"
#include "superblock.h"
#include "types.h"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Allocation a portion of RAM that is at least a given size and allocated in blocks.  This function allocates space via simple
 * pointer-bumping; no free space is managed.
 *
 * \param size The minimum number of bytes to allocate.
 * \return the address of a space whose length is at least `size` bytes and is a multiple of `block_size`; `0` if allocation failed.
 */
address_t block_allocate (word_t size) {

  /* How many blocks to allocate?  Account for a partial block. */
  word_t num_blocks = size / BYTES_PER_BLOCK;
  if (num_blocks * BYTES_PER_BLOCK < size) {
    num_blocks += 1;
  }
  word_t num_bytes = num_blocks * BYTES_PER_BLOCK;

  /* Allocate the space if possible. */
  statics_s* statics   = get_statics();
  address_t  base      = statics->heap_limit;
  address_t  stack_pointer;
  __asm__ volatile ("mv %0, sp" : "=r" (stack_pointer));
 if (base + num_bytes > stack_pointer) {
    return 0;
  }
  statics->heap_limit += num_bytes;
  return base;
  
} // block_allocate ()
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Load the kernel and jump to it.
 */
int main () {

  /* Intro... */
  print("Fivish BIOS+ v.2026-10-24\n");
  print("(c) Scott F. Kaplan | sfkaplan@amherst.edu\n");

  /* Find and show the time & date. */
  show_now();

  /* Grab the ad-hoc statics region and initialize its fields... */
  statics_s* statics = get_statics();

  /*   (a) The DMA portal. */
  dt_entry_s* dt_controller = find_device(controller_device_code, 1);
  if (dt_controller == NULL) {
    print("ERROR: Bus controller not found");
    abort(controller_search_failure_code);
  }
  statics->DMA_portal = (DMA_portal_s*)(dt_controller->limit - sizeof(*statics->DMA_portal));

  /*   (b) The block device portal. */
  dt_entry_s* dt_block_device = find_device(block_device_code, 1);
  if (dt_block_device == NULL) {
    print("ERROR: Block device not found\n");
    abort(block_device_search_failure_code);
  }
  statics->bd_portal = (bd_portal_s*)dt_block_device->base;

  /*   (c) RAM space for a heap. */
  statics->heap_base  = (statics->dt_RAM->base + statics->dt_RAM->limit) / 2;
  statics->heap_limit = statics->heap_base;

  print("  Kernel: Finding...");
    
  /* Read the superblock to get the location of the directory. */
  address_t      block_space     = block_allocate(BYTES_PER_BLOCK);
  bd_read_block(SUPERBLOCK_BLOCK, block_space);
  superblock_s*  superblock      = (superblock_s*)block_space;
  block_number_t directory_block = superblock->directory_block;
  superblock = NULL;

  /* Read the directory inode, and then the directory itself. */
  bd_read_block(directory_block, block_space);
  inode_s*           inode   = (inode_s*)block_space;
  directory_entry_s* entries = (directory_entry_s*)block_allocate(inode->length);
  if (entries == NULL) {
    print("ERROR: Failed to allocate memory for directory\n");
    abort(allocation_failure_code);
  }
  read_file((address_t)entries, inode);

  /* Find the `kernel` file (if it exists), and then read it. */
  int            num_entries  = inode->length / sizeof(directory_entry_s);
  block_number_t kernel_block = search_directory(entries, num_entries, "kernel.vmx");
  if (kernel_block == 0) {
    print("ERROR: Failed to find kernel.vmx\n");
    abort(kernel_file_failure_code);
  }

  /* Copy the kernel into the base of RAM, then jump there. */
  print("Loading...");
  bd_read_block(kernel_block, block_space);
  read_file(statics->dt_RAM->base, inode);
  print("Vectoring...\n\n");
  jump_to_kernel(statics->dt_RAM->base);

  /* Keep compiler happy, but we shouldn't be here. */
  return -1;

} /* main () */
/* =============================================================================================================================== */
