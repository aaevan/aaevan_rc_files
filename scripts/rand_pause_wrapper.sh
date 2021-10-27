#!/bin/bash

#add the following (uncommented) to roots crontab (sudo crontab -e):
#* * * * * su aaron -c "DISPLAY=:0.0 /home/aaron/scripts/rand_pause_wrapper.sh             
xfce4-terminal --hide-menubar -e /home/aaron/scripts/rand_10s_pause.sh
