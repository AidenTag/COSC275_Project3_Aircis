# Project 3

## Marci, Aiden, Ailís

## Testing

All commands are run from the project root. Build `fstool` with the `sys2` environment OFF (or will give failed to link error). Everything else needs `sys2` on.

    $ micromamba deactivate
    $ (cd fstool && make)
    $ micromamba activate sys2

Build the rest:

    (sys2) $ (cd bios && make)
    (sys2) $ (cd kernel && make)
    (sys2) $ (cd programs && make)

(`programs/` reports an assembly error for `syscall-test-prog.vmx`. We do not use that program.)

### Run a test

    (sys2) $ ./test.sh create-test
    (sys2) $ ./test.sh create-write-test

If you get "permission denied", run `chmod +x test.sh` once, or use `bash test.sh create-test`.

`test.sh` makes a fresh block device, formats it, copies in the kernel (as `kernel.vmx`) and the chosen test program (as `init.vmx`, the program the kernel starts), and launches the simulator.

Within the simulator, enter `step 10000` a few times until the console shows `Halting...`, then enter `show console text`, then `exit`.

### Test 1: create-test

Calls `create` on a new file.

#### What you should see

    [kernel:] Initializing trap table...done.
    [kernel:] RUN init.vmx
    [debug: ] allocate(4096) -> ...
    [debug: ] deallocate(...) [size = 4096]
    [debug: ] allocate(88) -> ...
    [debug: ] allocate(4096) -> ...
    [debug: ] allocate(4096) -> ...
    finished create!
    [debug: ] deallocate(...) [size = 4096]
    [debug: ] deallocate(...) [size = 4096]
    [kernel:] EXIT pid 0 with status 0
    [debug: ] deallocate(...) [size = 4096]
    [kernel:] All processes terminated
    [kernel:] Halting...

(Addresses vary between runs.) This shows the kernel loading a program from the file system, running it, and `create` adding a file that is then found in the directory.

### Test 2: create-write-test

Calls `create`, then `write`.

#### What you should see

    [kernel:] RUN init.vmx
    ...
    finished create!
    ...
    CREATE: ok
    ...
    [kernel:] Default handler called.
    [kernel:] Halting...

`create` succeeds (`CREATE: ok`). The `write` call that follows crashes the kernel (see Known issues).

## Known issues and limitations (we are going to work on these on our own time)

- **`write` on a newly created (empty) file crashes** with "Default handler called". Likely causes: the whole-file buffer is allocated at the file's old size (0 bytes) but the new data is copied into it, and `create` does not clear the new inode's `blocks[]`.
- **File system changes are in memory only.** `create`, `write`, `rename`, and `delete` update the kernel's copy of the directory and bitmap but do not write the directory back to the block device, so changes are visible within one run but do not persist between runs. We decided this was acceptable for now.
- **`getlength`, `getdir`, `read`, `rename`, and `delete` are implemented in `kernel/kernel.c` but are not covered by a test program**, so they are untested. We know of likely problems in `rename`, `delete`, and `getdir`: they do not translate user-space addresses (base and limit) the way `read` and `write` do, and `delete` does not write the bitmap back.
- **`init` was not rewritten to read `runlist.txt`.** The kernel starts whatever program is stored as `init.vmx` on the block device, which is how the tests above are run.
- **`do_run()` does not translate a filename passed from a user program**, so the RUN system call only works for the kernel's own initial launch.