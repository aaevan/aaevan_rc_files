#!/bin/bash

count=$(grep -c `date --rfc-3339='date'` ~/pomodoro_log.txt)
echo "$count pomodoros from today:"

cat ~/pomodoro_log.txt | grep `date --rfc-3339='date'`
sleep 3
