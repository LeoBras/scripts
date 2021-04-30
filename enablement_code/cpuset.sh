#!/bin/bash

#$1 first cpu for cpu0
#$2 second cpu for cpu0

for i in {0..3}; do
  c=""
  for a in $@ ; do
    c="$((8 * $i + $a)),$c"
  done
  virsh vcpupin bz188680-leo $i $c
done

virsh vcpupin bz188680-leo
