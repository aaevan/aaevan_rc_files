#!/bin/bash

monitor_state="`xset q | grep Monitor`"

if [[ "$monitor_state" == *"is On"* ]]; then
    rand_val=$RANDOM
    #the max val for $RANDOM is 32000, so a value of 1000 is a 1:32 chance
    one_in_32=$(($(($rand_val<1000))==1))
    if [ $one_in_32 == 1 ];
        then
        echo "take a short break and think!"
        aplay ~/scripts/chime.wav -q &
        sleep 40
        killall aplay
    fi
fi

