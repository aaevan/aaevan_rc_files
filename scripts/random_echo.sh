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

function echo_countdown(){
        if (($1 < 10)) && (($2 < 10))
        then
        echo 0$1:0$2
        elif (($1 < 10))
        then
        echo 0$1:$2
        elif (($2 < 10))
        then
        echo $1:0$2
        else 
        echo $1:$2
        fi
        sleep 1
}

echo_countdown $MINUTES $SECONDS
for i in `seq 0 $(($MINUTES - 1))`;
do
        for j in `seq 0 59`
        do
            mins=$(expr $(($MINUTES - 1)) - $i)
            secs=$(expr 59 - $j)
            echo_countdown $mins $secs
        done
done
