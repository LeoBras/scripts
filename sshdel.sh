#!/bin/bash

# $1 line to delete

sed -i "${1}d" /home/leonardo/.ssh/known_hosts
