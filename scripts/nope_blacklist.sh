#!/bin/bash

#example blacklist: minecraft, akrasiac, terraria,
#if a word is matched, print NOPE all over the screen with osd_cat until the offending process changes its name.

x_size=1600
y_size=900

while true; do
    matches=$(wmctrl -l | grep -wif words.txt |wc -l)
    echo $(wmctrl -l | grep -wif words.txt)
    echo $matches
    if [ "$matches" -ge "1" ]
    then
        indent=$(($RANDOM%$x_size-100)) #indent is the x axis
        offset=$(($RANDOM%$y_size-30))  #offset is the y axis
        rand_size=$(($RANDOM%200+50))
        font_string="-*-helvetica-bold-r-*-*-$rand_size-*-*-*-*-*-*-*"
        echo "NOPE" | osd_cat --pos=top --align=right --font=$font_string --offset=$offset -i $indent -d 1 -O 2 -c red &
    fi
    sleep .05
done

