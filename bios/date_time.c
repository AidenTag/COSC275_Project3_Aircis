/* =============================================================================================================================== */
/**
 * Functions for obtaining and formatting the current date and time for display.
 *
 * \file date_time.c
 **/
/* =============================================================================================================================== */



/* =============================================================================================================================== */
#include "bios_stub.h"
#include "date_time.h"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* CONSTANTS */

/** Days in each month (for non-leap years). */
const int days_in_month[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

/** The time zone adjustment (seconds). [-4 = EDT] */
#define TZ_ADJUSTMENT (-4 * 60 * 60) 
/* =============================================================================================================================== */



/* =============================================================================================================================== */
// Check if a year is a leap year
int is_leap_year(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void int_to_str_width (char* string, uint32_t value, int width) {

  // Set the null-termination at the end.
  char* current = string + width;
  *current-- = '\0';
  
  // Now traverse the string backwards, inserting each digit.
  while (current != string - 1) {
    int digit = value % 10;
    value = value / 10;
    *current-- = (char)(digit + '0');
  }

} /* int_to_str_width () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void to_datetime (uint32_t seconds, uint32_t millis, datetime_s *dt) {

  char buffer[32];
  
  // Extract time of day (seconds within the current day)
  uint32_t seconds_today = seconds % 86400;

  dt->hour        = seconds_today / 3600;
  uint32_t seconds_in_hour = seconds_today % 3600;
  dt->minute      = seconds_in_hour / 60;
  dt->second      = seconds_in_hour % 60;
  dt->millisecond = millis;

  // Calculate days since Unix epoch (Jan 1, 1970)
  uint32_t days_since_epoch = seconds / 86400;

  // Calculate the year
  uint32_t year = 1970;
  uint32_t days_remaining = days_since_epoch;
    
  // Handle dates 1970 and after (no negative dates)
  while (1) {
    uint32_t days_this_year = is_leap_year(year) ? 366 : 365;
    if (days_remaining < days_this_year) {
      break;
    }
    days_remaining -= days_this_year;
    year++;
  }
    
  dt->year = year;
    
  // Calculate month and day within the year
  uint32_t month = 0;
  while (month < 12) {
    int days_this_month = days_in_month[month];
    // February in a leap year has 29 days
    if (month == 1 && is_leap_year(year)) {
      days_this_month = 29;
    }
        
    if (days_remaining < days_this_month) {
      break;
    }
    days_remaining -= days_this_month;
    month++;
  }
    
  dt->month = month + 1;           // Convert to 1-based
  dt->day   = days_remaining + 1;  // Convert to 1-based
  
}
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* Format a string as:  2026-Feb-26 20:13:03.835 */
void time_to_str (char* str, datetime_s* dt) {

  /*
   * Arrays must be allocated on the stack (in RAM) so that BIOS code (in ROM) can use them.  Initialize constants so that code
   * determines the PC-relative addresses of string constants.
   */
  char* month_name[12];
  month_name[0] = "Jan";
  month_name[1] = "Feb";
  month_name[2] = "Mar";
  month_name[3] = "Apr";
  month_name[4] = "May";
  month_name[5] = "Jun";
  month_name[6] = "Jul";
  month_name[7] = "Aug";
  month_name[8] = "Sep";
  month_name[9] = "Oct";
  month_name[10] = "Nov";
  month_name[11] = "Dec";

  int i = 0;
  int_to_str_width(&str[i], dt->year, 4);
  i += 4;

  str[i++] = '-';

  int m = dt->month - 1;
  str[i++] = month_name[m][0];
  str[i++] = month_name[m][1];
  str[i++] = month_name[m][2];

  str[i++] = '-';

  int_to_str_width(&str[i], dt->day, 2);
  i += 2;

  str[i++] = ' ';
    
  int_to_str_width(&str[i], dt->hour, 2);
  i += 2;

  str[i++] = ':';
    
  int_to_str_width(&str[i], dt->minute, 2);
  i += 2;

  str[i++] = ':';
    
  int_to_str_width(&str[i], dt->second, 2);
  i += 2;

  str[i++] = '.';
    
  int_to_str_width(&str[i], dt->millisecond, 3);
  i += 3;

  str[i++] = '\0';
  
}
/* =============================================================================================================================== */



/* =============================================================================================================================== */
void show_now () {

  // Find the wall clock device (1st instance, since there should be only one).
  dt_entry_s* entry = find_device(wall_clock_device_code, 1);
  if (entry == NULL) {
    print("Failed to find wall clock device\n");
    abort(wall_clock_search_failure_code);
  }

  // Trigger a buffering of the time, then read it.
  clock_portal_s* portal = (clock_portal_s*)entry->base;
  portal->trigger = 0;
  word_t seconds      = portal->seconds;
  word_t milliseconds = portal->milliseconds;

  // Adjust for the time zone, convert the time, and print it.
  datetime_s dt;
  char       str[32];
  seconds += TZ_ADJUSTMENT;
  to_datetime(seconds, milliseconds, &dt);
  time_to_str(str, &dt);
  print(str);
  print("\n");
  
} // show_now ()
/* =============================================================================================================================== */
