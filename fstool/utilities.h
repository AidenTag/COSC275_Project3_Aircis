// ==================================================================================================================================
/**
 * Some pre-packaged functions that are useful everywhere.
 *
 * \file utilities.h
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <stdio.h>
#include <stdlib.h>
// ==================================================================================================================================



// ==================================================================================================================================
// MACROS

/** The system's page size. */
#define PAGE_SIZE 4096

/** Calculate the number of bytes in `n` kilobytes. */
#define KB(n)  ((size_t)n * 1024)

/** Calculate the number of bytes in `n` megabytes. */
#define MB(n)  (KB(n) * 1024)

/** Calculate the number of bytes in `n` gigabytes. */
#define GB(n)  (MB(n) * 1024)

/** The number of bits in a byte. */
#define BITS_PER_BYTE    8

/** The size of an address/word on this architecture. */
#define BYTES_PER_WORD   sizeof(uintptr_t)

/** The number of bits in an address/word on this architecture. */
#define BITS_PER_WORD    (BYTES_PER_WORD * BITS_PER_BYTE)

/** The minimum of two values. */
#define MIN(a,b) ((a < b) ? a : b)

/** The maximum of two values. */
#define MAX(a,b) ((a > b) ? a : b)

/** Emit an error message and exit. */
#define ABORT(...) {				\
    fprintf(stderr, "ERROR: ");                 \
    fprintf(stderr, ##__VA_ARGS__);		\
    exit(EXIT_FAILURE);                         \
  }

/** Emit a debugging message (or, if disabled, remove such output). */
#if defined (DEBUG_MSGS)
#define DEBUG(...) {					\
    fprintf(stderr, "DEBUG: ");				\
    fprintf(stderr, ##__VA_ARGS__);			\
  }
#else
#define DEBUG(...)
#endif /* DEBUG_MSGS */

#if defined (SWAP_ENDIANNESS)

/* Reorder the bytes, dependent on the size of the value. */
#define ORDER(x)							\
  ( sizeof(x) == 1 ? x :						\
    sizeof(x) == 2 ? ( ((x & 0xff00) >> 8) | ((x & 0x00ff) << 8) ) :	\
    sizeof(x) == 4 ? ( ((x & 0xff000000) >> 24) |			\
		       ((x & 0x00ff0000) >> 8) |			\
		       ((x & 0x0000ff00) << 8) |			\
		       ((x & 0x000000ff) << 24) ) :			\
    sizeof(x) == 8 ? ( ((x & 0xff00000000000000) >> 56) |		\
		       ((x & 0x00ff000000000000) >> 40) |		\
		       ((x & 0x0000ff0000000000) >> 24) |		\
		       ((x & 0x000000ff00000000) >> 8)  |		\
		       ((x & 0x00000000ff000000) << 8)  |		\
		       ((x & 0x0000000000ff0000) << 24) |		\
		       ((x & 0x000000000000ff00) << 40) |		\
		       ((x & 0x00000000000000ff) << 56) ) :		\
    -1 )

#else /* ! SWAP_ENDIANNESS */

/* Do nothing to the byte order. */
#define ORDER(x) (x)

#endif /* SWAP_ENDIANNESS */
// ==================================================================================================================================
