#!/bin/bash

#define default values:
MINUTES=25
SECONDS=0
WILL_BREAK=1

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

#echo Starting countdown for $MINUTES minutes and $SECONDS seconds.
if (($SECONDS > 0))
then
    for second in `seq -w $SECONDS -1 00`
    do
        for ms in `seq -w 99 -1 00`
        do
            printf "%02d:%02d:%02d\n" "${MINUTES#0}" "${second#0}" "${ms#0}"
            sleep .01
            #clear
        done
    done
else
    echo $MINUTES:00:00
    sleep .01
fi

for minute in `seq -w $(($MINUTES - 1)) -1 0`
do
        for second in `seq -w 59 -1 0`
        do
            for ms in `seq -w 99 -1 00`
            do
                printf "%02d:%02d:%02d\n" "${minute#0}" "${second#0}" "${ms#0}"
                sleep .01
                #clear
            done
        done
done
