#!/bin/bash
start_time=`date '+%H:%M:%S'`
echo "starting script at $start_time..."
echo "zeroing out PCM level...";
amixer -c 1 -- set PCM -51dB > /dev/null
amixer -c 2 -- set Speaker -51dB > /dev/null
echo "sleeping for 8 hours...";
#sleep 8h;
start_ramp_time=`date '+%H:%M:%S'`
echo "starting volume ramp-up at $start_ramp_time..."
echo "playing spotify... (`date '+%H:%M:%S'`)"
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
echo "raising volume... (`date '+%H:%M:%S'`)"
increment_num=0
#for i in `seq -51 .2 0` #original seq
for i in `seq 255 -1 0`
do
    increment_num=$((increment_num+1))
    echo "setting volume to ${i}dB... ($increment_num steps)"
    read -r sys_vol usb_vol <<<$(python volume_calc.py $i)
    amixer -c 1 -- set PCM ${sys_vol}dB > /dev/null
    amixer -c 2 -- set Speaker ${usb_vol}dB > /dev/null
    #echo "i: " $i "sys_vol: " $sys_vol "usb_vol: " $usb_vol #DEBUG
    #sleep 0.01 #for debugging
    #increment chosen because (15m * 60s) / 256 increments = 3.515625
    sleep 3.515
done
end_ramp_time=`date '+%H:%M:%S'`
echo "finished volume ramp at $end_ramp_time"
echo "started script: $start_time"
echo "started ramp: $start_ramp_time"
echo "ended ramp: $end_ramp_time"
#echo "----------------------------------------" >> ~/task_log.txt
date "+%x ----------------------------------------" >> ~/pomodoro_log.txt

