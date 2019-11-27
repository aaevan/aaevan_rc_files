MINUTES=25
BREAK=5
color=red

function osd_cat_br(){
    #writes to the top right of the screen.
    #The second line includes <pomodoro minutes>/<break minutes> followed by
    #the PID is displayed below the time readout for easily killing the process.
    #osd_cat needs something piped to it. osd_cat accepts raw text from cat
    color=$1
    #while read data; do
    #echo "$data" | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-4 -i -10 -d 1 -O 2 -c $color &
    #echo $MINUTES\ /\ $BREAK\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-* --offset=50 -i -6 -d 1 -O 2 -c $color &
    #done 
}

pipe_name=/tmp/osd_cat_pipe
mkfifo $pipe_name

/home/aaron/scripts/random_echo.sh > $pipe_name &

#osd_cat --pos=middle --align=center --color=red --font=-*-helvetica-bold-r-*-*-100-*-*-*-*-*-*-* --outline=4 --offset=-100 -d 2 -l 1 $pipe_name &
osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=-4 -i -10 -d 1 -O 2 -c $color -l 1 $pipe_name &
#osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-* --offset=50 -i -6 -d 1 -O 2 -c $color &
echo $MINUTES\ /\ $BREAK\ \|\ PID:$$ | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-12-*-*-*-*-*-*-* --offset=50 -i -6 -d 10 -O 2 -c $color &
osd_cat_br
