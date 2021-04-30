#!/bin/bash

command=$(yad --title="Enter Command" --text="Enter command to run over stdin" --form --field="Command" --field="Line by Line (\"\$line\"):CHK" --geometry=750)

if echo $command |grep "|TRUE|" > /dev/null
then
    echo "$1" | while IFS= read line
    do
        export line
        bash -c "${command%|*|}"
    done
else
    echo "$1" | bash -c "${command%|*|}"
fi
