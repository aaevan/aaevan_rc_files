#!/bin/bash

# every 15 minutes, ask what task you're doing and append that (with a date) to the end of task_log.txt

#add the following (uncommented) to roots crontab (sudo crontab -e):
#0,15,30,45 * * * * su aaron -c "DISPLAY=:0.0 /home/aaron/scripts/task_log_wrapper.sh"

#0,15,30,45 * * * * means run this script every 0, 15, 30 and 45 minute mark of every hour.

#we have to run the script as "aaron" because the default cron environment doesn't know anything about guis.

#DISPLAY=:0.0 refers to which screen to run the script.

#"xset q | grep Monitor" displays two possible lines
#   Monitor is On
#   Monitor is Off
# I use "is On" instead since "on" is a substring of "Monitor".

monitor_state="`xset q | grep Monitor`"
if [[ "$monitor_state" == *"is On"* ]]; then
    write_date="`date '+%m-%d-%y @ %H-%M-%S'`"
    read -p "What are you doing right now (... at `date '+%H:%M:%S'`)? " task
    echo "$write_date: \"$task\"" >> ~/task_log.txt
fi
