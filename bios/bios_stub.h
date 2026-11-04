/* =============================================================================================================================== */
#if !defined (_BIOS_STUB_H)
#define _BIOS_STUB_H
/* =============================================================================================================================== */



/* =============================================================================================================================== */
#include "types.h"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
extern word_t none_device_code;
extern word_t controller_device_code;
extern word_t ROM_device_code;
extern word_t RAM_device_code;
extern word_t console_device_code;
extern word_t block_device_code;
extern word_t wall_clock_device_code;
extern word_t random_device_code;

extern word_t controller_search_failure_code;
extern word_t RAM_search_failure_code;
extern word_t console_search_failure_code;
extern word_t block_device_search_failure_code;
extern word_t wall_clock_search_failure_code;
extern word_t allocation_failure_code;
extern word_t block_device_access_failure_code;
extern word_t kernel_file_failure_code;
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Search the device table for the n-th instance of a particular device type.
 *
 * \param type The code for the device type for which to search.
 * \return The address of the device table entry of the n-th instance of the given device type; <code>NULL</code> if no such
 *         instance was found.
 */
dt_entry_s* find_device (word_t type, int instance);

/**
 * Print a message to the console.
 *
 * \param msg The null-terminated string to print.
 */
void print (char* msg);

/**
 * Provide the ad-hoc statics region set up in RAM by the initial BIOS stub code.
 *
 * \return a pointer to the statics region.
 */
statics_s* get_statics ();

/**
 * Jump to the kernel.
 *
 * \param target The address at which the kernel is loaded.
 * \return <b>Does not return</b>.
 */
void jump_to_kernel (address_t target);

/**
 * Abort.  Halt the system.
 *
 * \param error A code, placed into `a0`, to indicate what error occurred.
 * \return <b>Does not return</b>.
 */
void abort (word_t error);
/* =============================================================================================================================== */




/* =============================================================================================================================== */
#endif /* _BIOS_STUB_H */
/* =============================================================================================================================== */
