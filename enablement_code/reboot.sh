#!/bin/bash -x
#  set -x

#$1 kernel name (p.ex 5.8.0-00076-ge14a29661109)
#$2 cmdline


if test -z $1; then
  hash=$(cd /home/leonardo/p10_lagarcia/ && git log --oneline -1 | awk '{print $1}')
  k=$(ls /boot/vml*$hash* |cut -d'-' -f 2-4 )
else
  k=$1
fi

if test -z "$2"; then
#  cmdline="xmon=on crashkernel=4G verbose"
  cmdline="powersave=off"
else
  cmdline="$2"
fi


kexec -l /boot/vmlinux-${k} --initrd=/boot/initrd.img-${k} --append="root=/dev/nvme0n1p2 ${cmdline}" &&
sleep 5 &&
kexec -e
