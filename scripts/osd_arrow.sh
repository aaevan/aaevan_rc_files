eval $(xdotool getmouselocation --shell)
echo "$X, $Y, $SCREEN, $WINDOW"
x_resolution=1600
#x_resolution=2650
x_real=$(($x_resolution - $X - 10))
y_real=$(($Y - 37))
DURATION=10
DIRECTION='left'
string_output="-->"
outline_width=3
fontsize=60

while getopts ":d:rlw" opt; do
  case $opt in
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      DURATION=$OPTARG
      ;;
    r)
      echo "-r was triggered, Parameter: $OPTARG" >&2
      DIRECTION='right'
      ;;
    l)
      echo "-l was triggered, Parameter: $OPTARG" >&2
      DIRECTION='left'
      ;;
    w)
      echo "-w was triggered, Parameter: $OPTARG" >&2
      DIRECTION='blank'
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

echo direction:$DIRECTION

if [ $DIRECTION == "left" ]; then
    echo "to the left!"
    x_real=$(($x_resolution - $X - 10))
    y_real=$(($Y - 37))
    color='green'
    outline_color='black'
    string_output="-->"
elif [ $DIRECTION == "right" ]; then
    echo "to the right!"
    x_real=$(($x_resolution - $X - 84))
    y_real=$(($Y - 37))
    color='green'
    outline_color='black'
    string_output="<--"
elif [ $DIRECTION == "blank" ]; then
    echo "white out!"
    x_real=$(($x_resolution - $X - 84))
    y_real=$(($Y - 37))
    color='white'
    outline_color='white'
    outline_width=5
    string_output="||||||||"
fi


echo $string_output | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-$fontsize-*-*-*-*-*-*-* --offset=$y_real -i $x_real -d $DURATION -O 3 --color=$color --outlinecolour=$outline_color --outline=$outline_width &
#echo $string_output | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-$fontsize-*-*-*-*-*-*-* --offset=$Y -i $X -d $DURATION -O 3 --color=red --outlinecolour=$outline_color --outline=$outline_width & #for debugging multiple screens?
echo x:$X y:$Y
