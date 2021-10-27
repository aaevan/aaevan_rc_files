#!/bin/bash

#TODO: write a wrapper that can be applied to any script and
#      passed into crontab, accept parameters (script and chance)

echo "take a short break and think!"
aplay ~/scripts/chime.wav -q &
sleep 40
killall aplay
