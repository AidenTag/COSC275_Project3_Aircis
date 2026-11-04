# fstool

A file system tool (`fstool`) that is external to the _Fivish_ system for creating and manipulating a virtual block device
storing a _Fstool_.

## Building

First, so that you may not only compile this code, but link it with the proper libraries to run as a normal program (that is,
_outside_ of the _Fivish_ simulator), you must install `gcc`:

```
  (sys2) $ micromamba install gcc
```

Once you have done that, you can build `fstool` with the build-script:

```
  (sys2) $ ./build.sh
```

## Creating the block device

The _Fivish_ simulator's block device is just a file, and the `fstool` tool needs such a file to use as though it were a sequence
of 4 KB blocks.  In order to create such a block device file, use the `make-block-device.sh` script:

```
  (sys2) $ ./make-block-device.sh bd 1024
```

This command will create a file named `bd` in your current directory, and then it will fill it with zeros, such that the file's size
is 1,024 4KB blocks, or 4 MB.

## Using the tool

First, see the commands:
```
  (sys2) $ ./fstool
  ERROR: Insufficient arguments
  USAGE: ./fstool format <block device path>
          list   <block device path>
          cpin   <block device path> <source path> <destination filename>
          cpout  <block device path> <destination path> <source filename>
          delete <block device path> <filename>
```

Once you have a block device file, you can format it as a _Neville File System_:

```
  (sys2) $ ./fstool format bd
```

You can then copy a file or two into that file system:

```
  (sys2) $ ./fstool cpin bd README.md readme.md
  (sys2) $ ./fstool cpin bd inode.c incode.c
```

Then list the directory to see them:

```
  (sys2) $ ./fstool list bd
```

And maybe copy one of them out, to see that it's the same as the original:
```
  (sys2) $ ./fstool cpout bd README-copy.md readme.md
```
