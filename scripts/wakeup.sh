#!/bin/bash
echo "zeroing out PCM level...";
amixer -c 1 -- set PCM -51dB > /dev/null
echo "Read for 30 minutes!";
sleep 30m;
echo "Sleeping for 8 hours...";
sleep 8h;
echo "playing spotify... (`date '+%H:%M:%S'`)"
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
echo "raising volume... (`date '+%H:%M:%S'`)"
for i in `seq -51 .2 0`
do
    echo "setting volume to ${i}dB..."
    amixer -c 1 -- set PCM ${i}dB > /dev/null
    sleep 3
done
echo "finished at `date '+%H:%M:%S'`"
