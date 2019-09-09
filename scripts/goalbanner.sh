#!/bin/bash
echo "What are you trying to work on right now?: "
read task

#for i in `seq 1 750`;
for i in `seq 1 1500`;
do
        echo TASK: $task | osd_cat --pos=bottom --align=center --font=-*-helvetica-bold-r-*-*-20-*-*-*-*-*-*-* --color=#00FF00 --offset=-80 --delay=2 --outline=2
        echo TASK: $task | osd_cat --pos=bottom --align=center --font=-*-helvetica-bold-r-*-*-20-*-*-*-*-*-*-* --color=#008800 --offset=-80 --delay=2 --outline=2
    #sleep 1;
done


