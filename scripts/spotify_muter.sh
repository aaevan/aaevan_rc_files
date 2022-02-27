counter_font=-*-helvetica-bold-r-*-*-20-*-*-*-*-*-*-*¬                    

raw_title=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 1 xesam:title | grep variant)

title=`python strip_inside_quotes.py $raw_title`

echo title is \"$title\"

if [ "$is_ad" = "" ] || [ "$is_ad" = "Advertisement" ]
then
    echo "it's an ad!"
    amixer -D pulse sset Master mute¬
    ./timer_echo.sh -m 0 -s 90 | osd_cat -l 1 --font=$counter_font --color=green
    sleep 90
    amixer -D pulse sset Master unmute¬
else
    echo "it's not an ad!"
fi

# do a while loop and test every second, if not an ad, break from the loop and unmute
# by default, poll every 5s or something


