#! /usr/bin/env bash

function show_usage_and_exit () {
    printf "USAGE: ${0} <filename> <size (4 KB blocks)>\n"
    exit 1
}

if [[ $# != 2 ]]; then
    show_usage_and_exit
fi

filename=${1}
size=${2}

printf "Creating the block device..."
dd if=/dev/urandom of="${filename}" bs=4K count=${size} > ${filename}.log 2>&1
if [[ $? != 0 ]]; then
    printf "failed!\n"
    exit 1
fi
printf "done.\n"
