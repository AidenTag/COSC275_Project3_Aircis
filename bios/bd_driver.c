// ==================================================================================================================================
/**
 * Functions for accessing the block device.
 *
 * \file bd_driver.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "bd_driver.h"
#include "bios_stub.h"
#include "types.h"
// ==================================================================================================================================



// ==================================================================================================================================
void bd_read_block (block_number_t block_number, address_t buffer) {

  /* Get the block device's portal. */
  statics_s*    statics    = get_statics();
  bd_portal_s*  bd_portal  = statics->bd_portal;
  DMA_portal_s* DMA_portal = statics->DMA_portal;
  
  /* Read the block into the device's internal buffer. */
  bd_portal->block_number = block_number;
  bd_portal->op_trigger   = BD_OP_READ;      /* Trigger */
  if (bd_portal->op_trigger == -1) {
    print("ERROR: Attempt to read invalid block number\n");
    abort(block_device_access_failure_code);
  } else if (bd_portal->op_trigger == -2) {
    print("ERROR: Failure in reading block device\n");
    abort(block_device_access_failure_code);
  }

  /* Copy the block from the device's buffer into the provided memory buffer via DMA. */
  DMA_portal->src    = (address_t)bd_portal->buffer;
  DMA_portal->dst    = buffer;
  DMA_portal->length = BYTES_PER_BLOCK;   /* Trigger */
  
} // read_block ()
// ==================================================================================================================================
