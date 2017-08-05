 #!/bin/bash

echo PID:$BASHPID | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-15-*-*-*-*-*-*-* --offset=-10 -d 1499 &

function finish {
    killall osd_cat
}
trap finish EXIT

function osd_cat_br {
    #osd_cat needs something piped to it-- we can't pipe directly to a function
    #so first the data needs to be read.
    while read data; do
        echo "$data" | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-250 -d 1 &
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

print_countdown 25 0
for i in `seq 0 24`;
do
        for j in `seq 0 59`
        do
            mins=$(expr 24 - $i)
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
    if zenity --question --text="Again?";
        then
        ~/scripts/pomodoro.sh & 
        else
        exit
    fi



