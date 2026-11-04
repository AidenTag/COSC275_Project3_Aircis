/* =============================================================================================================================== */
/* INCLUDES */

#include <stdbool.h>
#include <stdint.h>

#include "directory.h"
#include "heap_alloc.h"
#include "kernel.h"
#include "kernel_stub.h"
#include "mm_alloc.h"
#include "superblock.h"
#include "types.h"
#include "utility.h"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* CONSTANTS */

#define INIT_ROM_NUMBER 3

#define SYSCALL_NOOP      0xca110000
#define SYSCALL_EXIT      0xca110001
#define SYSCALL_PRINT     0xca110002
#define SYSCALL_RUN       0xca110003
#define SYSCALL_GETLENGTH 0xca110004
#define SYSCALL_GETDIR    0xca110005
#define SYSCALL_READ      0xca110006
#define SYSCALL_WRITE     0xca110007
#define SYSCALL_CREATE    0xca110008
#define SYSCALL_DELETE    0xca110009
#define SYSCALL_RENAME    0xca11000a

#define SYSCALL_INVALID_CODE -1

#define RUN_ERROR_NO_FILE    -1
#define RUN_ERROR_HEAP_ALLOC -2
#define RUN_ERROR_MM_ALLOC   -3
#define RUN_ERROR_TOO_LARGE  -4

/**
 * The offset of where `a0` is stored on the preservation stack relative to `sp`.  `a0 = x10`, so it is the 10th register,
 * subtracting the 2 that are not preserved (`zero` and `sp` itself), plus 1 for starting one full word back from `sp`.
 */
#define PRESERVED_A0_OFFSET ( -(10 - 2 + 1) * BYTES_PER_WORD )

#define SCHEDULER_QUANTUM 0x100

#define INIT_FILENAME     "init.vmx"
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* TYPES */

typedef struct process {
  struct process* next;
  struct process* prev;
  address_t       base;
  address_t       limit;
  word_t          epc;
  word_t          sp;
  word_t          id;
  filename_t      executable;
} process_s;
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/* GLOBALS */

/** The currently active process. */
process_s*    current_process = NULL;

/** The next available process ID. */
word_t        next_process_ID = 0;

/** The loaded superblock. */
superblock_s* superblock      = NULL;

/** The loaded directory inode. */
inode_s*      directory_inode = NULL;

/** The loaded directory. */
directory_entry_s* directory_entries = NULL;
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Insert a new process after the current one in the process list.
 *
 * \param process The new process to insert.
 */
void insert_process (process_s* process) {

  /* Special case: This is the first process. */
  if (current_process == NULL) {
    current_process = process;
    process->next = process;
    process->prev = process;
    return;
  }

  /* Insert the process after the current one. */
  process->next         = current_process->next;
  process->prev         = current_process;
  current_process->next = process;
  process->next->prev   = process;

} /* insert_process () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Remove a given process from the process list.  If it is the current one, update the current process pointer to the next process.
 *
 * \param process The process to remove.
 */
void remove_process (process_s* process) {

  /* Special case: This is the last process. */
  if (process->next == process) {
    current_process = NULL;
    process->next   = NULL;
    process->prev   = NULL;
    return;
  }

  /* If this process is the current one, advance to the next process. */
  if (process == current_process) {
    current_process = current_process->next;
  }
  
  /* Remove the process from its position in the list. */
  process->next->prev = process->prev;
  process->prev->next = process->next;
  process->next       = NULL;
  process->prev       = NULL;

} /* remove_process () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Determine whether it is time to switch to another process -- whether the quanta expired.
 */
void cpu_scheduler () {

  /* Is it time for a context switch? */
  word_t cycles;
  if (quantum_expired()) {

    /* Move to the next process in the list and jump into it with a whole new quantum. */
    current_process = current_process->next;
    cycles          = SCHEDULER_QUANTUM;
    
  } else {

    /* Time is left on this quantum, so finish it (by requesting 0 new cycles for the next scheduling). */
    cycles = 0;

  }
    
  userspace_jump(current_process->epc, current_process->sp, current_process->base, current_process->limit, cycles);
  
} // cpu_scheduler ()
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Perform the NOOP syscall.
 */
