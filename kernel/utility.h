/* =============================================================================================================================== */
/**
 * A collection of useful functions.
 *
 * \file io.h
 */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* AVOID MULTIPLE INCLUSION */

#if !defined (_IO_H)
#define _IO_H
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* INCLUDES */

#include "types.h"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* MACROS */

#if defined (_DEBUG_ACTIVE)
#define DEBUG(msg)				\
  {						\
    print("[debug: ] ");				\
    print(msg);					\
    print("\n");				\
  }
#else /* !_DEBUG_ACTIVE */
#define DEBUG(msg)
#endif /* [!] _DEBUG_ACTIVE */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* FUNCTION PROTOTYPES */

/**
 * Convert an integer value into a null-terminated text string in base 16.  The string is always a full eight digits, including
 * leading zeros, so the buffer space provided must be at least 9 characters in length.
 *
 * \param value  The integer to convert.
 * \param buffer The space in which to construct the string.
 */
void int_to_hex (word_t value, char* buffer);

/**
 * Convert an integer value into a null-terminated text string in base 10.  The integer is always interpreted as unsigned.  Leading
 * zeros are not generated.  The buffer space should be at least 11 characters in length.
 *
 * \param value  The integer to convert.
 * \param buffer The space in which to construct the string.
 */
void int_to_dec (word_t value, char* buffer);

/**
 * Print an integer value in base 10.  The integer is always interpreted as unsigned.  Leading zeros are not generated.
 *
 * \param value The value to print.
 */
void print_hex (word_t value);

/**
 * Print an integer value in base 16.  The integer is always interpreted as unsigned.  Leading zeros are generated.
 *
 * \param value The value to print.
 */
void print_dec (word_t value);

/**
 * Return the length of a null-terminated string.
 *
 * \param str    The string to measure.
 * \param maxlen The maximum length to consider for the string.
 * \return the length of the string, or `-1` if the string is `NULL`.
 */
int string_length (char* str, int maxlen);

/**
 * Copy a null-terminated string from one buffer to another.
 *
 * \param dst    The destination buffer.
 * \param src    The source buffer.
 * \param maxlen The maximum length of the string.
 * \return `0` if the copy was successful, `-1` if either buffer pointer was `NULL`.
 */
int string_copy (char* dst, char* src, int maxlen);

/**
 * Compare two null-terminated strings for equality.
 *
 * \param strA   The first string.
 * \param strB   The second string.
 * \param maxlen The maximum length of the strings.
 * \return _Zero_ if the strings are identical up to the point of a null termination or the maximum length, a _negative_ value if
 *         alphanumerically `strA < strB`, and a _positive_ value if `strA > strB`.  A `NULL` pointer is considered alphanumerically
 *         less-than all other possible strings, including the empty string.
 */
int string_compare (char* strA, char* strB, int maxlen);
/* =============================================================================================================================== */



/* =============================================================================================================================== */
#endif /* _IO_H */
/* =============================================================================================================================== */
