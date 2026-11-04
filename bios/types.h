/* =============================================================================================================================== */
#if !defined (_TYPES_H)
#define _TYPES_H
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* INCLUDES */

#include <stdint.h>
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* CONSTANTS */

#define BYTES_PER_WORD    4 
#define BITS_PER_BYTE     8
#define BITS_PER_NYBBLE   4
#define BYTES_PER_ADDRESS BYTES_PER_WORD
#define BYTES_PER_PAGE    4096
#define WORDS_PER_PAGE    (BYTES_PER_PAGE / BYTES_PER_WORD)

#define PAGE_OFFSET_BITS  12
#define PAGE_NUMBER(addr) (addr >> PAGE_OFFSET_BITS)
#define PAGE_NUMBER_MASK  (0xffffffff << PAGE_OFFSET_BITS)
#define PAGE_BASE(addr)   (addr & PAGE_NUMBER_MASK)
#define PAGE_OFFSET_MASK  (~PAGE_NUMBER_MASK)
#define PAGE_OFFSET(addr) (addr & PAGE_OFFSET_MASK)

#define BYTES_PER_BLOCK     BYTES_PER_PAGE
#define BLOCK_OFFSET_BITS   12
#define BLOCK_NUMBER(index) (index >> BLOCK_OFFSET_BITS)
#define BLOCK_NUMBER_MASK   (0xffffffff << BLOCK_OFFSET_BITS)
#define BLOCK_BASE(index)   (index & BLOCK_NUMBER_MASK)
#define BLOCK_OFFSET_MASK   (~BLOCK_NUMBER_MASK)
#define BLOCK_OFFSET(index) (index & BLOCK_OFFSET_MASK)
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* MACROS */

/** The minimum of two values. */
#define MIN(a,b) ((a < b) ? a : b)
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* TYPES */

typedef uint32_t address_t;
typedef uint32_t word_t;

#if !defined(NULL)
#define NULL ((void*)0)
#endif /* NULL */

typedef struct dt_entry {
  word_t    type;
  address_t base;
  address_t limit;
} dt_entry_s;

typedef struct DMA_portal {
  address_t src;
  address_t dst;
  word_t    length;
} DMA_portal_s;

typedef struct bd_portal {
  char      buffer[BYTES_PER_PAGE];
  word_t    block_number;
  word_t    op_trigger;
} bd_portal_s;

typedef struct clock_portal {
  uint32_t seconds;
  uint32_t milliseconds;
  uint32_t trigger;
} clock_portal_s;

typedef struct statics {
  dt_entry_s*   dt_console;
  word_t        console_cursor_column;
  dt_entry_s*   dt_RAM;
  DMA_portal_s* DMA_portal;
  bd_portal_s*  bd_portal;
  address_t     heap_base;
  address_t     heap_limit;
} statics_s;
/* =============================================================================================================================== */



/* =============================================================================================================================== */
#endif /* _TYPES_H */
/* =============================================================================================================================== */
