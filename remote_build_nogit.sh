#!/bin/bash

#$1 -> Local: /home/user/...
#$2 -> Host : user@server.domain.com:/home/user/...
#$3 -> Build command
#$4 -> subfolder (optional)


#Vars
src="$1/$4"
targ="$2/$4"
server=$(echo $2 | cut -d':' -f 1)
dir=$(echo $2 | cut -d':' -f 2)

#Sync
time rsync -av $src $targ


#Build
ssh $server "
cd $dir
$3
"
