#!/bin/bash

#count=$(grep -c `date --rfc-3339='date'` ~/pomodoro_log.txt)
count=$(grep -c "`date "+%c"`" ~/pomodoro_log.txt)
echo "$count pomodoros from today:"

#cat ~/pomodoro_log.txt | grep "`date "+%c"`"
tail -n $count ~/pomodoro_log.txt
sleep 3
