#!/bin/bash

#area_gif
#sleep 10; 
timestamp=$(date '+%m-%d-%y_%H-%M-%S')
eval $(xdotool getmouselocation --shell);
X=$(($X - 200))
Y=$(($Y - 200))
shutter -s=$X,$Y,400,400 -e --output=~/Pictures/area_gif_output/$timestamp.png
byzanz-record -d 10 -w 400 -h 400 -x $X -y $Y ~/Pictures/area_gif_output/$timestamp.gif
