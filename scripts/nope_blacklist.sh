#!/bin/bash

#if a word is matched from words.txt, print NOPE all over the screen with osd_cat until the offending process changes its name.

#change the below lines to your screen resolution:
x_size=1600
y_size=900
warning="NOPE"

while true; do
    matches=$(wmctrl -l | grep -wif words.txt |wc -l)
    echo $(wmctrl -l | grep -wif words.txt)
    #echo $matches
    if [ "$matches" -ge "1" ]
    then
        indent=$(($RANDOM%$x_size-100)) #indent is the x axis
        offset=$(($RANDOM%$y_size-30))  #offset is the y axis
        rand_size=$(($RANDOM%200+50)) #pick a random font size from 50 to 250
        font_string="-*-helvetica-bold-r-*-*-$rand_size-*-*-*-*-*-*-*" 
        echo $warning | osd_cat --pos=top --align=right --font=$font_string --offset=$offset -i $indent -d 1 -O 2 -c red &
    fi
    sleep .05
done

