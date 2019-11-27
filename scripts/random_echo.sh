#!/bin/bash

MINUTES=20
BREAK=1

function echo_countdown(){
        if (($1 < 10)) && (($2 < 10))
        then
        echo 0$1:0$2 #| osd_cat_br $color
        elif (($1 < 10))
        then
        echo 0$1:$2 #| osd_cat_br $color
        elif (($2 < 10))
        then
        echo $1:0$2 #| osd_cat_br $color
        else 
        echo $1:$2 #| osd_cat_br $color
        fi
        sleep .1
}

for i in `seq 0 $(($MINUTES - 1))`;
do
        for j in `seq 0 59`
        do
            mins=$(expr $(($MINUTES - 1)) - $i)
            secs=$(expr 59 - $j)
            echo_countdown $mins $secs
        done
done

#while true
#do
    #for i in {1..1000}
    #do
        #sleep .1
        #echo $$ $i 
    #done
    ##echo $RANDOM
#done


function osd_cat_br(){
    #writes to the top right of the screen.
    #The second line includes <pomodoro minutes>/<break minutes> followed by
    #the PID is displayed below the time readout for easily killing the process.
    #osd_cat needs something piped to it. osd_cat accepts raw text from cat
    color=$1
    while read data; do
        echo "$data" | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-4 -i -10 -d 1 -O 2 -c $color &
        echo $MINUTES\ /\ $BREAK\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-* --offset=50 -i -6 -d 1 -O 2 -c $color &
    done 
}

