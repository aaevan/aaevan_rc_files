#!/bin/bash
MINUTES=25
SECONDS=0
WILL_BREAK=1

counter_font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-*
info_font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-*
big_font=-*-helvetica-bold-r-*-*-100-*-*-*-*-*-*-*
info_string=$MINUTES\ /\ $BREAK\ \|\ PID:$$ 

#handle arguments:
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

pipe_name=/tmp/osd_cat_pipe
mkfifo $pipe_name

function print_countdown(){
        color=$3
        if (($1 < 10)) && (($2 < 10))
        then
        echo 0$1:0$2 | osd_cat_br $color
        #echo 0$1:0$2 > $pipe_name
        elif (($1 < 10))
        then
        echo 0$1:$2 | osd_cat_br $color
        #echo 0$1:$2 > $pipe_name
        elif (($2 < 10))
        then
        echo $1:0$2 | osd_cat_br $color
        #echo $1:0$2 > $pipe_name
        else 
        echo $1:$2 | osd_cat_br $color
        #echo $1:$2 > $pipe_name
        fi
        sleep 1
}

info_duration=$(($MINUTES * 60))
#Break duration is a fifth the length of the pomodoro interval.
BREAK=$(expr $MINUTES / 5)
BREAKSUBONE=$(expr $BREAK - 1)

#TESTING:
#osd_cat --pos=top --align=right --font=counter_font --offset=-4 -i -10 -d 1 -O 2 -c $color -l 1 $pipe_name &
#echo $MINUTES\ /\ $BREAK\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=info_font --offset=50 -i -6 -d $info_duration -O 2 -c $color &

echo BEGIN! | osd_cat --pos=middle --align=center --color=#00ff00 --font=$big_font --outline=4 --offset=-100 -d 2 &


print_countdown $MINUTES 0 red
echo "Starting timer for $MINUTES minutes followed by a $BREAK minute break."
for i in `seq 0 $(($MINUTES - 1))`;
do
        for j in `seq 0 59`
        do
            mins=$(expr $(($MINUTES - 1)) - $i)
            secs=$(expr 59 - $j)
            print_countdown $mins $secs red
        done
done    

#flash TAKE A BREAK four times:
for k in `seq 1 4`;
do
        echo TAKE A BREAK. | osd_cat --pos=middle --align=center --color=green --font=$big_font --outline=4 --offset=-100 -d 1 &
        sleep 2
done

#start the countdown timer:
print_countdown $BREAK 0 green
for l in `seq 0 $BREAKSUBONE`
do
    for m in `seq 0 59`
    do
        mins=$(expr $BREAKSUBONE - $l)
        secs=$(expr 59 - $m)
        print_countdown $mins $secs green
    done
done

if [ $WILL_BREAK -eq 1 ];
    then
    echo AGAIN? | osd_cat --pos=middle --align=center --color=red --font=$big_font --outline=4 --offset=-100 -d 999 &
    if zenity --question --text="Again?";
        then
        killall osd_cat
        ~/scripts/pomodoro.sh -m $MINUTES -s $SECONDS -b $WILL_BREAK & 
        else
        killall osd_cat
        exit
    fi
fi
