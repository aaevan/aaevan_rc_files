#f3 --> tab * 9 --> space --> enter
delay=15
#xdotool keydown --delay $delay Return 
#xdotool keyup --delay $delay Return
xdotool keydown --delay $delay F3
xdotool keyup --delay $delay F3
for i in $(seq 1 9)
do
    xdotool keydown --delay $delay Tab
    xdotool keyup --delay $delay Tab
done
xdotool keydown --delay $delay space
xdotool keyup --delay $delay space
for i in $(seq 1 2)
do
    xdotool keydown --delay $delay Return
    xdotool keyup --delay $delay Return
done
