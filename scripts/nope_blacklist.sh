#!/bin/bash

#check whether any window titles (grepping a list of words)
#match any of the blacklist words

#example blacklist: minecraft, akrasiac, terraria, "let's play"
#if a word is matched, print NOPE all over the screen with osd_cat until the offending process changes its name.

#randomly choose a place on the screen
x_size=1600
y_size=900

#spawn 10 or so osd_cat instances at once when a window name is detected?

while true; do
    matches=$(wmctrl -l | grep -wif words.txt |wc -l)
    if [ "$matches" -ge "1" ]
    then
        for i in {0..5}
        do
            indent=$(($RANDOM%$x_size-100))
            offset=$(($RANDOM%$y_size-30))
            rand_size=$(($RANDOM%200+50))
            font_string="-*-helvetica-bold-r-*-*-$rand_size-*-*-*-*-*-*-*"
            echo "NOPE" | osd_cat --pos=top --align=right --font=$font_string --offset=$offset -i $indent -d 1 -O 2 -c red &
        done
    fi
    sleep 1
done

