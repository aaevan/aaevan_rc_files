#!/bin/bash

MINUTES=25
SECS=0
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
      SECS=$OPTARG
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

/home/aaron/scripts/timer_echo.sh -m $MINUTES -s $SECS > $pipe_name &

info_duration=$(($MINUTES * 60))
total_secs=$(($MINUTES * 60 + $SECS))
read -r h m s <<< `convertsecs $total_secs`
echo total:$h:$m:$s
read -r bh bm bs <<< `convertsecs $(($total_secs / 5))`
echo total:$bh:$bm:$bs

echo MINUTES:$MINUTES, SECS:$SECS
echo convertsecs:`convertsecs $total_secs`
read -r h m s <<<`convertsecs $total_secs`
echo H:$h M:$m S:$s
echo info_duration:$info_duration
echo break_length:$break_length

osd_cat --pos=top --align=right --font=$COUNTERFONT --offset=-4 -i -10 -d 1 -O 2 -c $color -l 1 $pipe_name &
echo $MINUTES\ /\ $BREAK\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=$INFOFONT --offset=50 -i -6 -d $info_duration -O 2 -c $color &
