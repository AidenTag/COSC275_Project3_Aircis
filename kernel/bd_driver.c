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
#include "kernel_stub.h"
#include "types.h"
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Provide a pointer to the block device portal.
 *
 * \return A pointer to the portal, or `NULL` if no block device can be found.
 */
bd_portal_s* get_bd_portal () {

  static bd_portal_s* bd_portal = NULL;

  if (bd_portal == NULL) {

    dt_entry_s* dt_block_device = find_device(block_device_code, 1);
    if (dt_block_device != NULL) {
      bd_portal = (bd_portal_s*)dt_block_device->base;
    }
    
  }

  return bd_portal;

} // get_bd_portal ()
// ==================================================================================================================================



// ==================================================================================================================================
int bd_read_block (block_number_t block_number, address_t buffer) {

  /* Get the block device's portal. */
  bd_portal_s*  bd_portal  = get_bd_portal();
  
  /* Read the block into the device's internal buffer. */
  bd_portal->block_number = block_number;
  bd_portal->op_trigger   = BD_OP_READ;   /* Trigger */
  if (bd_portal->op_trigger < 0) {
    return bd_portal->op_trigger;
  }

  /* Copy the block from the device's buffer into the provided memory buffer via DMA. */
  DMA_portal_ptr->src    = (address_t)bd_portal->buffer;
  DMA_portal_ptr->dst    = buffer;
  DMA_portal_ptr->length = BYTES_PER_BLOCK;   /* Trigger */

  return BD_SUCCESS;
  
} // bd_read_block ()
// ==================================================================================================================================



// ==================================================================================================================================
int bd_write_block (block_number_t block_number, address_t buffer) {

  /* Get the block device's portal. */
  bd_portal_s*  bd_portal  = get_bd_portal();
  
  /* Copy the block from the provided memory buffer into the device's buffer via DMA. */
  DMA_portal_ptr->src    = buffer;
  DMA_portal_ptr->dst    = (address_t)bd_portal->buffer;
  DMA_portal_ptr->length = BYTES_PER_BLOCK;   /* Trigger */

  /* Write the block from the device's internal buffer. */
  bd_portal->block_number = block_number;
  bd_portal->op_trigger   = BD_OP_WRITE;      /* Trigger */
  if (bd_portal->op_trigger < 0) {
    return bd_portal->op_trigger;
  }

  return BD_SUCCESS;
  
} // bd_write_block ()
// ==================================================================================================================================



// ==================================================================================================================================
word_t bd_get_length () {

  /* Get the block device's portal. */
  bd_portal_s*  bd_portal  = get_bd_portal();
  
  /* Request the size of the device. */
  bd_portal->op_trigger = BD_OP_GETSIZE;      /* Trigger */

  /* Return the result from the device. */
  return bd_portal->op_trigger;
  
} // read_block ()
// ==================================================================================================================================
