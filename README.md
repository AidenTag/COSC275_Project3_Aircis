# Project 3

## Marci, Aiden, Ailís

## Testing

All commands are run from `project-3/` in the sys2 environment (except fstool which might not work if in env).

    $ micromamba activate sys2

Build everything:

    $ (cd fstool && make)
    (sys2) $ (cd bios && make)
    (sys2) $ (cd kernel && make)
    (sys2) $ (cd programs && make)

Create and format the block device, then copy files onto it:

    (sys2) $ ./fstool/make-block-device.sh bd 32
    (sys2) $ ./fstool/fstool format bd
    (sys2) $ ./fstool/fstool cpin bd kernel/kernel-image.vmx kernel.vmx
    (sys2) $ ./fstool/fstool cpin bd programs/init-prog.vmx init.vmx
    (sys2) $ ./fstool/fstool cpin bd runlist.txt runlist.txt
    (sys2) $ ./fstool/fstool cpin bd programs/do-nothing-prog.vmx do-nothing.vmx
    (sys2) $ ./fstool/fstool cpin bd programs/fib-prog.vmx fib.vmx

### Run the test

    (sys2) $

#### What you should see
