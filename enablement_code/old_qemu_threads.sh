# $1 thread num

bye(){
	echo bye...
	exit
}

trap bye SIGINT SIGTERM
trap bye SIGTSTP

cpu=$(($1 - 1))
pid=$(virsh qemu-monitor-command --hmp bz188680-leo "info cpus" |grep \#${cpu} |cut -d= -f2 |sed 's/\r//g')

while true ; do
  virsh qemu-monitor-command --hmp bz188680-leo "info registers -a" |tee registers |grep \#${cpu} |tail -1
  cat /proc/${pid}/stat |cut -d' ' -f 1-6,40
  sleep 0.5
done
