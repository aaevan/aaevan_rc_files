#read -r width height x y <<<$(import -identify /home/aaron/screens/screenshot$(date '+%m-%d-%y_%H%M-%S').png | awk '{print $4}' | tr "x" " " | tr "+" " ")

#the identify flag gives lots of info about screenshot geometry
#awk here is pulling out arguments and separating them with a space
#tr "x" " " replaces instances of x with a space

color="#ff44cc"

while getopts ":d:c:" opt; do
  case $opt in
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      DIRECTION=$OPTARG
      ;;
    c)
      echo "-c was triggered, Parameter: $OPTARG" >&2
      color=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

read -r width height screenx screeny x1 y1 <<<$(import -identify /tmp/outline.png | awk '{print $3 " " $4}' | tr "x" " " | tr "+" " ")

#offsets for this size of period so that the larger offset lines up with the center.

x_offset=19
y_offset=45

x2=$(($screenx-$x1))
y2=$(($screeny-$y1))

x3=$(($x2-$x_offset))
y3=$(($y1-$y_offset))

x4=$(($x3-$width))
y4=$(($y3+$height))

echo screenx:$screenx screeny:$screeny width:$width height:$height 
echo x1:$x1 y1:$y1 x2:$x2 y2:$y2 x3:$x3 y3:$y3

#does weird bullshit with multiple screens.
#I've gotta figure out how to get absolute coordinates with multiple screens 
# ... and translate that to what osd_cat uses.

#debug
#echo 1. | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y3 -i $x3 -d 60 --color="#ff0000" &
#echo 2. | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y4 -i $x4 -d 60 --color="#00ff00" &
#echo 3. | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y3 -i $x4 -d 60 --color="#0000ff" &
#echo 4. | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y4 -i $x3 -d 60 --color="#ffffff" &

#horizontal (dotted) lines of box:
#for x in `seq $x4 20 $x3`
#do
    #echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y3 -i $x -d 60 --color="#00ff00" &
    #echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y4 -i $x -d 60 --color="#00ff00" &
#done
#
##vertical (dotted) lines of box:
#for y in `seq $y3 20 $y4`
#do
    #echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y -i $x3 -d 60 --color="#00ff00" &
    #echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y -i $x4 -d 60 --color="#00ff00" &
#done


if [ $DIRECTION == "right" ]; then 
    echo x3:$x3 y3:$y3 x4:$x4 y4:$y4
    #python points_between_points.py $x3 $x4 $y3 $y4 | while read line
    python points_between_points.py $x4 $x3 $y3 $y4 | while read line
    do
        #echo input line:$line
        read -r x_val y_val <<< $(echo $line)
        #echo x_val:$x_val y_val:$y_val
        echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y_val -i $x_val -d 60 --color=$color &
    done
fi

if [ $DIRECTION == "left" ]; then 
    echo x3:$x3 y3:$y3 x4:$x4 y4:$y4
    python points_between_points.py $x3 $x4 $y3 $y4 | while read line
    #python points_between_points.py $x4 $x3 $y3 $y4 | while read line
    do
        #echo input_line:$line
        read -r x_val y_val <<< $(echo $line)
        #echo x_val:$x_val y_val:$y_val
        echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y_val -i $x_val -d 60 --color=$color &
    done
fi
