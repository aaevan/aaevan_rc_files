#!/bin/bash

#define default values:
MINUTES=25
SECONDS=0
WILL_BREAK=1
PREFIX=""
SUFFIX=""
MS=0

#handle arguments:
while getopts ":m:s:b:p:S:" opt; do
  case $opt in
    m) #minutes
      echo "-m was triggered, Parameter: $OPTARG" >&2
      MINUTES=$OPTARG
      ;;
    s) #seconds
      echo "-s was triggered, Parameter: $OPTARG" >&2
      SECONDS=$OPTARG
      ;;
    b) #break
      echo "-b was triggered, Parameter: $OPTARG" >&2
      WILL_BREAK=$OPTARG
      ;;
    p) #prefix
      echo "-p was triggered, Parameter: $OPTARG" >&2
      PREFIX=$OPTARG
      ;;
    S) #prefix
      echo "-S was triggered, Parameter: $OPTARG" >&2
      SUFFIX=$OPTARG
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
        if (($MS==1))
        then
            for ms in `seq -w 99 -1 00`
            do
                printf "\n$PREFIX%02d:%02d:%02d$SUFFIX" "${MINUTES#0}" "${second#0}" "${ms#0}"
                sleep .01
                #clear
            done
        else
            printf "\n$PREFIX%02d:%02d$SUFFIX" "${minute#0}" "${second#0}"
            sleep 1
        fi
    done
else
    if ((MS==1))
        then
            printf "\n$MINUTES:00:00"
            sleep .01
        else
            printf "\n$MINUTES:00"
            sleep 1
    fi
fi

for minute in `seq -w $(($MINUTES - 1)) -1 0`
do
        for second in `seq -w 59 -1 0`
        do
            if (($MS==1))
            then
                for ms in `seq -w 99 -1 00`
                do
                    printf "\n$PREFIX%02d:%02d:%02d$SUFFIX" "${minute#0}" "${second#0}" "${ms#0}"
                    sleep .01
                    #clear
                done
            else
                printf "\n$PREFIX%02d:%02d$SUFFIX" "${minute#0}" "${second#0}"
                sleep 1
            fi
        done
done
