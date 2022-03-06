#mutes audio for 30s
message_font=-*-helvetica-bold-r-*-*-20-*-*-*-*-*-*-*
amixer -D pulse sset Master mute
~/scripts/timer_echo.sh -m 0 -s 30 -p "MUTING: " | osd_cat -l 1 --font=$message_font --color=green
killall osd_cat
amixer -D pulse sset Master unmute
