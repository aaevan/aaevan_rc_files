 #!/bin/bash

MINUTES=25
SECONDS=0
WILL_BREAK=1

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

function osd_cat_br {
    #writes to the bottom right of the screen and includes the PID.
    #osd_cat needs something piped to it-- we can't pipe directly to a function
    #so first the data needs to be read.
    while read data; do
        echo "$data" | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-4 -i -10 -d 1 -O 2 &
        echo PID:$$ | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-10-*-*-*-*-*-*-* --offset=50 -i -6 -d 1 -O 2 &
        #echo "$data" | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-250 -d 1 &
        #echo PID:$$ | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-15-*-*-*-*-*-*-* --offset=-10 -d 1 &
    done 
}

function print_countdown {
        if (($1 < 10)) && (($2 < 10))
        then
        echo 0$1:0$2 | osd_cat_br
        elif (($1 < 10))
        then
        echo 0$1:$2 | osd_cat_br
        elif (($2 < 10))
        then
        echo $1:0$2 | osd_cat_br
        else 
        echo $1:$2 | osd_cat_br
        fi
        sleep 1
}

#/home/aaron/scripts/flashy_bullshit -m 'STUDY TIME!'
print_countdown $MINUTES 0
for i in `seq 0 $(($MINUTES - 1))`;
do
        for j in `seq 0 59`
        do
            mins=$(expr $(($MINUTES - 1)) - $i)
            secs=$(expr 59 - $j)
            print_countdown $mins $secs
        done
done    

for k in `seq 1 5`;
do
        echo TAKE A BREAK. | osd_cat --pos=middle --align=center --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-100 -d 1 &
        sleep 2
done

print_countdown 5 0
for l in `seq 0 4`
do
    for m in `seq 0 59`
    do
        mins=$(expr 4 - $l)
        secs=$(expr 59 - $m)
        print_countdown $mins $secs
    done
done

if [ $WILL_BREAK -eq 1 ];
    then
    if zenity --question --text="Again?";
        then
        ~/scripts/pomodoro.sh & 
        else
        exit
    fi
fi



