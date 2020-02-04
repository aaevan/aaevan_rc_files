#system wide macro to delete an entire vim document
#ggvGdd
delay=10
xdotool keydown --delay $delay "Escape"
xdotool keyup --delay $delay "Escape"
xdotool keydown --delay $delay g
xdotool keyup --delay $delay g
xdotool keydown --delay $delay g
xdotool keyup --delay $delay g
xdotool keydown --delay $delay v
xdotool keyup --delay $delay v
xdotool keydown --delay $delay G
xdotool keyup --delay $delay G
xdotool keydown --delay $delay dollar
xdotool keyup --delay $delay dollar
xdotool keydown --delay $delay d
xdotool keyup --delay $delay d
xdotool keydown --delay $delay d
xdotool keyup --delay $delay d
