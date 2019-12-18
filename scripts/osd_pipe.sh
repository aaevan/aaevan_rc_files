#!/bin/bash

MINUTES=25
SECONDS=0
WILL_BREAK=1
color=red

COUNTERFONT=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-*
INFOFONT=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-*

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

convertsecs() {
    h=$(bc <<< "${1}/3600")
    m=$(bc <<< "(${1}%3600)/60")
    s=$(bc <<< "${1}%60")
    printf "%d %d %d\n" $h $m $s
}

pipe_name=/tmp/osd_cat_pipe
mkfifo $pipe_name

/home/aaron/scripts/timer_echo.sh -m $MINUTES -s $SECONDS > $pipe_name &

info_duration=$(($MINUTES * 60))
total_secs=$(($MINUTES * 60 + $SECONDS))
read -r h m s <<< `convertsecs $total_secs`
read -r bh bm bs <<< `convertsecs $(($total_secs / 5))`
echo total:$h\h:$m\m:$s\s
echo break:$bh\h:$bm\m:$bs\s

osd_cat --pos=top --align=right --font=$COUNTERFONT --offset=-4 -i -10 -d 2 -O 2 -c $color -l 1 $pipe_name &
echo $MINUTES\ /\ $bm\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=$INFOFONT --offset=50 -i -6 -d $info_duration -O 2 -c $color &
