#!/bin/bash
echo "What are you trying to work on right now?: "
read task

for i in `seq 1 750`;
do
        echo TASK:$task | osd_cat --pos=bottom --align=center --font=-*-helvetica-bold-r-*-*-30-*-*-*-*-*-*-* --color=#00FF00 --offset=-120 --delay=1 --outline=2
    sleep 1;
done


