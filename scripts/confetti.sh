x_size=1600
y_size=900

while true;
do
    indent=$(($RANDOM%$x_size-100)) #indent is the x axis
    offset=$(($RANDOM%$y_size-30))  #offset is the y axis
    echo "." | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$offset -i $indent -d 10 -c `./rand_color.py` &
done
