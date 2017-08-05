#!/bin/bash

echo $1 | osd_cat --pos=bottom --align=center --font=-*-helvetica-bold-r-*-*-50-*-*-*-*-*-*-* --offset=-200 --color=$2 --delay=$3 &

