#!/bin/bash
# Usage: ./run_test.sh <program name without -prog.vmx>
# Example: ./run_test.sh create-test
set -e
rm -f bd
./fstool/make-block-device.sh bd 32
./fstool/fstool format bd
./fstool/fstool cpin bd kernel/kernel-image.vmx kernel.vmx
./fstool/fstool cpin bd programs/$1-prog.vmx init.vmx
./fstool/fstool list bd
f-simulate -b bd bios/bios-rom.vmx