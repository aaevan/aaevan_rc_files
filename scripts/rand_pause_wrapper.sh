#!/bin/bash

#add the following (uncommented) to roots crontab (sudo crontab -e):
#* * * * * su aaron -c "DISPLAY=:0.0 /home/aaron/scripts/rand_pause_wrapper.sh             

monitor_state="`xset q | grep Monitor`"

if [[ "$monitor_state" == *"is On"* ]]; then
    rand_val=$RANDOM
    #the max val for $RANDOM is 32000, so a value of 1000 is a 1:32 chance
    one_in_32=$(($(($rand_val<1000))==1))
    if [ $one_in_32 == 1 ];
        then
        xfce4-terminal --hide-menubar -e /home/aaron/scripts/rand_10s_pause.sh
    fi
fi

