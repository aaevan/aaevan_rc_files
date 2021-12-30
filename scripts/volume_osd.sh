left=`amixer -D pulse get Master | grep Left`
right=`amixer -D pulse get Master | grep Right`
left_percent=`echo $left | cut -d "[" -f2 | cut -d "%" -f1`
right_percent=`echo $right | cut -d "[" -f2 | cut -d "%" -f1`

osd_cat -o 5 -i 50 -d 1 --barmode=percentage -P $left_percent -c green &
osd_cat -o 20 -i 50 -d 1 --barmode=percentage -P $right_percent -c green &

echo $left_percent | osd_cat -o 40 -i 50 -d 1 -c green &

