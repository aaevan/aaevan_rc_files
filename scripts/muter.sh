if amixer -D pulse get Master | grep -q off; then 
    echo yeah
    amixer -D pulse sset Master unmute
else
    echo nope
    amixer -D pulse sset Master mute
fi
