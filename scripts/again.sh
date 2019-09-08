#!/bin/bash
    echo "AGAIN?"| osd_cat --pos=middle --align=center --font=-*-helvetica-bold-r-*-*-300-*-*-*-*-*-*-* --offset=-600 --color=red -d 100 &
read -p " " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    killall osd_cat
    echo "YES"| osd_cat --pos=middle --align=center --font=-*-helvetica-bold-r-*-*-300-*-*-*-*-*-*-* --offset=-600 --color=green -d 1 &
    sleep 1
    killall osd_cat
    exec $1 &
else
    killall osd_cat
    echo "NO"| osd_cat --pos=middle --align=center --font=-*-helvetica-bold-r-*-*-300-*-*-*-*-*-*-* --offset=-600 --color=red -d 1 &
    sleep 1
    killall osd_cat
fi

