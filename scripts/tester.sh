function print_countdown {
        if (($1 < 10)) && (($2 < 10))
        then
        echo 0$1:0$2 | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-250 -d 1 &
        elif (($1 < 10))
        then
        echo 0$1:$2 | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-250 -d 1 &
        elif (($2 < 10))
        then
        echo $1:0$2 | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-250 -d 1 &
        else 
        echo $1:$2 | osd_cat --pos=bottom --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-250 -d 1 &
        fi
        sleep 1
}

print_countdown 5 0
for l in `seq 0 4`
do
    for m in `seq 0 4`
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
