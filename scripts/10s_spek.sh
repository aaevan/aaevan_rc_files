#!/bin/bash
big_font=-*-helvetica-bold-r-*-*-100-*-*-*-*-*-*-*
filename=~/spek_clips/sound_clip_$(date '+%m-%d-%y_%H-%M-%S').wav
arecord -vv -fdat -d 10 $filename &
for seconds in `seq -w 10 -1 0`
do
    message_text="(recording: $seconds)"
    echo $message_text | osd_cat --pos=middle --align=center --color=green --font=$big_font --outline=4 --offset=-100 -d 1 &
    sleep 1
done
spek $filename
