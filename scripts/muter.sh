if amixer -D pulse get Master | grep -q off; then 
    amixer -D pulse sset Master unmute
else
    amixer -D pulse sset Master mute
fi
