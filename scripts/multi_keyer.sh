#!/usr/bin/env bash
key=$1
delay=$2
repeats=$3
echo $key | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-30-*-*-*-*-*-*-* --offset=-4 -i 150 -d 1 -O 20 -c blue &
for i in $(seq 1 $repeats)
do
        xdotool keydown --delay 20 $key
        xdotool keydown --delay $delay $key
        xdotool keyup --delay $delay $key
done
