#!/usr/bin/env bash

#key=Down
key=$1
delay=$2
repeats=$3

for i in $(seq 1 $repeats)
do
        xdotool keydown --delay $delay $key
        xdotool keyup --delay $delay $key
done