void do_noop () {

  DEBUG("NOOP requested");

  /* Advance the process PC so that it resumes after the ecall. */
  current_process->epc += 4;

} /* do_noop () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Perform the EXIT syscall.  Terminate and remove this process, choosing another to become the current process.
 *
 * \param status The exiting status of the process.
 */
void do_exit (word_t status) {

  print("[kernel:] EXIT pid ");
  print_dec(current_process->id);
  print(" with status ");
  print_dec(status);
  print("\n");

  /* Deallocate the process's main memory space. */
  mm_deallocate(current_process->base);

  /* Remove the process from the process list and deallocate its object. */
  process_s* process = current_process;
  remove_process(process);
  deallocate(process);

} /* do_exit () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Perform the RUN syscall.  Create a new process, loading the executable image from a given ROM to initialize it.
 *
 * \param filename The filename of the executable image to load.
 * \return the new process ID if successful; <code>-1</code> if the ROM number is invalid, <code>-2</code> if process object
 *         allocation failed, or <code>-3</code> if main memory allocation failed.
 */
word_t do_run (char* filename) {

  print("[kernel:] RUN ");
  __asm__ volatile ("ebreak");
  print(filename);
  print("\n");

  /* If this is not the initial process being created, advance the current process PC so that it resumes after the ecall. */
  if (current_process != NULL) {
    current_process->epc += 4;
  }

  /* Allocate main memory for the process. */
  address_t base = mm_allocate();
  if (base == 0) {
    return RUN_ERROR_MM_ALLOC;
  }

  /* Attempt to read the executable file into the main memory block. */
  int result = read_filename_to_buffer(base, filename, MM_BLOCK_SIZE);
  if (result < 0) {
    mm_deallocate(base);
    if (result == FS_NO_SUCH_FILE)
      return RUN_ERROR_NO_FILE;
    else
      return RUN_ERROR_TOO_LARGE;
  }
  
  /* Create a new process object insert it. */
  process_s* process = allocate(sizeof(*process));
  if (process == NULL) {
    mm_deallocate(base);
    return RUN_ERROR_HEAP_ALLOC;
  }
  process->epc        = 0;
  process->sp         = MM_BLOCK_SIZE;
  process->id         = next_process_ID++;
  string_copy(process->executable, filename, sizeof(process->executable));

  insert_process(process);
  
  return process->id;

} /* do_run () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Perform the PRINT syscall.  Print a given null-terminated string to the console.
 *
 * \param msg A pointer to a null-terminated string in the process's address space.
 * \return <code>0</code> if the message was successfully printed; <code>-1</code> otherwise (e.g., the string pointer was invalid.)
 */
word_t do_print (address_t msg) {

  /* Translate the string's pointer from a virtual to a physical address, verifying that it is in range. */
  msg = msg + current_process->base;
  if (msg >= current_process->limit) {
    return -1;
  }
  
  /* Make the printing happen. */
  print((char*)msg);

  /* Advance the process PC so that it resumes after the ecall. */
  current_process->epc += 4;
  
  return 0;
  
} /* do_print () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Carry out a syscall.  <b>Does not return.</b>
 *
 * \param code The requested syscall type
 * \param arg0 An additional argument; whether it is relevant depends upon which syscall is requested.
 */
