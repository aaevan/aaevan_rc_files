#!/bin/bash
sleep 1;
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
for i in `seq -51 .2 0`
do
    echo "i is: $i"
    command="amixer -c 1 -- set PCM ${i}dB"
    echo "command is: $command"
    #amixer -c 1 -- set PCM -$i%
    eval $command
    sleep 1
done
