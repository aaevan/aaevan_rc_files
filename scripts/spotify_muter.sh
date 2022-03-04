counter_font=-*-helvetica-bold-r-*-*-20-*-*-*-*-*-*-*¬                    

raw_title=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 1 xesam:title | grep variant)

raw_length=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 1 mpris:length | grep variant)

#echo title: $raw_title | osd_cat -o 0 --font=$counter_font -d 5 --color=red &
#echo raw_length: $raw_length | osd_cat -o 20 --font=$counter_font -d 5 --color=red &

#this is cute, but I'd need to do different parsing to strip out the title:
    #raw_metadata=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata')
    #raw_title=$(echo $raw_metadata | grep -A 1 xesam:title | grep variant)
    #raw_length=$(echo $raw_metadata | grep -A 1 mpris:length | grep variant)
    #echo $raw_title
    #echo $raw_length

#the length of the track in millionths of a second:

# if the current track is an ad, the output of raw_length will be the following:
# variant                uint64 30000000

# IFS='"' splits $raw_title on the double quotes
# there's two words followed by a quoted string
# the second quote is thrown out because it's a separator
# $junk is everything before the first quote, we only care about $title

IFS='"' read -r junk title <<< $raw_title
length=$(expr $(echo $raw_length | cut -d " " -f 3) / 1000000)

echo title is \"$title\"
echo length is $length seconds

if [ "$title" = "" ] || [ "$title" = "Advertisement" ]
then
    echo "it's an ad!"
    amixer -D pulse sset Master mute¬
    ~/scripts/timer_echo.sh -m 0 -s $length | osd_cat -l 1 --font=$counter_font --color=green
    #-o just means a vertical offset of 20 pixels:
    echo PID: $$ | osd_cat -o 20 --font=$counter_font -d $length --color=green
    sleep $length
    amixer -D pulse sset Master unmute¬
else
    echo "it's not an ad!"
fi

# do a while loop and test every second, if not an ad, break from the loop and unmute
# by default, poll every 5s or something


