#!/bin/bash

MINUTES=25
SECONDS=0
WILL_BREAK=1
color=red

counter_font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-*
info_font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-*

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

pipe_name=/tmp/osd_cat_pipe
mkfifo $pipe_name

/home/aaron/scripts/random_echo.sh -m $minutes > $pipe_name &

info_duration=$(expr $MINUTES * 60)

osd_cat --pos=top --align=right --font=counter_font --offset=-4 -i -10 -d 1 -O 2 -c $color -l 1 $pipe_name &
echo $MINUTES\ /\ $BREAK\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=info_font --offset=50 -i -6 -d 10 -O 2 -c $color &
