#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking pretty_baby
OFS=$IFS
IFS="
"
/usr/local/bin/ld -b elf32-i386 -m elf_i386  --dynamic-linker=/lib/ld-linux.so.2    -L. -o pretty_baby link.res
if [ $? != 0 ]; then DoExitLink pretty_baby; fi
IFS=$OFS
