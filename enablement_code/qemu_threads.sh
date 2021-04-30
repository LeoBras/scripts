
# $1 vmname

if test -z "${1}"; then
  vmname="bz188680-leo"
else
  vmname="${1}"
fi


bye(){
	echo bye...
	exit
}

getprocs(){
  #$1 vmname
  procs=""
  for p in $(virsh qemu-monitor-command --hmp ${1} "info cpus" |grep \# |cut -d= -f2 |sed 's/\r//g'); do
    procs="${procs} $p"
  done
  echo $procs
}


trap bye SIGINT SIGTERM
trap bye SIGTSTP

procs=''
ret=1

while true ; do
  if test "$ret" -eq "1"; then
    procs=$(getprocs ${vmname})
  fi
  echo #$procs

  c=0
  R=$(virsh qemu-monitor-command --hmp ${vmname} "info registers -a")
  if test "$?" -ne "0" ; then
    sleep 5
  fi
  for i in $procs; do
    p=$(cat /proc/$i/stat |cut -d' ' -f 1-6,40)
    if test "$?" -ne 0 ; then
      ret=1
      break
    fi
    r=$(echo "$R" |grep \#${c} |tail -1)
    c=$(( $c + 1 ))
    echo -e "$p \t $r"
  done
  sleep 0.5
done
