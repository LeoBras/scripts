#!/bin/bash

#$1 funcname

out=$(stap -L "kernel.statement(\"${1}@*:*\")")
f_line=$(echo "$out" | head -1 | cut -d\" -f 2 |cut -d":" -f 2)
l_line=$(echo "$out" | tail -1 | cut -d\" -f 2 |cut -d":" -f 2)
f_name=$(echo "$out" | tail -1 | cut -d\" -f 2 |cut -d":" -f 1 |cut -d"@" -f 2 )
n_lines=$((${l_line} - ${f_line} + 1))

echo "$out"
cat -n /lib/modules/$(uname -r)/source/${f_name} |head -${l_line} |tail -${n_lines}
