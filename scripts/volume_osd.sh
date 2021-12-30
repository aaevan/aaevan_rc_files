left=`amixer -D pulse get Master | grep Left`
right=`amixer -D pulse get Master | grep Right`
left_percent=`echo $left | cut -d "[" -f2 | cut -d "%" -f1`
right_percent=`echo $right | cut -d "[" -f2 | cut -d "%" -f1`

killall osd_cat
osd_cat -o 3 -i 280 -d 1 --barmode=percentage -P $left_percent -c green &
#osd_cat -o 20 -i 50 -d 1 --barmode=percentage -P $right_percent -c green &

echo $left_percent% | osd_cat -o 1 -i 1570 -d 1 -c green &
#echo R:$right_percent | osd_cat -o 18 -i 1340 -d 1 -c green &

