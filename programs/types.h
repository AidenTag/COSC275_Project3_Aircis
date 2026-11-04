#if !defined (_TYPES_H)
#define _TYPES_H

#include <stdint.h>

#if !defined (_NOT_FIVISH)

typedef uint32_t address_t;
typedef uint32_t word_t;

#else /* defined _NOT_FIVISH */

typedef uintptr_t address_t;
typedef uint32_t  word_t;

#endif /* _NOT_FIVISH */

#if !defined(NULL)
#define NULL ((void*)0)
#endif /* NULL */

#endif /* _TYPES_H */
