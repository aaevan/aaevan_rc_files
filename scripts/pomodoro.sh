#!/bin/bash
MINUTES=25
SECONDS=0
WILL_BREAK=1

counter_font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-*
info_font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-*
big_font=-*-helvetica-bold-r-*-*-100-*-*-*-*-*-*-*
info_duration=$(($MINUTES * 60))

#handle optional arguments:
while getopts ":m:s:b:" opt; do
  case $opt in
    m)
      echo "-m was triggered, Parameter: $OPTARG" >&2
      MINUTES=$OPTARG
      ;;
    s)
      echo "-s was triggered, Parameter: $OPTARG" >&2
      SECONDS=$OPTARG
      ;;
    b)
      echo "-b was triggered, Parameter: $OPTARG" >&2
      WILL_BREAK=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo inputs:
echo MINUTES:$MINUTES
echo SECONDS:$SECONDS

convertsecs() {
    h=$(bc <<< "${1}/3600")
    m=$(bc <<< "(${1}%3600)/60")
    s=$(bc <<< "${1}%60")
    printf "%d %d %d\n" $h $m $s
}

#Break duration is a fifth the length of the pomodoro interval.

total_secs=$(($MINUTES * 60 + $SECONDS))
read -r h m s <<< `convertsecs $total_secs`
read -r break_hours break_minutes break_seconds <<< `convertsecs $(($total_secs / 5))`

info_string=$MINUTES\ /\ $break_minutes\ \|\ PID:$$ 

function finish {
    killall osd_cat
}
trap finish EXIT

function osd_cat_br(){
    #writes to the top right of the screen.
    #The second line includes <pomodoro minutes>/<break minutes> followed by
    #the PID is displayed below the time readout for easily killing the process.
    #osd_cat needs something piped to it. osd_cat accepts raw text from cat
    color=$1
    while read data; do
        echo $data | osd_cat --pos=top --align=right --font=$counter_font --offset=-4 -i -10 -d 1 -O 2 -c $color &
        echo $info_string | osd_cat --pos=top --align=right --font=$info_font --offset=50 -i -6 -d 1 -O 2 -c $color &
    done 
}

function countdown_osd(){
    minutes_input=$1
    seconds_input=$2
    color_input=$3
    set_zero=$4
    echo minutes_input:$minutes_input, seconds_input:$seconds_input, color_input:$color_input
    if (($seconds_input > 0))
    then
        for second in `seq -w $seconds_input -1 00`
        do
            echo `printf "%02d:%02d\n" "${minutes_input#0}" "${second#0}"` | osd_cat_br $color_input
            sleep 1
        done
    else
        printf "%02d:00\n" "${minutes_input#0}" "${second#0}"
        sleep .01
    fi

    echo "Starting timer for $minutes_input minutes followed by a $break_minutes minute break."
    for minutes in `seq $(($minutes_input - 1)) -1 0`;
    do
            for seconds in `seq -w 59 -1 0`
            do
                echo `printf "%02d:%02d\n" "${minutes#0}" "${seconds#0}"` | osd_cat_br $color_input
                sleep 1
            done
    done    
}

function stopwatch(){
    color_input=$1
    minutes=0
    for minutes in `seq -w 0 999`
        do
            for seconds in `seq -w 0 59`
            do
                echo `printf "\-%02d:%02d\n" "${minutes#0}" "${seconds#0}"` | osd_cat_br $color_input
                sleep 1
            done
        done
}

echo BEGIN! | osd_cat --pos=middle --align=center --color=#00ff00 --font=$big_font --outline=4 --offset=-100 -d 2 &
countdown_osd $MINUTES $SECONDS red

echo "$MINUTES minute pomodoro finished on `date`" >> ~/pomodoro_log.txt
flash "TAKE A BREAK" six times:
for k in `seq 0 6`;
do
    echo TAKE A BREAK!| osd_cat --pos=middle --align=center --color=green --font=$big_font --outline=4 --offset=-100 -d 1 &
        sleep .5
        killall osd_cat
        sleep .5
done

countdown_osd $break_minutes $break_seconds green

if [ $WILL_BREAK -eq 1 ];
    then
    echo AGAIN? | osd_cat --pos=middle --align=center --color=red --font=$big_font --outline=4 --offset=-100 -d 999 &
    stopwatch white &
    if zenity --question --text="Again?";
        then
        killall osd_cat
        kill `jobs -p` #kill the running stopwatch
        ~/scripts/pomodoro.sh -m $MINUTES -s $SECONDS
        else
        killall osd_cat
        kill `jobs -p` #kill the running stopwatch
        exit
    fi
fi
