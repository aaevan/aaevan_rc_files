#!/bin/bash

#add the following (uncommented) to roots crontab (sudo crontab -e):
#23 0,30 * * * * su aaron -c "DISPLAY=:0.0 /home/aaron/scripts/task_log_wrapper.sh"

test_active=`xset q | grep Monitor`
substring='on'
if [[ "$test_active" == *"$substring"* ]]; then
    read -p "What are you doing right now (... at `date '+%H:%M:%S'`)? " task
    echo "`date '+%m-%d-%y @ %H-%M-%S'`: \"$task\"" >> ~/task_log.txt
fi
