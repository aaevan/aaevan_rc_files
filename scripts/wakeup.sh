#!/bin/bash
sleep 15m;
sleep 8h;
echo "playing spotify... (`date '+%H:%M:%S'`)"
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
echo "raising volume... (`date '+%H:%M:%S'`)"
for i in `seq -51 .2 0`
do
    echo "setting volume to ${i}dB..."
    amixer -c 1 -- set PCM ${i}dB > /dev/null
    sleep 2
done
echo "finished at `date '+%H:%M:%S'`"
