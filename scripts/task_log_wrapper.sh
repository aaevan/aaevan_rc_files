#!/bin/bash

#add the following (uncommented) to roots crontab (sudo crontab -e):
#23 0,30 * * * * su aaron -c "DISPLAY=:0.0 /home/aaron/scripts/task_log_wrapper.sh

xfce4-terminal --hide-menubar -e /home/aaron/scripts/what_are_you_doing.sh
