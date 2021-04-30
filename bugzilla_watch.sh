]#!/bin/bash
sleeptime=14
first="true"
notify-send "bzwatch start!"


while true
do
  sleep ${sleeptime}
  last=${now}
  wget -O /dev/shm/bz_watch '---bugzilla_link_here---'
  if  [ "$?" != "0" ]
  then
    notify-send "No connection"
    continue
  fi

  sleep 1

  now=$(sort -n -r /dev/shm/bz_watch |head -n -1 |cut -d, -f1)
  changes=$(diff -u <(echo "$last") <(echo "$now") |tail -n+4 |grep + |cut -d+ -f 2-)

  if [ "$first" == "true" ]
  then
    first="false"
    continue
  fi

  if [ "${changes}" == "" ]
  then
    continue
  fi

  for bug in ${changes}
  do
    notify-send "New Bug!" "https://---bugzilla-here---/show_bug.cgi?id=${bug} New bug!" 
  done

done

