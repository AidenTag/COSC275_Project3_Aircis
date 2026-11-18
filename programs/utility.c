/* =============================================================================================================================== */
/* INCLUDES */

#include <stdbool.h>
#include "syscall.h"
#include "utility.h"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* CONSTANTS */

#define BYTES_PER_WORD  4
#define BITS_PER_BYTE   8
#define BITS_PER_NYBBLE 4
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void int_to_hex (word_t value, char* buffer) {

  static char hex_digits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

  /* Traverse the value from most to least significant bits. */
  for (int shift = BYTES_PER_WORD * BITS_PER_BYTE - BITS_PER_NYBBLE; shift >= 0; shift -= BITS_PER_NYBBLE) {

    /* Grab the next nybble and add its corresponding digit to the string, advancing the string's pointer. */
    word_t nybble = (value >> shift) & 0xf;
    *buffer++ = hex_digits[nybble];
    
  }

  /* Finish the string with a null termination. */
  *buffer = '\0';
  
} /* int_to_hex () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void int_to_dec (word_t value, char* buffer) {

  /* A space to place the digits as they are produced in reverse order. */
  char temp[12];

  /* Special case: 0. */
  if (value == 0) {
    buffer[0] = '0';
    buffer[1] = '\0';
    return;
  }
  
  /* Append digits until no more remain. */
  int i = 0;
  while (value != 0) {

    int digit = value % 10;
    value /= 10;
    temp[i++] = '0' + digit;
    
  }

  /* Reverse the digits as they are placed into the given buffer. */
  i -= 1;
  while (i >= 0) {
    *buffer++ = temp[i--];
  }
  
  /* Finish the string with null termination. */
  *buffer = '\0';

} /* int_to_dec () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void print_dec (word_t value) {

  char buffer[16];
  int_to_dec(value, buffer);
  print(buffer);

} /* print_dec () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void print_hex (word_t value) {

  char buffer[16];
  int_to_hex(value, buffer);
  print(buffer);

} /* print_hex () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
int string_length (char* str) {

  if (str == NULL) return 0;

  int length = 0;
  while (*str != '\0') {
    ++length;
    ++str;
  }

  return length;
  
} /* string_length () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
int string_compare (char* str_A, char* str_B) {

  if (str_A == NULL && str_B == NULL) return 0;
  if (str_A == NULL) return 1;
  if (str_B == NULL) return -1;

  while (true) {

    if (*str_A == *str_B) {
      if (*str_A == '\0') {
	return 0;
      }
      str_A++;
      str_B++;
    } else if (*str_A < *str_B) {
      return -1;
    } else {
      return 1;
    }
    
  }
  
} /* string_compare () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* HEAP ALLOCATION (user-space copy of kernel/heap_alloc.c, minus the debug printing) */

#include <stddef.h>

#define ADDR_SIZE (sizeof(address_t))
#define ALIGN_UP(addr) (addr % ADDR_SIZE == 0 ? addr : (addr + ADDR_SIZE) & ~(ADDR_SIZE - 1))

#define HEADER_TO_BLOCK(p) ((void*)((address_t)p + sizeof(header_s)))
#define BLOCK_TO_HEADER(p) ((header_s*)((address_t)p - sizeof(header_s)))

typedef struct header {

  word_t         size;
  struct header* next;
  struct header* prev;

} header_s;

/* A pair of sentinels to the free list, making the coding easier. */
header_s free_head = { .next = NULL, .prev = NULL, .size = 0 };
header_s free_tail = { .next = NULL, .prev = NULL, .size = 0 };

/* The current limit of the heap. */
address_t heap_limit = (address_t)NULL;

/* The end of the statics (a label in stub_end.asm), at which the heap begins. */
extern address_t statics_limit;

/* Initialize the heap.  If it is already initialized, do nothing. */
static void heap_init () {

  if (heap_limit != (address_t)NULL) return;

  heap_limit     = (address_t)&statics_limit;
  free_head.next = &free_tail;
  free_tail.prev = &free_head;

} /* heap_init () */



void* allocate (int size) {

  heap_init();

  /* Blocks must always be allocated in word/address-sized chunks. */
  size = ALIGN_UP(size);

  /* Search the free list for a block of sufficient size. */
  header_s* current = free_head.next;
  while (current != &free_tail) {

    if (current->size >= size) {
      current->prev->next = current->next;
      current->next->prev = current->prev;
      current->next       = NULL;
      current->prev       = NULL;
      break;
    }
    current = current->next;

  }

  /* If we did not find a free block to use, make a new one at the end of the heap. */
  if (current == &free_tail) {
    current        = (header_s*)heap_limit;
    current->size  = size;
    heap_limit    += sizeof(header_s) + size;
  }

  return HEADER_TO_BLOCK(current);

} /* allocate () */



void deallocate (void* ptr) {

  if (ptr == NULL) return;

  /* Insert the block at the front of the free list. */
  header_s* header     = BLOCK_TO_HEADER(ptr);
  header->next         = free_head.next;
  header->prev         = &free_head;
  free_head.next->prev = header;
  free_head.next       = header;

} /* deallocate () */
/* =============================================================================================================================== */
