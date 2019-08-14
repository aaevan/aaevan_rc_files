COLOR=`~/scripts/rand_color.py`
shuf -n 1 /home/aaron/scripts/survival_series.txt | fold -s -w 25 | sed 's/.$//' | osd_cat --pos=middle --align=center --outline=4 --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --color=$COLOR