void do_syscall (word_t code, word_t arg0) {

  /* Copy the preserved epc & sp into the process's info. */
  current_process->epc = preserved_epc;
  current_process->sp  = preserved_sp;
  
  /* Dispatch on the requested system call by code. */
  bool   has_return_value = false;
  word_t result           = 0;
  if (code == SYSCALL_NOOP) {

    do_noop();

  } else  if (code == SYSCALL_EXIT) {
    
    do_exit(arg0);
    /* Special case: If the last process just exited, halt the kernel. */
    if (current_process == NULL) {
      print("[kernel:] All processes terminated\n");
      halt_kernel();
    }

  } else if (code == SYSCALL_RUN) {
    
    has_return_value = true;
    result = do_run((char*)arg0);

  } else if (code == SYSCALL_PRINT) {
    
    has_return_value = true;
    result = do_print((address_t)arg0);
    
  } else {
    
    result = SYSCALL_INVALID_CODE;
    
  }

  /* If there is a return value, copy it into the current process's preserved a0 register space on its stack. */
  if (has_return_value) {
    word_t* preserved_a0 = (word_t*)(current_process->base + current_process->sp + PRESERVED_A0_OFFSET);
    *preserved_a0        = result;
  }

  /* Schedule a process. */
  cpu_scheduler();
  
} /* do_syscall () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Process a clock alarm interrupt with a context switch.  <b>Does not return.</b>
 */
void do_alarm (word_t code, word_t arg0) {

  /* Copy the preserved epc & sp into the process's info. */
  current_process->epc = preserved_epc;
  current_process->sp  = preserved_sp;

  /* The scheduler will determine what process to run and then run it. */
  cpu_scheduler();
  
} /* do_alarm () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
#define FS_METADATA_SUPERBLOCK 0
#define FS_METADATA_DIRINODE   1
#define FS_METADATA_DIRFILE    2
/**
 * Initialize the file system by preloading the superblock and directory.
 */
void fs_init () {

  /* This should only be called once, so if it's called a second time, issue a warning. */
  static block_t* fs_metadata_blocks = NULL;
  if (fs_metadata_blocks != NULL) {
    print("[kernel:] WARNING: fs_init() unexpectedly re-called\n");
    return;
  }
  
  /* Allocate a main memory space to hold the file system metadata. */
  fs_metadata_blocks = (block_t*)mm_allocate();
  if (fs_metadata_blocks == NULL) {
    print("[kernel:] Failed allocation for file system metadata\n");
    halt_kernel();
  }

  /* Read the superblock. */
  superblock = (superblock_s*)&fs_metadata_blocks[FS_METADATA_SUPERBLOCK];
  if (bd_read_block(SUPERBLOCK_BLOCK, (address_t)superblock) < 0) {
    print("[kernel:] Failed to read superblock\n");
    halt_kernel();
  }

  /* Read the directory inode. */
  directory_inode = (inode_s*)&fs_metadata_blocks[FS_METADATA_DIRINODE];
  if (bd_read_block(superblock->directory_block, (address_t)directory_inode) < 0) {
    print("[kernel:] Failed to read directory inode\n");
    halt_kernel();
  }

  /* Read the directory file itself. */
  directory_entries = (directory_entry_s*)&fs_metadata_blocks[FS_METADATA_DIRFILE];
  int bytes_remaining = MM_BLOCK_SIZE - (2 *  BYTES_PER_BLOCK);
  if (read_inode_to_buffer((address_t)directory_entries, directory_inode, bytes_remaining) < 0) {
    print("[kernel:] Failed to read directory file\n");
    halt_kernel();
  }

} /* fs_init () */
/* =============================================================================================================================== */



/* =============================================================================================================================== */
/**
 * Run the initial user program (`init`).
 */
void run_init () {

  /* Prepare the file system. */
  fs_init();

  /* Call the RUN syscall handler to perform the actual loading and execution of init. */
  int result = do_run(INIT_FILENAME);
  if (result < 0) {
    if (result == RUN_ERROR_NO_FILE) {
      print("[kernel:] No init.vmx found\n");
    } else {
      print("[kernel:] Failed to run init\n");
    }
    halt_kernel();
  }

  /* Schedule a process -- this process. */
  cpu_scheduler();

} /* run_init () */
/* =============================================================================================================================== */
