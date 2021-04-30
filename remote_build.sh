#!/bin/bash

#$1 -> Host : user@server.domain:/path/to/source/
#$2 -> Build/deploy command

server=$(echo $1 | cut -d':' -f 1)
name=$(echo $server |cut -d'@' -f2 |cut -d'.' -f 1)
dir=$(echo $1 | cut -d':' -f 2)

BRANCH=$(git rev-parse --abbrev-ref HEAD)
#if [[ "$BRANCH" != "send" ]];
#then
#  if git rev-parse --verify send ;
#  then
#    git branch -m send send_$RANDOM
#  fi
#  git checkout -b send
#fi

if ! git remote | grep $name;
then git remote add $name $1
fi

git add -u .
git commit --no-gpg-sign -s -m "$(date)"
git push $name $BRANCH --force


ssh $server "
cd $dir
git  stash
#git clean -f
if ! git checkout recv ;
then git checkout -b recv
fi
git reset --hard $BRANCH
$2
#make -j80
"
